Return-Path: <stable+bounces-24300-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DA4A8693C7
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 14:48:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2403B2924D9
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 13:48:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87CA21420D4;
	Tue, 27 Feb 2024 13:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MVxGiq7H"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4646414532D;
	Tue, 27 Feb 2024 13:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709041605; cv=none; b=u9XK7cC4cYu623gt4EW8cZnyS21loP0ubFbX3XP9LBfBqWHWXn2EwHOKtIuMFWrmPrC6a9Choueulljgk0DdM5Sp81WHTr/b7mkB8OBhidogH/6e1EfUD3tawc8Jimap1p14hLO/+um+U4bflqU2BnixNiKGDoTGUIRDBYcDhrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709041605; c=relaxed/simple;
	bh=hYkb8Xt+ganV3Ls35/3g/oAb/6pcFYx4yVIiNsqFuBU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nsxmG+OmPidbFCqwLKcKO+rqEiivdoZqAfqq7tAzaK2KyAMJP08gH3n3y18XUTt8SKciOLkIqKGb9Masi3Qn0rFUPuTCJs+IfBxXWub+m3z+uz5EiL8tdKbIQ2L0CiP+s/76G6WnuudZQ2ScxLpgKdyO9ksmr+CgobyTT6M5FuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MVxGiq7H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6E3BC433C7;
	Tue, 27 Feb 2024 13:46:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709041605;
	bh=hYkb8Xt+ganV3Ls35/3g/oAb/6pcFYx4yVIiNsqFuBU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MVxGiq7Hwh2JjZF5kkIDPepjrPBa36cuKPmyM0wl7J9QtBl1w7TeXkIMGOFH0mbQM
	 X0gSCEk9e+cbJfcENlDzCM7PEvW0S20uT3lVn0i0pyIqtS+W7Mu1BV6Ba2JlZHfJNa
	 zx+ne9valIf7rs1uCfLFdbYCPm2sSwdU4lB8JIts=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jason Gunthorpe <jgg@mellanox.com>,
	Steve Wise <swise@opengridcomputing.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Dennis Dalessandro <dennis.dalessandro@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 38/52] RDMA/ulp: Use dev_name instead of ibdev->name
Date: Tue, 27 Feb 2024 14:26:25 +0100
Message-ID: <20240227131549.782576667@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240227131548.514622258@linuxfoundation.org>
References: <20240227131548.514622258@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jason Gunthorpe <jgg@mellanox.com>

[ Upstream commit 6c8541118bd53bc90b6c2473e289e5541de80376 ]

These return the same thing but dev_name is a more conventional use of the
kernel API.

Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Reviewed-by: Steve Wise <swise@opengridcomputing.com>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Reviewed-by: Dennis Dalessandro <dennis.dalessandro@intel.com>
Stable-dep-of: eb5c7465c324 ("RDMA/srpt: fix function pointer cast warnings")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/ulp/ipoib/ipoib_verbs.c    |  2 +-
 drivers/infiniband/ulp/iser/iser_verbs.c      |  9 ++++---
 drivers/infiniband/ulp/isert/ib_isert.c       |  2 +-
 .../infiniband/ulp/opa_vnic/opa_vnic_vema.c   |  3 ++-
 drivers/infiniband/ulp/srp/ib_srp.c           | 10 ++++---
 drivers/infiniband/ulp/srpt/ib_srpt.c         | 26 ++++++++++---------
 include/rdma/rdma_vt.h                        |  2 +-
 7 files changed, 30 insertions(+), 24 deletions(-)

