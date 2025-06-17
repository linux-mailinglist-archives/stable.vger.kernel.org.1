Return-Path: <stable+bounces-154199-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BBB87ADD86F
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 18:55:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB9994A323D
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 16:44:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 327882EE5F9;
	Tue, 17 Jun 2025 16:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1pwXM+yg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDFCA2DFF09;
	Tue, 17 Jun 2025 16:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750178422; cv=none; b=o/L+IccCnQ4RABOKNYweKYrQ5j0gTATH1wSNCsMPPswSYC+pLvTyJQU8M8gDXyuuVQOZvaWiAtDshr7WzY2Lv+g2KvLD8ZiJclT6othiJU1ObSYOSgmK0hl3NqF8zTq6f8+B4ClfSvrTE5vTlzsa7Aji3hVMCgIIOqum/wNH5RE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750178422; c=relaxed/simple;
	bh=pvvDLeic6JQpPenyTHhQI7gULptoQ+6AJMrYDn9iIZg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nBzXRy+avFS6AG0HZ+LoJLKgbmUSFsHYhxFafIVcA31jD8Z4YNaYIQJYqTlceMWbWhHW890RYH1oW8fuvQygusRZK1/qF+amjaERwYhWlcuSK7q8gamlh8ZkEDGiJUCz7NI9lwV+eFD6fEdPpuYBoZxalpZrMS27E9JR3cmcWXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1pwXM+yg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D697C4CEE3;
	Tue, 17 Jun 2025 16:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750178422;
	bh=pvvDLeic6JQpPenyTHhQI7gULptoQ+6AJMrYDn9iIZg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=1pwXM+ygqHCn+G78ELNpIBfAQQa3teejjFDFNgub2KsWz/AGL7kyaNoAzF+g8mtVd
	 o+vKne7K6uVwMV54Y/hxyi3SJ5WRjG+vfuneS0aV8ZwHfjBkBM/YsthIyQiQO+vNcX
	 ifOFpDXUlueGI0MQusa2S58d04d8iSX3h4TooD7o=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	stable <stable@kernel.org>,
	RD Babiera <rdbabiera@google.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Badhri Jagan Sridharan <badhri@google.com>
Subject: [PATCH 6.12 497/512] usb: typec: tcpm: move tcpm_queue_vdm_unlocked to asynchronous work
Date: Tue, 17 Jun 2025 17:27:43 +0200
Message-ID: <20250617152439.760990113@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250617152419.512865572@linuxfoundation.org>
References: <20250617152419.512865572@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: RD Babiera <rdbabiera@google.com>

commit 324d45e53f1a36c88bc649dc39e0c8300a41be0a upstream.

A state check was previously added to tcpm_queue_vdm_unlocked to
prevent a deadlock where the DisplayPort Alt Mode driver would be
executing work and attempting to grab the tcpm_lock while the TCPM
was holding the lock and attempting to unregister the altmode, blocking
on the altmode driver's cancel_work_sync call.

Because the state check isn't protected, there is a small window
where the Alt Mode driver could determine that the TCPM is
in a ready state and attempt to grab the lock while the
TCPM grabs the lock and changes the TCPM state to one that
causes the deadlock. The callstack is provided below:

[110121.667392][    C7] Call trace:
[110121.667396][    C7]  __switch_to+0x174/0x338
[110121.667406][    C7]  __schedule+0x608/0x9f0
[110121.667414][    C7]  schedule+0x7c/0xe8
[110121.667423][    C7]  kernfs_drain+0xb0/0x114
[110121.667431][    C7]  __kernfs_remove+0x16c/0x20c
[110121.667436][    C7]  kernfs_remove_by_name_ns+0x74/0xe8
[110121.667442][    C7]  sysfs_remove_group+0x84/0xe8
[110121.667450][    C7]  sysfs_remove_groups+0x34/0x58
[110121.667458][    C7]  device_remove_groups+0x10/0x20
[110121.667464][    C7]  device_release_driver_internal+0x164/0x2e4
[110121.667475][    C7]  device_release_driver+0x18/0x28
[110121.667484][    C7]  bus_remove_device+0xec/0x118
[110121.667491][    C7]  device_del+0x1e8/0x4ac
[110121.667498][    C7]  device_unregister+0x18/0x38
[110121.667504][    C7]  typec_unregister_altmode+0x30/0x44
[110121.667515][    C7]  tcpm_reset_port+0xac/0x370
[110121.667523][    C7]  tcpm_snk_detach+0x84/0xb8
[110121.667529][    C7]  run_state_machine+0x4c0/0x1b68
[110121.667536][    C7]  tcpm_state_machine_work+0x94/0xe4
[110121.667544][    C7]  kthread_worker_fn+0x10c/0x244
[110121.667552][    C7]  kthread+0x104/0x1d4
[110121.667557][    C7]  ret_from_fork+0x10/0x20

