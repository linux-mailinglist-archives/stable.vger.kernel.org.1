Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29A517A7FF5
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 14:31:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234690AbjITMbo (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 08:31:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236105AbjITMbn (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 08:31:43 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB66C9E
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 05:31:37 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6CEBC433C7;
        Wed, 20 Sep 2023 12:31:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695213097;
        bh=7IEZCg2MkSoTzyOT7VPhPHTbsXYohaioKg8rdfAgFww=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RhOC1V1vD1Zi1L9r/wJyewoH4dBvy+3R9DJnQWerQjlssI877Phd/epaf9KbVPGQ4
         y6+KO86HyR//j4U4fV4JVRw23T6FkYzKto6+rPWCTGqzBh+YCqjDaUIvSKmj4rbfGq
         6WVIRlGyncOUhQp6DmALSdZo6A9w+7hVkCwZ/hbk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 152/367] media: v4l2-core: Fix a potential resource leak in v4l2_fwnode_parse_link()
Date:   Wed, 20 Sep 2023 13:28:49 +0200
Message-ID: <20230920112902.596439597@linuxfoundation.org>
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

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

[ Upstream commit d7b13edd4cb4bfa335b6008ab867ac28582d3e5c ]

If fwnode_graph_get_remote_endpoint() fails, 'fwnode' is known to be NULL,
so fwnode_handle_put() is a no-op.

Release the reference taken from a previous fwnode_graph_get_port_parent()
call instead.

Also handle fwnode_graph_get_port_parent() failures.

In order to fix these issues, add an error handling path to the function
and the needed gotos.

Fixes: ca50c197bd96 ("[media] v4l: fwnode: Support generic fwnode for parsing standardised properties")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/v4l2-core/v4l2-fwnode.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/media/v4l2-core/v4l2-fwnode.c b/drivers/media/v4l2-core/v4l2-fwnode.c
index 56aad92b80fc9..00d66495b47d7 100644
--- a/drivers/media/v4l2-core/v4l2-fwnode.c
+++ b/drivers/media/v4l2-core/v4l2-fwnode.c
@@ -570,18 +570,28 @@ int v4l2_fwnode_parse_link(struct fwnode_handle *fwnode,
 	fwnode_graph_parse_endpoint(fwnode, &fwep);
 	link->local_port = fwep.port;
 	link->local_node = fwnode_graph_get_port_parent(fwnode);
+	if (!link->local_node)
+		return -ENOLINK;
 
 	fwnode = fwnode_graph_get_remote_endpoint(fwnode);
-	if (!fwnode) {
-		fwnode_handle_put(fwnode);
-		return -ENOLINK;
-	}
+	if (!fwnode)
+		goto err_put_local_node;
 
 	fwnode_graph_parse_endpoint(fwnode, &fwep);
 	link->remote_port = fwep.port;
 	link->remote_node = fwnode_graph_get_port_parent(fwnode);
+	if (!link->remote_node)
+		goto err_put_remote_endpoint;
 
 	return 0;
+
+err_put_remote_endpoint:
+	fwnode_handle_put(fwnode);
+
+err_put_local_node:
+	fwnode_handle_put(link->local_node);
+
+	return -ENOLINK;
 }
 EXPORT_SYMBOL_GPL(v4l2_fwnode_parse_link);
 
-- 
2.40.1



