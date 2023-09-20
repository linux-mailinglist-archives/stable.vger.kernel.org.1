Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 883F87A801C
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 14:32:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236152AbjITMdA (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 08:33:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236157AbjITMc7 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 08:32:59 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A44708F
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 05:32:53 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBD6CC433CB;
        Wed, 20 Sep 2023 12:32:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695213173;
        bh=H/uluswX6VBD8pZmXHtuiL+ciWg4T0ow3QvcP5keeSY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Bf/JmPRINkuNFXSia4BBqlxceEwu6GgYP2rYviUS44C/5V8vdCpRcMFoetqAr/CMW
         YmnD65ov3z0c5d3UWWa7JAx4Nc6M8M5T/3yrAjQWp+ifzV6ykGPIpArmlitkMJqWMy
         nLvSHSwd8Nhx1XMjYFChef3B5IL2icJWKztOCR1E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Marco Felsch <m.felsch@pengutronix.de>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 151/367] media: v4l2-fwnode: simplify v4l2_fwnode_parse_link
Date:   Wed, 20 Sep 2023 13:28:48 +0200
Message-ID: <20230920112902.573636741@linuxfoundation.org>
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

[ Upstream commit 507a0ba93aa1cf2837d2abc4ab0cbad3c29409d3 ]

This helper was introduced before those helpers where awailable. Convert
it to cleanup the code and improbe readability.

Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Stable-dep-of: d7b13edd4cb4 ("media: v4l2-core: Fix a potential resource leak in v4l2_fwnode_parse_link()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/v4l2-core/v4l2-fwnode.c | 25 +++++++++----------------
 1 file changed, 9 insertions(+), 16 deletions(-)

diff --git a/drivers/media/v4l2-core/v4l2-fwnode.c b/drivers/media/v4l2-core/v4l2-fwnode.c
index 217d67cb31af2..56aad92b80fc9 100644
--- a/drivers/media/v4l2-core/v4l2-fwnode.c
+++ b/drivers/media/v4l2-core/v4l2-fwnode.c
@@ -560,33 +560,26 @@ int v4l2_fwnode_endpoint_alloc_parse(struct fwnode_handle *fwnode,
 }
 EXPORT_SYMBOL_GPL(v4l2_fwnode_endpoint_alloc_parse);
 
-int v4l2_fwnode_parse_link(struct fwnode_handle *__fwnode,
+int v4l2_fwnode_parse_link(struct fwnode_handle *fwnode,
 			   struct v4l2_fwnode_link *link)
 {
-	const char *port_prop = "reg";
-	struct fwnode_handle *fwnode;
+	struct fwnode_endpoint fwep;
 
 	memset(link, 0, sizeof(*link));
 
-	fwnode = fwnode_get_parent(__fwnode);
-	fwnode_property_read_u32(fwnode, port_prop, &link->local_port);
-	fwnode = fwnode_get_next_parent(fwnode);
-	if (is_of_node(fwnode) && of_node_name_eq(to_of_node(fwnode), "ports"))
-		fwnode = fwnode_get_next_parent(fwnode);
-	link->local_node = fwnode;
+	fwnode_graph_parse_endpoint(fwnode, &fwep);
+	link->local_port = fwep.port;
+	link->local_node = fwnode_graph_get_port_parent(fwnode);
 
-	fwnode = fwnode_graph_get_remote_endpoint(__fwnode);
+	fwnode = fwnode_graph_get_remote_endpoint(fwnode);
 	if (!fwnode) {
 		fwnode_handle_put(fwnode);
 		return -ENOLINK;
 	}
 
-	fwnode = fwnode_get_parent(fwnode);
-	fwnode_property_read_u32(fwnode, port_prop, &link->remote_port);
-	fwnode = fwnode_get_next_parent(fwnode);
-	if (is_of_node(fwnode) && of_node_name_eq(to_of_node(fwnode), "ports"))
-		fwnode = fwnode_get_next_parent(fwnode);
-	link->remote_node = fwnode;
+	fwnode_graph_parse_endpoint(fwnode, &fwep);
+	link->remote_port = fwep.port;
+	link->remote_node = fwnode_graph_get_port_parent(fwnode);
 
 	return 0;
 }
-- 
2.40.1



