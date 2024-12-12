Return-Path: <stable+bounces-103253-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 098879EF698
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 18:27:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12E1217F27F
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 17:20:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A67792210EA;
	Thu, 12 Dec 2024 17:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ghdvpfWD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6257A1F2381;
	Thu, 12 Dec 2024 17:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734024005; cv=none; b=PrCk7Y6tWaTUdmr81VPOg1z8dFPy5UbG2Jm+me+mY/sNFOpkIJf5mEsqq1UIsO6xD1qujeu7rgWeGASGNIaV9E0zSZgF7EOfXwQMmSAJLstwlNEt5fK3Zvd+EAvYK88k4YRBN3mza/mmiOhxuov7MvXi7rReS0bZsAG1guYkFL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734024005; c=relaxed/simple;
	bh=UEbxrhhqQOC+DOXXLMWWSmE28CKHJQ6KhzP/Fom/VS8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B/qX4v/rDrY+LPX4JOzAmE+ITSGzAC1ktTwxxn9FN9AdYFkcMbK/GFcexrIQSmnjlnFz2SV81CWkoREZgKwW+R+8OBur321PdLLBoF2PwnJ1WNXVzi1QSlKb5JV6YNUum30R8z2MjOwtO4r+fYbXX6W/HwWF/QSFqT/m6ks0Nxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ghdvpfWD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6FEBC4CECE;
	Thu, 12 Dec 2024 17:20:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734024005;
	bh=UEbxrhhqQOC+DOXXLMWWSmE28CKHJQ6KhzP/Fom/VS8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ghdvpfWD4+hSF79aSw2rPVuOumHJRP7nj/rYM//UCHwRZm2vI/kxN2HKVrFSGB89x
	 Gp2Ldw13psuuCL2IZDRpxMfAzzznGK5gvXef/5eXbX40hBwBu/HWvZ4AnitwUvquEB
	 0ip5YQhmCtjz3/QW62djaksMsCIDitnviifVknvA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Subbaraya Sundeep <sbhatta@marvell.com>,
	Sunil Goutham <sgoutham@marvell.com>,
	Rakesh Babu <rsaladi2@marvell.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 125/459] octeontx2-af: Mbox changes for 98xx
Date: Thu, 12 Dec 2024 15:57:43 +0100
Message-ID: <20241212144258.447221363@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241212144253.511169641@linuxfoundation.org>
References: <20241212144253.511169641@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Subbaraya Sundeep <sbhatta@marvell.com>

[ Upstream commit a84cdcea3b4feb46730c88454b5f85e828429c2b ]

This patch puts together all mailbox changes
for 98xx silicon:

Attach ->
Modify resource attach mailbox handler to
request LFs from a block address out of multiple
blocks of same type. If a PF/VF need LFs from two
blocks of same type then attach mbox should be
called twice.

Example:
        struct rsrc_attach *attach;
        .. Allocate memory for message ..
        attach->cptlfs = 3; /* 3 LFs from CPT0 */
        .. Send message ..
        .. Allocate memory for message ..
        attach->modify = 1;
        attach->cpt_blkaddr = BLKADDR_CPT1;
        attach->cptlfs = 2; /* 2 LFs from CPT1 */
        .. Send message ..

Detach ->
Update detach mailbox and its handler to detach
resources from CPT1 and NIX1 blocks.

MSIX ->
Updated the MSIX mailbox and its handler to return
MSIX offsets for the new block CPT1.

Free resources ->
Update free_rsrc mailbox and its handler to return
the free resources count of new blocks NIX1 and CPT1

Links ->
Number of CGX,LBK and SDP links may vary between
platforms. For example, in 98xx number of CGX and LBK
links are more than 96xx. Hence the info about number
of links present in hardware is useful for consumers to
request link configuration properly. This patch sends
this info in nix_lf_alloc_rsp.

