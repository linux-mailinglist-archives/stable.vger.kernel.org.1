Return-Path: <stable+bounces-113498-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EBF33A292A2
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 16:04:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8EAA7188EB76
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 14:56:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB0F01D8A12;
	Wed,  5 Feb 2025 14:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Q/mXeU+u"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8740C172767;
	Wed,  5 Feb 2025 14:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738767164; cv=none; b=qoTL7K2pSJ8FgGqe2bk2Q9gL72ddE4vpWxZtGqIwE6SC6AhYcH0Zs714g7Ynq1LwEQOTc77CFNWiDYMg+PRFagC8KVJSaGYzgTRv2+MRuUtJOQNUNXZQ/1/AwbTfpyswzaIvHx3KURdTKR4vdF/62l2H+vpqoXFoEcqCZbjqvsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738767164; c=relaxed/simple;
	bh=knECKjCFB1CIc5rihTUvI3g7Tict4XdCpDKY5srY9Jo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W4vHb2GchQ2t4RHlzce80j5IesfB/YrWXDRWHtmFV+NYvtp+npGrDUlrYbENy2+tiGmVGFFqNIpKefJumWZtWrg9kufGg2p5ob3xpZYvgMA4ScKvs9nARiPDuwy/SkJRxN9NP4vwprxIWDw6930rNXVp0UEVKAKp3AKRf0jz624=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Q/mXeU+u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5EFAC4CEE2;
	Wed,  5 Feb 2025 14:52:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1738767164;
	bh=knECKjCFB1CIc5rihTUvI3g7Tict4XdCpDKY5srY9Jo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Q/mXeU+u8ZUmU1nJINjirKB/y/ShUq4VVRHq8VRVrjoaud+sby92EDEPax9OGGXmS
	 IZQj1eMDjguwIVyQBGfr6705YZIjv+ihxo0wLqQmpOfgzeXDPlvT4kvDoQ8fjPFVMg
	 HgSQpA2GCAgeXKcsub3pem2JlFemIzFE/Kfu9f4A=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.13 365/623] memory: tegra20-emc: fix an OF node reference bug in tegra_emc_find_node_by_ram_code()
Date: Wed,  5 Feb 2025 14:41:47 +0100
Message-ID: <20250205134510.183962810@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250205134456.221272033@linuxfoundation.org>
References: <20250205134456.221272033@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.13-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>

[ Upstream commit b9784e5cde1f9fb83661a70e580e381ae1264d12 ]

As of_find_node_by_name() release the reference of the argument device
node, tegra_emc_find_node_by_ram_code() releases some device nodes while
still in use, resulting in possible UAFs. According to the bindings and
the in-tree DTS files, the "emc-tables" node is always device's child
node with the property "nvidia,use-ram-code", and the "lpddr2" node is a
child of the "emc-tables" node. Thus utilize the
for_each_child_of_node() macro and of_get_child_by_name() instead of
of_find_node_by_name() to simplify the code.

This bug was found by an experimental verification tool that I am
developing.

Fixes: 96e5da7c8424 ("memory: tegra: Introduce Tegra20 EMC driver")
Signed-off-by: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
Link: https://lore.kernel.org/r/20241217091434.1993597-1-joe@pf.is.s.u-tokyo.ac.jp
Link: https://lore.kernel.org/r/20241218024415.2494267-3-joe@pf.is.s.u-tokyo.ac.jp
[krzysztof: applied v1, adjust the commit msg to incorporate v2 parts]
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/memory/tegra/tegra20-emc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/memory/tegra/tegra20-emc.c b/drivers/memory/tegra/tegra20-emc.c
index 7193f848d17e6..9b7d30a21a5bd 100644
--- a/drivers/memory/tegra/tegra20-emc.c
+++ b/drivers/memory/tegra/tegra20-emc.c
@@ -474,14 +474,15 @@ tegra_emc_find_node_by_ram_code(struct tegra_emc *emc)
 
 	ram_code = tegra_read_ram_code();
 
-	for (np = of_find_node_by_name(dev->of_node, "emc-tables"); np;
-	     np = of_find_node_by_name(np, "emc-tables")) {
+	for_each_child_of_node(dev->of_node, np) {
+		if (!of_node_name_eq(np, "emc-tables"))
+			continue;
 		err = of_property_read_u32(np, "nvidia,ram-code", &value);
 		if (err || value != ram_code) {
 			struct device_node *lpddr2_np;
 			bool cfg_mismatches = false;
 
-			lpddr2_np = of_find_node_by_name(np, "lpddr2");
+			lpddr2_np = of_get_child_by_name(np, "lpddr2");
 			if (lpddr2_np) {
 				const struct lpddr2_info *info;
 
@@ -518,7 +519,6 @@ tegra_emc_find_node_by_ram_code(struct tegra_emc *emc)
 			}
 
 			if (cfg_mismatches) {
-				of_node_put(np);
 				continue;
 			}
 		}
-- 
2.39.5




