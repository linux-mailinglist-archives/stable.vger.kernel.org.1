Return-Path: <stable+bounces-237636-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IKx9Lgc93WmqbAkAu9opvQ
	(envelope-from <stable+bounces-237636-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 20:59:19 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FF2B3F253B
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 20:59:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3C4F43018626
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 18:59:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8621390995;
	Mon, 13 Apr 2026 18:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O0QhKUCM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABD3C23EAB2
	for <stable@vger.kernel.org>; Mon, 13 Apr 2026 18:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776106749; cv=none; b=S0VWb0kNxFnkcAYE+I3tKr/lWpCGDBSbBomr/4/Ahqk4D5P5hGJuTE/J8a2Y0g/9K2GVE4LivwvxHxxIpadvBKe8534KRA/SmITNyBdRevsaBYvdFqtvMnB1A8CE9Y4DC9ZqghQwfaI1/IZP6F/dha5JXxDj4KJR4ZD0Z/CZYm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776106749; c=relaxed/simple;
	bh=9EtOELKQd3hjsa6kWchiRAxxnGqnV/lt0I2ai9VgBZo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ryO0un1dsPrsbH8ufRaC2UejDufr8xb3Q5HgHId8gc0IM++I+X6uPCzC7rDkBXZqH7eedBl5c1WGOx71PFnHYvB22AXXGbVEdoLzFo8Lmf7ubDNYwNv7Y1gv/57IBAIBUGee1GJRXeGvXfcXquNaaSSBEIuYmdwf4uwVcdibiUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O0QhKUCM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 602B4C2BCAF;
	Mon, 13 Apr 2026 18:59:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776106749;
	bh=9EtOELKQd3hjsa6kWchiRAxxnGqnV/lt0I2ai9VgBZo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=O0QhKUCMfhS0kAqXwC3EQmpBR+wxVZKfc670daf/zeJDNFLrqgwIzzPxcYHdCL82r
	 93CjtMfhp2J8oyyoJ9Mh/kLDVKlhLVWukmTYZhesB9c1MW0yS7jzfw4QHgyt04GHGh
	 7Nn2oyyQzCmISkTEFEn+iWCTgmYnJsE+302+shS+n0iVNd8He5eDb3RvCIiMY4V9s6
	 XrzqXRPdURJKeeT0MtpApRBQGGmqchlp0w8hgfBzbXeJavfW8hpsps6y50t+yCdz7E
	 02eufDp3fEVC6K6hJunGwSIUESONSINZXwMscOwTp8TezbvJBabotEdRrd8GOQ2oO6
	 xgdM4/fhfJxwA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Milena Olech <milena.olech@intel.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Willem de Bruijn <willemb@google.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Mina Almasry <almasrymina@google.com>,
	Samuel Salin <Samuel.salin@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/2] idpf: move virtchnl structures to the header file
Date: Mon, 13 Apr 2026 14:59:05 -0400
Message-ID: <20260413185906.3429937-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026041354-trowel-buggy-c7ca@gregkh>
References: <2026041354-trowel-buggy-c7ca@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-237636-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,intel.com:email]
X-Rspamd-Queue-Id: 5FF2B3F253B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Milena Olech <milena.olech@intel.com>

[ Upstream commit c5d0607f424e4091c879688383ac4754739a1669 ]

Move virtchnl structures to the header file to expose them for the PTP
virtchnl file.

Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Milena Olech <milena.olech@intel.com>
Tested-by: Mina Almasry <almasrymina@google.com>
Tested-by: Samuel Salin <Samuel.salin@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
Stable-dep-of: 591478118293 ("idpf: fix PREEMPT_RT raw/bh spinlock nesting for async VC handling")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../net/ethernet/intel/idpf/idpf_virtchnl.c   | 86 +------------------
 .../net/ethernet/intel/idpf/idpf_virtchnl.h   | 84 ++++++++++++++++++
 2 files changed, 86 insertions(+), 84 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
index 3d80b53161a4c..946aca7a07681 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
@@ -6,88 +6,6 @@
 #include "idpf.h"
 #include "idpf_virtchnl.h"
 
