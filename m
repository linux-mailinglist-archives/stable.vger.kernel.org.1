Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 601B37CCFFB
	for <lists+stable@lfdr.de>; Wed, 18 Oct 2023 00:23:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232068AbjJQWXE (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 17 Oct 2023 18:23:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230056AbjJQWXE (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 17 Oct 2023 18:23:04 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66810B0
        for <stable@vger.kernel.org>; Tue, 17 Oct 2023 15:23:02 -0700 (PDT)
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39HMML4B021509
        for <stable@vger.kernel.org>; Tue, 17 Oct 2023 22:23:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=l2VTJFPu1oH2KX+1eatbOkbzPHtf/200Y5yJa/Vcpx4=;
 b=Mat96BRuqWe0ALjKvmHTF8BNf/3BEBgHSfQHVTkGbFn/+lFw9h7tbYqrnHP1d8FsM2df
 UD3yTa07mrv/knQ+434TzXNeDmW2HqMr1jX16K2TSvE/YDN6qoWI/pUKN3o3iwlWpb4M
 hUKo4j7V5f2zFqtrcmewg00T4x9EoGRFypy4pwp+qSqgi91xxE+tL8wLDCdHO8sR8aw+
 /pDJZTa15HQi0ukqa+X206iginQXMrEU7KlNsT+Tm+JpF7HlCXE3NHk+/fWld0+hpsPl
 oPOzS0iDCzQIo6aK3wp2ri9do6G4OZ5mk1PLougmo19qkuHxwgUK0yjhWcP2yOUT1gFb Tg== 
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tt30k810a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <stable@vger.kernel.org>; Tue, 17 Oct 2023 22:23:01 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 39HL5wTH012871
        for <stable@vger.kernel.org>; Tue, 17 Oct 2023 22:23:00 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
        by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3tr5pycbmq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <stable@vger.kernel.org>; Tue, 17 Oct 2023 22:23:00 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
        by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 39HMMvwq56230242
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Oct 2023 22:22:57 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5861F58055;
        Tue, 17 Oct 2023 22:22:57 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6945E5804B;
        Tue, 17 Oct 2023 22:22:56 +0000 (GMT)
Received: from li-2c1e724c-2c76-11b2-a85c-ae42eaf3cb3d.ibm.com.com (unknown [9.61.47.87])
        by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 17 Oct 2023 22:22:56 +0000 (GMT)
From:   Tony Krowiak <akrowiak@linux.ibm.com>
To:     kvm390-list@tuxmaker.boeblingen.de.ibm.com
Cc:     freude@linux.ibm.com, pasic@linux.vnet.ibm.com,
        borntraeger@de.ibm.com, fiuczy@linux.ibm.com,
        jjherne@linux.ibm.com, mjrosato@linux.ibm.com,
        stable@vger.kernel.org
Subject: [RFC 1/7] s390/vfio-ap: always filter entire AP matrix
Date:   Tue, 17 Oct 2023 18:22:48 -0400
Message-ID: <20231017222254.68457-2-akrowiak@linux.ibm.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231017222254.68457-1-akrowiak@linux.ibm.com>
References: <20231017222254.68457-1-akrowiak@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: q-aVoZX27UdTvDXfBVgy5w0eh0NPXWFV
X-Proofpoint-ORIG-GUID: q-aVoZX27UdTvDXfBVgy5w0eh0NPXWFV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-17_06,2023-10-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 priorityscore=1501 malwarescore=0 clxscore=1015 mlxscore=0 phishscore=0
 suspectscore=0 impostorscore=0 spamscore=0 mlxlogscore=999
 lowpriorityscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2309180000 definitions=main-2310170189
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

The vfio_ap_mdev_filter_matrix function is called whenever a new adapter or
domain is assigned to the mdev. The purpose of the function is to update
the guest's AP configuration by filtering the matrix of adapters and
domains assigned to the mdev. When an adapter or domain is assigned, only
the APQNs associated with the APID of the new adapter or APQI of the new
domain are inspected. If an APQN does not reference a queue device bound to
the vfio_ap device driver, then it's APID will be filtered from the mdev's
matrix when updating the guest's AP configuration.

Inspecting only the APID of the new adapter or APQI of the new domain will
result in passing AP queues through to a guest that are not bound to the
vfio_ap device driver under certain circumstances. Consider the following:

guest's AP configuration (all also assigned to the mdev's matrix):
14.0004
14.0005
14.0006
16.0004
16.0005
16.0006

unassign domain 4
unbind queue 16.0005
assign domain 4

When domain 4 is re-assigned, since only domain 4 will be inspected, the
APQNs that will be examined will be:
14.0004
16.0004

Since both of those APQNs reference queue devices that are bound to the
vfio_ap device driver, nothing will get filtered from the mdev's matrix
when updating the guest's AP configuration. Consequently, queue 16.0005
will get passed through despite not being bound to the driver. This
violates the linux device model requirement that a guest shall only be
given access to devices bound to the device driver facilitating their
pass-through.

To resolve this problem, every adapter and domain assigned to the mdev will
be inspected when filtering the mdev's matrix.

Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
Fixes: 48cae940c31d ("s390/vfio-ap: refresh guest's APCB by filtering AP resources assigned to mdev")
Cc: <stable@vger.kernel.org>
---
 drivers/s390/crypto/vfio_ap_ops.c | 59 ++++++++++---------------------
 1 file changed, 18 insertions(+), 41 deletions(-)

diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
index 4db538a55192..e5490640e19c 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -670,8 +670,7 @@ static bool vfio_ap_mdev_filter_cdoms(struct ap_matrix_mdev *matrix_mdev)
  * Return: a boolean value indicating whether the KVM guest's APCB was changed
  *	   by the filtering or not.
  */
-static bool vfio_ap_mdev_filter_matrix(unsigned long *apm, unsigned long *aqm,
-				       struct ap_matrix_mdev *matrix_mdev)
+static bool vfio_ap_mdev_filter_matrix(struct ap_matrix_mdev *matrix_mdev)
 {
 	unsigned long apid, apqi, apqn;
 	DECLARE_BITMAP(prev_shadow_apm, AP_DEVICES);
@@ -692,8 +691,8 @@ static bool vfio_ap_mdev_filter_matrix(unsigned long *apm, unsigned long *aqm,
 	bitmap_and(matrix_mdev->shadow_apcb.aqm, matrix_mdev->matrix.aqm,
 		   (unsigned long *)matrix_dev->info.aqm, AP_DOMAINS);
 
-	for_each_set_bit_inv(apid, apm, AP_DEVICES) {
-		for_each_set_bit_inv(apqi, aqm, AP_DOMAINS) {
+	for_each_set_bit_inv(apid, matrix_mdev->matrix.apm, AP_DEVICES) {
+		for_each_set_bit_inv(apqi, matrix_mdev->matrix.aqm, AP_DOMAINS) {
 			/*
 			 * If the APQN is not bound to the vfio_ap device
 			 * driver, then we can't assign it to the guest's
@@ -958,7 +957,6 @@ static ssize_t assign_adapter_store(struct device *dev,
 {
 	int ret;
 	unsigned long apid;
-	DECLARE_BITMAP(apm_delta, AP_DEVICES);
 	struct ap_matrix_mdev *matrix_mdev = dev_get_drvdata(dev);
 
 	mutex_lock(&ap_perms_mutex);
@@ -987,11 +985,8 @@ static ssize_t assign_adapter_store(struct device *dev,
 	}
 
 	vfio_ap_mdev_link_adapter(matrix_mdev, apid);
-	memset(apm_delta, 0, sizeof(apm_delta));
-	set_bit_inv(apid, apm_delta);
 
-	if (vfio_ap_mdev_filter_matrix(apm_delta,
-				       matrix_mdev->matrix.aqm, matrix_mdev))
+	if (vfio_ap_mdev_filter_matrix(matrix_mdev))
 		vfio_ap_mdev_update_guest_apcb(matrix_mdev);
 
 	ret = count;
@@ -1167,7 +1162,6 @@ static ssize_t assign_domain_store(struct device *dev,
 {
 	int ret;
 	unsigned long apqi;
-	DECLARE_BITMAP(aqm_delta, AP_DOMAINS);
 	struct ap_matrix_mdev *matrix_mdev = dev_get_drvdata(dev);
 
 	mutex_lock(&ap_perms_mutex);
@@ -1196,11 +1190,8 @@ static ssize_t assign_domain_store(struct device *dev,
 	}
 
 	vfio_ap_mdev_link_domain(matrix_mdev, apqi);
-	memset(aqm_delta, 0, sizeof(aqm_delta));
-	set_bit_inv(apqi, aqm_delta);
 
-	if (vfio_ap_mdev_filter_matrix(matrix_mdev->matrix.apm, aqm_delta,
-				       matrix_mdev))
+	if (vfio_ap_mdev_filter_matrix(matrix_mdev))
 		vfio_ap_mdev_update_guest_apcb(matrix_mdev);
 
 	ret = count;
@@ -2091,9 +2082,7 @@ int vfio_ap_mdev_probe_queue(struct ap_device *apdev)
 	if (matrix_mdev) {
 		vfio_ap_mdev_link_queue(matrix_mdev, q);
 
-		if (vfio_ap_mdev_filter_matrix(matrix_mdev->matrix.apm,
-					       matrix_mdev->matrix.aqm,
-					       matrix_mdev))
+		if (vfio_ap_mdev_filter_matrix(matrix_mdev))
 			vfio_ap_mdev_update_guest_apcb(matrix_mdev);
 	}
 	dev_set_drvdata(&apdev->device, q);
@@ -2443,35 +2432,23 @@ void vfio_ap_on_cfg_changed(struct ap_config_info *cur_cfg_info,
 
 static void vfio_ap_mdev_hot_plug_cfg(struct ap_matrix_mdev *matrix_mdev)
 {
-	bool do_hotplug = false;
-	int filter_domains = 0;
-	int filter_adapters = 0;
-	DECLARE_BITMAP(apm, AP_DEVICES);
-	DECLARE_BITMAP(aqm, AP_DOMAINS);
+	bool filter_domains, filter_adapters, filter_cdoms, do_hotplug = false;
 
 	mutex_lock(&matrix_mdev->kvm->lock);
 	mutex_lock(&matrix_dev->mdevs_lock);
 
-	filter_adapters = bitmap_and(apm, matrix_mdev->matrix.apm,
-				     matrix_mdev->apm_add, AP_DEVICES);
-	filter_domains = bitmap_and(aqm, matrix_mdev->matrix.aqm,
-				    matrix_mdev->aqm_add, AP_DOMAINS);
-
-	if (filter_adapters && filter_domains)
-		do_hotplug |= vfio_ap_mdev_filter_matrix(apm, aqm, matrix_mdev);
-	else if (filter_adapters)
-		do_hotplug |=
-			vfio_ap_mdev_filter_matrix(apm,
-						   matrix_mdev->shadow_apcb.aqm,
-						   matrix_mdev);
-	else
-		do_hotplug |=
-			vfio_ap_mdev_filter_matrix(matrix_mdev->shadow_apcb.apm,
-						   aqm, matrix_mdev);
+	filter_adapters = bitmap_intersects(matrix_mdev->matrix.apm,
+					    matrix_mdev->apm_add, AP_DEVICES);
+	filter_domains = bitmap_intersects(matrix_mdev->matrix.aqm,
+					   matrix_mdev->aqm_add, AP_DOMAINS);
+	filter_cdoms = bitmap_intersects(matrix_mdev->matrix.adm,
+					 matrix_mdev->adm_add, AP_DOMAINS);
+
+	if (filter_adapters || filter_domains)
+		do_hotplug = vfio_ap_mdev_filter_matrix(matrix_mdev);
 
-	if (bitmap_intersects(matrix_mdev->matrix.adm, matrix_mdev->adm_add,
-			      AP_DOMAINS))
-		do_hotplug |= vfio_ap_mdev_filter_cdoms(matrix_mdev);
+	if (filter_cdoms)
+		do_hotplug = vfio_ap_mdev_filter_cdoms(matrix_mdev);
 
 	if (do_hotplug)
 		vfio_ap_mdev_update_guest_apcb(matrix_mdev);
-- 
2.41.0

