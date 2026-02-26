Return-Path: <stable+bounces-219834-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gLIUMfF7oGmMkAQAu9opvQ
	(envelope-from <stable+bounces-219834-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 26 Feb 2026 17:59:29 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 43FBC1AB81E
	for <lists+stable@lfdr.de>; Thu, 26 Feb 2026 17:59:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 100EC3195386
	for <lists+stable@lfdr.de>; Thu, 26 Feb 2026 16:45:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C625744CF52;
	Thu, 26 Feb 2026 16:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="LcVNHYIH"
X-Original-To: stable@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B4EB4279EE
	for <stable@vger.kernel.org>; Thu, 26 Feb 2026 16:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772122678; cv=none; b=Iy1SOr/kfYxVLuO3rtguyT6C0KmzCRvteOspgQuFVwDq7CN6UP6yi4jzEvQoZ2azpYS98OfCGVNTRc4gueHJJXWCoXUvlvnMDu7CdNEbIT26dMSA4P+i8oGBfSbw1P4ngofHwiJEB3fYtBA8p7P6LEnJzDGianunaToPsjqGDT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772122678; c=relaxed/simple;
	bh=Knp6wnhpWJMojlwQMsPPfiQVNGdDbd7c6ZWcXNeIGeE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=HGdIy5OtwSGGb9WFd6kL0LPAld3PApbLPjSDrYyx621hmdj3D3WzWUlWU1/UnuLPtsKyZa3d2dGfKKURI5so2vpMdaxOBYbYtrtmcFc/8WBXjSKN0iLw1Sq72JKEOxsonm/DTD6/PW49KuvcWrOKhxXwj8FuAwk9wEapMpcfTjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=LcVNHYIH; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 593741A147E;
	Thu, 26 Feb 2026 16:17:49 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 130E85FDE9;
	Thu, 26 Feb 2026 16:17:49 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D11BB103693AF;
	Thu, 26 Feb 2026 17:17:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1772122667; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=2lxLb7hEAgiLLYrfqBAXfJR0rppZEYHpa8Yprgn7TsU=;
	b=LcVNHYIHAgLnVrWlXzK8Fp4CEOpIlaqaJFVANV07dGm8rtPkGMUNktktIeG65ECFz3QTdl
	fJv132Et4htLiLYz7ZGREOw3Jt3plGe51JF8x/GC0CqorPNrgsyPksAXlo/yWzNiYDvakW
	f89U/BXfzOTtbKyg5Szpj6ySotZQOpsZRKMx73+8bFXzqnhmw9ipdihVz6wDrQjhyDjkJR
	NPqusQbtp1O3IjwKdxlE5tu4djRkObGZH4PsUG0A1nio5tlrAUMxH0yDb1dEsKknRgicgZ
	mP8mNL4lyY4trOlDwD95ZjiOD8PYNFRhFUgsnAMtQx3I6v7fYuU79TbNyFmhXw==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Subject: [PATCH 0/3] drm/bridge: ti-sn65dsi83: two fixes + add test pattern
Date: Thu, 26 Feb 2026 17:16:43 +0100
Message-Id: <20260226-ti-sn65dsi83-dual-lvds-fixes-and-test-pattern-v1-0-2e15f5a9a6a0@bootlin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOtxoGkC/x3M3QqDMAxA4VeRXC9QK3Y/rzJ2UUy6BSSTJspAf
 HfLLj84nB2Mq7DBo9uh8iYmX23oLx1Mn6xvRqFmiCGmEGNCFzRNI5ncBqQ1zzhvZFjkx4ZZCZ3
 NccnuXBXLWEq6cn8PYYL2XCr/y7Z8vo7jBLSZpJB/AAAA
X-Change-ID: 20260226-ti-sn65dsi83-dual-lvds-fixes-and-test-pattern-f5ff67e1900c
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Frieder Schrempf <frieder.schrempf@kontron.de>, Marek Vasut <marex@denx.de>, 
 Linus Walleij <linusw@kernel.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-219834-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[intel.com,linaro.org,kernel.org,ideasonboard.com,kwiboo.se,gmail.com,linux.intel.com,suse.de,ffwll.ch,kontron.de,denx.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luca.ceresoli@bootlin.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[bootlin.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:mid,bootlin.com:dkim,bootlin.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 43FBC1AB81E
X-Rspamd-Action: no action

This series fixes two bugs in the driver code and adds support for enabling
the test pattern output from userspace.

Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
---
Luca Ceresoli (3):
      drm/bridge: ti-sn65dsi83: fix CHA_DSI_CLK_RANGE rounding
      drm/bridge: ti-sn65dsi83: halve horizontal syncs for dual LVDS output
      drm/bridge: ti-sn65dsi83: add test pattern generation support

 drivers/gpu/drm/bridge/ti-sn65dsi83.c | 26 ++++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)
---
base-commit: 36d9579fed6c9429aa172f77bd28c58696ce8e2b
change-id: 20260226-ti-sn65dsi83-dual-lvds-fixes-and-test-pattern-f5ff67e1900c

Best regards,
-- 
Luca Ceresoli <luca.ceresoli@bootlin.com>


