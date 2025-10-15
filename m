Return-Path: <stable+bounces-185802-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 515A9BDE34D
	for <lists+stable@lfdr.de>; Wed, 15 Oct 2025 13:09:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 923FF50660E
	for <lists+stable@lfdr.de>; Wed, 15 Oct 2025 11:06:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3424F31D39C;
	Wed, 15 Oct 2025 11:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Vxp4ISXC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7C8531CA61
	for <stable@vger.kernel.org>; Wed, 15 Oct 2025 11:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760526388; cv=none; b=tHSKRXTH7+ipAUsY6wzvdIKA856Lt4ZLfsM0liD78wqJgbnUBYKVLnwmZXAZqyqMq8+nCUNgfl936rL0H2YTP+PhZOY9+cSWhBDI34QX6rj2YCOKa1vaZn+YJmT4era5btJThCnyPNAijQxuz5TlVPqUGbYRDjhgbfkbXiKJhK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760526388; c=relaxed/simple;
	bh=+69ghTjLQLrNTii5dsC98K4pmlqMFz6vgYaEBOT4eTQ=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=FAacu6xRkbi63MozXchv8pksihCY84D7fAZhAQyxplnY6nCooz6j3J2Ve2/BRTAbG3yupFqYO1p25564QorrTQ7e1DQqt6m96NThIYlKI2uI0qRxiz2L9jw8P8v2ecedYnDD3sVVBCLobs3jgPHmzHH9D0eBCqJrn5V1YEjYNIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Vxp4ISXC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64C8CC4CEF8;
	Wed, 15 Oct 2025 11:06:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760526388;
	bh=+69ghTjLQLrNTii5dsC98K4pmlqMFz6vgYaEBOT4eTQ=;
	h=Subject:To:Cc:From:Date:From;
	b=Vxp4ISXClYdVtMCY5+CT8EEnCfKZJrkXccAhS7yX3oPr5gM3kF/ByvnfLFU7gdusN
	 HyAq99qOfqifPF/fi5T8nGQjIF6TLP9cIQ8vBAROFlK4fOh4ELa07GP3vR9dtsVXrL
	 EbyS7X21fLnij3ovNhzmTRimxsf/wXkRqMs35Z7Q=
Subject: FAILED: patch "[PATCH] cxl, acpi/hmat: Update CXL access coordinates directly" failed to apply to 6.12-stable tree
To: dave.jiang@intel.com,dan.j.williams@intel.com,jonathan.cameron@huawei.com,marc.herbert@linux.intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 15 Oct 2025 13:06:18 +0200
Message-ID: <2025101518-thriving-lend-6587@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 2e454fb8056df6da4bba7d89a57bf60e217463c0
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025101518-thriving-lend-6587@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 2e454fb8056df6da4bba7d89a57bf60e217463c0 Mon Sep 17 00:00:00 2001
From: Dave Jiang <dave.jiang@intel.com>
Date: Fri, 29 Aug 2025 15:29:06 -0700
Subject: [PATCH] cxl, acpi/hmat: Update CXL access coordinates directly
 instead of through HMAT

The current implementation of CXL memory hotplug notifier gets called
before the HMAT memory hotplug notifier. The CXL driver calculates the
access coordinates (bandwidth and latency values) for the CXL end to
end path (i.e. CPU to endpoint). When the CXL region is onlined, the CXL
memory hotplug notifier writes the access coordinates to the HMAT target
structs. Then the HMAT memory hotplug notifier is called and it creates
the access coordinates for the node sysfs attributes.

During testing on an Intel platform, it was found that although the
newly calculated coordinates were pushed to sysfs, the sysfs attributes for
the access coordinates showed up with the wrong initiator. The system has
4 nodes (0, 1, 2, 3) where node 0 and 1 are CPU nodes and node 2 and 3 are
CXL nodes. The expectation is that node 2 would show up as a target to node
0:
/sys/devices/system/node/node2/access0/initiators/node0

However it was observed that node 2 showed up as a target under node 1:
/sys/devices/system/node/node2/access0/initiators/node1

The original intent of the 'ext_updated' flag in HMAT handling code was to
stop HMAT memory hotplug callback from clobbering the access coordinates
after CXL has injected its calculated coordinates and replaced the generic
target access coordinates provided by the HMAT table in the HMAT target
structs. However the flag is hacky at best and blocks the updates from
other CXL regions that are onlined in the same node later on. Remove the
'ext_updated' flag usage and just update the access coordinates for the
nodes directly without touching HMAT target data.

The hotplug memory callback ordering is changed. Instead of changing CXL,
move HMAT back so there's room for the levels rather than have CXL share
the same level as SLAB_CALLBACK_PRI. The change will resulting in the CXL
callback to be executed after the HMAT callback.

With the change, the CXL hotplug memory notifier runs after the HMAT
callback. The HMAT callback will create the node sysfs attributes for
access coordinates. The CXL callback will write the access coordinates to
the now created node sysfs attributes directly and will not pollute the
HMAT target values.

A nodemask is introduced to keep track if a node has been updated and
prevents further updates.

