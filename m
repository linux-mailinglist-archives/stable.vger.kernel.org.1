Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3BB97ED331
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 21:46:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233711AbjKOUqx (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 15:46:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233748AbjKOUqn (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 15:46:43 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50A2BD5A
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 12:46:40 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA280C433C7;
        Wed, 15 Nov 2023 20:46:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700081200;
        bh=bB0Z53as7Zy9bDGgWld0HtHCuWVOX4rrhC9yDuvYtfQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CTOLf5stXs/70FFRNsXd96AzCppMboZsOj1FNDAM6j5XaB4H7Bx1fcUEWjoYvZ5P8
         TjwaPLPyDnz9bu7cInj10He5ut20lzUlqjJTlWt0zKvv/1kedcEoXoozRNNTHac/b2
         wd6yEG0PLRfxGtZF8otFLFFajKGVvpN9V4I12kBg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Yuntao Wang <ytcoode@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 010/244] x86/boot: Fix incorrect startup_gdt_descr.size
Date:   Wed, 15 Nov 2023 15:33:22 -0500
Message-ID: <20231115203548.992188504@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115203548.387164783@linuxfoundation.org>
References: <20231115203548.387164783@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yuntao Wang <ytcoode@gmail.com>

[ Upstream commit 001470fed5959d01faecbd57fcf2f60294da0de1 ]

Since the size value is added to the base address to yield the last valid
byte address of the GDT, the current size value of startup_gdt_descr is
incorrect (too large by one), fix it.

[ mingo: This probably never mattered, because startup_gdt[] is only used
         in a very controlled fashion - but make it consistent nevertheless. ]

Fixes: 866b556efa12 ("x86/head/64: Install startup GDT")
Signed-off-by: Yuntao Wang <ytcoode@gmail.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Link: https://lore.kernel.org/r/20230807084547.217390-1-ytcoode@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kernel/head64.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
index 5036104d54707..2375f5f4f763f 100644
--- a/arch/x86/kernel/head64.c
+++ b/arch/x86/kernel/head64.c
@@ -79,7 +79,7 @@ static struct desc_struct startup_gdt[GDT_ENTRIES] = {
  * while the kernel still uses a direct mapping.
  */
 static struct desc_ptr startup_gdt_descr = {
-	.size = sizeof(startup_gdt),
+	.size = sizeof(startup_gdt)-1,
 	.address = 0,
 };
 
-- 
2.42.0



