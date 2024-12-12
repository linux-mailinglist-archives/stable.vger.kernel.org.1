Return-Path: <stable+bounces-101459-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B41FE9EEC8B
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 16:35:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 322AA188289D
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 15:33:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8080215774;
	Thu, 12 Dec 2024 15:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qxbGUgQR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67A826F2FE;
	Thu, 12 Dec 2024 15:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734017622; cv=none; b=b+T9AdcVZuret9/udiIrOiRNRMD6JBOoHvBHZ9fzEmW7+tb5+1SXVgQNbmi81t/yXb95Nvkgw7zgD8UHaAU+63wKd93TYRiPKrhJ9iNnjazo948Qqbadf16Nz3RpgCP5pmEQkgOSFmQET2BK2o3ozDucDXTtBzNoXKw11XyOuuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734017622; c=relaxed/simple;
	bh=/QgT0j4RPSMXNeFemPc04WkYNQ4RpRGkgwcJ0JhDarE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RZr7DhF8CMWdt3cp+guR0fFOfW+LDnyvX8vY9EiePpjBV/ogdIsxwu0Cjf1pcgIzuLetSH6qffUh3sqjbFopJ6g707ioW5HfW9PhpxEYCQOQhpxyB4dw9Ywrooa4q01f4QYhXx4sQxbiMEmjTdfR9yCf5+o7YaC7FZyTG9pLJKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qxbGUgQR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79440C4CECE;
	Thu, 12 Dec 2024 15:33:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734017622;
	bh=/QgT0j4RPSMXNeFemPc04WkYNQ4RpRGkgwcJ0JhDarE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qxbGUgQR+GE6PsDwxQVgEohfcDL6iQ/SZJpmN7Q6XnRALgrYy7wIb2KlQCyqYO1hR
	 /F1LB6fdkWjN5olees02p6AemPZn+M4+GI0q/sReBda/AsxCNMs+rrcyuVWjfwLYgJ
	 FiXiMDM+TvNnwM//fLJPWQykNrifVgTMRp76A3hE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Alexandra Winter <wintera@linux.ibm.com>,
	Wen Gu <guwen@linux.alibaba.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 035/356] net/smc: introduce sub-functions for smc_clc_send_confirm_accept()
Date: Thu, 12 Dec 2024 15:55:54 +0100
Message-ID: <20241212144246.015345100@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241212144244.601729511@linuxfoundation.org>
References: <20241212144244.601729511@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Wen Gu <guwen@linux.alibaba.com>

[ Upstream commit 5205ac4483b630e47c65f192a3ac19be7a8ea648 ]

There is a large if-else block in smc_clc_send_confirm_accept() and it
is better to split it into two sub-functions.

Suggested-by: Alexandra Winter <wintera@linux.ibm.com>
Signed-off-by: Wen Gu <guwen@linux.alibaba.com>
Reviewed-by: Alexandra Winter <wintera@linux.ibm.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Stable-dep-of: 0541db8ee32c ("net/smc: initialize close_work early to avoid warning")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/smc/smc_clc.c | 197 +++++++++++++++++++++++++++-------------------
 1 file changed, 115 insertions(+), 82 deletions(-)

diff --git a/net/smc/smc_clc.c b/net/smc/smc_clc.c
index b34aff73ada4c..d471a06baac32 100644
--- a/net/smc/smc_clc.c
+++ b/net/smc/smc_clc.c
@@ -1007,6 +1007,112 @@ int smc_clc_send_proposal(struct smc_sock *smc, struct smc_init_info *ini)
 	return reason_code;
 }
 
