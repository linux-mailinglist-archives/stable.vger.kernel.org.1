Return-Path: <stable+bounces-220439-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sJLME6Y3o2lx+gQAu9opvQ
	(envelope-from <stable+bounces-220439-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:44:54 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 000351C6376
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:44:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DF7DC31CA44A
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:28:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86D7B3B5BF3;
	Sat, 28 Feb 2026 17:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="su/3RFGh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AA513B5BEA;
	Sat, 28 Feb 2026 17:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300328; cv=none; b=EsvaJUBmP9GsCHp08cRTJmyegWWhvu2D3QVu/IyOKmwuWns7rp4gu5sjM40OiPNbKr5klF0XXqKZMCNwkSQ3qpqpBQqNvIoPz0jkg98Q+2c255J9YyjCIfg7tB35cF03en+Jcl0lUmsdO7pyzx3e8ONZt97l8ZhPqPGf/MxdRH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300328; c=relaxed/simple;
	bh=VEKKTeVhlcWLRPYgdIU1LNz+iIYdHus7P0jtbj/SmGw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X1k15kcpXa4ByIVZbSWPJeArl9VTH7lOYFIDojxpwWEDrPMOOpOksGTUPqKt+9aongtI/5i9lkstP/SoXYWrqSP1Ms0C/WG/auONSHeKIQcad4KdIM4U1c2dQZ0r/A+rNmkAFOcDDdiD8pJ9/iIDt0gKN17xxHRM6eRLNRfLsj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=su/3RFGh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97862C19423;
	Sat, 28 Feb 2026 17:38:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300328;
	bh=VEKKTeVhlcWLRPYgdIU1LNz+iIYdHus7P0jtbj/SmGw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=su/3RFGh16VfYOxbgJ7C3IeTG1fYW8DrqQzcDthuTiGrXpcisVUaQyfVIAyjsUfIb
	 xFrGnzlb1XbdV+sM7ZxN8dE+A4KeTzqN5MAz/g8QfDEWP8r0JuRS1Np1FrE9eBOcPf
	 woAtce8j+t9M3LJkTrnMh2nanADd34BttOZVaviLv1ZbIagjOWklH+snRzX1lZum+O
	 q/1Na5j0zYEuVJrdCQfXwZBCbunJqdxKz2Yx9y+wD2S776FcGhoThPwt5ERRQmCQ+V
	 +p6KuMbMISt3fJfibUeuoUYLwHO72p/HDg5LGhMHTBQrikKH6JQ68F6DO53uIAinZU
	 2upNoqCAJKsnw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 360/844] clk: renesas: rzg2l: Deassert reset on assert timeout
Date: Sat, 28 Feb 2026 12:24:33 -0500
Message-ID: <20260228173244.1509663-361-sashal@kernel.org>
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
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-220439-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.983];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,renesas];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 000351C6376
X-Rspamd-Action: no action

From: Biju Das <biju.das.jz@bp.renesas.com>

[ Upstream commit 0b0201f259e1158a875c5fd01adf318ae5d32352 ]

If the assert() fails due to timeout error, set the reset register bit
back to deasserted state. This change is needed especially for handling
assert error in suspend() callback that expect the device to be in
operational state in case of failure.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/20260108123433.104464-2-biju.das.jz@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/renesas/rzg2l-cpg.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/renesas/rzg2l-cpg.c b/drivers/clk/renesas/rzg2l-cpg.c
index 64d1ef6e4c943..c20ea1212b360 100644
--- a/drivers/clk/renesas/rzg2l-cpg.c
+++ b/drivers/clk/renesas/rzg2l-cpg.c
@@ -1647,6 +1647,7 @@ static int __rzg2l_cpg_assert(struct reset_controller_dev *rcdev,
 	u32 mask = BIT(info->resets[id].bit);
 	s8 monbit = info->resets[id].monbit;
 	u32 value = mask << 16;
+	u32 mon;
 	int ret;
 
 	dev_dbg(rcdev->dev, "%s id:%ld offset:0x%x\n",
@@ -1667,10 +1668,10 @@ static int __rzg2l_cpg_assert(struct reset_controller_dev *rcdev,
 		return 0;
 	}
 
-	ret = readl_poll_timeout_atomic(priv->base + reg, value,
-					assert == !!(value & mask), 10, 200);
-	if (ret && !assert) {
-		value = mask << 16;
+	ret = readl_poll_timeout_atomic(priv->base + reg, mon,
+					assert == !!(mon & mask), 10, 200);
+	if (ret) {
+		value ^= mask;
 		writel(value, priv->base + CLK_RST_R(info->resets[id].off));
 	}
 
-- 
2.51.0


