Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6BC979F2DA
	for <lists+stable@lfdr.de>; Wed, 13 Sep 2023 22:28:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231195AbjIMU2k (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 13 Sep 2023 16:28:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231167AbjIMU2k (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 13 Sep 2023 16:28:40 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0DD71BC6
        for <stable@vger.kernel.org>; Wed, 13 Sep 2023 13:28:36 -0700 (PDT)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38DIRYT8030966
        for <stable@vger.kernel.org>; Wed, 13 Sep 2023 13:28:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=s2048-2021-q4;
 bh=7dLqCoT6WQqD17hGiU5LCbKgrBgxInsnOmHnTNHPGqw=;
 b=YhKQBP4kUZn/5OXXL6Mwo1twidUc4EaOGKGYi4hdJFcBPnT0MNx07Jrs2NkBvMuVTudp
 JvfgljUQHN7M2TwqosangTXxEISFFvjXRs6lJnxVKGTqV25o0l5l0siawnT+FyKVV0Cm
 wmy++6VTbo8DiuTcTQlgF6amgNB+8qecTQx/1qCuJirWbalVZqwjU/3ikUaYl1TrvTi4
 1NFCl569fo1lC2RO0rPDVUgxv1vrnVyWs6cJvRC5lCqoxNZltZNZsLukt9PZTCO1/LGN
 ECNCKxy0nx96QbQ7jOwFE3NjGCHupSFEnGjpCa6QEtEr0Z7Bq02KcWhkOSfv3Xe0CjHh +Q== 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3t2y8tkyh6-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <stable@vger.kernel.org>; Wed, 13 Sep 2023 13:28:36 -0700
Received: from twshared10465.02.ash9.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:11d::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 13 Sep 2023 13:28:34 -0700
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
        id 1C9F21E9E7481; Wed, 13 Sep 2023 13:28:23 -0700 (PDT)
From:   Keith Busch <kbusch@meta.com>
To:     <linux-nvme@lists.infradead.org>, <hch@lst.de>
CC:     Keith Busch <kbusch@kernel.org>,
        =?UTF-8?q?Cl=C3=A1udio=20Sampaio?= <patola@gmail.com>,
        Felix Yan <felixonmars@archlinux.org>,
        Sagi Grimberg <sagi@grimberg.me>, <stable@vger.kernel.org>
Subject: [PATCHv2] nvme: avoid bogus CRTO values
Date:   Wed, 13 Sep 2023 13:28:10 -0700
Message-ID: <20230913202810.2631288-1-kbusch@meta.com>
X-Mailer: git-send-email 2.34.1
Content-Type: text/plain; charset="UTF-8"
X-FB-Internal: Safe
X-Proofpoint-GUID: 3tfRNYTmqqqRc5fH0UuShtwg6ycUriJZ
X-Proofpoint-ORIG-GUID: 3tfRNYTmqqqRc5fH0UuShtwg6ycUriJZ
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-13_15,2023-09-13_01,2023-05-22_02
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Keith Busch <kbusch@kernel.org>

Some devices are reporting Controller Ready Modes Supported, but return
0 for CRTO. These devices require a much higher time to ready than that,
so they are failing to initialize after the driver started preferring
that value over CAP.TO.

The spec requires CAP.TO match the appropritate CRTO value, or be set to
0xff if CRTO is larger than that. This means that CAP.TO can be used to
validate if CRTO is reliable, and provides an appropriate fallback for
setting the timeout value if not. Use whichever is larger.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D217863
Reported-by: Cl=C3=A1udio Sampaio <patola@gmail.com>
Reported-by: Felix Yan <felixonmars@archlinux.org>
Based-on-a-patch-by: Felix Yan <felixonmars@archlinux.org>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Cc: stable@vger.kernel.org
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
v1->v2:
  Warn once if driver isn't relying on CRTO values

 drivers/nvme/host/core.c | 54 ++++++++++++++++++++++++++--------------
 1 file changed, 35 insertions(+), 19 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 37b6fa7466620..0685ed4f2dc49 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2245,25 +2245,8 @@ int nvme_enable_ctrl(struct nvme_ctrl *ctrl)
 	else
 		ctrl->ctrl_config =3D NVME_CC_CSS_NVM;
=20
-	if (ctrl->cap & NVME_CAP_CRMS_CRWMS) {
-		u32 crto;
-
-		ret =3D ctrl->ops->reg_read32(ctrl, NVME_REG_CRTO, &crto);
-		if (ret) {
-			dev_err(ctrl->device, "Reading CRTO failed (%d)\n",
-				ret);
-			return ret;
-		}
-
-		if (ctrl->cap & NVME_CAP_CRMS_CRIMS) {
-			ctrl->ctrl_config |=3D NVME_CC_CRIME;
-			timeout =3D NVME_CRTO_CRIMT(crto);
-		} else {
-			timeout =3D NVME_CRTO_CRWMT(crto);
-		}
-	} else {
-		timeout =3D NVME_CAP_TIMEOUT(ctrl->cap);
-	}
+	if (ctrl->cap & NVME_CAP_CRMS_CRWMS && ctrl->cap & NVME_CAP_CRMS_CRIMS)
+		ctrl->ctrl_config |=3D NVME_CC_CRIME;
=20
 	ctrl->ctrl_config |=3D (NVME_CTRL_PAGE_SHIFT - 12) << NVME_CC_MPS_SHIFT;
 	ctrl->ctrl_config |=3D NVME_CC_AMS_RR | NVME_CC_SHN_NONE;
@@ -2277,6 +2260,39 @@ int nvme_enable_ctrl(struct nvme_ctrl *ctrl)
 	if (ret)
 		return ret;
=20
+	/* CAP value may change after initial CC write */
+	ret =3D ctrl->ops->reg_read64(ctrl, NVME_REG_CAP, &ctrl->cap);
+	if (ret)
+		return ret;
+
+	timeout =3D NVME_CAP_TIMEOUT(ctrl->cap);
+	if (ctrl->cap & NVME_CAP_CRMS_CRWMS) {
+		u32 crto, ready_timeout;
+
+		ret =3D ctrl->ops->reg_read32(ctrl, NVME_REG_CRTO, &crto);
+		if (ret) {
+			dev_err(ctrl->device, "Reading CRTO failed (%d)\n",
+				ret);
+			return ret;
+		}
+
+		/*
+		 * CRTO should always be greater or equal to CAP.TO, but some
+		 * devices are known to get this wrong. Use the larger of the
+		 * two values.
+		 */
+		if (ctrl->ctrl_config & NVME_CC_CRIME)
+			ready_timeout =3D NVME_CRTO_CRIMT(crto);
+		else
+			ready_timeout =3D NVME_CRTO_CRWMT(crto);
+
+		if (ready_timeout < timeout)
+			dev_warn_once(ctrl->device, "bad crto:%x cap:%llx\n",
+				      crto, ctrl->cap);
+		else
+			timeout =3D ready_timeout;
+	}
+
 	ctrl->ctrl_config |=3D NVME_CC_ENABLE;
 	ret =3D ctrl->ops->reg_write32(ctrl, NVME_REG_CC, ctrl->ctrl_config);
 	if (ret)
--=20
2.34.1

