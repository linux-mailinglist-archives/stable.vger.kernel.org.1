Return-Path: <stable+bounces-221012-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uGYtMQ5do2nW/AQAu9opvQ
	(envelope-from <stable+bounces-221012-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 22:24:30 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3898E1C9002
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 22:24:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 060083448B01
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:45:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4D6F47CC89;
	Sat, 28 Feb 2026 17:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rgq9T6CR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6656C4BCAA0;
	Sat, 28 Feb 2026 17:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772301355; cv=none; b=gZng4HIx26dRCfVhzzfqtkUC24eUm7ro9tlvOLmCAtA/xPYpwfg8qwfx348A2dTx++8ITkGP0MQS7WzVo33tWfzggvnKqre7GdprXboSevNpbtd0aYI1sSy6PM+tw/0knCqDrQq6iuuK7wM3Jn+aDLwtbrerZO5WP9FdU9zKtfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772301355; c=relaxed/simple;
	bh=9cr3n3gmMpWWaSZjZA2afqSrWBNC6bCrHzSRJ4+2g74=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ho78vK+8xCVJW48wwzyZORLXKIemrPB9RFQKy0v0wgK3LABZmxtV5YK6FFgGCT3rCUYTxMSryxk8FKk7odJ3Ou0IqafEmc0RweG+iADTIAGpXar4hy8quWQ+R1mSD0XEPHCB/47qnwX/WAj5KMBeITOTl41Q3ecfYbae7u51REY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rgq9T6CR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B08F4C19423;
	Sat, 28 Feb 2026 17:55:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772301355;
	bh=9cr3n3gmMpWWaSZjZA2afqSrWBNC6bCrHzSRJ4+2g74=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Rgq9T6CR1RFcHZvjYx/WB08+6wSuBTzOCN7QFfN7pc31LfG2rVX9SJtPg413HsuWp
	 dBSF5P/38W5JAyBKtnWL2xzPwgVBKCb20eB15Fd4NuU0MDeDhnac9hJQcpR8aaiifz
	 UGoGqgTCZPqQT2bPS+IvEueHDNPfUdtrg+vueSvd6T9LActMu1yEPO1KineS0YNBjn
	 6q50Dj0dQKYvwdcVjg2dAFMzCgI0SwU7QlZS/YOG6pr2aLob2Zvrbc6yxiUi+Foo9/
	 sP01+466UH+84i0kSfEJ1XRsauRH1TgLIJECWClQkw1/k7HPA/BL1xhCxl73zab4FL
	 wkBXke4eKCMxQ==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev
Cc: Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org,
	Nishanth Menon <nm@ti.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 543/752] soc: ti: pruss: Fix double free in pruss_clk_mux_setup()
Date: Sat, 28 Feb 2026 12:44:14 -0500
Message-ID: <20260228174750.1542406-543-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228174750.1542406-1-sashal@kernel.org>
References: <20260228174750.1542406-1-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-221012-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ti.com:email,msgid.link:url,iscas.ac.cn:email]
X-Rspamd-Queue-Id: 3898E1C9002
X-Rspamd-Action: no action

From: Wentao Liang <vulab@iscas.ac.cn>

[ Upstream commit 80db65d4acfb9ff12d00172aed39ea8b98261aad ]

In the pruss_clk_mux_setup(), the devm_add_action_or_reset() indirectly
calls pruss_of_free_clk_provider(), which calls of_node_put(clk_mux_np)
on the error path. However, after the devm_add_action_or_reset()
returns, the of_node_put(clk_mux_np) is called again, causing a double
free.

Fix by returning directly, to avoid the duplicate of_node_put().

Fixes: ba59c9b43c86 ("soc: ti: pruss: support CORECLK_MUX and IEPCLK_MUX")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
Link: https://patch.msgid.link/20260113014716.2464741-1-vulab@iscas.ac.cn
Signed-off-by: Nishanth Menon <nm@ti.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/soc/ti/pruss.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/soc/ti/pruss.c b/drivers/soc/ti/pruss.c
index 038576805bfa0..0fd59c73f585d 100644
--- a/drivers/soc/ti/pruss.c
+++ b/drivers/soc/ti/pruss.c
@@ -366,12 +366,10 @@ static int pruss_clk_mux_setup(struct pruss *pruss, struct clk *clk_mux,
 
 	ret = devm_add_action_or_reset(dev, pruss_of_free_clk_provider,
 				       clk_mux_np);
-	if (ret) {
+	if (ret)
 		dev_err(dev, "failed to add clkmux free action %d", ret);
-		goto put_clk_mux_np;
-	}
 
-	return 0;
+	return ret;
 
 put_clk_mux_np:
 	of_node_put(clk_mux_np);
-- 
2.51.0


