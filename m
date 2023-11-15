Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90ED37ED41E
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 21:56:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344523AbjKOU44 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 15:56:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344545AbjKOU4y (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 15:56:54 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E271F198
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 12:56:50 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D2B5C4E77A;
        Wed, 15 Nov 2023 20:56:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700081810;
        bh=WJSn6gn4D/x3sDcamz+/W3VgGbxxgb7KwYcKs1uHc54=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vz1isihOl6yyqfQaOTt7j9RFZJb5oPzjgQ1++9JqJ7FXf37NJzMON/snAvY+8bFIy
         MemSOj4TvqQ8hX2PRKAzdQG94Yv3q97iHYM2LpBRoWPf0oNBdsgy59D0qbbwjq7FDX
         /MNCr/sdX0cJGPly8jQPUD8hs2ezcO4M88yHkYfU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 140/191] powerpc/40x: Remove stale PTE_ATOMIC_UPDATES macro
Date:   Wed, 15 Nov 2023 15:46:55 -0500
Message-ID: <20231115204652.912117964@linuxfoundation.org>
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

From: Christophe Leroy <christophe.leroy@csgroup.eu>

[ Upstream commit cc8ee288f484a2a59c01ccd4d8a417d6ed3466e3 ]

40x TLB handlers were reworked by commit 2c74e2586bb9 ("powerpc/40x:
Rework 40x PTE access and TLB miss") to not require PTE_ATOMIC_UPDATES
anymore.

Then commit 4e1df545e2fa ("powerpc/pgtable: Drop PTE_ATOMIC_UPDATES")
removed all code related to PTE_ATOMIC_UPDATES.

Remove left over PTE_ATOMIC_UPDATES macro.

Fixes: 2c74e2586bb9 ("powerpc/40x: Rework 40x PTE access and TLB miss")
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://msgid.link/f061db5857fcd748f84a6707aad01754686ce97e.1695659959.git.christophe.leroy@csgroup.eu
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/include/asm/nohash/32/pte-40x.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/powerpc/include/asm/nohash/32/pte-40x.h b/arch/powerpc/include/asm/nohash/32/pte-40x.h
index 2d3153cfc0d79..acf61242e85bf 100644
--- a/arch/powerpc/include/asm/nohash/32/pte-40x.h
+++ b/arch/powerpc/include/asm/nohash/32/pte-40x.h
@@ -69,9 +69,6 @@
 
 #define _PTE_NONE_MASK	0
 
-/* Until my rework is finished, 40x still needs atomic PTE updates */
-#define PTE_ATOMIC_UPDATES	1
-
 #define _PAGE_BASE_NC	(_PAGE_PRESENT | _PAGE_ACCESSED)
 #define _PAGE_BASE	(_PAGE_BASE_NC)
 
-- 
2.42.0