-#define IDPF_VC_XN_MIN_TIMEOUT_MSEC	2000
-#define IDPF_VC_XN_DEFAULT_TIMEOUT_MSEC	(60 * 1000)
-#define IDPF_VC_XN_IDX_M		GENMASK(7, 0)
-#define IDPF_VC_XN_SALT_M		GENMASK(15, 8)
-#define IDPF_VC_XN_RING_LEN		U8_MAX
-
-/**
- * enum idpf_vc_xn_state - Virtchnl transaction status
- * @IDPF_VC_XN_IDLE: not expecting a reply, ready to be used
- * @IDPF_VC_XN_WAITING: expecting a reply, not yet received
- * @IDPF_VC_XN_COMPLETED_SUCCESS: a reply was expected and received,
- *				  buffer updated
- * @IDPF_VC_XN_COMPLETED_FAILED: a reply was expected and received, but there
- *				 was an error, buffer not updated
- * @IDPF_VC_XN_SHUTDOWN: transaction object cannot be used, VC torn down
- * @IDPF_VC_XN_ASYNC: transaction sent asynchronously and doesn't have the
- *		      return context; a callback may be provided to handle
- *		      return
- */
-enum idpf_vc_xn_state {
-	IDPF_VC_XN_IDLE = 1,
-	IDPF_VC_XN_WAITING,
-	IDPF_VC_XN_COMPLETED_SUCCESS,
-	IDPF_VC_XN_COMPLETED_FAILED,
-	IDPF_VC_XN_SHUTDOWN,
-	IDPF_VC_XN_ASYNC,
-};
-
-struct idpf_vc_xn;
-/* Callback for asynchronous messages */
-typedef int (*async_vc_cb) (struct idpf_adapter *, struct idpf_vc_xn *,
-			    const struct idpf_ctlq_msg *);
-
-/**
- * struct idpf_vc_xn - Data structure representing virtchnl transactions
- * @completed: virtchnl event loop uses that to signal when a reply is
- *	       available, uses kernel completion API
- * @state: virtchnl event loop stores the data below, protected by the
- *	   completion's lock.
- * @reply_sz: Original size of reply, may be > reply_buf.iov_len; it will be
- *	      truncated on its way to the receiver thread according to
- *	      reply_buf.iov_len.
- * @reply: Reference to the buffer(s) where the reply data should be written
- *	   to. May be 0-length (then NULL address permitted) if the reply data
- *	   should be ignored.
- * @async_handler: if sent asynchronously, a callback can be provided to handle
- *		   the reply when it's received
- * @vc_op: corresponding opcode sent with this transaction
- * @idx: index used as retrieval on reply receive, used for cookie
- * @salt: changed every message to make unique, used for cookie
- */
-struct idpf_vc_xn {
-	struct completion completed;
-	enum idpf_vc_xn_state state;
-	size_t reply_sz;
-	struct kvec reply;
-	async_vc_cb async_handler;
-	u32 vc_op;
-	u8 idx;
-	u8 salt;
-};
-
-/**
- * struct idpf_vc_xn_params - Parameters for executing transaction
- * @send_buf: kvec for send buffer
- * @recv_buf: kvec for recv buffer, may be NULL, must then have zero length
- * @timeout_ms: timeout to wait for reply
- * @async: send message asynchronously, will not wait on completion
- * @async_handler: If sent asynchronously, optional callback handler. The user
- *		   must be careful when using async handlers as the memory for
- *		   the recv_buf _cannot_ be on stack if this is async.
- * @vc_op: virtchnl op to send
- */
-struct idpf_vc_xn_params {
-	struct kvec send_buf;
-	struct kvec recv_buf;
-	int timeout_ms;
-	bool async;
-	async_vc_cb async_handler;
-	u32 vc_op;
-};
-
 /**
  * struct idpf_vc_xn_manager - Manager for tracking transactions
  * @ring: backing and lookup for transactions
@@ -449,8 +367,8 @@ static void idpf_vc_xn_push_free(struct idpf_vc_xn_manager *vcxn_mngr,
  * >= @recv_buf.iov_len, but we never overflow @@recv_buf_iov_base). < 0 for
  * error.
  */
