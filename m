Return-Path: <stable+bounces-51829-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C83B9071D6
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 14:41:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89DC71F2814E
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 12:41:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB6D0143C7A;
	Thu, 13 Jun 2024 12:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YdhlNjqV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9DD6143C59;
	Thu, 13 Jun 2024 12:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718282436; cv=none; b=mIQ9TtmrRbqnHXXerQcCiO9P095F6lz/iMyCIbmgqsXkYsJdR/K3/rrpHj7e8RR1yZnk3Cp1YksSgOmrstcncKrmoo9qlPgVV4Opm3q8YGkSF6EfmoUL62/JwRlASlzGjrY0BEDHg8HfvqtG/EJOxaLc0giAmFBuhq9jFMMwhvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718282436; c=relaxed/simple;
	bh=O10EeILrDOFPL3s/2PJkJKPpsevXFzh9s5cxkoObWq8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E0Q1gvgd6M7u8WGXV37WibtY+4WoRpHHbgovOerXs+Pb7MtW1riGyiEAGDg0kNZS6ya23ZxJvkEFeLKySk0unbzbYUSFuBwvx3jznO/Mtle1ADiPa6s+kfqSXSdt3vBclwosVioBMmhSM/viTY7QC7vPkRL0L49H/bcj2KVIFjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YdhlNjqV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EEC1C2BBFC;
	Thu, 13 Jun 2024 12:40:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718282436;
	bh=O10EeILrDOFPL3s/2PJkJKPpsevXFzh9s5cxkoObWq8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YdhlNjqVGQa8C/cD0gO1ttfSX1UxR3jlvzhxtLnLkti6sbj3eDLcoyWrNJtPe5ksO
	 W91qgwBkL65Gx+Dkdzt1X3MOLQFxW60pNyNhGnv2sI+Kj+97kS9lnam1YfgRzWWCMC
	 lstQM/6abwKcNpGGtgussmpkS039kKAVha/v0CWE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 276/402] media: cec: use call_op and check for !unregistered
Date: Thu, 13 Jun 2024 13:33:53 +0200
Message-ID: <20240613113312.917169889@linuxfoundation.org>
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

[ Upstream commit e2ed5024ac2bc27d4bfc99fd58f5ab54de8fa965 ]

Use call_(void_)op consistently in the CEC core framework. Ditto
for the cec pin ops. And check if !adap->devnode.unregistered before
calling each op. This avoids calls to ops when the device has been
unregistered and the underlying hardware may be gone.

Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
Stable-dep-of: 47c82aac10a6 ("media: cec: core: avoid recursive cec_claim_log_addrs")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/cec/core/cec-adap.c     | 37 ++++++++++-----------------
 drivers/media/cec/core/cec-api.c      |  6 +++--
 drivers/media/cec/core/cec-core.c     |  4 +--
 drivers/media/cec/core/cec-pin-priv.h | 11 ++++++++
 drivers/media/cec/core/cec-pin.c      | 23 ++++++++---------
 drivers/media/cec/core/cec-priv.h     | 10 ++++++++
 6 files changed, 51 insertions(+), 40 deletions(-)

