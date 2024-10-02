Return-Path: <stable+bounces-80565-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CD9C98DE94
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 17:14:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 902F81C22B4F
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 15:14:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5B921D0B93;
	Wed,  2 Oct 2024 15:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="aNFB676W"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C0491D0B97
	for <stable@vger.kernel.org>; Wed,  2 Oct 2024 15:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727882020; cv=none; b=g1lMcndA67ZnlRdXX3QdxD546BIDPCDHvrw0rMm6WNu3ZzOnGnsQeZss3O47S3DgkMk4q1qkTGUZOcmc9BrVctY44KI9jHavAn5P8OfzJ/Ufqgimq5qMA3S2S9MlrnRik5kR8Cb8IKW/P6OPtttk9zztGPmLfdY0uV0OBwZdSos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727882020; c=relaxed/simple;
	bh=Bq2isIoUKS0rDsCDCe6SujXKyZlu0uAedmAiTpvh96Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RlgHh4FsG8lQ4a0b9D1x4YKaPuyptNljP3wp7QIS+PkvVixeS0r77qopdWuWs3iifuzp1T5cogelT+HWW5k4duiT0aiN0YfbQhn/Ls0FUftDOnmCK9tnge1euvpdbMHY6eoxg5AQFBQPAHVs/WcFCjPw11igqGtqn+wZPn/JfEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=aNFB676W; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 492Cd4FE011655;
	Wed, 2 Oct 2024 15:13:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type:content-transfer-encoding; s=
	corp-2023-11-20; bh=GLg5ev2maIfh8+m+PapeyWJ9Qdey8XbXVVyEhSC0iA4=; b=
	aNFB676WpUzl2j3Z0Et88Yx3azme67uSLCNZXXvQEyMrpUOscMS/TilWLMfgF4fI
	ddeH7nwWk8Cn10yuobxhM5Zmgx+ZFZ/x1J9yWsF165wppKrmiOxS3qWtUHwRyu4a
	P5cjfDtFJ0YQtSg3++ihSRy1WtsK2Amtt3VASs1MElpUaFdtmDzSN++J23dE3/LC
	yl60YuhdLTu5eUnq745clPMrkqkpPfIEeG5wvqWcR5GMKohs8xy4CRVw1VNjtROm
	5W1Nk9wc2vzfz59uDl1odq5OSuW74LZ46VEiLkaG52paQ5ETLwdAz1Fj5w7MYpBb
	h3KWVv9Db95U8w755SgwSw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41x8k39psg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 02 Oct 2024 15:13:29 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 492EYo7g028438;
	Wed, 2 Oct 2024 15:13:28 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 41x8897a99-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 02 Oct 2024 15:13:02 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 492FCqrV028673;
	Wed, 2 Oct 2024 15:13:02 GMT
Received: from localhost.localdomain (dhcp-10-175-43-118.vpn.oracle.com [10.175.43.118])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 41x88979xb-2;
	Wed, 02 Oct 2024 15:13:01 +0000
From: Vegard Nossum <vegard.nossum@oracle.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, pavel@denx.de, cengiz.can@canonical.com,
        mheyne@amazon.de, mngyadam@amazon.com, kuntal.nayak@broadcom.com,
        ajay.kaher@broadcom.com, zsm@chromium.org, dan.carpenter@linaro.org,
        shivani.agarwal@broadcom.com, Mark Pearson <mpearson-lenovo@squebb.ca>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
        Vegard Nossum <vegard.nossum@oracle.com>
Subject: [PATCH RFC 6.6.y 12/15] platform/x86: think-lmi: Fix password opcode ordering for workstations
Date: Wed,  2 Oct 2024 17:12:33 +0200
Message-Id: <20241002151236.11787-2-vegard.nossum@oracle.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241002151236.11787-1-vegard.nossum@oracle.com>
References: <20241002150606.11385-1-vegard.nossum@oracle.com>
 <20241002151236.11787-1-vegard.nossum@oracle.com>
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
 definitions=2024-10-02_15,2024-09-30_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 malwarescore=0
 mlxlogscore=999 phishscore=0 suspectscore=0 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2408220000
 definitions=main-2410020111
X-Proofpoint-GUID: bQLn5R5l-TQHYdcDqfdTSLY6pxbaBNOQ
X-Proofpoint-ORIG-GUID: bQLn5R5l-TQHYdcDqfdTSLY6pxbaBNOQ

From: Mark Pearson <mpearson-lenovo@squebb.ca>

[ Upstream commit 6f7d0f5fd8e440c3446560100ac4ff9a55eec340 ]

The Lenovo workstations require the password opcode to be run before
the attribute value is changed (if Admin password is enabled).

Tested on some Thinkpads to confirm they are OK with this order too.

Signed-off-by: Mark Pearson <mpearson-lenovo@squebb.ca>
Fixes: 640a5fa50a42 ("platform/x86: think-lmi: Opcode support")
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Link: https://lore.kernel.org/r/20240209152359.528919-1-mpearson-lenovo@squebb.ca
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
(cherry picked from commit 6f7d0f5fd8e440c3446560100ac4ff9a55eec340)
[Harshit: CVE-2024-26836; Resolve conflicts due to missing commit:
 318d97849fc2 ("platform/x86: think-lmi: Add bulk save feature") which is
 not in 6.6.y]
Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Signed-off-by: Vegard Nossum <vegard.nossum@oracle.com>
---
 drivers/platform/x86/think-lmi.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/platform/x86/think-lmi.c b/drivers/platform/x86/think-lmi.c
index aee869769843f..2396decdb3cb3 100644
--- a/drivers/platform/x86/think-lmi.c
+++ b/drivers/platform/x86/think-lmi.c
@@ -1021,7 +1021,16 @@ static ssize_t current_value_store(struct kobject *kobj,
 		 * Note - this sets the variable and then the password as separate
 		 * WMI calls. Function tlmi_save_bios_settings will error if the
 		 * password is incorrect.
+		 * Workstation's require the opcode to be set before changing the
+		 * attribute.
 		 */
+		if (tlmi_priv.pwd_admin->valid && tlmi_priv.pwd_admin->password[0]) {
+			ret = tlmi_opcode_setting("WmiOpcodePasswordAdmin",
+						  tlmi_priv.pwd_admin->password);
+			if (ret)
+				goto out;
+		}
+
 		set_str = kasprintf(GFP_KERNEL, "%s,%s;", setting->display_name,
 				    new_setting);
 		if (!set_str) {
@@ -1033,13 +1042,6 @@ static ssize_t current_value_store(struct kobject *kobj,
 		if (ret)
 			goto out;
 
-		if (tlmi_priv.pwd_admin->valid && tlmi_priv.pwd_admin->password[0]) {
-			ret = tlmi_opcode_setting("WmiOpcodePasswordAdmin",
-						  tlmi_priv.pwd_admin->password);
-			if (ret)
-				goto out;
-		}
-
 		ret = tlmi_save_bios_settings("");
 	} else { /* old non-opcode based authentication method (deprecated) */
 		if (tlmi_priv.pwd_admin->valid && tlmi_priv.pwd_admin->password[0]) {
-- 
2.34.1


