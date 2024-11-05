Return-Path: <stable+bounces-89895-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FF259BD2DE
	for <lists+stable@lfdr.de>; Tue,  5 Nov 2024 17:52:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B37D31C22315
	for <lists+stable@lfdr.de>; Tue,  5 Nov 2024 16:52:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD1CB1D9A7A;
	Tue,  5 Nov 2024 16:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ox8/TZYd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A84C7E591
	for <stable@vger.kernel.org>; Tue,  5 Nov 2024 16:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730825517; cv=none; b=oJ2DaXi5fMsUWBRoln68Aum5TFAOO3SCR552W8xrpTJV9EctwI+fAuOYQkLc6nxner5/O+ximyzNYjMZdKek3EZDCQAvX3VRL+Tf/eL3+tzVd97igDHktqxt1v+rygHj9tcZk6kYiqzXfGKne0q03OWP0JQScWvJCVaZ2MJHaB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730825517; c=relaxed/simple;
	bh=97A76eFGopKHz2c0U1BsXLapOMDovXsVr0BVk0iqkks=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=URs90txXBt7PdfrTwz3mxHF0nmtXvc57xOZDsxFVD/125bYfddULFYkLrzJJIfhxSe2g/kEqM9yHNQ2auJGEhCRZ5vHNmfGfTJdrqSsIUevCBWdHYggPvS7wVnralGmyWFv6yXh81dhi+ixl3maSzDhGxXKUMyv+6QJpwwEYgzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ox8/TZYd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB5E2C4CECF;
	Tue,  5 Nov 2024 16:51:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1730825517;
	bh=97A76eFGopKHz2c0U1BsXLapOMDovXsVr0BVk0iqkks=;
	h=Subject:To:Cc:From:Date:From;
	b=ox8/TZYdsqnS4IGK61akqv9MPZkoTvoiB/cdgO8Vtokhf0eZBBdZFjJcV8yXuAtBi
	 YqoqSQy6HZgt5zIk4ch2fslTRhrNnMqINCqWgbaJrWN5/cGLSvYB0fP+C9nL1/cXbB
	 cO2JcWTjpLJ36USnCIJirwTdEuEUIAfgeBjaj+NM=
Subject: FAILED: patch "[PATCH] cxl/port: Fix use-after-free, permit out-of-order decoder" failed to apply to 6.1-stable tree
To: dan.j.williams@intel.com,Jonathan.Cameron@huawei.com,alison.schofield@intel.com,dave.jiang@intel.com,dave@stgolabs.net,gregkh@linuxfoundation.org,ira.weiny@intel.com,quic_zijuhu@quicinc.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 05 Nov 2024 17:51:39 +0100
Message-ID: <2024110539-swooned-cold-53f5@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 101c268bd2f37e965a5468353e62d154db38838e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024110539-swooned-cold-53f5@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 101c268bd2f37e965a5468353e62d154db38838e Mon Sep 17 00:00:00 2001
From: Dan Williams <dan.j.williams@intel.com>
Date: Tue, 22 Oct 2024 18:43:49 -0700
Subject: [PATCH] cxl/port: Fix use-after-free, permit out-of-order decoder
 shutdown

In support of investigating an initialization failure report [1],
cxl_test was updated to register mock memory-devices after the mock
root-port/bus device had been registered. That led to cxl_test crashing
with a use-after-free bug with the following signature:

    cxl_port_attach_region: cxl region3: cxl_host_bridge.0:port3 decoder3.0 add: mem0:decoder7.0 @ 0 next: cxl_switch_uport.0 nr_eps: 1 nr_targets: 1
    cxl_port_attach_region: cxl region3: cxl_host_bridge.0:port3 decoder3.0 add: mem4:decoder14.0 @ 1 next: cxl_switch_uport.0 nr_eps: 2 nr_targets: 1
    cxl_port_setup_targets: cxl region3: cxl_switch_uport.0:port6 target[0] = cxl_switch_dport.0 for mem0:decoder7.0 @ 0
1)  cxl_port_setup_targets: cxl region3: cxl_switch_uport.0:port6 target[1] = cxl_switch_dport.4 for mem4:decoder14.0 @ 1
    [..]
    cxld_unregister: cxl decoder14.0:
    cxl_region_decode_reset: cxl_region region3:
    mock_decoder_reset: cxl_port port3: decoder3.0 reset
2)  mock_decoder_reset: cxl_port port3: decoder3.0: out of order reset, expected decoder3.1
    cxl_endpoint_decoder_release: cxl decoder14.0:
    [..]
    cxld_unregister: cxl decoder7.0:
