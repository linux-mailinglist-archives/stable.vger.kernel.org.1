Return-Path: <stable+bounces-210554-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CD4PBeGtb2nxEwAAu9opvQ
	(envelope-from <stable+bounces-210554-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 20 Jan 2026 17:31:29 +0100
X-Original-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 98B6447945
	for <lists+stable@lfdr.de>; Tue, 20 Jan 2026 17:31:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0C2C07826EC
	for <lists+stable@lfdr.de>; Tue, 20 Jan 2026 14:41:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E72BF40FD9D;
	Tue, 20 Jan 2026 14:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="IVXvK30T"
X-Original-To: stable@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C112340B6E2;
	Tue, 20 Jan 2026 14:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768919572; cv=none; b=UxORc7ctpQuI9gp7RrTtSuZLvf+Dq34QhAiRrFTvgz1bTGYdxRrPxVtXsAzEckHd/WpzEGZsXGNKILNwEFsWP41s97iZ8oUr1DnXMIIs9DPr9tnpFmYaMkDB1LgH7854SjHsjrfvtQgD4pY/+NwvJwJ5osMw+RD80s4KIrCMzEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768919572; c=relaxed/simple;
	bh=uns2v8KH7FKm99rtF8K7XsF8bh+wgH8xOaw9xwuiFbY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=NOWZUyCkQbVNZK8UnFKGrjtMXQAv7qQgOQ0RXAy76k0tLj01IMes8fJ144DOuQzS6JrX1pCIZSEkuk9aZLO1R9vWUTzuJwvwdwwFKGNI+QSW5PQij8JBYVA1IfUsn5qOuCtGtXW2YsDxuUk3N0p9igvq2Sqm6PHL/ju+k7N/uGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=IVXvK30T; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 34C011A2965;
	Tue, 20 Jan 2026 14:32:47 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 0777B606AB;
	Tue, 20 Jan 2026 14:32:47 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0BCC610B6B3C2;
	Tue, 20 Jan 2026 15:32:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1768919566; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=CnR4HH0qbA5JMdYprFWKRDPXqXPpkZ+LLXc3tQitS84=;
	b=IVXvK30TnSaepMj69bYNn55/lQxwgSv1HQzFNJJIZOQbbC4QqLAHwPsE44r8RFYo9uc7AL
	1X47C3e+f4USmaWZ9TvXrF4Jluk+xG4bUi7Pdbpt7BhP1K2QZBjaWpwt+kif1ykOyWSU/B
	osFs2+I54bNKxMzJ0I7VCyqXKVY5NdoU+0FQz+MPUf98xintblaldXhpYdNBugVwN8sHBh
	ZLCjOnjo8qIiK8AfGbJBQdLGQJOKjAR9QrI4NVHW93vM+/jIC4LBL7aeO7WzZAxMiyYGbp
	UF+tiQmAUU0Yn1UdnQzF9KAy6qJjfU3O13QiG0ExWcIcQaPRAymf4dUG5290Eg==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: Andy Yan <andy.yan@rock-chips.com>, 
 Osama Abdelkader <osama.abdelkader@gmail.com>
Cc: stable@vger.kernel.org, Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260102155553.13243-1-osama.abdelkader@gmail.com>
References: <20260102155553.13243-1-osama.abdelkader@gmail.com>
Subject: Re: [PATCH v3] drm/bridge: synopsys: dw-dp: fix error paths of
 dw_dp_bind
Message-Id: <176891955882.652956.206927403017627596.b4-ty@bootlin.com>
Date: Tue, 20 Jan 2026 15:32:38 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [-0.46 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-210554-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[rock-chips.com,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[17];
	FREEMAIL_CC(0.00)[vger.kernel.org,intel.com,linaro.org,kernel.org,ideasonboard.com,kwiboo.se,gmail.com,linux.intel.com,suse.de,ffwll.ch,oss.qualcomm.com,lists.freedesktop.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[bootlin.com,reject];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luca.ceresoli@bootlin.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[bootlin.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,bootlin.com:email,bootlin.com:dkim,bootlin.com:mid]
X-Rspamd-Queue-Id: 98B6447945
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On Fri, 02 Jan 2026 16:55:52 +0100, Osama Abdelkader wrote:
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
> [...]

Applied, thanks!

[1/1] drm/bridge: synopsys: dw-dp: fix error paths of dw_dp_bind
      commit: 1a0f69e3c28477b97d3609569b7e8feb4b6162e8

Best regards,
-- 
Luca Ceresoli <luca.ceresoli@bootlin.com>