[110121.667689][    C7] Workqueue: events dp_altmode_work
[110121.667697][    C7] Call trace:
[110121.667701][    C7]  __switch_to+0x174/0x338
[110121.667710][    C7]  __schedule+0x608/0x9f0
[110121.667717][    C7]  schedule+0x7c/0xe8
[110121.667725][    C7]  schedule_preempt_disabled+0x24/0x40
[110121.667733][    C7]  __mutex_lock+0x408/0xdac
[110121.667741][    C7]  __mutex_lock_slowpath+0x14/0x24
[110121.667748][    C7]  mutex_lock+0x40/0xec
[110121.667757][    C7]  tcpm_altmode_enter+0x78/0xb4
[110121.667764][    C7]  typec_altmode_enter+0xdc/0x10c
[110121.667769][    C7]  dp_altmode_work+0x68/0x164
[110121.667775][    C7]  process_one_work+0x1e4/0x43c
[110121.667783][    C7]  worker_thread+0x25c/0x430
[110121.667789][    C7]  kthread+0x104/0x1d4
[110121.667794][    C7]  ret_from_fork+0x10/0x20

Change tcpm_queue_vdm_unlocked to queue for tcpm_queue_vdm_work,
which can perform the state check while holding the TCPM lock
while the Alt Mode lock is no longer held. This requires a new
struct to hold the vdm data, altmode_vdm_event.

Fixes: cdc9946ea637 ("usb: typec: tcpm: enforce ready state when queueing alt mode vdm")
Cc: stable <stable@kernel.org>
Signed-off-by: RD Babiera <rdbabiera@google.com>
Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Reviewed-by: Badhri Jagan Sridharan <badhri@google.com>
Link: https://lore.kernel.org/r/20250506232853.1968304-2-rdbabiera@google.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/typec/tcpm/tcpm.c |   91 ++++++++++++++++++++++++++++++++----------
 1 file changed, 71 insertions(+), 20 deletions(-)

--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -568,6 +568,15 @@ struct pd_rx_event {
 	enum tcpm_transmit_type rx_sop_type;
 };
 
