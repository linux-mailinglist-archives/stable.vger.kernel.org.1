Return-Path: <stable+bounces-83486-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 43BD199AAB8
	for <lists+stable@lfdr.de>; Fri, 11 Oct 2024 19:55:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C086F1F22B22
	for <lists+stable@lfdr.de>; Fri, 11 Oct 2024 17:55:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD5F61BB6BB;
	Fri, 11 Oct 2024 17:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="e8Ydhu3N"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6699195811;
	Fri, 11 Oct 2024 17:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728669335; cv=none; b=HdWabj67lPzLZJlOPKXwIm8T6yYrFrk/ujncq2SWfxB/Yz/cjCUjcwR9B8iM762JUBR78y51Qx1hh2/y+OxcdGkn3BLfPBogzuFjfmL8zdFuRJceP/7LKQfND10KUXrMODc9JwaxKo58BuINQD42+ROHHSjs1EvgA6RuQoR9A+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728669335; c=relaxed/simple;
	bh=CT798ZPWR9VTz5Dx5l8Vw/iGAKdOvqGkdEaOVACV7PE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CFPwytz/+oAwupK3MtRMcERiuBX2maSJNT4kMLDoxHzf1M+C2vSVD7r+aH5LLchS/h6pMFDESzVFaF4U5sHWa5loqgM8fboKvMxYTeU2Mfx/SP79uqjRhCBsdbRsHKRUkHNYP08j21Gg3dbz5OExnuTXdSyYN4xsY+wLuXN2/vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=e8Ydhu3N; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49BCpY5t029765;
	Fri, 11 Oct 2024 17:55:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2023-11-20; bh=pyICVjXcybLbovmc
	CE7Wu349rBpWSS3W1If9knEy2+4=; b=e8Ydhu3N5kJpQGAs9+RIfsxBtQbLtfyP
	VrEW+Z3GN9pNfuMFJKXsGBtSAJ/yai+wPXFkn37K11KF244D9O7fIFrk2b4mOIHp
	JmeGjwqDMkvrKopUBd47m8K8BhQhSrJjpP2EkiKzbU1ns4t6aqzIN6ns8sc6jd4u
	ID1pTO+Xrk/KXXdRLWEkU5NGJ357rS/8dbY4ZBeZ4qvmmF4q79k75PhKLeIctIqW
	R3RuLdzEq94ecEinxLIgXjZyMlP2V7D6tJ31GuKPpFp8q14PI9dAahE14tooxkgP
	WX32PuuSyTbuSlWMUkHheIgMHjLxHY2g81HpC7pdTx9B0xiTWkIwgg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42308dwh9b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 11 Oct 2024 17:55:25 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49BGAPaE005946;
	Fri, 11 Oct 2024 17:55:24 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 422uwbkbvc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 11 Oct 2024 17:55:24 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 49BHtOev021019;
	Fri, 11 Oct 2024 17:55:24 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 422uwbkbue-1;
	Fri, 11 Oct 2024 17:55:23 +0000
From: Sherry Yang <sherry.yang@oracle.com>
To: stable@vger.kernel.org, sashal@kernel.org, gregkh@linuxfoundation.org
Cc: kenneth.t.chan@gmail.com, hdegoede@redhat.com, mgross@linux.intel.com,
        xi.wang@gmail.com, mjg@redhat.com, platform-driver-x86@vger.kernel.org,
        sherry.yang@oracle.com
Subject: [PATCH 5.15.y] platform/x86: panasonic-laptop: Fix SINF array out of bounds accesses
Date: Fri, 11 Oct 2024 10:55:21 -0700
Message-ID: <20241011175521.1758191-1-sherry.yang@oracle.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-11_15,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0
 mlxlogscore=999 mlxscore=0 suspectscore=0 adultscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410110124
X-Proofpoint-ORIG-GUID: 0Y2H9Qx-AfOVMo7DmiNdzEaBPbCekNU3
X-Proofpoint-GUID: 0Y2H9Qx-AfOVMo7DmiNdzEaBPbCekNU3

From: Hans de Goede <hdegoede@redhat.com>

commit f52e98d16e9bd7dd2b3aef8e38db5cbc9899d6a4 upstream.

The panasonic laptop code in various places uses the SINF array with index
values of 0 - SINF_CUR_BRIGHT(0x0d) without checking that the SINF array
is big enough.

Not all panasonic laptops have this many SINF array entries, for example
the Toughbook CF-18 model only has 10 SINF array entries. So it only
supports the AC+DC brightness entries and mute.

Check that the SINF array has a minimum size which covers all AC+DC
brightness entries and refuse to load if the SINF array is smaller.

For higher SINF indexes hide the sysfs attributes when the SINF array
does not contain an entry for that attribute, avoiding show()/store()
accessing the array out of bounds and add bounds checking to the probe()
and resume() code accessing these.

Fixes: e424fb8cc4e6 ("panasonic-laptop: avoid overflow in acpi_pcc_hotkey_add()")
Cc: stable@vger.kernel.org
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Link: https://lore.kernel.org/r/20240909113227.254470-1-hdegoede@redhat.com
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[Sherry: clean cherry-pick backport, fix CVE-2024-46859]
Signed-off-by: Sherry Yang <sherry.yang@oracle.com>
---
 drivers/platform/x86/panasonic-laptop.c | 49 ++++++++++++++++++++-----
 1 file changed, 39 insertions(+), 10 deletions(-)

