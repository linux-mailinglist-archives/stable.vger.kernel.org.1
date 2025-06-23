Return-Path: <stable+bounces-157307-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ED27AE5368
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 23:52:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5958F443DD3
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 21:52:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 780A222258C;
	Mon, 23 Jun 2025 21:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tTa1EZP3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32004218AC1;
	Mon, 23 Jun 2025 21:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750715548; cv=none; b=MwHOIqHybovr6TGKTboA+Ff06ka39HStKRcQd8xh0kmI4Ubr5/F7HWxqdivl567O4cpybVKwdpUCSAmuEwOHBNXQ0cIIEw2ZVwy6S+b/yZYVG4mlEPmJ6Rl7om5LiJSVeKzUJbAyf1xSPlcCXeM/dCTr7/DGcO9+oENVGpu6kmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750715548; c=relaxed/simple;
	bh=IPZlk6iqJg2HSCeaExyPtiTkxEBLian+lvRogLZWsV8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FLte8aiIS5srj9rD8o3Hb6ZW2zamcvdzWDray511ks/8IMvi8Je8soMcTsckHo8gqVYKpoFI3qw1QWqzYdzj8lpwzXMkAnsp9nH8YIv+iffbzIENh5hHL6VSm2Z/NDcpD24ivVdc1mTciKXH1l/AtNZoqJq2PTtRZt6hxOOfJhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tTa1EZP3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBAA0C4CEEA;
	Mon, 23 Jun 2025 21:52:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750715548;
	bh=IPZlk6iqJg2HSCeaExyPtiTkxEBLian+lvRogLZWsV8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tTa1EZP3oICDt/p8F+sHPfoRW24kUecErV5y7UWPJydUvj7ZNypdpbgKrfZTSloz4
	 FajF65h/dKiU20aRny+qUqI3rwHFMMze2FNsi3hejGmfVEISWBrhGVudEPAiz8r29p
	 nctIV16Uhlh2fDQPY3ompSBwRpnO/ovsQBp443vI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ben Skeggs <bskeggs@nvidia.com>,
	Alexandre Courbot <acourbot@nvidia.com>,
	Zhi Wang <zhiw@nvidia.com>,
	Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH 6.15 486/592] drm/nouveau/nvkm: factor out current GSP RPC command policies
Date: Mon, 23 Jun 2025 15:07:24 +0200
Message-ID: <20250623130711.993070918@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250623130700.210182694@linuxfoundation.org>
References: <20250623130700.210182694@linuxfoundation.org>
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

6.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Zhi Wang <zhiw@nvidia.com>

commit 4570355f8eaa476164cfb7ca959fdbf0cebbc9eb upstream.

There can be multiple cases of handling the GSP RPC messages, which are
the reply of GSP RPC commands according to the requirement of the
callers and the nature of the GSP RPC commands.

The current supported reply policies are "callers don't care" and "receive
the entire message" according to the requirement of the callers. To
introduce a new policy, factor out the current RPC command reply polices.
Also, centralize the handling of the reply in a single function.

Factor out NVKM_GSP_RPC_REPLY_NOWAIT as "callers don't care" and
NVKM_GSP_RPC_REPLY_RECV as "receive the entire message". Introduce a
kernel doc to document the policies. Factor out
r535_gsp_rpc_handle_reply().

No functional change is intended for small GSP RPC commands. For large GSP
commands, the caller decides the policy of how to handle the returned GSP
RPC message.

Cc: Ben Skeggs <bskeggs@nvidia.com>
Cc: Alexandre Courbot <acourbot@nvidia.com>
Signed-off-by: Zhi Wang <zhiw@nvidia.com>
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
Link: https://patchwork.freedesktop.org/patch/msgid/20250227013554.8269-2-zhiw@nvidia.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 Documentation/gpu/nouveau.rst                      |    3 
 drivers/gpu/drm/nouveau/include/nvkm/subdev/gsp.h  |   34 +++++++--
 drivers/gpu/drm/nouveau/nvkm/subdev/bar/r535.c     |    2 
 drivers/gpu/drm/nouveau/nvkm/subdev/gsp/r535.c     |   75 ++++++++++-----------
 drivers/gpu/drm/nouveau/nvkm/subdev/instmem/r535.c |    2 
 5 files changed, 72 insertions(+), 44 deletions(-)

