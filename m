Return-Path: <stable+bounces-153061-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADA29ADD25B
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 17:41:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 73EE17A4F3D
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 15:37:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D97E32ECD0A;
	Tue, 17 Jun 2025 15:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="S+gt4Bgf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 957EE2E9753;
	Tue, 17 Jun 2025 15:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750174740; cv=none; b=jN6KPZFErLtJWOyM8Y8XANd8tIK+2R5/RQpKBFf2jBczg+RacSZkv3qwXN+HBp/vnxDb64hjqUdcAVqtVyyFJ0z9x5GWO65it9kUIY0N3QRbMHlzspTuscEj/JEzQ9i+g8gUJwaB/hWxeULPGQQWaSlxqWudZgqU6IHz0NmlpfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750174740; c=relaxed/simple;
	bh=78xnMrqXjQ6FeNyavfswU5O6AI0mMnMQCc870HTo5Vc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ki/aVEiAhRKMRbRsWYQl+Gb4mTnfC8GGJGAEMu37h1vO/v7NDFcNjbhNTVTzQu6w5SD5r5s8q7HWPVXbk1niCpv1uelG1XwoQVdQoU9MjslveoXO1EQ6JlkFS169yuOD7/LnWwE2R91juBqNOuNbat8FNBMaMNzQkpMTeK+DDu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=S+gt4Bgf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1BA2C4CEE3;
	Tue, 17 Jun 2025 15:38:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750174740;
	bh=78xnMrqXjQ6FeNyavfswU5O6AI0mMnMQCc870HTo5Vc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=S+gt4BgfQ/neu7I3ofhIq3/nNHM++3JfEO1AvaQ9Y7nwMNgXlvCMWKzwrBlPB4Epl
	 0lIf0gAmtfHnKICVpPe9WCQ94fZLY+7T7uW4otgbpdID34gZFDcSZ7lUqgnNWu2Osz
	 iJ7Ok+8NMeEyEsOQauQYt8HFfNTF0Vvx7nm4I+6E=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jacob Moroni <jmoroni@google.com>,
	Eric Dumazet <edumazet@google.com>,
	Zhu Yanjun <yanjun.zhu@linux.dev>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 081/356] IB/cm: use rwlock for MAD agent lock
Date: Tue, 17 Jun 2025 17:23:16 +0200
Message-ID: <20250617152341.480474819@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250617152338.212798615@linuxfoundation.org>
References: <20250617152338.212798615@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jacob Moroni <jmoroni@google.com>

[ Upstream commit 4dab26bed543584577b64b36aadb8b5b165bf44f ]

In workloads where there are many processes establishing connections using
RDMA CM in parallel (large scale MPI), there can be heavy contention for
mad_agent_lock in cm_alloc_msg.

This contention can occur while inside of a spin_lock_irq region, leading
to interrupts being disabled for extended durations on many
cores. Furthermore, it leads to the serialization of rdma_create_ah calls,
which has negative performance impacts for NICs which are capable of
processing multiple address handle creations in parallel.

The end result is the machine becoming unresponsive, hung task warnings,
netdev TX timeouts, etc.

Since the lock appears to be only for protection from cm_remove_one, it
can be changed to a rwlock to resolve these issues.

Reproducer:

Server:
  for i in $(seq 1 512); do
    ucmatose -c 32 -p $((i + 5000)) &
  done

Client:
  for i in $(seq 1 512); do
    ucmatose -c 32 -p $((i + 5000)) -s 10.2.0.52 &
  done

Fixes: 76039ac9095f ("IB/cm: Protect cm_dev, cm_ports and mad_agent with kref and lock")
Link: https://patch.msgid.link/r/20250220175612.2763122-1-jmoroni@google.com
Signed-off-by: Jacob Moroni <jmoroni@google.com>
Acked-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Zhu Yanjun <yanjun.zhu@linux.dev>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/core/cm.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/infiniband/core/cm.c b/drivers/infiniband/core/cm.c
index 07fb8d3c037f0..d45e3909dafe1 100644
--- a/drivers/infiniband/core/cm.c
+++ b/drivers/infiniband/core/cm.c
@@ -166,7 +166,7 @@ struct cm_port {
 struct cm_device {
 	struct kref kref;
 	struct list_head list;
-	spinlock_t mad_agent_lock;
+	rwlock_t mad_agent_lock;
 	struct ib_device *ib_device;
 	u8 ack_delay;
 	int going_down;
@@ -284,7 +284,7 @@ static struct ib_mad_send_buf *cm_alloc_msg(struct cm_id_private *cm_id_priv)
 	if (!cm_id_priv->av.port)
 		return ERR_PTR(-EINVAL);
 
-	spin_lock(&cm_id_priv->av.port->cm_dev->mad_agent_lock);
+	read_lock(&cm_id_priv->av.port->cm_dev->mad_agent_lock);
 	mad_agent = cm_id_priv->av.port->mad_agent;
 	if (!mad_agent) {
 		m = ERR_PTR(-EINVAL);
@@ -315,7 +315,7 @@ static struct ib_mad_send_buf *cm_alloc_msg(struct cm_id_private *cm_id_priv)
 	m->context[0] = cm_id_priv;
 
 out:
-	spin_unlock(&cm_id_priv->av.port->cm_dev->mad_agent_lock);
+	read_unlock(&cm_id_priv->av.port->cm_dev->mad_agent_lock);
 	return m;
 }
 
@@ -1294,10 +1294,10 @@ static __be64 cm_form_tid(struct cm_id_private *cm_id_priv)
 	if (!cm_id_priv->av.port)
 		return cpu_to_be64(low_tid);
 
-	spin_lock(&cm_id_priv->av.port->cm_dev->mad_agent_lock);
+	read_lock(&cm_id_priv->av.port->cm_dev->mad_agent_lock);
 	if (cm_id_priv->av.port->mad_agent)
 		hi_tid = ((u64)cm_id_priv->av.port->mad_agent->hi_tid) << 32;
-	spin_unlock(&cm_id_priv->av.port->cm_dev->mad_agent_lock);
+	read_unlock(&cm_id_priv->av.port->cm_dev->mad_agent_lock);
 	return cpu_to_be64(hi_tid | low_tid);
 }
 
@@ -4374,7 +4374,7 @@ static int cm_add_one(struct ib_device *ib_device)
 		return -ENOMEM;
 
 	kref_init(&cm_dev->kref);
-	spin_lock_init(&cm_dev->mad_agent_lock);
+	rwlock_init(&cm_dev->mad_agent_lock);
 	cm_dev->ib_device = ib_device;
 	cm_dev->ack_delay = ib_device->attrs.local_ca_ack_delay;
 	cm_dev->going_down = 0;
@@ -4490,9 +4490,9 @@ static void cm_remove_one(struct ib_device *ib_device, void *client_data)
 		 * The above ensures no call paths from the work are running,
 		 * the remaining paths all take the mad_agent_lock.
 		 */
-		spin_lock(&cm_dev->mad_agent_lock);
+		write_lock(&cm_dev->mad_agent_lock);
 		port->mad_agent = NULL;
-		spin_unlock(&cm_dev->mad_agent_lock);
+		write_unlock(&cm_dev->mad_agent_lock);
 		ib_unregister_mad_agent(mad_agent);
 		ib_port_unregister_client_groups(ib_device, i,
 						 cm_counter_groups);
-- 
2.39.5




