Return-Path: <stable+bounces-76518-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D244D97A6CD
	for <lists+stable@lfdr.de>; Mon, 16 Sep 2024 19:31:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DF201C22942
	for <lists+stable@lfdr.de>; Mon, 16 Sep 2024 17:31:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3D221EEE9;
	Mon, 16 Sep 2024 17:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NCRevh1c"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 842321B7E9
	for <stable@vger.kernel.org>; Mon, 16 Sep 2024 17:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726507871; cv=none; b=RCWiUO1rbOPKysn+4zj+FeZfIw9YgE2DzdNKHxQ2O7dnnqvtesm9He2SX6U/eGNJ9Ubj2e/7feftr4ZqvVz70U8xhqq07Kenq4pKlJQUFYaiDACBUp0xO2az2GWZsKfW//qPRjhDr1JOe+RjLMlGxnIMQDeA2iZXq24TicVKFJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726507871; c=relaxed/simple;
	bh=wk7ogxmE10FVDLbB+ylbahteMnuAesdQB+Mpvs6WZBU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=r/1A5ZDr1y2+6kYF9pyqUabp8wYul4nB8iGhIZ66c8Bu04+4GQSPD44yd5l/Ops74Lat9ADZ6SbYDOdoZvuPazUHdc8iIDg2Wo9RCsiejkRABEyzJVDHH03QO7VYtSfTSNfaj8eeltLDJi/B4Keyvn7g6tCYW93SZ9k4nPTWTwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=NCRevh1c; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48GEMYjj001024;
	Mon, 16 Sep 2024 17:31:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding; s=corp-2023-11-20; bh=W0LmE7qZi/+Ed/
	Vd9SZfBQQUBIdiDPHW6FpeptK1pvM=; b=NCRevh1cCYwDqx5E90l6qDZRySLcgj
	rihyaO7uwTVPGYPFhqHwzwynfvet1JufX4JbRyIFVzH9QDN/EYfIIn8N8lwziPUE
	VqDfwbFqmDdaeIL68wwXu90v+m0bYOxrHVh92zX48L8sedlljGfRNGeE2FmvmXJ4
	saPbGef0mZiD3zO9UieVmbOcuMzBgDPrzduGboC+S4pgXMlJEJDQGVU6Q3SoDZ+g
	vECjNJe8fxsMwVU38mkdVvDulHTGaY797y92wM0nwEowFlHCitSL+ywvUdjs6OKH
	UkXkz5nLyB82NfcJd7+GZNQ4gf8JCTFU73tUY408QjYnRtp0JAyUSjpA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41n3sfm0x9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Sep 2024 17:31:04 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 48GGKdhv011209;
	Mon, 16 Sep 2024 17:31:04 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 41nyb5w6kp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Sep 2024 17:31:04 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 48GHV3lB027085;
	Mon, 16 Sep 2024 17:31:03 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 41nyb5w6k8-1;
	Mon, 16 Sep 2024 17:31:03 +0000
From: Samasth Norway Ananda <samasth.norway.ananda@oracle.com>
To: stable@vger.kernel.org
Cc: michael.chan@broadcom.com, kuba@kernel.org, somnath.kotur@broadcom.com,
        pavan.chebbi@broadcom.com, samasth.norway.ananda@oracle.com
Subject: [PATCH 6.6.y] bnxt_en: Cap the size of HWRM_PORT_PHY_QCFG forwarded response
Date: Mon, 16 Sep 2024 10:31:02 -0700
Message-ID: <20240916173102.1973619-1-samasth.norway.ananda@oracle.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-16_13,2024-09-13_02,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 adultscore=0 malwarescore=0 suspectscore=0 phishscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2408220000 definitions=main-2409160116
X-Proofpoint-GUID: OjuUZUei9IT-00w0rmcD1tUZhOVwXimo
X-Proofpoint-ORIG-GUID: OjuUZUei9IT-00w0rmcD1tUZhOVwXimo

From: Michael Chan <michael.chan@broadcom.com>

commit 7d9df38c9c037ab84502ce7eeae9f1e1e7e72603 upstream.

Firmware interface 1.10.2.118 has increased the size of
HWRM_PORT_PHY_QCFG response beyond the maximum size that can be
forwarded.  When the VF's link state is not the default auto state,
the PF will need to forward the response back to the VF to indicate
the forced state.  This regression may cause the VF to fail to
initialize.

Fix it by capping the HWRM_PORT_PHY_QCFG response to the maximum
96 bytes.  The SPEEDS2_SUPPORTED flag needs to be cleared because the
new speeds2 fields are beyond the legacy structure.  Also modify
bnxt_hwrm_fwd_resp() to print a warning if the message size exceeds 96
bytes to make this failure more obvious.