3)  cxl_region_decode_reset: cxl_region region3:
    Oops: general protection fault, probably for non-canonical address 0x6b6b6b6b6b6b6bc3: 0000 [#1] PREEMPT SMP PTI
    [..]
    RIP: 0010:to_cxl_port+0x8/0x60 [cxl_core]
    [..]
    Call Trace:
     <TASK>
     cxl_region_decode_reset+0x69/0x190 [cxl_core]
     cxl_region_detach+0xe8/0x210 [cxl_core]
     cxl_decoder_kill_region+0x27/0x40 [cxl_core]
     cxld_unregister+0x5d/0x60 [cxl_core]

At 1) a region has been established with 2 endpoint decoders (7.0 and
14.0). Those endpoints share a common switch-decoder in the topology
(3.0). At teardown, 2), decoder14.0 is the first to be removed and hits
the "out of order reset case" in the switch decoder. The effect though
is that region3 cleanup is aborted leaving it in-tact and
referencing decoder14.0. At 3) the second attempt to teardown region3
trips over the stale decoder14.0 object which has long since been
deleted.

The fix here is to recognize that the CXL specification places no
mandate on in-order shutdown of switch-decoders, the driver enforces
in-order allocation, and hardware enforces in-order commit. So, rather
than fail and leave objects dangling, always remove them.

In support of making cxl_region_decode_reset() always succeed,
cxl_region_invalidate_memregion() failures are turned into warnings.
Crashing the kernel is ok there since system integrity is at risk if
caches cannot be managed around physical address mutation events like
CXL region destruction.

A new device_for_each_child_reverse_from() is added to cleanup
port->commit_end after all dependent decoders have been disabled. In
other words if decoders are allocated 0->1->2 and disabled 1->2->0 then
port->commit_end only decrements from 2 after 2 has been disabled, and
it decrements all the way to zero since 1 was disabled previously.

Link: http://lore.kernel.org/20241004212504.1246-1-gourry@gourry.net [1]
Cc: stable@vger.kernel.org
Fixes: 176baefb2eb5 ("cxl/hdm: Commit decoder state to hardware")
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Cc: Dave Jiang <dave.jiang@intel.com>
Cc: Alison Schofield <alison.schofield@intel.com>
Cc: Ira Weiny <ira.weiny@intel.com>
Cc: Zijun Hu <quic_zijuhu@quicinc.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Ira Weiny <ira.weiny@intel.com>
Link: https://patch.msgid.link/172964782781.81806.17902885593105284330.stgit@dwillia2-xfh.jf.intel.com
Signed-off-by: Ira Weiny <ira.weiny@intel.com>

diff --git a/drivers/base/core.c b/drivers/base/core.c
index a4c853411a6b..e42f1ad73078 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -4037,6 +4037,41 @@ int device_for_each_child_reverse(struct device *parent, void *data,
 }
 EXPORT_SYMBOL_GPL(device_for_each_child_reverse);
 
