Return-Path: <stable+bounces-230166-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iOrpKnObwmm3fQQAu9opvQ
	(envelope-from <stable+bounces-230166-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 15:10:59 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CCE2309F65
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 15:10:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 395753045667
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 14:05:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 166253D566E;
	Tue, 24 Mar 2026 14:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="MKhW16zn"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99C783D6496
	for <stable@vger.kernel.org>; Tue, 24 Mar 2026 14:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774361115; cv=none; b=HMJmHpZQnPgFpe+57T6tZdxK9JIVybPYtPEf7AYHq2AYOjiEae+yJdUg4TLVeNzRPv+Bs0jjgvrgfrD0C4SCCwxWKHqQ9cpQcmgnuu2oKAnrljX3ajq1uaLDu8KtUmcHIO7Wq1iLdjV5DZi4GNkCAF7RS4q0cVZBAxgc4CN7CQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774361115; c=relaxed/simple;
	bh=uu9C7zsR7ufVWTxY5z8AQZHcOJxtjfsyUQzQ5LUVnFk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CanFhwhx/ytCRm0FmQlpFjnP8qsPQi50VpwfjFipPLe4KxUVhvn88OosdGJZnLgDjlBMnz6WO5ffZaS//NGIFgYh6lSppPx0qEK1oNmRYo2KpL2I/mUQBHpl98dYzZu2bTS8kmxji80n7a2oluEvO9wlkSplHTKCMm6Z3vO+VNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=MKhW16zn; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62OCC1BC1021874;
	Tue, 24 Mar 2026 14:05:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=kmnEJ
	lD0D+relrQssJ+DMKQdMe7xdxqicIKKotOUSlg=; b=MKhW16znC0P7ylONvnIlW
	nkUtvwDqJN3WJ8oXqdyZbWGEAkWOnkvWkSE7emYuaR+mVj5iThSrDtPtsLuqdzsG
	My8FrcNTWA7sCL0ShypUbE+KM4UKw1dE51nL9/8H/nNCtyJ/axfXAOLejBofqhk8
	M9iKfTfibMUUFhsChU+MaIpDNmvBbE12tribdDstQMIHUAxD4ce9OdhPHlAIMQmP
	AGTGbgBNYoNNuGCbtogILIfDgCUeJD9D6/pb4RO/OH/gLBM+BhlEfRCxnPrgjhtt
	h0jEwC1d360hyjnv148hqfLIj8MtLaV2mtGb/4hNk+xzb41IWnX0Gnf5pYmT9p3e
	g==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4d1kfpm9hq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Mar 2026 14:05:08 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 62OCSemo040169;
	Tue, 24 Mar 2026 14:05:07 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4d1hs9pdku-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Mar 2026 14:05:07 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 62OE50Ec023161;
	Tue, 24 Mar 2026 14:05:07 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4d1hs9pd7j-4;
	Tue, 24 Mar 2026 14:05:06 +0000
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
To: stable@vger.kernel.org
Cc: Mateusz Polchlopek <mateusz.polchlopek@intel.com>,
        Przemek Kitszel <przemyslaw.kitszel@intel.com>,
        Martyna Szapar-Mudlaw <martyna.szapar-mudlaw@linux.intel.com>,
        Rafal Romanowski <rafal.romanowski@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Subject: [PATCH 6.12.y 3/9] ice: fix using untrusted value of pkt_len in ice_vc_fdir_parse_raw()
Date: Tue, 24 Mar 2026 07:04:50 -0700
Message-ID: <20260324140456.832964-4-harshit.m.mogalapalli@oracle.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260324140456.832964-1-harshit.m.mogalapalli@oracle.com>
References: <20260324140456.832964-1-harshit.m.mogalapalli@oracle.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-24_03,2026-03-23_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0 bulkscore=0
 malwarescore=0 mlxlogscore=999 mlxscore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2603050001
 definitions=main-2603240111
X-Proofpoint-GUID: ZEpSTdQy-AKvbkDa_kuCx2_2swHtscD7
X-Authority-Analysis: v=2.4 cv=VKnQXtPX c=1 sm=1 tr=0 ts=69c29a14 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=x4eqshVgHu-cdnggieHk:22 a=QyXUC8HyAAAA:8 a=yPCof4ZbAAAA:8
 a=mSe9d35KmMoDGA_Sj9EA:9
X-Proofpoint-ORIG-GUID: ZEpSTdQy-AKvbkDa_kuCx2_2swHtscD7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI0MDExMSBTYWx0ZWRfX/cIRxJ1ZWyL3
 7P9QdXU76B9CCdBg3NYx9GlhcgX4wJB08vwiv2Tyj17/nIaLHY0B6fszWHWFm7SZeCxzssJeWdp
 xj86IMHlh767gWtGEOhOgHwQPufD235y7LPpwWh9qiOBfv0qcIHwhgwkGwmixhboV6ogCiCI+hK
 PCFrGdzc2K232FPEmDcMQgaw+7ULcfngMXupA87e2ZlAGTMAPN+RDleYkhZJ2AK9th6xKY5t6KG
 1NDmtN0AY23u1LD6cmo7COjSw0457LWMBhtn47me2BMMFaiokWbqeAT5h8J5e+g5ZdQttHf1nGi
 s7EpsotVNOGJeI4maR7N0kdoLXJggHEojbYNpeWCZCMT6+9KEMBbKa8cKOhurMJbDRw4QSO29+m
 HdP1PVQJeXdzBLNmKA9MGSDuFfawStzw8XRYUQiYrbjHbuVsqwhaojHg5qQJzAihmDvvjP2yvvy
 5jewVe76GnKfIOIT3qA==
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-230166-lists,stable=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oracle.com:dkim,oracle.com:email,oracle.com:mid,intel.com:email];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[harshit.m.mogalapalli@oracle.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[oracle.com:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 2CCE2309F65
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Mateusz Polchlopek <mateusz.polchlopek@intel.com>

[ Upstream commit 1388dd564183a5a18ec4a966748037736b5653c5 ]

Fix using the untrusted value of proto->raw.pkt_len in function
ice_vc_fdir_parse_raw() by verifying if it does not exceed the
VIRTCHNL_MAX_SIZE_RAW_PACKET value.

Fixes: 99f419df8a5c ("ice: enable FDIR filters from raw binary patterns for VFs")
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Signed-off-by: Martyna Szapar-Mudlaw <martyna.szapar-mudlaw@linux.intel.com>
Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
(cherry picked from commit 1388dd564183a5a18ec4a966748037736b5653c5)
Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
---
 .../ethernet/intel/ice/ice_virtchnl_fdir.c    | 24 ++++++++++++-------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl_fdir.c b/drivers/net/ethernet/intel/ice/ice_virtchnl_fdir.c
index ef755cee64ca..f90f545b3144 100644
--- a/drivers/net/ethernet/intel/ice/ice_virtchnl_fdir.c
+++ b/drivers/net/ethernet/intel/ice/ice_virtchnl_fdir.c
@@ -832,21 +832,27 @@ ice_vc_fdir_parse_raw(struct ice_vf *vf,
 		      struct virtchnl_proto_hdrs *proto,
 		      struct virtchnl_fdir_fltr_conf *conf)
 {
-	u8 *pkt_buf, *msk_buf __free(kfree);
+	u8 *pkt_buf, *msk_buf __free(kfree) = NULL;
 	struct ice_parser_result rslt;
 	struct ice_pf *pf = vf->pf;
+	u16 pkt_len, udp_port = 0;
 	struct ice_parser *psr;
 	int status = -ENOMEM;
 	struct ice_hw *hw;
-	u16 udp_port = 0;
 
-	pkt_buf = kzalloc(proto->raw.pkt_len, GFP_KERNEL);
-	msk_buf = kzalloc(proto->raw.pkt_len, GFP_KERNEL);
+	pkt_len = proto->raw.pkt_len;
+
+	if (!pkt_len || pkt_len > VIRTCHNL_MAX_SIZE_RAW_PACKET)
+		return -EINVAL;
+
+	pkt_buf = kzalloc(pkt_len, GFP_KERNEL);
+	msk_buf = kzalloc(pkt_len, GFP_KERNEL);
+
 	if (!pkt_buf || !msk_buf)
 		goto err_mem_alloc;
 
-	memcpy(pkt_buf, proto->raw.spec, proto->raw.pkt_len);
-	memcpy(msk_buf, proto->raw.mask, proto->raw.pkt_len);
+	memcpy(pkt_buf, proto->raw.spec, pkt_len);
+	memcpy(msk_buf, proto->raw.mask, pkt_len);
 
 	hw = &pf->hw;
 
@@ -862,7 +868,7 @@ ice_vc_fdir_parse_raw(struct ice_vf *vf,
 	if (ice_get_open_tunnel_port(hw, &udp_port, TNL_VXLAN))
 		ice_parser_vxlan_tunnel_set(psr, udp_port, true);
 
-	status = ice_parser_run(psr, pkt_buf, proto->raw.pkt_len, &rslt);
+	status = ice_parser_run(psr, pkt_buf, pkt_len, &rslt);
 	if (status)
 		goto err_parser_destroy;
 
@@ -876,7 +882,7 @@ ice_vc_fdir_parse_raw(struct ice_vf *vf,
 	}
 
 	status = ice_parser_profile_init(&rslt, pkt_buf, msk_buf,
-					 proto->raw.pkt_len, ICE_BLK_FD,
+					 pkt_len, ICE_BLK_FD,
 					 conf->prof);
 	if (status)
 		goto err_parser_profile_init;
@@ -885,7 +891,7 @@ ice_vc_fdir_parse_raw(struct ice_vf *vf,
 		ice_parser_profile_dump(hw, conf->prof);
 
 	/* Store raw flow info into @conf */
-	conf->pkt_len = proto->raw.pkt_len;
+	conf->pkt_len = pkt_len;
 	conf->pkt_buf = pkt_buf;
 	conf->parser_ena = true;
 
-- 
2.50.1


