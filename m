Return-Path: <stable+bounces-43494-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F30438C0B9E
	for <lists+stable@lfdr.de>; Thu,  9 May 2024 08:41:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8809E2845A2
	for <lists+stable@lfdr.de>; Thu,  9 May 2024 06:41:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B16EB824BB;
	Thu,  9 May 2024 06:41:23 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFF17624;
	Thu,  9 May 2024 06:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715236883; cv=none; b=La7A0/Bv3hlbpQIWR5/cJgRAjA2gls3cTflowjMLLiGWyTUwssYGCxUKE5eT4AFX94m+m7MA7hz8MhII9Gl0+5ICmzaWDU1ya/zVHRkiWZaQ80Rpu55BP1kcAfbEX3ks8bA9mcSzetejfTie4gHra2+dtgfEFx8Aqfv2gdHpQ4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715236883; c=relaxed/simple;
	bh=oRK+r+QFI/xe8d51/zCXf0KG6fsVEb0onJS00AWFRMo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fgix6I2wyaEdVHYpsCaoWn2dNqfrIY+t6FwrLYymLui+F5SmBc3oN81KtQm7xFZKiTGcATJ1SyBGMNbX+hD/QkyZ6/k4kqiurLAlvJplYVnzGZxrAdpnILqutibOYHHkECmujTNN7ic3lgSqF3kdTS1wFZdxd/uGtyCouMc0KU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-41adf155cffso4231015e9.2;
        Wed, 08 May 2024 23:41:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715236880; x=1715841680;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OtZke5GvRA5Q1ygOLdEqDZhz3gKzUkn+WkX6FZdmhDA=;
        b=KkH2SE1VP/3U5raiAwmLeDaE+6FqcfFE+v7FoHedoCCHiILLdk7XsjfOcxTCJK4jb1
         hkYOJ5KY8tbMA21iXehBiTm+s01JAqJO423WCgtpNWihZ2fm9EBEumFzU0BjQCbPLrSA
         1NY0foNlgGRMY3gmxPFybZXh0Lq23sN2/6XDx5AmM08ED+WOzF4X39rTMpv+3/QM6iTf
         JxRIrsR7PGPSiVXq0Qr433czIjak1JIgvpxMU6Ktsk9H9lTx3/pYg57T9nDQC8u1Blgr
         G0xKkk5sZtblaICUM/aY+n5aj1GzjqJDzwpDWKLDAmzZClwkaueCejNSkNOksTs+3nTU
         rYkg==
X-Forwarded-Encrypted: i=1; AJvYcCWVIott+ugw3MhU8GnPT/mAYDSnzuKyLj9lv5NfohFy78T9t2N9i28xnpEgLnR9xwzmpkjzZ0DkYSSTI6mUy7T3S6M59on4/+anO6esYjpbCAvZfJwScL7fpaB7wHh7ZkgnkQ/+WLyudMUyoB4pBCGpCZ6sD7fy+gzjF6Z44g/QJFmL
X-Gm-Message-State: AOJu0Yzpp/OGiUJFKpmzV9xTxvBweTZTQIO4ZJJtqfyNvonZGL5K36Mv
	rEbO+u7Dkj8uR4jw6YJLkpNTZX0SgoI0n/duULPzYFOWMHyBqOUInhvnzA==
X-Google-Smtp-Source: AGHT+IHM0oiKR2ualZSIpF7ByJMGe0bpbn4VxgTpK1NX2n4lzsiPH/7eTUFazXmgoVk9hUf8oVtwaw==
X-Received: by 2002:a05:600c:4706:b0:41e:7a1a:d626 with SMTP id 5b1f17b1804b1-41f721b046emr40784725e9.31.1715236880236;
        Wed, 08 May 2024 23:41:20 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:69? ([2a0b:e7c0:0:107::aaaa:69])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-41f87d2045asm47797715e9.27.2024.05.08.23.41.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 May 2024 23:41:19 -0700 (PDT)
Message-ID: <e167d14c-76d3-46b4-aca5-b6003f9cbfc1@kernel.org>
Date: Thu, 9 May 2024 08:41:18 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tty: Fix possible deadlock in tty_buffer_flush
To: kovalev@altlinux.org, gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Cc: lvc-project@linuxtesting.org, dutyrok@altlinux.org,
 oficerovas@altlinux.org, stable@vger.kernel.org
References: <20240508093005.1044815-1-kovalev@altlinux.org>
Content-Language: en-US
From: Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <20240508093005.1044815-1-kovalev@altlinux.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 08. 05. 24, 11:30, kovalev@altlinux.org wrote:
> From: Vasiliy Kovalev <kovalev@altlinux.org>
> 
> A possible scenario in which a deadlock may occur is as follows:
> 
> flush_to_ldisc() {
> 
>    mutex_lock(&buf->lock);
> 
>    tty_port_default_receive_buf() {
>      tty_ldisc_receive_buf() {
>        n_tty_receive_buf2() {
> 	n_tty_receive_buf_common() {
> 	  n_tty_receive_char_special() {
> 	    isig() {
> 	      tty_driver_flush_buffer() {
> 		pty_flush_buffer() {
> 		  tty_buffer_flush() {
> 
> 		    mutex_lock(&buf->lock); (DEADLOCK)
> 
> flush_to_ldisc() and tty_buffer_flush() functions they use the same mutex
> (&buf->lock), but not necessarily the same struct tty_bufhead object.

"not necessarily" -- so does it mean that it actually can happen (and we 
should fix it) or not at all (and we should annotate the mutex)?

> However, you should probably use a separate mutex for the
> tty_buffer_flush() function to exclude such a situation.
...

> Cc: stable@vger.kernel.org

What commit does this fix?

> --- a/drivers/tty/tty_buffer.c
> +++ b/drivers/tty/tty_buffer.c
> @@ -226,7 +226,7 @@ void tty_buffer_flush(struct tty_struct *tty, struct tty_ldisc *ld)
>   
>   	atomic_inc(&buf->priority);
>   
> -	mutex_lock(&buf->lock);
> +	mutex_lock(&buf->flush_mtx);

Hmm, how does this protect against concurrent buf pickup. We free it 
here and the racing thread can start using it, or?

>   	/* paired w/ release in __tty_buffer_request_room; ensures there are
>   	 * no pending memory accesses to the freed buffer
>   	 */

thanks,
-- 
js
suse labs


