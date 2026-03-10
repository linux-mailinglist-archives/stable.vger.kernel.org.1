Return-Path: <stable+bounces-224377-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4NHbEjsCsGnOeQIAu9opvQ
	(envelope-from <stable+bounces-224377-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 12:36:27 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 06A5924B166
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 12:36:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7C0F53075322
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 11:29:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7E9B3876A3;
	Tue, 10 Mar 2026 11:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iK5NyBZ8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B6B63803EA;
	Tue, 10 Mar 2026 11:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773142110; cv=none; b=FUBQZ/5o+GpwAcncAONBm5Mugh3fKm7eC/fnqDBSPIIc/SjCajXQ//xek8Fnsdz6B3VAzwS7xvwodyIm0qoqN27Dx7VblPyPS2QciezwoE+fdF0vldiXmlLs7Ik15jlYtvxXlaa+ehKQpv++3avE86klzeHv1r9KWmY8px2RmkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773142110; c=relaxed/simple;
	bh=NUYZOn2Q0n26eTBEFKMEkD+ThcG1k5SdrAojUY2QwzA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VHkazunbJT7VBr4hRTAwhYDWzVT92EaeVO9PmZg9AXwnB8bHiHx5oNWZ+5Zo0hKy38vQbk88t/XrhdHRIETCQjKq3J2mg1wwiWalnVb8FSqXg5o1ZHYbJIGRH36uya6lx8QW/3+OBVTUkx6r7NeKXZKeKspP1Gry+0mzN6Moh0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iK5NyBZ8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB680C2BCAF;
	Tue, 10 Mar 2026 11:28:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773142110;
	bh=NUYZOn2Q0n26eTBEFKMEkD+ThcG1k5SdrAojUY2QwzA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iK5NyBZ8WcIwuql7xp4OQLeRTE+6Zu9Hy2/GZJL2KrLPnh5apwd9g9sNm+AMhfNil
	 ZYlB7ZeSccp1736u+Q4y0ADLmEoX9L56N5pewKvRvyQ3W9l6XLlNhfVhS6qZ+zgkFb
	 kyVhjAjbQX3G0YT5t5lo6IgIBAummNKHf+BbyCphIj9FrMhCZhPHKeA4l2rGoyBrlk
	 JUKRlK4096WKk66hh4VkMQS26+O+5yRm/PfhiZpyZnX1hB/Iul+8Yyu8L40ZYASMor
	 hlSNeq3Jpy8vp9WhMR5o/nV26kU6rraOyyRIjvPTfvOQAqBzv0mFnRpexcd3Z5rUHD
	 2WnppG0r9lJOA==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Alexander Stein <alexander.stein@ew.tq-group.com>,
	Mark Brown <broonie@kernel.org>,
	Fabio Estevam <festevam@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 6.18 198/314] ASoC: fsl_xcvr: provide regmap names
Date: Tue, 10 Mar 2026 07:17:37 -0400
Message-ID: <e1d191055e450a230e53d8fd1fb69e607cf926dc.1773141555.git.sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1773141554.git.sashal@kernel.org>
References: <cover.1773141554.git.sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 06A5924B166
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[ew.tq-group.com,kernel.org,gmail.com,linuxfoundation.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-224377-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,linuxfoundation.org:email,tq-group.com:email,msgid.link:url]
X-Rspamd-Action: no action

From: Alexander Stein <alexander.stein@ew.tq-group.com>

commit 08fd332eeb88515af4f1892d91f6ef4ea7558b71 upstream.

This driver uses multiple regmaps, which will causes name conflicts
in debugfs like:
  debugfs: '30cc0000.xcvr' already exists in 'regmap'
Fix this by adding a name for the non-core regmap configurations.

Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
Link: https://patch.msgid.link/20251216084931.553328-1-alexander.stein@ew.tq-group.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Fabio Estevam <festevam@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/soc/fsl/fsl_xcvr.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/fsl/fsl_xcvr.c b/sound/soc/fsl/fsl_xcvr.c
index 06434b2c9a0fb..a268fb81a2f86 100644
--- a/sound/soc/fsl/fsl_xcvr.c
+++ b/sound/soc/fsl/fsl_xcvr.c
@@ -1323,6 +1323,7 @@ static const struct reg_default fsl_xcvr_phy_reg_defaults[] = {
 };
 
 static const struct regmap_config fsl_xcvr_regmap_phy_cfg = {
+	.name = "phy",
 	.reg_bits = 8,
 	.reg_stride = 4,
 	.val_bits = 32,
@@ -1335,6 +1336,7 @@ static const struct regmap_config fsl_xcvr_regmap_phy_cfg = {
 };
 
 static const struct regmap_config fsl_xcvr_regmap_pllv0_cfg = {
+	.name = "pllv0",
 	.reg_bits = 8,
 	.reg_stride = 4,
 	.val_bits = 32,
@@ -1345,6 +1347,7 @@ static const struct regmap_config fsl_xcvr_regmap_pllv0_cfg = {
 };
 
 static const struct regmap_config fsl_xcvr_regmap_pllv1_cfg = {
+	.name = "pllv1",
 	.reg_bits = 8,
 	.reg_stride = 4,
 	.val_bits = 32,
-- 
2.51.0


