Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ABC16FAA18
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 12:59:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235382AbjEHK67 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 06:58:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235442AbjEHK6n (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 06:58:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D25030AE3
        for <stable@vger.kernel.org>; Mon,  8 May 2023 03:57:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D76F6629EF
        for <stable@vger.kernel.org>; Mon,  8 May 2023 10:57:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBFEEC433AA;
        Mon,  8 May 2023 10:57:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683543452;
        bh=d9u7KixYQFLZpMdHU5J7ywXcNX2AquLzyQtEbBSO+OQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aKRQAEp6waUPHqjL1rW20bWUk5njDnXjugk6xT0Uc8dxAWcTBu6U/QHpqblYgGhN3
         gdd+PNAUoO01/c1+NuA4W5QPro/bplFsnrot9cnWAGYsC8V5byzOExxd1odOBys65K
         DlJt3u8HmgR3YzbHTjCWmAYzF1OhKOIwwUNZFLhk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH 6.3 095/694] cxl/port: Scan single-target ports for decoders
Date:   Mon,  8 May 2023 11:38:50 +0200
Message-Id: <20230508094435.600164130@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094432.603705160@linuxfoundation.org>
References: <20230508094432.603705160@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Dan Williams <dan.j.williams@intel.com>

commit 7bba261e0aa6e8e5f28a3a3def8338b6512534ee upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/cxl/core/hdm.c |    5 +++--
 drivers/cxl/port.c     |   18 +++++++++++++-----
 2 files changed, 16 insertions(+), 7 deletions(-)

--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -92,8 +92,9 @@ static int map_hdm_decoder_regs(struct c
 
 	cxl_probe_component_regs(&port->dev, crb, &map.component_map);
 	if (!map.component_map.hdm_decoder.valid) {
-		dev_err(&port->dev, "HDM decoder registers invalid\n");
-		return -ENXIO;
+		dev_dbg(&port->dev, "HDM decoder registers not implemented\n");
+		/* unique error code to indicate no HDM decoder capability */
+		return -ENODEV;
 	}
 
 	return cxl_map_component_regs(&port->dev, regs, &map,
--- a/drivers/cxl/port.c
+++ b/drivers/cxl/port.c
@@ -66,14 +66,22 @@ static int cxl_switch_port_probe(struct
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


