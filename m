Return-Path: <stable+bounces-83422-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F3BC999C1E
	for <lists+stable@lfdr.de>; Fri, 11 Oct 2024 07:34:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 634C3B2289B
	for <lists+stable@lfdr.de>; Fri, 11 Oct 2024 05:34:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD0C2194088;
	Fri, 11 Oct 2024 05:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="clI8qarG"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAEEF2F26;
	Fri, 11 Oct 2024 05:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728624871; cv=none; b=OxIF59WEe7MO4ieBfGi4XVVl/XFjmB/td41fyRLdbkvUyzNcJBh4ZehEjP9wmO5M5H8PQZqEDkgnoe+o1NLV6lmZg8LL4ElcpOEPUV9nZm4+ISeTwy7z7eq/fgneLgW9cL+vhR5ocY4WMw6X1KQb4es7ybtQcIRzzsCm4ctKp28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728624871; c=relaxed/simple;
	bh=obtioSTRwwRcBv5j9xguOwlGpsr+Bb/BJZ8PlRGyjvI=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nVgX/9z/cLlacH/McveSMZdwN7NHRz1QeRmOyAjuFzKWQqc+EiR6z8Bca4i05yzN1QMi/sYh/eOPb1/0EhW5N9MOKkmcQBk/pzJFg3Gm1FSJ2jsGbHNkOR4fyz2EDtdym+ZYFNS48csv8LctdnVoj9KdM9+nhfGOWFXPZOE5SeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=clI8qarG; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728624869; x=1760160869;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=obtioSTRwwRcBv5j9xguOwlGpsr+Bb/BJZ8PlRGyjvI=;
  b=clI8qarGzdkGAVF8sK7+r9KEeTL1P1Ew6GWZEjzFJCYAGk3NBBDpEqBG
   5R9fazGja54Elc0eldG59sfRY70b2XAQD2q1QT7xHwngL8ceWbQScrEVN
   XS1CKxzL67+D2gjQ3ty7/LnZy6jK/dfUzypz5gYx1ELQkLj5qO5wfdWQO
   pGz9lKlENjgOvxbtZBocTGgMHZOpmYQzxdzaRb9odxaE1fEn18FREiYRX
   xY7D+ZKS1JL1eiz+lP3ubxOnc1kOSSylaVHKFRZl7E4s8HHv7Su797ZA6
   m3eMiB0AY4lq7eJSpdGd4Gayxh5s1GkA0jkdZYGU4CEcNvDnvXKui/R1g
   A==;
X-CSE-ConnectionGUID: zlXdb/kCSlqzX/qV+dOXpg==
X-CSE-MsgGUID: 7XO47e79SvCo6WoSST2aqA==
X-IronPort-AV: E=McAfee;i="6700,10204,11221"; a="53416739"
X-IronPort-AV: E=Sophos;i="6.11,195,1725346800"; 
   d="scan'208";a="53416739"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2024 22:34:29 -0700
X-CSE-ConnectionGUID: sR/lD/9QThOYEuzw1k7Pfw==
X-CSE-MsgGUID: JsrE8DygRrei8KcvRSSP4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,195,1725346800"; 
   d="scan'208";a="114262380"
Received: from inaky-mobl1.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.125.111.110])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2024 22:34:29 -0700
Subject: [PATCH 4/5] cxl/port: Fix use-after-free,
 permit out-of-order decoder shutdown
From: Dan Williams <dan.j.williams@intel.com>
To: dave.jiang@intel.com, ira.weiny@intel.com
Cc: stable@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Alison Schofield <alison.schofield@intel.com>, Zijun Hu <zijun_hu@icloud.com>,
 vishal.l.verma@intel.com, linux-cxl@vger.kernel.org
Date: Thu, 10 Oct 2024 22:34:26 -0700
Message-ID: <172862486548.2150669.3548553804904171839.stgit@dwillia2-xfh.jf.intel.com>
In-Reply-To: <172862483180.2150669.5564474284074502692.stgit@dwillia2-xfh.jf.intel.com>
References: <172862483180.2150669.5564474284074502692.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: StGit/0.18-3-g996c
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

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
Cc: <stable@vger.kernel.org>
Fixes: 176baefb2eb5 ("cxl/hdm: Commit decoder state to hardware")
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: Dave Jiang <dave.jiang@intel.com>
Cc: Alison Schofield <alison.schofield@intel.com>
Cc: Ira Weiny <ira.weiny@intel.com>
Cc: Zijun Hu <zijun_hu@icloud.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/base/core.c          |   35 +++++++++++++++++++++++++++++
 drivers/cxl/core/hdm.c       |   50 +++++++++++++++++++++++++++++++++++-------
 drivers/cxl/core/region.c    |   48 +++++++++++-----------------------------
 drivers/cxl/cxl.h            |    3 ++-
 include/linux/device.h       |    3 +++
 tools/testing/cxl/test/cxl.c |   14 ++++--------
 6 files changed, 100 insertions(+), 53 deletions(-)

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


