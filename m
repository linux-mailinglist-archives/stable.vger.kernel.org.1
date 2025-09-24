Return-Path: <stable+bounces-181600-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3293B99B15
	for <lists+stable@lfdr.de>; Wed, 24 Sep 2025 13:56:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 638FB4C2DF1
	for <lists+stable@lfdr.de>; Wed, 24 Sep 2025 11:56:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59A102DC773;
	Wed, 24 Sep 2025 11:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=g001.emailsrvr.com header.i=@g001.emailsrvr.com header.b="SfQg2KBp";
	dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b="UctSm/QS"
X-Original-To: stable@vger.kernel.org
Received: from smtp85.iad3b.emailsrvr.com (smtp85.iad3b.emailsrvr.com [146.20.161.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 750F71E2834
	for <stable@vger.kernel.org>; Wed, 24 Sep 2025 11:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=146.20.161.85
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758714983; cv=none; b=XaAFd96XcmkFNHw+A79f31cNAsd12P1NkBNQ4JQEbKQms10kzu3IMp/a4rLYq/VoaARDxMDYNyjfsjZkdOEOtMxt5NN8zuhuMh3rCqPfFYQ55rA7vO0mo4/LRViaCFShOZkQ07tRCrRxZLFm/kVBdO6a3eN144rhasiNXksBsZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758714983; c=relaxed/simple;
	bh=4sH1ny7lHaWXyvRBY7TW5YOvkqgtkY6ZmoIu2Cpl0jI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l6DFjOlNcaXQPulrrrLe40PnaJAozCvt5lcODmy0pdPRyxkC3qj9NvudBf2Uw2Xul8jxxh8e/JYYUzpUjzahtqt0QZtjdEa4XgMg5h9D8q/I8g5lg7VOrf8R6kPIETG+csKsznLYW4y0sa2o5DAYvLmLQ1Tavkfgu9TM9lJoiNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mev.co.uk; spf=pass smtp.mailfrom=mev.co.uk; dkim=pass (1024-bit key) header.d=g001.emailsrvr.com header.i=@g001.emailsrvr.com header.b=SfQg2KBp; dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b=UctSm/QS; arc=none smtp.client-ip=146.20.161.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mev.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mev.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=g001.emailsrvr.com;
	s=feedback; t=1758712873;
	bh=4sH1ny7lHaWXyvRBY7TW5YOvkqgtkY6ZmoIu2Cpl0jI=;
	h=Date:Subject:To:From:From;
	b=SfQg2KBpe6VJO837nueW11qbFXKiaEDHhqerguDIb15PTmLxWLp13rSV6Z6mNmgPY
	 F97vQdHn8ypdcRKf1IZI8Cc6ODiRVWarPJHkLq5X9KQ4dZ1jJs/hyUVi97THfNDu7N
	 rAcFHttBqavU+6/AMPsEZNV1DafRZ+Abk3T2HmCM=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
	s=20221208-6x11dpa4; t=1758712873;
	bh=4sH1ny7lHaWXyvRBY7TW5YOvkqgtkY6ZmoIu2Cpl0jI=;
	h=Date:Subject:To:From:From;
	b=UctSm/QSA9IZd7c+ZWFPD/bMk1qRCsgPa5tYR+llr9WqmemacWvZ92R68ZwGTgit5
	 qZNnu7+VyeZ+qyV9/Nkstox6nxfYKUUFntBDapu6RFDcCk30ZVxodyIU/xu6F9rCBL
	 9ABhKNohdWOhqOkSk4PoBNBCGTyK4gr3iaYuyPjQ=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp3.relay.iad3b.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id 4BA914033B;
	Wed, 24 Sep 2025 07:21:12 -0400 (EDT)
Message-ID: <67b4ae93-f537-4674-bafe-2173232f70e0@mev.co.uk>
Date: Wed, 24 Sep 2025 12:21:11 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] comedi: fix divide-by-zero in comedi_buf_munge()
To: Deepanshu Kartikey <kartikey406@gmail.com>,
 H Hartley Sweeten <hsweeten@visionengravers.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 syzbot+f6c3c066162d2c43a66c@syzkaller.appspotmail.com
References: <20250924102639.1256191-1-kartikey406@gmail.com>
Content-Language: en-GB
From: Ian Abbott <abbotti@mev.co.uk>
Organization: MEV Ltd.
In-Reply-To: <20250924102639.1256191-1-kartikey406@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Classification-ID: d19ac750-f060-476a-aeb1-108d7f4f7e59-1-1

On 24/09/2025 11:26, Deepanshu Kartikey wrote:
> The comedi_buf_munge() function performs a modulo operation
> `async->munge_chan %= async->cmd.chanlist_len` without first
> checking if chanlist_len is zero. If a user program submits a command with
> chanlist_len set to zero, this causes a divide-by-zero error when the device
> processes data in the interrupt handler path.
> 
> Add a check for zero chanlist_len at the beginning of the
> function, similar to the existing checks for !map and
> CMDF_RAWDATA flag. When chanlist_len is zero, update
> munge_count and return early, indicating the data was
> handled without munging.
> 
> This prevents potential kernel panics from malformed user commands.
> 
> Reported-by: syzbot+f6c3c066162d2c43a66c@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=f6c3c066162d2c43a66c
> Cc: stable@vger.kernel.org
> Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
> ---
> v2: Merged the chanlist_len check with existing early return
>      check as suggested by Ian Abbott
> 
> ---
>   drivers/comedi/comedi_buf.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/comedi/comedi_buf.c b/drivers/comedi/comedi_buf.c
> index 002c0e76baff..c7c262a2d8ca 100644
> --- a/drivers/comedi/comedi_buf.c
> +++ b/drivers/comedi/comedi_buf.c
> @@ -317,7 +317,7 @@ static unsigned int comedi_buf_munge(struct comedi_subdevice *s,
>   	unsigned int count = 0;
>   	const unsigned int num_sample_bytes = comedi_bytes_per_sample(s);
>   
> -	if (!s->munge || (async->cmd.flags & CMDF_RAWDATA)) {
> +	if (!s->munge || (async->cmd.flags & CMDF_RAWDATA) || async->cmd.chanlist_len == 0) {
>   		async->munge_count += num_bytes;
>   		return num_bytes;
>   	}

Looks good, thanks!

Reviewed-by: Ian Abbott <abbotti@mev.co.uk>

-- 
-=( Ian Abbott <abbotti@mev.co.uk> || MEV Ltd. is a company  )=-
-=( registered in England & Wales.  Regd. number: 02862268.  )=-
-=( Regd. addr.: S11 & 12 Building 67, Europa Business Park, )=-
-=( Bird Hall Lane, STOCKPORT, SK3 0XA, UK. || www.mev.co.uk )=-

