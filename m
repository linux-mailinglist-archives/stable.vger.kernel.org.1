Return-Path: <stable+bounces-181592-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F1F7B990C5
	for <lists+stable@lfdr.de>; Wed, 24 Sep 2025 11:11:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A28E34C0727
	for <lists+stable@lfdr.de>; Wed, 24 Sep 2025 09:11:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8827F287258;
	Wed, 24 Sep 2025 09:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=g001.emailsrvr.com header.i=@g001.emailsrvr.com header.b="V/5OGHsA";
	dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b="Bp34dbgM"
X-Original-To: stable@vger.kernel.org
Received: from smtp72.iad3b.emailsrvr.com (smtp72.iad3b.emailsrvr.com [146.20.161.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4A9B28136C
	for <stable@vger.kernel.org>; Wed, 24 Sep 2025 09:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=146.20.161.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758705109; cv=none; b=HuZkHptLkso002VlozvAML7NwJU34wpkijj8+Cgz22wjFqLcGvsIbXUYR9Xu5PiuLSUqYEoRbMfh66zlXHZEMeep8wCOe+wNmmy/xx8V2p8vFOi5OzxS3HeMrfzF33NBZUc6LZGuw+LX0Rs+TXE5MOD3DPZPjmMPY0KjxUkAqKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758705109; c=relaxed/simple;
	bh=tsezQOcDbSsKHWE+Y8NNE2KYFSXpuNPy/H6+E//0ZJI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KbgLDUDCdsGbzQ+szrfYhltW0lh4IH1ELP7rSliTFAW3qqrjduVEDoS7fDR2l2993PcN6rCUMb2LZNlsGJhnRTMN5A1GgM2HpXDxmnmVt5jXM1gjrqr2hu4lLt9Cqyps/hCJ1sowUruOWvyFfi7i7VhLGHYltiIfKTVPiDkGD+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mev.co.uk; spf=pass smtp.mailfrom=mev.co.uk; dkim=pass (1024-bit key) header.d=g001.emailsrvr.com header.i=@g001.emailsrvr.com header.b=V/5OGHsA; dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b=Bp34dbgM; arc=none smtp.client-ip=146.20.161.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mev.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mev.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=g001.emailsrvr.com;
	s=feedback; t=1758704636;
	bh=tsezQOcDbSsKHWE+Y8NNE2KYFSXpuNPy/H6+E//0ZJI=;
	h=Date:Subject:To:From:From;
	b=V/5OGHsAGfxe2+NG8OrT2SOCAi/wpqhtyMkZhpvLf6AmOgUVKXTucE1kd3I2KqSEy
	 7VFor+tNIciVlggzYHctd2B/riAWa6lzZApZCi7YcVeO/zOAfhH70F+EAfUVxYGgtj
	 iYWh2+26gG3Jnxhglt0j+8sf3wH6vVufv4Q9KlnY=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
	s=20221208-6x11dpa4; t=1758704636;
	bh=tsezQOcDbSsKHWE+Y8NNE2KYFSXpuNPy/H6+E//0ZJI=;
	h=Date:Subject:To:From:From;
	b=Bp34dbgMe7WoapyLFJfe8rzI/HsFKNryoa+pMqUX8QV1NLA8sAG1BXW8DK9fIhsEP
	 E6QJQh+1QbcnTVTTdxViiIcR5VjMLOnxn1V0VREaO9hMsKr3cKanbbf8oh+P40xB7R
	 3JRkicQRiG7jkSY0BeqW5uykPn/NlB2wrWcTjNro=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp2.relay.iad3b.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id 6051C201D1;
	Wed, 24 Sep 2025 05:03:55 -0400 (EDT)
Message-ID: <3f7b60e8-9df8-414a-afd2-2caca7d43209@mev.co.uk>
Date: Wed, 24 Sep 2025 10:03:54 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] comedi: fix divide-by-zero in comedi_buf_munge()
To: Deepanshu Kartikey <kartikey406@gmail.com>,
 H Hartley Sweeten <hsweeten@visionengravers.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 syzbot+f6c3c066162d2c43a66c@syzkaller.appspotmail.com
References: <20250924015606.1098345-1-kartikey406@gmail.com>
Content-Language: en-GB
From: Ian Abbott <abbotti@mev.co.uk>
Organization: MEV Ltd.
In-Reply-To: <20250924015606.1098345-1-kartikey406@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Classification-ID: 96808095-5086-44c3-9ba0-64ac69f8dc05-1-1

On 24/09/2025 02:56, Deepanshu Kartikey wrote:
> The comedi_buf_munge() function performs a modulo operation
> `async->munge_chan %= async->cmd.chanlist_len` without first
> checking if chanlist_len is zero. If a user program submits
> a command with chanlist_len set to zero, this causes a
> divide-by-zero error when the device processes data in the
> interrupt handler path.

I don't think it should happen for supported hardware devices that are 
working properly, but it helps to defend against the unexpected.

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
>   drivers/comedi/comedi_buf.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/comedi/comedi_buf.c b/drivers/comedi/comedi_buf.c
> index 002c0e76baff..786f888299ce 100644
> --- a/drivers/comedi/comedi_buf.c
> +++ b/drivers/comedi/comedi_buf.c
> @@ -321,6 +321,11 @@ static unsigned int comedi_buf_munge(struct comedi_subdevice *s,
>   		async->munge_count += num_bytes;
>   		return num_bytes;
>   	}
> +
> +	if (async->cmd.chanlist_len == 0) {
> +		async->munge_count += num_bytes;
> +		return num_bytes;
> +	}

This `if` statement could be merged with the preceding `if` statement 
that has the same body, which would save a few lines.

>   
>   	/* don't munge partial samples */
>   	num_bytes -= num_bytes % num_sample_bytes;


-- 
-=( Ian Abbott <abbotti@mev.co.uk> || MEV Ltd. is a company  )=-
-=( registered in England & Wales.  Regd. number: 02862268.  )=-
-=( Regd. addr.: S11 & 12 Building 67, Europa Business Park, )=-
-=( Bird Hall Lane, STOCKPORT, SK3 0XA, UK. || www.mev.co.uk )=-

