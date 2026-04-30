Return-Path: <stable+bounces-242201-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8DVqC/2082lB6QEAu9opvQ
	(envelope-from <stable+bounces-242201-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 22:01:01 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B29244A788B
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 22:01:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 615E8302E40F
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 20:00:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F170388E62;
	Thu, 30 Apr 2026 20:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n2vmEcu9"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAE32388E70
	for <stable@vger.kernel.org>; Thu, 30 Apr 2026 20:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777579243; cv=none; b=MFKf7ZePeoXteeDE2bEe2nS6FVOhz3TFr259RJXAb8GaHmEkztrU2sgJ5Ad3lH0Bh3kBRLz7Jd76kvklyRUUe10tEDXGifgArJSPJi1d8Lc8G/nK2yUCwOqCQsImWdSLXfP93zXcaDj6eMrYINMbYdDS2QoxF32su5U56RoNmqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777579243; c=relaxed/simple;
	bh=oqKXKlm6wYMmuyYmNyuWvqeT7CRSh4QUaJek0Uj379E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cirkxcib/x3XxDElJI99d8up1zxfOVWfPekKAg7vr06Y1agbAb1SDLY+1CalUoJqIRCk6WOMjlKe7Ny5R96XxUzULw5uemg35mHoQwXClphGEDBqgRm2enmzvgYJ8pwASxMqZMR3Q/ElIHZjTZ4VF6diBQN0Bi4q6sPn/h2UYmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=n2vmEcu9; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-48a7fe4f40bso13253965e9.0
        for <stable@vger.kernel.org>; Thu, 30 Apr 2026 13:00:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777579240; x=1778184040; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=v0+yTsXt/PCHfrBu1YrbRJLXz84iGqApbjKG4zjSc2I=;
        b=n2vmEcu99rDDr1Pk4hom7WcHtR6Z5iy+IWyAi12ssQFCoAvHLl5UzKjEi3/2mk3Ukm
         z0qW4kOMQab5TqAzDqpWv8WiVHe98BO5ZPG4Ra9oP8z+lS98thTp62sQSn+FHrhcayPA
         Y/TK6B/OXIIlxwuFtn4eL+HrEixI8OkC8YGSAz5P0/Qs4UYZLjhAo4JH03sheujK/qZS
         jCkmMwjDH1w4GBjIiQ7+j8EE4ZjVbdn6zFBqJexwFHsvpkuCQIWiW8kLwHhMJ7ZO2TNP
         B9N+0OdJE93xsYki5capcQiGTCRoH4tWk8Z0WaHvEcZ6VMjX45EgnRkCVDQsCFwiwF91
         YPfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777579240; x=1778184040;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v0+yTsXt/PCHfrBu1YrbRJLXz84iGqApbjKG4zjSc2I=;
        b=T47m1jNUWE/6xhZk0GKt4wrP7wHo9SxM2H3cPc8ALrd0Ij2pgqVceRk9I6CCB8SrZJ
         gYqqu0p7BjcCtCWBUqQCCzrMGQDShjQCjX6HdnJLhUKjbPQEbHI5uGjmQS++4dET9rp3
         U7cYnRvBAoU8G/GYC5dDK8sXwG01vnglOWP8kpGk1lHHlaYkHLfa5uDUQcCVOv3hFETI
         XGKbVSOz/rQpSeHwurDDFBmzku3dwtnHapqr3G0WEPIVs7fAJnD8xk9Vlpbzhc/1CC1n
         oVI6+yuA7TucqfmfuxVXT/bvUa6poVenpxj4kOplo3pUyK7NIwqXIyKJCq7K0Pn0VJt8
         KcYw==
X-Forwarded-Encrypted: i=1; AFNElJ8Yce25eCezNH2RNFV652UAWQUZhgWHrHYnpMqxDVQK1j9Zr562FF9xRP0za+D3jw0i3Ok8P2s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6msvbmgASEn+GkxWOsXeSYzVIdMsZP1h818JIW/IldR3ZYcW/
	FjiacFpDVmL9qo8Fi8PG59PToB/gU6MPo838VpktqqFABquxV3CPLBhq
X-Gm-Gg: AeBDietIU6xRgpyQSLZp+PcH0vMOJyBmkNIg7G4fkqubNc+xoC0f4/SsKv7Qh5/TfuW
	puUolaQvlw1xpze7hf0gZRaktC3XQSs1a+GoWTPn4Q2evstPk0Gy9B1juJ6c9btKyoNi4fkMmof
	9q5D51V+MTMZBZ5Y92t5KTmCF5JlN5pXO8ZEOw6Brvmvc2Wp1UrougEQhb9KtdOftW141OR9Mkm
	RHsPrrD676bQAEdotKu9fDweFii7JacNzdRUHGL8aFWIRnM1Xkd7j+a2dYrzOoNlIu4K+EDs7mZ
	qC/4li4qVtGsvjvaJuJA4L1RNVYJaEGWOUDHruVZxr/Ey73ZTLpXFwz09m5z+5F5t3hFC9qbeEu
	c2watkwrlACiIiD4ccpI5e23m9FzxiYK0QmSNw/T1F3OCv2YB02wJL96+5j4b2j7ZLQvCoPDH24
	VZOmF28+PoT9jODZiyCtE/tik0WwyUpik/QdfEvppj10adJjjx0BXKXqOMXcy0ohml/L7f
X-Received: by 2002:a05:600c:8b22:b0:485:3a03:ceca with SMTP id 5b1f17b1804b1-48a844582c3mr75430765e9.23.1777579240148;
        Thu, 30 Apr 2026 13:00:40 -0700 (PDT)
Received: from osama ([2a02:908:1b6:8980:55a4:d495:8d6f:1416])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a8ebb3dc1sm3019145e9.14.2026.04.30.13.00.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2026 13:00:39 -0700 (PDT)
Date: Thu, 30 Apr 2026 22:00:37 +0200
From: Osama Abdelkader <osama.abdelkader@gmail.com>
To: Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Peter Senna Tschudin <peter.senna@gmail.com>, Ian Ray <ian.ray@ge.com>,
	Martyn Welch <martyn.welch@collabora.co.uk>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Archit Taneja <architt@codeaurora.org>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v3 3/3] drm/bridge: megachips: remove bridge when irq
 request fails
