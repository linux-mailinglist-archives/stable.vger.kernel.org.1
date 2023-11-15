Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E8447ED639
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 22:52:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344341AbjKOUzy (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 15:55:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343769AbjKOUzt (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 15:55:49 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6B9E11D
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 12:55:44 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45EDCC4E778;
        Wed, 15 Nov 2023 20:55:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700081744;
        bh=SMbD7UXwYagUiU85OI0XcEYegUAJaJiN1KTgglut9DI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Qt9wMKnjQvXkTD6j/o7Weu1thKnaqjQMbxnBep17kzsvyVeDpjsXk3mrE1N7xfd0E
         btfXM8xpM9OB3yZzD4nqtm2M+rA4JhpOtr2WdALnsumBt8JTieF14TiEKtbs53IyUB
         a31KLb4q6Igx9IoCsTx0Y1anarQt9j2sJ2ZIJcE0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Ard Biesheuvel <ardb@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Kursad Oney <kursad.oney@broadcom.com>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 097/191] ARM: 9321/1: memset: cast the constant byte to unsigned char
Date:   Wed, 15 Nov 2023 15:46:12 -0500
Message-ID: <20231115204650.389227320@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115204644.490636297@linuxfoundation.org>
References: <20231115204644.490636297@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kursad Oney <kursad.oney@broadcom.com>

[ Upstream commit c0e824661f443b8cab3897006c1bbc69fd0e7bc4 ]

memset() description in ISO/IEC 9899:1999 (and elsewhere) says:

	The memset function copies the value of c (converted to an
	unsigned char) into each of the first n characters of the
	object pointed to by s.

The kernel's arm32 memset does not cast c to unsigned char. This results
in the following code to produce erroneous output:

	char a[128];
	memset(a, -128, sizeof(a));

This is because gcc will generally emit the following code before
it calls memset() :

	mov   r0, r7
	mvn   r1, #127        ; 0x7f
	bl    00000000 <memset>

r1 ends up with 0xffffff80 before being used by memset() and the
'a' array will have -128 once in every four bytes while the other
bytes will be set incorrectly to -1 like this (printing the first
8 bytes) :

	test_module: -128 -1 -1 -1
	test_module: -1 -1 -1 -128

The change here is to 'and' r1 with 255 before it is used.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reviewed-by: Ard Biesheuvel <ardb@kernel.org>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Kursad Oney <kursad.oney@broadcom.com>
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/lib/memset.S | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/lib/memset.S b/arch/arm/lib/memset.S
index 6ca4535c47fb6..e36d053a8a903 100644
--- a/arch/arm/lib/memset.S
+++ b/arch/arm/lib/memset.S
@@ -16,6 +16,7 @@
 ENTRY(mmioset)
 ENTRY(memset)
 UNWIND( .fnstart         )
+	and	r1, r1, #255		@ cast to unsigned char
 	ands	r3, r0, #3		@ 1 unaligned?
 	mov	ip, r0			@ preserve r0 as return value
 	bne	6f			@ 1
-- 
2.42.0



