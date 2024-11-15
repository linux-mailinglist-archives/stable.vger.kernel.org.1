Return-Path: <stable+bounces-93225-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7CF29CD805
	for <lists+stable@lfdr.de>; Fri, 15 Nov 2024 07:46:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E643B25F9B
	for <lists+stable@lfdr.de>; Fri, 15 Nov 2024 06:46:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2E4A29A9;
	Fri, 15 Nov 2024 06:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MBINQe/j"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60E1417E015;
	Fri, 15 Nov 2024 06:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731653210; cv=none; b=URuPMobfEGCJ3yCEafWhsz+M8Cc53P9pTSfKUYtdeiXteDB5kB/RTqRGXiVje9lBGHHWvLXXonVpV/dXPhcuHnhsfmnChNOKVTWj8Cy6X1eSuQn95LQSbAiTcCZCFrX4IO8FWruz06E5IN92NWfHEoYnYoycFsYsAN1ZF1mjo30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731653210; c=relaxed/simple;
	bh=VQc36sZaE/BDuq9bTQNnxG6He7vTU3N4cALXo2IAXFo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IVWwuQOeZb6aOLaYZoBeP74URGihATf+6ATnFYqdB5LK+KmQFYDkC8rHrOsecpTRNf8i7DmCVBBOvfqsEL/HHywtwheTouthsqDavZVn7B47fdekA3V22xn1gx2I7os+cWflnU4CLPumhIfklby+fAVnxyro17jbfB5CmtQGWKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MBINQe/j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C383AC4CECF;
	Fri, 15 Nov 2024 06:46:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1731653210;
	bh=VQc36sZaE/BDuq9bTQNnxG6He7vTU3N4cALXo2IAXFo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MBINQe/ja0Ugwbc2SfdyqGNyGDjdbJMK6MLE45r7SGnLFWkWg0t327XXeQqd94l/g
	 09sO4pEmSYHGreJi6rpOGKuxg//3G5KWzg0lXWgYODKSD7ij3dL3CkTrvDn0d5oyvo
	 P1Yj5b/ZBhBITiXvIsOgFmradkaW+C3+qBo/9gUA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Harald Freudenberger <freude@linux.ibm.com>,
	Holger Dengler <dengler@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.11 19/63] s390/ap: Fix CCA crypto card behavior within protected execution environment
Date: Fri, 15 Nov 2024 07:37:42 +0100
Message-ID: <20241115063726.614814906@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241115063725.892410236@linuxfoundation.org>
References: <20241115063725.892410236@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.11-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Harald Freudenberger <freude@linux.ibm.com>

[ Upstream commit 78f636e82b2288462498e235dc5a886426ce5dd7 ]

A crypto card comes in 3 flavors: accelerator, CCA co-processor or
EP11 co-processor. Within a protected execution environment only the
accelerator and EP11 co-processor is supported. However, it is
possible to set up a KVM guest with a CCA card and run it as a
protected execution guest. There is nothing at the host side which
prevents this. Within such a guest, a CCA card is shown as "illicit"
and you can't do anything with such a crypto card.

Regardless of the unsupported CCA card within a protected execution
guest there are a couple of user space applications which
unconditional try to run crypto requests to the zcrypt device
driver. There was a bug within the AP bus code which allowed such a
request to be forwarded to a CCA card where it is finally
rejected and the driver reacts with -ENODEV but also triggers an AP
bus scan. Together with a retry loop this caused some kind of "hang"
of the KVM guest. On startup it caused timeouts and finally led the
KVM guest startup fail. Fix that by closing the gap and make sure a
CCA card is not usable within a protected execution environment.

Another behavior within an protected execution environment with CCA
cards was that the se_bind and se_associate AP queue sysfs attributes
where shown. The implementation unconditional always added these
attributes. Fix that by checking if the card mode is supported within
a protected execution environment and only if valid, add the attribute
group.

Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
Reviewed-by: Holger Dengler <dengler@linux.ibm.com>
Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/s390/crypto/ap_bus.c   |  3 +--
 drivers/s390/crypto/ap_bus.h   |  2 +-
 drivers/s390/crypto/ap_queue.c | 28 ++++++++++++++++++++--------
 3 files changed, 22 insertions(+), 11 deletions(-)

