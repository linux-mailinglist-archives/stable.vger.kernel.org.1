Return-Path: <stable+bounces-244392-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MOrcIYlL+2mYYwMAu9opvQ
	(envelope-from <stable+bounces-244392-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 06 May 2026 16:09:13 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F41F84DBBFC
	for <lists+stable@lfdr.de>; Wed, 06 May 2026 16:09:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5D2CB301D695
	for <lists+stable@lfdr.de>; Wed,  6 May 2026 13:58:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1636B4266AC;
	Wed,  6 May 2026 13:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Az4J8nzU"
X-Original-To: stable@vger.kernel.org
Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A185442849F
	for <stable@vger.kernel.org>; Wed,  6 May 2026 13:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778075899; cv=pass; b=npX43jl3B3WpVCyFRmElc0mi5PeFJ3/1hvWPBDjDHD+8RDy042WooMY8HY6O6jo4aDQpfwVmecwsdv+lgFbQ8uayIp63rmM4DJ49PpED7BlZ32AJ3IHwz0gFYOmfcWIQCvQ8Whn3JABmqtJPobtRcASHy6r00wyggjq/iFrUA7c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778075899; c=relaxed/simple;
	bh=eaImYnZHNc8mXAJzozd++XRV+p2+tu+Ffdsrm6vJlbY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U8Sz0mgaV+4+HDQ96ULYZZJB2QsmA1Pl4XG0jjgUm8s7f994oOoCFh4ACBfhHGYk4MMPm1s1pVr135799oPXlvRkR73A1TbBeQcGcfF2Dhh6W1HiDl6gv/kBZaxO7Em9Rm+mallSdiLZMUlPn6RstTaTc52W+S7j+zyIrI2++rk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Az4J8nzU; arc=pass smtp.client-ip=74.125.224.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-6587cee8b57so7333849d50.2
        for <stable@vger.kernel.org>; Wed, 06 May 2026 06:58:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778075898; cv=none;
        d=google.com; s=arc-20240605;
        b=ge1OV74AwzLejuXO+/cyKYYOkrbVTAMddtuv5dzSEuPmagQKdD8hbC0TfsLUMFVMnS
         W51gaflcopJyZJ3I/GI1DuPLFfuPhU09XgHViB75PF8vreg6/spyXltSBKXLQB4TAgHt
         4ymZohoVUUj5uO72dKEr0wWCqZxzfuZWL/fjeSAWF7K+OKuo+qwsoyv9Wve/I1uqVDlU
         reoVYkM8ZGqWTbDFoo4p/BtTRJWfuOxDkfNzhwhW8bZ4FeO1dSXrGEE5k3e9A/gC7dK+
         WheOkZ1kG5v4SbFsGerwohn5L1HeDd2wBf7hvK5nzudF4tJOpANBu9mesg9QvDFEhrlv
         jvUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=yAGZRzNWoj71eYuAlCwOROEzF/QQfxUQn3hZ1d0klWU=;
        fh=Y1Qq4FW8kQQ+iQ8IbtDmtJOof/Zs22mCZkeUIMh/S3g=;
        b=duEnv2nxVD1a22/5w/wXaif0d/Nk36jgmBbxaFwglBbgYy90lJORAYdORJmdp5yTyw
         mGmtGWHYh9MOId2Y0qlwb13jXE1CamGcKnk1aZwlL2ZG9Yq6hyB6dCWhg9FxvesLv9RD
         HNSU67pt5DDrMHmV/942UAXEc0mWYydN4qDoBn3Z5AUNOdO3xl/2WvpxP5/uuP9qOEZB
         b7wXPpJjayQLD/ofxouqlInVvuI0qCfXhrWMsCl6y4VjymXo75/AR14S45W13b0/CK0w
         NmmXHOIabVMw0/P+egwRrRB1AI8/SNPA+TrzFozkwTe+ssmsN0Fae705lWj9CAxy5npn
         2Hmg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778075898; x=1778680698; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yAGZRzNWoj71eYuAlCwOROEzF/QQfxUQn3hZ1d0klWU=;
        b=Az4J8nzU4XHj8JiAItPLOzwJJB6MTDQtZ7OWd3IP4WkvdWD1+oZqcKM0jsKFsKulQC
         2HJFC0g0uYUU9VZ/CchmUrkzZBVtWrdvyc4hGvg4QG7/MnmboP0dLzSvglNW0IVZVYtG
         nWit1EykMmD1GxCE0yDqnphDuLlTb18KUX4xPebRQj/oc3GyVh0xckLA2CATT3wv8+Sm
         Ttnvp3wUPWHH9zJNW2BbMCMPqNGiwf6M08B/ujo2zx2PUTAd1+wOvHQqFGb8SffOjNYU
         i3bDUVCZCGBJJtNOtCjIYEPtB7M2LIMlBCn1G8z9V3Sk6oUNHhKL0hucXE/mQhA5GMOF
         E9hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778075898; x=1778680698;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yAGZRzNWoj71eYuAlCwOROEzF/QQfxUQn3hZ1d0klWU=;
        b=Dd2HwroP3dovbosIwjVshoO4xDm+00gMORxYeaKF9sMDKM9OiCu5JlC0YTXjF1SwFw
         qAYgYMliJ4TyGh6jE7e/QEM0E0ajTC16x43rDLUPt4xSWBwJTTD01JZPt1jSwAYSShGd
         eyxJDomncclmjKVGsnc2VaWVndVdQ2NAU2Npm4wd5HVZPCrCU4LVsYN0cmdFxmEw8gqe
         dw0GKawYnAbYK/EfJiI1cDCSakHJToY8LHj2bHr4eYJh/nq0GuX05EfOMLY82t3niDKx
         EcZ4CVooKPjY8j+P7FJHXwrT1TUPHP//qjzTBqsB/e6VS2UcoPxeTFsHy2My1DKGdgnl
         m+0g==
X-Forwarded-Encrypted: i=1; AFNElJ8qTI00HC29OBljhr46EFeDnPsqnyi0XKO3QWk9bKWBTIUXMJ+WVBP4Ra4yeOXK9fsCjJlzDK4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxeyqd5YNG8d6QKrkMwAveOGkbKZGUYyOn7Juk+P8pMkCsCY1m+
	11v+605jtXGKnIBuBkN12Fgb3xt9DR2ddQpPulwWOyEL2jitk96zaOUCIIMSxE0iKaU6m96wQbf
	h8MrAS64dEDm2yT0hdpBQ23LQbRSsj/4=
X-Gm-Gg: AeBDievUA6+J6FcB481EZJvCFN90hvrYUwT5R2CQM42m/6uQA79voNnn2CgCupgnVTc
	NL37ieY2jf/FnKT4oFLpTGzKk/rqsCCtYvysJljpfV7hM1AAze8V/Uma7afFtIurQasaTOsG+U0
	q6E9JWX9WY48Qkjrwb/ZFuAT+CFHeI0LDA7X9tpBIcyefZ3nIPUHxi99eLcICOm9pgIxXIlfX8h
	jxKCCHhYRRIjPmYXh8Z8WSajMvoFm+RglORUYheXe5HOCAn9nTE16PNRPzlxL7A/us8LJjORk2Y
	tXF/4yPh5FKkGIbZBmlVuF4oDFh1+A==
X-Received: by 2002:a05:690e:1688:b0:651:be8b:e87e with SMTP id
 956f58d0204a3-65c799989cemr4075950d50.34.1778075897748; Wed, 06 May 2026
 06:58:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260506092324.635014-1-lgs201920130244@gmail.com> <afsO9TxVuz79FFQ0@raspi>
In-Reply-To: <afsO9TxVuz79FFQ0@raspi>
From: Guangshuo Li <lgs201920130244@gmail.com>
Date: Wed, 6 May 2026 21:58:07 +0800
X-Gm-Features: AVHnY4IW3B6qWimauAAC6R2YoxAVTsxlXp2RYpmYRhFA5w6dajkgOR-Qizc8_E8
Message-ID: <CANUHTR8PNO-3hfEMCz4Zz_2ERLonE7OyNzPWtAaDtVpNB=YGhw@mail.gmail.com>
Subject: Re: [PATCH v5] drm/bridge: imx8qxp-pxl2dpi: avoid ERR_PTR with
 device_node cleanup
To: Liu Ying <victor.liu@nxp.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Robert Foss <rfoss@kernel.org>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
	Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, 
	Luca Ceresoli <luca.ceresoli@bootlin.com>, dri-devel@lists.freedesktop.org, 
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: F41F84DBBFC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-244392-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[intel.com,linaro.org,kernel.org,ideasonboard.com,kwiboo.se,gmail.com,linux.intel.com,suse.de,ffwll.ch,nxp.com,pengutronix.de,bootlin.com,lists.freedesktop.org,lists.linux.dev,lists.infradead.org,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lgs201920130244@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[]

Hi Liu,

Thanks for the clarification.

On Wed, 6 May 2026 at 17:49, Liu Ying <victor.liu@nxp.com> wrote:
>

>
> By "minimal" in v4 comment, I meant not to use __free(device_node)
> in imx8qxp_pxl2dpi_get_available_ep_from_port() and
> imx8qxp_pxl2dpi_set_pixel_link_sel() - please keep using
> __free(device_node) in imx8qxp_pxl2dpi_find_next_bridge().
>
>
> >   - Keep imx8qxp_pxl2dpi_get_available_ep_from_port() unchanged.
>
> No, please fix imx8qxp_pxl2dpi_get_available_ep_from_port() to make it
> return int.
>
> >   - Do not change imx8qxp_pxl2dpi_set_pixel_link_sel().
>
> No, you need to change it.
>
> --
> Regards,
> Liu Ying

I misunderstood your previous comment. I will update the patch to keep
using __free(device_node) in imx8qxp_pxl2dpi_find_next_bridge(),
change imx8qxp_pxl2dpi_get_available_ep_from_port() to return int and
pass the endpoint through an output argument, but avoid adding cleanup
action usage in imx8qxp_pxl2dpi_get_available_ep_from_port() and
imx8qxp_pxl2dpi_set_pixel_link_sel().

I will also drop the unnecessary local NULL initialization for ep,
since the helper initializes the output argument to NULL.

I will send a v6.

Best regards,
Guangshuo

