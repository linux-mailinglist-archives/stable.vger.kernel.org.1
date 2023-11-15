Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E667E7ED12E
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 21:00:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344068AbjKOT77 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:59:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344095AbjKOT74 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:59:56 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEB86B8
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:59:52 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65E82C433C8;
        Wed, 15 Nov 2023 19:59:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700078392;
        bh=vyCDetnyMyyvAKBo8e4Sq6qY0GVBu1Z2TL7UWGAU1qY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CBs5p0TjlYotE8165Xappkw0ZgDJ7gbHMxIEhNee7Ig1iNDp2xFc+Ba/8cIlUtPqX
         Jx09eIseDb5xyOoiQxvs8zglADj8Lia5vK9DSBJrl49iEtY5xj/Jv4P27Vad2TUD4i
         /za1ZQUYFu0RLihW3c7b5IhFL+9EyqoypoiTCT4M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 295/379] powerpc/40x: Remove stale PTE_ATOMIC_UPDATES macro
Date:   Wed, 15 Nov 2023 14:26:10 -0500
Message-ID: <20231115192702.596271968@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115192645.143643130@linuxfoundation.org>
References: <20231115192645.143643130@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

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



