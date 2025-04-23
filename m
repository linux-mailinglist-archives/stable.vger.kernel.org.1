Return-Path: <stable+bounces-135491-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 258C9A98E9D
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 16:57:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB15F1B84146
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 14:54:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81D9127D763;
	Wed, 23 Apr 2025 14:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="b+9ia4g3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FBE3481CD;
	Wed, 23 Apr 2025 14:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745420063; cv=none; b=pR8+7a7EWC7kRnCFofu0Z1UlWJBIL7RXU0xjVHyWDTiyrwgJOMycIk2dKBfjyk8L33oPSdiNsiogh1JseyvHDBTDBecX7zIjck5wtTQU8CdD4HXP7OPk/4La5j5obMptGabhriykTW9GHbBPGPUdQgyFg6zsO2gfC/KWb8O2tms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745420063; c=relaxed/simple;
	bh=4lI7BiKDbnVHrKleRdhNrV/rKKpKohdMYK7ndp+Rngg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BzPohO0V+YwI8kb0flyBWMPZw4rE0LhtK+u1tG2hJSHZf0l60mVoLnLI5eRmiwSa6BcGwi3B1YVR738v/5kwzKIqDGvtRGcJVq96RJG3pFaZExk5G4unYhr8tZT4iqVUI3miO7OuVqIfhkkETJYPxpvVfPmIkHqaQxT50+IWKrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=b+9ia4g3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C98B0C4CEE2;
	Wed, 23 Apr 2025 14:54:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745420063;
	bh=4lI7BiKDbnVHrKleRdhNrV/rKKpKohdMYK7ndp+Rngg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=b+9ia4g3p2BZdZzQ7lrljQXQnrokGuzHHWg3kzePZ9KoHRZWXYK5DvXYDOjZRxxuh
	 Qoxq3JJI1ZNBK3ik8FRmM4RCmV4Xfwl5zdVYxKFnlOceJ4E+/aORKpBV/Gt4Ab+KOU
	 D+tCDUbIfFe1dr/fUx4C8Dm1r4lKVWaGpXxphgqU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Chenyuan Yang <chenyuan0y@gmail.com>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.14 056/241] octeontx2-pf: handle otx2_mbox_get_rsp errors
Date: Wed, 23 Apr 2025 16:42:00 +0200
Message-ID: <20250423142622.795902383@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250423142620.525425242@linuxfoundation.org>
References: <20250423142620.525425242@linuxfoundation.org>
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

6.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chenyuan Yang <chenyuan0y@gmail.com>

[ Upstream commit 688abe1027d00b7d4b2ce2d8764a2ae5ec6d250b ]

Adding error pointer check after calling otx2_mbox_get_rsp().

This is similar to the commit bd3110bc102a
("octeontx2-pf: handle otx2_mbox_get_rsp errors in otx2_flows.c").

Signed-off-by: Chenyuan Yang <chenyuan0y@gmail.com>
Fixes: 6c40ca957fe5 ("octeontx2-pf: Adds TC offload support")
Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Link: https://patch.msgid.link/20250412183327.3550970-1-chenyuan0y@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/marvell/octeontx2/nic/rep.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/rep.c b/drivers/net/ethernet/marvell/octeontx2/nic/rep.c
index 04e08e06f30ff..7153a71dfc860 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/rep.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/rep.c
@@ -67,6 +67,8 @@ static int rvu_rep_mcam_flow_init(struct rep_dev *rep)
 
 		rsp = (struct npc_mcam_alloc_entry_rsp *)otx2_mbox_get_rsp
 			(&priv->mbox.mbox, 0, &req->hdr);
+		if (IS_ERR(rsp))
+			goto exit;
 
 		for (ent = 0; ent < rsp->count; ent++)
 			rep->flow_cfg->flow_ent[ent + allocated] = rsp->entry_list[ent];
-- 
2.39.5




