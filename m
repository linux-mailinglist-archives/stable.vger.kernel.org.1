Return-Path: <stable+bounces-158606-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF363AE886D
	for <lists+stable@lfdr.de>; Wed, 25 Jun 2025 17:43:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CAD6166BEF
	for <lists+stable@lfdr.de>; Wed, 25 Jun 2025 15:42:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6442026A08D;
	Wed, 25 Jun 2025 15:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="KaqNQYYE"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A71828466E
	for <stable@vger.kernel.org>; Wed, 25 Jun 2025 15:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750866171; cv=none; b=XtHaOGLiw3BsNr4F4j7rruY4rUUW+1xFI6JmA3pz24ZdZAs++m1j2tQvX0OwoXINTWcu5q4LKxIXxs3fQHgLCgGje+oBWH9hzmYz5LnhJK9rLj2n6sedMVZodKXlIebxFpc9SuL3ernSoD+jWGwx4XYT5h+e2NZ2mRgqZEtNvzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750866171; c=relaxed/simple;
	bh=wkTHmKIuR29zpTWvaK7MkfRQFG89dAt06Z5/StrvTxA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Y67f62omWlJ3VaXl/sALJJ6L+6Zj/ytM71k6G2M8hAkD0bA1pqdMrPPUjI2GarAfectUQNKOA36jhoD7q2eDJUXx7QBc+GkHopvW6mKcxDhsU0/wFIRCBLEDaBwq6WyIADA7HJOFOTjNrUHp3fQQ1JP6C6VqVQp7NQ4+LJhFIWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=KaqNQYYE; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55PFC2UJ031219;
	Wed, 25 Jun 2025 15:42:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=wvTzkcQHol/BgYli2meyocUmdSG4y
	UShkjNNBJoQizY=; b=KaqNQYYEFc2/AhALWFLfH56gqsODgEdhmQPCMnZAbUxju
	Eie/pMfrYFpa522CKqVhEMFh1ydFupVhvFQwSp8nQ4XMTu35XB5vmlk8Osx7r/Ln
	JUzLS3XivSqjJqLt2mUDvKHPKPvLcxrnReGT/wsHucPoRVTpdH4XVP95DvsBaaYV
	LfCfyFP2s+uT1rsvnxCT+bNydUdBSssMUM/Q/fqNzXn+rinB9s0cx1UI+KLXjRYl
	uhJNVTp25TnIXOHwDuIyxW1b/JppLTIPhinWgs6bo+bsW6c9sGEvXUXcmjj3YJcl
	sWfwz1ziJwF8DoqQ4elXNF9FhtLjX4/p4eZH30fCw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47ds87yuym-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 25 Jun 2025 15:42:46 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55PEXR4v037984;
	Wed, 25 Jun 2025 15:42:45 GMT
Received: from ca-dev110.us.oracle.com (ca-dev110.us.oracle.com [10.129.136.45])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 47ehperc17-1;
	Wed, 25 Jun 2025 15:42:45 +0000
From: Larry Bassel <larry.bassel@oracle.com>
To: stable@vger.kernel.org
Cc: jlee@suse.com, rafael.j.wysocki@intel.com
Subject: [PATCH 5.15.y] thermal/int340x_thermal: handle data_vault when the value is ZERO_SIZE_PTR
Date: Wed, 25 Jun 2025 08:42:17 -0700
Message-ID: <20250625154217.215744-1-larry.bassel@oracle.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-25_04,2025-06-25_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 suspectscore=0 spamscore=0 mlxlogscore=999 mlxscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2506250114
X-Authority-Analysis: v=2.4 cv=a8gw9VSF c=1 sm=1 tr=0 ts=685c18f6 b=1 cx=c_pps a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17 a=6IFa9wvqVegA:10 a=pGLkceISAAAA:8 a=iox4zFpeAAAA:8 a=QyXUC8HyAAAA:8 a=yPCof4ZbAAAA:8 a=jsP5_mamT8ZzNc7Yj0AA:9
 a=WzC6qhA0u3u7Ye7llzcV:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI1MDExNiBTYWx0ZWRfX5qr+6Ajo7Tfs luRY3JmI8zrYqR8OrcPBJ3Q2TybdEsCTjnxlwtDZARPrsxnt1g1efInG/ALIgdfVk4mdE88jDTB 6TPpGOvrZOBla5C0JoR9haMaE9D53N/edgCdS93F1w3B7kJz0BzQMc1wvVfVt8HNrQnpULn2aXN
 qg2OiqTKEEYGmrJAnLqulD8aN/arORv69lNbC2l+GFjqOTUl1xMNMP/ifOkf9LnA/bwLSSSfn9E KrfIkbt9puhNjDzQdqtSWseQ0+Bnvk8heabNPQjT+VAqfOgUZtE9jHYJeh7ER6gvqd68TYJr84A AfL4wkmYrHCX7LA5KB4aEEL8pi3jvubq7joIIVqGzwqE+ml1YCt+Vr5rADoUj9mCVlz+rvWbfHs
 jXi/RaxwlHndHx2zbuSgZ48pFCc56oRCbYz9gyBdko9Y6JfqRY8Ev4fYPCQeDlBDKSDSLyYZ
