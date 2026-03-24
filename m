Return-Path: <stable+bounces-230165-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qAbPIm2bwmm3fQQAu9opvQ
	(envelope-from <stable+bounces-230165-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 15:10:53 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DFC69309F5E
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 15:10:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B2CD030363B7
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 14:05:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29C963D566E;
	Tue, 24 Mar 2026 14:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FRy0AHFL"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DCF33D6496
	for <stable@vger.kernel.org>; Tue, 24 Mar 2026 14:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774361113; cv=none; b=JnjzGhUYsGcqAJbQQSW5c92cDop0TLAB/j75ZDU93qXN8nNctCPjNp1YcegVxWCKLz1Bp/cTkUurIRSGivbqqQrrliewCuWZhYx3zyzT/EVaefSXzxUd/xh9ZaSAyGj5Zyn5QnESMkQGdScOLZNw1ePqvvK3qOxxusJ2rnMc6Hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774361113; c=relaxed/simple;
	bh=PmnRgfL8sxatxvRS3LOoq14oq6DTSxWoukxsxRHsozs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SLbdBbga45SM0cmmLJIxtAVsYYnoT5Vujfi+dq+mKDI8YAnwo7jNnbjA3QmStVLfkO5NtqROMMfjOEIyJQuymH3HatM5YNYL45ySmDSJGt8jKhEAgosBbXGCG6focU5M79qVnMOAVsiaFIgMTvb7lgKFxft8G9UbqVPlZ4zw+Co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=FRy0AHFL; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62OCC1BB1021874;
	Tue, 24 Mar 2026 14:05:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=TeXH9jR/KayURSeIASCAANvS1ZYSzTxMb+zeQcNz6bI=; b=
	FRy0AHFLdJjZcyif0jpmrMeztx724GBpPqgAY4ie/XLmLMfAnlVSDl6dnoR3FGdF
	K4Yni5dao9FZP5SL33ewhD36kRQHikjc6fDyqWrp+x9M39AHdnTL9HRL7jUVxMzn
	rRHmwtm1oPXcZubRU/rzG57UKyV3GhOkL4yeQb20BIcPg1vhWuiZ+VBkUqdk1hS0
	+cfeIC+BUebSNQZ0m+gLZGoDRun+OBiUVkgbXUBU9RcCJq7gkHXuRqdU8uA9MFtE
	rUGykjIp/ZV++IN2zUH5SNXy/PLZr07y12hOIzA60jXxYkU7ifLpdjcAXatePeNH
	twJrHQEojGV9VJGGakTUMQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4d1kfpm9hc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Mar 2026 14:05:04 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 62ODq5Ir039887;
	Tue, 24 Mar 2026 14:05:03 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4d1hs9pdbn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Mar 2026 14:05:03 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 62OE50EY023161;
	Tue, 24 Mar 2026 14:05:02 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4d1hs9pd7j-2;
	Tue, 24 Mar 2026 14:05:02 +0000
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
        =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
        Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Subject: [PATCH 6.12.y 1/9] landlock: Optimize file path walks and prepare for audit support
Date: Tue, 24 Mar 2026 07:04:48 -0700
Message-ID: <20260324140456.832964-2-harshit.m.mogalapalli@oracle.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260324140456.832964-1-harshit.m.mogalapalli@oracle.com>
References: <20260324140456.832964-1-harshit.m.mogalapalli@oracle.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-24_03,2026-03-23_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0 bulkscore=0
 malwarescore=0 mlxlogscore=999 mlxscore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2603050001
 definitions=main-2603240111
X-Proofpoint-GUID: unTjJynVyikU8ZHwosFI0lOXJM9RzenY
X-Authority-Analysis: v=2.4 cv=VKnQXtPX c=1 sm=1 tr=0 ts=69c29a10 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=x4eqshVgHu-cdnggieHk:22 a=VwQbUJbxAAAA:8
 a=edGIuiaXAAAA:8 a=1XWaLZrsAAAA:8 a=yPCof4ZbAAAA:8 a=UWeds6VcmML97xFuvbcA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=4kyDAASA-Eebq_PzFVE6:22
X-Proofpoint-ORIG-GUID: unTjJynVyikU8ZHwosFI0lOXJM9RzenY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI0MDExMSBTYWx0ZWRfX/9BSLpjB+d8n
 SVcL/zkOb5FxI7bYQ9Y9XEqBjyf3Z64bm0CZvV0+Snex5RTLdp0PH+ESMx7V5gyzjwdQKdcAmb1
 NlxZ0g19RAUE96Icf4AGL7MeSkJA+qgH4fgESbQ+bC8J4x1gIFPcwl5haGIZ38gp9fQ1mBluq/w
 +Ld1U2NJvrer7IObLNZo+Oab+JIKiw0tlcCSWpSaWfI6N9BFvalIwGX4PlQQlzmx/QqdttgSSU3
 0harszu2QmZF5AL0AmocEoY7uqzPsyIGnoK6vFWwITpVld65Z6YI39OkBzJ1jOOkhlNWemTD5hV
 LNMei8bsEpzMton/rge/YiXKuUrzpEiNxuH7YZ9Uh9dmEf3ZMFwS49W54KlYtI2wpYbdoccUHcq
 E7HR8otIg50ZjcrSCh3Fhk74Iks9SGigMr5VhQSFPBGpXR7qnuuj2em7SyWJGIV4gfDr37SwuyH
 NVC+oq21Zx+nycwWiYg==
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-230165-lists,stable=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oracle.com:dkim,oracle.com:email,oracle.com:mid];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[oracle.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[harshit.m.mogalapalli@oracle.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: DFC69309F5E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Mickaël Salaün <mic@digikod.net>

[ Upstream commit d617f0d72d8041c7099fd04a62db0f0fa5331c1a ]

Always synchronize access_masked_parent* with access_request_parent*
according to allowed_parent*.  This is required for audit support to be
able to get back to the reason of denial.

In a rename/link action, instead of always checking a rule two times for
the same parent directory of the source and the destination files, only
check it when an action on a child was not already allowed.  This also
enables us to keep consistent allowed_parent* status, which is required
to get back to the reason of denial.

For internal mount points, only upgrade allowed_parent* to true but do
not wrongfully set both of them to false otherwise.  This is also
required to get back to the reason of denial.

This does not impact the current behavior but slightly optimize code and
prepare for audit support that needs to know the exact reason why an
access was denied.

Cc: Günther Noack <gnoack@google.com>
Link: https://lore.kernel.org/r/20250108154338.1129069-14-mic@digikod.net
Signed-off-by: Mickaël Salaün <mic@digikod.net>
(cherry picked from commit d617f0d72d8041c7099fd04a62db0f0fa5331c1a)
Stable-dep-of: 49c9e09d9610 ("landlock: Fix handling of disconnected directories")
Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
---
 security/landlock/fs.c | 44 ++++++++++++++++++++++++++----------------
 1 file changed, 27 insertions(+), 17 deletions(-)

diff --git a/security/landlock/fs.c b/security/landlock/fs.c
index 511e6ae8b79c..f0e94cb74fca 100644
--- a/security/landlock/fs.c
+++ b/security/landlock/fs.c
@@ -849,15 +849,6 @@ static bool is_access_to_paths_allowed(
 				     child1_is_directory, layer_masks_parent2,
 				     layer_masks_child2,
 				     child2_is_directory))) {
-			allowed_parent1 = scope_to_request(
-				access_request_parent1, layer_masks_parent1);
-			allowed_parent2 = scope_to_request(
-				access_request_parent2, layer_masks_parent2);
-
-			/* Stops when all accesses are granted. */
-			if (allowed_parent1 && allowed_parent2)
-				break;
-
 			/*
 			 * Now, downgrades the remaining checks from domain
 			 * handled accesses to requested accesses.
@@ -865,15 +856,32 @@ static bool is_access_to_paths_allowed(
 			is_dom_check = false;
 			access_masked_parent1 = access_request_parent1;
 			access_masked_parent2 = access_request_parent2;
+
+			allowed_parent1 =
+				allowed_parent1 ||
+				scope_to_request(access_masked_parent1,
+						 layer_masks_parent1);
+			allowed_parent2 =
+				allowed_parent2 ||
+				scope_to_request(access_masked_parent2,
+						 layer_masks_parent2);
+
+			/* Stops when all accesses are granted. */
+			if (allowed_parent1 && allowed_parent2)
+				break;
 		}
 
 		rule = find_rule(domain, walker_path.dentry);