Fixes: 84a911db8305 ("bnxt_en: Update firmware interface to 1.10.2.118")
Reviewed-by: Somnath Kotur <somnath.kotur@broadcom.com>
Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
Link: https://lore.kernel.org/r/20240612231736.57823-1-michael.chan@broadcom.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[Samasth: backport to 6.6.y]
Signed-off-by: Samasth Norway Ananda <samasth.norway.ananda@oracle.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.h     | 51 +++++++++++++++++++
 .../net/ethernet/broadcom/bnxt/bnxt_sriov.c   | 12 ++++-
 2 files changed, 61 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index 0116f67593e3a..f323c77aaea0e 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -1195,6 +1195,57 @@ struct bnxt_ntuple_filter {
 #define BNXT_FLTR_UPDATE	1
 };
 
+/* Compat version of hwrm_port_phy_qcfg_output capped at 96 bytes.  The
+ * first 95 bytes are identical to hwrm_port_phy_qcfg_output in bnxt_hsi.h.
+ * The last valid byte in the compat version is different.
+ */
+struct hwrm_port_phy_qcfg_output_compat {
+	__le16	error_code;
+	__le16	req_type;
+	__le16	seq_id;
+	__le16	resp_len;
+	u8	link;
+	u8	active_fec_signal_mode;
+	__le16	link_speed;
+	u8	duplex_cfg;
+	u8	pause;
+	__le16	support_speeds;
+	__le16	force_link_speed;
+	u8	auto_mode;
+	u8	auto_pause;
+	__le16	auto_link_speed;
+	__le16	auto_link_speed_mask;
+	u8	wirespeed;
+	u8	lpbk;
+	u8	force_pause;
+	u8	module_status;
+	__le32	preemphasis;
+	u8	phy_maj;
+	u8	phy_min;
+	u8	phy_bld;
+	u8	phy_type;
+	u8	media_type;
+	u8	xcvr_pkg_type;
+	u8	eee_config_phy_addr;
+	u8	parallel_detect;
+	__le16	link_partner_adv_speeds;
+	u8	link_partner_adv_auto_mode;
+	u8	link_partner_adv_pause;
+	__le16	adv_eee_link_speed_mask;
+	__le16	link_partner_adv_eee_link_speed_mask;
+	__le32	xcvr_identifier_type_tx_lpi_timer;
+	__le16	fec_cfg;
+	u8	duplex_state;
+	u8	option_flags;
+	char	phy_vendor_name[16];
+	char	phy_vendor_partnumber[16];
+	__le16	support_pam4_speeds;
+	__le16	force_pam4_link_speed;
+	__le16	auto_pam4_link_speed_mask;
+	u8	link_partner_pam4_adv_speeds;
+	u8	valid;
+};
+
 struct bnxt_link_info {
 	u8			phy_type;
 	u8			media_type;
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_sriov.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_sriov.c
index dde327f2c57ee..ac9a0c039b776 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_sriov.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_sriov.c
@@ -942,8 +942,11 @@ static int bnxt_hwrm_fwd_resp(struct bnxt *bp, struct bnxt_vf_info *vf,
 	struct hwrm_fwd_resp_input *req;
 	int rc;
 
-	if (BNXT_FWD_RESP_SIZE_ERR(msg_size))
+	if (BNXT_FWD_RESP_SIZE_ERR(msg_size)) {
+		netdev_warn_once(bp->dev, "HWRM fwd response too big (%d bytes)\n",
+				 msg_size);
 		return -EINVAL;
+	}
 
 	rc = hwrm_req_init(bp, req, HWRM_FWD_RESP);
 	if (!rc) {
@@ -1077,7 +1080,7 @@ static int bnxt_vf_set_link(struct bnxt *bp, struct bnxt_vf_info *vf)
 		rc = bnxt_hwrm_exec_fwd_resp(
 			bp, vf, sizeof(struct hwrm_port_phy_qcfg_input));
 	} else {
-		struct hwrm_port_phy_qcfg_output phy_qcfg_resp = {0};
+		struct hwrm_port_phy_qcfg_output_compat phy_qcfg_resp = {};
 		struct hwrm_port_phy_qcfg_input *phy_qcfg_req;
 
 		phy_qcfg_req =
@@ -1088,6 +1091,11 @@ static int bnxt_vf_set_link(struct bnxt *bp, struct bnxt_vf_info *vf)
 		mutex_unlock(&bp->link_lock);
 		phy_qcfg_resp.resp_len = cpu_to_le16(sizeof(phy_qcfg_resp));
 		phy_qcfg_resp.seq_id = phy_qcfg_req->seq_id;
+		/* New SPEEDS2 fields are beyond the legacy structure, so
+		 * clear the SPEEDS2_SUPPORTED flag.
+		 */
+		phy_qcfg_resp.option_flags &=
+			~PORT_PHY_QCAPS_RESP_FLAGS2_SPEEDS2_SUPPORTED;
 		phy_qcfg_resp.valid = 1;
 
 		if (vf->flags & BNXT_VF_LINK_UP) {
-- 
2.45.2


