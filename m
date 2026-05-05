Return-Path: <stable+bounces-243974-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2Lv6IIx9+WmZ9AIAu9opvQ
	(envelope-from <stable+bounces-243974-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 07:18:04 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0491A4C6C8D
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 07:18:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6B4F73047DDF
	for <lists+stable@lfdr.de>; Tue,  5 May 2026 05:16:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86FB03C5DCD;
	Tue,  5 May 2026 05:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d86G2D5j"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 489723C1969;
	Tue,  5 May 2026 05:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777958144; cv=none; b=I6DYYPe1LAAvqvVlX/EdPbKLTM5tbjJ/YC+B4A9Y4v2WoyXO2202U/gS5VGrqhV2VGz7eXgowJrekUW8xP3TdF6kLF4xYUj83jfQDzgW1XKy/e8Yan4XmCgPUcOH+kf8kccG8IZJLCA4TiMjRv7XWT8PjJ/PHu2ebqjq/RvIcUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777958144; c=relaxed/simple;
	bh=pbR7JwtXASt0IOmnygmQFZ2bAgwitMbjo1NT7cigBQ8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SLZ1NnqxXVtqI0MFXZcECVvRpi0HaNlNC/0xvjGKRlODK2NEIW9/AOxMgciQS3U9+mwZUw0wmJNV4HTDMNHdLPDiPwYuL4jZ4bzpCOizSIUg+DxybpFeiUy3xaFs3SixMPlgH1gCJJPG8FpVExI2yyZ/IDYlhNy/8h2FtCQ2UMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d86G2D5j; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777958142; x=1809494142;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=pbR7JwtXASt0IOmnygmQFZ2bAgwitMbjo1NT7cigBQ8=;
  b=d86G2D5jRXz+fqMZKQGt8c2gvNMhM7gKa2WBFUOAvLqe4PRhkEPeW4A5
   I/kNxURKDQEMhdY7UUYlVjy7jb5F8tP7HCEyV3uY0KCY3jALLEYai2sy8
   Hgk/kbQVtgpo2u6AnpsXouXMf7oes5OooGS+hDWdrb1b7bK3oYZ+iYGxt
   UZemzZOPDaSbF6kUVeHcrnNyRh1ahJTlMrszn8vAeDbh09ytxuw1kiGxK
   bQSxa7+zO2FTBCfEcU6AIuELBU6+OMc6jEdRawfPFUhF8nz12s5dVaKPn
   OyAMqxNYXZOCpi2EK/QCTAv/h3ffxnMOWuzsegno4TjsL3yzuVVmWV0ed
   g==;
X-CSE-ConnectionGUID: zezQelhETcqWjhkoPTCyxA==
X-CSE-MsgGUID: J6vCxvuYQGeFw79RSqj5OA==
X-IronPort-AV: E=McAfee;i="6800,10657,11776"; a="89126463"
X-IronPort-AV: E=Sophos;i="6.23,216,1770624000"; 
   d="scan'208";a="89126463"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2026 22:15:37 -0700
X-CSE-ConnectionGUID: DnjtoIWTS6GRK9CKfp657g==
X-CSE-MsgGUID: BDCX+4auS9uu0viupHzkhA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,216,1770624000"; 
   d="scan'208";a="239683505"
Received: from orcnseosdtjek.jf.intel.com (HELO [10.166.28.109]) ([10.166.28.109])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2026 22:15:37 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Mon, 04 May 2026 22:14:20 -0700
Subject: [PATCH net 07/13] idpf: fix xdp crash in soft reset error path
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260504-jk-iwl-net-2026-05-04-v1-7-a222a88bd962@intel.com>
References: <20260504-jk-iwl-net-2026-05-04-v1-0-a222a88bd962@intel.com>
In-Reply-To: <20260504-jk-iwl-net-2026-05-04-v1-0-a222a88bd962@intel.com>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Piotr Kwapulinski <piotr.kwapulinski@intel.com>, 
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>, 
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>, 
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>, 
 Michal Kubiak <michal.kubiak@intel.com>, 
 Joshua Hay <joshua.a.hay@intel.com>, 
 Madhu Chittim <madhu.chittim@intel.com>, 
 Willem de Bruijn <willemb@google.com>, 
 Dave Ertman <david.m.ertman@intel.com>, Ivan Vecera <ivecera@redhat.com>, 
 Grzegorz Nitka <grzegorz.nitka@intel.com>
Cc: netdev@vger.kernel.org, stable@vger.kernel.org, 
 Jacob Keller <jacob.e.keller@intel.com>, 
 Emil Tantilov <emil.s.tantilov@intel.com>
X-Mailer: b4 0.16-dev-ea14f
X-Developer-Signature: v=1; a=openpgp-sha256; l=10193;
 i=jacob.e.keller@intel.com; h=from:subject:message-id;
 bh=/ZZ1SfBCScDHoI+kNUkyxL5Q4Kvdm6viQyce4wd1MD4=;
 b=owGbwMvMwCWWNS3WLp9f4wXjabUkhsyfNd8urUyR/lAh4NNvsD37/7wzc3fWqp9SMtzE91Hs6
 r3J3lWOHaUsDGJcDLJiiiwKDiErrxtPCNN64ywHM4eVCWQIAxenAEzkVxvD/+zIW9s/3qsImtz5
 1P/KpWUBDF1M+z8ob2o4qTTb+WH8VEeG/9573rLOuH7b7LBO6+5Nh5l/Xvjl8Yf966/Tj2JjNm1
 zy+EAAA==
X-Developer-Key: i=jacob.e.keller@intel.com; a=openpgp;
 fpr=204054A9D73390562AEC431E6A965D3E6F0F28E8
X-Rspamd-Queue-Id: 0491A4C6C8D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-243974-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jacob.e.keller@intel.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable,netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,intel.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

From: Emil Tantilov <emil.s.tantilov@intel.com>

NULL pointer dereference is reported in cases where idpf_vport_open()
fails during soft reset:

./xdpsock -i <inf> -q -r -N

[ 3179.186687] idpf 0000:83:00.0: Failed to initialize queue ids for vport 0: -12
[ 3179.276739] BUG: kernel NULL pointer dereference, address: 0000000000000010
[ 3179.277636] #PF: supervisor read access in kernel mode
[ 3179.278470] #PF: error_code(0x0000) - not-present page
[ 3179.279285] PGD 0
[ 3179.280083] Oops: Oops: 0000 [#1] SMP NOPTI
...
[ 3179.283997] Workqueue: events xp_release_deferred
[ 3179.284770] RIP: 0010:idpf_find_rxq_vec+0x17/0x30 [idpf]
...
[ 3179.291937] Call Trace:
[ 3179.292392]  <TASK>
[ 3179.292843]  idpf_qp_switch+0x25/0x820 [idpf]
[ 3179.293325]  idpf_xsk_pool_setup+0x7c/0x520 [idpf]
[ 3179.293803]  idpf_xdp+0x59/0x240 [idpf]
[ 3179.294275]  xp_disable_drv_zc+0x62/0xb0
[ 3179.294743]  xp_clear_dev+0x40/0xb0
[ 3179.295198]  xp_release_deferred+0x1f/0xa0
[ 3179.295648]  process_one_work+0x226/0x730
[ 3179.296106]  worker_thread+0x19e/0x340
[ 3179.296557]  ? __pfx_worker_thread+0x10/0x10
[ 3179.297009]  kthread+0xf4/0x130
[ 3179.297459]  ? __pfx_kthread+0x10/0x10
[ 3179.297910]  ret_from_fork+0x32c/0x410
[ 3179.298361]  ? __pfx_kthread+0x10/0x10
[ 3179.298702]  ret_from_fork_asm+0x1a/0x30

Fix the error handling of the soft reset in idpf_xdp_setup_prog() by
restoring the vport->xdp_prog to the old value. This avoids referencing
the orphaned prog that was copied to vport->xdp_prog in the soft reset
and prevents subsequent false positive by idpf_xdp_enabled(). Roll back
the number of queues as well. Also only call put on the program if the
soft reset was successful. Returning an error will trigger the core XDP
stack to handle the put otherwise.

Update the restart check in idpf_xsk_pool_setup() to use IDPF_VPORT_UP bit
instead of netif_running(). The idpf_vport_stop/start() calls will not
update the __LINK_STATE_START bit, making this test a false positive
should the soft reset fail.

Fixes: 3d57b2c00f09 ("idpf: add XSk pool initialization")
Cc: stable@vger.kernel.org
Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
Signed-off-by: Joshua Hay <joshua.a.hay@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf_txrx.h     |  6 +++---
 drivers/net/ethernet/intel/idpf/idpf_virtchnl.h |  4 ++--
 drivers/net/ethernet/intel/idpf/idpf_lib.c      |  4 +---
 drivers/net/ethernet/intel/idpf/idpf_txrx.c     | 12 ++++--------
 drivers/net/ethernet/intel/idpf/idpf_virtchnl.c | 19 ++++---------------
 drivers/net/ethernet/intel/idpf/xdp.c           |  8 +++++---
 drivers/net/ethernet/intel/idpf/xsk.c           |  4 +++-
 7 files changed, 22 insertions(+), 35 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.h b/drivers/net/ethernet/intel/idpf/idpf_txrx.h
index b6836e38f449..22c647d6dd5c 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.h
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.h
@@ -1084,9 +1084,9 @@ void idpf_vport_init_num_qs(struct idpf_vport *vport,
 			    struct idpf_q_vec_rsrc *rsrc);
 void idpf_vport_calc_num_q_desc(struct idpf_vport *vport,
 				struct idpf_q_vec_rsrc *rsrc);
-int idpf_vport_calc_total_qs(struct idpf_adapter *adapter, u16 vport_index,
-			     struct virtchnl2_create_vport *vport_msg,
-			     struct idpf_vport_max_q *max_q);
+void idpf_vport_calc_total_qs(struct idpf_adapter *adapter, u16 vport_index,
+			      struct virtchnl2_create_vport *vport_msg,
+			      struct idpf_vport_max_q *max_q);
 void idpf_vport_calc_num_q_groups(struct idpf_q_vec_rsrc *rsrc);
 int idpf_vport_queues_alloc(struct idpf_vport *vport,
 			    struct idpf_q_vec_rsrc *rsrc);
diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.h b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.h
index 6876e3ed9d1b..76d238fc660c 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.h
+++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.h
@@ -169,8 +169,8 @@ int idpf_send_destroy_vport_msg(struct idpf_adapter *adapter, u32 vport_id);
 int idpf_send_enable_vport_msg(struct idpf_adapter *adapter, u32 vport_id);
 int idpf_send_disable_vport_msg(struct idpf_adapter *adapter, u32 vport_id);
 
-int idpf_vport_adjust_qs(struct idpf_vport *vport,
-			 struct idpf_q_vec_rsrc *rsrc);
+void idpf_vport_adjust_qs(struct idpf_vport *vport,
+			  struct idpf_q_vec_rsrc *rsrc);
 int idpf_vport_alloc_max_qs(struct idpf_adapter *adapter,
 			    struct idpf_vport_max_q *max_q);
 void idpf_vport_dealloc_max_qs(struct idpf_adapter *adapter,
diff --git a/drivers/net/ethernet/intel/idpf/idpf_lib.c b/drivers/net/ethernet/intel/idpf/idpf_lib.c
index cf966fe6c759..56198b417c97 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_lib.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_lib.c
@@ -2042,9 +2042,7 @@ int idpf_initiate_soft_reset(struct idpf_vport *vport,
 	/* Adjust resource parameters prior to reallocating resources */
 	switch (reset_cause) {
 	case IDPF_SR_Q_CHANGE:
-		err = idpf_vport_adjust_qs(new_vport, new_rsrc);
-		if (err)
-			goto free_vport;
+		idpf_vport_adjust_qs(new_vport, new_rsrc);
 		break;
 	case IDPF_SR_Q_DESC_CHANGE:
 		/* Update queue parameters before allocating resources */
diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
index 4fc0bb14c5b1..4e0d31023123 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
@@ -1568,12 +1568,10 @@ void idpf_vport_calc_num_q_desc(struct idpf_vport *vport,
  * @vport_idx: vport idx to retrieve vport pointer
  * @vport_msg: message to fill with data
  * @max_q: vport max queue info
- *
- * Return: 0 on success, error value on failure.
  */
-int idpf_vport_calc_total_qs(struct idpf_adapter *adapter, u16 vport_idx,
-			     struct virtchnl2_create_vport *vport_msg,
-			     struct idpf_vport_max_q *max_q)
+void idpf_vport_calc_total_qs(struct idpf_adapter *adapter, u16 vport_idx,
+			      struct virtchnl2_create_vport *vport_msg,
+			      struct idpf_vport_max_q *max_q)
 {
 	int dflt_splitq_txq_grps = 0, dflt_singleq_txqs = 0;
 	int dflt_splitq_rxq_grps = 0, dflt_singleq_rxqs = 0;
@@ -1624,7 +1622,7 @@ int idpf_vport_calc_total_qs(struct idpf_adapter *adapter, u16 vport_idx,
 	}
 
 	if (!vport_config)
-		return 0;
+		return;
 
 	user = &vport_config->user_config;
 	user->num_req_rx_qs = le16_to_cpu(vport_msg->num_rx_q);
@@ -1640,8 +1638,6 @@ int idpf_vport_calc_total_qs(struct idpf_adapter *adapter, u16 vport_idx,
 	vport_msg->num_tx_q = cpu_to_le16(user->num_req_tx_qs + num_xdpsq);
 	if (idpf_is_queue_model_split(le16_to_cpu(vport_msg->txq_model)))
 		vport_msg->num_tx_complq = vport_msg->num_tx_q;
-
-	return 0;
 }
 
 /**
diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
index be66f9b2e101..91af4f298475 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
@@ -1578,12 +1578,7 @@ int idpf_send_create_vport_msg(struct idpf_adapter *adapter,
 	else
 		vport_msg->rxq_model = cpu_to_le16(VIRTCHNL2_QUEUE_MODEL_SINGLE);
 
-	err = idpf_vport_calc_total_qs(adapter, idx, vport_msg, max_q);
-	if (err) {
-		dev_err(&adapter->pdev->dev, "Enough queues are not available");
-
-		return err;
-	}
+	idpf_vport_calc_total_qs(adapter, idx, vport_msg, max_q);
 
 	if (!adapter->vport_params_recvd[idx]) {
 		adapter->vport_params_recvd[idx] = kzalloc(IDPF_CTLQ_MAX_BUF_LEN,
@@ -4065,24 +4060,18 @@ int idpf_vport_queue_ids_init(struct idpf_vport *vport,
  * @vport: virtual port data struct
  * @rsrc: pointer to queue and vector resources
  *
- * Renegotiate queues.  Returns 0 on success, negative on failure.
+ * Renegotiate queues.
  */
-int idpf_vport_adjust_qs(struct idpf_vport *vport, struct idpf_q_vec_rsrc *rsrc)
+void idpf_vport_adjust_qs(struct idpf_vport *vport, struct idpf_q_vec_rsrc *rsrc)
 {
 	struct virtchnl2_create_vport vport_msg;
-	int err;
 
 	vport_msg.txq_model = cpu_to_le16(rsrc->txq_model);
 	vport_msg.rxq_model = cpu_to_le16(rsrc->rxq_model);
-	err = idpf_vport_calc_total_qs(vport->adapter, vport->idx, &vport_msg,
-				       NULL);
-	if (err)
-		return err;
+	idpf_vport_calc_total_qs(vport->adapter, vport->idx, &vport_msg, NULL);
 
 	idpf_vport_init_num_qs(vport, &vport_msg, rsrc);
 	idpf_vport_calc_num_q_groups(rsrc);
-
-	return 0;
 }
 
 /**
diff --git a/drivers/net/ethernet/intel/idpf/xdp.c b/drivers/net/ethernet/intel/idpf/xdp.c
index dcd867517a5f..f6e6b72169fd 100644
--- a/drivers/net/ethernet/intel/idpf/xdp.c
+++ b/drivers/net/ethernet/intel/idpf/xdp.c
@@ -488,11 +488,13 @@ static int idpf_xdp_setup_prog(struct idpf_vport *vport,
 				   "Could not reopen the vport after XDP setup");
 
 		cfg->user_config.xdp_prog = old;
-		old = prog;
-	}
+		vport->xdp_prog = old;
 
-	if (old)
+		/* Restore previous queue config */
+		idpf_vport_adjust_qs(vport, &vport->dflt_qv_rsrc);
+	} else if (old) {
 		bpf_prog_put(old);
+	}
 
 	libeth_xdp_set_redirect(vport->netdev, vport->xdp_prog);
 
diff --git a/drivers/net/ethernet/intel/idpf/xsk.c b/drivers/net/ethernet/intel/idpf/xsk.c
index d95d3efdfd36..3d8c430efd2b 100644
--- a/drivers/net/ethernet/intel/idpf/xsk.c
+++ b/drivers/net/ethernet/intel/idpf/xsk.c
@@ -553,6 +553,7 @@ int idpf_xskrq_poll(struct idpf_rx_queue *rxq, u32 budget)
 
 int idpf_xsk_pool_setup(struct idpf_vport *vport, struct netdev_bpf *bpf)
 {
+	const struct idpf_netdev_priv *np = netdev_priv(vport->netdev);
 	struct xsk_buff_pool *pool = bpf->xsk.pool;
 	u32 qid = bpf->xsk.queue_id;
 	bool restart;
@@ -568,7 +569,8 @@ int idpf_xsk_pool_setup(struct idpf_vport *vport, struct netdev_bpf *bpf)
 		return -EINVAL;
 	}
 
-	restart = idpf_xdp_enabled(vport) && netif_running(vport->netdev);
+	restart = idpf_xdp_enabled(vport) &&
+		  test_bit(IDPF_VPORT_UP, np->state);
 	if (!restart)
 		goto pool;
 

-- 
2.54.0.rc2.531.gaf818d63126a


