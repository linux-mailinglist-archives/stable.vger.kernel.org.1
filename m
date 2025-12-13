Return-Path: <stable+bounces-200953-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B681CBA881
	for <lists+stable@lfdr.de>; Sat, 13 Dec 2025 12:52:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0B64530D7408
	for <lists+stable@lfdr.de>; Sat, 13 Dec 2025 11:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F29F6308F32;
	Sat, 13 Dec 2025 11:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K6fKe2lp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF4E922068F;
	Sat, 13 Dec 2025 11:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765626730; cv=none; b=tPDaSuVfVjG8kRSFjGkqB81Si86KJ99+b4l9Pq0bnnSMS0sjRyL/MacScDz2wjbJdKHCpsVRuuti2PLUdxLAZys6mEy6FQQKzVyfzXCiYuM5csKEX4HDsNtl4/GM+eSn6MZ9CP31fhwwemt4J/F8LjvDBAB608SnmrNUjO++YAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765626730; c=relaxed/simple;
	bh=cRLJRThehTY8h7LofACIaVp0WcRzbpkcc39cOdCg+AQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cv/oR+nSwNSzQ9prNARNwfLi690PZiasruYFYxfn2ydKdQ8A1+8cBp4RvDyeQOwQghBUlaTN+gCotCnMLgO2lnOkTFFao+2i7OMDvNI5U1yRw97OvEyE2qIqsuBgqvTMUBc+mYsfYHRuFHZ7+dVW4T8ZJDHaKK/qT0toQS4F2Kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K6fKe2lp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51D09C4CEF7;
	Sat, 13 Dec 2025 11:52:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765626730;
	bh=cRLJRThehTY8h7LofACIaVp0WcRzbpkcc39cOdCg+AQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=K6fKe2lpjNlzN7bt6/NayhMtZvHr3pZec+jhgvK2rmvtUKznviCtnrBn3cKDrJHrA
	 vmmuvFrccyXG0J92BB7kYo2Oriy8nyyhDwH96N90tf8zczcmsY14ug5+qsp8UUulgp
	 WjRlSQDIUgP22+hdqbXQv6RGC3ReUYhn7IUI/tSDZRc0K6w+65v9wnjXqpvzcPeyrY
	 N/i9Mf2sXFeJOs+AtcGC3N+EhwXPQ4irt8lCuxbLt1sBjzozRPKIzqe29iXDU1sqLP
	 zBY5CdR03DRXJ1ettR/zlRxm6C4GuP9rYyOZlD/deBMZeAxmmJb+t2O/QVTfVasxPt
	 BGdgGdH6io8bg==
Message-ID: <bc08a3fe-5b1c-4f19-b1df-fe1b1d5b23e2@kernel.org>
Date: Sat, 13 Dec 2025 12:52:07 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Patch "media: ov02c10: Fix default vertical flip" has been added
 to the 6.18-stable tree
To: stable@vger.kernel.org, stable-commits@vger.kernel.org, sre@kernel.org
Cc: Bryan O'Donoghue <bod@kernel.org>,
 Sakari Ailus <sakari.ailus@linux.intel.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>
References: <20251213093506.4122377-1-sashal@kernel.org>
From: Hans de Goede <hansg@kernel.org>
Content-Language: en-US, nl
In-Reply-To: <20251213093506.4122377-1-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Sasha,

On 13-Dec-25 10:35, Sasha Levin wrote:
> This is a note to let you know that I've just added the patch titled
> 
>     media: ov02c10: Fix default vertical flip

This fix is incomplete, leading to wrong colors and it causes
the image to be upside down on some Dell XPS models where it
currently is the right way up.

There is a series of fixes which applies on top of this to
fix both issues:

https://lore.kernel.org/linux-media/20251210112436.167212-1-johannes.goede@oss.qualcomm.com/

For now (without the fixes on top) we are better of not adding
this patch to the stable series. Can you drop this patch
please?

Same for 6.17 and other stable series.

Regards,

Hans






> 
> to the 6.18-stable tree which can be found at:
>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> 
> The filename of the patch is:
>      media-ov02c10-fix-default-vertical-flip.patch
> and it can be found in the queue-6.18 subdirectory.
> 
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.
> 
> 
> 
> commit 14cc4474799a595caeccdb8fdf2ca4b867cef972
> Author: Sebastian Reichel <sre@kernel.org>
> Date:   Wed Aug 20 02:13:19 2025 +0200
> 
>     media: ov02c10: Fix default vertical flip
>     
>     [ Upstream commit d5ebe3f7d13d4cee3ff7e718de23564915aaf163 ]
>     
>     The driver right now defaults to setting the vertical flip bit. This
>     conflicts with proper handling of the rotation property defined in
>     ACPI or device tree, so drop the VFLIP bit. It should be handled via
>     V4L2_CID_VFLIP instead.
>     
>     Reported-by: Frederic Stuyk <fstuyk@runbox.com>
>     Closes: https://lore.kernel.org/all/b6df9ae7-ea9f-4e5a-8065-5b130f534f37@runbox.com/
>     Fixes: 44f89010dae0 ("media: i2c: Add Omnivision OV02C10 sensor driver")
>     Signed-off-by: Sebastian Reichel <sre@kernel.org>
>     Reviewed-by: Bryan O'Donoghue <bod@kernel.org>
>     Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
>     Signed-off-by: Hans Verkuil <hverkuil+cisco@kernel.org>
>     Signed-off-by: Sasha Levin <sashal@kernel.org>
> 

> diff --git a/drivers/media/i2c/ov02c10.c b/drivers/media/i2c/ov02c10.c
> index 8c4d85dc7922e..8e22ff446b0c4 100644
> --- a/drivers/media/i2c/ov02c10.c
> +++ b/drivers/media/i2c/ov02c10.c
> @@ -174,7 +174,7 @@ static const struct reg_sequence sensor_1928x1092_30fps_setting[] = {
>  	{0x3816, 0x01},
>  	{0x3817, 0x01},
>  
> -	{0x3820, 0xb0},
> +	{0x3820, 0xa0},
>  	{0x3821, 0x00},
>  	{0x3822, 0x80},
>  	{0x3823, 0x08},


