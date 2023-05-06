Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCDA76F8FA9
	for <lists+stable@lfdr.de>; Sat,  6 May 2023 09:11:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229906AbjEFHLJ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 6 May 2023 03:11:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjEFHLJ (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 6 May 2023 03:11:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E7CD2D53
        for <stable@vger.kernel.org>; Sat,  6 May 2023 00:11:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DB768616DD
        for <stable@vger.kernel.org>; Sat,  6 May 2023 07:11:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A9A8C433D2;
        Sat,  6 May 2023 07:11:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683357067;
        bh=ZTVM8Yh8Xm5fIeP/12Bv+wWJbFmimDk+JzXj9KfJdXo=;
        h=Subject:To:Cc:From:Date:From;
        b=D3f8JFzf92oR1cMFVve6SnAznGWOcPTtQKX3keDSWSXTe8o/o8pSE5pFtti0IwEx/
         CSqxhWolqrlrdGm6iOJJyoiruY/2bo2KbXq0WE+QEmImMnF3ImUjQLoQWzzhJokUHe
         N+OEzCXrcrN5V3lQHDYZtTjbJEOlVam4zeYaepRs=
Subject: FAILED: patch "[PATCH] cxl/port: Scan single-target ports for decoders" failed to apply to 6.1-stable tree
To:     dan.j.williams@intel.com, Jonathan.Cameron@huawei.com,
        alison.schofield@intel.com, dave.jiang@intel.com,
        stable@vger.kernel.org
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sat, 06 May 2023 15:57:11 +0900
Message-ID: <2023050610-gloater-twitch-f845@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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
git cherry-pick -x 7bba261e0aa6e8e5f28a3a3def8338b6512534ee
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023050610-gloater-twitch-f845@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

7bba261e0aa6 ("cxl/port: Scan single-target ports for decoders")
a5fcd228ca1d ("Merge branch 'for-6.3/cxl-rr-emu' into cxl/next")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 7bba261e0aa6e8e5f28a3a3def8338b6512534ee Mon Sep 17 00:00:00 2001
From: Dan Williams <dan.j.williams@intel.com>
Date: Fri, 14 Apr 2023 11:54:11 -0700
Subject: [PATCH] cxl/port: Scan single-target ports for decoders

Do not assume that a single-target port falls back to a passthrough
decoder configuration. Scan for decoders and only fallback after probing
that the HDM decoder capability is not present.

One user visible affect of this bug is the inability to enumerate
present CXL regions as the decoder settings for the present decoders are
skipped.

Fixes: d17d0540a0db ("cxl/core/hdm: Add CXL standard decoder enumeration to the core")
Reported-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Link: http://lore.kernel.org/r/20230227153128.8164-1-Jonathan.Cameron@huawei.com
Cc: <stable@vger.kernel.org>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Alison Schofield <alison.schofield@intel.com>
Link: https://lore.kernel.org/r/168149845130.792294.3210421233937427962.stgit@dwillia2-xfh.jf.intel.com
Signed-off-by: Dan Williams <dan.j.williams@intel.com>

diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index 6fdf7981ddc7..abe3877cfa63 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -92,8 +92,9 @@ static int map_hdm_decoder_regs(struct cxl_port *port, void __iomem *crb,
 
 	cxl_probe_component_regs(&port->dev, crb, &map.component_map);
 	if (!map.component_map.hdm_decoder.valid) {
-		dev_err(&port->dev, "HDM decoder registers invalid\n");
-		return -ENXIO;
+		dev_dbg(&port->dev, "HDM decoder registers not implemented\n");
+		/* unique error code to indicate no HDM decoder capability */
+		return -ENODEV;
 	}
 
 	return cxl_map_component_regs(&port->dev, regs, &map,
diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
index 22a7ab2bae7c..eb57324c4ad4 100644
--- a/drivers/cxl/port.c
+++ b/drivers/cxl/port.c
@@ -66,14 +66,22 @@ static int cxl_switch_port_probe(struct cxl_port *port)
 	if (rc < 0)
 		return rc;
 
-	if (rc == 1)
-		return devm_cxl_add_passthrough_decoder(port);
-
 	cxlhdm = devm_cxl_setup_hdm(port, NULL);
-	if (IS_ERR(cxlhdm))
+	if (!IS_ERR(cxlhdm))
+		return devm_cxl_enumerate_decoders(cxlhdm, NULL);
+
+	if (PTR_ERR(cxlhdm) != -ENODEV) {
+		dev_err(&port->dev, "Failed to map HDM decoder capability\n");
 		return PTR_ERR(cxlhdm);
+	}
+
+	if (rc == 1) {
+		dev_dbg(&port->dev, "Fallback to passthrough decoder\n");
+		return devm_cxl_add_passthrough_decoder(port);
+	}
 
-	return devm_cxl_enumerate_decoders(cxlhdm, NULL);
+	dev_err(&port->dev, "HDM decoder capability not found\n");
+	return -ENXIO;
 }
 
 static int cxl_endpoint_port_probe(struct cxl_port *port)

