Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 311DB7BE078
	for <lists+stable@lfdr.de>; Mon,  9 Oct 2023 15:40:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377273AbjJINkd (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 9 Oct 2023 09:40:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377338AbjJINk2 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 9 Oct 2023 09:40:28 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 587CFDF
        for <stable@vger.kernel.org>; Mon,  9 Oct 2023 06:40:26 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AE68C433C8;
        Mon,  9 Oct 2023 13:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696858826;
        bh=lVCTU1sNEAD1R8kU+oqFH0zdItrl2bE4xmQ8Ts6Wy2Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zm20X4/jKc1ueaXdX5BmH/CctmBbW69HwK1tmnuGib2CoZlo8KcQYQ9QL4HJfX5qK
         W1Gj3BhdkK6wUa95egVvQupndQfDO4Hfs8YndIWNOiuPn8ZOrQ4pRp4kaNfxrFXMS+
         QUZjwnfjFjJ0gA/kpPuoCP5VPltWnHxYIeZNyIRk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Helge Deller <deller@gmx.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 112/226] parisc: irq: Make irq_stack_union static to avoid sparse warning
Date:   Mon,  9 Oct 2023 15:01:13 +0200
Message-ID: <20231009130129.708077086@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231009130126.697995596@linuxfoundation.org>
References: <20231009130126.697995596@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Helge Deller <deller@gmx.de>

[ Upstream commit b1bef1388c427cdad7331a9c8eb4ebbbe5b954b0 ]

Signed-off-by: Helge Deller <deller@gmx.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/parisc/kernel/irq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/parisc/kernel/irq.c b/arch/parisc/kernel/irq.c
index 60f5829d476f5..2762e8540672e 100644
--- a/arch/parisc/kernel/irq.c
+++ b/arch/parisc/kernel/irq.c
@@ -388,7 +388,7 @@ union irq_stack_union {
 	volatile unsigned int lock[1];
 };
 
-DEFINE_PER_CPU(union irq_stack_union, irq_stack_union) = {
+static DEFINE_PER_CPU(union irq_stack_union, irq_stack_union) = {
 		.slock = { 1,1,1,1 },
 	};
 #endif
-- 
2.40.1



