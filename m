Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0F2072C1A7
	for <lists+stable@lfdr.de>; Mon, 12 Jun 2023 12:59:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237253AbjFLK7W (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 12 Jun 2023 06:59:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237303AbjFLK6G (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 12 Jun 2023 06:58:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 600C859CF
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 03:46:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F242362430
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 10:46:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1791CC433D2;
        Mon, 12 Jun 2023 10:46:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686566761;
        bh=vOAd/QHu52Ax9iUKx4WF+I1PJY3jSYueVJ33G+g5WEw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Eqro0vQN7W8B6TdgJ2RXJP5cC3tZ7KXYePybNcGtzh90EfOjEU1FEVWTk41w5zlqG
         5wMFMM80d2I5yRlH9FkEZ73/e5ZVZSr6XEUwZoNWuc1bLw7TLH2yMeOfy4T4qmSoJN
         F9whLN6NglVGGX5+0z/vVKwY0o8nHDRqMQD3LATM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Qingfang DENG <qingfang.deng@siflower.com.cn>,
        Jakub Kicinski <kuba@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 008/160] neighbour: fix unaligned access to pneigh_entry
Date:   Mon, 12 Jun 2023 12:25:40 +0200
Message-ID: <20230612101715.511076386@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230612101715.129581706@linuxfoundation.org>
References: <20230612101715.129581706@linuxfoundation.org>
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
index 2f2a6023fb0e5..94a1599824d8f 100644
--- a/include/net/neighbour.h
+++ b/include/net/neighbour.h
@@ -180,7 +180,7 @@ struct pneigh_entry {
 	netdevice_tracker	dev_tracker;
 	u32			flags;
 	u8			protocol;
-	u8			key[];
+	u32			key[];
 };
 
 /*
-- 
2.39.2



