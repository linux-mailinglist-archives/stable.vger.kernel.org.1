Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5303C72C07E
	for <lists+stable@lfdr.de>; Mon, 12 Jun 2023 12:53:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233344AbjFLKxB (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 12 Jun 2023 06:53:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235797AbjFLKwq (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 12 Jun 2023 06:52:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 981751BF0
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 03:37:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2E9FA623F7
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 10:37:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47B4FC4339B;
        Mon, 12 Jun 2023 10:37:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686566228;
        bh=3a3S7E//5RGg3AIUfWREo/KfaGDdWdkOow4ZzeCJryo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rcJmtji04y7ih4dXDyZ151BbdHf8IK13t4lQ0ZJ0vrHzpMv8X29yExQJcAeGvs/+x
         JTM27eK9jp6VPx/egNdIavb4bpOFO7SzJVIwxmWn6Osk+a3NThewiC2RPUPkEbiUW1
         UplFyVR5LkQ4uOGjiEY6cpInyIRl4A2XPJSPnwv8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Qingfang DENG <qingfang.deng@siflower.com.cn>,
        Jakub Kicinski <kuba@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 15/91] neighbour: fix unaligned access to pneigh_entry
Date:   Mon, 12 Jun 2023 12:26:04 +0200
Message-ID: <20230612101702.727875399@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230612101702.085813286@linuxfoundation.org>
References: <20230612101702.085813286@linuxfoundation.org>
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

From: Qingfang DENG <qingfang.deng@siflower.com.cn>

[ Upstream commit ed779fe4c9b5a20b4ab4fd6f3e19807445bb78c7 ]

After the blamed commit, the member key is longer 4-byte aligned. On
platforms that do not support unaligned access, e.g., MIPS32R2 with
unaligned_action set to 1, this will trigger a crash when accessing
an IPv6 pneigh_entry, as the key is cast to an in6_addr pointer.

Change the type of the key to u32 to make it aligned.

Fixes: 62dd93181aaa ("[IPV6] NDISC: Set per-entry is_router flag in Proxy NA.")
Signed-off-by: Qingfang DENG <qingfang.deng@siflower.com.cn>
Link: https://lore.kernel.org/r/20230601015432.159066-1-dqfext@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/neighbour.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/net/neighbour.h b/include/net/neighbour.h
index d5767e25509cc..abb22cfd4827f 100644
--- a/include/net/neighbour.h
+++ b/include/net/neighbour.h
@@ -174,7 +174,7 @@ struct pneigh_entry {
 	struct net_device	*dev;
 	u8			flags;
 	u8			protocol;
-	u8			key[];
+	u32			key[];
 };
 
 /*
-- 
2.39.2



