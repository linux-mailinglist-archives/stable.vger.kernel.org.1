Return-Path: <stable+bounces-217413-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ANNVJ3vilmlbqgIAu9opvQ
	(envelope-from <stable+bounces-217413-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 19 Feb 2026 11:14:19 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1865515DAC3
	for <lists+stable@lfdr.de>; Thu, 19 Feb 2026 11:14:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AAB083040777
	for <lists+stable@lfdr.de>; Thu, 19 Feb 2026 10:13:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8369B6A8D2;
	Thu, 19 Feb 2026 10:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LRC4r/Hq"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 344A9326927;
	Thu, 19 Feb 2026 10:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771496025; cv=none; b=BhkYdD1COcE/8rmOZEEcXLhYxWammmcvXg+zk6y2qwBtDlRB0u3ztJfWWiHim0huQXOtcF64XC3R7Md4H8OV4e1/Qfq9oZxfvMFSrwijKygwoMA+HCLxc+jeH3WNAf7d7+nr/+e84KaGY3TsXiFaXHvK/fbZojuIFWyd7nVXp2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771496025; c=relaxed/simple;
	bh=1S3Zcerz5VCdaOYY7w8Mi2pA9IWpmVPErqQI96uNezQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r/bnj3qqDdp/97dwwXM6GQaedZPx8HKWMNgrexQFsTK7bL5nOB/2v2bsB7phWKrVfA40wFF59F8eEyUatMz0Tw4E+XONkJyRY/w086oBDuB0nj/Qih1BkXBpybb5O/ygBOsY596fXnamOClgiF0s2t4eA2eM6//r8mpTO40LB6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=LRC4r/Hq; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61J6l3ev3675770;
	Thu, 19 Feb 2026 10:13:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=YRAMM
	QDzMRqeW7JZ3PgiAcfW1P6Dhpkzu6Am9wZb0Tc=; b=LRC4r/HqyDewUTJ1czVFH
	gUG6NZ62DqpiH6/CPOVQCMc2/gkk3qrbyvkI0bLzvFWvy043TH+eciLof1tjrQGD
	vN4mJd/48kUtVN+Tb29Tk8EAPIZJTjE2rMPkV3wHDHPd9WLVe0gvtNMhk21LbwhT
	WRw2uWomZdQmVEadBLiXvpbXzI9oaWDx1ACdScUHD5sloFNVtLuM2gZGONPZh+RN
	Cd6A3DNkgoZkU2iJ0hdl1c3MzUNFFRvFcAV5SnBloq89gbPlNmKTsZLl04NF9+rF
	kc91NmmCfffSWU67JBVNWksrvxLeuXyEjwaP2vj9tJqAMzjJ90dgSSFNMAwhRuRZ
	Q==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4caj0ay4fm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 19 Feb 2026 10:13:40 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 61J9wHKl033224;
	Thu, 19 Feb 2026 10:13:39 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4ccb228uk4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 19 Feb 2026 10:13:39 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 61JADULq037324;
	Thu, 19 Feb 2026 10:13:39 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4ccb228uem-5;
	Thu, 19 Feb 2026 10:13:38 +0000
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
To: stable@vger.kernel.org
Cc: kevin.brodsky@arm.com, linux-kselftest@vger.kernel.org,
        Aishwarya TCV <aishwarya.tcv@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Subject: [PATCH 6.12.y 04/14] selftests/mm: Define PKEY_UNRESTRICTED for pkey_sighandler_tests
Date: Thu, 19 Feb 2026 02:13:08 -0800
Message-ID: <20260219101318.2442406-5-harshit.m.mogalapalli@oracle.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260219101318.2442406-1-harshit.m.mogalapalli@oracle.com>
References: <20260219101318.2442406-1-harshit.m.mogalapalli@oracle.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-19_03,2026-02-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0 mlxscore=0
 suspectscore=0 malwarescore=0 adultscore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2602130000
 definitions=main-2602190094
X-Proofpoint-GUID: YxJl7BAQMseM1n7DY6Kg13BA9af2kVen
X-Proofpoint-ORIG-GUID: YxJl7BAQMseM1n7DY6Kg13BA9af2kVen
X-Authority-Analysis: v=2.4 cv=UsVu9uwB c=1 sm=1 tr=0 ts=6996e254 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=VwQbUJbxAAAA:8 a=7CQSdrXTAAAA:8 a=yPCof4ZbAAAA:8
 a=ivxBf_eL_BqN1E0USzoA:9 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE5MDA5NCBTYWx0ZWRfX5nCPFSGL+omV
 uxVSBBJmSbffLu4gbIhLGCrCrOjlpKobOEAIvi6AT4MM9miJS74qNIuGtELx9w8iuw+8xmSN+hV
 g5kDCj47vuVy0q15oSUJRpgaLjBY/w/vQinNdFktAYg/o4i6dsB8fo0hwpRjV95ATT+OSIoJ986
 /Uq5XO/RR6EtacUUXYv/COLKg0PE2TdNWb5C93vh3GRjdL/DG/Ci1HsPTz/bY2/PLUJiSea/6O2
 tjSV6ya6+fpG30mi5mX3TOlSaIIQV5GNYEFML7V8wJD0HyhIjZq2Q23d8UidSHtvl2SSmgpHOoG
 BsyJW6qZY+RPew1MdQEhL6D+cTPF5v1Vz2RQrf7CEOTaUvjuNSdEzs+0f5mxVHX1SUvW3s4VwTd
 WNh0bEbLKTahvSwwXeSzQ3jETCxYiNj7LAGCM+7NkUtl6bJqOvCOGG/1Upl0SM+Bnz4WPaGyBf5
 3pvTbO8aa49eBBSjISQ==
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-217413-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[oracle.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[harshit.m.mogalapalli@oracle.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oracle.com:mid,oracle.com:dkim,oracle.com:email,arm.com:email];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 1865515DAC3
X-Rspamd-Action: no action

From: Kevin Brodsky <kevin.brodsky@arm.com>

[ Upstream commit db64dfffcad2992d6bfc680822bdf715335c43f1 ]

Commit 6e182dc9f268 ("selftests/mm: Use generic pkey register
manipulation") makes use of PKEY_UNRESTRICTED in
pkey_sighandler_tests. The macro has been proposed for addition to
uapi headers [1], but the patch hasn't landed yet.

Define PKEY_UNRESTRICTED in pkey-helpers.h for the time being to fix
the build.

[1] https://lore.kernel.org/all/20241028090715.509527-2-yury.khrustalev@arm.com/

Fixes: 6e182dc9f268 ("selftests/mm: Use generic pkey register manipulation")
Reported-by: Aishwarya TCV <aishwarya.tcv@arm.com>
Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
Link: https://lore.kernel.org/r/20241107131640.650703-1-kevin.brodsky@arm.com
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
(cherry picked from commit db64dfffcad2992d6bfc680822bdf715335c43f1)
[Harshit: backport to 6.12.y, clean cherry-pick]
Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
---
 tools/testing/selftests/mm/pkey-helpers.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/testing/selftests/mm/pkey-helpers.h b/tools/testing/selftests/mm/pkey-helpers.h
index 9ab6a3ee153b..f7cfe163b0ff 100644
--- a/tools/testing/selftests/mm/pkey-helpers.h
+++ b/tools/testing/selftests/mm/pkey-helpers.h
@@ -112,6 +112,13 @@ void record_pkey_malloc(void *ptr, long size, int prot);
 #define PKEY_MASK	(PKEY_DISABLE_ACCESS | PKEY_DISABLE_WRITE)
 #endif
 
+/*
+ * FIXME: Remove once the generic PKEY_UNRESTRICTED definition is merged.
+ */
+#ifndef PKEY_UNRESTRICTED
+#define PKEY_UNRESTRICTED 0x0
+#endif
+
 #ifndef set_pkey_bits
 static inline u64 set_pkey_bits(u64 reg, int pkey, u64 flags)
 {
-- 
2.47.3


