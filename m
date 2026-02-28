Return-Path: <stable+bounces-220156-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4AlKDQMso2mF+AQAu9opvQ
	(envelope-from <stable+bounces-220156-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:55:15 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E46591C535F
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:55:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A5C9F30CEE59
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 17:44:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D213D4949E6;
	Sat, 28 Feb 2026 17:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WtYoipL+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9289833E367;
	Sat, 28 Feb 2026 17:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300064; cv=none; b=uTxzol2sEQd/PgWFF/1PP9ykW80wbbeMm+3eSHesUC6Rbqs3xvJJuICsINlNKVWAtH3pqMYhdK3iNdVX+QdMfoKgWs9ObMYABIyeURAD5lZTcyKgnsB+bzq4n0oaMHVibYe8+8XeofsubPMQPSwMY7a6K3duLR/SBQDzToFjhr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300064; c=relaxed/simple;
	bh=PCEMzzxLXGpmxcOlMeVYiq+8d2ssX8aaUrN3TwllnxA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LZV3w/ybSD6nQIoj3wc2HErsOnrFMv85Yet7F+q072OstgWQ+MjYTNOH4TZiQqAvq49GCfQXrEe4AQBRk8VCaHRdE/WcSoXnOEGiM7+2SZ8SvC2cRV/5/QrAWVk83hVxHyQcFrrfaIKYtbJYQYsfbKMxF/E0XV5Axux8DUFMu/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WtYoipL+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7562C2BC9E;
	Sat, 28 Feb 2026 17:34:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300064;
	bh=PCEMzzxLXGpmxcOlMeVYiq+8d2ssX8aaUrN3TwllnxA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WtYoipL+/bed/4u26hdffaFdLEa4x2d7/5aPA26IACpUBl8LYbJMHvi1K5+xMH4gO
	 hnqZyjI5IjOgRIhAHKRgUGyuvySj63zQFRbAhFtdTMK1bf8NXJWtYMWS378q80C/1+
	 ReyG00NLG9wXUbwPFsN0p+h3jHkkz1ldEK1Vt3jgbIq5i8TMuZy9JyV6WUkeeAEa1E
	 atVRR9fBxrr6FbReQgpIBlEFZvjDaamHwJ0pb8QAdUKU5mhkqYVO1quFQsdDP34OY0
	 l0nPqn6XvGoD90TmFM+7ZS6DAeQg2kymEvcOj7KybGYTxLnLUw9ZHKz+uhaAHGcvPd
	 PyATAi0Byn8Eg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 078/844] cpufreq: dt-platdev: Block the driver from probing on more QC platforms
Date: Sat, 28 Feb 2026 12:19:51 -0500
Message-ID: <20260228173244.1509663-79-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220156-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:email,qualcomm.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E46591C535F
X-Rspamd-Action: no action

From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

[ Upstream commit 7b781899072c5701ef9538c365757ee9ab9c00bd ]

Add a number of QC platforms to the blocklist, they all use either the
qcom-cpufreq-hw driver.

Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/cpufreq/cpufreq-dt-platdev.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
index b06a43143d23c..2fecab989dacc 100644
--- a/drivers/cpufreq/cpufreq-dt-platdev.c
+++ b/drivers/cpufreq/cpufreq-dt-platdev.c
@@ -169,8 +169,11 @@ static const struct of_device_id blocklist[] __initconst = {
 	{ .compatible = "qcom,sdm845", },
 	{ .compatible = "qcom,sdx75", },
 	{ .compatible = "qcom,sm6115", },
+	{ .compatible = "qcom,sm6125", },
+	{ .compatible = "qcom,sm6150", },
 	{ .compatible = "qcom,sm6350", },
 	{ .compatible = "qcom,sm6375", },
+	{ .compatible = "qcom,sm7125", },
 	{ .compatible = "qcom,sm7225", },
 	{ .compatible = "qcom,sm7325", },
 	{ .compatible = "qcom,sm8150", },
-- 
2.51.0


