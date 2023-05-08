Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA8B76FA43C
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 11:56:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233354AbjEHJ4x (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 05:56:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233828AbjEHJ4j (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 05:56:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02C892B160
        for <stable@vger.kernel.org>; Mon,  8 May 2023 02:56:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7627E62244
        for <stable@vger.kernel.org>; Mon,  8 May 2023 09:56:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80415C433D2;
        Mon,  8 May 2023 09:56:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683539792;
        bh=s/J4rBg8YGjib0xac4mmgvSpUwsgiYZs69ikaG2nbAo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=spYObx4tQUzyyjDby++jnSagICBlhPuyKvyD3Gq+lK0xB52UOCFQpXK0/kinN+uch
         zfPQaiwjTbNQzn9GUmj+7DXg/NdS3uygD9AkoGe0qwpxSHQEySSxdciM5NH9BMMqY3
         jHrhJ1BqcrE84RFcwV2UD1wiAQQxTHCc5FOh+PEU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Dave Jiang <dave.jiang@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH 6.1 108/611] cxl/hdm: Fail upon detecting 0-sized decoders
Date:   Mon,  8 May 2023 11:39:10 +0200
Message-Id: <20230508094425.754328177@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094421.513073170@linuxfoundation.org>
References: <20230508094421.513073170@linuxfoundation.org>
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
@@ -214,8 +214,11 @@ static int __cxl_dpa_reserve(struct cxl_
 
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
@@ -268,7 +271,6 @@ static int __cxl_dpa_reserve(struct cxl_
 		cxled->mode = CXL_DECODER_MIXED;
 	}
 
-success:
 	port->hdm_end++;
 	get_device(&cxled->cxld.dev);
 	return 0;
@@ -727,6 +729,13 @@ static int init_hdm_decoder(struct cxl_p
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