+/**
+ * device_for_each_child_reverse_from - device child iterator in reversed order.
+ * @parent: parent struct device.
+ * @from: optional starting point in child list
+ * @fn: function to be called for each device.
+ * @data: data for the callback.
+ *
+ * Iterate over @parent's child devices, starting at @from, and call @fn
+ * for each, passing it @data. This helper is identical to
+ * device_for_each_child_reverse() when @from is NULL.
+ *
+ * @fn is checked each iteration. If it returns anything other than 0,
+ * iteration stop and that value is returned to the caller of
+ * device_for_each_child_reverse_from();
+ */
+int device_for_each_child_reverse_from(struct device *parent,
+				       struct device *from, const void *data,
+				       int (*fn)(struct device *, const void *))
+{
+	struct klist_iter i;
+	struct device *child;
+	int error = 0;
+
+	if (!parent->p)
+		return 0;
+
+	klist_iter_init_node(&parent->p->klist_children, &i,
+			     (from ? &from->p->knode_parent : NULL));
+	while ((child = prev_device(&i)) && !error)
+		error = fn(child, data);
+	klist_iter_exit(&i);
+	return error;
+}
+EXPORT_SYMBOL_GPL(device_for_each_child_reverse_from);
+
 /**
  * device_find_child - device iterator for locating a particular device.
  * @parent: parent struct device
diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index 3df10517a327..223c273c0cd1 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -712,7 +712,44 @@ static int cxl_decoder_commit(struct cxl_decoder *cxld)
 	return 0;
 }
 
-static int cxl_decoder_reset(struct cxl_decoder *cxld)
+static int commit_reap(struct device *dev, const void *data)
+{
+	struct cxl_port *port = to_cxl_port(dev->parent);
+	struct cxl_decoder *cxld;
+
+	if (!is_switch_decoder(dev) && !is_endpoint_decoder(dev))
+		return 0;
+
+	cxld = to_cxl_decoder(dev);
+	if (port->commit_end == cxld->id &&
+	    ((cxld->flags & CXL_DECODER_F_ENABLE) == 0)) {
+		port->commit_end--;
+		dev_dbg(&port->dev, "reap: %s commit_end: %d\n",
+			dev_name(&cxld->dev), port->commit_end);
+	}
+
+	return 0;
+}
+
+void cxl_port_commit_reap(struct cxl_decoder *cxld)
+{
+	struct cxl_port *port = to_cxl_port(cxld->dev.parent);
+
+	lockdep_assert_held_write(&cxl_region_rwsem);
+
+	/*
+	 * Once the highest committed decoder is disabled, free any other
+	 * decoders that were pinned allocated by out-of-order release.
+	 */
+	port->commit_end--;
+	dev_dbg(&port->dev, "reap: %s commit_end: %d\n", dev_name(&cxld->dev),
+		port->commit_end);
+	device_for_each_child_reverse_from(&port->dev, &cxld->dev, NULL,
+					   commit_reap);
+}
+EXPORT_SYMBOL_NS_GPL(cxl_port_commit_reap, CXL);
+
+static void cxl_decoder_reset(struct cxl_decoder *cxld)
 {
 	struct cxl_port *port = to_cxl_port(cxld->dev.parent);
 	struct cxl_hdm *cxlhdm = dev_get_drvdata(&port->dev);
@@ -721,14 +758,14 @@ static int cxl_decoder_reset(struct cxl_decoder *cxld)
 	u32 ctrl;
 
 	if ((cxld->flags & CXL_DECODER_F_ENABLE) == 0)
-		return 0;
+		return;
 
-	if (port->commit_end != id) {
+	if (port->commit_end == id)
+		cxl_port_commit_reap(cxld);
+	else
 		dev_dbg(&port->dev,
 			"%s: out of order reset, expected decoder%d.%d\n",
 			dev_name(&cxld->dev), port->id, port->commit_end);
-		return -EBUSY;
-	}
 
 	down_read(&cxl_dpa_rwsem);
 	ctrl = readl(hdm + CXL_HDM_DECODER0_CTRL_OFFSET(id));
@@ -741,7 +778,6 @@ static int cxl_decoder_reset(struct cxl_decoder *cxld)
 	writel(0, hdm + CXL_HDM_DECODER0_BASE_LOW_OFFSET(id));
 	up_read(&cxl_dpa_rwsem);
 
-	port->commit_end--;
 	cxld->flags &= ~CXL_DECODER_F_ENABLE;
 
 	/* Userspace is now responsible for reconfiguring this decoder */
@@ -751,8 +787,6 @@ static int cxl_decoder_reset(struct cxl_decoder *cxld)
 		cxled = to_cxl_endpoint_decoder(&cxld->dev);
 		cxled->state = CXL_DECODER_STATE_MANUAL;
 	}
-
-	return 0;
 }
 
 static int cxl_setup_hdm_decoder_from_dvsec(
diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index e701e4b04032..3478d2058303 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -232,8 +232,8 @@ static int cxl_region_invalidate_memregion(struct cxl_region *cxlr)
 				"Bypassing cpu_cache_invalidate_memregion() for testing!\n");
 			return 0;
 		} else {
-			dev_err(&cxlr->dev,
-				"Failed to synchronize CPU cache state\n");
+			dev_WARN(&cxlr->dev,
+				 "Failed to synchronize CPU cache state\n");
 			return -ENXIO;
 		}
 	}
@@ -242,19 +242,17 @@ static int cxl_region_invalidate_memregion(struct cxl_region *cxlr)
 	return 0;
 }
 
-static int cxl_region_decode_reset(struct cxl_region *cxlr, int count)
+static void cxl_region_decode_reset(struct cxl_region *cxlr, int count)
 {
 	struct cxl_region_params *p = &cxlr->params;
-	int i, rc = 0;
+	int i;
 
 	/*
-	 * Before region teardown attempt to flush, and if the flush
-	 * fails cancel the region teardown for data consistency
-	 * concerns
+	 * Before region teardown attempt to flush, evict any data cached for
+	 * this region, or scream loudly about missing arch / platform support
+	 * for CXL teardown.
 	 */
-	rc = cxl_region_invalidate_memregion(cxlr);
-	if (rc)
-		return rc;
+	cxl_region_invalidate_memregion(cxlr);
 
 	for (i = count - 1; i >= 0; i--) {
 		struct cxl_endpoint_decoder *cxled = p->targets[i];
@@ -277,23 +275,17 @@ static int cxl_region_decode_reset(struct cxl_region *cxlr, int count)
 			cxl_rr = cxl_rr_load(iter, cxlr);
 			cxld = cxl_rr->decoder;
 			if (cxld->reset)
-				rc = cxld->reset(cxld);
-			if (rc)
-				return rc;
+				cxld->reset(cxld);
 			set_bit(CXL_REGION_F_NEEDS_RESET, &cxlr->flags);
 		}
 
 endpoint_reset:
-		rc = cxled->cxld.reset(&cxled->cxld);
-		if (rc)
-			return rc;
+		cxled->cxld.reset(&cxled->cxld);
 		set_bit(CXL_REGION_F_NEEDS_RESET, &cxlr->flags);
 	}
 
 	/* all decoders associated with this region have been torn down */
 	clear_bit(CXL_REGION_F_NEEDS_RESET, &cxlr->flags);
