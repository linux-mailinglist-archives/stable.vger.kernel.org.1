Return-Path: <stable+bounces-209691-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CA8ED27514
	for <lists+stable@lfdr.de>; Thu, 15 Jan 2026 19:18:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EF22630FB4BA
	for <lists+stable@lfdr.de>; Thu, 15 Jan 2026 17:56:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00C313E8C59;
	Thu, 15 Jan 2026 17:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xJYzdTZ6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B60463E8C51;
	Thu, 15 Jan 2026 17:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768499416; cv=none; b=f0/vduQHVGivQUNSfJZcTUXAb86va3UstRiSbzfM359i7D6res82UYck3dvlkOaSp1De0r5hKeJk8FNJZZPUccbhAz2lfn3/Oz8zeafGVG5gLVTA6Bc7/ma+oR3xvx/iSNirHYXkaNBxKSUp9Rk1jnYbKtPOX/VPxA54Ouimtm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768499416; c=relaxed/simple;
	bh=EdhMw2RMnDFA1/DC98RMY+vi6E0eP+LuWpZhexbPxlY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r7vIqUTwggkLcC1peNXYfvPlGvXeYVey103wtZWCzmP1VExwLtdNg0Jv5kUvvYRmX5WgysViTA3WNZOWbktFoKJvVNU1pgI6fXRHsCqcW49AljnpOaQCdSmI+n2M8dOAGL/Md3G8Yb7CJYPz1ouMi+MfvK5sNa7qM0VJ/ocGLRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xJYzdTZ6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 367AEC19425;
	Thu, 15 Jan 2026 17:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1768499416;
	bh=EdhMw2RMnDFA1/DC98RMY+vi6E0eP+LuWpZhexbPxlY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=xJYzdTZ6i/4kvhpZI83Le1hphQhKPLfEfs82k981kAKLWyg2bW2YCc5UnvKGDSOuI
	 XGsjkQPYLQoXADweRh1Z8cMm1+sRJRZyU14akUcNccaCajfAbjiSY0TRM27fM8g0ec
	 Iv4REPravxoDMcSE6s2A1NLwe2mPMm+Q1mBUrkEU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Justin Tee <justin.tee@broadcom.com>,
	Christoph Hellwig <hch@lst.de>,
	Daniel Wagner <wagi@kernel.org>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 219/451] nvme-fc: dont hold rport lock when putting ctrl
Date: Thu, 15 Jan 2026 17:47:00 +0100
Message-ID: <20260115164238.821426188@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260115164230.864985076@linuxfoundation.org>
References: <20260115164230.864985076@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Daniel Wagner <wagi@kernel.org>

[ Upstream commit b71cbcf7d170e51148d5467820ae8a72febcb651 ]

nvme_fc_ctrl_put can acquire the rport lock when freeing the
ctrl object:

nvme_fc_ctrl_put
  nvme_fc_ctrl_free
    spin_lock_irqsave(rport->lock)

Thus we can't hold the rport lock when calling nvme_fc_ctrl_put.

Justin suggested use the safe list iterator variant because
nvme_fc_ctrl_put will also modify the rport->list.

Cc: Justin Tee <justin.tee@broadcom.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Daniel Wagner <wagi@kernel.org>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/fc.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index e37e7207c60c..dbc9173ec0f8 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -1500,14 +1500,14 @@ nvme_fc_match_disconn_ls(struct nvme_fc_rport *rport,
 {
 	struct fcnvme_ls_disconnect_assoc_rqst *rqst =
 					&lsop->rqstbuf->rq_dis_assoc;
-	struct nvme_fc_ctrl *ctrl, *ret = NULL;
+	struct nvme_fc_ctrl *ctrl, *tmp, *ret = NULL;
 	struct nvmefc_ls_rcv_op *oldls = NULL;
 	u64 association_id = be64_to_cpu(rqst->associd.association_id);
 	unsigned long flags;
 
 	spin_lock_irqsave(&rport->lock, flags);
 
-	list_for_each_entry(ctrl, &rport->ctrl_list, ctrl_list) {
+	list_for_each_entry_safe(ctrl, tmp, &rport->ctrl_list, ctrl_list) {
 		if (!nvme_fc_ctrl_get(ctrl))
 			continue;
 		spin_lock(&ctrl->lock);
@@ -1520,7 +1520,9 @@ nvme_fc_match_disconn_ls(struct nvme_fc_rport *rport,
 		if (ret)
 			/* leave the ctrl get reference */
 			break;
+		spin_unlock_irqrestore(&rport->lock, flags);
 		nvme_fc_ctrl_put(ctrl);
+		spin_lock_irqsave(&rport->lock, flags);
 	}
 
 	spin_unlock_irqrestore(&rport->lock, flags);
-- 
2.51.0




