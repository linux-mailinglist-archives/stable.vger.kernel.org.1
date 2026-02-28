Return-Path: <stable+bounces-220474-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aIC/FpY4o2mU+gQAu9opvQ
	(envelope-from <stable+bounces-220474-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:48:54 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D16BC1C648B
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:48:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 164F83124A50
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:34:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 492DF3BFDB7;
	Sat, 28 Feb 2026 17:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gugd4w2O"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07D273C0C1A;
	Sat, 28 Feb 2026 17:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300361; cv=none; b=EeY5/n7W1BuPc2PiMmzerx12jJeiTF8pkvwTYFSAGFM+iQOb6TFv31/yur4zx7jyiGAGMUEU/GLam2+hZafhw/oSF5rc19tLttPrQg63sM76rg5cq/TJ+dUbfeQvK8V7BJcA2THhziglgVji5xZqOLifwn+x5xyxqqmZ1rq+WrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300361; c=relaxed/simple;
	bh=gruoONGr1LBGtKcr1XKUcE1mXzaxkW8h7qwHuPBVHY4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DQgosii8Cp95Mo7ENf2PvbjQ1xk1eMPFe0pndJxc5z0RK0AZQHO6+4XmnXLodGdeB7TpUdngxUwke9/nGmCDOzcqQ4BrO3+FKtPojiQGEfULJ3OCqT2BT2wgLv8e+CS/1Qd6+jgZQ9gWqhFol8Fc3aVhYUKdobm8W38yu4h6YIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gugd4w2O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FF3CC19424;
	Sat, 28 Feb 2026 17:39:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300360;
	bh=gruoONGr1LBGtKcr1XKUcE1mXzaxkW8h7qwHuPBVHY4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gugd4w2OwT+c4NMZDLD9/vnvH1Wai/jyVYEDO6HOzRVbSYg0ritXVCu1biUWtkpkE
	 kpkwEJU5uUEQGHgV3BY058xnDLCCft9iGV9DcCUoAUPxn8SXSIXm79Ql8FLMNj5WIX
	 t+CO0UVNJggxNx15WKSlomfdDgEuc9XVcnmlkapnAJBf0bfMqvJ1UYgV3W6WhwLywJ
	 w1j9+LNzYwmhbHSOquBO9way5sO0icflrXcQjZA3cUuxZuYOwnvy1Z8dsrDJ3C39wB
	 eU8gxf+4Cb+gmNdg66iHhoIITHf9B8KODv72/D/FMrY1HTVKjsVYKAIXxDEeSWnuFd
	 uw4F2PFDdVxqQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Aleksandar Gerasimovski <aleksandar.gerasimovski@belden.com>,
	Vinod Koul <vkoul@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 395/844] phy: mvebu-cp110-utmi: fix dr_mode property read from dts
Date: Sat, 28 Feb 2026 12:25:08 -0500
Message-ID: <20260228173244.1509663-396-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-220474-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: D16BC1C648B
X-Rspamd-Action: no action

From: Aleksandar Gerasimovski <aleksandar.gerasimovski@belden.com>

[ Upstream commit e2ce913452ab56b3330539cc443b97b7ea8c3a1a ]

The problem with the current implementation is that it does not consider
that the USB controller can have multiple PHY handles with different
arguments count, as for example we have in our cn9131 based platform:
"phys = <&cp0_comphy1 0>, <&cp0_utmi0>;".

In such case calling "of_usb_get_dr_mode_by_phy" with -1 (no phy-cells)
leads to not proper phy detection, taking the "marvell,cp110-utmi-phy"
dts definition we can call the "of_usb_get_dr_mode_by_phy" with 0
(#phy-cells = <0>) and safely look for that phy.

Signed-off-by: Aleksandar Gerasimovski <aleksandar.gerasimovski@belden.com>
Link: https://patch.msgid.link/20260106150643.922110-1-aleksandar.gerasimovski@belden.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/phy/marvell/phy-mvebu-cp110-utmi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/phy/marvell/phy-mvebu-cp110-utmi.c b/drivers/phy/marvell/phy-mvebu-cp110-utmi.c
index 59903f86b13f5..dd3e515a8e865 100644
--- a/drivers/phy/marvell/phy-mvebu-cp110-utmi.c
+++ b/drivers/phy/marvell/phy-mvebu-cp110-utmi.c
@@ -338,7 +338,7 @@ static int mvebu_cp110_utmi_phy_probe(struct platform_device *pdev)
 			return -ENOMEM;
 		}
 
-		port->dr_mode = of_usb_get_dr_mode_by_phy(child, -1);
+		port->dr_mode = of_usb_get_dr_mode_by_phy(child, 0);
 		if ((port->dr_mode != USB_DR_MODE_HOST) &&
 		    (port->dr_mode != USB_DR_MODE_PERIPHERAL)) {
 			dev_err(&pdev->dev,
-- 
2.51.0


