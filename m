Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0ACEF713AB9
	for <lists+stable@lfdr.de>; Sun, 28 May 2023 18:50:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbjE1Qus (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 28 May 2023 12:50:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbjE1Qur (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 28 May 2023 12:50:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0192BE
        for <stable@vger.kernel.org>; Sun, 28 May 2023 09:50:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 322C660F79
        for <stable@vger.kernel.org>; Sun, 28 May 2023 16:50:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A102C433EF;
        Sun, 28 May 2023 16:50:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685292644;
        bh=YD/t2ce435vJJFZh2lj683NTsCPYv1rrFQYdRaZ4sJU=;
        h=Subject:To:Cc:From:Date:From;
        b=0ZnFf+/QQ3ypShf4QC37u3swXiXa8h9WurpMeIA0+QElAunofHdE7LLX67UoCWhgC
         dwF7BvV4UXZwniR3VL9qNEUViYWL6dlMWElKDYjzRsLNj8oST4oR/lrnjuidNNhmec
         uj9/KoWi8AZZl+ip3Nye9N4I7wkEwSDx1GrRH9NY=
Subject: FAILED: patch "[PATCH] cxl: Move cxl_await_media_ready() to before capacity info" failed to apply to 5.15-stable tree
To:     dave.jiang@intel.com, dan.j.williams@intel.com, ira.weiny@intel.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sun, 28 May 2023 17:48:27 +0100
Message-ID: <2023052827-dancing-proud-0d5b@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x e764f12208b99ac7892c4e3f6bf88d71ca71036f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023052827-dancing-proud-0d5b@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:

e764f12208b9 ("cxl: Move cxl_await_media_ready() to before capacity info retrieval")
fd35fdcbf75b ("cxl/test: Add mock test for set_timestamp")
f8d22bf50ca5 ("tools/testing/cxl: Mock support for Get Poison List")
a5fcd228ca1d ("Merge branch 'for-6.3/cxl-rr-emu' into cxl/next")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From e764f12208b99ac7892c4e3f6bf88d71ca71036f Mon Sep 17 00:00:00 2001
From: Dave Jiang <dave.jiang@intel.com>
Date: Thu, 18 May 2023 16:38:20 -0700
Subject: [PATCH] cxl: Move cxl_await_media_ready() to before capacity info
 retrieval

Move cxl_await_media_ready() to cxl_pci probe before driver starts issuing
IDENTIFY and retrieving memory device information to ensure that the
device is ready to provide the information. Allow cxl_pci_probe() to succeed
even if media is not ready. Cache the media failure in cxlds and don't ask
the device for any media information.

The rationale for proceeding in the !media_ready case is to allow for
mailbox operations to interrogate and/or remediate the device. After
media is repaired then rebinding the cxl_pci driver is expected to
restart the capacity scan.

Suggested-by: Dan Williams <dan.j.williams@intel.com>
Fixes: b39cb1052a5c ("cxl/mem: Register CXL memX devices")
Reviewed-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Link: https://lore.kernel.org/r/168445310026.3251520.8124296540679268206.stgit@djiang5-mobl3
[djbw: fixup cxl_test]
Signed-off-by: Dan Williams <dan.j.williams@intel.com>

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index 23b9ff920d7e..2c8dc7e2b84d 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -1028,7 +1028,7 @@ static int cxl_mem_get_partition_info(struct cxl_dev_state *cxlds)
  * cxl_dev_state_identify() - Send the IDENTIFY command to the device.
  * @cxlds: The device data for the operation
  *
- * Return: 0 if identify was executed successfully.
+ * Return: 0 if identify was executed successfully or media not ready.
  *
  * This will dispatch the identify command to the device and on success populate
  * structures to be exported to sysfs.
@@ -1041,6 +1041,9 @@ int cxl_dev_state_identify(struct cxl_dev_state *cxlds)
 	u32 val;
 	int rc;
 
+	if (!cxlds->media_ready)
+		return 0;
+
 	mbox_cmd = (struct cxl_mbox_cmd) {
 		.opcode = CXL_MBOX_OP_IDENTIFY,
 		.size_out = sizeof(id),
@@ -1115,10 +1118,12 @@ int cxl_mem_create_range_info(struct cxl_dev_state *cxlds)
 				   cxlds->persistent_only_bytes, "pmem");
 	}
 
-	rc = cxl_mem_get_partition_info(cxlds);
-	if (rc) {
-		dev_err(dev, "Failed to query partition information\n");
-		return rc;
+	if (cxlds->media_ready) {
+		rc = cxl_mem_get_partition_info(cxlds);
+		if (rc) {
+			dev_err(dev, "Failed to query partition information\n");
+			return rc;
+		}
 	}
 
 	rc = add_dpa_res(dev, &cxlds->dpa_res, &cxlds->ram_res, 0,
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index db12b6313afb..a2845a7a69d8 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -266,6 +266,7 @@ struct cxl_poison_state {
  * @regs: Parsed register blocks
  * @cxl_dvsec: Offset to the PCIe device DVSEC
  * @rcd: operating in RCD mode (CXL 3.0 9.11.8 CXL Devices Attached to an RCH)
+ * @media_ready: Indicate whether the device media is usable
  * @payload_size: Size of space for payload
  *                (CXL 2.0 8.2.8.4.3 Mailbox Capabilities Register)
  * @lsa_size: Size of Label Storage Area
@@ -303,6 +304,7 @@ struct cxl_dev_state {
 	int cxl_dvsec;
 
 	bool rcd;
+	bool media_ready;
 	size_t payload_size;
 	size_t lsa_size;
 	struct mutex mbox_mutex; /* Protects device mailbox and firmware */
diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
index 10caf180b3fa..519edd0eb196 100644
--- a/drivers/cxl/mem.c
+++ b/drivers/cxl/mem.c
@@ -124,6 +124,9 @@ static int cxl_mem_probe(struct device *dev)
 	struct dentry *dentry;
 	int rc;
 
+	if (!cxlds->media_ready)
+		return -EBUSY;
+
 	/*
 	 * Someone is trying to reattach this device after it lost its port
 	 * connection (an endpoint port previously registered by this memdev was
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index f7a5b8e9c102..0872f2233ed0 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -708,6 +708,12 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (rc)
 		dev_dbg(&pdev->dev, "Failed to map RAS capability.\n");
 
+	rc = cxl_await_media_ready(cxlds);
+	if (rc == 0)
+		cxlds->media_ready = true;
+	else
+		dev_warn(&pdev->dev, "Media not active (%d)\n", rc);
+
 	rc = cxl_pci_setup_mailbox(cxlds);
 	if (rc)
 		return rc;
diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
index 17a95f469c26..c23b6164e1c0 100644
--- a/drivers/cxl/port.c
+++ b/drivers/cxl/port.c
@@ -117,12 +117,6 @@ static int cxl_endpoint_port_probe(struct cxl_port *port)
 	if (rc)
 		return rc;
 
-	rc = cxl_await_media_ready(cxlds);
-	if (rc) {
-		dev_err(&port->dev, "Media not active (%d)\n", rc);
-		return rc;
-	}
-
 	rc = devm_cxl_enumerate_decoders(cxlhdm, &info);
 	if (rc)
 		return rc;
diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
index ba572d03c687..34b48027b3de 100644
--- a/tools/testing/cxl/test/mem.c
+++ b/tools/testing/cxl/test/mem.c
@@ -1256,6 +1256,7 @@ static int cxl_mock_mem_probe(struct platform_device *pdev)
 	if (rc)
 		return rc;
 
+	cxlds->media_ready = true;
 	rc = cxl_dev_state_identify(cxlds);
 	if (rc)
 		return rc;

