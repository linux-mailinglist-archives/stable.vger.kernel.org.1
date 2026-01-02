Return-Path: <stable+bounces-204455-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 071DDCEE2FF
	for <lists+stable@lfdr.de>; Fri, 02 Jan 2026 11:46:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C9B26300A1D5
	for <lists+stable@lfdr.de>; Fri,  2 Jan 2026 10:46:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9999C1E7660;
	Fri,  2 Jan 2026 10:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="gNuzgdsO"
X-Original-To: stable@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CD471DFF7
	for <stable@vger.kernel.org>; Fri,  2 Jan 2026 10:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767350788; cv=none; b=FLcNL9LbR61Y7oN5qEEvrWGv4khC6IVpadzcZBuJnFVPcngfKqUHFRzJuEGusjKj2v4rkDvQLgSU4XkUi+08ziuL+wccARBDKs/4wCcde1ycKh6Lbpn1f65Iop9tyI0+NYS33SRMCxQZiEBRAHDYV4esM1ZqShcmnMZlSFXvjbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767350788; c=relaxed/simple;
	bh=xGhv9yIiqlpNcmLuumfW7cmgsKnmYQGggsPyHISzfGc=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:From:Subject:Cc:
	 References:In-Reply-To; b=LrCBFrkgn7WOLnusQ2rkO5DoYiXpX19+aLh77mQEOmjyKFfXGwxLbRfzFTz1RrL9yjGwFBpYwSg4NrqrhjrFrNfVqPfQ1WInRLL0fWLywAIVQY9Xaebhkti+0H0UvSgIeXUY7cqKcm34ukR0TO+VpMiE0juiWVB5T6fIQViyGn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=gNuzgdsO; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id C56724E41EF9;
	Fri,  2 Jan 2026 10:46:16 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 91F2860749;
	Fri,  2 Jan 2026 10:46:16 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 24DE8113B0716;
	Fri,  2 Jan 2026 11:46:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1767350775; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=hwrpAtofACV8mGnbbTj3ALFCTWHZSpnmoDNSqNxt0fE=;
	b=gNuzgdsO86vSGmyIcX3LO5esH3tHwTMeHye+WadDjwMyHWXJrD1+TkSD3MUvlwzvIdzMvE
	o0g+MuY++yvo7f83RYo7HXxIsbrDHl8pgEAZMOO1oOtAVc/6Y4+aNyz/WMJ2WO5xq12GqT
	U5HO8SrdDNaNJAP/EYJdA5vhUD9efGauxclThSPoeWD/Ond7W7Jwef/8yT7oaq46dszGXz
	jCoZukKBzZ1rfyeFLxTEc9wJVCEI3To554eIbLnDjlo9CVVsFFPefySiKTCcswucWcyaW5
	Ly/IZ/pWw+BR/7EuzF6XzaNXviSvYfwu4t8XZEAvV/apN4sVCnyYbWjjDSP0VA==
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 02 Jan 2026 11:46:08 +0100
Message-Id: <DFE1K6AD151E.23NWWMYDV2ZDI@bootlin.com>
To: "Osama Abdelkader" <osama.abdelkader@gmail.com>, "Andy Yan"
 <andy.yan@rock-chips.com>
From: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
Subject: Re: [PATCH v2] drm/bridge: synopsys: dw-dp: return when attach
 bridge fail
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
X-Mailer: aerc 0.20.1
References: <20251231144115.65968-1-osama.abdelkader@gmail.com>
In-Reply-To: <20251231144115.65968-1-osama.abdelkader@gmail.com>
X-Last-TLS-Session-Version: TLSv1.3

Hello Osama, Andy Yan,

Andy, a question for you below.

On Wed Dec 31, 2025 at 3:41 PM CET, Osama Abdelkader wrote:
> When drm_bridge_attach() fails, the function should return an error
> instead of continuing execution.
>
> Fixes: 86eecc3a9c2e ("drm/bridge: synopsys: Add DW DPTX Controller suppor=
t library")
> Cc: stable@vger.kernel.org
>
> Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
> ---
> v2:
> use concise error message
> add Fixes and Cc tags
> ---
>  drivers/gpu/drm/bridge/synopsys/dw-dp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-dp.c b/drivers/gpu/drm/br=
idge/synopsys/dw-dp.c
> index 82aaf74e1bc0..bc311a596dff 100644
> --- a/drivers/gpu/drm/bridge/synopsys/dw-dp.c
> +++ b/drivers/gpu/drm/bridge/synopsys/dw-dp.c
> @@ -2063,7 +2063,7 @@ struct dw_dp *dw_dp_bind(struct device *dev, struct=
 drm_encoder *encoder,
>
>  	ret =3D drm_bridge_attach(encoder, bridge, NULL, DRM_BRIDGE_ATTACH_NO_C=
ONNECTOR);
>  	if (ret)
> -		dev_err_probe(dev, ret, "Failed to attach bridge\n");
> +		return ERR_PTR(dev_err_probe(dev, ret, "Failed to attach bridge\n"));

Your change looks good now. However there is aanother issue, sorry for not
having noticed before.

While reading the dw_dp_bind() code in its entirety I have noticed that on
any error after drm_bridge_attach() (and also a drm_bridge_attach() error,
with this patch) it returns without undoing the previous actions. This is
fine for devm actions, but a problem for non-devm actions, which start at
drm_dp_aux_register().

For example, if phy_init() fails, dw_dp_bind() returns without calling
drm_dp_aux_unregister(), thus leaking the resources previously allocated by
drm_dp_aux_register().

Andy, can you tell whether my analysis is correct?

If it is, this should be fixed before applying this patch. Osama, do you
think you can add such a patch in your next iteration?

Best regards,
Luca

--
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