Signed-off-by: Subbaraya Sundeep <sbhatta@marvell.com>
Signed-off-by: Sunil Goutham <sgoutham@marvell.com>
Signed-off-by: Rakesh Babu <rsaladi2@marvell.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Stable-dep-of: e26f8eac6bb2 ("octeontx2-pf: handle otx2_mbox_get_rsp errors in otx2_ethtool.c")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../net/ethernet/marvell/octeontx2/af/mbox.h  | 19 ++++-
 .../net/ethernet/marvell/octeontx2/af/rvu.c   | 85 +++++++++++++++----
 .../ethernet/marvell/octeontx2/af/rvu_nix.c   |  4 +
 .../ethernet/marvell/octeontx2/af/rvu_reg.c   |  2 +-
 .../marvell/octeontx2/af/rvu_struct.h         |  2 +
 5 files changed, 94 insertions(+), 18 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
index 263a211294168..f46de8419b770 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
@@ -86,7 +86,7 @@ struct mbox_msghdr {
 #define OTX2_MBOX_REQ_SIG (0xdead)
 #define OTX2_MBOX_RSP_SIG (0xbeef)
 	u16 sig;         /* Signature, for validating corrupted msgs */
-#define OTX2_MBOX_VERSION (0x0001)
+#define OTX2_MBOX_VERSION (0x0007)
 	u16 ver;         /* Version of msg's structure for this ID */
 	u16 next_msgoff; /* Offset of next msg within mailbox region */
 	int rc;          /* Msg process'ed response code */
@@ -271,6 +271,17 @@ struct ready_msg_rsp {
  * or to detach partial of a cetain resource type.
  * Rest of the fields specify how many of what type to
  * be attached.
+ * To request LFs from two blocks of same type this mailbox
+ * can be sent twice as below:
+ *      struct rsrc_attach *attach;
+ *       .. Allocate memory for message ..
+ *       attach->cptlfs = 3; <3 LFs from CPT0>
+ *       .. Send message ..
+ *       .. Allocate memory for message ..
+ *       attach->modify = 1;
+ *       attach->cpt_blkaddr = BLKADDR_CPT1;
+ *       attach->cptlfs = 2; <2 LFs from CPT1>
+ *       .. Send message ..
  */
 struct rsrc_attach {
 	struct mbox_msghdr hdr;
@@ -281,6 +292,7 @@ struct rsrc_attach {
 	u16  ssow;
 	u16  timlfs;
 	u16  cptlfs;
+	int  cpt_blkaddr; /* BLKADDR_CPT0/BLKADDR_CPT1 or 0 for BLKADDR_CPT0 */
 };
 
 /* Structure for relinquishing resources.
@@ -314,6 +326,8 @@ struct msix_offset_rsp {
 	u16  ssow_msixoff[MAX_RVU_BLKLF_CNT];
 	u16  timlf_msixoff[MAX_RVU_BLKLF_CNT];
 	u16  cptlf_msixoff[MAX_RVU_BLKLF_CNT];
+	u8   cpt1_lfs;
+	u16  cpt1_lf_msixoff[MAX_RVU_BLKLF_CNT];
 };
 
 struct get_hw_cap_rsp {
@@ -491,6 +505,9 @@ struct nix_lf_alloc_rsp {
 	u8	lf_tx_stats; /* NIX_AF_CONST1::LF_TX_STATS */
 	u16	cints; /* NIX_AF_CONST2::CINTS */
 	u16	qints; /* NIX_AF_CONST2::QINTS */
+	u8	cgx_links;  /* No. of CGX links present in HW */
+	u8	lbk_links;  /* No. of LBK links present in HW */
+	u8	sdp_links;  /* No. of SDP links present in HW */
 };
 
 /* NIX AQ enqueue msg */
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
index e8a2552fb690a..78309821ce298 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
@@ -1185,6 +1185,8 @@ static int rvu_detach_rsrcs(struct rvu *rvu, struct rsrc_detach *detach,
 				continue;
 			else if ((blkid == BLKADDR_NIX0) && !detach->nixlf)
 				continue;
+			else if ((blkid == BLKADDR_NIX1) && !detach->nixlf)
+				continue;
 			else if ((blkid == BLKADDR_SSO) && !detach->sso)
 				continue;
 			else if ((blkid == BLKADDR_SSOW) && !detach->ssow)
@@ -1193,6 +1195,8 @@ static int rvu_detach_rsrcs(struct rvu *rvu, struct rsrc_detach *detach,
 				continue;
 			else if ((blkid == BLKADDR_CPT0) && !detach->cptlfs)
 				continue;
+			else if ((blkid == BLKADDR_CPT1) && !detach->cptlfs)
+				continue;
 		}
 		rvu_detach_block(rvu, pcifunc, block->type);
 	}
@@ -1242,7 +1246,8 @@ static int rvu_get_nix_blkaddr(struct rvu *rvu, u16 pcifunc)
 	return pfvf->nix_blkaddr;
 }
 
-static int rvu_get_attach_blkaddr(struct rvu *rvu, int blktype, u16 pcifunc)
+static int rvu_get_attach_blkaddr(struct rvu *rvu, int blktype,
+				  u16 pcifunc, struct rsrc_attach *attach)
 {
 	int blkaddr;
 
@@ -1250,6 +1255,14 @@ static int rvu_get_attach_blkaddr(struct rvu *rvu, int blktype, u16 pcifunc)
 	case BLKTYPE_NIX:
 		blkaddr = rvu_get_nix_blkaddr(rvu, pcifunc);
 		break;
+	case BLKTYPE_CPT:
+		if (attach->hdr.ver < RVU_MULTI_BLK_VER)
+			return rvu_get_blkaddr(rvu, blktype, 0);
+		blkaddr = attach->cpt_blkaddr ? attach->cpt_blkaddr :
+			  BLKADDR_CPT0;
+		if (blkaddr != BLKADDR_CPT0 && blkaddr != BLKADDR_CPT1)
+			return -ENODEV;
+		break;
 	default:
 		return rvu_get_blkaddr(rvu, blktype, 0);
 	};
@@ -1260,8 +1273,8 @@ static int rvu_get_attach_blkaddr(struct rvu *rvu, int blktype, u16 pcifunc)
 	return -ENODEV;
 }
 
