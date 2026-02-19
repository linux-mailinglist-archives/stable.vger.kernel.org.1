Return-Path: <stable+bounces-217414-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cG16DIHilmlbqgIAu9opvQ
	(envelope-from <stable+bounces-217414-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 19 Feb 2026 11:14:25 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BD23415DAD1
	for <lists+stable@lfdr.de>; Thu, 19 Feb 2026 11:14:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 562813044089
	for <lists+stable@lfdr.de>; Thu, 19 Feb 2026 10:13:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7845322753;
	Thu, 19 Feb 2026 10:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="seEMqjJS"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BC3E311C37;
	Thu, 19 Feb 2026 10:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771496026; cv=none; b=LOtrR/sm5YzzXpEjQO1DBhQjHNvoFMcrCxF3H6v/tuNAcmOYVP5WtKIZWVwrd0KkkAbgi1iJz7fXCBAGTC3PJztktI+AR2osrD26ERHVoXL0hTIMp/t4I37B9aq/Ol3dJ+hL7a1JWprhQdpR5x6QepdowUFQvvVIES4czGLjAA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771496026; c=relaxed/simple;
	bh=HUFCkRdB1BpMpyD02upH5qkQcuONSvJxV6QGLTBGrNE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LbkyivCpxlIVcPzDIRvpEF3xi7yQDlTBoN3XckCXz3PG1B1L5rNPhV2iG8GLf+pcC4eSH103o4mWn1xcW11B6vAHLqCow14VrCxTtPfNx08uroslwkJm1P66vp+4GTMeHZ1co845/7q2hICB9MyNVBHSs7eURS1R/KBr571ZIiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=seEMqjJS; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61J7deIJ066193;
	Thu, 19 Feb 2026 10:13:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=AnMyv6Ig8groNsjMOcDVvNN+0BN3v50eSX32tVF4MII=; b=
	seEMqjJSsnKaPiwi091/Aha6nix55GpTHFfrFgiOOcQvg9AALUJhnRwmpzwFe4cH
	tL31tznvUQJLJpv0sVIhFyBI5gQIeaD54g6uIOdMvnI2FgPYYbtsAUTgcjIJsitd
	qolDvxlT3D12Uv636gZLCGDUhAHle/jE840aOTHKBDnWHJOnBuqXGb3LScjHh5u+
	28pmlUYY50U1Nm/4onnraCQMIism9xljyjL1cVhUgZ3jzdsq6TJLnt+xODp9EmX+
	eQD8bsn6EGDksAtEn/NPIgPj2U1LW0nD1u9t/5yYcLHkcyHUzIEnJcZD0cs5g0wW
	1PuehCSngBHgrZbJ/ugQ0Q==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4caj0473t4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 19 Feb 2026 10:13:38 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 61J7qChY033535;
	Thu, 19 Feb 2026 10:13:38 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4ccb228ujc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 19 Feb 2026 10:13:38 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 61JADULo037324;
	Thu, 19 Feb 2026 10:13:37 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4ccb228uem-4;
	Thu, 19 Feb 2026 10:13:36 +0000
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
Subject: [PATCH 6.12.y 03/14] selftests/mm: fix strncpy() length
Date: Thu, 19 Feb 2026 02:13:07 -0800
Message-ID: <20260219101318.2442406-4-harshit.m.mogalapalli@oracle.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260219101318.2442406-1-harshit.m.mogalapalli@oracle.com>
References: <20260219101318.2442406-1-harshit.m.mogalapalli@oracle.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-19_03,2026-02-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=887 spamscore=0 mlxscore=0
 suspectscore=0 malwarescore=0 adultscore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2602130000
 definitions=main-2602190094
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE5MDA5NCBTYWx0ZWRfX5d8yddLKIEi9
 68WSizMRqZWeO6SNp44WeTTWI9b3VbPQ/IQ5R17syFY6u+3TL64d3kmQ/z44qOkqfqQHF7ICzx0
 3iOEzxfE+dyKlo0TGXMvuvDxJ895V2/Rt/tZ5rUPKmf0C76LP4Hoejy9GJ5nOrN6/dDo7M54ZqH
 V+0oOLfEYIBtUbFpC+Hloxed/MDVZjtDd9Yt/u+CZuNWLPunmxd2G05Xypfz8EChjBlaoyuAFXU
 JbLxv2hOPl9pL+rskxLI3Rg9WQqRsKkj3P0kc8SEpzYMg2CrDmKR90sqiLeL4CU4unYy0y22Itz
 fOYj0TH53AIPPG5uc/pblUwx5EVpBxxkSakkZ0qIDTBVHcIK0m+SJOrgfaubkJClvMZCAKufBVk
 Y05GkNfD44IW7UB8lLmn3XfBAWFDs+4GQIl8xH6qV4VU3/QRbTasQ5KxjBRBKmA2eseq1VqGy2l
 v/a+NHGtX8gGXzGDtuA==
X-Authority-Analysis: v=2.4 cv=O+w0fR9W c=1 sm=1 tr=0 ts=6996e252 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=VwQbUJbxAAAA:8
 a=7CQSdrXTAAAA:8 a=yPCof4ZbAAAA:8 a=QyXUC8HyAAAA:8 a=Z4Rwk6OoAAAA:8
 a=miD44l8NRCU-1xOx2msA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=a-qgeE7W1pNrGK8U0ZQC:22 a=HkZW87K1Qel5hWWM3VKY:22
X-Proofpoint-GUID: CdL2kEkGM819rZcy0UKIXwuHkVbrskDY
X-Proofpoint-ORIG-GUID: CdL2kEkGM819rZcy0UKIXwuHkVbrskDY
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-217414-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:mid,oracle.com:dkim,oracle.com:email,linux-foundation.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,arm.com:email];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[harshit.m.mogalapalli@oracle.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[oracle.com:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: BD23415DAD1
X-Rspamd-Action: no action

From: Kevin Brodsky <kevin.brodsky@arm.com>

[ Upstream commit 5b6b2799f617b3259d551980fa94f290d96bc593 ]

GCC complains (with -O2) that the length is equal to the destination size,
which is indeed invalid.  Subtract 1 from the size of the array to leave
room for '\0'.

Link: https://lkml.kernel.org/r/20241209095019.1732120-4-kevin.brodsky@arm.com
Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
Cc: Aruna Ramakrishna <aruna.ramakrishna@oracle.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Joey Gouly <joey.gouly@arm.com>
Cc: Keith Lucas <keith.lucas@oracle.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: Shuah Khan <shuah@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
(cherry picked from commit 5b6b2799f617b3259d551980fa94f290d96bc593)
[Harshit: Backport to 6.12.y, fixes build time warning: warning:
‘strncpy’ specified bound 256 equals destination size in 6.12.y, this is
a clean cherry-pick]
Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
---
 tools/testing/selftests/mm/write_to_hugetlbfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/mm/write_to_hugetlbfs.c b/tools/testing/selftests/mm/write_to_hugetlbfs.c
index 1289d311efd7..34c91f7e6128 100644
--- a/tools/testing/selftests/mm/write_to_hugetlbfs.c
+++ b/tools/testing/selftests/mm/write_to_hugetlbfs.c
@@ -89,7 +89,7 @@ int main(int argc, char **argv)
 			size = atoi(optarg);
 			break;
 		case 'p':
-			strncpy(path, optarg, sizeof(path));
+			strncpy(path, optarg, sizeof(path) - 1);
 			break;
 		case 'm':
 			if (atoi(optarg) >= MAX_METHOD) {
-- 
2.47.3


