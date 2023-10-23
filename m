Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 699FE7D3394
	for <lists+stable@lfdr.de>; Mon, 23 Oct 2023 13:31:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234088AbjJWLb7 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 23 Oct 2023 07:31:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234089AbjJWLb5 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 23 Oct 2023 07:31:57 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4805DB
        for <stable@vger.kernel.org>; Mon, 23 Oct 2023 04:31:55 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D675BC433C9;
        Mon, 23 Oct 2023 11:31:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698060715;
        bh=h5p4xmQ4wmJMfQeULjNBs70GiN6on0KkZOMZh0OOENo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gDIFpWQvjmw07IE79jjMy+6avusLl4TTb0tiiWnEu99JsETomLQ69QHM/U5V7T78H
         75nTZhs+BQGuNpUmuL9bmRj1VAKtrIANGw+kyTrYUj15W9Ybq/OzZD3nZ1LhpX4lg6
         cm1P/+fCbCM23rcFytYEim6PsK8+5vgxUJiKx+U4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 041/123] powerpc/64e: Fix wrong test in __ptep_test_and_clear_young()
Date:   Mon, 23 Oct 2023 12:56:39 +0200
Message-ID: <20231023104819.103119139@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231023104817.691299567@linuxfoundation.org>
References: <20231023104817.691299567@linuxfoundation.org>
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

5.4-stable review patch.  If anyone has any objections, please let me know.

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
index 9a33b8bd842d9..c32cb88a15750 100644
--- a/arch/powerpc/include/asm/nohash/64/pgtable.h
+++ b/arch/powerpc/include/asm/nohash/64/pgtable.h
@@ -244,7 +244,7 @@ static inline int __ptep_test_and_clear_young(struct mm_struct *mm,
 {
 	unsigned long old;
 
-	if (pte_young(*ptep))
+	if (!pte_young(*ptep))
 		return 0;
 	old = pte_update(mm, addr, ptep, _PAGE_ACCESSED, 0, 0);
 	return (old & _PAGE_ACCESSED) != 0;
-- 
2.40.1



