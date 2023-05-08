Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC7AB6FA6D6
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 12:24:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234571AbjEHKYo (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 06:24:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234341AbjEHKYA (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 06:24:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4B63DD82
        for <stable@vger.kernel.org>; Mon,  8 May 2023 03:23:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3A01F625A4
        for <stable@vger.kernel.org>; Mon,  8 May 2023 10:23:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A59A8C433D2;
        Mon,  8 May 2023 10:23:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683541424;
        bh=ydqqOy8nE5f+6DyKMekGq+xvhigWUAr9WsliuyvSpFU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UQsJpVeXsR3yQ1JFLscOIjHHCYQdEgUvzb6hzoU4qcHlGtsFTsjHWadUwM6c9upBi
         BPs0i4wnNhvFHjcuK1Ole9XU//cDsn55yQepQkM2HYTwVQfWMicfoXLXafFVknW1ws
         VQb34CAtM06SO36B9L//LGgSSMdwdCPcQHVfBkBw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Dave Jiang <dave.jiang@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH 6.2 111/663] cxl/hdm: Fail upon detecting 0-sized decoders
Date:   Mon,  8 May 2023 11:38:57 +0200
Message-Id: <20230508094432.100452689@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094428.384831245@linuxfoundation.org>
References: <20230508094428.384831245@linuxfoundation.org>
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

commit 7701c8bef4f14bd9f7940c6ed0e6a73584115a96 upstream.

Decoders committed with 0-size lead to later crashes on shutdown as
__cxl_dpa_release() assumes a 'struct resource' has been established in
the in 'cxlds->dpa_res'. Just fail the driver load in this instance
since there are deeper problems with the enumeration or the setup when
this happens.

Fixes: 9c57cde0dcbd ("cxl/hdm: Enumerate allocated DPA")
Cc: <stable@vger.kernel.org>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Alison Schofield <alison.schofield@intel.com>
Link: https://lore.kernel.org/r/168149843516.792294.11872242648319572632.stgit@dwillia2-xfh.jf.intel.com
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/cxl/core/hdm.c |   15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -219,8 +219,11 @@ static int __cxl_dpa_reserve(struct cxl_
 
 	lockdep_assert_held_write(&cxl_dpa_rwsem);
 
-	if (!len)
-		goto success;
+	if (!len) {
+		dev_warn(dev, "decoder%d.%d: empty reservation attempted\n",
+			 port->id, cxled->cxld.id);
+		return -EINVAL;
+	}
 
 	if (cxled->dpa_res) {
 		dev_dbg(dev, "decoder%d.%d: existing allocation %pr assigned\n",
@@ -273,7 +276,6 @@ static int __cxl_dpa_reserve(struct cxl_
 		cxled->mode = CXL_DECODER_MIXED;
 	}
 
-success:
 	port->hdm_end++;
 	get_device(&cxled->cxld.dev);
 	return 0;
@@ -732,6 +734,13 @@ static int init_hdm_decoder(struct cxl_p
 				 port->id, cxld->id);
 			return -ENXIO;
 		}
+
+		if (size == 0) {
+			dev_warn(&port->dev,
+				 "decoder%d.%d: Committed with zero size\n",
+				 port->id, cxld->id);
+			return -ENXIO;
+		}
 		port->commit_end = cxld->id;
 	} else {
 		/* unless / until type-2 drivers arrive, assume type-3 */