Fixes: 067353a46d8c ("cxl/region: Add memory hotplug notifier for cxl region")
Cc: stable@vger.kernel.org
Tested-by: Marc Herbert <marc.herbert@linux.intel.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Link: https://patch.msgid.link/20250829222907.1290912-4-dave.jiang@intel.com
Signed-off-by: Dave Jiang <dave.jiang@intel.com>

diff --git a/drivers/acpi/numa/hmat.c b/drivers/acpi/numa/hmat.c
index 4958301f5417..5d32490dc4ab 100644
--- a/drivers/acpi/numa/hmat.c
+++ b/drivers/acpi/numa/hmat.c
@@ -74,7 +74,6 @@ struct memory_target {
 	struct node_cache_attrs cache_attrs;
 	u8 gen_port_device_handle[ACPI_SRAT_DEVICE_HANDLE_SIZE];
 	bool registered;
-	bool ext_updated;	/* externally updated */
 };
 
 struct memory_initiator {
@@ -391,7 +390,6 @@ int hmat_update_target_coordinates(int nid, struct access_coordinate *coord,
 				  coord->read_bandwidth, access);
 	hmat_update_target_access(target, ACPI_HMAT_WRITE_BANDWIDTH,
 				  coord->write_bandwidth, access);
-	target->ext_updated = true;
 
 	return 0;
 }
@@ -773,10 +771,6 @@ static void hmat_update_target_attrs(struct memory_target *target,
 	u32 best = 0;
 	int i;
 
-	/* Don't update if an external agent has changed the data.  */
-	if (target->ext_updated)
-		return;
-
 	/* Don't update for generic port if there's no device handle */
 	if ((access == NODE_ACCESS_CLASS_GENPORT_SINK_LOCAL ||
 	     access == NODE_ACCESS_CLASS_GENPORT_SINK_CPU) &&
diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
index c0af645425f4..c891fd618cfd 100644
--- a/drivers/cxl/core/cdat.c
+++ b/drivers/cxl/core/cdat.c
@@ -1081,8 +1081,3 @@ int cxl_update_hmat_access_coordinates(int nid, struct cxl_region *cxlr,
 {
 	return hmat_update_target_coordinates(nid, &cxlr->coord[access], access);
 }
-
-bool cxl_need_node_perf_attrs_update(int nid)
-{
-	return !acpi_node_backed_by_real_pxm(nid);
-}
diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index 2669f251d677..a253d308f3c9 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -139,7 +139,6 @@ long cxl_pci_get_latency(struct pci_dev *pdev);
 int cxl_pci_get_bandwidth(struct pci_dev *pdev, struct access_coordinate *c);
 int cxl_update_hmat_access_coordinates(int nid, struct cxl_region *cxlr,
 				       enum access_coordinate_class access);
-bool cxl_need_node_perf_attrs_update(int nid);
 int cxl_port_get_switch_dport_bandwidth(struct cxl_port *port,
 					struct access_coordinate *c);
 
diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 71cc42d05248..0ed95cbc5d5b 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -30,6 +30,12 @@
  * 3. Decoder targets
  */
 
+/*
+ * nodemask that sets per node when the access_coordinates for the node has
+ * been updated by the CXL memory hotplug notifier.
+ */
+static nodemask_t nodemask_region_seen = NODE_MASK_NONE;
+
 static struct cxl_region *to_cxl_region(struct device *dev);
 
 #define __ACCESS_ATTR_RO(_level, _name) {				\
@@ -2442,14 +2448,8 @@ static bool cxl_region_update_coordinates(struct cxl_region *cxlr, int nid)
 
 	for (int i = 0; i < ACCESS_COORDINATE_MAX; i++) {
 		if (cxlr->coord[i].read_bandwidth) {
-			rc = 0;
-			if (cxl_need_node_perf_attrs_update(nid))
-				node_set_perf_attrs(nid, &cxlr->coord[i], i);
-			else
-				rc = cxl_update_hmat_access_coordinates(nid, cxlr, i);
-
-			if (rc == 0)
-				cset++;
+			node_update_perf_attrs(nid, &cxlr->coord[i], i);
+			cset++;
 		}
 	}
 
@@ -2487,6 +2487,10 @@ static int cxl_region_perf_attrs_callback(struct notifier_block *nb,
 	if (nid != region_nid)
 		return NOTIFY_DONE;
 
+	/* No action needed if node bit already set */
+	if (node_test_and_set(nid, nodemask_region_seen))
+		return NOTIFY_DONE;
+
 	if (!cxl_region_update_coordinates(cxlr, nid))
 		return NOTIFY_DONE;
 
diff --git a/include/linux/memory.h b/include/linux/memory.h
index 1305102688d0..0b755d1ef1ec 100644
--- a/include/linux/memory.h
+++ b/include/linux/memory.h
@@ -120,8 +120,8 @@ struct mem_section;
  */
 #define DEFAULT_CALLBACK_PRI	0
 #define SLAB_CALLBACK_PRI	1
-#define HMAT_CALLBACK_PRI	2
 #define CXL_CALLBACK_PRI	5
+#define HMAT_CALLBACK_PRI	6
 #define MM_COMPUTE_BATCH_PRI	10
 #define CPUSET_CALLBACK_PRI	10
 #define MEMTIER_HOTPLUG_PRI	100