+struct altmode_vdm_event {
+	struct kthread_work work;
+	struct tcpm_port *port;
+	u32 header;
+	u32 *data;
+	int cnt;
+	enum tcpm_transmit_type tx_sop_type;
+};
+
 static const char * const pd_rev[] = {
 	[PD_REV10]		= "rev1",
 	[PD_REV20]		= "rev2",
@@ -1562,18 +1571,68 @@ static void tcpm_queue_vdm(struct tcpm_p
 	mod_vdm_delayed_work(port, 0);
 }
 
-static void tcpm_queue_vdm_unlocked(struct tcpm_port *port, const u32 header,
-				    const u32 *data, int cnt, enum tcpm_transmit_type tx_sop_type)
+static void tcpm_queue_vdm_work(struct kthread_work *work)
 {
-	if (port->state != SRC_READY && port->state != SNK_READY &&
-	    port->state != SRC_VDM_IDENTITY_REQUEST)
-		return;
+	struct altmode_vdm_event *event = container_of(work,
+						       struct altmode_vdm_event,
+						       work);
+	struct tcpm_port *port = event->port;
 
 	mutex_lock(&port->lock);
-	tcpm_queue_vdm(port, header, data, cnt, tx_sop_type);
+	if (port->state != SRC_READY && port->state != SNK_READY &&
+	    port->state != SRC_VDM_IDENTITY_REQUEST) {
+		tcpm_log_force(port, "dropping altmode_vdm_event");
+		goto port_unlock;
+	}
+
+	tcpm_queue_vdm(port, event->header, event->data, event->cnt, event->tx_sop_type);
+
+port_unlock:
+	kfree(event->data);
+	kfree(event);
 	mutex_unlock(&port->lock);
 }
 
+static int tcpm_queue_vdm_unlocked(struct tcpm_port *port, const u32 header,
+				   const u32 *data, int cnt, enum tcpm_transmit_type tx_sop_type)
+{
+	struct altmode_vdm_event *event;
+	u32 *data_cpy;
+	int ret = -ENOMEM;
+
+	event = kzalloc(sizeof(*event), GFP_KERNEL);
+	if (!event)
+		goto err_event;
+
+	data_cpy = kcalloc(cnt, sizeof(u32), GFP_KERNEL);
+	if (!data_cpy)
+		goto err_data;
+
+	kthread_init_work(&event->work, tcpm_queue_vdm_work);
+	event->port = port;
+	event->header = header;
+	memcpy(data_cpy, data, sizeof(u32) * cnt);
+	event->data = data_cpy;
+	event->cnt = cnt;
+	event->tx_sop_type = tx_sop_type;
+
+	ret = kthread_queue_work(port->wq, &event->work);
+	if (!ret) {
+		ret = -EBUSY;
+		goto err_queue;
+	}
+
+	return 0;
+
+err_queue:
+	kfree(data_cpy);
+err_data:
+	kfree(event);
+err_event:
+	tcpm_log_force(port, "failed to queue altmode vdm, err:%d", ret);
+	return ret;
+}
+
 static void svdm_consume_identity(struct tcpm_port *port, const u32 *p, int cnt)
 {
 	u32 vdo = p[VDO_INDEX_IDH];
@@ -2784,8 +2843,7 @@ static int tcpm_altmode_enter(struct typ
 	header = VDO(altmode->svid, vdo ? 2 : 1, svdm_version, CMD_ENTER_MODE);
 	header |= VDO_OPOS(altmode->mode);
 
-	tcpm_queue_vdm_unlocked(port, header, vdo, vdo ? 1 : 0, TCPC_TX_SOP);
-	return 0;
+	return tcpm_queue_vdm_unlocked(port, header, vdo, vdo ? 1 : 0, TCPC_TX_SOP);
 }
 
 static int tcpm_altmode_exit(struct typec_altmode *altmode)
@@ -2801,8 +2859,7 @@ static int tcpm_altmode_exit(struct type
 	header = VDO(altmode->svid, 1, svdm_version, CMD_EXIT_MODE);
 	header |= VDO_OPOS(altmode->mode);
 
-	tcpm_queue_vdm_unlocked(port, header, NULL, 0, TCPC_TX_SOP);
-	return 0;
+	return tcpm_queue_vdm_unlocked(port, header, NULL, 0, TCPC_TX_SOP);
 }
 
 static int tcpm_altmode_vdm(struct typec_altmode *altmode,
@@ -2810,9 +2867,7 @@ static int tcpm_altmode_vdm(struct typec
 {
 	struct tcpm_port *port = typec_altmode_get_drvdata(altmode);
 
-	tcpm_queue_vdm_unlocked(port, header, data, count - 1, TCPC_TX_SOP);
-
-	return 0;
+	return tcpm_queue_vdm_unlocked(port, header, data, count - 1, TCPC_TX_SOP);
 }
 
 static const struct typec_altmode_ops tcpm_altmode_ops = {
@@ -2836,8 +2891,7 @@ static int tcpm_cable_altmode_enter(stru
 	header = VDO(altmode->svid, vdo ? 2 : 1, svdm_version, CMD_ENTER_MODE);
 	header |= VDO_OPOS(altmode->mode);
 
-	tcpm_queue_vdm_unlocked(port, header, vdo, vdo ? 1 : 0, TCPC_TX_SOP_PRIME);
-	return 0;
+	return tcpm_queue_vdm_unlocked(port, header, vdo, vdo ? 1 : 0, TCPC_TX_SOP_PRIME);
 }
 
 static int tcpm_cable_altmode_exit(struct typec_altmode *altmode, enum typec_plug_index sop)
@@ -2853,8 +2907,7 @@ static int tcpm_cable_altmode_exit(struc
 	header = VDO(altmode->svid, 1, svdm_version, CMD_EXIT_MODE);
 	header |= VDO_OPOS(altmode->mode);
 
-	tcpm_queue_vdm_unlocked(port, header, NULL, 0, TCPC_TX_SOP_PRIME);
-	return 0;
+	return tcpm_queue_vdm_unlocked(port, header, NULL, 0, TCPC_TX_SOP_PRIME);
 }
 
 static int tcpm_cable_altmode_vdm(struct typec_altmode *altmode, enum typec_plug_index sop,
@@ -2862,9 +2915,7 @@ static int tcpm_cable_altmode_vdm(struct
 {
 	struct tcpm_port *port = typec_altmode_get_drvdata(altmode);
 
-	tcpm_queue_vdm_unlocked(port, header, data, count - 1, TCPC_TX_SOP_PRIME);
-
-	return 0;
+	return tcpm_queue_vdm_unlocked(port, header, data, count - 1, TCPC_TX_SOP_PRIME);
 }
 
 static const struct typec_cable_ops tcpm_cable_ops = {



