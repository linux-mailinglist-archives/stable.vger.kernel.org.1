Return-Path: <stable+bounces-231622-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ePmyCNr4y2lENAYAu9opvQ
	(envelope-from <stable+bounces-231622-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 18:39:54 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E17A36CEBC
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 18:39:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1817E31F2FAB
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 16:31:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C6A141B373;
	Tue, 31 Mar 2026 16:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WmD3EmzQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E431C23507B;
	Tue, 31 Mar 2026 16:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774974644; cv=none; b=ZRj2KtR1uFkrTWEFB0lWW2xeiwxItYPDF0N89djaVcxMri33iWrxo6R/ZV9ehJ0BsCnNpDgiAChOlfJYCm5pFdENsSMjhbdeipHserkeqQ9zFWfRq1aMwSuGpvuTr/ZEFUbzFcL2Mp8mCHKz1G6brsUJFsPmZx8SBMDpTu8uCzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774974644; c=relaxed/simple;
	bh=dORJhiELTJDyrrlOlzrda6rVUdZe8zFaYU6zFnZ3C4U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VfaUbeev3/IQf3Xv/2+V3yvt/x92W8o44BXXsb5uTFHtxxtNdlINm15QqlvMVbSlvpbt8UyuSkWT2VyUPycmCycrMRtofWjynJi4Qujv3Dii4HP6q7xZLvnoIy54Y0lqCSHs4smdzgq9HqW1tp+9XgP7AOa+FT5aOiwRJ4owe1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WmD3EmzQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B1D9C19423;
	Tue, 31 Mar 2026 16:30:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774974643;
	bh=dORJhiELTJDyrrlOlzrda6rVUdZe8zFaYU6zFnZ3C4U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WmD3EmzQIBcTYP6Ogkmxw/KiLx7AdA4ILjOvSV/yOvhICyIFJs2xzIrY7yJq1izx0
	 tCpika5uLNwPHE2KYUqPZV6ypyLvwFLcoC3k3hVqBOswCymp1srggRQgdhs+I/5Gop
	 ifYmd+tQe7Z6dSZfCBGR3z6pg5Y5EpymSUrJe3yE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Alexander Stein <alexander.stein@ew.tq-group.com>,
	Frank Li <Frank.Li@nxp.com>,
	Vinod Koul <vkoul@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 164/175] dmaengine: xilinx: xdma: Fix regmap init error handling
Date: Tue, 31 Mar 2026 18:22:28 +0200
Message-ID: <20260331161735.821602130@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260331161729.779738837@linuxfoundation.org>
References: <20260331161729.779738837@linuxfoundation.org>
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
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-231622-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.998];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,nxp.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:mid]
X-Rspamd-Queue-Id: 7E17A36CEBC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.6-stable review patch.  If anyone has any objections, please let me know.

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
index dbab4c4499143..d806bb1162aef 100644
--- a/drivers/dma/xilinx/xdma.c
+++ b/drivers/dma/xilinx/xdma.c
@@ -901,8 +901,8 @@ static int xdma_probe(struct platform_device *pdev)
 
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




