Return-Path: <stable+bounces-58641-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA37392B7FD
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 13:29:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64F09285BAF
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 11:29:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF29B158A07;
	Tue,  9 Jul 2024 11:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="g+NyyJmw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B61815886B;
	Tue,  9 Jul 2024 11:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720524556; cv=none; b=PXoXbyNRqDkKhTsynp0lvS5ibtsdhYinrsmVqACjsG8sszcMQN29Q8PwoB25qlXSM+ErMC7k0WXrNIg5a+ElsTCXFy1DmL2TRL+lk7aNMhBYkNp87cTyQAt7H+U0UfK1te9/2FbBwN3clj2j5NP119vcvU8f7hfq+XZivIh5dNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720524556; c=relaxed/simple;
	bh=fM2tv+Xor7B+KAGosbiugOOjnK3hB56XJrK2JqGDKJI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nuS7W8kHuQDbM2hIOlQGBgywSprZz7edEJz7yHEWEyRk1zapiXgHyIFkWuw0t7wFYdyA3+HQlEx08onrVAcpvhXu46E7jp4CC67ns+1FxniZOmapAbvnSlYjdiaIVVS2/ehW7s/rTZYfFdAYmmufMJOglIsDtAbiO7KNnVwCsIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=g+NyyJmw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20974C32786;
	Tue,  9 Jul 2024 11:29:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1720524556;
	bh=fM2tv+Xor7B+KAGosbiugOOjnK3hB56XJrK2JqGDKJI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=g+NyyJmwThJXtntyimGBD+ZR85OtVrEgFFjfNHvWcMDvViqnCTvJxcBJ5GvUfrVue
	 ivcv/O5hlfMKb4RN0zEJUybgykAUkbiPILZGcMnHxhum2SCZXCmDbdQoOXdeq5/ry/
	 0mzphpb6+iuREEisvK701B+DYOhaYGzXiWmREsAg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Michael Guralnik <michaelgur@nvidia.com>,
	Mark Zhang <markzhang@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 007/102] IB/core: Implement a limit on UMAD receive List
Date: Tue,  9 Jul 2024 13:09:30 +0200
Message-ID: <20240709110651.644594031@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240709110651.353707001@linuxfoundation.org>
References: <20240709110651.353707001@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michael Guralnik <michaelgur@nvidia.com>

[ Upstream commit ca0b44e20a6f3032224599f02e7c8fb49525c894 ]

The existing behavior of ib_umad, which maintains received MAD
packets in an unbounded list, poses a risk of uncontrolled growth.
As user-space applications extract packets from this list, the rate
of extraction may not match the rate of incoming packets, leading
to potential list overflow.

To address this, we introduce a limit to the size of the list. After
considering typical scenarios, such as OpenSM processing, which can
handle approximately 100k packets per second, and the 1-second retry
timeout for most packets, we set the list size limit to 200k. Packets
received beyond this limit are dropped, assuming they are likely timed
out by the time they are handled by user-space.

Notably, packets queued on the receive list due to reasons like
timed-out sends are preserved even when the list is full.

Signed-off-by: Michael Guralnik <michaelgur@nvidia.com>
Reviewed-by: Mark Zhang <markzhang@nvidia.com>
Link: https://lore.kernel.org/r/7197cb58a7d9e78399008f25036205ceab07fbd5.1713268818.git.leon@kernel.org
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/core/user_mad.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/drivers/infiniband/core/user_mad.c b/drivers/infiniband/core/user_mad.c
index 5c284dfbe6923..66a0c5a73b832 100644
--- a/drivers/infiniband/core/user_mad.c
+++ b/drivers/infiniband/core/user_mad.c
@@ -63,6 +63,8 @@ MODULE_AUTHOR("Roland Dreier");
 MODULE_DESCRIPTION("InfiniBand userspace MAD packet access");
 MODULE_LICENSE("Dual BSD/GPL");
 
+#define MAX_UMAD_RECV_LIST_SIZE 200000
+
 enum {
 	IB_UMAD_MAX_PORTS  = RDMA_MAX_PORTS,
 	IB_UMAD_MAX_AGENTS = 32,
@@ -113,6 +115,7 @@ struct ib_umad_file {
 	struct mutex		mutex;
 	struct ib_umad_port    *port;
 	struct list_head	recv_list;
+	atomic_t		recv_list_size;
 	struct list_head	send_list;
 	struct list_head	port_list;
 	spinlock_t		send_lock;
@@ -180,24 +183,28 @@ static struct ib_mad_agent *__get_agent(struct ib_umad_file *file, int id)
 	return file->agents_dead ? NULL : file->agent[id];
 }
 
-static int queue_packet(struct ib_umad_file *file,
-			struct ib_mad_agent *agent,
-			struct ib_umad_packet *packet)
+static int queue_packet(struct ib_umad_file *file, struct ib_mad_agent *agent,
+			struct ib_umad_packet *packet, bool is_recv_mad)
 {
 	int ret = 1;
 
 	mutex_lock(&file->mutex);
 
+	if (is_recv_mad &&
+	    atomic_read(&file->recv_list_size) > MAX_UMAD_RECV_LIST_SIZE)
+		goto unlock;
+
 	for (packet->mad.hdr.id = 0;
 	     packet->mad.hdr.id < IB_UMAD_MAX_AGENTS;
 	     packet->mad.hdr.id++)
 		if (agent == __get_agent(file, packet->mad.hdr.id)) {
 			list_add_tail(&packet->list, &file->recv_list);
+			atomic_inc(&file->recv_list_size);
 			wake_up_interruptible(&file->recv_wait);
 			ret = 0;
 			break;
 		}
-
+unlock:
 	mutex_unlock(&file->mutex);
 
 	return ret;
@@ -224,7 +231,7 @@ static void send_handler(struct ib_mad_agent *agent,
 	if (send_wc->status == IB_WC_RESP_TIMEOUT_ERR) {
 		packet->length = IB_MGMT_MAD_HDR;
 		packet->mad.hdr.status = ETIMEDOUT;
-		if (!queue_packet(file, agent, packet))
+		if (!queue_packet(file, agent, packet, false))
 			return;
 	}
 	kfree(packet);
@@ -284,7 +291,7 @@ static void recv_handler(struct ib_mad_agent *agent,
 		rdma_destroy_ah_attr(&ah_attr);
 	}
 
-	if (queue_packet(file, agent, packet))
+	if (queue_packet(file, agent, packet, true))
 		goto err2;
 	return;
 
@@ -409,6 +416,7 @@ static ssize_t ib_umad_read(struct file *filp, char __user *buf,
 
 	packet = list_entry(file->recv_list.next, struct ib_umad_packet, list);
 	list_del(&packet->list);
+	atomic_dec(&file->recv_list_size);
 
 	mutex_unlock(&file->mutex);
 
@@ -421,6 +429,7 @@ static ssize_t ib_umad_read(struct file *filp, char __user *buf,
 		/* Requeue packet */
 		mutex_lock(&file->mutex);
 		list_add(&packet->list, &file->recv_list);
+		atomic_inc(&file->recv_list_size);
 		mutex_unlock(&file->mutex);
 	} else {
 		if (packet->recv_wc)
-- 
2.43.0




