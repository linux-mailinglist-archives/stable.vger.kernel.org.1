Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 613E27CA28E
	for <lists+stable@lfdr.de>; Mon, 16 Oct 2023 10:51:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229848AbjJPIv3 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 16 Oct 2023 04:51:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232953AbjJPIv1 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 16 Oct 2023 04:51:27 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1211E8
        for <stable@vger.kernel.org>; Mon, 16 Oct 2023 01:51:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A5B7C433C8;
        Mon, 16 Oct 2023 08:51:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697446285;
        bh=ppVkYyojaBkwMT7JMrl2dXMdn2aEAzaCHeyU9e9ZNBY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TpHyRJU+BMH4MUIeXbVZ5y5kTGcMjSX6JaiBWb0puyNCfDCrW68oGoMgeO6n8v0IN
         imqt2NIuRYjXQswtgPNzcf3g7e5AKZAPuEEAa3xkJk+aUGBS9YtmdcCh6XR8pld0ja
         c/3ryaQaHc3UOwdo0eoh/Maa43xG5WaXTjweH8ak=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 084/102] powerpc/64e: Fix wrong test in __ptep_test_and_clear_young()
Date:   Mon, 16 Oct 2023 10:41:23 +0200
Message-ID: <20231016083955.933451534@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231016083953.689300946@linuxfoundation.org>
References: <20231016083953.689300946@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Christophe Leroy <christophe.leroy@csgroup.eu>

[ Upstream commit 5ea0bbaa32e8f54e9a57cfee4a3b8769b80be0d2 ]

Commit 45201c879469 ("powerpc/nohash: Remove hash related code from
nohash headers.") replaced:

  if ((pte_val(*ptep) & (_PAGE_ACCESSED | _PAGE_HASHPTE)) == 0)
	return 0;

By:

  if (pte_young(*ptep))
	return 0;

But it should be:

  if (!pte_young(*ptep))
	return 0;

Fix it.

Fixes: 45201c879469 ("powerpc/nohash: Remove hash related code from nohash headers.")
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://msgid.link/8bb7f06494e21adada724ede47a4c3d97e879d40.1695659959.git.christophe.leroy@csgroup.eu
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/include/asm/nohash/64/pgtable.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/nohash/64/pgtable.h b/arch/powerpc/include/asm/nohash/64/pgtable.h
index 2225991c69b55..6ad4714352c7a 100644
--- a/arch/powerpc/include/asm/nohash/64/pgtable.h
+++ b/arch/powerpc/include/asm/nohash/64/pgtable.h
@@ -209,7 +209,7 @@ static inline int __ptep_test_and_clear_young(struct mm_struct *mm,
 {
 	unsigned long old;
 
-	if (pte_young(*ptep))
+	if (!pte_young(*ptep))
 		return 0;
 	old = pte_update(mm, addr, ptep, _PAGE_ACCESSED, 0, 0);
 	return (old & _PAGE_ACCESSED) != 0;
-- 
2.40.1