-
-	return 0;
 }
 
 static int commit_decoder(struct cxl_decoder *cxld)
@@ -409,16 +401,8 @@ static ssize_t commit_store(struct device *dev, struct device_attribute *attr,
 		 * still pending.
 		 */
 		if (p->state == CXL_CONFIG_RESET_PENDING) {
-			rc = cxl_region_decode_reset(cxlr, p->interleave_ways);
-			/*
-			 * Revert to committed since there may still be active
-			 * decoders associated with this region, or move forward
-			 * to active to mark the reset successful
-			 */
-			if (rc)
-				p->state = CXL_CONFIG_COMMIT;
-			else
-				p->state = CXL_CONFIG_ACTIVE;
+			cxl_region_decode_reset(cxlr, p->interleave_ways);
+			p->state = CXL_CONFIG_ACTIVE;
 		}
 	}
 
@@ -2054,13 +2038,7 @@ static int cxl_region_detach(struct cxl_endpoint_decoder *cxled)
 	get_device(&cxlr->dev);
 
 	if (p->state > CXL_CONFIG_ACTIVE) {
-		/*
-		 * TODO: tear down all impacted regions if a device is
-		 * removed out of order
-		 */
-		rc = cxl_region_decode_reset(cxlr, p->interleave_ways);
-		if (rc)
-			goto out;
+		cxl_region_decode_reset(cxlr, p->interleave_ways);
 		p->state = CXL_CONFIG_ACTIVE;
 	}
 
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 0d8b810a51f0..5406e3ab3d4a 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -359,7 +359,7 @@ struct cxl_decoder {
 	struct cxl_region *region;
 	unsigned long flags;
 	int (*commit)(struct cxl_decoder *cxld);
-	int (*reset)(struct cxl_decoder *cxld);
+	void (*reset)(struct cxl_decoder *cxld);
 };
 
 /*
@@ -730,6 +730,7 @@ static inline bool is_cxl_root(struct cxl_port *port)
 int cxl_num_decoders_committed(struct cxl_port *port);
 bool is_cxl_port(const struct device *dev);
 struct cxl_port *to_cxl_port(const struct device *dev);
+void cxl_port_commit_reap(struct cxl_decoder *cxld);
 struct pci_bus;
 int devm_cxl_register_pci_bus(struct device *host, struct device *uport_dev,
 			      struct pci_bus *bus);
diff --git a/include/linux/device.h b/include/linux/device.h
index b4bde8d22697..667cb6db9019 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -1078,6 +1078,9 @@ int device_for_each_child(struct device *dev, void *data,
 			  int (*fn)(struct device *dev, void *data));
 int device_for_each_child_reverse(struct device *dev, void *data,
 				  int (*fn)(struct device *dev, void *data));
+int device_for_each_child_reverse_from(struct device *parent,
+				       struct device *from, const void *data,
+				       int (*fn)(struct device *, const void *));
 struct device *device_find_child(struct device *dev, void *data,
 				 int (*match)(struct device *dev, void *data));
 struct device *device_find_child_by_name(struct device *parent,
diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
index 90d5afd52dd0..c5bbd89b3192 100644
--- a/tools/testing/cxl/test/cxl.c
+++ b/tools/testing/cxl/test/cxl.c
@@ -693,26 +693,22 @@ static int mock_decoder_commit(struct cxl_decoder *cxld)
 	return 0;
 }
 
-static int mock_decoder_reset(struct cxl_decoder *cxld)
+static void mock_decoder_reset(struct cxl_decoder *cxld)
 {
 	struct cxl_port *port = to_cxl_port(cxld->dev.parent);
 	int id = cxld->id;
 
 	if ((cxld->flags & CXL_DECODER_F_ENABLE) == 0)
-		return 0;
+		return;
 
 	dev_dbg(&port->dev, "%s reset\n", dev_name(&cxld->dev));
-	if (port->commit_end != id) {
+	if (port->commit_end == id)
+		cxl_port_commit_reap(cxld);
+	else
 		dev_dbg(&port->dev,
 			"%s: out of order reset, expected decoder%d.%d\n",
 			dev_name(&cxld->dev), port->id, port->commit_end);
-		return -EBUSY;
-	}
-
-	port->commit_end--;
 	cxld->flags &= ~CXL_DECODER_F_ENABLE;
-
-	return 0;
 }
 
 static void default_mock_decoder(struct cxl_decoder *cxld)


