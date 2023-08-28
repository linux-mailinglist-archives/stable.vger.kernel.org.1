Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D81B78AA11
	for <lists+stable@lfdr.de>; Mon, 28 Aug 2023 12:19:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230133AbjH1KSj (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 28 Aug 2023 06:18:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231136AbjH1KSL (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 28 Aug 2023 06:18:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7595119
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 03:18:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C86DE63779
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 10:18:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA7FFC433C8;
        Mon, 28 Aug 2023 10:18:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693217883;
        bh=7P6cFtPZZb6mbs/rs88B0AtWf7SsqBVhQuNoN6P2B6U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qrJlbYVR3rOXgsE1jcdvf8+2xO9IQG4ZW5T9oKnhSz9xDgyOJcFHRt773jfKuXzwn
         3Uv5nqI4QctZ45vVUCYfrj2M1/CrC55rtkBUyxXus0M8mXL4sHuBKfQbK+Mu5ic/Ir
         Oi9f9hJJKoXAtTbUOYnHh+2HGDeH5jzorFp9MGTQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Jiri Pirko <jiri@nvidia.com>,
        Simon Horman <horms@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 017/129] devlink: add missing unregister linecard notification
Date:   Mon, 28 Aug 2023 12:11:36 +0200
Message-ID: <20230828101157.967073403@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230828101157.383363777@linuxfoundation.org>
References: <20230828101157.383363777@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jiri Pirko <jiri@nvidia.com>

[ Upstream commit 2ebbc9752d06bb1d01201fe632cb6da033b0248d ]

Cited fixes commit introduced linecard notifications for register,
however it didn't add them for unregister. Fix that by adding them.

Fixes: c246f9b5fd61 ("devlink: add support to create line card and expose to user")
Signed-off-by: Jiri Pirko <jiri@nvidia.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://lore.kernel.org/r/20230817125240.2144794-1-jiri@resnulli.us
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/devlink/leftover.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/devlink/leftover.c b/net/devlink/leftover.c
index 790e61b2a9404..6ef6090eeffe5 100644
--- a/net/devlink/leftover.c
+++ b/net/devlink/leftover.c
@@ -6739,6 +6739,7 @@ void devlink_notify_unregister(struct devlink *devlink)
 	struct devlink_param_item *param_item;
 	struct devlink_trap_item *trap_item;
 	struct devlink_port *devlink_port;
+	struct devlink_linecard *linecard;
 	struct devlink_rate *rate_node;
 	struct devlink_region *region;
 	unsigned long port_index;
@@ -6767,6 +6768,8 @@ void devlink_notify_unregister(struct devlink *devlink)
 
 	xa_for_each(&devlink->ports, port_index, devlink_port)
 		devlink_port_notify(devlink_port, DEVLINK_CMD_PORT_DEL);
+	list_for_each_entry_reverse(linecard, &devlink->linecard_list, list)
+		devlink_linecard_notify(linecard, DEVLINK_CMD_LINECARD_DEL);
 	devlink_notify(devlink, DEVLINK_CMD_DEL);
 }
 
-- 
2.40.1



