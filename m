Return-Path: <stable+bounces-217582-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WEXPBttwmGkoIgMAu9opvQ
	(envelope-from <stable+bounces-217582-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 20 Feb 2026 15:34:03 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 73E8216860E
	for <lists+stable@lfdr.de>; Fri, 20 Feb 2026 15:34:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E19F930C5943
	for <lists+stable@lfdr.de>; Fri, 20 Feb 2026 14:31:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17469260565;
	Fri, 20 Feb 2026 14:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Dh0ifrOe"
X-Original-To: stable@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2DEB25C802
	for <stable@vger.kernel.org>; Fri, 20 Feb 2026 14:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771597918; cv=none; b=CA16Sq9KUVJssxZHvbY/YaxRxWAW8yms46woFJ9a3Mi7+HMVMG/fC0uSAVxTMsPjEo6Zr+j+SY8kgbzc2SFgh6rFc7gZCSxTF+gV0BXyydrR1IKdLBtF8loKiy5hGxSZf/vFMyq+Cf/pGg8he+hMuzHIzXe/fciqduOTy8hC/RA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771597918; c=relaxed/simple;
	bh=8pFXxfm43Ygmt72K/mPB3H7PwfQ1tOuAOc+Hc2LxDfs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=KaCs4rMEXe+4EwlZmuDRfxp8NjpTghS5HVzV6dTEBCcG0Y/450OxjNoOyw1wBgUIK4oCpq9wUQNuEkx1ds/j9h/X2xepjdVzpQjprv7vNo0oeNfFT8vp1LUN1j+Me5uCn/ZNFaJd2kpoHZ2xARQBvV0wpr74dViBEt8b2Eh3h6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Dh0ifrOe; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id DD812C16540;
	Fri, 20 Feb 2026 14:32:07 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 037975FA8F;
	Fri, 20 Feb 2026 14:31:55 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 84960102F19B0;
	Fri, 20 Feb 2026 15:31:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1771597913; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=rPpUH3pBdNAOPK5SiNx2Rrg92L+/rJ08JvvHmn303A4=;
	b=Dh0ifrOeeS41VcE9gU+++r5glsC6Fr1ruRyVc93NpfJv666XSEpdn2oOEQW/ftH5R8jXG5
	nG8H62uMO8j8mJfbJ67z44jFzpm+qHLOLQqt5upwKsSdJi1RXAFh3he/kJqPf/xSTr2x+C
	nzVH1p87WhiH3pGmPePcq2JxJnufdU7+KUcmZ/5453o3d5g1rAAH4tayZ/ir77OoWcaHyF
	ThE2zF+QKucuQpTkcCCxTg1e3XN4njqU8agVMkPZ3BE3XahtTBcJjwmU5mHrlsLmYp4xQp
	LmNqe9KgxZei/zQ18whLY7akuFODp3l99hsV7t9qAs5A9kIwpAN0g11WlSKbEg==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: Inki Dae <inki.dae@samsung.com>, 
 Jagan Teki <jagan@amarulasolutions.com>, 
 Marek Szyprowski <m.szyprowski@samsung.com>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Marek Vasut <marex@denx.de>, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Osama Abdelkader <osama.abdelkader@gmail.com>
Cc: stable@vger.kernel.org
In-Reply-To: <20260209184115.10937-1-osama.abdelkader@gmail.com>
References: <20260209184115.10937-1-osama.abdelkader@gmail.com>
Subject: Re: [PATCH] drm/bridge: samsung-dsim: Fix memory leak in error
 path
Message-Id: <177159790823.593042.10877987376431584853.b4-ty@bootlin.com>
Date: Fri, 20 Feb 2026 15:31:48 +0100
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-217582-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[samsung.com,amarulasolutions.com,intel.com,linaro.org,kernel.org,ideasonboard.com,kwiboo.se,gmail.com,linux.intel.com,suse.de,ffwll.ch,denx.de,lists.freedesktop.org,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luca.ceresoli@bootlin.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[bootlin.com:+];
	NEURAL_HAM(-0.00)[-0.997];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 73E8216860E
X-Rspamd-Action: no action


On Mon, 09 Feb 2026 19:41:14 +0100, Osama Abdelkader wrote:
> In samsung_dsim_host_attach(), drm_bridge_add() is called to add the
> bridge. However, if samsung_dsim_register_te_irq() or
> pdata->host_ops->attach() fails afterwards, the function returns
> without removing the bridge, causing a memory leak.
> 
> Fix this by adding proper error handling with goto labels to ensure
> drm_bridge_remove() is called in all error paths. Also ensure that
> samsung_dsim_unregister_te_irq() is called if the attach operation
> fails after the TE IRQ has been registered.
> 
> [...]

Applied, thanks!

[1/1] drm/bridge: samsung-dsim: Fix memory leak in error path
      commit: 803ec1faf7c1823e6e3b1f2aaa81be18528c9436

Best regards,
-- 
Luca Ceresoli <luca.ceresoli@bootlin.com>