-		allowed_parent1 = landlock_unmask_layers(
-			rule, access_masked_parent1, layer_masks_parent1,
-			ARRAY_SIZE(*layer_masks_parent1));
-		allowed_parent2 = landlock_unmask_layers(
-			rule, access_masked_parent2, layer_masks_parent2,
-			ARRAY_SIZE(*layer_masks_parent2));
+		allowed_parent1 = allowed_parent1 ||
+				  landlock_unmask_layers(
+					  rule, access_masked_parent1,
+					  layer_masks_parent1,
+					  ARRAY_SIZE(*layer_masks_parent1));
+		allowed_parent2 = allowed_parent2 ||
+				  landlock_unmask_layers(
+					  rule, access_masked_parent2,
+					  layer_masks_parent2,
+					  ARRAY_SIZE(*layer_masks_parent2));
 
 		/* Stops when a rule from each layer grants access. */
 		if (allowed_parent1 && allowed_parent2)
@@ -897,8 +905,10 @@ static bool is_access_to_paths_allowed(
 			 * access to internal filesystems (e.g. nsfs, which is
 			 * reachable through /proc/<pid>/ns/<namespace>).
 			 */
-			allowed_parent1 = allowed_parent2 =
-				!!(walker_path.mnt->mnt_flags & MNT_INTERNAL);
+			if (walker_path.mnt->mnt_flags & MNT_INTERNAL) {
+				allowed_parent1 = true;
+				allowed_parent2 = true;
+			}
 			break;
 		}
 		parent_dentry = dget_parent(walker_path.dentry);
-- 
2.50.1


