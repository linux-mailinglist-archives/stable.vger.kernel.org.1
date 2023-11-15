Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 107107ED4B4
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 21:58:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344766AbjKOU6z (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 15:58:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344619AbjKOU5p (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 15:57:45 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 299171BCD
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 12:57:32 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E58EBC4E67B;
        Wed, 15 Nov 2023 20:50:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700081456;
        bh=CCCv3bsOU59DT3YOAulrZk/ZbrMuyZ7wbMy9bZnkkXM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SpJBRzBi6IrNrsEMmWXcu2hiuwbiKytkqBaLSr0Jx3iRIGsFCeMu7iMV+Ete48j17
         iqvoA3N9JXe2eXuYK3dbZNDKgKwBybM6nO2dKqfJhKtZeXgcLp+xxVGbwmOLYbvtPK
         yOh1useHvUJZBOpc6BMAGL9eq2EMlB5Vxs0c4+w4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Ard Biesheuvel <ardb@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Kursad Oney <kursad.oney@broadcom.com>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 138/244] ARM: 9321/1: memset: cast the constant byte to unsigned char
Date:   Wed, 15 Nov 2023 15:35:30 -0500
Message-ID: <20231115203556.634704177@linuxfoundation.org>
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
index 9817cb258c1a5..0481b9bbbd004 100644
--- a/arch/arm/lib/memset.S
+++ b/arch/arm/lib/memset.S
@@ -17,6 +17,7 @@ ENTRY(__memset)
 ENTRY(mmioset)
 WEAK(memset)
 UNWIND( .fnstart         )
+	and	r1, r1, #255		@ cast to unsigned char
 	ands	r3, r0, #3		@ 1 unaligned?
 	mov	ip, r0			@ preserve r0 as return value
 	bne	6f			@ 1
-- 
2.42.0



