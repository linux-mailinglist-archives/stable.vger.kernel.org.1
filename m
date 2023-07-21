Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8CFA75D388
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 21:11:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231854AbjGUTLs (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 15:11:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231855AbjGUTLr (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 15:11:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9010B30E2
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 12:11:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1B5C761D2F
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 19:11:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F609C433C8;
        Fri, 21 Jul 2023 19:11:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689966705;
        bh=hM/GjtUJtB5sdQaHHOKBHqgdX9udWsotpA+gsQRKUeY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2XCYRYUhOwNhwF9W+y1wrD+WMaiOLYRFwxihiBZ95WXOeErdnvaL8Vp6bB601oIIK
         2ldJtVodrEszTpfxeQ5t38oGHzLbLkyrHUmu2okXr3J6LOSSHVVEffZojOQkJVXbbs
         +C5PRZQa45PJPVOgAmgXq923wLhdZG9Jv6CljOv8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Jisheng Zhang <jszhang@kernel.org>,
        kernel test robot <lkp@intel.com>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 437/532] riscv: mm: fix truncation warning on RV32
Date:   Fri, 21 Jul 2023 18:05:41 +0200
Message-ID: <20230721160638.267212451@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230721160614.695323302@linuxfoundation.org>
References: <20230721160614.695323302@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Jisheng Zhang <jszhang@kernel.org>

[ Upstream commit b690e266dae2f85f4dfea21fa6a05e3500a51054 ]

lkp reports below sparse warning when building for RV32:
arch/riscv/mm/init.c:1204:48: sparse: warning: cast truncates bits from
constant value (100000000 becomes 0)

IMO, the reason we didn't see this truncates bug in real world is "0"
means MEMBLOCK_ALLOC_ACCESSIBLE in memblock and there's no RV32 HW
with more than 4GB memory.

Fix it anyway to make sparse happy.

Fixes: decf89f86ecd ("riscv: try to allocate crashkern region from 32bit addressible memory")
Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202306080034.SLiCiOMn-lkp@intel.com/
Link: https://lore.kernel.org/r/20230709171036.1906-1-jszhang@kernel.org
Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/riscv/mm/init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index f8bfbe983517c..d7115acab3501 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -843,7 +843,7 @@ static void __init reserve_crashkernel(void)
 	 */
 	crash_base = memblock_phys_alloc_range(crash_size, PMD_SIZE,
 					       search_start,
-					       min(search_end, (unsigned long) SZ_4G));
+					       min(search_end, (unsigned long)(SZ_4G - 1)));
 	if (crash_base == 0) {
 		/* Try again without restricting region to 32bit addressible memory */
 		crash_base = memblock_phys_alloc_range(crash_size, PMD_SIZE,
-- 
2.39.2



