Return-Path: <stable+bounces-220275-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iJA0IaEvo2nb+AQAu9opvQ
	(envelope-from <stable+bounces-220275-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:10:41 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 06C641C57F3
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:10:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CFD9031B1119
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:03:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9871136B602;
	Sat, 28 Feb 2026 17:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gf2dLCBY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5653C36B5F9;
	Sat, 28 Feb 2026 17:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300179; cv=none; b=VLMsRBTt6qLvD1i47zQiZileDZ3qsizGjsO7Ek2WdF7dy/n3PrFrNbVT95+ciFdEfqmxWIgh05g3wvTNeB6PMw1c2TDYiRo0V81r9rlq5EOgD7j2QL9wrevkE9vCMpPuBX1nC/RQ2HD2q8c0TzI/x8qsz8blPBaKLzKdwA9bMJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300179; c=relaxed/simple;
	bh=pT8x8zLiJMqCIFt8/Tq8tXTiE8oYOB5XkIngBKSYPcA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fMC69o6nO+mP6IBVBPQbtQOWaXPxssXwTGgbldgqw+drVCpGdkAdghQeY0WNH66PRbZWj14yoKowepg63OhOnFwpGSiHfNE9x50TaZfvVv1UUFr93AbX4ejntYXFydzrhCDoJaMjvr/LmIUvozXRP79M6eeMg59Z8V+4iSSnVO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gf2dLCBY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 316F6C19423;
	Sat, 28 Feb 2026 17:36:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300179;
	bh=pT8x8zLiJMqCIFt8/Tq8tXTiE8oYOB5XkIngBKSYPcA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Gf2dLCBYZ9x00Ps24hZrNyYiCf9UrZ70a8XXVbCFvZtQ8gdE7YzbFwxhZw4yrJGrq
	 H02YRWGvKq0WTpzHMuw87bP4ta9Rj8G5TkcT25anJ50X03Xk8u1QD1OLrna4ABmqOf
	 eGKHE9qZxFj73vYDW6K5NRsM+Ef1hgxVbJlrOr1tNs998nokaWGfqMbBCjMT6865jJ
	 QyXMdrUXmySz9U2Mqer8oCQ+LB7MFq2bKz14icWBNVkHAmuH/ON4fCPKY5w2CPd4Vl
	 lO/W2vlrp/51lzYPGMHU/TxhAfvhzz+Op40PWsCtUj0aILQnfTJO6KsRYoOxpLekQX
	 TLjXTBefVDcIw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Bard Liao <yung-chuan.liao@linux.intel.com>,
	Liam Girdwood <liam.r.girdwood@intel.com>,
	Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 197/844] ASoC: soc-acpi-intel-arl-match: change rt722 amp endpoint to aggregated
Date: Sat, 28 Feb 2026 12:21:50 -0500
Message-ID: <20260228173244.1509663-198-sashal@kernel.org>
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
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220275-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 06C641C57F3
X-Rspamd-Action: no action

From: Bard Liao <yung-chuan.liao@linux.intel.com>

[ Upstream commit 08c09899960118ffb01417242e659eb6cc067d6a ]

rt722 is aggregated with rt1320 amp in arl_rt722_l0_rt1320_l2 and it is
the only audio configuration in the ARL platform. Set .aggregated = 1 to
represent the fact and avoid unexpected issue.

Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Reviewed-by: Liam Girdwood <liam.r.girdwood@intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Link: https://patch.msgid.link/20260119091749.1752088-2-yung-chuan.liao@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../intel/common/soc-acpi-intel-arl-match.c   | 23 +++++++++----------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/sound/soc/intel/common/soc-acpi-intel-arl-match.c b/sound/soc/intel/common/soc-acpi-intel-arl-match.c
index 6bf7a6250ddc3..c952f7d2b2c0e 100644
--- a/sound/soc/intel/common/soc-acpi-intel-arl-match.c
+++ b/sound/soc/intel/common/soc-acpi-intel-arl-match.c
@@ -45,23 +45,22 @@ static const struct snd_soc_acpi_endpoint spk_3_endpoint = {
 	.group_id = 1,
 };
 
-/*
- * RT722 is a multi-function codec, three endpoints are created for
- * its headset, amp and dmic functions.
- */
-static const struct snd_soc_acpi_endpoint rt722_endpoints[] = {
+static const struct snd_soc_acpi_endpoint jack_amp_g1_dmic_endpoints[] = {
+	/* Jack Endpoint */
 	{
 		.num = 0,
 		.aggregated = 0,
 		.group_position = 0,
 		.group_id = 0,
 	},
+	/* Amp Endpoint, work as spk_l_endpoint */
 	{
 		.num = 1,
-		.aggregated = 0,
+		.aggregated = 1,
 		.group_position = 0,
-		.group_id = 0,
+		.group_id = 1,
 	},
+	/* DMIC Endpoint */
 	{
 		.num = 2,
 		.aggregated = 0,
@@ -229,11 +228,11 @@ static const struct snd_soc_acpi_adr_device rt711_sdca_0_adr[] = {
 	}
 };
 
-static const struct snd_soc_acpi_adr_device rt722_0_single_adr[] = {
+static const struct snd_soc_acpi_adr_device rt722_0_agg_adr[] = {
 	{
 		.adr = 0x000030025D072201ull,
-		.num_endpoints = ARRAY_SIZE(rt722_endpoints),
-		.endpoints = rt722_endpoints,
+		.num_endpoints = ARRAY_SIZE(jack_amp_g1_dmic_endpoints),
+		.endpoints = jack_amp_g1_dmic_endpoints,
 		.name_prefix = "rt722"
 	}
 };
@@ -394,8 +393,8 @@ static const struct snd_soc_acpi_link_adr arl_rt711_l0_rt1316_l3[] = {
 static const struct snd_soc_acpi_link_adr arl_rt722_l0_rt1320_l2[] = {
 	{
 		.mask = BIT(0),
-		.num_adr = ARRAY_SIZE(rt722_0_single_adr),
-		.adr_d = rt722_0_single_adr,
+		.num_adr = ARRAY_SIZE(rt722_0_agg_adr),
+		.adr_d = rt722_0_agg_adr,
 	},
 	{
 		.mask = BIT(2),
-- 
2.51.0


