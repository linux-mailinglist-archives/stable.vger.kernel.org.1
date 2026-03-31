Return-Path: <stable+bounces-232014-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SIVQAM8CzGmGNQYAu9opvQ
	(envelope-from <stable+bounces-232014-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 19:22:23 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F7EA36E91D
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 19:22:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 97C1731232C4
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 16:47:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25E2641B342;
	Tue, 31 Mar 2026 16:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WHDzlwLZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE14E33120E;
	Tue, 31 Mar 2026 16:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774975652; cv=none; b=Wt7zx6YK8bG+VGASFWz4erOs2eaWoK2Gvpag7hxpvjJW5RJXbk0YV5ALEEfrt5i5pfCWrsA5Jx+vVyQQ0c0rEyfUncA9S+S8yJZq/kBjR7oK1TyxEEB7yTGzhl58JEdVaocSSkBAYeszI5RTtSFcSLZ/a7Y5qHn6yWMKgbkv6iI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774975652; c=relaxed/simple;
	bh=4ndE8liVUyY1pVEtyF8yWNnOw+kgSN1ge6xJZRYaffk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Oifa2EHcyT/Go/NvQ2cy9rVLOULaaEJvhpsrI0sFLKejysbka5NWpDePT09jgaaya8ItF/A1UXALliCRnv7sQJjXTWUOMUzWOGoodcG/FIZhBedRHkhgwsf1odcXxHFw/8U2NJgY/J06uIjGMwmH/GU5/WXQ+InMqSAf5nTDBdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WHDzlwLZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49BFAC19423;
	Tue, 31 Mar 2026 16:47:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774975652;
	bh=4ndE8liVUyY1pVEtyF8yWNnOw+kgSN1ge6xJZRYaffk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WHDzlwLZvI9/F1IaGIUxQwqXqVYPLwwqADSnrX/oQ9OiLBGLPaXGR85lJUAljOpUZ
	 2mkze06GNMnQ7Z8HQJM2BiqqztQrGiEVGcolCyeYdVOwld4reA40O4E5mybj8S9gMY
	 xe31GH9cpD8kWVcpur62HyZWWxU6G/DTlI0ZrRlA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Danilo Krummrich <dakr@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 006/244] sh: platform_early: remove pdev->driver_override check
Date: Tue, 31 Mar 2026 18:19:16 +0200
Message-ID: <20260331161741.939597693@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260331161741.651718120@linuxfoundation.org>
References: <20260331161741.651718120@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-232014-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable,renesas];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4F7EA36E91D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Danilo Krummrich <dakr@kernel.org>

[ Upstream commit c5f60e3f07b6609562d21efda878e83ce8860728 ]

In commit 507fd01d5333 ("drivers: move the early platform device support to
arch/sh") platform_match() was copied over to the sh platform_early
code, accidentally including the driver_override check.

This check does not make sense for platform_early, as sysfs is not even
available in first place at this point in the boot process, hence remove
the check.

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Fixes: 507fd01d5333 ("drivers: move the early platform device support to arch/sh")
Link: https://lore.kernel.org/all/DH4M3DJ4P58T.1BGVAVXN71Z09@kernel.org/
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/sh/drivers/platform_early.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/sh/drivers/platform_early.c b/arch/sh/drivers/platform_early.c
index 143747c45206f..48ddbc547bd9a 100644
--- a/arch/sh/drivers/platform_early.c
+++ b/arch/sh/drivers/platform_early.c
@@ -26,10 +26,6 @@ static int platform_match(struct device *dev, struct device_driver *drv)
 	struct platform_device *pdev = to_platform_device(dev);
 	struct platform_driver *pdrv = to_platform_driver(drv);
 
-	/* When driver_override is set, only bind to the matching driver */
-	if (pdev->driver_override)
-		return !strcmp(pdev->driver_override, drv->name);
-
 	/* Then try to match against the id table */
 	if (pdrv->id_table)
 		return platform_match_id(pdrv->id_table, pdev) != NULL;
-- 
2.51.0




