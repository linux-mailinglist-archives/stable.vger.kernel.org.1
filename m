Return-Path: <stable+bounces-217423-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +NKmM6nilmnkqQIAu9opvQ
	(envelope-from <stable+bounces-217423-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 19 Feb 2026 11:15:05 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7209615DB34
	for <lists+stable@lfdr.de>; Thu, 19 Feb 2026 11:15:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CB6CD304C09F
	for <lists+stable@lfdr.de>; Thu, 19 Feb 2026 10:14:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8877328B4B;
	Thu, 19 Feb 2026 10:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="EG99RYkY"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 931B56A8D2;
	Thu, 19 Feb 2026 10:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771496049; cv=none; b=ksH0rfr3hI7hDl2M83YXEgPV6zegfpvekeA94aAZBg1qVEcv7uqn9EJMkPuA3YAnM3+16FgKVOT+JQ8IALzkMrcb/AmOqmHlsTTVCCkQslCksfU3wHiEyUdqD8NLQJjh/MREkGHji4i13OB1DfzbSJB6yyIBBgSHgTsK03X85kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771496049; c=relaxed/simple;
	bh=7epN4rrEvPlROwz7dU6uWe3NYu+OlXxZ9j8beNpJg/Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sP4FaGtu2LPZrlZImPM4Y8hq3mOwyJMSPzA5Rd0UJlvEaLhoChxaISXUlLnKhS4+PGdigLaXlgqftxrSMOp8I2iwSyB+fux6ZKhGOyatDX0Bx73kooJfNblkQYZMqRVkZhl5UhYxFsxonfKfFocCGO0jFGz45qEYenzCkWgVBVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=EG99RYkY; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61J7Ib6O3675640;
	Thu, 19 Feb 2026 10:14:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=DlL7O
	mDuTOs3aLLn33u1ZnHh2iCRqzKyZPMpa6al1sA=; b=EG99RYkYE+MrmWbg/Ds+r
	5c3p6weuJ6BrW9jOEjIhSSPBX1DA5jlMawsHJ+/K858wq8W7Jri0J6SZYghzTGJm
	WXaeBAfjm9vkk31jGzoSFONPyCZQGOtIdKOqXPv6TYJsp3L4zKNjn6B7erxv/ZEx
	76xqWYv2/d5Zc+IAScBgaIWq4JkXP6DDvtV13G7/Yo+Hw0EvEQWS7GfivgiRrL7Q
	Kn6ILXSO11U54CzTNv3gRWMX2kg5v89OYNjJz6UkmH8892t7R4MZH36n1gUs7/4i
	eevz7dfdtXyRdXM0pANpSxq8FKA5RpQ5SxCjHLzadPYVx9tHtfZbhQ9j2ab94HgF
	Q==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4caj0ay4g2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 19 Feb 2026 10:14:01 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 61J9wHwG033233;
	Thu, 19 Feb 2026 10:14:00 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4ccb228uvh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 19 Feb 2026 10:14:00 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 61JADUMC037324;
	Thu, 19 Feb 2026 10:14:00 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4ccb228uem-15;
	Thu, 19 Feb 2026 10:13:59 +0000
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
Subject: [PATCH 6.12.y 14/14] selftests/mm: skip pkey_sighandler_tests if support is missing
Date: Thu, 19 Feb 2026 02:13:18 -0800
Message-ID: <20260219101318.2442406-15-harshit.m.mogalapalli@oracle.com>
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
X-Proofpoint-GUID: JOIjDE8G9n295DU-U-H2Nd4iAeGbS3WC
X-Proofpoint-ORIG-GUID: JOIjDE8G9n295DU-U-H2Nd4iAeGbS3WC
X-Authority-Analysis: v=2.4 cv=UsVu9uwB c=1 sm=1 tr=0 ts=6996e269 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=VwQbUJbxAAAA:8 a=7CQSdrXTAAAA:8 a=yPCof4ZbAAAA:8
 a=QyXUC8HyAAAA:8 a=Z4Rwk6OoAAAA:8 a=df86cSpv0Oj3CKEDSYsA:9
 a=a-qgeE7W1pNrGK8U0ZQC:22 a=HkZW87K1Qel5hWWM3VKY:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE5MDA5NCBTYWx0ZWRfX+sfsNkDcYU6k
 J0Fhn5sNC5GxD9vQtXUJgarp+2jTLOSHTDbBPTSqqnjjppyB8zPBKe/bu68FMAqrs1X+vDz4uZo
 0qA/ZwjSLMe7B4gFP9Ront143xWkAcf7++88PtkefPreBCnhRPi4wvfVFZmUwVgUPPq5PopF6xo
 8+aZ5KHOk9lr5/kSGKp/Kd+JihIledGk7TosUw4pGfZQCYSqb3F1FwORwi5BO+RK6r8B8TM43lf
 sllOQE9136+NsJfhlsiDVtPElMX2at58Ghd2XW36U10S0YUp8wAYacjK3HrsTDdr4vMhXJRc6yI
 D5FO8qN4Al/LedRSeWZAtaUJ5Sw2ioD5QpNRxoZZkL9KGryf3Ky+wE9FZBJHw3IyD3JzQJud9qr
 KMI/9krSnuBN8TgRXAZn/PvCDxR4KgLHvcolOg8dAsSv2NsJ3i4EaK+Ue7SC1NzHkc61F7Qnu2N
 QnqtTnLprLuFmCwJTfA==
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-217423-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[oracle.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[harshit.m.mogalapalli@oracle.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:mid,oracle.com:dkim,oracle.com:email,linux-foundation.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,arm.com:email];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 7209615DB34
X-Rspamd-Action: no action

From: Kevin Brodsky <kevin.brodsky@arm.com>

[ Upstream commit 1c6b1d4889d72a705c9f60f9916ebabbcfe25d30 ]

The pkey_sighandler_tests are bound to fail if either the kernel or CPU
doesn't support pkeys.  Skip the tests if pkeys support is missing.

Link: https://lkml.kernel.org/r/20241209095019.1732120-14-kevin.brodsky@arm.com
Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
Cc: Aruna Ramakrishna <aruna.ramakrishna@oracle.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Joey Gouly <joey.gouly@arm.com>
Cc: Keith Lucas <keith.lucas@oracle.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: Shuah Khan <shuah@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
(cherry picked from commit 1c6b1d4889d72a705c9f60f9916ebabbcfe25d30)
[Harshit: clean backport to 6.12.y, fixes tests on machines that don't
really have pkeys support, with this the tests are correctly skipped]
Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
---
 tools/testing/selftests/mm/pkey_sighandler_tests.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/testing/selftests/mm/pkey_sighandler_tests.c b/tools/testing/selftests/mm/pkey_sighandler_tests.c
index 6d1a521d6936..1c744cd71d33 100644
--- a/tools/testing/selftests/mm/pkey_sighandler_tests.c
+++ b/tools/testing/selftests/mm/pkey_sighandler_tests.c
@@ -505,6 +505,9 @@ int main(int argc, char *argv[])
 	ksft_print_header();
 	ksft_set_plan(ARRAY_SIZE(pkey_tests));
 
+	if (!is_pkeys_supported())
+		ksft_exit_skip("pkeys not supported\n");
+
 	for (i = 0; i < ARRAY_SIZE(pkey_tests); i++)
 		(*pkey_tests[i])();
 
-- 
2.47.3