Message-ID: <afO05Q3tPgifoqvz@osama>
References: <20260423200622.325076-1-osama.abdelkader@gmail.com>
 <20260423200622.325076-3-osama.abdelkader@gmail.com>
 <DI5M5PFEHAD8.2IO9A5HABWOK6@bootlin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DI5M5PFEHAD8.2IO9A5HABWOK6@bootlin.com>
X-Rspamd-Queue-Id: B29244A788B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-242201-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[19];
	FREEMAIL_CC(0.00)[gmail.com,ge.com,collabora.co.uk,intel.com,linaro.org,kernel.org,ideasonboard.com,kwiboo.se,linux.intel.com,suse.de,ffwll.ch,codeaurora.org,lists.freedesktop.org,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[osamaabdelkader@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,bootlin.com:url]

Hello Luca,

On Wed, Apr 29, 2026 at 01:48:33PM +0200, Luca Ceresoli wrote:
> On Thu Apr 23, 2026 at 10:06 PM CEST, Osama Abdelkader wrote:
> > If devm_request_threaded_irq() fails after drm_bridge_add(), remove the
> > bridge before returning.
> >
> > Keep drm_bridge_add() rather than devm_drm_bridge_add(): registration is
> > tied to the STDP4028 device while ge_b850v3_register() may complete from
> > either I2C probe; devm would not unwind the bridge if the other client's
> > probe fails.
> >
> > Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
> > Fixes: a68ee76f4a28 ("drm/bridge: megachips-stdpxxxx-ge-b850v3-fw: Fix bridge initialization")
> 
> That commit only moved the bug to a slightly different location. The bug
> was present even before, since commit fcfa0ddc18ed ("drm/bridge: Drivers
> for megachips-stdpxxxx-ge-b850v3-fw (LVDS-DP++)"), so you should update
> your Fixes line to point to it.

Updated in v4, thanks.

> 
> 
> > Cc: stable@vger.kernel.org
> > ---
> > v3: add Fixes and Cc tags
> > v2: IRQ failure path only (explicit drm_bridge_remove)
> > ---
> >  .../drm/bridge/megachips-stdpxxxx-ge-b850v3-fw.c | 16 ++++++++++------
> >  1 file changed, 10 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/bridge/megachips-stdpxxxx-ge-b850v3-fw.c b/drivers/gpu/drm/bridge/megachips-stdpxxxx-ge-b850v3-fw.c
> > index c9e6505cbd88..2d02cc69f237 100644
> > --- a/drivers/gpu/drm/bridge/megachips-stdpxxxx-ge-b850v3-fw.c
> > +++ b/drivers/gpu/drm/bridge/megachips-stdpxxxx-ge-b850v3-fw.c
> > @@ -251,7 +251,6 @@ static void ge_b850v3_lvds_remove(void)
> >  		goto out;
> >
> >  	drm_bridge_remove(&ge_b850v3_lvds_ptr->bridge);
> > -
> >  	ge_b850v3_lvds_ptr = NULL;
> >  out:
> >  	mutex_unlock(&ge_b850v3_lvds_dev_mutex);
> > @@ -261,6 +260,7 @@ static int ge_b850v3_register(void)
> >  {
> >  	struct i2c_client *stdp4028_i2c = ge_b850v3_lvds_ptr->stdp4028_i2c;
> >  	struct device *dev = &stdp4028_i2c->dev;
> > +	int ret;
> >
> >  	/* drm bridge initialization */
> >  	ge_b850v3_lvds_ptr->bridge.ops = DRM_BRIDGE_OP_DETECT |
> > @@ -277,11 +277,15 @@ static int ge_b850v3_register(void)
> >  	if (!stdp4028_i2c->irq)
> >  		return 0;
> >
> > -	return devm_request_threaded_irq(&stdp4028_i2c->dev,
> > -			stdp4028_i2c->irq, NULL,
> > -			ge_b850v3_lvds_irq_handler,
> > -			IRQF_TRIGGER_HIGH | IRQF_ONESHOT,
> > -			"ge-b850v3-lvds-dp", ge_b850v3_lvds_ptr);
> > +	ret = devm_request_threaded_irq(&stdp4028_i2c->dev,
> > +					stdp4028_i2c->irq, NULL,
> > +					ge_b850v3_lvds_irq_handler,
> > +					IRQF_TRIGGER_HIGH | IRQF_ONESHOT,
> > +					"ge-b850v3-lvds-dp", ge_b850v3_lvds_ptr);
> > +	if (ret)
> > +		drm_bridge_remove(&ge_b850v3_lvds_ptr->bridge);
> 
> Why not just using devm_drm_bridge_add() and keep everything else clean, as
> you did in other patches in the series?

Because registration is tied to the STDP4028 device while ge_b850v3_register()
may complete from either I2C probe; so devm would not unwind the bridge if the 
other client's probe fails.

> 
> Luca
> 
> --
> Luca Ceresoli, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com

