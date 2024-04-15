Return-Path: <stable+bounces-39396-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F4E48A4848
	for <lists+stable@lfdr.de>; Mon, 15 Apr 2024 08:43:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0671F281CCE
	for <lists+stable@lfdr.de>; Mon, 15 Apr 2024 06:43:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F21F51EB3E;
	Mon, 15 Apr 2024 06:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="grJH5ukb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1E711DA32;
	Mon, 15 Apr 2024 06:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713163424; cv=none; b=svpXc588tyOY0XGdVm6X8F/k4SPrDUtK0Q6InRzts12XtSY3K6vjQZLiaR6WMigfROXajh+2Fm+PCMVEB6TE3eCsC32wSXE2M/SLOXU7SMPJTEn9G49NVSRkMxxsVSnyr4f3hd43+UPXrcT7J5f+Q8v7I0ebgvj2FwmELi2duPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713163424; c=relaxed/simple;
	bh=DNNTj+ykDgM/JD4IQplT3/fMLpZxUwGg0a/sfofypEA=;
	h=Message-ID:Date:From:To:Subject:In-Reply-To:References:Cc; b=ZCCgibunc6qrM6l4PKvxq6O6a3v8jnEIE94JC5fmV9hRmEao6MlaMwHLu/Lheg2KHBstMDUHts/Xqd141DKWXfBIbw4yxkUGT8KZQt0sqJyxDF2IQzR1X2ue+3acY+3HFHw0ozccJ9VvbN1yYFeRHujKIY/wdcBPSTj5ekUP7LQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=grJH5ukb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2321C3277B;
	Mon, 15 Apr 2024 06:43:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713163424;
	bh=DNNTj+ykDgM/JD4IQplT3/fMLpZxUwGg0a/sfofypEA=;
	h=Date:From:To:Subject:In-Reply-To:References:Cc:From;
	b=grJH5ukbJiygA1ARCF3SJlQpcu7vxzkD7XPDygzVcrACtm6Szv3GGaQrXSobFRN+I
	 Y+oYQKWHJCSt2JIbappiAkmsXTwOUhR2133qqVLZasThzLBoVJcHVJbvMdkqXQTV3X
	 jMjfep2N3bgFTN38PXBJvBZagZELuCrinl7zA0g0g6W62xF+erU9VZRFyuNMsyy0ZW
	 8h3E2ryxXET7ISmwUOTyS6LfJGvJ5Wkch2fUvlZbNBUqe/N7ST0ooKwdI/u7vvSlcy
	 2cXi7wxJdQX8QgduyJGXMm5r94cWapN8vWhC4+ZC17VD/PPyZe8F3y6+PmK+iT+/iv
	 Ux0CxPLeK4qAQ==
Message-ID: <5843f81d9ca77b26aeb25504f9c8a4f6@kernel.org>
Date: Mon, 15 Apr 2024 06:43:41 +0000
From: "Maxime Ripard" <mripard@kernel.org>
To: "Thomas Zimmermann" <tzimmermann@suse.de>
Subject: Re: [PATCH v2 01/43] drm/fbdev-generic: Do not set physical
 framebuffer address
In-Reply-To: <20240410130557.31572-2-tzimmermann@suse.de>
References: <20240410130557.31572-2-tzimmermann@suse.de>
Cc: airlied@gmail.com, daniel@ffwll.ch, deller@gmx.de, dri-devel@lists.freedesktop.org, javierm@redhat.com, linux-fbdev@vger.kernel.org, stable@vger.kernel.org, "Maarten
 Lankhorst" <maarten.lankhorst@linux.intel.com>, "Maxime Ripard" <mripard@kernel.org>, "Sui
 Jingfeng" <sui.jingfeng@linux.dev>, "Zack Rusin" <zack.rusin@broadcom.com>, "Zack
 Rusin" <zackr@vmware.com>
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

On Wed, 10 Apr 2024 15:01:57 +0200, Thomas Zimmermann wrote:
> Framebuffer memory is allocated via vzalloc() from non-contiguous
> physical pages. The physical framebuffer start address is therefore
> meaningless. Do not set it.
> 
> The value is not used within the kernel and only exported to userspace
> 
> [ ... ]

Acked-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime

