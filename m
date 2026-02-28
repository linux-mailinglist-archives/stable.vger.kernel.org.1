Return-Path: <stable+bounces-220752-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6A2TA+pDo2li+wQAu9opvQ
	(envelope-from <stable+bounces-220752-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:37:14 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 594741C7300
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:37:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BBABB32A50E2
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:18:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14BA2403DDF;
	Sat, 28 Feb 2026 17:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iAksRyvw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9C3E403DD6;
	Sat, 28 Feb 2026 17:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300632; cv=none; b=qsi9lJfvWJ8Lu22yddEVIKk0Y196JfBsh/7C9so5y+W0MMvxMA0z7/lQaADcuykrAXEalCRb7HFN0D+uvuXxo7UX+SJQwhdTnjJTPrvNcCBh2NaSti5DB+Oy0hvhIF1drmAd0xaNMk1toWDQIvTF6dQX4zkG0pe3avjdbd+JAE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300632; c=relaxed/simple;
	bh=0MEsXN5AH0lIkGP598z4YSPXisf20/DS+OzSmpQsEhc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qAS6ol4GL9nGeFQ79ZAYZ6Irx9mw70XBzRafB+IsKyZvTQmcR0WaUR7rRdH59abCjZpgPhfZtckuvBfMzgIQvjVm/NVdkqqCSMx58Gpl0uxgiSbCPjMgN2bqr0zmagDAHDGPt1EnLuz8thU58hr/gkcbRI5Sze8/58wcqMa2Fg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iAksRyvw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEA04C19423;
	Sat, 28 Feb 2026 17:43:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300632;
	bh=0MEsXN5AH0lIkGP598z4YSPXisf20/DS+OzSmpQsEhc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iAksRyvwMwKttINUd7CfTZXGcZLNoOm8IhJJRWtFfo3x9uQglDyGpcR/DUCR4+One
	 DuEsx7MEel9CivDAdh7KHHwfW4ZW6RyZeJVbhHvXTmRjMUB505BOtO71ogPvbnItim
	 Wrg0Kood+fB1hV14quYryoDSqqdtoFNPMpcaZIZZGh+ag8gAfy+tfJWycy6cM1KMlj
	 2REzXapawqd0nJBpKQzoutntboGWxhIIdI+m/6Fr9A0sisxk7d/NuaIIO5thb/2Md4
	 7/+cEKuyHKZNcqa84wey9P/lCpyR1PRpAy4Eu0g4H5MUl594nMgMpIHfiGB3wvrQBa
	 FvTcPZRTP0VDw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Johan Hovold <johan@kernel.org>,
	Mikko Perttunen <mperttunen@nvidia.com>,
	Miaoqian Lin <linmq006@gmail.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 673/844] clk: tegra: tegra124-emc: fix device leak on set_rate()
Date: Sat, 28 Feb 2026 12:29:46 -0500
Message-ID: <20260228173244.1509663-674-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,nvidia.com,gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220752-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 594741C7300
X-Rspamd-Action: no action

From: Johan Hovold <johan@kernel.org>

[ Upstream commit da61439c63d34ae6503d080a847f144d587e3a48 ]

Make sure to drop the reference taken when looking up the EMC device and
its driver data on first set_rate().

Note that holding a reference to a device does not prevent its driver
data from going away so there is no point in keeping the reference.

Fixes: 2db04f16b589 ("clk: tegra: Add EMC clock driver")
Fixes: 6d6ef58c2470 ("clk: tegra: tegra124-emc: Fix missing put_device() call in emc_ensure_emc_driver")
Cc: stable@vger.kernel.org	# 4.2: 6d6ef58c2470
Cc: Mikko Perttunen <mperttunen@nvidia.com>
Cc: Miaoqian Lin <linmq006@gmail.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/tegra/clk-tegra124-emc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/tegra/clk-tegra124-emc.c b/drivers/clk/tegra/clk-tegra124-emc.c
index 0f6fb776b2298..5f1af6dfe7154 100644
--- a/drivers/clk/tegra/clk-tegra124-emc.c
+++ b/drivers/clk/tegra/clk-tegra124-emc.c
@@ -197,8 +197,8 @@ static struct tegra_emc *emc_ensure_emc_driver(struct tegra_clk_emc *tegra)
 	tegra->emc_node = NULL;
 
 	tegra->emc = platform_get_drvdata(pdev);
+	put_device(&pdev->dev);
 	if (!tegra->emc) {
-		put_device(&pdev->dev);
 		pr_err("%s: cannot find EMC driver\n", __func__);
 		return NULL;
 	}
-- 
2.51.0


