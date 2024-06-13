Return-Path: <stable+bounces-51826-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C7A99071D0
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 14:41:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C028C1F28154
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 12:41:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 624A9143C60;
	Thu, 13 Jun 2024 12:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CyZja22c"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DE24143C55;
	Thu, 13 Jun 2024 12:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718282428; cv=none; b=NB4uULkXvwzzmvLN/NkoZilHfSQakorl9n5Z8VVwXvRI0KaLlzR+Pt+OAvgJLdBdJTFkyL809+WaHV+MXGj3ncN1yCskdmSw5mOKGNfsjrYOn3HX12BHRPRLwzVIvCo3zTapD4H1IUp/3Dd7Ia3ebB9SChulIz48Lk7UDbL2y00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718282428; c=relaxed/simple;
	bh=yrx+LrAzuBy42F3b+v69TK7XTa99a1MK1hBH+UP1I7M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ezkqFSTeoPdiXmec0PuuhT1FToOuNeVbMvwvlAocKTuPqsD3lDmueCcsuqxFYsVik2lrzr27FZ7y0pTB7fJq3moJS0JZWXixjHw63nPbofW1aVY5HqUGlhh7ftnqthrEdyvZQqpZ0eSvSZL5T9kQxj6vha9KD6Mb+FgJBjLr2d4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CyZja22c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48147C2BBFC;
	Thu, 13 Jun 2024 12:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718282427;
	bh=yrx+LrAzuBy42F3b+v69TK7XTa99a1MK1hBH+UP1I7M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CyZja22cf5WfqDBSDr2dQdIhkybaZc09RRlZD/I5Gmfc5yTqbesVBG58J9huOBd8g
	 XE1rGhyxLhImPivVasvZV0e6Kt5XOvfu0B+3tvQ/B322NqZto7vW+Ig9egNDjNmZhS
	 jSLVQC9sv8yrDHaqV+GHEtbybxQ99D+tmIKBdyh0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 273/402] media: cec: call enable_adap on s_log_addrs
Date: Thu, 13 Jun 2024 13:33:50 +0200
Message-ID: <20240613113312.800845091@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240613113302.116811394@linuxfoundation.org>
References: <20240613113302.116811394@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hans Verkuil <hverkuil-cisco@xs4all.nl>

[ Upstream commit 3813c932ed970dd4f413498ccecb03c73c4f1784 ]

Don't enable/disable the adapter if the first fh is opened or the
last fh is closed, instead do this when the adapter is configured
or unconfigured, and also when we enter Monitor All or Monitor Pin
mode for the first time or we exit the Monitor All/Pin mode for the
last time.

However, if needs_hpd is true, then do this when the physical
address is set or cleared: in that case the adapter typically is
powered by the HPD, so it really is disabled when the HPD is low.
This case (needs_hpd is true) was already handled in this way, so
this wasn't changed.

The problem with the old behavior was that if the HPD goes low when
no fh is open, and a transmit was in progress, then the adapter would
be disabled, typically stopping the transmit immediately which
leaves a partial message on the bus, which isn't nice and can confuse
some adapters.

It makes much more sense to disable it only when the adapter is
unconfigured and we're not monitoring the bus, since then you really
won't be using it anymore.

To keep track of this store a CEC activation count and call adap_enable
only when it goes from 0 to 1 or back to 0.

Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
Stable-dep-of: 47c82aac10a6 ("media: cec: core: avoid recursive cec_claim_log_addrs")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/cec/core/cec-adap.c | 174 ++++++++++++++++++++++--------
 drivers/media/cec/core/cec-api.c  |  18 +---
 include/media/cec.h               |   2 +
 3 files changed, 130 insertions(+), 64 deletions(-)

diff --git a/drivers/media/cec/core/cec-adap.c b/drivers/media/cec/core/cec-adap.c
index 1b72063f242e0..730f169c93ba3 100644
--- a/drivers/media/cec/core/cec-adap.c
+++ b/drivers/media/cec/core/cec-adap.c
@@ -1532,6 +1532,7 @@ static void cec_claim_log_addrs(struct cec_adapter *adap, bool block)
 					   "ceccfg-%s", adap->name);
 	if (IS_ERR(adap->kthread_config)) {
 		adap->kthread_config = NULL;
+		adap->is_configuring = false;
 	} else if (block) {
 		mutex_unlock(&adap->lock);
 		wait_for_completion(&adap->config_completion);
@@ -1539,59 +1540,90 @@ static void cec_claim_log_addrs(struct cec_adapter *adap, bool block)
 	}
 }
 