-static ssize_t idpf_vc_xn_exec(struct idpf_adapter *adapter,
-			       const struct idpf_vc_xn_params *params)
+ssize_t idpf_vc_xn_exec(struct idpf_adapter *adapter,
+			const struct idpf_vc_xn_params *params)
 {
 	const struct kvec *send_buf = &params->send_buf;
 	struct idpf_vc_xn *xn;
diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.h b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.h
index 23271cf0a2160..77578206badab 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.h
+++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.h
@@ -4,6 +4,88 @@
 #ifndef _IDPF_VIRTCHNL_H_
 #define _IDPF_VIRTCHNL_H_
 
+#define IDPF_VC_XN_MIN_TIMEOUT_MSEC	2000
+#define IDPF_VC_XN_DEFAULT_TIMEOUT_MSEC	(60 * 1000)
+#define IDPF_VC_XN_IDX_M		GENMASK(7, 0)
+#define IDPF_VC_XN_SALT_M		GENMASK(15, 8)
+#define IDPF_VC_XN_RING_LEN		U8_MAX
+
+/**
+ * enum idpf_vc_xn_state - Virtchnl transaction status
+ * @IDPF_VC_XN_IDLE: not expecting a reply, ready to be used
+ * @IDPF_VC_XN_WAITING: expecting a reply, not yet received
+ * @IDPF_VC_XN_COMPLETED_SUCCESS: a reply was expected and received, buffer
+ *				  updated
+ * @IDPF_VC_XN_COMPLETED_FAILED: a reply was expected and received, but there
+ *				 was an error, buffer not updated
+ * @IDPF_VC_XN_SHUTDOWN: transaction object cannot be used, VC torn down
+ * @IDPF_VC_XN_ASYNC: transaction sent asynchronously and doesn't have the
+ *		      return context; a callback may be provided to handle
+ *		      return
+ */
+enum idpf_vc_xn_state {
+	IDPF_VC_XN_IDLE = 1,
+	IDPF_VC_XN_WAITING,
+	IDPF_VC_XN_COMPLETED_SUCCESS,
+	IDPF_VC_XN_COMPLETED_FAILED,
+	IDPF_VC_XN_SHUTDOWN,
+	IDPF_VC_XN_ASYNC,
+};
+
+struct idpf_vc_xn;
+/* Callback for asynchronous messages */
+typedef int (*async_vc_cb) (struct idpf_adapter *, struct idpf_vc_xn *,
+			    const struct idpf_ctlq_msg *);
+
+/**
+ * struct idpf_vc_xn - Data structure representing virtchnl transactions
+ * @completed: virtchnl event loop uses that to signal when a reply is
+ *	       available, uses kernel completion API
+ * @state: virtchnl event loop stores the data below, protected by the
+ *	   completion's lock.
+ * @reply_sz: Original size of reply, may be > reply_buf.iov_len; it will be
+ *	      truncated on its way to the receiver thread according to
+ *	      reply_buf.iov_len.
+ * @reply: Reference to the buffer(s) where the reply data should be written
+ *	   to. May be 0-length (then NULL address permitted) if the reply data
+ *	   should be ignored.
+ * @async_handler: if sent asynchronously, a callback can be provided to handle
+ *		   the reply when it's received
+ * @vc_op: corresponding opcode sent with this transaction
+ * @idx: index used as retrieval on reply receive, used for cookie
+ * @salt: changed every message to make unique, used for cookie
+ */
+struct idpf_vc_xn {
+	struct completion completed;
+	enum idpf_vc_xn_state state;
+	size_t reply_sz;
+	struct kvec reply;
+	async_vc_cb async_handler;
+	u32 vc_op;
+	u8 idx;
+	u8 salt;
+};
+
+/**
+ * struct idpf_vc_xn_params - Parameters for executing transaction
+ * @send_buf: kvec for send buffer
+ * @recv_buf: kvec for recv buffer, may be NULL, must then have zero length
+ * @timeout_ms: timeout to wait for reply
+ * @async: send message asynchronously, will not wait on completion
+ * @async_handler: If sent asynchronously, optional callback handler. The user
+ *		   must be careful when using async handlers as the memory for
+ *		   the recv_buf _cannot_ be on stack if this is async.
+ * @vc_op: virtchnl op to send
+ */
+struct idpf_vc_xn_params {
+	struct kvec send_buf;
+	struct kvec recv_buf;
+	int timeout_ms;
+	bool async;
+	async_vc_cb async_handler;
+	u32 vc_op;
+};
+
 struct idpf_adapter;
 struct idpf_netdev_priv;
 struct idpf_vec_regs;
@@ -11,6 +93,8 @@ struct idpf_vport;
 struct idpf_vport_max_q;
 struct idpf_vport_user_config_data;
 
+ssize_t idpf_vc_xn_exec(struct idpf_adapter *adapter,
+			const struct idpf_vc_xn_params *params);
 int idpf_init_dflt_mbx(struct idpf_adapter *adapter);
 void idpf_deinit_dflt_mbx(struct idpf_adapter *adapter);
 int idpf_vc_core_init(struct idpf_adapter *adapter);
-- 
2.53.0


