Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26B8279BA88
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:11:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240833AbjIKV17 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 17:27:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241955AbjIKPS4 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 11:18:56 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B01FFA
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 08:18:51 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74CD6C433C8;
        Mon, 11 Sep 2023 15:18:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694445530;
        bh=pgA3MA68Rh+S2Bp0iOM9A2/8kKD89lufIfj7Ecs6Mws=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=x2/yUTZ6tK2kTF0JzD7c4lcVTalW4SQpoKUM8SAQbY3wN3z9wHFpCM4vAbMc1SBrH
         IWmwB8qwst3l3UMkToVOEyNbqREMBMwuVtqY1L//fb8RdQDmKyfp0LrsBjDwNPlOAq
         uPIMdW50cSWK50VgS+ZSyIqJ0b3OSD8qPIgz5N4M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Liang He <windhl@126.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 380/600] powerpc/mpc5xxx: Add missing fwnode_handle_put()
Date:   Mon, 11 Sep 2023 15:46:53 +0200
Message-ID: <20230911134644.888020305@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134633.619970489@linuxfoundation.org>
References: <20230911134633.619970489@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Liang He <windhl@126.com>

[ Upstream commit b9bbbf4979073d5536b7650decd37fcb901e6556 ]

In mpc5xxx_fwnode_get_bus_frequency(), we should add
fwnode_handle_put() when break out of the iteration
fwnode_for_each_parent_node() as it will automatically
increase and decrease the refcounter.

Fixes: de06fba62af6 ("powerpc/mpc5xxx: Switch mpc5xxx_get_bus_frequency() to use fwnode")
Signed-off-by: Liang He <windhl@126.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://msgid.link/20230322030423.1855440-1-windhl@126.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/sysdev/mpc5xxx_clocks.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/sysdev/mpc5xxx_clocks.c b/arch/powerpc/sysdev/mpc5xxx_clocks.c
index c5bf7e1b37804..58cee28e23992 100644
--- a/arch/powerpc/sysdev/mpc5xxx_clocks.c
+++ b/arch/powerpc/sysdev/mpc5xxx_clocks.c
@@ -25,8 +25,10 @@ unsigned long mpc5xxx_fwnode_get_bus_frequency(struct fwnode_handle *fwnode)
 
 	fwnode_for_each_parent_node(fwnode, parent) {
 		ret = fwnode_property_read_u32(parent, "bus-frequency", &bus_freq);
-		if (!ret)
+		if (!ret) {
+			fwnode_handle_put(parent);
 			return bus_freq;
+		}
 	}
 
 	return 0;
-- 
2.40.1