diff --git a/drivers/infiniband/ulp/ipoib/ipoib_verbs.c b/drivers/infiniband/ulp/ipoib/ipoib_verbs.c
index 9f36ca786df84..1e88213459f2f 100644
--- a/drivers/infiniband/ulp/ipoib/ipoib_verbs.c
+++ b/drivers/infiniband/ulp/ipoib/ipoib_verbs.c
@@ -277,7 +277,7 @@ void ipoib_event(struct ib_event_handler *handler,
 		return;
 
 	ipoib_dbg(priv, "Event %d on device %s port %d\n", record->event,
-		  record->device->name, record->element.port_num);
+		  dev_name(&record->device->dev), record->element.port_num);
 
 	if (record->event == IB_EVENT_SM_CHANGE ||
 	    record->event == IB_EVENT_CLIENT_REREGISTER) {
diff --git a/drivers/infiniband/ulp/iser/iser_verbs.c b/drivers/infiniband/ulp/iser/iser_verbs.c
index bee8c0b1d6a51..4ff3d98fa6a4e 100644
--- a/drivers/infiniband/ulp/iser/iser_verbs.c
+++ b/drivers/infiniband/ulp/iser/iser_verbs.c
@@ -55,7 +55,7 @@ static void iser_event_handler(struct ib_event_handler *handler,
 {
 	iser_err("async event %s (%d) on device %s port %d\n",
 		 ib_event_msg(event->event), event->event,
-		 event->device->name, event->element.port_num);
+		dev_name(&event->device->dev), event->element.port_num);
 }
 
 /**
@@ -85,7 +85,7 @@ static int iser_create_device_ib_res(struct iser_device *device)
 	max_cqe = min(ISER_MAX_CQ_LEN, ib_dev->attrs.max_cqe);
 
 	iser_info("using %d CQs, device %s supports %d vectors max_cqe %d\n",
-		  device->comps_used, ib_dev->name,
+		  device->comps_used, dev_name(&ib_dev->dev),
 		  ib_dev->num_comp_vectors, max_cqe);
 
 	device->pd = ib_alloc_pd(ib_dev,
@@ -468,7 +468,8 @@ static int iser_create_ib_conn_res(struct ib_conn *ib_conn)
 			iser_conn->max_cmds =
 				ISER_GET_MAX_XMIT_CMDS(ib_dev->attrs.max_qp_wr);
 			iser_dbg("device %s supports max_send_wr %d\n",
-				 device->ib_device->name, ib_dev->attrs.max_qp_wr);
+				 dev_name(&device->ib_device->dev),
+				 ib_dev->attrs.max_qp_wr);
 		}
 	}
 
@@ -764,7 +765,7 @@ static void iser_addr_handler(struct rdma_cm_id *cma_id)
 		      IB_DEVICE_SIGNATURE_HANDOVER)) {
 			iser_warn("T10-PI requested but not supported on %s, "
 				  "continue without T10-PI\n",
-				  ib_conn->device->ib_device->name);
+				  dev_name(&ib_conn->device->ib_device->dev));
 			ib_conn->pi_support = false;
 		} else {
 			ib_conn->pi_support = true;
diff --git a/drivers/infiniband/ulp/isert/ib_isert.c b/drivers/infiniband/ulp/isert/ib_isert.c
index d7b7b77e4d658..c4eec0aef76e6 100644
--- a/drivers/infiniband/ulp/isert/ib_isert.c
+++ b/drivers/infiniband/ulp/isert/ib_isert.c
@@ -262,7 +262,7 @@ isert_alloc_comps(struct isert_device *device)
 
 	isert_info("Using %d CQs, %s supports %d vectors support "
 		   "pi_capable %d\n",
-		   device->comps_used, device->ib_device->name,
+		   device->comps_used, dev_name(&device->ib_device->dev),
 		   device->ib_device->num_comp_vectors,
 		   device->pi_capable);
 
diff --git a/drivers/infiniband/ulp/opa_vnic/opa_vnic_vema.c b/drivers/infiniband/ulp/opa_vnic/opa_vnic_vema.c
index 15711dcc6f585..d119d9afa845a 100644
--- a/drivers/infiniband/ulp/opa_vnic/opa_vnic_vema.c
+++ b/drivers/infiniband/ulp/opa_vnic/opa_vnic_vema.c
@@ -888,7 +888,8 @@ static void opa_vnic_event(struct ib_event_handler *handler,
 		return;
 
 	c_dbg("OPA_VNIC received event %d on device %s port %d\n",
-	      record->event, record->device->name, record->element.port_num);
+	      record->event, dev_name(&record->device->dev),
+	      record->element.port_num);
 
 	if (record->event == IB_EVENT_PORT_ERR)
 		idr_for_each(&port->vport_idr, vema_disable_vport, NULL);
diff --git a/drivers/infiniband/ulp/srp/ib_srp.c b/drivers/infiniband/ulp/srp/ib_srp.c
index 6dcdc42ed0819..f5402c5742009 100644
--- a/drivers/infiniband/ulp/srp/ib_srp.c
+++ b/drivers/infiniband/ulp/srp/ib_srp.c
@@ -3115,7 +3115,8 @@ static ssize_t show_local_ib_device(struct device *dev,
 {
 	struct srp_target_port *target = host_to_target(class_to_shost(dev));
 
-	return sprintf(buf, "%s\n", target->srp_host->srp_dev->dev->name);
+	return sprintf(buf, "%s\n",
+		       dev_name(&target->srp_host->srp_dev->dev->dev));
 }
 
 static ssize_t show_ch_count(struct device *dev, struct device_attribute *attr,
@@ -3990,7 +3991,7 @@ static ssize_t show_ibdev(struct device *dev, struct device_attribute *attr,
 {
 	struct srp_host *host = container_of(dev, struct srp_host, dev);
 
-	return sprintf(buf, "%s\n", host->srp_dev->dev->name);
+	return sprintf(buf, "%s\n", dev_name(&host->srp_dev->dev->dev));
 }
 
 static DEVICE_ATTR(ibdev, S_IRUGO, show_ibdev, NULL);
@@ -4022,7 +4023,8 @@ static struct srp_host *srp_add_port(struct srp_device *device, u8 port)
 
 	host->dev.class = &srp_class;
 	host->dev.parent = device->dev->dev.parent;
-	dev_set_name(&host->dev, "srp-%s-%d", device->dev->name, port);
+	dev_set_name(&host->dev, "srp-%s-%d", dev_name(&device->dev->dev),
+		     port);
 
 	if (device_register(&host->dev))
 		goto free_host;
@@ -4098,7 +4100,7 @@ static void srp_add_one(struct ib_device *device)
 	srp_dev->mr_max_size	= srp_dev->mr_page_size *
 				   srp_dev->max_pages_per_mr;
 	pr_debug("%s: mr_page_shift = %d, device->max_mr_size = %#llx, device->max_fast_reg_page_list_len = %u, max_pages_per_mr = %d, mr_max_size = %#x\n",
-		 device->name, mr_page_shift, attr->max_mr_size,
+		 dev_name(&device->dev), mr_page_shift, attr->max_mr_size,
 		 attr->max_fast_reg_page_list_len,
 		 srp_dev->max_pages_per_mr, srp_dev->mr_max_size);
 
diff --git a/drivers/infiniband/ulp/srpt/ib_srpt.c b/drivers/infiniband/ulp/srpt/ib_srpt.c
index f3d83a05aa4fa..fd3d8da6a9db8 100644
--- a/drivers/infiniband/ulp/srpt/ib_srpt.c
+++ b/drivers/infiniband/ulp/srpt/ib_srpt.c
@@ -152,7 +152,7 @@ static void srpt_event_handler(struct ib_event_handler *handler,
 		return;
 
 	pr_debug("ASYNC event= %d on device= %s\n", event->event,
-		 sdev->device->name);
+		 dev_name(&sdev->device->dev));
 
 	switch (event->event) {
 	case IB_EVENT_PORT_ERR:
@@ -1969,7 +1969,8 @@ static void __srpt_close_all_ch(struct srpt_port *sport)
 			if (srpt_disconnect_ch(ch) >= 0)
 				pr_info("Closing channel %s because target %s_%d has been disabled\n",
 					ch->sess_name,
-					sport->sdev->device->name, sport->port);
+					dev_name(&sport->sdev->device->dev),
+					sport->port);
 			srpt_close_ch(ch);
 		}
 	}
@@ -2163,7 +2164,7 @@ static int srpt_cm_req_recv(struct srpt_device *const sdev,
 	if (!sport->enabled) {
 		rej->reason = cpu_to_be32(SRP_LOGIN_REJ_INSUFFICIENT_RESOURCES);
 		pr_info("rejected SRP_LOGIN_REQ because target port %s_%d has not yet been enabled\n",
-			sport->sdev->device->name, port_num);
+			dev_name(&sport->sdev->device->dev), port_num);
 		goto reject;
 	}
 
@@ -2303,7 +2304,7 @@ static int srpt_cm_req_recv(struct srpt_device *const sdev,
 		rej->reason = cpu_to_be32(
 				SRP_LOGIN_REJ_INSUFFICIENT_RESOURCES);
 		pr_info("rejected SRP_LOGIN_REQ because target %s_%d is not enabled\n",
-			sdev->device->name, port_num);
+			dev_name(&sdev->device->dev), port_num);
 		mutex_unlock(&sport->mutex);
 		ret = -EINVAL;
 		goto reject;
@@ -2890,7 +2891,7 @@ static int srpt_release_sport(struct srpt_port *sport)
 	while (wait_event_timeout(sport->ch_releaseQ,
 				  srpt_ch_list_empty(sport), 5 * HZ) <= 0) {
 		pr_info("%s_%d: waiting for session unregistration ...\n",
-			sport->sdev->device->name, sport->port);
+			dev_name(&sport->sdev->device->dev), sport->port);
 		rcu_read_lock();
 		list_for_each_entry(nexus, &sport->nexus_list, entry) {
 			list_for_each_entry(ch, &nexus->ch_list, list) {
@@ -2980,7 +2981,7 @@ static int srpt_alloc_srq(struct srpt_device *sdev)
 	}
 
 	pr_debug("create SRQ #wr= %d max_allow=%d dev= %s\n", sdev->srq_size,
-		 sdev->device->attrs.max_srq_wr, device->name);
+		 sdev->device->attrs.max_srq_wr, dev_name(&device->dev));
 
 	sdev->ioctx_ring = (struct srpt_recv_ioctx **)
 		srpt_alloc_ioctx_ring(sdev, sdev->srq_size,
@@ -3013,8 +3014,8 @@ static int srpt_use_srq(struct srpt_device *sdev, bool use_srq)
 	} else if (use_srq && !sdev->srq) {
 		ret = srpt_alloc_srq(sdev);
 	}
-	pr_debug("%s(%s): use_srq = %d; ret = %d\n", __func__, device->name,
-		 sdev->use_srq, ret);
+	pr_debug("%s(%s): use_srq = %d; ret = %d\n", __func__,
+		 dev_name(&device->dev), sdev->use_srq, ret);
 	return ret;
 }
 
@@ -3100,7 +3101,7 @@ static void srpt_add_one(struct ib_device *device)
 
 		if (srpt_refresh_port(sport)) {
 			pr_err("MAD registration failed for %s-%d.\n",
-			       sdev->device->name, i);
+			       dev_name(&sdev->device->dev), i);
 			goto err_event;
 		}
 	}
@@ -3111,7 +3112,7 @@ static void srpt_add_one(struct ib_device *device)
 
 out:
 	ib_set_client_data(device, &srpt_client, sdev);
-	pr_debug("added %s.\n", device->name);
+	pr_debug("added %s.\n", dev_name(&device->dev));
 	return;
 
 err_event:
@@ -3126,7 +3127,7 @@ static void srpt_add_one(struct ib_device *device)
 	kfree(sdev);
 err:
 	sdev = NULL;
-	pr_info("%s(%s) failed.\n", __func__, device->name);
+	pr_info("%s(%s) failed.\n", __func__, dev_name(&device->dev));
 	goto out;
 }
 
@@ -3141,7 +3142,8 @@ static void srpt_remove_one(struct ib_device *device, void *client_data)
 	int i;
 
 	if (!sdev) {
-		pr_info("%s(%s): nothing to do.\n", __func__, device->name);
+		pr_info("%s(%s): nothing to do.\n", __func__,
+			dev_name(&device->dev));
 		return;
 	}
 
diff --git a/include/rdma/rdma_vt.h b/include/rdma/rdma_vt.h
index e79229a0cf014..8a36122afb754 100644
--- a/include/rdma/rdma_vt.h
+++ b/include/rdma/rdma_vt.h
@@ -434,7 +434,7 @@ static inline void rvt_set_ibdev_name(struct rvt_dev_info *rdi,
  */
 static inline const char *rvt_get_ibdev_name(const struct rvt_dev_info *rdi)
 {
-	return rdi->ibdev.name;
+	return dev_name(&rdi->ibdev.dev);
 }
 
 static inline struct rvt_pd *ibpd_to_rvtpd(struct ib_pd *ibpd)
-- 
2.43.0




