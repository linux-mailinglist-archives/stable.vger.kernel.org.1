Return-Path: <stable+bounces-133716-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E727A92703
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 20:18:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A85EF19069AB
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 18:18:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 332D21EB1BF;
	Thu, 17 Apr 2025 18:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="exktLBgd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E68903594D;
	Thu, 17 Apr 2025 18:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744913926; cv=none; b=L77aCnJzzVFG+IYNl8cMoLyX6zLwxcht9d+0bUGI4INIoxGVJO3J3T4Tn3JLfa2uGdsZmYl3YxGVEIF0Ryp6Ds9tk4boSW3cSumZIQ7PY8oaA+hU0WuYibUXVy/jFLRB5YokuXaUoOPpR+BL69dAMV8rpmRgf+F0BYsBBE2HpKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744913926; c=relaxed/simple;
	bh=g2LRLD8FDnwAGQBZAE+kRlj59wCW0xybcnweT/thgTU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ie9OikS6pObk1p8CHB+6/J9r/0l40qc6bjNtjaMFg4FJHdsSEgFWoUpufXZS/u+w6CYY7Cx7K+aQ3SyTJhjHkeDOVSmojh1dvuq+RSea4gU7Y1ylP+VLqodVZ9JVkVS/8gR1NJY0Sc4XCFRZk4scX/dGEBg/T5O7INBgRa9iPLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=exktLBgd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 776FBC4CEE4;
	Thu, 17 Apr 2025 18:18:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744913925;
	bh=g2LRLD8FDnwAGQBZAE+kRlj59wCW0xybcnweT/thgTU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=exktLBgdI5d+Asb9wi52ldHOZtflJtsCEROovAmLTHk/jfhWaA2jgbjV5CvBc/eki
	 uK7CVMe9711yLjs+8pDMGMztbT+ZqcMTQvc9EGgPzDPu9qjnMxH7LzgjzbbhSKbHJA
	 9hLo9VvGw1NmoTaP3qGzKaiYK8V0iax/Xo5EQiBs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Hariprasad Kelam <hkelam@marvell.com>,
	Simon Horman <horms@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.13 017/414] octeontx2-pf: qos: fix VF root node parent queue index
Date: Thu, 17 Apr 2025 19:46:15 +0200
Message-ID: <20250417175112.095998955@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250417175111.386381660@linuxfoundation.org>
References: <20250417175111.386381660@linuxfoundation.org>
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

From: Hariprasad Kelam <hkelam@marvell.com>

[ Upstream commit b7db94734e785e380b0db0f9295e07024f4d42a0 ]

The current code configures the Physical Function (PF) root node at TL1
and the Virtual Function (VF) root node at TL2.

This ensure at any given point of time PF traffic gets more priority.

                    PF root node
                      TL1
                     /  \
                    TL2  TL2 VF root node
                    /     \
                   TL3    TL3
                   /       \
                  TL4      TL4
                  /         \
                 SMQ        SMQ

Due to a bug in the current code, the TL2 parent queue index on the
VF interface is not being configured, leading to 'SMQ Flush' errors

Fixes: 5e6808b4c68d ("octeontx2-pf: Add support for HTB offload")
Signed-off-by: Hariprasad Kelam <hkelam@marvell.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://patch.msgid.link/20250407070341.2765426-1-hkelam@marvell.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/marvell/octeontx2/nic/qos.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/qos.c b/drivers/net/ethernet/marvell/octeontx2/nic/qos.c
index 0f844c14485a0..35acc07bd9648 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/qos.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/qos.c
@@ -165,6 +165,11 @@ static void __otx2_qos_txschq_cfg(struct otx2_nic *pfvf,
 
 		otx2_config_sched_shaping(pfvf, node, cfg, &num_regs);
 	} else if (level == NIX_TXSCH_LVL_TL2) {
+		/* configure parent txschq */
+		cfg->reg[num_regs] = NIX_AF_TL2X_PARENT(node->schq);
+		cfg->regval[num_regs] = (u64)hw->tx_link << 16;
+		num_regs++;
+
 		/* configure link cfg */
 		if (level == pfvf->qos.link_cfg_lvl) {
 			cfg->reg[num_regs] = NIX_AF_TL3_TL2X_LINKX_CFG(node->schq, hw->tx_link);
-- 
2.39.5