+/*
+ * Helper functions to enable/disable the CEC adapter.
+ *
+ * These functions are called with adap->lock held.
+ */
+static int cec_activate_cnt_inc(struct cec_adapter *adap)
+{
+	int ret;
+
+	if (adap->activate_cnt++)
+		return 0;
+
+	/* serialize adap_enable */
+	mutex_lock(&adap->devnode.lock);
+	adap->last_initiator = 0xff;
+	adap->transmit_in_progress = false;
+	ret = adap->ops->adap_enable(adap, true);
+	if (ret)
+		adap->activate_cnt--;
+	mutex_unlock(&adap->devnode.lock);
+	return ret;
+}
+
+static void cec_activate_cnt_dec(struct cec_adapter *adap)
+{
+	if (WARN_ON(!adap->activate_cnt))
+		return;
+
+	if (--adap->activate_cnt)
+		return;
+
+	/* serialize adap_enable */
+	mutex_lock(&adap->devnode.lock);
+	WARN_ON(adap->ops->adap_enable(adap, false));
+	adap->last_initiator = 0xff;
+	adap->transmit_in_progress = false;
+	mutex_unlock(&adap->devnode.lock);
+}
+
 /* Set a new physical address and send an event notifying userspace of this.
  *
  * This function is called with adap->lock held.
  */
 void __cec_s_phys_addr(struct cec_adapter *adap, u16 phys_addr, bool block)
 {
+	bool becomes_invalid = phys_addr == CEC_PHYS_ADDR_INVALID;
+	bool is_invalid = adap->phys_addr == CEC_PHYS_ADDR_INVALID;
+
 	if (phys_addr == adap->phys_addr)
 		return;
-	if (phys_addr != CEC_PHYS_ADDR_INVALID && adap->devnode.unregistered)
+	if (!becomes_invalid && adap->devnode.unregistered)
 		return;
 
 	dprintk(1, "new physical address %x.%x.%x.%x\n",
 		cec_phys_addr_exp(phys_addr));
-	if (phys_addr == CEC_PHYS_ADDR_INVALID ||
-	    adap->phys_addr != CEC_PHYS_ADDR_INVALID) {
+	if (becomes_invalid || !is_invalid) {
 		adap->phys_addr = CEC_PHYS_ADDR_INVALID;
 		cec_post_state_event(adap);
 		cec_adap_unconfigure(adap);
-		/* Disabling monitor all mode should always succeed */
-		if (adap->monitor_all_cnt)
-			WARN_ON(call_op(adap, adap_monitor_all_enable, false));
-		/* serialize adap_enable */
-		mutex_lock(&adap->devnode.lock);
-		if (adap->needs_hpd || list_empty(&adap->devnode.fhs)) {
-			WARN_ON(adap->ops->adap_enable(adap, false));
-			adap->transmit_in_progress = false;
+		if (becomes_invalid && adap->needs_hpd) {
+			/* Disable monitor-all/pin modes if needed */
+			if (adap->monitor_all_cnt)
+				WARN_ON(call_op(adap, adap_monitor_all_enable, false));
+			if (adap->monitor_pin_cnt)
+				WARN_ON(call_op(adap, adap_monitor_pin_enable, false));
+			cec_activate_cnt_dec(adap);
 			wake_up_interruptible(&adap->kthread_waitq);
 		}
-		mutex_unlock(&adap->devnode.lock);
-		if (phys_addr == CEC_PHYS_ADDR_INVALID)
+		if (becomes_invalid)
 			return;
 	}
 
-	/* serialize adap_enable */
-	mutex_lock(&adap->devnode.lock);
-	adap->last_initiator = 0xff;
-	adap->transmit_in_progress = false;
-
-	if (adap->needs_hpd || list_empty(&adap->devnode.fhs)) {
-		if (adap->ops->adap_enable(adap, true)) {
-			mutex_unlock(&adap->devnode.lock);
+	if (is_invalid && adap->needs_hpd) {
+		if (cec_activate_cnt_inc(adap))
 			return;
-		}
-	}
-
-	if (adap->monitor_all_cnt &&
-	    call_op(adap, adap_monitor_all_enable, true)) {
-		if (adap->needs_hpd || list_empty(&adap->devnode.fhs))
-			WARN_ON(adap->ops->adap_enable(adap, false));
-		mutex_unlock(&adap->devnode.lock);
-		return;
+		/*
+		 * Re-enable monitor-all/pin modes if needed. We warn, but
+		 * continue if this fails as this is not a critical error.
+		 */
+		if (adap->monitor_all_cnt)
+			WARN_ON(call_op(adap, adap_monitor_all_enable, true));
+		if (adap->monitor_pin_cnt)
+			WARN_ON(call_op(adap, adap_monitor_pin_enable, true));
 	}
-	mutex_unlock(&adap->devnode.lock);
 
 	adap->phys_addr = phys_addr;
 	cec_post_state_event(adap);
@@ -1656,6 +1688,8 @@ int __cec_s_log_addrs(struct cec_adapter *adap,
 		return -ENODEV;
 
 	if (!log_addrs || log_addrs->num_log_addrs == 0) {
+		if (!adap->is_configuring && !adap->is_configured)
+			return 0;
 		cec_adap_unconfigure(adap);
 		adap->log_addrs.num_log_addrs = 0;
 		for (i = 0; i < CEC_MAX_LOG_ADDRS; i++)
@@ -1663,6 +1697,8 @@ int __cec_s_log_addrs(struct cec_adapter *adap,
 		adap->log_addrs.osd_name[0] = '\0';
 		adap->log_addrs.vendor_id = CEC_VENDOR_ID_NONE;
 		adap->log_addrs.cec_version = CEC_OP_CEC_VERSION_2_0;
+		if (!adap->needs_hpd)
+			cec_activate_cnt_dec(adap);
 		return 0;
 	}
 
@@ -1796,6 +1832,12 @@ int __cec_s_log_addrs(struct cec_adapter *adap,
 		       sizeof(log_addrs->features[i]));
 	}
 
+	if (!adap->needs_hpd && !adap->is_configuring && !adap->is_configured) {
+		int ret = cec_activate_cnt_inc(adap);
+
+		if (ret)
+			return ret;
+	}
 	log_addrs->log_addr_mask = adap->log_addrs.log_addr_mask;
 	adap->log_addrs = *log_addrs;
 	if (adap->phys_addr != CEC_PHYS_ADDR_INVALID)
@@ -2099,20 +2141,37 @@ static int cec_receive_notify(struct cec_adapter *adap, struct cec_msg *msg,
  */
 int cec_monitor_all_cnt_inc(struct cec_adapter *adap)
 {
-	int ret = 0;
+	int ret;
 
-	if (adap->monitor_all_cnt == 0)
-		ret = call_op(adap, adap_monitor_all_enable, 1);
-	if (ret == 0)
-		adap->monitor_all_cnt++;
+	if (adap->monitor_all_cnt++)
+		return 0;
+
+	if (!adap->needs_hpd) {
+		ret = cec_activate_cnt_inc(adap);
+		if (ret) {
+			adap->monitor_all_cnt--;
+			return ret;
+		}
+	}
+
+	ret = call_op(adap, adap_monitor_all_enable, true);
+	if (ret) {
+		adap->monitor_all_cnt--;
+		if (!adap->needs_hpd)
+			cec_activate_cnt_dec(adap);
+	}
 	return ret;
 }
 
 void cec_monitor_all_cnt_dec(struct cec_adapter *adap)
 {
-	adap->monitor_all_cnt--;
-	if (adap->monitor_all_cnt == 0)
-		WARN_ON(call_op(adap, adap_monitor_all_enable, 0));
+	if (WARN_ON(!adap->monitor_all_cnt))
+		return;
+	if (--adap->monitor_all_cnt)
+		return;
+	WARN_ON(call_op(adap, adap_monitor_all_enable, false));
+	if (!adap->needs_hpd)
+		cec_activate_cnt_dec(adap);
 }
 
 /*
@@ -2122,20 +2181,37 @@ void cec_monitor_all_cnt_dec(struct cec_adapter *adap)
  */
 int cec_monitor_pin_cnt_inc(struct cec_adapter *adap)
 {
-	int ret = 0;
+	int ret;
 
-	if (adap->monitor_pin_cnt == 0)
-		ret = call_op(adap, adap_monitor_pin_enable, 1);
-	if (ret == 0)
-		adap->monitor_pin_cnt++;
+	if (adap->monitor_pin_cnt++)
+		return 0;
+
+	if (!adap->needs_hpd) {
+		ret = cec_activate_cnt_inc(adap);
+		if (ret) {
+			adap->monitor_pin_cnt--;
+			return ret;
+		}
+	}
+
+	ret = call_op(adap, adap_monitor_pin_enable, true);
+	if (ret) {
+		adap->monitor_pin_cnt--;
+		if (!adap->needs_hpd)
+			cec_activate_cnt_dec(adap);
+	}
 	return ret;
 }
 
 void cec_monitor_pin_cnt_dec(struct cec_adapter *adap)
 {
-	adap->monitor_pin_cnt--;
-	if (adap->monitor_pin_cnt == 0)
-		WARN_ON(call_op(adap, adap_monitor_pin_enable, 0));
+	if (WARN_ON(!adap->monitor_pin_cnt))
+		return;
+	if (--adap->monitor_pin_cnt)
+		return;
+	WARN_ON(call_op(adap, adap_monitor_pin_enable, false));
+	if (!adap->needs_hpd)
+		cec_activate_cnt_dec(adap);
 }
 
 #ifdef CONFIG_DEBUG_FS
@@ -2149,6 +2225,7 @@ int cec_adap_status(struct seq_file *file, void *priv)
 	struct cec_data *data;
 
 	mutex_lock(&adap->lock);
+	seq_printf(file, "activation count: %u\n", adap->activate_cnt);
 	seq_printf(file, "configured: %d\n", adap->is_configured);
 	seq_printf(file, "configuring: %d\n", adap->is_configuring);
 	seq_printf(file, "phys_addr: %x.%x.%x.%x\n",
@@ -2163,6 +2240,9 @@ int cec_adap_status(struct seq_file *file, void *priv)
 	if (adap->monitor_all_cnt)
 		seq_printf(file, "file handles in Monitor All mode: %u\n",
 			   adap->monitor_all_cnt);
+	if (adap->monitor_pin_cnt)
+		seq_printf(file, "file handles in Monitor Pin mode: %u\n",
+			   adap->monitor_pin_cnt);
 	if (adap->tx_timeouts) {
 		seq_printf(file, "transmit timeouts: %u\n",
 			   adap->tx_timeouts);
diff --git a/drivers/media/cec/core/cec-api.c b/drivers/media/cec/core/cec-api.c
index 4510a4bec659a..398eeacf1eb59 100644
--- a/drivers/media/cec/core/cec-api.c
+++ b/drivers/media/cec/core/cec-api.c
@@ -586,18 +586,6 @@ static int cec_open(struct inode *inode, struct file *filp)
 		return err;
 	}
 
-	/* serialize adap_enable */
-	mutex_lock(&devnode->lock);
-	if (list_empty(&devnode->fhs) &&
-	    !adap->needs_hpd &&
-	    adap->phys_addr == CEC_PHYS_ADDR_INVALID) {
-		err = adap->ops->adap_enable(adap, true);
-		if (err) {
-			mutex_unlock(&devnode->lock);
-			kfree(fh);
-			return err;
-		}
-	}
 	filp->private_data = fh;
 
 	/* Queue up initial state events */
@@ -625,6 +613,7 @@ static int cec_open(struct inode *inode, struct file *filp)
 	}
 #endif
 
+	mutex_lock(&devnode->lock);
 	mutex_lock(&devnode->lock_fhs);
 	list_add(&fh->list, &devnode->fhs);
 	mutex_unlock(&devnode->lock_fhs);
@@ -656,15 +645,10 @@ static int cec_release(struct inode *inode, struct file *filp)
 		cec_monitor_all_cnt_dec(adap);
 	mutex_unlock(&adap->lock);
 
-	/* serialize adap_enable */
 	mutex_lock(&devnode->lock);
 	mutex_lock(&devnode->lock_fhs);
 	list_del(&fh->list);
 	mutex_unlock(&devnode->lock_fhs);
-	if (cec_is_registered(adap) && list_empty(&devnode->fhs) &&
-	    !adap->needs_hpd && adap->phys_addr == CEC_PHYS_ADDR_INVALID) {
-		WARN_ON(adap->ops->adap_enable(adap, false));
-	}
 	mutex_unlock(&devnode->lock);
 
 	/* Unhook pending transmits from this filehandle. */
diff --git a/include/media/cec.h b/include/media/cec.h
index 77346f757036d..97c5f5bfcbd00 100644
--- a/include/media/cec.h
+++ b/include/media/cec.h
@@ -185,6 +185,7 @@ struct cec_adap_ops {
  *	Drivers that need this can set this field to true after the
  *	cec_allocate_adapter() call.
  * @last_initiator:	the initiator of the last transmitted message.
+ * @activate_cnt:	number of times that CEC is activated
  * @monitor_all_cnt:	number of filehandles monitoring all msgs
  * @monitor_pin_cnt:	number of filehandles monitoring pin changes
  * @follower_cnt:	number of filehandles in follower mode
@@ -236,6 +237,7 @@ struct cec_adapter {
 	bool cec_pin_is_high;
 	bool adap_controls_phys_addr;
 	u8 last_initiator;
+	u32 activate_cnt;
 	u32 monitor_all_cnt;
 	u32 monitor_pin_cnt;
 	u32 follower_cnt;
-- 
2.43.0




