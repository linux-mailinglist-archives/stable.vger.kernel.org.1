Return-Path: <stable+bounces-71638-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ADE6E9661E2
	for <lists+stable@lfdr.de>; Fri, 30 Aug 2024 14:40:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 301AD1F2549F
	for <lists+stable@lfdr.de>; Fri, 30 Aug 2024 12:40:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F29F2199942;
	Fri, 30 Aug 2024 12:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="oFO9YoYH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Av1vBmoJ"
X-Original-To: stable@vger.kernel.org
Received: from fhigh6-smtp.messagingengine.com (fhigh6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 586A71898E5
	for <stable@vger.kernel.org>; Fri, 30 Aug 2024 12:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725021649; cv=none; b=b+vuy9m2eOYJQMWIZ6U9BRvXDfyPtqTEQ10C6gm5V7lS/G8vIhZLytIOKdPkWqbsOFUmbvx6wfiWcn6aC2J5Q7Kglozj0aTGDdTXkGinHTIXGmwJCybsfSlxYUUNigyJpos9ndNiL+vX3DMmTurXFR6Rslv1mTcoZCN6XdLcIMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725021649; c=relaxed/simple;
	bh=hw5lI+cpX6VBlumA9ey/Fjaj3dyGnRR63/wzgc8TIX0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fi6zchLsE/K4vkRjYfRL0Fwxw1EHEzq7stz8Cf48ZlJ0gST+paDh+ZHA0Q1lLnVXLKtq6dj57FygLeQvAH2ywxTATHC1lOYVtUXsHCvDV5XlvVeSSNA6zCHFq+czJ0Yf8GtUxWFuJeElzjqf2ptBL6eg0Fov1hy8x2PyFwxA5uM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=oFO9YoYH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Av1vBmoJ; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from phl-compute-06.internal (phl-compute-06.nyi.internal [10.202.2.46])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 6685B1140253;
	Fri, 30 Aug 2024 08:40:46 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Fri, 30 Aug 2024 08:40:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1725021646; x=1725108046; bh=hrcA1s5Pjl
	iexHc+0CqtyeVokrInplOUEY2mQSRYzCo=; b=oFO9YoYH/kHhTarBMw+AN1AU9b
	JDYUg8h89/2zBVYzuuqqpSxR5ksTh+1TPXA88FNPgW/SJbdCrjxhGPLN/WtuM6ym
	4BF58FXxYqJTCrtN/dFw7IrSQnStqqJ4hEDuvLul1KveiO4LFbMQs7XcMN4/gfTu
	EhgMY4uBDA13TjwesHDhcY878Ouyrik/JQ9EpT5nBS+Som8wPjchXqjX+BiR1FZh
	3ckpWi7bQoVnmt3dJbkdhLAlRoiFJ4bRnGBspfZ7lke0ivDMzkCNT48Tq9e+v2nS
	ty91+7jkdb+u8jO/6ytN7ngielXeHfkzXuoAKO5U7DgpsxmIILPplNvptFvA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1725021646; x=1725108046; bh=hrcA1s5PjliexHc+0CqtyeVokrIn
	plOUEY2mQSRYzCo=; b=Av1vBmoJy9crGkD8Y5TVNYfZBGK2gkkoyVB0McpiHfgp
	d1N/N94bQTHYHYHOZ5Pc8nyaHxi0Kn4tNbgNvg6JI62z1SiilhmsRSPXg012SXaT
	wa8W4M7MkOeJO701py5FtAWFg0YrlCzdOY1QSqxqoup34V5ABhdxaplMeJQaNAhG
	C0DO5kkIb3ylt4mVw2RPLdX7VfU8Jx4QgxD50bKcSYMCnRaaT1QYpIq/qvnkYO3u
	ze3cNjezsaPadQaE2UwzKhMd6tIzwztVkqE1v1TqnsaKy9AMaxLmoRJ6Kh1mNXG9
	Dsd2h7dwYfmTWAG7k2WQLytq+CjpdwsYKyb2NGNq3w==
X-ME-Sender: <xms:zr3RZlybOFkBZycRNdjpjo5-BicVSzu0dnJIPqrftgI3jm1tco9PgA>
    <xme:zr3RZlTqdCHHb5zJMhn-TiCNbUAPDB-RPYFw-FckjNgY77GkvUFnEKMxWfwEZiOVx
    BC46KAqSeBxHQ>
X-ME-Received: <xmr:zr3RZvWVHx6D62I0nh_v4xzS9u3eSXomwj7ozUplQdidWJ-HFJSCFTW6C0YqQHdrMAXo7SoWnvbUdeZvswBzQJJgy-mS3KobnIhdwA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudefiedgheehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomhepifhrvghgucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrf
    grthhtvghrnhepgeehueehgfdtledutdelkeefgeejteegieekheefudeiffdvudeffeel
    vedttddvnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhrohgrhhdrtghomhdp
    nhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprhhisg
    grlhgurgestghhrhhomhhiuhhmrdhorhhgpdhrtghpthhtohepshhtrggslhgvsehvghgv
    rhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhgruhhrvghnthdrphhinhgthhgrrh
    htsehiuggvrghsohhnsghorghrugdrtghomh
X-ME-Proxy: <xmx:zr3RZnhj7CzOz4LXxiuYdO7xl_6gFEKzXSmYKfkrPn_qnM3eRmdvvQ>
    <xmx:zr3RZnDu54CuKP7CgUPln7FDYACrmS_dwEuEcIuIDf8PIPjiA12P7w>
    <xmx:zr3RZgLCH7PhQ9TW3w8MZnpQ3GByiRLnQxGHTdaoJyl7iuwalzOv9g>
    <xmx:zr3RZmD4SNW6WuCC4cMQvePcf76IduWYDzT095gf90DAKhyK3SuZVQ>
    <xmx:zr3RZp2Ps6n1okgcuCo70A0VAA4XLvFfZEyeznJdh5zR33tClo9ICiec>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 30 Aug 2024 08:40:45 -0400 (EDT)
Date: Fri, 30 Aug 2024 14:40:41 +0200
From: Greg KH <greg@kroah.com>
To: Ricardo Ribalda <ribalda@chromium.org>
Cc: stable@vger.kernel.org,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH 5.10.y] media: uvcvideo: Fix integer overflow calculating
 timestamp
