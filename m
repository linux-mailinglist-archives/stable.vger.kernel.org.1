Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CECD7462FA
	for <lists+stable@lfdr.de>; Mon,  3 Jul 2023 20:56:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230084AbjGCS40 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 3 Jul 2023 14:56:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231241AbjGCS4Z (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 3 Jul 2023 14:56:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E445E6B
        for <stable@vger.kernel.org>; Mon,  3 Jul 2023 11:56:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CF92560D3A
        for <stable@vger.kernel.org>; Mon,  3 Jul 2023 18:56:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E563FC433C8;
        Mon,  3 Jul 2023 18:56:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1688410583;
        bh=tkZebvUB7jLTzwBGztrLg//YN0Jnz0GbwLfeCJGdngI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=t6gWh0IrvYHzDif0zpg/JzwpIQx2/nQvUzrQ78188DAFD7AyFLITWmNh2JQTAPy94
         j7hbrOge2mIXbvaLQJpsEFor2I+28gP+0+9vMj8FMIS9dxMA7ZxRI2ZjwKrD8j/ooL
         SQQCo21PbZv1r1OAKwiBYth8XlLJDf4BxOGI0tG0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH 6.3 07/13] Revert "cxl/port: Enable the HDM decoder capability for switch ports"
Date:   Mon,  3 Jul 2023 20:54:17 +0200
Message-ID: <20230703184519.419646733@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230703184519.206275653@linuxfoundation.org>
References: <20230703184519.206275653@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Dan Williams <dan.j.williams@intel.com>

commit 8f0220af58c3b73e9041377a23708d37600b33c1 upstream.

commit eb0764b822b9 ("cxl/port: Enable the HDM decoder capability for switch ports")

...was added on the observation of CXL memory not being accessible after
setting up a region on a "cold-plugged" device. A "cold-plugged" CXL
device is one that was not present at boot, so platform-firmware/BIOS
has no chance to set it up.

While it is true that the debug found the enable bit clear in the
host-bridge's instance of the global control register (CXL 3.0
8.2.4.19.2 CXL HDM Decoder Global Control Register), that bit is
described as:

"This bit is only applicable to CXL.mem devices and shall
return 0 on CXL Host Bridges and Upstream Switch Ports."

So it is meant to be zero, and further testing confirmed that this "fix"
had no effect on the failure. Revert it, and be more vigilant about
proposed fixes in the future. Since the original copied stable@, flag
this revert for stable@ as well.

Cc: <stable@vger.kernel.org>
Fixes: eb0764b822b9 ("cxl/port: Enable the HDM decoder capability for switch ports")
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Link: https://lore.kernel.org/r/168685882012.3475336.16733084892658264991.stgit@dwillia2-xfh.jf.intel.com
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/cxl/core/pci.c        | 27 ++++-----------------------
 drivers/cxl/cxl.h             |  1 -
 drivers/cxl/port.c            | 14 +++++---------
 tools/testing/cxl/Kbuild      |  1 -
 tools/testing/cxl/test/mock.c | 15 ---------------
 5 files changed, 9 insertions(+), 49 deletions(-)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 67f4ab6daa34..74962b18e3b2 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -308,36 +308,17 @@ static void disable_hdm(void *_cxlhdm)
 	       hdm + CXL_HDM_DECODER_CTRL_OFFSET);
 }
 
-int devm_cxl_enable_hdm(struct cxl_port *port, struct cxl_hdm *cxlhdm)
+static int devm_cxl_enable_hdm(struct device *host, struct cxl_hdm *cxlhdm)
 {
-	void __iomem *hdm;
+	void __iomem *hdm = cxlhdm->regs.hdm_decoder;
 	u32 global_ctrl;
 
-	/*
-	 * If the hdm capability was not mapped there is nothing to enable and
-	 * the caller is responsible for what happens next.  For example,
-	 * emulate a passthrough decoder.
-	 */
-	if (IS_ERR(cxlhdm))
-		return 0;
-
-	hdm = cxlhdm->regs.hdm_decoder;
 	global_ctrl = readl(hdm + CXL_HDM_DECODER_CTRL_OFFSET);
-
-	/*
-	 * If the HDM decoder capability was enabled on entry, skip
-	 * registering disable_hdm() since this decode capability may be
-	 * owned by platform firmware.
-	 */
-	if (global_ctrl & CXL_HDM_DECODER_ENABLE)
-		return 0;
-
 	writel(global_ctrl | CXL_HDM_DECODER_ENABLE,
 	       hdm + CXL_HDM_DECODER_CTRL_OFFSET);
 
-	return devm_add_action_or_reset(&port->dev, disable_hdm, cxlhdm);
+	return devm_add_action_or_reset(host, disable_hdm, cxlhdm);
 }