+static void
+smcd_clc_prep_confirm_accept(struct smc_connection *conn,
+			     struct smc_clc_msg_accept_confirm_v2 *clc_v2,
+			     int first_contact, u8 version,
+			     u8 *eid, struct smc_init_info *ini,
+			     int *fce_len,
+			     struct smc_clc_first_contact_ext_v2x *fce_v2x,
+			     struct smc_clc_msg_trail *trl)
+{
+	struct smcd_dev *smcd = conn->lgr->smcd;
+	struct smc_clc_msg_accept_confirm *clc;
+	int len;
+
+	/* SMC-D specific settings */
+	clc = (struct smc_clc_msg_accept_confirm *)clc_v2;
+	memcpy(clc->hdr.eyecatcher, SMCD_EYECATCHER,
+	       sizeof(SMCD_EYECATCHER));
+	clc->hdr.typev1 = SMC_TYPE_D;
+	clc->d0.gid = htonll(smcd->ops->get_local_gid(smcd));
+	clc->d0.token = htonll(conn->rmb_desc->token);
+	clc->d0.dmbe_size = conn->rmbe_size_comp;
+	clc->d0.dmbe_idx = 0;
+	memcpy(&clc->d0.linkid, conn->lgr->id, SMC_LGR_ID_SIZE);
+	if (version == SMC_V1) {
+		clc->hdr.length = htons(SMCD_CLC_ACCEPT_CONFIRM_LEN);
+	} else {
+		clc_v2->d1.chid = htons(smc_ism_get_chid(smcd));
+		if (eid && eid[0])
+			memcpy(clc_v2->d1.eid, eid, SMC_MAX_EID_LEN);
+		len = SMCD_CLC_ACCEPT_CONFIRM_LEN_V2;
+		if (first_contact) {
+			*fce_len = smc_clc_fill_fce_v2x(fce_v2x, ini);
+			len += *fce_len;
+		}
+		clc_v2->hdr.length = htons(len);
+	}
+	memcpy(trl->eyecatcher, SMCD_EYECATCHER,
+	       sizeof(SMCD_EYECATCHER));
+}
+
+static void
+smcr_clc_prep_confirm_accept(struct smc_connection *conn,
+			     struct smc_clc_msg_accept_confirm_v2 *clc_v2,
+			     int first_contact, u8 version,
+			     u8 *eid, struct smc_init_info *ini,
+			     int *fce_len,
+			     struct smc_clc_first_contact_ext_v2x *fce_v2x,
+			     struct smc_clc_fce_gid_ext *gle,
+			     struct smc_clc_msg_trail *trl)
+{
+	struct smc_clc_msg_accept_confirm *clc;
+	struct smc_link *link = conn->lnk;
+	int len;
+
+	/* SMC-R specific settings */
+	clc = (struct smc_clc_msg_accept_confirm *)clc_v2;
+	memcpy(clc->hdr.eyecatcher, SMC_EYECATCHER,
+	       sizeof(SMC_EYECATCHER));
+	clc->hdr.typev1 = SMC_TYPE_R;
+	memcpy(clc->r0.lcl.id_for_peer, local_systemid,
+	       sizeof(local_systemid));
+	memcpy(&clc->r0.lcl.gid, link->gid, SMC_GID_SIZE);
+	memcpy(&clc->r0.lcl.mac, &link->smcibdev->mac[link->ibport - 1],
+	       ETH_ALEN);
+	hton24(clc->r0.qpn, link->roce_qp->qp_num);
+	clc->r0.rmb_rkey =
+		htonl(conn->rmb_desc->mr[link->link_idx]->rkey);
+	clc->r0.rmbe_idx = 1; /* for now: 1 RMB = 1 RMBE */
+	clc->r0.rmbe_alert_token = htonl(conn->alert_token_local);
+	switch (clc->hdr.type) {
+	case SMC_CLC_ACCEPT:
+		clc->r0.qp_mtu = link->path_mtu;
+		break;
+	case SMC_CLC_CONFIRM:
+		clc->r0.qp_mtu = min(link->path_mtu, link->peer_mtu);
+		break;
+	}
+	clc->r0.rmbe_size = conn->rmbe_size_comp;
+	clc->r0.rmb_dma_addr = conn->rmb_desc->is_vm ?
+		cpu_to_be64((uintptr_t)conn->rmb_desc->cpu_addr) :
+		cpu_to_be64((u64)sg_dma_address
+			    (conn->rmb_desc->sgt[link->link_idx].sgl));
+	hton24(clc->r0.psn, link->psn_initial);
+	if (version == SMC_V1) {
+		clc->hdr.length = htons(SMCR_CLC_ACCEPT_CONFIRM_LEN);
+	} else {
+		if (eid && eid[0])
+			memcpy(clc_v2->r1.eid, eid, SMC_MAX_EID_LEN);
+		len = SMCR_CLC_ACCEPT_CONFIRM_LEN_V2;
+		if (first_contact) {
+			*fce_len = smc_clc_fill_fce_v2x(fce_v2x, ini);
+			len += *fce_len;
+			fce_v2x->fce_v2_base.v2_direct =
+				!link->lgr->uses_gateway;
+			if (clc->hdr.type == SMC_CLC_CONFIRM) {
+				memset(gle, 0, sizeof(*gle));
+				gle->gid_cnt = ini->smcrv2.gidlist.len;
+				len += sizeof(*gle);
+				len += gle->gid_cnt * sizeof(gle->gid[0]);
+			}
+		}
+		clc_v2->hdr.length = htons(len);
+	}
+	memcpy(trl->eyecatcher, SMC_EYECATCHER, sizeof(SMC_EYECATCHER));
+}
+
 /* build and send CLC CONFIRM / ACCEPT message */
 static int smc_clc_send_confirm_accept(struct smc_sock *smc,
 				       struct smc_clc_msg_accept_confirm_v2 *clc_v2,
@@ -1015,11 +1121,10 @@ static int smc_clc_send_confirm_accept(struct smc_sock *smc,
 {
 	struct smc_clc_first_contact_ext_v2x fce_v2x;
 	struct smc_connection *conn = &smc->conn;
-	struct smcd_dev *smcd = conn->lgr->smcd;
 	struct smc_clc_msg_accept_confirm *clc;
 	struct smc_clc_fce_gid_ext gle;
 	struct smc_clc_msg_trail trl;
-	int i, len, fce_len;
+	int i, fce_len;
 	struct kvec vec[5];
 	struct msghdr msg;
 
@@ -1028,86 +1133,14 @@ static int smc_clc_send_confirm_accept(struct smc_sock *smc,
 	clc->hdr.version = version;	/* SMC version */
 	if (first_contact)
 		clc->hdr.typev2 |= SMC_FIRST_CONTACT_MASK;
-	if (conn->lgr->is_smcd) {
-		/* SMC-D specific settings */
-		memcpy(clc->hdr.eyecatcher, SMCD_EYECATCHER,
-		       sizeof(SMCD_EYECATCHER));
-		clc->hdr.typev1 = SMC_TYPE_D;
-		clc->d0.gid = htonll(smcd->ops->get_local_gid(smcd));
-		clc->d0.token = htonll(conn->rmb_desc->token);
-		clc->d0.dmbe_size = conn->rmbe_size_comp;
-		clc->d0.dmbe_idx = 0;
-		memcpy(&clc->d0.linkid, conn->lgr->id, SMC_LGR_ID_SIZE);
-		if (version == SMC_V1) {
-			clc->hdr.length = htons(SMCD_CLC_ACCEPT_CONFIRM_LEN);
-		} else {
-			clc_v2->d1.chid = htons(smc_ism_get_chid(smcd));
-			if (eid && eid[0])
-				memcpy(clc_v2->d1.eid, eid, SMC_MAX_EID_LEN);
-			len = SMCD_CLC_ACCEPT_CONFIRM_LEN_V2;
-			if (first_contact) {
-				fce_len = smc_clc_fill_fce_v2x(&fce_v2x, ini);
-				len += fce_len;
-			}
-			clc_v2->hdr.length = htons(len);
-		}
-		memcpy(trl.eyecatcher, SMCD_EYECATCHER,
-		       sizeof(SMCD_EYECATCHER));
-	} else {
-		struct smc_link *link = conn->lnk;
-
-		/* SMC-R specific settings */
-		memcpy(clc->hdr.eyecatcher, SMC_EYECATCHER,
-		       sizeof(SMC_EYECATCHER));
-		clc->hdr.typev1 = SMC_TYPE_R;
-		clc->hdr.length = htons(SMCR_CLC_ACCEPT_CONFIRM_LEN);
-		memcpy(clc->r0.lcl.id_for_peer, local_systemid,
-		       sizeof(local_systemid));
-		memcpy(&clc->r0.lcl.gid, link->gid, SMC_GID_SIZE);
-		memcpy(&clc->r0.lcl.mac, &link->smcibdev->mac[link->ibport - 1],
-		       ETH_ALEN);
-		hton24(clc->r0.qpn, link->roce_qp->qp_num);
-		clc->r0.rmb_rkey =
-			htonl(conn->rmb_desc->mr[link->link_idx]->rkey);
-		clc->r0.rmbe_idx = 1; /* for now: 1 RMB = 1 RMBE */
-		clc->r0.rmbe_alert_token = htonl(conn->alert_token_local);
-		switch (clc->hdr.type) {
-		case SMC_CLC_ACCEPT:
-			clc->r0.qp_mtu = link->path_mtu;
-			break;
-		case SMC_CLC_CONFIRM:
-			clc->r0.qp_mtu = min(link->path_mtu, link->peer_mtu);
-			break;
-		}
-		clc->r0.rmbe_size = conn->rmbe_size_comp;
-		clc->r0.rmb_dma_addr = conn->rmb_desc->is_vm ?
-			cpu_to_be64((uintptr_t)conn->rmb_desc->cpu_addr) :
-			cpu_to_be64((u64)sg_dma_address
-				    (conn->rmb_desc->sgt[link->link_idx].sgl));
-		hton24(clc->r0.psn, link->psn_initial);
-		if (version == SMC_V1) {
-			clc->hdr.length = htons(SMCR_CLC_ACCEPT_CONFIRM_LEN);
-		} else {
-			if (eid && eid[0])
-				memcpy(clc_v2->r1.eid, eid, SMC_MAX_EID_LEN);
-			len = SMCR_CLC_ACCEPT_CONFIRM_LEN_V2;
-			if (first_contact) {
-				fce_len = smc_clc_fill_fce_v2x(&fce_v2x, ini);
-				len += fce_len;
-				fce_v2x.fce_v2_base.v2_direct =
-					!link->lgr->uses_gateway;
-				if (clc->hdr.type == SMC_CLC_CONFIRM) {
-					memset(&gle, 0, sizeof(gle));
-					gle.gid_cnt = ini->smcrv2.gidlist.len;
-					len += sizeof(gle);
-					len += gle.gid_cnt * sizeof(gle.gid[0]);
-				}
-			}
-			clc_v2->hdr.length = htons(len);
-		}
-		memcpy(trl.eyecatcher, SMC_EYECATCHER, sizeof(SMC_EYECATCHER));
-	}
-
+	if (conn->lgr->is_smcd)
+		smcd_clc_prep_confirm_accept(conn, clc_v2, first_contact,
+					     version, eid, ini, &fce_len,
+					     &fce_v2x, &trl);
+	else
+		smcr_clc_prep_confirm_accept(conn, clc_v2, first_contact,
+					     version, eid, ini, &fce_len,
+					     &fce_v2x, &gle, &trl);
 	memset(&msg, 0, sizeof(msg));
 	i = 0;
 	vec[i].iov_base = clc_v2;
-- 
2.43.0




