Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02ADC72C00B
	for <lists+stable@lfdr.de>; Mon, 12 Jun 2023 12:49:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234185AbjFLKtY (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 12 Jun 2023 06:49:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234292AbjFLKsz (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 12 Jun 2023 06:48:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AACF25FD8
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 03:33:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E941F614F0
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 10:33:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08969C433EF;
        Mon, 12 Jun 2023 10:33:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686565994;
        bh=3a3S7E//5RGg3AIUfWREo/KfaGDdWdkOow4ZzeCJryo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=grUI7REJWYpDldmSclnVtR2A7SCxhc8GDROg3Zlr8FHk7oVmMfOOTt7mzoRqkTWrm
         Jg44QICVHZ+aN0pLtgqIM6haVLNa95VFAb1Orw31I0fADAwR34X4L/VIdHCIyQdeYm
         ccngs0M4/140a4rT5edZuSeGbwHEF9uIgeRG/hO8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Qingfang DENG <qingfang.deng@siflower.com.cn>,
        Jakub Kicinski <kuba@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 16/68] neighbour: fix unaligned access to pneigh_entry
Date:   Mon, 12 Jun 2023 12:26:08 +0200
Message-ID: <20230612101659.139958640@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230612101658.437327280@linuxfoundation.org>
References: <20230612101658.437327280@linuxfoundation.org>
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



