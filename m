Return-Path: <stable+bounces-233938-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id APVbLKB/1mmQFwgAu9opvQ
	(envelope-from <stable+bounces-233938-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 18:17:36 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D86F3BEC2A
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 18:17:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DC032300D14D
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 16:17:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 350F6346782;
	Wed,  8 Apr 2026 16:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="BIq1oqTf"
X-Original-To: stable@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE64A258EE0
	for <stable@vger.kernel.org>; Wed,  8 Apr 2026 16:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775665054; cv=none; b=lWm0TeC/O31xeh98Cf4nSqvft4RqI8SVW/x5hAhBSyPE+jQUlTJg5STfMO96jLXhTlzkxCOgaRO1fNDLRcZie0Md0EwSzYrtfB9QAWoC0S+wmt2Xnq7QLnHMSrvlUCDQZEVo3JJl81sFKAEsLHl8ylh+fyeTzJLxFzR3qdHdDhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775665054; c=relaxed/simple;
	bh=4A0tIwDD9VHgCy7Bk1wUfoUS7YjldjWZiQz5d1R8gEk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fdGDLNIgQG3J0QQV18bNOmilgRQTyc+sfJHG0nXPMnxrHESmY4clt/UEklMzHsKr3lLfJG4o58A34PX69wk7QOTib7kiqGlDT16LyIHToZXQ9PUvNr/+fpCTH8repFTyEDKNnv4q/6pL9LiOfR0WgNugWs4jtDL40X81zrkIJRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=BIq1oqTf; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id B1929C5AA9A;
	Wed,  8 Apr 2026 16:18:05 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 57C3C603CE;
	Wed,  8 Apr 2026 16:17:31 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3EA6910450154;
	Wed,  8 Apr 2026 18:17:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1775665050; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=sW7PfS/oGOQ7K0BGI9Bt1TIPXOxXhcJbY+thwE8WW+g=;
	b=BIq1oqTfqfW6AV6UWeme3jl+n9hN744rsHzRQCGMeshPn+VoDrOOPblFhtOjxu5WgCDfr6
	PKEGzY8QPUG/LmPsvKpnDPVI97jfnGYLmFrSlogdV3v0Suax/HJIUaoW9BWwQFS6GKAcOX
	0qW8rycPgQGQTZE+6RsCbq2l8Sax/Xi70S7+xyjsorrfNfInSStzLrunwiwgkuBG9QSmob
	1eOsMKn8bplGk20ZTo5+7AutuhBGL+wciUCPWckqeMndhNTmla0rVmjnFoHCHsemUQ0QHq
	1Mz5tcUfE2UiKvD+VK/2qvWbnv660f0uq/VdqVyk+QWArwAmvZOp8CkHJRem7A==
Message-ID: <bd58a56f-f30c-491b-b50e-6cdede803139@bootlin.com>
Date: Wed, 8 Apr 2026 18:18:07 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/arcpgu: fix device node leak
To: Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Simona Vetter <simona.vetter@ffwll.ch>,
 Alexey Brodkin <abrodkin@synopsys.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: Hui Pu <Hui.Pu@gehealthcare.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Ian Ray <ian.ray@gehealthcare.com>, stable@vger.kernel.org
References: <20260402-drm-arcgpu-fix-device-node-leak-v2-1-d773cf754ae5@bootlin.com>
From: Louis Chauvet <louis.chauvet@bootlin.com>
Content-Language: en-US
In-Reply-To: <20260402-drm-arcgpu-fix-device-node-leak-v2-1-d773cf754ae5@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-233938-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[bootlin.com,ffwll.ch,synopsys.com,linux.intel.com,kernel.org,suse.de,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[bootlin.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[louis.chauvet@bootlin.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:dkim,bootlin.com:email,bootlin.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2D86F3BEC2A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 4/2/26 18:42, Luca Ceresoli wrote:
> This function gets a device_node reference via
> of_graph_get_remote_port_parent() and stores it in encoder_node, but never
> puts that reference. Add it.
> 
> There used to be a of_node_put(encoder_node) but it has been removed by
> mistake during a rework in commit 3ea66a794fdc ("drm/arc: Inline
> arcpgu_drm_hdmi_init").
> 
> Fixes: 3ea66a794fdc ("drm/arc: Inline arcpgu_drm_hdmi_init")
> Cc: stable@vger.kernel.org
> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>

> ---
> Changes in v2:
> - fix typos in commit message
> ---
>   drivers/gpu/drm/tiny/arcpgu.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/tiny/arcpgu.c b/drivers/gpu/drm/tiny/arcpgu.c
> index 505888497482..c93d61ac0bb7 100644
> --- a/drivers/gpu/drm/tiny/arcpgu.c
> +++ b/drivers/gpu/drm/tiny/arcpgu.c
> @@ -250,7 +250,8 @@ DEFINE_DRM_GEM_DMA_FOPS(arcpgu_drm_ops);
>   static int arcpgu_load(struct arcpgu_drm_private *arcpgu)
>   {
>   	struct platform_device *pdev = to_platform_device(arcpgu->drm.dev);
> -	struct device_node *encoder_node = NULL, *endpoint_node = NULL;
> +	struct device_node *encoder_node __free(device_node) = NULL;
> +	struct device_node *endpoint_node = NULL;
>   	struct drm_connector *connector = NULL;
>   	struct drm_device *drm = &arcpgu->drm;
>   	int ret;
> 
> ---
> base-commit: 4b9c36c83b34f710da9573291404f6a2246251c1
> change-id: 20251119-drm-arcgpu-fix-device-node-leak-f909bc1f7fbb
> 
> Best regards,
> --
> Luca Ceresoli <luca.ceresoli@bootlin.com>
> 


