Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56FE078AB77
	for <lists+stable@lfdr.de>; Mon, 28 Aug 2023 12:31:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231460AbjH1Kaz (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 28 Aug 2023 06:30:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231483AbjH1Kah (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 28 Aug 2023 06:30:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE6B5AB
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 03:30:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 62E4463CAF
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 10:30:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7632BC433C7;
        Mon, 28 Aug 2023 10:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693218631;
        bh=xhRnyqwG5V+IT/4qcmLSpeSz1eW34O25zGX9HCRRu7k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PFTJ+ziamO7oZ9gpJKYziATmFrX5hWNoaXZOhHqfBYf9kf5fGLCCtRkYundxecm4k
         u1MWk8VKDPi+vMfSLHMzhrTBRWXAqclQ8gHrxreC0vw9GR94Tku+Ts/4aOD+Dsisw8
         wc2dMqZJb3YC8om/ccodGnN5PYCKsZ5GRDcRHJ58=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Jiri Pirko <jiri@nvidia.com>,
        Simon Horman <horms@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 028/122] devlink: add missing unregister linecard notification
Date:   Mon, 28 Aug 2023 12:12:23 +0200
Message-ID: <20230828101157.363418933@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230828101156.480754469@linuxfoundation.org>
References: <20230828101156.480754469@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

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
index 5a4a4b34ac15c..63188d6a50fe9 100644
--- a/net/devlink/leftover.c
+++ b/net/devlink/leftover.c
@@ -9727,6 +9727,7 @@ static void devlink_notify_unregister(struct devlink *devlink)
 	struct devlink_param_item *param_item;
 	struct devlink_trap_item *trap_item;
 	struct devlink_port *devlink_port;
+	struct devlink_linecard *linecard;
 	struct devlink_rate *rate_node;
 	struct devlink_region *region;
 
@@ -9753,6 +9754,8 @@ static void devlink_notify_unregister(struct devlink *devlink)
 
 	list_for_each_entry_reverse(devlink_port, &devlink->port_list, list)
 		devlink_port_notify(devlink_port, DEVLINK_CMD_PORT_DEL);
+	list_for_each_entry_reverse(linecard, &devlink->linecard_list, list)
+		devlink_linecard_notify(linecard, DEVLINK_CMD_LINECARD_DEL);
 	devlink_notify(devlink, DEVLINK_CMD_DEL);
 }
 
-- 
2.40.1



