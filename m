Return-Path: <stable+bounces-217412-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UD33IFrilmnkqQIAu9opvQ
	(envelope-from <stable+bounces-217412-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 19 Feb 2026 11:13:46 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DF5C15DA64
	for <lists+stable@lfdr.de>; Thu, 19 Feb 2026 11:13:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7E8F43008C2B
	for <lists+stable@lfdr.de>; Thu, 19 Feb 2026 10:13:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C989D326933;
	Thu, 19 Feb 2026 10:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="oUg1XICp"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EAE3320CAD;
	Thu, 19 Feb 2026 10:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771496024; cv=none; b=VRvva+FMAtk6WlnjjJ7RSnXEchgppK0cIjRaNqhQ+RR3K6dBmD9mhOoju5XbtVhxk34utJ/3JAqi3I9pZe+bI3JhytfX6Po4m+6qQpWQWDCwsatAjA1q1NYbPwSMTqRAacMmXH6Ff0DA06JVdwspZNOYDX+Edhp0VHHs7eZVbjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771496024; c=relaxed/simple;
	bh=UwVRGz/ZbCTPQv0iSEcOCKtupZjIsenWsa9tIlC6lxA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dW8s7uivfE9b1otLhMe6fAJJh01GoB1razAboV+r8igx05OJuopeDo6aMU9VYN6ecWIIy/4mkVR9JqXDXBdqeI5BeGed021C02Db3+tiWmqKh/jD7xTSJc5hNAfamHn3Kc9Nh5JROgzBHG1kXYNcDefrKf/JdFD+lnwZws00/MQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=oUg1XICp; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61J7csof066038;
	Thu, 19 Feb 2026 10:13:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=BxIcM
	CH4P4/1VfgXVWyc61REXEh59cLRHU3nKgwMeuw=; b=oUg1XICpR+Hb3+AWGArhG
	gZtH4djjJmtXyne7uhbAwRobhxhw4fEgVE/aXmY9y20DrRCgi7XK3PzcZDjT5EzA
	Bojbgoo1saxsX9rbYZSjuF+kZ5Zj6X9LmY/lUQhK8Xj8IZodsdwc9zwgtOrqj//l
	TZowWkQzcEp2y1WdIbzesZ8ugpKTKldemvp7dkaBTmwrgqm413plB2TocB1uVhA9
	YQ4fODRwFa5gMK4QYWl+di05xFNunJxpWD/2SuKlBHOUCrgX1XTuUpPCypwsPdON
	wFtPo8Gxk76alUVPrFNUh/u9fkS2fwUAEYdaItk0Tr2vs/0tUGMVvtn7bPV5q3qF
	A==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4caj0473t2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 19 Feb 2026 10:13:36 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 61J7l2o3033274;
	Thu, 19 Feb 2026 10:13:36 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4ccb228uhe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 19 Feb 2026 10:13:35 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 61JADULm037324;
	Thu, 19 Feb 2026 10:13:35 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4ccb228uem-3;
	Thu, 19 Feb 2026 10:13:34 +0000
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
To: stable@vger.kernel.org
Cc: kevin.brodsky@arm.com, linux-kselftest@vger.kernel.org,
        Aruna Ramakrishna <aruna.ramakrishna@oracle.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Joey Gouly <joey.gouly@arm.com>, Keith Lucas <keith.lucas@oracle.com>,
        Ryan Roberts <ryan.roberts@arm.com>, Shuah Khan <shuah@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Subject: [PATCH 6.12.y 02/14] selftests/mm: fix -Wmaybe-uninitialized warnings
Date: Thu, 19 Feb 2026 02:13:06 -0800
Message-ID: <20260219101318.2442406-3-harshit.m.mogalapalli@oracle.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE5MDA5NCBTYWx0ZWRfX4c89RhL/ZrMX
 u5hkaESrq/V5jfimlTPH7CmkCgLd+z11JkYDjqHdl7rqx6dLQFYi4WzzT3f5mumGJG6gBI9dmcW
 x0+O/z8efnazWxDKbd+ouJWuXjwq9zWYoXPHtcQJ38z1qEGEQ6UNGxA/EHP5fukmCrLa6CFAUsv
 V1a8j/Qj4e6LXiIPz2yPTNdiGD/Oiq5BOWrcOn9WEoIVCGeGlOaGX5JqZUp05CLw1KszMyIPll8
 +ysYvPAofGgE22XcXWKSHW+hbTaP6nJriY8Vc4yCFW4T9hRLHndyjMdi80GL98jJBiiXlLSKzf/
 wYiyB9yG1fu1Pa7rN0uqWaAS7RqkCQQRENUqOdRqaeaZiWTM19F1GyJ8uLy0jRwGvLPqbE1J16y
 m/TWPjyl/Gwt4RagvVFv6r9hxZ4cwX7RxPyo1/KzZfeUzJEsC1NzjsiP80uerHhUo8SOBtrWWDo
 jUTvPDcsTxDU4n9MnWA==
X-Authority-Analysis: v=2.4 cv=O+w0fR9W c=1 sm=1 tr=0 ts=6996e250 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=VwQbUJbxAAAA:8 a=7CQSdrXTAAAA:8 a=yPCof4ZbAAAA:8
 a=QyXUC8HyAAAA:8 a=Z4Rwk6OoAAAA:8 a=m5V4_6Zx8MTly2rGdJcA:9
 a=a-qgeE7W1pNrGK8U0ZQC:22 a=HkZW87K1Qel5hWWM3VKY:22
X-Proofpoint-GUID: _QhMC4Z1PJ8ImVSlXCWEd9rGkDj5cQRq
X-Proofpoint-ORIG-GUID: _QhMC4Z1PJ8ImVSlXCWEd9rGkDj5cQRq
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-217412-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[oracle.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[harshit.m.mogalapalli@oracle.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,oracle.com:mid,oracle.com:dkim,oracle.com:email];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 1DF5C15DA64
X-Rspamd-Action: no action

From: Kevin Brodsky <kevin.brodsky@arm.com>

[ Upstream commit 516fb516383ef39d881d116c6447826356883ad0 ]

A few -Wmaybe-uninitialized warnings show up when building the mm tests
with -O2.  None of them looks worrying; silence them by initialising the
problematic variables.

Link: https://lkml.kernel.org/r/20241209095019.1732120-3-kevin.brodsky@arm.com
Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
Cc: Aruna Ramakrishna <aruna.ramakrishna@oracle.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Joey Gouly <joey.gouly@arm.com>
Cc: Keith Lucas <keith.lucas@oracle.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: Shuah Khan <shuah@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
(cherry picked from commit 516fb516383ef39d881d116c6447826356883ad0)
[Harshit: Backport to 6.12.y -- fixes some harmeless build time warnings -
clean cherry-pick]
Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
---
 tools/testing/selftests/mm/ksm_tests.c       | 2 +-
 tools/testing/selftests/mm/mremap_test.c     | 2 +-
 tools/testing/selftests/mm/soft-dirty.c      | 2 +-
 tools/testing/selftests/mm/uffd-unit-tests.c | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/mm/ksm_tests.c b/tools/testing/selftests/mm/ksm_tests.c
index b748c48908d9..dcdd5bb20f3d 100644
--- a/tools/testing/selftests/mm/ksm_tests.c
+++ b/tools/testing/selftests/mm/ksm_tests.c
@@ -776,7 +776,7 @@ static int ksm_cow_time(int merge_type, int mapping, int prot, int timeout, size
 
 int main(int argc, char *argv[])
 {
-	int ret, opt;
+	int ret = 0, opt;
 	int prot = 0;
 	int ksm_scan_limit_sec = KSM_SCAN_LIMIT_SEC_DEFAULT;
 	int merge_type = KSM_MERGE_TYPE_DEFAULT;
diff --git a/tools/testing/selftests/mm/mremap_test.c b/tools/testing/selftests/mm/mremap_test.c
index 5a3a9bcba640..056b227f4a30 100644
--- a/tools/testing/selftests/mm/mremap_test.c
+++ b/tools/testing/selftests/mm/mremap_test.c
@@ -384,7 +384,7 @@ static void mremap_move_within_range(unsigned int pattern_seed, char *rand_addr)
 static long long remap_region(struct config c, unsigned int threshold_mb,
 			      char *rand_addr)
 {
-	void *addr, *src_addr, *dest_addr, *dest_preamble_addr;
+	void *addr, *src_addr, *dest_addr, *dest_preamble_addr = NULL;
 	unsigned long long t, d;
 	struct timespec t_start = {0, 0}, t_end = {0, 0};
 	long long  start_ns, end_ns, align_mask, ret, offset;
diff --git a/tools/testing/selftests/mm/soft-dirty.c b/tools/testing/selftests/mm/soft-dirty.c
index 7b91df12ce5b..1d1ba75ea26b 100644
--- a/tools/testing/selftests/mm/soft-dirty.c
+++ b/tools/testing/selftests/mm/soft-dirty.c
@@ -128,7 +128,7 @@ static void test_mprotect(int pagemap_fd, int pagesize, bool anon)
 {
 	const char *type[] = {"file", "anon"};
 	const char *fname = "./soft-dirty-test-file";
-	int test_fd;
+	int test_fd = 0;
 	char *map;
 
 	if (anon) {
diff --git a/tools/testing/selftests/mm/uffd-unit-tests.c b/tools/testing/selftests/mm/uffd-unit-tests.c
index 52d6979ebf99..74c8bc02b506 100644
--- a/tools/testing/selftests/mm/uffd-unit-tests.c
+++ b/tools/testing/selftests/mm/uffd-unit-tests.c
@@ -1123,7 +1123,7 @@ uffd_move_test_common(uffd_test_args_t *targs, unsigned long chunk_size,
 	char c;
 	unsigned long long count;
 	struct uffd_args args = { 0 };
-	char *orig_area_src, *orig_area_dst;
+	char *orig_area_src = NULL, *orig_area_dst = NULL;
 	unsigned long step_size, step_count;
 	unsigned long src_offs = 0;
 	unsigned long dst_offs = 0;
-- 
2.47.3


