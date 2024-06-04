Return-Path: <stable+bounces-47947-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CC5398FB978
	for <lists+stable@lfdr.de>; Tue,  4 Jun 2024 18:47:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09D501C21560
	for <lists+stable@lfdr.de>; Tue,  4 Jun 2024 16:47:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B15C2127B7A;
	Tue,  4 Jun 2024 16:47:53 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail.itouring.de (mail.itouring.de [85.10.202.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 708331487CC
	for <stable@vger.kernel.org>; Tue,  4 Jun 2024 16:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.10.202.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717519673; cv=none; b=p7tL/MdFfY8zjByU08ijgx9vHmaza8teyw6VeBcyr2so4W2JNVweOLtg0wpO1Lf4JYB9D8+XHnnbdrgYkBtX94a2D5wntbe4vBM9HO9G9TTMlXoRcOelTkfHwGuvtG4h2TjCjOx1aN4AMs7D6WPS/7sHFhMYomMYmlLPaJj0v2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717519673; c=relaxed/simple;
	bh=pOFpXSVVJGBxMLZfhmV7GnsGacj02dAmRHLRN5xJYTE=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=fcizg7SC+6t+cCgTOvtLxzIyYJvM+Te+nPySiS7inwE0A1XeHFSQQ37Roh8xHXv0Lk2+2g/WGXxfzuINC+u46zdeqH8xPuopm04TxEwtRcRTsdYlC1RlnkWduKJNGMTCyk/Uovxse3yMqq4bH1exhBhUXH4S73sdNDfs99KEqmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=applied-asynchrony.com; spf=pass smtp.mailfrom=applied-asynchrony.com; arc=none smtp.client-ip=85.10.202.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=applied-asynchrony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=applied-asynchrony.com
Received: from tux.applied-asynchrony.com (p5ddd7553.dip0.t-ipconnect.de [93.221.117.83])
	by mail.itouring.de (Postfix) with ESMTPSA id 3765810376E;
	Tue,  4 Jun 2024 18:47:49 +0200 (CEST)
Received: from [192.168.100.223] (ragnarok.applied-asynchrony.com [192.168.100.223])
	by tux.applied-asynchrony.com (Postfix) with ESMTP id 065DAF0160B;
	Tue, 04 Jun 2024 18:47:49 +0200 (CEST)
Subject: Re: Please queue up f4dca95fc0f6 for 6.9 et.al.
To: Eric Dumazet <edumazet@google.com>
Cc: Greg KH <gregkh@linuxfoundation.org>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>,
 Jakub Kicinski <kuba@kernel.org>
References: <575be1d3-d364-7719-5cfb-f89bdec66573@applied-asynchrony.com>
 <2024060452-headrest-deny-2a5b@gregkh>
 <ba29a0e9-8f4c-e209-fb2d-1ef80f97da6d@applied-asynchrony.com>
 <CANn89iKN3i6m4h=UUmQbRNSocNY61bb7OaS-tdTnnmWuaPot1w@mail.gmail.com>
From: =?UTF-8?Q?Holger_Hoffst=c3=a4tte?= <holger@applied-asynchrony.com>
Organization: Applied Asynchrony, Inc.
Message-ID: <0d919e78-f017-869f-3107-1ee51c30d6b2@applied-asynchrony.com>
Date: Tue, 4 Jun 2024 18:47:48 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CANn89iKN3i6m4h=UUmQbRNSocNY61bb7OaS-tdTnnmWuaPot1w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit

On 2024-06-04 18:32, Eric Dumazet wrote:
> On Tue, Jun 4, 2024 at 6:26 PM Holger Hoffstätte
> <holger@applied-asynchrony.com> wrote:
>>
>> On 2024-06-04 17:44, Greg KH wrote:
>>> On Tue, Jun 04, 2024 at 04:56:24PM +0200, Holger Hoffstätte wrote:
>>>>
>>>> Just ${Subject} since it's a fix for a potential security footgun/DOS, whereever
>>>> commit 378979e94e95 ("tcp: remove 64 KByte limit for initial tp->rcv_wnd value")
>>>> has been queued up.
>>>
>>> Only applies to 6.9.y, have backports for older kernels?
>>
>> No, sorry - I'm just the messenger here and moved everything to 6.9 already.
>> Cc'ing Jakub and Eric.
>>
>> My understanding is that the previous commit was a performance enhancement,
>> so if this turns out to be too difficult then maybe 378979e94e95 ("tcp: remove
>> 64 KByte limit for initial tp->rcv_wnd value") should just not be merged either.
>> I have both patches on 6.9 but really cannot say whether they should go to
>> older releases.
>>
> 
> Sorry I am missing the prior emails, 378979e94e95 does not seem
> security related to me,
> only one small TCP change.
> 
> What is the problem ?

I noticed that 378979e94e95 was queued up for the next -stable releases
(autobot?) and notified Greg that the followup fix f4dca95fc0f6 would be a
good idea as well (since *that* one seemed quite security related to me?).
But it does not apply cleanly on older releases and I don't really feel
qualified to do backports.
So the question was whether only the first patch is OK by itself or neither
should go into older releases at all.

Hope that explains it?

Thanks!
Holger

