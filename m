Return-Path: <stable+bounces-6062-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1098480D88D
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 19:46:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC3BE1F217D5
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 18:46:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF0C151C2B;
	Mon, 11 Dec 2023 18:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xTIihvg9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DDACC8C8;
	Mon, 11 Dec 2023 18:46:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03D83C433C7;
	Mon, 11 Dec 2023 18:46:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702320409;
	bh=uf/83bmOn6xDDpNEf3eQW5s+duaxzPm9kUkbLiFg68Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=xTIihvg9vQhVQ9RKmAixFgWYiuM6ad4XqRSyvw+bLocC0ZDiOmogLSuTpHrixACi3
	 EeCfdQkkXScaxbB69nW+QbHF3Ql2iANb+V1gKJy4yyrJAvjAF4tCtCnDtfwtxAPp0K
	 pPTT5NlELL8BeMdUXenwzoe5HQbYw6atMMiFw6LE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Subbaraya Sundeep <sbhatta@marvell.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 022/194] octeontx2-af: Check return value of nix_get_nixlf before using nixlf
Date: Mon, 11 Dec 2023 19:20:12 +0100
Message-ID: <20231211182037.583991347@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231211182036.606660304@linuxfoundation.org>
References: <20231211182036.606660304@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Subbaraya Sundeep <sbhatta@marvell.com>

[ Upstream commit 830139e7b6911266a84a77e1f18abf758995cc89 ]

If a NIXLF is not attached to a PF/VF device then
nix_get_nixlf function fails and returns proper error
code. But npc_get_default_entry_action does not check it
and uses garbage value in subsequent calls. Fix this
by cheking the return value of nix_get_nixlf.

Fixes: 967db3529eca ("octeontx2-af: add support for multicast/promisc packet replication feature")
Signed-off-by: Subbaraya Sundeep <sbhatta@marvell.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
index 16cfc802e348d..f65805860c8d4 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
@@ -389,7 +389,13 @@ static u64 npc_get_default_entry_action(struct rvu *rvu, struct npc_mcam *mcam,
 	int bank, nixlf, index;
 
 	/* get ucast entry rule entry index */
-	nix_get_nixlf(rvu, pf_func, &nixlf, NULL);
+	if (nix_get_nixlf(rvu, pf_func, &nixlf, NULL)) {
+		dev_err(rvu->dev, "%s: nixlf not attached to pcifunc:0x%x\n",
+			__func__, pf_func);
+		/* Action 0 is drop */
+		return 0;
+	}
+
 	index = npc_get_nixlf_mcam_index(mcam, pf_func, nixlf,
 					 NIXLF_UCAST_ENTRY);
 	bank = npc_get_bank(mcam, index);
-- 
2.42.0




