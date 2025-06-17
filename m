Return-Path: <stable+bounces-153521-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C06BADD4F9
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 18:15:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BA2417CAA3
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 16:07:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2AC72EA15A;
	Tue, 17 Jun 2025 16:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0l2Fjkxg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CDFE2DFF09;
	Tue, 17 Jun 2025 16:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750176232; cv=none; b=jSCyZA4RgLtI4G8joopZf+ZUtKJmLzVsvPvCKx3rzTGlb3Hf2CoLDZAu3OH/gVA1g4UXtVD4b9QtyNdjvee4AqWh8Avh6bAnjaYEcumCMs0toHI91qN4euPW0mEFofv60m1x0/Dufm542H8dYkCR8LAt9kK8ZRXg6FB7yJ49NY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750176232; c=relaxed/simple;
	bh=5lf51HtJMFTm8ARXclngX9Kf3V9h8YBJp1PL1P8CFGc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f8FKYE7CayBCEUbu12HS6J43p2n4pSI9ur1azmBCVayoGp0atcDS8RKmeRhwxnEsn54UnTZjXW16iteyTr8dOBpYyLvgHPizho3E4MRAsVgoeYNDWidV9AO29brypDzLfxNBcICIUUxk0lYW0oph461DuokvZPzC2CvPwyJVaCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0l2Fjkxg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06BECC4CEE3;
	Tue, 17 Jun 2025 16:03:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750176232;
	bh=5lf51HtJMFTm8ARXclngX9Kf3V9h8YBJp1PL1P8CFGc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=0l2FjkxgURGr1T4pDT/A02YUaAzUS6RmP8mxdUZKphcSoSq4Z4eUlB31MVNTCEVDL
	 iRErKn6YecQfLde9vh21uYTX5UAZ/epu8bDlCSRMVt0iS5TQ9glFBzwK7fDpKU9fZQ
	 hNBkQGwNJi8EYDXFtZHfnjMBIpkU04ck1xOD+VEk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jacob Moroni <jmoroni@google.com>,
	Eric Dumazet <edumazet@google.com>,
	Zhu Yanjun <yanjun.zhu@linux.dev>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.15 167/780] IB/cm: use rwlock for MAD agent lock
Date: Tue, 17 Jun 2025 17:17:55 +0200
Message-ID: <20250617152458.284718155@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250617152451.485330293@linuxfoundation.org>
References: <20250617152451.485330293@linuxfoundation.org>
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
index 142170473e753..effa53dd68002 100644
--- a/drivers/infiniband/core/cm.c
+++ b/drivers/infiniband/core/cm.c
@@ -167,7 +167,7 @@ struct cm_port {
 struct cm_device {
 	struct kref kref;
 	struct list_head list;
-	spinlock_t mad_agent_lock;
+	rwlock_t mad_agent_lock;
 	struct ib_device *ib_device;
 	u8 ack_delay;
 	int going_down;
@@ -285,7 +285,7 @@ static struct ib_mad_send_buf *cm_alloc_msg(struct cm_id_private *cm_id_priv)
 	if (!cm_id_priv->av.port)
 		return ERR_PTR(-EINVAL);
 
-	spin_lock(&cm_id_priv->av.port->cm_dev->mad_agent_lock);
+	read_lock(&cm_id_priv->av.port->cm_dev->mad_agent_lock);
 	mad_agent = cm_id_priv->av.port->mad_agent;
 	if (!mad_agent) {
 		m = ERR_PTR(-EINVAL);
@@ -311,7 +311,7 @@ static struct ib_mad_send_buf *cm_alloc_msg(struct cm_id_private *cm_id_priv)
 	m->ah = ah;
 
 out:
-	spin_unlock(&cm_id_priv->av.port->cm_dev->mad_agent_lock);
+	read_unlock(&cm_id_priv->av.port->cm_dev->mad_agent_lock);
 	return m;
 }
 
@@ -1297,10 +1297,10 @@ static __be64 cm_form_tid(struct cm_id_private *cm_id_priv)
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
 
@@ -4378,7 +4378,7 @@ static int cm_add_one(struct ib_device *ib_device)
 		return -ENOMEM;
 
 	kref_init(&cm_dev->kref);
-	spin_lock_init(&cm_dev->mad_agent_lock);
+	rwlock_init(&cm_dev->mad_agent_lock);
 	cm_dev->ib_device = ib_device;
 	cm_dev->ack_delay = ib_device->attrs.local_ca_ack_delay;
 	cm_dev->going_down = 0;
@@ -4494,9 +4494,9 @@ static void cm_remove_one(struct ib_device *ib_device, void *client_data)
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