X-Proofpoint-GUID: P3Im2dYoLlw1CpR_p-999lnYUIzfTAiK
X-Proofpoint-ORIG-GUID: P3Im2dYoLlw1CpR_p-999lnYUIzfTAiK

From: "Lee, Chun-Yi" <joeyli.kernel@gmail.com>

[ Upstream commit 7931e28098a4c1a2a6802510b0cbe57546d2049d ]

In some case, the GDDV returns a package with a buffer which has
zero length. It causes that kmemdup() returns ZERO_SIZE_PTR (0x10).

Then the data_vault_read() got NULL point dereference problem when
accessing the 0x10 value in data_vault.

[   71.024560] BUG: kernel NULL pointer dereference, address:
0000000000000010

This patch uses ZERO_OR_NULL_PTR() for checking ZERO_SIZE_PTR or
NULL value in data_vault.

Signed-off-by: "Lee, Chun-Yi" <jlee@suse.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
(cherry picked from commit 7931e28098a4c1a2a6802510b0cbe57546d2049d)
[Larry: backport to 5.15.y. Minor conflict resolved due to missing commit 9e5d3d6be664
thermal: int340x: Consolidate freeing of acpi_buffer pointer]
Signed-off-by: Larry Bassel <larry.bassel@oracle.com>
---
 drivers/thermal/intel/int340x_thermal/int3400_thermal.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/intel/int340x_thermal/int3400_thermal.c b/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
index 6aa5fe973613..1c479c72b7d2 100644
--- a/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
+++ b/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
@@ -469,7 +469,7 @@ static void int3400_setup_gddv(struct int3400_thermal_priv *priv)
 	priv->data_vault = kmemdup(obj->package.elements[0].buffer.pointer,
 				   obj->package.elements[0].buffer.length,
 				   GFP_KERNEL);
-	if (!priv->data_vault) {
+	if (ZERO_OR_NULL_PTR(priv->data_vault)) {
 		kfree(buffer.pointer);
 		return;
 	}
@@ -540,7 +540,7 @@ static int int3400_thermal_probe(struct platform_device *pdev)
 			goto free_imok;
 	}
 
-	if (priv->data_vault) {
+	if (!ZERO_OR_NULL_PTR(priv->data_vault)) {
 		result = sysfs_create_group(&pdev->dev.kobj,
 					    &data_attribute_group);
 		if (result)
@@ -558,7 +558,8 @@ static int int3400_thermal_probe(struct platform_device *pdev)
 free_sysfs:
 	cleanup_odvp(priv);
 	if (priv->data_vault) {
-		sysfs_remove_group(&pdev->dev.kobj, &data_attribute_group);
+		if (!ZERO_OR_NULL_PTR(priv->data_vault))
+			sysfs_remove_group(&pdev->dev.kobj, &data_attribute_group);
 		kfree(priv->data_vault);
 	}
 free_uuid:
@@ -590,7 +591,7 @@ static int int3400_thermal_remove(struct platform_device *pdev)
 	if (!priv->rel_misc_dev_res)
 		acpi_thermal_rel_misc_device_remove(priv->adev->handle);
 
-	if (priv->data_vault)
+	if (!ZERO_OR_NULL_PTR(priv->data_vault))
 		sysfs_remove_group(&pdev->dev.kobj, &data_attribute_group);
 	sysfs_remove_group(&pdev->dev.kobj, &uuid_attribute_group);
 	sysfs_remove_group(&pdev->dev.kobj, &imok_attribute_group);
-- 
2.46.0


