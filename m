Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38F3371384D
	for <lists+stable@lfdr.de>; Sun, 28 May 2023 09:26:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229441AbjE1H0m (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 28 May 2023 03:26:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjE1H0l (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 28 May 2023 03:26:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A16DC7
        for <stable@vger.kernel.org>; Sun, 28 May 2023 00:26:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0DBB960F82
        for <stable@vger.kernel.org>; Sun, 28 May 2023 07:26:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23FCAC433D2;
        Sun, 28 May 2023 07:26:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685258799;
        bh=lmmNwp0Ip1YUsum8WzSg+pGmOucMSELMWq1Hi3IN3KQ=;
        h=Subject:To:Cc:From:Date:From;
        b=oE10FkTUNwB22TZo5d8pyiTH6hcLNxleYVzy+5vGETmV+ikqM2NIdJ/q9+EIG9KVm
         ZtJDttGUTc295HhTcI5xAYaRcLjWvqFA0p4GMgUN2KTYNB0EbAomEPwVKtdvZLWSvg
         WO1ixIip9aid1J2WouTY+VPll4dOb8O3IEg0rrWk=
Subject: FAILED: patch "[PATCH] cxl/port: Enable the HDM decoder capability for switch ports" failed to apply to 6.1-stable tree
To:     dan.j.williams@intel.com, derick.w.marks@intel.com,
        ira.weiny@intel.com, stable@vger.kernel.org
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sun, 28 May 2023 08:26:37 +0100
Message-ID: <2023052837-carve-antics-2e83@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x eb0764b822b9b26880b28ccb9100b2983e01bc17
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023052837-carve-antics-2e83@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

eb0764b822b9 ("cxl/port: Enable the HDM decoder capability for switch ports")
7bba261e0aa6 ("cxl/port: Scan single-target ports for decoders")
a5fcd228ca1d ("Merge branch 'for-6.3/cxl-rr-emu' into cxl/next")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From eb0764b822b9b26880b28ccb9100b2983e01bc17 Mon Sep 17 00:00:00 2001
From: Dan Williams <dan.j.williams@intel.com>
Date: Wed, 17 May 2023 20:19:43 -0700
Subject: [PATCH] cxl/port: Enable the HDM decoder capability for switch ports

Derick noticed, when testing hot plug, that hot-add behaves nominally
after a removal. However, if the hot-add is done without a prior
removal, CXL.mem accesses fail. It turns out that the original
implementation of the port driver and region programming wrongly assumed
that platform-firmware always enables the host-bridge HDM decoder
capability. Add support turning on switch-level HDM decoders in the case
where platform-firmware has not.

The implementation is careful to only arrange for the enable to be
undone if the current instance of the driver was the one that did the
enable. This is to interoperate with platform-firmware that may expect
CXL.mem to remain active after the driver is shutdown. This comes at the
cost of potentially not shutting down the enable on kexec flows, but it
is mitigated by the fact that the related HDM decoders still need to be
enabled on an individual basis.

Cc: <stable@vger.kernel.org>
Reported-by: Derick Marks <derick.w.marks@intel.com>
Fixes: 54cdbf845cf7 ("cxl/port: Add a driver for 'struct cxl_port' objects")
Reviewed-by: Ira Weiny <ira.weiny@intel.com>
Link: https://lore.kernel.org/r/168437998331.403037.15719879757678389217.stgit@dwillia2-xfh.jf.intel.com
Signed-off-by: Dan Williams <dan.j.williams@intel.com>

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index f332fe7af92b..c35c002b65dd 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -241,17 +241,36 @@ static void disable_hdm(void *_cxlhdm)
 	       hdm + CXL_HDM_DECODER_CTRL_OFFSET);
 }
 
-static int devm_cxl_enable_hdm(struct device *host, struct cxl_hdm *cxlhdm)
+int devm_cxl_enable_hdm(struct cxl_port *port, struct cxl_hdm *cxlhdm)
 {
-	void __iomem *hdm = cxlhdm->regs.hdm_decoder;
+	void __iomem *hdm;
 	u32 global_ctrl;
 
+	/*
+	 * If the hdm capability was not mapped there is nothing to enable and
+	 * the caller is responsible for what happens next.  For example,
+	 * emulate a passthrough decoder.
+	 */
+	if (IS_ERR(cxlhdm))
+		return 0;
+
+	hdm = cxlhdm->regs.hdm_decoder;
 	global_ctrl = readl(hdm + CXL_HDM_DECODER_CTRL_OFFSET);
+
+	/*
+	 * If the HDM decoder capability was enabled on entry, skip
+	 * registering disable_hdm() since this decode capability may be
+	 * owned by platform firmware.
+	 */
+	if (global_ctrl & CXL_HDM_DECODER_ENABLE)
+		return 0;
+
 	writel(global_ctrl | CXL_HDM_DECODER_ENABLE,
 	       hdm + CXL_HDM_DECODER_CTRL_OFFSET);
 
-	return devm_add_action_or_reset(host, disable_hdm, cxlhdm);
+	return devm_add_action_or_reset(&port->dev, disable_hdm, cxlhdm);
 }
