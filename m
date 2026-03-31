Return-Path: <stable+bounces-232209-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0BsYM1oFzGnPNQYAu9opvQ
	(envelope-from <stable+bounces-232209-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 19:33:14 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C4BD036EE83
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 19:33:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A7F913172926
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 16:56:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAE4A3FADEE;
	Tue, 31 Mar 2026 16:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wLbIlmoy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 764733F7867;
	Tue, 31 Mar 2026 16:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774976158; cv=none; b=RCESposwUTeCS76sE9zurnc/qRjfsctBMBLTizDB1Q+2q8K8oksmVrQ0u0rlZ6WXvrQqkGiAZ53tnuhVfY3h9EnjzkBOnjk9pmgQwYvGUcA1nO6vBG0LAzQ5/uFxfaxMcqisLKHco/JL5pTegQtZ2hoEzyU/RncgD9goXZJz9lU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774976158; c=relaxed/simple;
	bh=dltlIVAfslAH4soztbZI1k9d8IVhrlkZtLpvxZytWjs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EUSJyj+y85dGfa1U5NezFi3rhRK7+jUi+/HW8xEfgrjLqVojXI+BqCwzx+kMRaqHmsfrF7/AeI4rQ9EKmszsMCoxdYzRz9FSNLrx8cTjDpE1+CpHtzFzT+lJFcwqjckH0MJCvNpQ5FblGkggOoHadTzqYfo+TgZk5++eGXfzja8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wLbIlmoy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08D08C19423;
	Tue, 31 Mar 2026 16:55:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774976158;
	bh=dltlIVAfslAH4soztbZI1k9d8IVhrlkZtLpvxZytWjs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=wLbIlmoyoz9oLInWNhAUZBLvxkd5kUfyp8uJzcXOi5Gmpw3iMrk6iKejNFSmVkGNu
	 xAlYwEwiH7M/1UXeqFPl/RTFqYbacSx8y5bJk9FQh0r8cxtpmZCP4kvRtusd0mwri+
	 SUlvVJobNn6lBw1E8GO2UzGaKuMD1WmPq5NBYtb0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Alexander Stein <alexander.stein@ew.tq-group.com>,
	Frank Li <Frank.Li@nxp.com>,
	Vinod Koul <vkoul@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 229/244] dmaengine: xilinx: xdma: Fix regmap init error handling
Date: Tue, 31 Mar 2026 18:22:59 +0200
Message-ID: <20260331161750.222897810@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-232209-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.998];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,msgid.link:url,nxp.com:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,tq-group.com:email]
X-Rspamd-Queue-Id: C4BD036EE83
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alexander Stein <alexander.stein@ew.tq-group.com>

[ Upstream commit e0adbf74e2a0455a6bc9628726ba87bcd0b42bf8 ]

devm_regmap_init_mmio returns an ERR_PTR() upon error, not NULL.
Fix the error check and also fix the error message. Use the error code
from ERR_PTR() instead of the wrong value in ret.

Fixes: 17ce252266c7 ("dmaengine: xilinx: xdma: Add xilinx xdma driver")
Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Link: https://patch.msgid.link/20251014061309.283468-1-alexander.stein@ew.tq-group.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/dma/xilinx/xdma.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/xilinx/xdma.c b/drivers/dma/xilinx/xdma.c
index 2726c7154fcef..6781c6754e65a 100644
--- a/drivers/dma/xilinx/xdma.c
+++ b/drivers/dma/xilinx/xdma.c
@@ -1240,8 +1240,8 @@ static int xdma_probe(struct platform_device *pdev)
 
 	xdev->rmap = devm_regmap_init_mmio(&pdev->dev, reg_base,
 					   &xdma_regmap_config);
-	if (!xdev->rmap) {
-		xdma_err(xdev, "config regmap failed: %d", ret);
+	if (IS_ERR(xdev->rmap)) {
+		xdma_err(xdev, "config regmap failed: %pe", xdev->rmap);
 		goto failed;
 	}
 	INIT_LIST_HEAD(&xdev->dma_dev.channels);
-- 
2.53.0




