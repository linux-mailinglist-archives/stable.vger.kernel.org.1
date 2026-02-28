Return-Path: <stable+bounces-220699-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gNFHOW1Co2li+wQAu9opvQ
	(envelope-from <stable+bounces-220699-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:30:53 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 49D301C714D
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:30:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DE6EF3097241
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:09:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABE4E317145;
	Sat, 28 Feb 2026 17:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R+1HYv+T"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EA5648C416;
	Sat, 28 Feb 2026 17:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300579; cv=none; b=ZUPPOswdvGMFT2fR65mAiCDUrbm8+K59/z8WdEPBjh9wZD0Uow55QU/Ia5ze5bPq5u41PlKdfleiA/gPF/7mAs147+j3G0rxgzofQa/lra2myoK6SMAdyKvG+XN0RW+Fh2t2857SWY1jo6Llmj5sNijMjsVYSeZRjgnazC5ZeVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300579; c=relaxed/simple;
	bh=4wwd9lAtfAx/5nuKfXxd7IZ69+OJygCwQdi19XSC14k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cgnuZQhxp2Pqj4N6yp0069HItjCDDAsYjfF4+PlfH+kPVLjZohrNQ8SYR084UXsgmRd0BpQBM7aTVGGtKZhprGm8f/mDMqqYf9BYoBQz5unhuLtJ1ekfjMLBn4YibRejrWudnyV2tAuftJI4g1P/OeL++G4raw0SbH87pJju2Aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R+1HYv+T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A507FC19425;
	Sat, 28 Feb 2026 17:42:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300579;
	bh=4wwd9lAtfAx/5nuKfXxd7IZ69+OJygCwQdi19XSC14k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=R+1HYv+TGVdocEzy/FB11dKU2C5ec5sa6vgUY2NNFc7551uftwliArRJNIQE5ljD6
	 rkz2IoYcYy2e5u0M2xqWIUyzvLVOCTxuiEdm+nua+7/uxbBy5TmoLLmIBaizkCd6RC
	 IPgZtioUPuGCPRplk0TfkO/lhc6tcrx0dZM/aYiwloCkYkRwj9ExHbe53crA0Yr/l1
	 +MvDcGBAY+lS+nx26cD/XQUZmlNa2KicbBFxhkYE1LHNU56WN3RE/1PPFXmjguePOc
	 L1oRjobSPzdtPGokNjYt0SdtgvUEXEh3qMMGY+7XuoT7FibLsuxOjMHaB4XXFzUC6s
	 itsOiiAtRWZIQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>,
	Brian Masney <bmasney@redhat.com>,
	Thierry Reding <treding@nvidia.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 620/844] clk: tegra: tegra124-emc: Fix potential memory leak in tegra124_clk_register_emc()
Date: Sat, 28 Feb 2026 12:28:53 -0500
Message-ID: <20260228173244.1509663-621-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220699-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[iscas.ac.cn:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,nvidia.com:email]
X-Rspamd-Queue-Id: 49D301C714D
X-Rspamd-Action: no action

From: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>

[ Upstream commit fce0d0bd9c20fefd180ea9e8362d619182f97a1d ]

If clk_register() fails, call kfree to release "tegra".

Fixes: 2db04f16b589 ("clk: tegra: Add EMC clock driver")
Cc: stable@vger.kernel.org
Signed-off-by: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>
Reviewed-by: Brian Masney <bmasney@redhat.com>
Signed-off-by: Thierry Reding <treding@nvidia.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/tegra/clk-tegra124-emc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/tegra/clk-tegra124-emc.c b/drivers/clk/tegra/clk-tegra124-emc.c
index 2a6db04342815..0f6fb776b2298 100644
--- a/drivers/clk/tegra/clk-tegra124-emc.c
+++ b/drivers/clk/tegra/clk-tegra124-emc.c
@@ -538,8 +538,10 @@ struct clk *tegra124_clk_register_emc(void __iomem *base, struct device_node *np
 	tegra->hw.init = &init;
 
 	clk = clk_register(NULL, &tegra->hw);
-	if (IS_ERR(clk))
+	if (IS_ERR(clk)) {
+		kfree(tegra);
 		return clk;
+	}
 
 	tegra->prev_parent = clk_hw_get_parent_by_index(
 		&tegra->hw, emc_get_parent(&tegra->hw))->clk;
-- 
2.51.0


