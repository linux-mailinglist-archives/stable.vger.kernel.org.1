Return-Path: <stable+bounces-247237-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SDsUE8bvBWq3dgIAu9opvQ
	(envelope-from <stable+bounces-247237-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 17:52:38 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BAA65444F1
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 17:52:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 36A86300CE57
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 15:52:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7244146588;
	Thu, 14 May 2026 15:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R7PKVHYF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 926F42066DE
	for <stable@vger.kernel.org>; Thu, 14 May 2026 15:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778773954; cv=none; b=rA3MZTbfRLJmNOtE9wfcM9tj2fGO71IaXXoFTyaBFG42t6IoSDB0fxikH8TfuHMPgqSQk9Kc7iXUchAfgSurjG28vhnyFBxLlU44Ia4kBBY4JjqGOF5O8m/pZW7esKI97oLgfw4KNIGl4b+ZN9jlwtJnVo+0rbGEshNinq2ze3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778773954; c=relaxed/simple;
	bh=xGHDO7oSzCV5n8CqQc0Zvrs8ifFH38bfjHyN5eM8UAM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JipCowtNk2bYh/4qEBzi4JX3WdmBsRFyIRM58Hr1BkiXr3hooCK6IATmCbevsy2RPfcXgQQK19/oi2AG16I7wo36ZuAPSUQ0N3BAAyNC45aoCj6EFuh55PhGbP7WngFXn1HjEEsGzUJ8IHmd5JmvR7nxaa4503pwyhJBWWYQ37Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R7PKVHYF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1E5CC2BCB3;
	Thu, 14 May 2026 15:52:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778773954;
	bh=xGHDO7oSzCV5n8CqQc0Zvrs8ifFH38bfjHyN5eM8UAM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=R7PKVHYF6LIByJMeSTH7C8gzsua5mdBGmqzIt26k72Hx1ng1GJ3SqAEkhe09wkOOB
	 mdjHqKRnPYhGkccIBuUXEhLOguHF8PiCEqQRZ2OKm2hR3n7sDr0dE63gHN6+MyMle6
	 oe/vrlo+P0HDXM8j1yY8CPdXuWcyq4u3kq5WIiKGMm855YzqQTl2bETVyKyUF0Ipc1
	 WbMvrB4RKm2uQ86qlNeLg4sXGzqfKBAg55u6ILW25DU1r518DRBrDTvJSkRtZxVEYX
	 Nfq3QhEnhGAIiDKfsq/oDW3gQ6okYjkpWcsNXzI4kikLM2Lmjpo7zILPJ+I3u/sC3H
	 MOqEzgJmdzgYQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Prasanna Kumar T S M <ptsm@linux.microsoft.com>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] EDAC/versalnet: Fix device name memory leak
Date: Thu, 14 May 2026 11:52:31 -0400
Message-ID: <20260514155232.307214-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026051203-jasmine-payment-6259@gregkh>
References: <2026051203-jasmine-payment-6259@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 9BAA65444F1
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-247237-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url]
X-Rspamd-Action: no action

From: Prasanna Kumar T S M <ptsm@linux.microsoft.com>

[ Upstream commit 8cf5dd235eff6008cb04c3d8064d2acfa90616f1 ]

The device name allocated via kzalloc() in init_one_mc() is assigned to
dev->init_name but never freed on the normal removal path.  device_register()
copies init_name and then sets dev->init_name to NULL, so the name pointer
becomes unreachable from the device. Thus leaking memory.

Use a stack-local char array instead of using kzalloc() for name.

Fixes: d5fe2fec6c40 ("EDAC: Add a driver for the AMD Versal NET DDR controller")
Signed-off-by: Prasanna Kumar T S M <ptsm@linux.microsoft.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260401111856.2342975-1-ptsm@linux.microsoft.com
[ adapted fix from `init_one_mc()` helper to the equivalent loop in `init_versalnet()` using literal `32` instead of `MC_NAME_LEN` ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/edac/versalnet_edac.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/edac/versalnet_edac.c b/drivers/edac/versalnet_edac.c
index f90723bc93d5c..4053ee2e0beef 100644
--- a/drivers/edac/versalnet_edac.c
+++ b/drivers/edac/versalnet_edac.c
@@ -765,9 +765,9 @@ static int init_versalnet(struct mc_priv *priv, struct platform_device *pdev)
 	u32 num_chans, rank, dwidth, config;
 	struct edac_mc_layer layers[2];
 	struct mem_ctl_info *mci;
+	char name[32];
 	struct device *dev;
 	enum dev_type dt;
-	char *name;
 	int rc, i;
 
 	for (i = 0; i < NUM_CONTROLLERS; i++) {
@@ -814,7 +814,6 @@ static int init_versalnet(struct mc_priv *priv, struct platform_device *pdev)
 
 		dev = kzalloc(sizeof(*dev), GFP_KERNEL);
 		dev->release = versal_edac_release;
-		name = kmalloc(32, GFP_KERNEL);
 		sprintf(name, "versal-net-ddrmc5-edac-%d", i);
 		dev->init_name = name;
 		rc = device_register(dev);
-- 
2.53.0


