Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 755FD7B89E4
	for <lists+stable@lfdr.de>; Wed,  4 Oct 2023 20:30:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244302AbjJDSaU (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 4 Oct 2023 14:30:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244300AbjJDSaT (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Oct 2023 14:30:19 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E04DEAD
        for <stable@vger.kernel.org>; Wed,  4 Oct 2023 11:30:16 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13BB7C433C8;
        Wed,  4 Oct 2023 18:30:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696444216;
        bh=7WEa9AfKJ7B4W0hPt1Fg1/zOSziUqukDkW/UJUD++Yk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jMywL2XFbdOig7P7pBBPzOSSdgSGt68Be3vOSFjekmrrOM9qgPFXmtk4IixFGJpnI
         hvGkRGl6peWqsvzmLyDHGvAEY+VbRxt0j6XPTtaEnhvguo+Y3f/HsKCrBvaxZeXQ/j
         Hpg85cQjA0VbbQzMl/ypUB0D15gpG94wzLda2WYM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Helge Deller <deller@gmx.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 171/321] parisc: irq: Make irq_stack_union static to avoid sparse warning
Date:   Wed,  4 Oct 2023 19:55:16 +0200
Message-ID: <20231004175237.179543518@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231004175229.211487444@linuxfoundation.org>
References: <20231004175229.211487444@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Helge Deller <deller@gmx.de>

[ Upstream commit b1bef1388c427cdad7331a9c8eb4ebbbe5b954b0 ]

Signed-off-by: Helge Deller <deller@gmx.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/parisc/kernel/irq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/parisc/kernel/irq.c b/arch/parisc/kernel/irq.c
index 12c4d4104ade4..2f81bfd4f15e1 100644
--- a/arch/parisc/kernel/irq.c
+++ b/arch/parisc/kernel/irq.c
@@ -365,7 +365,7 @@ union irq_stack_union {
 	volatile unsigned int lock[1];
 };
 
-DEFINE_PER_CPU(union irq_stack_union, irq_stack_union) = {
+static DEFINE_PER_CPU(union irq_stack_union, irq_stack_union) = {
 		.slock = { 1,1,1,1 },
 	};
 #endif
-- 
2.40.1