diff --git a/drivers/media/cec/core/cec-adap.c b/drivers/media/cec/core/cec-adap.c
index 297842398cf30..f53d0de176d85 100644
--- a/drivers/media/cec/core/cec-adap.c
+++ b/drivers/media/cec/core/cec-adap.c
@@ -39,15 +39,6 @@ static void cec_fill_msg_report_features(struct cec_adapter *adap,
  */
 #define CEC_XFER_TIMEOUT_MS (5 * 400 + 100)
 
-#define call_op(adap, op, arg...) \
-	(adap->ops->op ? adap->ops->op(adap, ## arg) : 0)
-
-#define call_void_op(adap, op, arg...)			\
-	do {						\
-		if (adap->ops->op)			\
-			adap->ops->op(adap, ## arg);	\
-	} while (0)
-
 static int cec_log_addr2idx(const struct cec_adapter *adap, u8 log_addr)
 {
 	int i;
@@ -405,9 +396,9 @@ static void cec_data_cancel(struct cec_data *data, u8 tx_status, u8 rx_status)
 	/* Queue transmitted message for monitoring purposes */
 	cec_queue_msg_monitor(adap, &data->msg, 1);
 
-	if (!data->blocking && data->msg.sequence && adap->ops->received)
+	if (!data->blocking && data->msg.sequence)
 		/* Allow drivers to process the message first */
-		adap->ops->received(adap, &data->msg);
+		call_op(adap, received, &data->msg);
 
 	cec_data_completed(data);
 }
@@ -584,8 +575,8 @@ int cec_thread_func(void *_adap)
 
 		adap->transmit_in_progress_aborted = false;
 		/* Tell the adapter to transmit, cancel on error */
-		if (adap->ops->adap_transmit(adap, data->attempts,
-					     signal_free_time, &data->msg))
+		if (call_op(adap, adap_transmit, data->attempts,
+			    signal_free_time, &data->msg))
 			cec_data_cancel(data, CEC_TX_STATUS_ABORTED, 0);
 		else
 			adap->transmit_in_progress = true;
@@ -1311,7 +1302,7 @@ static int cec_config_log_addr(struct cec_adapter *adap,
 	 * Message not acknowledged, so this logical
 	 * address is free to use.
 	 */
-	err = adap->ops->adap_log_addr(adap, log_addr);
+	err = call_op(adap, adap_log_addr, log_addr);
 	if (err)
 		return err;
 
@@ -1328,9 +1319,8 @@ static int cec_config_log_addr(struct cec_adapter *adap,
  */
 static void cec_adap_unconfigure(struct cec_adapter *adap)
 {
-	if (!adap->needs_hpd ||
-	    adap->phys_addr != CEC_PHYS_ADDR_INVALID)
-		WARN_ON(adap->ops->adap_log_addr(adap, CEC_LOG_ADDR_INVALID));
+	if (!adap->needs_hpd || adap->phys_addr != CEC_PHYS_ADDR_INVALID)
+		WARN_ON(call_op(adap, adap_log_addr, CEC_LOG_ADDR_INVALID));
 	adap->log_addrs.log_addr_mask = 0;
 	adap->is_configured = false;
 	cec_flush(adap);
@@ -1573,7 +1563,7 @@ static int cec_activate_cnt_inc(struct cec_adapter *adap)
 	mutex_lock(&adap->devnode.lock);
 	adap->last_initiator = 0xff;
 	adap->transmit_in_progress = false;
-	ret = adap->ops->adap_enable(adap, true);
+	ret = call_op(adap, adap_enable, true);
 	if (ret)
 		adap->activate_cnt--;
 	mutex_unlock(&adap->devnode.lock);
@@ -1590,7 +1580,7 @@ static void cec_activate_cnt_dec(struct cec_adapter *adap)
 
 	/* serialize adap_enable */
 	mutex_lock(&adap->devnode.lock);
-	WARN_ON(adap->ops->adap_enable(adap, false));
+	WARN_ON(call_op(adap, adap_enable, false));
 	adap->last_initiator = 0xff;
 	adap->transmit_in_progress = false;
 	adap->transmit_in_progress_aborted = false;
@@ -1964,11 +1954,10 @@ static int cec_receive_notify(struct cec_adapter *adap, struct cec_msg *msg,
 	    msg->msg[1] != CEC_MSG_CDC_MESSAGE)
 		return 0;
 
-	if (adap->ops->received) {
-		/* Allow drivers to process the message first */
-		if (adap->ops->received(adap, msg) != -ENOMSG)
-			return 0;
-	}
+	/* Allow drivers to process the message first */
+	if (adap->ops->received && !adap->devnode.unregistered &&
+	    adap->ops->received(adap, msg) != -ENOMSG)
+		return 0;
 
 	/*
 	 * REPORT_PHYSICAL_ADDR, CEC_MSG_USER_CONTROL_PRESSED and
diff --git a/drivers/media/cec/core/cec-api.c b/drivers/media/cec/core/cec-api.c
index 398eeacf1eb59..a44cd1484a13c 100644
--- a/drivers/media/cec/core/cec-api.c
+++ b/drivers/media/cec/core/cec-api.c
@@ -595,7 +595,8 @@ static int cec_open(struct inode *inode, struct file *filp)
 		adap->conn_info.type != CEC_CONNECTOR_TYPE_NO_CONNECTOR;
 	cec_queue_event_fh(fh, &ev, 0);
 #ifdef CONFIG_CEC_PIN
-	if (adap->pin && adap->pin->ops->read_hpd) {
+	if (adap->pin && adap->pin->ops->read_hpd &&
+	    !adap->devnode.unregistered) {
 		err = adap->pin->ops->read_hpd(adap);
 		if (err >= 0) {
 			ev.event = err ? CEC_EVENT_PIN_HPD_HIGH :
@@ -603,7 +604,8 @@ static int cec_open(struct inode *inode, struct file *filp)
 			cec_queue_event_fh(fh, &ev, 0);
 		}
 	}
-	if (adap->pin && adap->pin->ops->read_5v) {
+	if (adap->pin && adap->pin->ops->read_5v &&
+	    !adap->devnode.unregistered) {
 		err = adap->pin->ops->read_5v(adap);
 		if (err >= 0) {
 			ev.event = err ? CEC_EVENT_PIN_5V_HIGH :
diff --git a/drivers/media/cec/core/cec-core.c b/drivers/media/cec/core/cec-core.c
index ec67065d52021..34f1631b77098 100644
--- a/drivers/media/cec/core/cec-core.c
+++ b/drivers/media/cec/core/cec-core.c
@@ -204,7 +204,7 @@ static ssize_t cec_error_inj_write(struct file *file,
 		line = strsep(&p, "\n");
 		if (!*line || *line == '#')
 			continue;
-		if (!adap->ops->error_inj_parse_line(adap, line)) {
+		if (!call_op(adap, error_inj_parse_line, line)) {
 			kfree(buf);
 			return -EINVAL;
 		}
@@ -217,7 +217,7 @@ static int cec_error_inj_show(struct seq_file *sf, void *unused)
 {
 	struct cec_adapter *adap = sf->private;
 
-	return adap->ops->error_inj_show(adap, sf);
+	return call_op(adap, error_inj_show, sf);
 }
 
 static int cec_error_inj_open(struct inode *inode, struct file *file)
diff --git a/drivers/media/cec/core/cec-pin-priv.h b/drivers/media/cec/core/cec-pin-priv.h
index fb101f15865c8..e7d63f6acb300 100644
--- a/drivers/media/cec/core/cec-pin-priv.h
+++ b/drivers/media/cec/core/cec-pin-priv.h
@@ -12,6 +12,17 @@
 #include <linux/atomic.h>
 #include <media/cec-pin.h>
 
+#define call_pin_op(pin, op, arg...)					\
+	((pin && pin->ops->op && !pin->adap->devnode.unregistered) ?	\
+	 pin->ops->op(pin->adap, ## arg) : 0)
+
+#define call_void_pin_op(pin, op, arg...)				\
+	do {								\
+		if (pin && pin->ops->op &&				\
+		    !pin->adap->devnode.unregistered)			\
+			pin->ops->op(pin->adap, ## arg);		\
+	} while (0)
+
 enum cec_pin_state {
 	/* CEC is off */
 	CEC_ST_OFF,
diff --git a/drivers/media/cec/core/cec-pin.c b/drivers/media/cec/core/cec-pin.c
index 0eb90cc0ffb0f..99e69c49e0c9e 100644
--- a/drivers/media/cec/core/cec-pin.c
+++ b/drivers/media/cec/core/cec-pin.c
@@ -135,7 +135,7 @@ static void cec_pin_update(struct cec_pin *pin, bool v, bool force)
 
 static bool cec_pin_read(struct cec_pin *pin)
 {
-	bool v = pin->ops->read(pin->adap);
+	bool v = call_pin_op(pin, read);
 
 	cec_pin_update(pin, v, false);
 	return v;
@@ -143,13 +143,13 @@ static bool cec_pin_read(struct cec_pin *pin)
 
 static void cec_pin_low(struct cec_pin *pin)
 {
-	pin->ops->low(pin->adap);
+	call_void_pin_op(pin, low);
 	cec_pin_update(pin, false, false);
 }
 
 static bool cec_pin_high(struct cec_pin *pin)
 {
-	pin->ops->high(pin->adap);
+	call_void_pin_op(pin, high);
 	return cec_pin_read(pin);
 }
 
@@ -1086,7 +1086,7 @@ static int cec_pin_thread_func(void *_adap)
 				    CEC_PIN_IRQ_UNCHANGED)) {
 		case CEC_PIN_IRQ_DISABLE:
 			if (irq_enabled) {
-				pin->ops->disable_irq(adap);
+				call_void_pin_op(pin, disable_irq);
 				irq_enabled = false;
 			}
 			cec_pin_high(pin);
@@ -1097,7 +1097,7 @@ static int cec_pin_thread_func(void *_adap)
 		case CEC_PIN_IRQ_ENABLE:
 			if (irq_enabled)
 				break;
-			pin->enable_irq_failed = !pin->ops->enable_irq(adap);
+			pin->enable_irq_failed = !call_pin_op(pin, enable_irq);
 			if (pin->enable_irq_failed) {
 				cec_pin_to_idle(pin);
 				hrtimer_start(&pin->timer, ns_to_ktime(0),
@@ -1112,8 +1112,8 @@ static int cec_pin_thread_func(void *_adap)
 		if (kthread_should_stop())
 			break;
 	}
-	if (pin->ops->disable_irq && irq_enabled)
-		pin->ops->disable_irq(adap);
+	if (irq_enabled)
+		call_void_pin_op(pin, disable_irq);
 	hrtimer_cancel(&pin->timer);
 	cec_pin_read(pin);
 	cec_pin_to_idle(pin);
@@ -1208,7 +1208,7 @@ static void cec_pin_adap_status(struct cec_adapter *adap,
 	seq_printf(file, "state: %s\n", states[pin->state].name);
 	seq_printf(file, "tx_bit: %d\n", pin->tx_bit);
 	seq_printf(file, "rx_bit: %d\n", pin->rx_bit);
-	seq_printf(file, "cec pin: %d\n", pin->ops->read(adap));
+	seq_printf(file, "cec pin: %d\n", call_pin_op(pin, read));
 	seq_printf(file, "cec pin events dropped: %u\n",
 		   pin->work_pin_events_dropped_cnt);
 	seq_printf(file, "irq failed: %d\n", pin->enable_irq_failed);
@@ -1261,8 +1261,7 @@ static void cec_pin_adap_status(struct cec_adapter *adap,
 	pin->rx_data_bit_too_long_cnt = 0;
 	pin->rx_low_drive_cnt = 0;
 	pin->tx_low_drive_cnt = 0;
-	if (pin->ops->status)
-		pin->ops->status(adap, file);
+	call_void_pin_op(pin, status, file);
 }
 
 static int cec_pin_adap_monitor_all_enable(struct cec_adapter *adap,
@@ -1278,7 +1277,7 @@ static void cec_pin_adap_free(struct cec_adapter *adap)
 {
 	struct cec_pin *pin = adap->pin;
 
-	if (pin->ops->free)
+	if (pin && pin->ops->free)
 		pin->ops->free(adap);
 	adap->pin = NULL;
 	kfree(pin);
@@ -1288,7 +1287,7 @@ static int cec_pin_received(struct cec_adapter *adap, struct cec_msg *msg)
 {
 	struct cec_pin *pin = adap->pin;
 
-	if (pin->ops->received)
+	if (pin->ops->received && !adap->devnode.unregistered)
 		return pin->ops->received(adap, msg);
 	return -ENOMSG;
 }
diff --git a/drivers/media/cec/core/cec-priv.h b/drivers/media/cec/core/cec-priv.h
index 9bbd05053d420..b78df931aa74b 100644
--- a/drivers/media/cec/core/cec-priv.h
+++ b/drivers/media/cec/core/cec-priv.h
@@ -17,6 +17,16 @@
 			pr_info("cec-%s: " fmt, adap->name, ## arg);	\
 	} while (0)
 
+#define call_op(adap, op, arg...)					\
+	((adap->ops->op && !adap->devnode.unregistered) ?		\
+	 adap->ops->op(adap, ## arg) : 0)
+
+#define call_void_op(adap, op, arg...)					\
+	do {								\
+		if (adap->ops->op && !adap->devnode.unregistered)	\
+			adap->ops->op(adap, ## arg);			\
+	} while (0)
+
 /* devnode to cec_adapter */
 #define to_cec_adapter(node) container_of(node, struct cec_adapter, devnode)
 
-- 
2.43.0