Message-ID: <2024083032-patchwork-mushy-607f@gregkh>
References: <2024072959-overpass-sapling-797e@gregkh>
 <20240819120652.18798-1-ribalda@chromium.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240819120652.18798-1-ribalda@chromium.org>

On Mon, Aug 19, 2024 at 12:06:52PM +0000, Ricardo Ribalda wrote:
> The function uvc_video_clock_update() supports a single SOF overflow. Or
> in other words, the maximum difference between the first ant the last
> timestamp can be 4096 ticks or 4.096 seconds.
> 
> This results in a maximum value for y2 of: 0x12FBECA00, that overflows
> 32bits.
> y2 = (u32)ktime_to_ns(ktime_sub(last->host_time, first->host_time)) + y1;
> 
> Extend the size of y2 to u64 to support all its values.
> 
> Without this patch:
>  # yavta -s 1920x1080 -f YUYV -t 1/5 -c /dev/video0
> Device /dev/v4l/by-id/usb-Shine-Optics_Integrated_Camera_0001-video-index0 opened.
> Device `Integrated Camera: Integrated C' on `usb-0000:00:14.0-6' (driver 'uvcvideo') supports video, capture, without mplanes.
> Video format set: YUYV (56595559) 1920x1080 (stride 3840) field none buffer size 4147200
> Video format: YUYV (56595559) 1920x1080 (stride 3840) field none buffer size 4147200
> Current frame rate: 1/5
> Setting frame rate to: 1/5
> Frame rate set: 1/5
> 8 buffers requested.
> length: 4147200 offset: 0 timestamp type/source: mono/SoE
> Buffer 0/0 mapped at address 0x7947ea94c000.
> length: 4147200 offset: 4149248 timestamp type/source: mono/SoE
> Buffer 1/0 mapped at address 0x7947ea557000.
> length: 4147200 offset: 8298496 timestamp type/source: mono/SoE
> Buffer 2/0 mapped at address 0x7947ea162000.
> length: 4147200 offset: 12447744 timestamp type/source: mono/SoE
> Buffer 3/0 mapped at address 0x7947e9d6d000.
> length: 4147200 offset: 16596992 timestamp type/source: mono/SoE
> Buffer 4/0 mapped at address 0x7947e9978000.
> length: 4147200 offset: 20746240 timestamp type/source: mono/SoE
> Buffer 5/0 mapped at address 0x7947e9583000.
> length: 4147200 offset: 24895488 timestamp type/source: mono/SoE
> Buffer 6/0 mapped at address 0x7947e918e000.
> length: 4147200 offset: 29044736 timestamp type/source: mono/SoE
> Buffer 7/0 mapped at address 0x7947e8d99000.
> 0 (0) [-] none 0 4147200 B 507.554210 508.874282 242.836 fps ts mono/SoE
> 1 (1) [-] none 2 4147200 B 508.886298 509.074289 0.751 fps ts mono/SoE
> 2 (2) [-] none 3 4147200 B 509.076362 509.274307 5.261 fps ts mono/SoE
> 3 (3) [-] none 4 4147200 B 509.276371 509.474336 5.000 fps ts mono/SoE
> 4 (4) [-] none 5 4147200 B 509.476394 509.674394 4.999 fps ts mono/SoE
> 5 (5) [-] none 6 4147200 B 509.676506 509.874345 4.997 fps ts mono/SoE
> 6 (6) [-] none 7 4147200 B 509.876430 510.074370 5.002 fps ts mono/SoE
> 7 (7) [-] none 8 4147200 B 510.076434 510.274365 5.000 fps ts mono/SoE
> 8 (0) [-] none 9 4147200 B 510.276421 510.474333 5.000 fps ts mono/SoE
> 9 (1) [-] none 10 4147200 B 510.476391 510.674429 5.001 fps ts mono/SoE
> 10 (2) [-] none 11 4147200 B 510.676434 510.874283 4.999 fps ts mono/SoE
> 11 (3) [-] none 12 4147200 B 510.886264 511.074349 4.766 fps ts mono/SoE
> 12 (4) [-] none 13 4147200 B 511.070577 511.274304 5.426 fps ts mono/SoE
> 13 (5) [-] none 14 4147200 B 511.286249 511.474301 4.637 fps ts mono/SoE
> 14 (6) [-] none 15 4147200 B 511.470542 511.674251 5.426 fps ts mono/SoE
> 15 (7) [-] none 16 4147200 B 511.672651 511.874337 4.948 fps ts mono/SoE
> 16 (0) [-] none 17 4147200 B 511.873988 512.074462 4.967 fps ts mono/SoE
> 17 (1) [-] none 18 4147200 B 512.075982 512.278296 4.951 fps ts mono/SoE
> 18 (2) [-] none 19 4147200 B 512.282631 512.482423 4.839 fps ts mono/SoE
> 19 (3) [-] none 20 4147200 B 518.986637 512.686333 0.149 fps ts mono/SoE
> 20 (4) [-] none 21 4147200 B 518.342709 512.886386 -1.553 fps ts mono/SoE
> 21 (5) [-] none 22 4147200 B 517.909812 513.090360 -2.310 fps ts mono/SoE
> 22 (6) [-] none 23 4147200 B 517.590775 513.294454 -3.134 fps ts mono/SoE
> 23 (7) [-] none 24 4147200 B 513.298465 513.494335 -0.233 fps ts mono/SoE
> 24 (0) [-] none 25 4147200 B 513.510273 513.698375 4.721 fps ts mono/SoE
> 25 (1) [-] none 26 4147200 B 513.698904 513.902327 5.301 fps ts mono/SoE
> 26 (2) [-] none 27 4147200 B 513.895971 514.102348 5.074 fps ts mono/SoE
> 27 (3) [-] none 28 4147200 B 514.099091 514.306337 4.923 fps ts mono/SoE
> 28 (4) [-] none 29 4147200 B 514.310348 514.510567 4.734 fps ts mono/SoE
> 29 (5) [-] none 30 4147200 B 514.509295 514.710367 5.026 fps ts mono/SoE
> 30 (6) [-] none 31 4147200 B 521.532513 514.914398 0.142 fps ts mono/SoE
> 31 (7) [-] none 32 4147200 B 520.885277 515.118385 -1.545 fps ts mono/SoE
> 32 (0) [-] none 33 4147200 B 520.411140 515.318336 -2.109 fps ts mono/SoE
> 33 (1) [-] none 34 4147200 B 515.325425 515.522278 -0.197 fps ts mono/SoE
> 34 (2) [-] none 35 4147200 B 515.538276 515.726423 4.698 fps ts mono/SoE
> 35 (3) [-] none 36 4147200 B 515.720767 515.930373 5.480 fps ts mono/SoE
> 
> Cc: stable@vger.kernel.org
> Fixes: 66847ef013cc ("[media] uvcvideo: Add UVC timestamps support")
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Link: https://lore.kernel.org/r/20240610-hwtimestamp-followup-v1-2-f9eaed7be7f0@chromium.org
> Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> (cherry picked from commit 8676a5e796fa18f55897ca36a94b2adf7f73ebd1)
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> ---

All now queued up, thanks.

greg k-h

