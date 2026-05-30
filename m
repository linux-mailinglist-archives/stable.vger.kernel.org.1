Return-Path: <stable+bounces-259083-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sC9FDf0xG2qqAAkAu9opvQ
	(envelope-from <stable+bounces-259083-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 20:52:45 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A9CC8612B2E
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 20:52:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DA3E631081C2
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 18:42:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E54C1B87C0;
	Sat, 30 May 2026 18:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XWb3ZgV8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06D6226738C;
	Sat, 30 May 2026 18:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780166556; cv=none; b=B87VbcvjUQKMe8R/kJ84NO+r8yKfD1fmjj94/1CFR0cL8AHGkTxqffVqDgcQFJwHR1zEd6zgfsyivro1Wb4F23Y5aT+gytrUsqQp6Xn8cwV4hMsz4jnLSF4qc5DfJW8nzmQXtXKHgv9PE0mK7t0Ax8/YvVKU0509kToPEkjRqxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780166556; c=relaxed/simple;
	bh=YXTplMTij6akB5cgvyG8nDYxdesycnuamBYoRGW9avg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iWTBNgzz0eCPpjwZvJRiD4jkU0GY5u/foTKo/ngzTc2gSuGYDx/9EB6RGjGB5WCOUvmhW6ByGLS1qmVIXScYSTbjVD4sQHnC/tab9bQQOg0rHvtKWl701+HMa5nSgapOrWcpFSefBdO2p0tPsGKbWzs0jLp3goHaFMv7KljaL0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XWb3ZgV8; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BC701F00893;
	Sat, 30 May 2026 18:42:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780166555;
	bh=7+9Y6UQZTb65tjJv8u92Xll/Ll7YVl4j+0sWO8yrGUU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XWb3ZgV8rQK9wi/k10c7YndVSQHHWCgX0AHAVdC6raOwbf9/7ycNgcEJZ24tVTB4n
	 DdHBdqcdS0w3E0hn6ZPG727lsunQWbM1yTIuCXNpWoPMOskKXDm19JoBHSuzjSkfqV
	 zxQW9MWSmJKupyiypOG8MyDSWD+DbMFWSxv3g34c=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Mikko Perttunen <mperttunen@nvidia.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 362/589] memory: tegra30-emc: Fix dll_change check
Date: Sat, 30 May 2026 18:04:03 +0200
Message-ID: <20260530160234.357111463@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260530160224.570625122@linuxfoundation.org>
References: <20260530160224.570625122@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-259083-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.996];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,msgid.link:url,linuxfoundation.org:mid,linuxfoundation.org:dkim,nvidia.com:email]
X-Rspamd-Queue-Id: A9CC8612B2E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mikko Perttunen <mperttunen@nvidia.com>

[ Upstream commit 0a93f2355cf4922ad2399dbef5ea1049fef116d4 ]

The code checking whether the specified memory timing enables DLL
in the EMRS register was reversed. DLL is enabled if bit A0 is low.
Fix the check.

Fixes: e34212c75a68 ("memory: tegra: Introduce Tegra30 EMC driver")
Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
Link: https://patch.msgid.link/20260126-fix-emc-dllchange-v1-2-47ad3bb63262@nvidia.com
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/memory/tegra/tegra30-emc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/memory/tegra/tegra30-emc.c b/drivers/memory/tegra/tegra30-emc.c
index 1bd6d3d827aa9..464cdc702754c 100644
--- a/drivers/memory/tegra/tegra30-emc.c
+++ b/drivers/memory/tegra/tegra30-emc.c
@@ -513,14 +513,14 @@ static int emc_prepare_timing_change(struct tegra_emc *emc, unsigned long rate)
 	emc->emc_cfg = readl_relaxed(emc->regs + EMC_CFG);
 	emc_dbg = readl_relaxed(emc->regs + EMC_DBG);
 
-	if (emc->dll_on == !!(timing->emc_mode_1 & 0x1))
+	if (emc->dll_on == !(timing->emc_mode_1 & 0x1))
 		dll_change = DLL_CHANGE_NONE;
-	else if (timing->emc_mode_1 & 0x1)
+	else if (!(timing->emc_mode_1 & 0x1))
 		dll_change = DLL_CHANGE_ON;
 	else
 		dll_change = DLL_CHANGE_OFF;
 
-	emc->dll_on = !!(timing->emc_mode_1 & 0x1);
+	emc->dll_on = !(timing->emc_mode_1 & 0x1);
 
 	if (timing->data[80] && !readl_relaxed(emc->regs + EMC_ZCAL_INTERVAL))
 		emc->zcal_long = true;
-- 
2.53.0