diff --git a/drivers/platform/x86/panasonic-laptop.c b/drivers/platform/x86/panasonic-laptop.c
index 7ca49b3fc6c2..b06382dcecf7 100644
--- a/drivers/platform/x86/panasonic-laptop.c
+++ b/drivers/platform/x86/panasonic-laptop.c
@@ -773,6 +773,24 @@ static DEVICE_ATTR_RW(dc_brightness);
 static DEVICE_ATTR_RW(current_brightness);
 static DEVICE_ATTR_RW(cdpower);
 
+static umode_t pcc_sysfs_is_visible(struct kobject *kobj, struct attribute *attr, int idx)
+{
+	struct device *dev = kobj_to_dev(kobj);
+	struct acpi_device *acpi = to_acpi_device(dev);
+	struct pcc_acpi *pcc = acpi_driver_data(acpi);
+
+	if (attr == &dev_attr_mute.attr)
+		return (pcc->num_sifr > SINF_MUTE) ? attr->mode : 0;
+
+	if (attr == &dev_attr_eco_mode.attr)
+		return (pcc->num_sifr > SINF_ECO_MODE) ? attr->mode : 0;
+
+	if (attr == &dev_attr_current_brightness.attr)
+		return (pcc->num_sifr > SINF_CUR_BRIGHT) ? attr->mode : 0;
+
+	return attr->mode;
+}
+
 static struct attribute *pcc_sysfs_entries[] = {
 	&dev_attr_numbatt.attr,
 	&dev_attr_lcdtype.attr,
@@ -787,8 +805,9 @@ static struct attribute *pcc_sysfs_entries[] = {
 };
 
 static const struct attribute_group pcc_attr_group = {
-	.name	= NULL,		/* put in device directory */
-	.attrs	= pcc_sysfs_entries,
+	.name		= NULL,		/* put in device directory */
+	.attrs		= pcc_sysfs_entries,
+	.is_visible	= pcc_sysfs_is_visible,
 };
 
 
@@ -941,12 +960,15 @@ static int acpi_pcc_hotkey_resume(struct device *dev)
 	if (!pcc)
 		return -EINVAL;
 
-	acpi_pcc_write_sset(pcc, SINF_MUTE, pcc->mute);
-	acpi_pcc_write_sset(pcc, SINF_ECO_MODE, pcc->eco_mode);
+	if (pcc->num_sifr > SINF_MUTE)
+		acpi_pcc_write_sset(pcc, SINF_MUTE, pcc->mute);
+	if (pcc->num_sifr > SINF_ECO_MODE)
+		acpi_pcc_write_sset(pcc, SINF_ECO_MODE, pcc->eco_mode);
 	acpi_pcc_write_sset(pcc, SINF_STICKY_KEY, pcc->sticky_key);
 	acpi_pcc_write_sset(pcc, SINF_AC_CUR_BRIGHT, pcc->ac_brightness);
 	acpi_pcc_write_sset(pcc, SINF_DC_CUR_BRIGHT, pcc->dc_brightness);
-	acpi_pcc_write_sset(pcc, SINF_CUR_BRIGHT, pcc->current_brightness);
+	if (pcc->num_sifr > SINF_CUR_BRIGHT)
+		acpi_pcc_write_sset(pcc, SINF_CUR_BRIGHT, pcc->current_brightness);
 
 	return 0;
 }
@@ -963,8 +985,12 @@ static int acpi_pcc_hotkey_add(struct acpi_device *device)
 
 	num_sifr = acpi_pcc_get_sqty(device);
 
-	if (num_sifr < 0 || num_sifr > 255) {
-		pr_err("num_sifr out of range");
+	/*
+	 * pcc->sinf is expected to at least have the AC+DC brightness entries.
+	 * Accesses to higher SINF entries are checked against num_sifr.
+	 */
+	if (num_sifr <= SINF_DC_CUR_BRIGHT || num_sifr > 255) {
+		pr_err("num_sifr %d out of range %d - 255\n", num_sifr, SINF_DC_CUR_BRIGHT + 1);
 		return -ENODEV;
 	}
 
@@ -1016,11 +1042,14 @@ static int acpi_pcc_hotkey_add(struct acpi_device *device)
 	acpi_pcc_write_sset(pcc, SINF_STICKY_KEY, 0);
 	pcc->sticky_key = 0;
 
-	pcc->eco_mode = pcc->sinf[SINF_ECO_MODE];
-	pcc->mute = pcc->sinf[SINF_MUTE];
 	pcc->ac_brightness = pcc->sinf[SINF_AC_CUR_BRIGHT];
 	pcc->dc_brightness = pcc->sinf[SINF_DC_CUR_BRIGHT];
-	pcc->current_brightness = pcc->sinf[SINF_CUR_BRIGHT];
+	if (pcc->num_sifr > SINF_MUTE)
+		pcc->mute = pcc->sinf[SINF_MUTE];
+	if (pcc->num_sifr > SINF_ECO_MODE)
+		pcc->eco_mode = pcc->sinf[SINF_ECO_MODE];
+	if (pcc->num_sifr > SINF_CUR_BRIGHT)
+		pcc->current_brightness = pcc->sinf[SINF_CUR_BRIGHT];
 
 	/* add sysfs attributes */
 	result = sysfs_create_group(&device->dev.kobj, &pcc_attr_group);
-- 
2.46.0


