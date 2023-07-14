Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05804753D99
	for <lists+stable@lfdr.de>; Fri, 14 Jul 2023 16:36:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236056AbjGNOgt (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 14 Jul 2023 10:36:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236069AbjGNOgp (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 14 Jul 2023 10:36:45 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9D011FC4
        for <stable@vger.kernel.org>; Fri, 14 Jul 2023 07:36:41 -0700 (PDT)
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36EEMBl8018890
        for <stable@vger.kernel.org>; Fri, 14 Jul 2023 14:36:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=TZ6zolUdkoELCJqniZVe02+RTPdGjLrGNshYyOx7wqs=;
 b=jP460xNMVQRoA8HRFpCTJPe9GLwTW3+7nSMj2uEdiS6EvJ5Sb1x9z+HtIAX7tn9It2b2
 o3rOg2EMA7NeyezZNhM7lMezGc9tiK0ZUAA27g9ycOsFGlOZwIOaogwTjXdcuUdNG6x9
 IGeeXQZ5TOICTr2umqjgakTeU+dHPuBPZF3rKVChtq7S9hlSINV8BBsSt3DgBLnIRgRp
 mrmEKJQR2gTnPtNj0/UCNSGwab5Y+4vAKM9pdepdQJkcijGf6qVtVzw2W2RFTvbn009V
 1U8UrvSDaeK/5S6YVB4LhfK0288dnJkL01aOkPJcrSrnJT8fs8haJ2YhvqVRbT37D8rd dg== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ru82kga3n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <stable@vger.kernel.org>; Fri, 14 Jul 2023 14:36:41 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 36E6VZps004553
        for <stable@vger.kernel.org>; Fri, 14 Jul 2023 14:36:39 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
        by ppma06ams.nl.ibm.com (PPS) with ESMTPS id 3rtqk18cty-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <stable@vger.kernel.org>; Fri, 14 Jul 2023 14:36:38 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
        by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 36EEaZGM60096882
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 Jul 2023 14:36:35 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3B96220049;
        Fri, 14 Jul 2023 14:36:35 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F17D220040;
        Fri, 14 Jul 2023 14:36:34 +0000 (GMT)
Received: from funtu2.fritz.box?044ibm.com (unknown [9.171.86.206])
        by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Fri, 14 Jul 2023 14:36:34 +0000 (GMT)
From:   Harald Freudenberger <freude@linux.ibm.com>
To:     linux390-list@tuxmaker.boeblingen.de.ibm.com, dengler@linux.ibm.com
Cc:     Harald Freudenberger <freude@linux.ibm.com>, stable@vger.kernel.org
Subject: [PATCH v2] s390/zcrypt: fix reply buffer calculations for CCA replies
Date:   Fri, 14 Jul 2023 16:36:30 +0200
Message-Id: <20230714143630.457866-1-freude@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: gCy87yZhoVQi_LzDJHl5mvsp_dQMJZm-
X-Proofpoint-GUID: gCy87yZhoVQi_LzDJHl5mvsp_dQMJZm-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-14_06,2023-07-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 bulkscore=0 spamscore=0 impostorscore=0 phishscore=0
 priorityscore=1501 mlxscore=0 mlxlogscore=999 malwarescore=0 clxscore=1011
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307140132
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

The length information for available buffer space for CCA
replies is covered with two fields in the T6 header prepended
on each CCA reply: fromcardlen1 and fromcardlen2. The sum of
these both values must not exceed the AP bus limit for this
card (24KB for CEX8, 12KB CEX7 and older) minus the always
present headers.

The current code adjusted the fromcardlen2 value in case
of exceeding the AP bus limit when there was a non-zero
value given from userspace. Some tests now showed that this
was the wrong assumption. Instead the userspace value given for
this field should always be trusted and if the sum of the
wo fields exceeds the AP bus limit for this card the first
field fromcardlen1 should be adjusted instead.

So now the calculation is done with this new insight in mind.
Also some additional checks for overflow have been introduced
and some comments to provide some documentation for future
maintainers of this complicated calculation code.

Furthermore the 128 bytes of fix overhead which is used
in the current code is not correct. Investications showed
that for a reply always the same two header structs are
prepended before a possible payload. So this is also fixed
with this patch.

Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
Cc: stable@vger.kernel.org
---
 drivers/s390/crypto/zcrypt_msgtype6.c | 45 ++++++++++++++++++++-------
 1 file changed, 33 insertions(+), 12 deletions(-)

diff --git a/drivers/s390/crypto/zcrypt_msgtype6.c b/drivers/s390/crypto/zcrypt_msgtype6.c
index 247f0ad38362..5ac110669327 100644
--- a/drivers/s390/crypto/zcrypt_msgtype6.c
+++ b/drivers/s390/crypto/zcrypt_msgtype6.c
@@ -551,6 +551,12 @@ static int xcrb_msg_to_type6_ep11cprb_msgx(bool userspace, struct ap_message *ap
  *
  * Returns 0 on success or -EINVAL, -EFAULT, -EAGAIN in case of an error.
  */
+struct type86_reply_hdrs {
+	struct type86_hdr hdr;
+	struct type86_fmt2_ext fmt2;
+	/* ... payload may follow ... */
+} __packed;
+
 struct type86x_reply {
 	struct type86_hdr hdr;
 	struct type86_fmt2_ext fmt2;
@@ -1101,23 +1107,38 @@ static long zcrypt_msgtype6_send_cprb(bool userspace, struct zcrypt_queue *zq,
 				      struct ica_xcRB *xcrb,
 				      struct ap_message *ap_msg)
 {
-	int rc;
+	unsigned int reply_bufsize_minus_headers =
+		zq->reply.bufsize - sizeof(struct type86_reply_hdrs);
 	struct response_type *rtype = ap_msg->private;
 	struct {
 		struct type6_hdr hdr;
 		struct CPRBX cprbx;
 		/* ... more data blocks ... */
 	} __packed * msg = ap_msg->msg;
-
-	/*
-	 * Set the queue's reply buffer length minus 128 byte padding
-	 * as reply limit for the card firmware.
-	 */
-	msg->hdr.fromcardlen1 = min_t(unsigned int, msg->hdr.fromcardlen1,
-				      zq->reply.bufsize - 128);
-	if (msg->hdr.fromcardlen2)
-		msg->hdr.fromcardlen2 =
-			zq->reply.bufsize - msg->hdr.fromcardlen1 - 128;
+	int rc, delta;
+
+	/* limit each of the two from fields to AP bus limit - headers */
+	msg->hdr.fromcardlen1 = min_t(unsigned int,
+				      msg->hdr.fromcardlen1,
+				      reply_bufsize_minus_headers);
+	msg->hdr.fromcardlen2 = min_t(unsigned int,
+				      msg->hdr.fromcardlen2,
+				      reply_bufsize_minus_headers);
+
+	/* calculate delta if the sum of both exceeds AP bus limit - headers */
+	delta = msg->hdr.fromcardlen1 + msg->hdr.fromcardlen2
+		- reply_bufsize_minus_headers;
+	if (delta > 0) {
+		/*
+		 * Sum exceeds AP bus limit - headers, prune fromcardlen1
+		 * (always trust fromcardlen2)
+		 */
+		if (delta > msg->hdr.fromcardlen1) {
+			rc = -EINVAL;
+			goto out;
+		}
+		msg->hdr.fromcardlen1 -= delta;
+	}
 
 	init_completion(&rtype->work);
 	rc = ap_queue_message(zq->queue, ap_msg);
@@ -1240,7 +1261,7 @@ static long zcrypt_msgtype6_send_ep11_cprb(bool userspace, struct zcrypt_queue *
 	 * as reply limit for the card firmware.
 	 */
 	msg->hdr.fromcardlen1 = zq->reply.bufsize -
-		sizeof(struct type86_hdr) - sizeof(struct type86_fmt2_ext);
+		sizeof(struct type86_reply_hdrs);
 
 	init_completion(&rtype->work);
 	rc = ap_queue_message(zq->queue, ap_msg);
-- 
2.34.1

