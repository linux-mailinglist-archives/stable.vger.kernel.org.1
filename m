Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CF4D7A7FEC
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 14:31:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236081AbjITMbU (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 08:31:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236059AbjITMbT (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 08:31:19 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 532D393
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 05:31:13 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71925C433C8;
        Wed, 20 Sep 2023 12:31:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695213072;
        bh=RsfYrrqWtIU+FIgNXzS8rY/mPpELizKK5k9RaIfScAU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EnIw+XbRhffGOL3G8adtSu+cubx7Zr3NbXyDoEd7gaFogZCVGmWrCg83B70+6UhhR
         FuKa9Ak6nEd44XtxduBA1Zr4RcXEeGO5rT/DA6uJxe2g4H1hwQ3xH8Oez2OUD5Tqg1
         glPgtDgXLXo/0250jIFfbun20rsnzxCgSaQHUNVA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Marco Felsch <m.felsch@pengutronix.de>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 150/367] media: v4l2-fwnode: fix v4l2_fwnode_parse_link handling
Date:   Wed, 20 Sep 2023 13:28:47 +0200
Message-ID: <20230920112902.549708013@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230920112858.471730572@linuxfoundation.org>
References: <20230920112858.471730572@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Marco Felsch <m.felsch@pengutronix.de>

[ Upstream commit 453b0c8304dcbc6eed2836de8fee90bf5bcc7006 ]

Currently the driver differentiate the port number property handling for
ACPI and DT. This is wrong as because ACPI should use the "reg" val too
[1].

[1] https://patchwork.kernel.org/patch/11421985/

Fixes: ca50c197bd96 ("[media] v4l: fwnode: Support generic fwnode for parsing standardised properties")
Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
Acked-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Stable-dep-of: d7b13edd4cb4 ("media: v4l2-core: Fix a potential resource leak in v4l2_fwnode_parse_link()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/v4l2-core/v4l2-fwnode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/v4l2-core/v4l2-fwnode.c b/drivers/media/v4l2-core/v4l2-fwnode.c
index 48c3b9f72722a..217d67cb31af2 100644
--- a/drivers/media/v4l2-core/v4l2-fwnode.c
+++ b/drivers/media/v4l2-core/v4l2-fwnode.c
@@ -563,7 +563,7 @@ EXPORT_SYMBOL_GPL(v4l2_fwnode_endpoint_alloc_parse);
 int v4l2_fwnode_parse_link(struct fwnode_handle *__fwnode,
 			   struct v4l2_fwnode_link *link)
 {
-	const char *port_prop = is_of_node(__fwnode) ? "reg" : "port";
+	const char *port_prop = "reg";
 	struct fwnode_handle *fwnode;
 
 	memset(link, 0, sizeof(*link));
-- 
2.40.1