--- a/Documentation/gpu/nouveau.rst
+++ b/Documentation/gpu/nouveau.rst
@@ -27,3 +27,6 @@ GSP Support
 
 .. kernel-doc:: drivers/gpu/drm/nouveau/nvkm/subdev/gsp/r535.c
    :doc: GSP message queue element
+
+.. kernel-doc:: drivers/gpu/drm/nouveau/include/nvkm/subdev/gsp.h
+   :doc: GSP message handling policy
--- a/drivers/gpu/drm/nouveau/include/nvkm/subdev/gsp.h
+++ b/drivers/gpu/drm/nouveau/include/nvkm/subdev/gsp.h
@@ -31,6 +31,25 @@ typedef int (*nvkm_gsp_msg_ntfy_func)(vo
 struct nvkm_gsp_event;
 typedef void (*nvkm_gsp_event_func)(struct nvkm_gsp_event *, void *repv, u32 repc);
 
+/**
+ * DOC: GSP message handling policy
+ *
+ * When sending a GSP RPC command, there can be multiple cases of handling
+ * the GSP RPC messages, which are the reply of GSP RPC commands, according
+ * to the requirement of the callers and the nature of the GSP RPC commands.
+ *
+ * NVKM_GSP_RPC_REPLY_NOWAIT - If specified, immediately return to the
+ * caller after the GSP RPC command is issued.
+ *
+ * NVKM_GSP_RPC_REPLY_RECV - If specified, wait and receive the entire GSP
+ * RPC message after the GSP RPC command is issued.
+ *
+ */
+enum nvkm_gsp_rpc_reply_policy {
+	NVKM_GSP_RPC_REPLY_NOWAIT = 0,
+	NVKM_GSP_RPC_REPLY_RECV,
+};
+
 struct nvkm_gsp {
 	const struct nvkm_gsp_func *func;
 	struct nvkm_subdev subdev;
@@ -188,7 +207,8 @@ struct nvkm_gsp {
 
 	const struct nvkm_gsp_rm {
 		void *(*rpc_get)(struct nvkm_gsp *, u32 fn, u32 argc);
-		void *(*rpc_push)(struct nvkm_gsp *, void *argv, bool wait, u32 repc);
+		void *(*rpc_push)(struct nvkm_gsp *gsp, void *argv,
+				  enum nvkm_gsp_rpc_reply_policy policy, u32 repc);
 		void (*rpc_done)(struct nvkm_gsp *gsp, void *repv);
 
 		void *(*rm_ctrl_get)(struct nvkm_gsp_object *, u32 cmd, u32 argc);
@@ -255,9 +275,10 @@ nvkm_gsp_rpc_get(struct nvkm_gsp *gsp, u
 }
 
 static inline void *
-nvkm_gsp_rpc_push(struct nvkm_gsp *gsp, void *argv, bool wait, u32 repc)
+nvkm_gsp_rpc_push(struct nvkm_gsp *gsp, void *argv,
+		  enum nvkm_gsp_rpc_reply_policy policy, u32 repc)
 {
-	return gsp->rm->rpc_push(gsp, argv, wait, repc);
+	return gsp->rm->rpc_push(gsp, argv, policy, repc);
 }
 
 static inline void *
@@ -268,13 +289,14 @@ nvkm_gsp_rpc_rd(struct nvkm_gsp *gsp, u3
 	if (IS_ERR_OR_NULL(argv))
 		return argv;
 
-	return nvkm_gsp_rpc_push(gsp, argv, true, argc);
+	return nvkm_gsp_rpc_push(gsp, argv, NVKM_GSP_RPC_REPLY_RECV, argc);
 }
 
 static inline int
-nvkm_gsp_rpc_wr(struct nvkm_gsp *gsp, void *argv, bool wait)
+nvkm_gsp_rpc_wr(struct nvkm_gsp *gsp, void *argv,
+		enum nvkm_gsp_rpc_reply_policy policy)
 {
-	void *repv = nvkm_gsp_rpc_push(gsp, argv, wait, 0);
+	void *repv = nvkm_gsp_rpc_push(gsp, argv, policy, 0);
 
 	if (IS_ERR(repv))
 		return PTR_ERR(repv);
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/bar/r535.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/bar/r535.c
@@ -56,7 +56,7 @@ r535_bar_bar2_update_pde(struct nvkm_gsp
 	rpc->info.entryValue = addr ? ((addr >> 4) | 2) : 0; /* PD3 entry format! */
 	rpc->info.entryLevelShift = 47; //XXX: probably fetch this from mmu!
 
-	return nvkm_gsp_rpc_wr(gsp, rpc, true);
+	return nvkm_gsp_rpc_wr(gsp, rpc, NVKM_GSP_RPC_REPLY_RECV);
 }
 
 static void
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/r535.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/r535.c
@@ -585,13 +585,34 @@ r535_gsp_rpc_poll(struct nvkm_gsp *gsp,
 }
 
 static void *
-r535_gsp_rpc_send(struct nvkm_gsp *gsp, void *payload, bool wait,
-		  u32 gsp_rpc_len)
+r535_gsp_rpc_handle_reply(struct nvkm_gsp *gsp, u32 fn,
+			  enum nvkm_gsp_rpc_reply_policy policy,
+			  u32 gsp_rpc_len)
+{
+	struct nvfw_gsp_rpc *reply;
+	void *repv = NULL;
+
+	switch (policy) {
+	case NVKM_GSP_RPC_REPLY_NOWAIT:
+		break;
+	case NVKM_GSP_RPC_REPLY_RECV:
+		reply = r535_gsp_msg_recv(gsp, fn, gsp_rpc_len);
+		if (!IS_ERR_OR_NULL(reply))
+			repv = reply->data;
+		else
+			repv = reply;
+		break;
+	}
+
+	return repv;
+}
+
+static void *
+r535_gsp_rpc_send(struct nvkm_gsp *gsp, void *payload,
+		  enum nvkm_gsp_rpc_reply_policy policy, u32 gsp_rpc_len)
 {
 	struct nvfw_gsp_rpc *rpc = to_gsp_hdr(payload, rpc);
-	struct nvfw_gsp_rpc *msg;
 	u32 fn = rpc->function;
-	void *repv = NULL;
 	int ret;
 
 	if (gsp->subdev.debug >= NV_DBG_TRACE) {
@@ -605,15 +626,7 @@ r535_gsp_rpc_send(struct nvkm_gsp *gsp,
 	if (ret)
 		return ERR_PTR(ret);
 
-	if (wait) {
-		msg = r535_gsp_msg_recv(gsp, fn, gsp_rpc_len);
-		if (!IS_ERR_OR_NULL(msg))
-			repv = msg->data;
-		else
-			repv = msg;
-	}
-
-	return repv;
+	return r535_gsp_rpc_handle_reply(gsp, fn, policy, gsp_rpc_len);
 }
 
 static void
@@ -797,7 +810,7 @@ r535_gsp_rpc_rm_free(struct nvkm_gsp_obj
 	rpc->params.hRoot = client->object.handle;
 	rpc->params.hObjectParent = 0;
 	rpc->params.hObjectOld = object->handle;
-	return nvkm_gsp_rpc_wr(gsp, rpc, true);
+	return nvkm_gsp_rpc_wr(gsp, rpc, NVKM_GSP_RPC_REPLY_RECV);
 }
 
 static void
@@ -815,7 +828,7 @@ r535_gsp_rpc_rm_alloc_push(struct nvkm_g
 	struct nvkm_gsp *gsp = object->client->gsp;
 	void *ret = NULL;
 
-	rpc = nvkm_gsp_rpc_push(gsp, rpc, true, sizeof(*rpc));
+	rpc = nvkm_gsp_rpc_push(gsp, rpc, NVKM_GSP_RPC_REPLY_RECV, sizeof(*rpc));
 	if (IS_ERR_OR_NULL(rpc))
 		return rpc;
 
@@ -876,7 +889,7 @@ r535_gsp_rpc_rm_ctrl_push(struct nvkm_gs
 	struct nvkm_gsp *gsp = object->client->gsp;
 	int ret = 0;
 
-	rpc = nvkm_gsp_rpc_push(gsp, rpc, true, repc);
+	rpc = nvkm_gsp_rpc_push(gsp, rpc, NVKM_GSP_RPC_REPLY_RECV, repc);
 	if (IS_ERR_OR_NULL(rpc)) {
 		*params = NULL;
 		return PTR_ERR(rpc);
@@ -948,8 +961,8 @@ r535_gsp_rpc_get(struct nvkm_gsp *gsp, u
 }
 
 static void *
-r535_gsp_rpc_push(struct nvkm_gsp *gsp, void *payload, bool wait,
-		  u32 gsp_rpc_len)
+r535_gsp_rpc_push(struct nvkm_gsp *gsp, void *payload,
+		  enum nvkm_gsp_rpc_reply_policy policy, u32 gsp_rpc_len)
 {
 	struct nvfw_gsp_rpc *rpc = to_gsp_hdr(payload, rpc);
 	struct r535_gsp_msg *msg = to_gsp_hdr(rpc, msg);
@@ -967,7 +980,7 @@ r535_gsp_rpc_push(struct nvkm_gsp *gsp,
 		rpc->length = sizeof(*rpc) + max_payload_size;
 		msg->checksum = rpc->length;
 
-		repv = r535_gsp_rpc_send(gsp, payload, false, 0);
+		repv = r535_gsp_rpc_send(gsp, payload, NVKM_GSP_RPC_REPLY_NOWAIT, 0);
 		if (IS_ERR(repv))
 			goto done;
 
@@ -988,7 +1001,7 @@ r535_gsp_rpc_push(struct nvkm_gsp *gsp,
 
 			memcpy(next, payload, size);
 
-			repv = r535_gsp_rpc_send(gsp, next, false, 0);
+			repv = r535_gsp_rpc_send(gsp, next, NVKM_GSP_RPC_REPLY_NOWAIT, 0);
 			if (IS_ERR(repv))
 				goto done;
 
@@ -997,20 +1010,10 @@ r535_gsp_rpc_push(struct nvkm_gsp *gsp,
 		}
 
 		/* Wait for reply. */
-		rpc = r535_gsp_msg_recv(gsp, fn, payload_size +
-					sizeof(*rpc));
-		if (!IS_ERR_OR_NULL(rpc)) {
-			if (wait) {
-				repv = rpc->data;
-			} else {
-				nvkm_gsp_rpc_done(gsp, rpc);
-				repv = NULL;
-			}
-		} else {
-			repv = wait ? rpc : NULL;
-		}
+		repv = r535_gsp_rpc_handle_reply(gsp, fn, policy, payload_size +
+						 sizeof(*rpc));
 	} else {
-		repv = r535_gsp_rpc_send(gsp, payload, wait, gsp_rpc_len);
+		repv = r535_gsp_rpc_send(gsp, payload, policy, gsp_rpc_len);
 	}
 
 done:
@@ -1327,7 +1330,7 @@ r535_gsp_rpc_unloading_guest_driver(stru
 		rpc->newLevel = NV2080_CTRL_GPU_SET_POWER_STATE_GPU_LEVEL_0;
 	}
 
-	return nvkm_gsp_rpc_wr(gsp, rpc, true);
+	return nvkm_gsp_rpc_wr(gsp, rpc, NVKM_GSP_RPC_REPLY_RECV);
 }
 
 enum registry_type {
@@ -1684,7 +1687,7 @@ r535_gsp_rpc_set_registry(struct nvkm_gs
 
 	build_registry(gsp, rpc);
 
-	return nvkm_gsp_rpc_wr(gsp, rpc, false);
+	return nvkm_gsp_rpc_wr(gsp, rpc, NVKM_GSP_RPC_REPLY_NOWAIT);
 
 fail:
 	clean_registry(gsp);
@@ -1893,7 +1896,7 @@ r535_gsp_rpc_set_system_info(struct nvkm
 	info->pciConfigMirrorSize = 0x001000;
 	r535_gsp_acpi_info(gsp, &info->acpiMethodData);
 
-	return nvkm_gsp_rpc_wr(gsp, info, false);
+	return nvkm_gsp_rpc_wr(gsp, info, NVKM_GSP_RPC_REPLY_NOWAIT);
 }
 
 static int
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/instmem/r535.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/instmem/r535.c
@@ -105,7 +105,7 @@ fbsr_memlist(struct nvkm_gsp_device *dev
 			rpc->pteDesc.pte_pde[i].pte = (phys >> 12) + i;
 	}
 
-	ret = nvkm_gsp_rpc_wr(gsp, rpc, true);
+	ret = nvkm_gsp_rpc_wr(gsp, rpc, NVKM_GSP_RPC_REPLY_RECV);
 	if (ret)
 		return ret;
 



