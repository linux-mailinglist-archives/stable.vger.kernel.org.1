Return-Path: <stable+bounces-204716-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EDC55CF3388
	for <lists+stable@lfdr.de>; Mon, 05 Jan 2026 12:23:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 68F48302CBAC
	for <lists+stable@lfdr.de>; Mon,  5 Jan 2026 11:20:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDCA6342C98;
	Mon,  5 Jan 2026 11:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="aXC4ZQt/"
X-Original-To: stable@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8E5A342530
	for <stable@vger.kernel.org>; Mon,  5 Jan 2026 11:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767612043; cv=none; b=S7gJMN/IEIoGLf2dP4YaOImPqMAigJF9znokSm+hi4Vz1qV6I490xHnUgYeiQDOzEhccWPIcdgmsg9KFclpo36kBr/iPyn4ldrS8dZoWdSgcoDHbxSvbmwIif7VhO7kfMYLDalLASxM7UV2Xru+xj+A0qVcN56YxnsecV9CqNSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767612043; c=relaxed/simple;
	bh=xas6ibraHS+4BjCQ6d0c56e4JsDJrT30DIcEVJwysKg=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=AwApdufhu1WpuPJqA4RAYzGY25mUkPuTjgs5MRuOCzhOG1PuYrY0xjVzGBWIiRVrDAUI7uzuHUVTr50QRmvzSlwojI3qGusWsiGSS1pFugyOFH+/E5UFKef1hJPGjdau4X9Tp+Ld9fGNgI1vXLDS4HrWUI8UokkxWoruTOGIpyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=aXC4ZQt/; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 324E11A2657;
	Mon,  5 Jan 2026 11:20:39 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id EDAFE60726;
	Mon,  5 Jan 2026 11:20:38 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0F7AD103C84F6;
	Mon,  5 Jan 2026 12:20:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1767612038; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=xHfSjWqxfxYko+txDt328icuQQjBRyghGWUrAKeMZGE=;
	b=aXC4ZQt/tBGsEBvst0PIkyYqOv3hYJstIf/OF8pstvJqyA0Y4aula3YQ0sHilDNmEf/ipm
	/IEBWpQ/gs3V/5bs88HH9Lmsrz/tWplLbOfp8r4GggLJ3/XL18wIi+xSkr9XuFsK6nXYgG
	762gW/GIPU+fBfEzSZHbhq/NALxbI6iYmZz7bBV3EFfn1oQSL49OLDuX6J61SZOyHFzBGW
	cFnOZclhfSbTm0/d0qvxDXzHlTxXoaQ1fH+lRTmN/tZcur9Cy9URVtPFvQyWLyT2muTNqd
	xetmz2PV/PctmCclnzH+p9q4hennbiLcYDIa34tL1Ro6ousggUuYLSGa6u3fGA==
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 05 Jan 2026 12:20:30 +0100
Message-Id: <DFGM64QKX8QF.28OD6W8F3JEJ8@bootlin.com>
Subject: Re: [PATCH v3] drm/bridge: synopsys: dw-dp: fix error paths of
 dw_dp_bind
Cc: <stable@vger.kernel.org>, "Andrzej Hajda" <andrzej.hajda@intel.com>,
 "Neil Armstrong" <neil.armstrong@linaro.org>, "Robert Foss"
 <rfoss@kernel.org>, "Laurent Pinchart" <Laurent.pinchart@ideasonboard.com>,
 "Jonas Karlman" <jonas@kwiboo.se>, "Jernej Skrabec"
 <jernej.skrabec@gmail.com>, "Maarten Lankhorst"
 <maarten.lankhorst@linux.intel.com>, "Maxime Ripard" <mripard@kernel.org>,
 "Thomas Zimmermann" <tzimmermann@suse.de>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Dmitry Baryshkov"
 <dmitry.baryshkov@oss.qualcomm.com>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>
To: "Osama Abdelkader" <osama.abdelkader@gmail.com>, "Andy Yan"
 <andy.yan@rock-chips.com>
From: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
X-Mailer: aerc 0.20.1
References: <20260102155553.13243-1-osama.abdelkader@gmail.com>
In-Reply-To: <20260102155553.13243-1-osama.abdelkader@gmail.com>
X-Last-TLS-Session-Version: TLSv1.3

Hello Osama,

On Fri Jan 2, 2026 at 4:55 PM CET, Osama Abdelkader wrote:
> Fix several issues in dw_dp_bind() error handling:
>
> 1. Missing return after drm_bridge_attach() failure - the function
>    continued execution instead of returning an error.
>
> 2. Resource leak: drm_dp_aux_register() is not a devm function, so
>    drm_dp_aux_unregister() must be called on all error paths after
>    aux registration succeeds. This affects errors from:
>    - drm_bridge_attach()
>    - phy_init()
>    - devm_add_action_or_reset()
>    - platform_get_irq()
>    - devm_request_threaded_irq()
>
> 3. Bug fix: platform_get_irq() returns the IRQ number or a negative
>    error code, but the error path was returning ERR_PTR(ret) instead
>    of ERR_PTR(dp->irq).
>
> Use a goto label for cleanup to ensure consistent error handling.
>
> Fixes: 86eecc3a9c2e ("drm/bridge: synopsys: Add DW DPTX Controller suppor=
t library")
> Cc: stable@vger.kernel.org
>
> Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>

Thank you for the improvements!

Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

Luca

--
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

