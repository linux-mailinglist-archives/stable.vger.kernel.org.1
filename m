Return-Path: <stable+bounces-34616-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FD37894014
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 18:25:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF1E2282E72
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 16:25:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA6A1481AB;
	Mon,  1 Apr 2024 16:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dymOVy/W"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 955B6446AC;
	Mon,  1 Apr 2024 16:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711988720; cv=none; b=r7lCVndQBXpV8F/eaoDm9psJaDRexOiSwRjBJfDv6UaQTd0AaYWVoyq8huCs18CUYkGEoqMRB/05U8M4swfHucB17xKHoQ+LPj9dw5l1Oiv6n1fjkbeGRFZPGoNXrGJyJ0NYK97o0qUhRUAr/5aI/l/jDxYOs9HfAR2D/nV1MPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711988720; c=relaxed/simple;
	bh=onjLmPUQcnDtjxYGkiHANtoijQ8rTD7QqloIY/bIwpQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tx4AydWvnfFlvMSuav0XrvDMvcNtQUn49SAmpnZEhma/fXwz1CamzkpN9slc5jXQkIsF6lEsx3PUpzM6ePQqWqTVDXCRt6vxQMSH8497h6A2+zyA26FK+y1kdUwYfKHagXnB+IJJF72FRynrwMPg3u5lMu9ZVeBUtsmdMVv2Xhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dymOVy/W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4437C433C7;
	Mon,  1 Apr 2024 16:25:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711988720;
	bh=onjLmPUQcnDtjxYGkiHANtoijQ8rTD7QqloIY/bIwpQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dymOVy/WrZWkyhFoWTnikHonaRc2jMSbyrMqBfl5Tg8aGxF2kgEAf2Sg+cVubTTXM
	 2QpqevgGo5mduT703ujPpdj9vO+3Z8k1FC45FrHfcaWusOrH/BR3HKmw0bDUnYawfT
	 /+IzopTxNt1y/OtF3H4IQK3QxIVuZ2tBGoqjcpIs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	stable <stable@kernel.org>,
	Ekansh Gupta <quic_ekangupt@quicinc.com>,
	Elliot Berman <quic_eberman@quicinc.com>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 6.7 269/432] misc: fastrpc: Pass proper arguments to scm call
Date: Mon,  1 Apr 2024 17:44:16 +0200
Message-ID: <20240401152601.199160752@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240401152553.125349965@linuxfoundation.org>
References: <20240401152553.125349965@linuxfoundation.org>
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

6.7-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ekansh Gupta <quic_ekangupt@quicinc.com>

commit a283d7f179ff83976af27bcc71f7474cb4d7c348 upstream.

For CMA memory allocation, ownership is assigned to DSP to make it
accessible by the PD running on the DSP. With current implementation
HLOS VM is stored in the channel structure during rpmsg_probe and
this VM is passed to qcom_scm call as the source VM.

The qcom_scm call will overwrite the passed source VM with the next
VM which would cause a problem in case the scm call is again needed.
Adding a local copy of source VM whereever scm call is made to avoid
this problem.

Fixes: 0871561055e6 ("misc: fastrpc: Add support for audiopd")
Cc: stable <stable@kernel.org>
Signed-off-by: Ekansh Gupta <quic_ekangupt@quicinc.com>
Reviewed-by: Elliot Berman <quic_eberman@quicinc.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Link: https://lore.kernel.org/r/20240224114247.85953-2-srinivas.kandagatla@linaro.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/misc/fastrpc.c |   10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -263,7 +263,6 @@ struct fastrpc_channel_ctx {
 	int domain_id;
 	int sesscount;
 	int vmcount;
-	u64 perms;
 	struct qcom_scm_vmperm vmperms[FASTRPC_MAX_VMIDS];
 	struct rpmsg_device *rpdev;
 	struct fastrpc_session_ctx session[FASTRPC_MAX_SESSIONS];
@@ -1279,9 +1278,11 @@ static int fastrpc_init_create_static_pr
 
 		/* Map if we have any heap VMIDs associated with this ADSP Static Process. */
 		if (fl->cctx->vmcount) {
+			u64 src_perms = BIT(QCOM_SCM_VMID_HLOS);
+
 			err = qcom_scm_assign_mem(fl->cctx->remote_heap->phys,
 							(u64)fl->cctx->remote_heap->size,
-							&fl->cctx->perms,
+							&src_perms,
 							fl->cctx->vmperms, fl->cctx->vmcount);
 			if (err) {
 				dev_err(fl->sctx->dev, "Failed to assign memory with phys 0x%llx size 0x%llx err %d",
@@ -1915,8 +1916,10 @@ static int fastrpc_req_mmap(struct fastr
 
 	/* Add memory to static PD pool, protection thru hypervisor */
 	if (req.flags == ADSP_MMAP_REMOTE_HEAP_ADDR && fl->cctx->vmcount) {
+		u64 src_perms = BIT(QCOM_SCM_VMID_HLOS);
+
 		err = qcom_scm_assign_mem(buf->phys, (u64)buf->size,
-			&fl->cctx->perms, fl->cctx->vmperms, fl->cctx->vmcount);
+			&src_perms, fl->cctx->vmperms, fl->cctx->vmcount);
 		if (err) {
 			dev_err(fl->sctx->dev, "Failed to assign memory phys 0x%llx size 0x%llx err %d",
 					buf->phys, buf->size, err);
@@ -2290,7 +2293,6 @@ static int fastrpc_rpmsg_probe(struct rp
 
 	if (vmcount) {
 		data->vmcount = vmcount;
-		data->perms = BIT(QCOM_SCM_VMID_HLOS);
 		for (i = 0; i < data->vmcount; i++) {
 			data->vmperms[i].vmid = vmids[i];
 			data->vmperms[i].perm = QCOM_SCM_PERM_RWX;