-static void rvu_attach_block(struct rvu *rvu, int pcifunc,
-			     int blktype, int num_lfs)
+static void rvu_attach_block(struct rvu *rvu, int pcifunc, int blktype,
+			     int num_lfs, struct rsrc_attach *attach)
 {
 	struct rvu_pfvf *pfvf = rvu_get_pfvf(rvu, pcifunc);
 	struct rvu_hwinfo *hw = rvu->hw;
@@ -1273,7 +1286,7 @@ static void rvu_attach_block(struct rvu *rvu, int pcifunc,
 	if (!num_lfs)
 		return;
 
-	blkaddr = rvu_get_attach_blkaddr(rvu, blktype, pcifunc);
+	blkaddr = rvu_get_attach_blkaddr(rvu, blktype, pcifunc, attach);
 	if (blkaddr < 0)
 		return;
 
@@ -1321,7 +1334,8 @@ static int rvu_check_rsrc_availability(struct rvu *rvu,
 
 	/* Only one NIX LF can be attached */
 	if (req->nixlf && !is_blktype_attached(pfvf, BLKTYPE_NIX)) {
-		blkaddr = rvu_get_attach_blkaddr(rvu, BLKTYPE_NIX, pcifunc);
+		blkaddr = rvu_get_attach_blkaddr(rvu, BLKTYPE_NIX,
+						 pcifunc, req);
 		if (blkaddr < 0)
 			return blkaddr;
 		block = &hw->block[blkaddr];
@@ -1383,7 +1397,11 @@ static int rvu_check_rsrc_availability(struct rvu *rvu,
 	}
 
 	if (req->cptlfs) {
-		block = &hw->block[BLKADDR_CPT0];
+		blkaddr = rvu_get_attach_blkaddr(rvu, BLKTYPE_CPT,
+						 pcifunc, req);
+		if (blkaddr < 0)
+			return blkaddr;
+		block = &hw->block[blkaddr];
 		if (req->cptlfs > block->lf.max) {
 			dev_err(&rvu->pdev->dev,
 				"Func 0x%x: Invalid CPTLF req, %d > max %d\n",
@@ -1404,6 +1422,22 @@ static int rvu_check_rsrc_availability(struct rvu *rvu,
 	return -ENOSPC;
 }
 
+static bool rvu_attach_from_same_block(struct rvu *rvu, int blktype,
+				       struct rsrc_attach *attach)
+{
+	int blkaddr, num_lfs;
+
+	blkaddr = rvu_get_attach_blkaddr(rvu, blktype,
+					 attach->hdr.pcifunc, attach);
+	if (blkaddr < 0)
+		return false;
+
+	num_lfs = rvu_get_rsrc_mapcount(rvu_get_pfvf(rvu, attach->hdr.pcifunc),
+					blkaddr);
+	/* Requester already has LFs from given block ? */
+	return !!num_lfs;
+}
+
 int rvu_mbox_handler_attach_resources(struct rvu *rvu,
 				      struct rsrc_attach *attach,
 				      struct msg_rsp *rsp)
@@ -1424,10 +1458,10 @@ int rvu_mbox_handler_attach_resources(struct rvu *rvu,
 
 	/* Now attach the requested resources */
 	if (attach->npalf)
-		rvu_attach_block(rvu, pcifunc, BLKTYPE_NPA, 1);
+		rvu_attach_block(rvu, pcifunc, BLKTYPE_NPA, 1, attach);
 
 	if (attach->nixlf)
-		rvu_attach_block(rvu, pcifunc, BLKTYPE_NIX, 1);
+		rvu_attach_block(rvu, pcifunc, BLKTYPE_NIX, 1, attach);
 
 	if (attach->sso) {
 		/* RVU func doesn't know which exact LF or slot is attached
@@ -1437,25 +1471,30 @@ int rvu_mbox_handler_attach_resources(struct rvu *rvu,
 		 */
 		if (attach->modify)
 			rvu_detach_block(rvu, pcifunc, BLKTYPE_SSO);
-		rvu_attach_block(rvu, pcifunc, BLKTYPE_SSO, attach->sso);
+		rvu_attach_block(rvu, pcifunc, BLKTYPE_SSO,
+				 attach->sso, attach);
 	}
 
 	if (attach->ssow) {
 		if (attach->modify)
 			rvu_detach_block(rvu, pcifunc, BLKTYPE_SSOW);
-		rvu_attach_block(rvu, pcifunc, BLKTYPE_SSOW, attach->ssow);
+		rvu_attach_block(rvu, pcifunc, BLKTYPE_SSOW,
+				 attach->ssow, attach);
 	}
 
 	if (attach->timlfs) {
 		if (attach->modify)
 			rvu_detach_block(rvu, pcifunc, BLKTYPE_TIM);
-		rvu_attach_block(rvu, pcifunc, BLKTYPE_TIM, attach->timlfs);
+		rvu_attach_block(rvu, pcifunc, BLKTYPE_TIM,
+				 attach->timlfs, attach);
 	}
 
 	if (attach->cptlfs) {
-		if (attach->modify)
+		if (attach->modify &&
+		    rvu_attach_from_same_block(rvu, BLKTYPE_CPT, attach))
 			rvu_detach_block(rvu, pcifunc, BLKTYPE_CPT);
-		rvu_attach_block(rvu, pcifunc, BLKTYPE_CPT, attach->cptlfs);
+		rvu_attach_block(rvu, pcifunc, BLKTYPE_CPT,
+				 attach->cptlfs, attach);
 	}
 
 exit:
@@ -1533,7 +1572,7 @@ int rvu_mbox_handler_msix_offset(struct rvu *rvu, struct msg_req *req,
 	struct rvu_hwinfo *hw = rvu->hw;
 	u16 pcifunc = req->hdr.pcifunc;
 	struct rvu_pfvf *pfvf;
-	int lf, slot;
+	int lf, slot, blkaddr;
 
 	pfvf = rvu_get_pfvf(rvu, pcifunc);
 	if (!pfvf->msix.bmap)
@@ -1543,8 +1582,14 @@ int rvu_mbox_handler_msix_offset(struct rvu *rvu, struct msg_req *req,
 	lf = rvu_get_lf(rvu, &hw->block[BLKADDR_NPA], pcifunc, 0);
 	rsp->npa_msixoff = rvu_get_msix_offset(rvu, pfvf, BLKADDR_NPA, lf);
 
-	lf = rvu_get_lf(rvu, &hw->block[BLKADDR_NIX0], pcifunc, 0);
-	rsp->nix_msixoff = rvu_get_msix_offset(rvu, pfvf, BLKADDR_NIX0, lf);
+	/* Get BLKADDR from which LFs are attached to pcifunc */
+	blkaddr = rvu_get_blkaddr(rvu, BLKTYPE_NIX, pcifunc);
+	if (blkaddr < 0) {
+		rsp->nix_msixoff = MSIX_VECTOR_INVALID;
+	} else {
+		lf = rvu_get_lf(rvu, &hw->block[blkaddr], pcifunc, 0);
+		rsp->nix_msixoff = rvu_get_msix_offset(rvu, pfvf, blkaddr, lf);
+	}
 
 	rsp->sso = pfvf->sso;
 	for (slot = 0; slot < rsp->sso; slot++) {
@@ -1573,6 +1618,14 @@ int rvu_mbox_handler_msix_offset(struct rvu *rvu, struct msg_req *req,
 		rsp->cptlf_msixoff[slot] =
 			rvu_get_msix_offset(rvu, pfvf, BLKADDR_CPT0, lf);
 	}
+
+	rsp->cpt1_lfs = pfvf->cpt1_lfs;
+	for (slot = 0; slot < rsp->cpt1_lfs; slot++) {
+		lf = rvu_get_lf(rvu, &hw->block[BLKADDR_CPT1], pcifunc, slot);
+		rsp->cpt1_lf_msixoff[slot] =
+			rvu_get_msix_offset(rvu, pfvf, BLKADDR_CPT1, lf);
+	}
+
 	return 0;
 }
 
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
index fb4b18be503c5..0a69d326f618c 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
@@ -1179,6 +1179,10 @@ int rvu_mbox_handler_nix_lf_alloc(struct rvu *rvu,
 	cfg = rvu_read64(rvu, blkaddr, NIX_AF_CONST2);
 	rsp->qints = ((cfg >> 12) & 0xFFF);
 	rsp->cints = ((cfg >> 24) & 0xFFF);
+	rsp->cgx_links = hw->cgx_links;
+	rsp->lbk_links = hw->lbk_links;
+	rsp->sdp_links = hw->sdp_links;
+
 	return rc;
 }
 
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_reg.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_reg.c
index 9d7c135c79659..e266f0c495595 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_reg.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_reg.c
@@ -35,7 +35,7 @@ static struct hw_reg_map txsch_reg_map[NIX_TXSCH_LVL_CNT] = {
 			      {0x1200, 0x12E0} } },
 	{NIX_TXSCH_LVL_TL3, 3, 0xFFFF, {{0x1000, 0x10E0}, {0x1600, 0x1608},
 			      {0x1610, 0x1618} } },
-	{NIX_TXSCH_LVL_TL2, 2, 0xFFFF, {{0x0E00, 0x0EE0}, {0x1700, 0x1768} } },
+	{NIX_TXSCH_LVL_TL2, 2, 0xFFFF, {{0x0E00, 0x0EE0}, {0x1700, 0x17B0} } },
 	{NIX_TXSCH_LVL_TL1, 1, 0xFFFF, {{0x0C00, 0x0D98} } },
 };
 
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_struct.h b/drivers/net/ethernet/marvell/octeontx2/af/rvu_struct.h
index a3ecb5de90005..761e8e9f5299c 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_struct.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_struct.h
@@ -14,6 +14,8 @@
 /* RVU Block revision IDs */
 #define RVU_BLK_RVUM_REVID		0x01
 
+#define RVU_MULTI_BLK_VER		0x7ULL
+
 /* RVU Block Address Enumeration */
 enum rvu_block_addr_e {
 	BLKADDR_RVUM		= 0x0ULL,
-- 
2.43.0




