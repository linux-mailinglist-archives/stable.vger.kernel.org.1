Return-Path: <stable+bounces-43496-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 80A648C0E35
	for <lists+stable@lfdr.de>; Thu,  9 May 2024 12:32:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1F0B1C21396
	for <lists+stable@lfdr.de>; Thu,  9 May 2024 10:32:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AEDD41C79;
	Thu,  9 May 2024 10:32:51 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from air.basealt.ru (air.basealt.ru [194.107.17.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46FF31361;
	Thu,  9 May 2024 10:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.107.17.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715250771; cv=none; b=lCDRimTWjRsD+VVrLmgp48QuLb5GytHXDTAeM6lmC/McFMR7PtUm9Jeg3WIft7D3XHo3AeyLO6frcEqj3AtyTT3E7/1PRWBkxYJk6+Bzk0/qML3jeGTMJvq2KwnciXi2KRkW7mcZU/CTGdweDbcvd2fe5ujguQ3I3ZB8U3RhvZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715250771; c=relaxed/simple;
	bh=2lxyu2hLVfeAwz1VtGgAmtW/z0G0oGotVbQhWW5bTso=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Jagkx0wvz0M53ziV4uk1OvRGRuRMwnQIE0ZYd/FP7Kp6XCvVwRg13OkE6EbqWqVpRq81zw2y+/J8COLPNlEaFinyY6uUfu3VJ0Epoi8871pgRSZHmUqLIsalPU+K+H28RhFjpcsMa/KxBEiG5NIIBaadTKwTgMbUYtNg3hecKLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org; spf=pass smtp.mailfrom=altlinux.org; arc=none smtp.client-ip=194.107.17.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altlinux.org
Received: by air.basealt.ru (Postfix, from userid 490)
	id BA0D42F20231; Thu,  9 May 2024 10:32:44 +0000 (UTC)
X-Spam-Level: 
Received: from [192.168.0.102] (unknown [178.76.204.78])
	by air.basealt.ru (Postfix) with ESMTPSA id 073EF2F20226;
	Thu,  9 May 2024 10:32:43 +0000 (UTC)
Message-ID: <face96b8-6e69-0f2d-1cb0-a20acd906338@basealt.ru>
Date: Thu, 9 May 2024 13:32:43 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] tty: Fix possible deadlock in tty_buffer_flush
Content-Language: en-US
To: Jiri Slaby <jirislaby@kernel.org>, kovalev@altlinux.org,
 gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org
Cc: lvc-project@linuxtesting.org, dutyrok@altlinux.org,
 oficerovas@altlinux.org, stable@vger.kernel.org
References: <20240508093005.1044815-1-kovalev@altlinux.org>
 <e167d14c-76d3-46b4-aca5-b6003f9cbfc1@kernel.org>
From: Vasiliy Kovalev <kovalev@altlinux.org>
In-Reply-To: <e167d14c-76d3-46b4-aca5-b6003f9cbfc1@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

09.05.2024 09:41, Jiri Slaby wrote:
> On 08. 05. 24, 11:30, kovalev@altlinux.org wrote:
>> From: Vasiliy Kovalev <kovalev@altlinux.org>
>>
>> A possible scenario in which a deadlock may occur is as follows:
>>
>> flush_to_ldisc() {
>>
>>    mutex_lock(&buf->lock);
>>
>>    tty_port_default_receive_buf() {
>>      tty_ldisc_receive_buf() {
>>        n_tty_receive_buf2() {
>>     n_tty_receive_buf_common() {
>>       n_tty_receive_char_special() {
>>         isig() {
>>           tty_driver_flush_buffer() {
>>         pty_flush_buffer() {
>>           tty_buffer_flush() {
>>
>>             mutex_lock(&buf->lock); (DEADLOCK)
>>
>> flush_to_ldisc() and tty_buffer_flush() functions they use the same mutex
>> (&buf->lock), but not necessarily the same struct tty_bufhead object.
 >
> "not necessarily" -- so does it mean that it actually can happen (and we 
> should fix it) or not at all (and we should annotate the mutex)?

During debugging, when running the reproducer multiple times, I failed 
to catch a situation where these mutexes have the same address in memory 
in the above call scenario, so I'm not sure that such a situation is 
possible. But earlier, a thread is triggered that accesses the same 
structure (and mutex), so LOCKDEP tools throw a warning:

thread 0:
flush_to_ldisc() {

   mutex_lock(&buf->lock) // Address mutex == 0xA

   n_tty_receive_buf_common();

   mutex_unlock(&buf->lock) // Address mutex == 0xA
}

thread 1:
flush_to_ldisc() {

   mutex_lock(&buf->lock) // Address mutex == 0xB

   n_tty_receive_buf_common() {
     isig() {
       tty_driver_flush_buffer() {
         pty_flush_buffer() {
           tty_buffer_flush() {

              mutex_lock(&buf->lock) // Address  mutex == 0xA    -> 
throw Warning
              // successful continuation
...
}


>> However, you should probably use a separate mutex for the
>> tty_buffer_flush() function to exclude such a situation.
> ...
> 
>> Cc: stable@vger.kernel.org
> 
> What commit does this fix?

I will assume that the commit of introducing mutexes in these functions: 
e9975fdec013 ("tty: Ensure single-threaded flip buffer consumer with mutex")

>> --- a/drivers/tty/tty_buffer.c
>> +++ b/drivers/tty/tty_buffer.c
>> @@ -226,7 +226,7 @@ void tty_buffer_flush(struct tty_struct *tty, 
>> struct tty_ldisc *ld)
>>       atomic_inc(&buf->priority);
>> -    mutex_lock(&buf->lock);
>> +    mutex_lock(&buf->flush_mtx);
> 
> Hmm, how does this protect against concurrent buf pickup. We free it 
> here and the racing thread can start using it, or?

Yes, assuming that such a scenario is possible..

Otherwise, if such a scenario is not possible and the patch is 
inappropriate, then you need to mark this mutex in some way to tell 
lockdep tools to ignore this place..

>>       /* paired w/ release in __tty_buffer_request_room; ensures there 
>> are
>>        * no pending memory accesses to the freed buffer
>>        */
> 
> thanks,

-- 
Regards,
Vasiliy Kovalev