diff --git a/drivers/s390/crypto/ap_bus.c b/drivers/s390/crypto/ap_bus.c
index 3ba4e1c5e15df..57aefccbb8556 100644
--- a/drivers/s390/crypto/ap_bus.c
+++ b/drivers/s390/crypto/ap_bus.c
@@ -1865,13 +1865,12 @@ static inline void ap_scan_domains(struct ap_card *ac)
 		}
 		/* if no queue device exists, create a new one */
 		if (!aq) {
-			aq = ap_queue_create(qid, ac->ap_dev.device_type);
+			aq = ap_queue_create(qid, ac);
 			if (!aq) {
 				AP_DBF_WARN("%s(%d,%d) ap_queue_create() failed\n",
 					    __func__, ac->id, dom);
 				continue;
 			}
-			aq->card = ac;
 			aq->config = !decfg;
 			aq->chkstop = chkstop;
 			aq->se_bstate = hwinfo.bs;
diff --git a/drivers/s390/crypto/ap_bus.h b/drivers/s390/crypto/ap_bus.h
index 0b275c7193196..f4622ee4d8947 100644
--- a/drivers/s390/crypto/ap_bus.h
+++ b/drivers/s390/crypto/ap_bus.h
@@ -272,7 +272,7 @@ int ap_test_config_usage_domain(unsigned int domain);
 int ap_test_config_ctrl_domain(unsigned int domain);
 
 void ap_queue_init_reply(struct ap_queue *aq, struct ap_message *ap_msg);
-struct ap_queue *ap_queue_create(ap_qid_t qid, int device_type);
+struct ap_queue *ap_queue_create(ap_qid_t qid, struct ap_card *ac);
 void ap_queue_prepare_remove(struct ap_queue *aq);
 void ap_queue_remove(struct ap_queue *aq);
 void ap_queue_init_state(struct ap_queue *aq);
diff --git a/drivers/s390/crypto/ap_queue.c b/drivers/s390/crypto/ap_queue.c
index 1f647ffd6f4db..dcd1590c0f81f 100644
--- a/drivers/s390/crypto/ap_queue.c
+++ b/drivers/s390/crypto/ap_queue.c
@@ -22,6 +22,11 @@ static void __ap_flush_queue(struct ap_queue *aq);
  * some AP queue helper functions
  */
 
+static inline bool ap_q_supported_in_se(struct ap_queue *aq)
+{
+	return aq->card->hwinfo.ep11 || aq->card->hwinfo.accel;
+}
+
 static inline bool ap_q_supports_bind(struct ap_queue *aq)
 {
 	return aq->card->hwinfo.ep11 || aq->card->hwinfo.accel;
@@ -1104,18 +1109,19 @@ static void ap_queue_device_release(struct device *dev)
 	kfree(aq);
 }
 
-struct ap_queue *ap_queue_create(ap_qid_t qid, int device_type)
+struct ap_queue *ap_queue_create(ap_qid_t qid, struct ap_card *ac)
 {
 	struct ap_queue *aq;
 
 	aq = kzalloc(sizeof(*aq), GFP_KERNEL);
 	if (!aq)
 		return NULL;
+	aq->card = ac;
 	aq->ap_dev.device.release = ap_queue_device_release;
 	aq->ap_dev.device.type = &ap_queue_type;
-	aq->ap_dev.device_type = device_type;
-	// add optional SE secure binding attributes group
-	if (ap_sb_available() && is_prot_virt_guest())
+	aq->ap_dev.device_type = ac->ap_dev.device_type;
+	/* in SE environment add bind/associate attributes group */
+	if (ap_is_se_guest() && ap_q_supported_in_se(aq))
 		aq->ap_dev.device.groups = ap_queue_dev_sb_attr_groups;
 	aq->qid = qid;
 	spin_lock_init(&aq->lock);
@@ -1196,10 +1202,16 @@ bool ap_queue_usable(struct ap_queue *aq)
 	}
 
 	/* SE guest's queues additionally need to be bound */
-	if (ap_q_needs_bind(aq) &&
-	    !(aq->se_bstate == AP_BS_Q_USABLE ||
-	      aq->se_bstate == AP_BS_Q_USABLE_NO_SECURE_KEY))
-		rc = false;
+	if (ap_is_se_guest()) {
+		if (!ap_q_supported_in_se(aq)) {
+			rc = false;
+			goto unlock_and_out;
+		}
+		if (ap_q_needs_bind(aq) &&
+		    !(aq->se_bstate == AP_BS_Q_USABLE ||
+		      aq->se_bstate == AP_BS_Q_USABLE_NO_SECURE_KEY))
+			rc = false;
+	}
 
 unlock_and_out:
 	spin_unlock_bh(&aq->lock);
-- 
2.43.0