+EXPORT_SYMBOL_NS_GPL(devm_cxl_enable_hdm, CXL);
 
 int cxl_dvsec_rr_decode(struct device *dev, int d,
 			struct cxl_endpoint_dvsec_info *info)
@@ -425,7 +444,7 @@ int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm,
 	if (info->mem_enabled)
 		return 0;
 
-	rc = devm_cxl_enable_hdm(&port->dev, cxlhdm);
+	rc = devm_cxl_enable_hdm(port, cxlhdm);
 	if (rc)
 		return rc;
 
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 044a92d9813e..f93a28538962 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -710,6 +710,7 @@ struct cxl_endpoint_dvsec_info {
 struct cxl_hdm;
 struct cxl_hdm *devm_cxl_setup_hdm(struct cxl_port *port,
 				   struct cxl_endpoint_dvsec_info *info);
+int devm_cxl_enable_hdm(struct cxl_port *port, struct cxl_hdm *cxlhdm);
 int devm_cxl_enumerate_decoders(struct cxl_hdm *cxlhdm,
 				struct cxl_endpoint_dvsec_info *info);
 int devm_cxl_add_passthrough_decoder(struct cxl_port *port);
diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
index eb57324c4ad4..17a95f469c26 100644
--- a/drivers/cxl/port.c
+++ b/drivers/cxl/port.c
@@ -60,13 +60,17 @@ static int discover_region(struct device *dev, void *root)
 static int cxl_switch_port_probe(struct cxl_port *port)
 {
 	struct cxl_hdm *cxlhdm;
-	int rc;
+	int rc, nr_dports;
 
-	rc = devm_cxl_port_enumerate_dports(port);
-	if (rc < 0)
-		return rc;
+	nr_dports = devm_cxl_port_enumerate_dports(port);
+	if (nr_dports < 0)
+		return nr_dports;
 
 	cxlhdm = devm_cxl_setup_hdm(port, NULL);
+	rc = devm_cxl_enable_hdm(port, cxlhdm);
+	if (rc)
+		return rc;
+
 	if (!IS_ERR(cxlhdm))
 		return devm_cxl_enumerate_decoders(cxlhdm, NULL);
 
@@ -75,7 +79,7 @@ static int cxl_switch_port_probe(struct cxl_port *port)
 		return PTR_ERR(cxlhdm);
 	}
 
-	if (rc == 1) {
+	if (nr_dports == 1) {
 		dev_dbg(&port->dev, "Fallback to passthrough decoder\n");
 		return devm_cxl_add_passthrough_decoder(port);
 	}
diff --git a/tools/testing/cxl/Kbuild b/tools/testing/cxl/Kbuild
index fba7bec96acd..6f9347ade82c 100644
--- a/tools/testing/cxl/Kbuild
+++ b/tools/testing/cxl/Kbuild
@@ -6,6 +6,7 @@ ldflags-y += --wrap=acpi_pci_find_root
 ldflags-y += --wrap=nvdimm_bus_register
 ldflags-y += --wrap=devm_cxl_port_enumerate_dports
 ldflags-y += --wrap=devm_cxl_setup_hdm
+ldflags-y += --wrap=devm_cxl_enable_hdm
 ldflags-y += --wrap=devm_cxl_add_passthrough_decoder
 ldflags-y += --wrap=devm_cxl_enumerate_decoders
 ldflags-y += --wrap=cxl_await_media_ready
diff --git a/tools/testing/cxl/test/mock.c b/tools/testing/cxl/test/mock.c
index de3933a776fd..284416527644 100644
--- a/tools/testing/cxl/test/mock.c
+++ b/tools/testing/cxl/test/mock.c
@@ -149,6 +149,21 @@ struct cxl_hdm *__wrap_devm_cxl_setup_hdm(struct cxl_port *port,
 }
 EXPORT_SYMBOL_NS_GPL(__wrap_devm_cxl_setup_hdm, CXL);
 
+int __wrap_devm_cxl_enable_hdm(struct cxl_port *port, struct cxl_hdm *cxlhdm)
+{
+	int index, rc;
+	struct cxl_mock_ops *ops = get_cxl_mock_ops(&index);
+
+	if (ops && ops->is_mock_port(port->uport))
+		rc = 0;
+	else
+		rc = devm_cxl_enable_hdm(port, cxlhdm);
+	put_cxl_mock_ops(index);
+
+	return rc;
+}
+EXPORT_SYMBOL_NS_GPL(__wrap_devm_cxl_enable_hdm, CXL);
+
 int __wrap_devm_cxl_add_passthrough_decoder(struct cxl_port *port)
 {
 	int rc, index;