-EXPORT_SYMBOL_NS_GPL(devm_cxl_enable_hdm, CXL);
 
 int cxl_dvsec_rr_decode(struct device *dev, int d,
 			struct cxl_endpoint_dvsec_info *info)
@@ -511,7 +492,7 @@ int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm,
 	if (info->mem_enabled)
 		return 0;
 
-	rc = devm_cxl_enable_hdm(port, cxlhdm);
+	rc = devm_cxl_enable_hdm(&port->dev, cxlhdm);
 	if (rc)
 		return rc;
 
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index f309b1387858..f0c428cb9a71 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -710,7 +710,6 @@ struct cxl_endpoint_dvsec_info {
 struct cxl_hdm;
 struct cxl_hdm *devm_cxl_setup_hdm(struct cxl_port *port,
 				   struct cxl_endpoint_dvsec_info *info);
-int devm_cxl_enable_hdm(struct cxl_port *port, struct cxl_hdm *cxlhdm);
 int devm_cxl_enumerate_decoders(struct cxl_hdm *cxlhdm,
 				struct cxl_endpoint_dvsec_info *info);
 int devm_cxl_add_passthrough_decoder(struct cxl_port *port);
diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
index c23b6164e1c0..07c5ac598da1 100644
--- a/drivers/cxl/port.c
+++ b/drivers/cxl/port.c
@@ -60,17 +60,13 @@ static int discover_region(struct device *dev, void *root)
 static int cxl_switch_port_probe(struct cxl_port *port)
 {
 	struct cxl_hdm *cxlhdm;
-	int rc, nr_dports;
-
-	nr_dports = devm_cxl_port_enumerate_dports(port);
-	if (nr_dports < 0)
-		return nr_dports;
+	int rc;
 
-	cxlhdm = devm_cxl_setup_hdm(port, NULL);
-	rc = devm_cxl_enable_hdm(port, cxlhdm);
-	if (rc)
+	rc = devm_cxl_port_enumerate_dports(port);
+	if (rc < 0)
 		return rc;
 
+	cxlhdm = devm_cxl_setup_hdm(port, NULL);
 	if (!IS_ERR(cxlhdm))
 		return devm_cxl_enumerate_decoders(cxlhdm, NULL);
 
@@ -79,7 +75,7 @@ static int cxl_switch_port_probe(struct cxl_port *port)
 		return PTR_ERR(cxlhdm);
 	}
 
-	if (nr_dports == 1) {
+	if (rc == 1) {
 		dev_dbg(&port->dev, "Fallback to passthrough decoder\n");
 		return devm_cxl_add_passthrough_decoder(port);
 	}
diff --git a/tools/testing/cxl/Kbuild b/tools/testing/cxl/Kbuild
index 6f9347ade82c..fba7bec96acd 100644
--- a/tools/testing/cxl/Kbuild
+++ b/tools/testing/cxl/Kbuild
@@ -6,7 +6,6 @@ ldflags-y += --wrap=acpi_pci_find_root
 ldflags-y += --wrap=nvdimm_bus_register
 ldflags-y += --wrap=devm_cxl_port_enumerate_dports
 ldflags-y += --wrap=devm_cxl_setup_hdm
-ldflags-y += --wrap=devm_cxl_enable_hdm
 ldflags-y += --wrap=devm_cxl_add_passthrough_decoder
 ldflags-y += --wrap=devm_cxl_enumerate_decoders
 ldflags-y += --wrap=cxl_await_media_ready
diff --git a/tools/testing/cxl/test/mock.c b/tools/testing/cxl/test/mock.c
index 284416527644..de3933a776fd 100644
--- a/tools/testing/cxl/test/mock.c
+++ b/tools/testing/cxl/test/mock.c
@@ -149,21 +149,6 @@ struct cxl_hdm *__wrap_devm_cxl_setup_hdm(struct cxl_port *port,
 }
 EXPORT_SYMBOL_NS_GPL(__wrap_devm_cxl_setup_hdm, CXL);
 
-int __wrap_devm_cxl_enable_hdm(struct cxl_port *port, struct cxl_hdm *cxlhdm)
-{
-	int index, rc;
-	struct cxl_mock_ops *ops = get_cxl_mock_ops(&index);
-
-	if (ops && ops->is_mock_port(port->uport))
-		rc = 0;
-	else
-		rc = devm_cxl_enable_hdm(port, cxlhdm);
-	put_cxl_mock_ops(index);
-
-	return rc;
-}
-EXPORT_SYMBOL_NS_GPL(__wrap_devm_cxl_enable_hdm, CXL);
-
 int __wrap_devm_cxl_add_passthrough_decoder(struct cxl_port *port)
 {
 	int rc, index;
-- 
2.41.0



