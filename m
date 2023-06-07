Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0490726CBA
	for <lists+stable@lfdr.de>; Wed,  7 Jun 2023 22:36:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233975AbjFGUfy (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 7 Jun 2023 16:35:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233966AbjFGUfo (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Jun 2023 16:35:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B61A72128
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 13:35:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 95A9364573
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 20:35:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4ED0C433D2;
        Wed,  7 Jun 2023 20:35:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686170128;
        bh=hD6JmmcmGt9F6GGzY+6zbtcZ7G84QuEkFFvP7ojVP8w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=j42ZGUOHrJjZp0AHs7CGEpgah0bjdFAvryLhA6mKQnqs0XRZ9H1QsuISo3gtGSYb/
         fvsaUL+/TSjcHWJ6q9g9VeTPxlxmmADkd1oj3bvx1zlZ5BjfoAtgGyoG1uAKKa3lu8
         mEtRtLIeHGYxdxM27TBtU0lLNmRKePhc18TrGJAM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, kernel test robot <lkp@intel.com>,
        Min-Hua Chen <minhuadotchen@gmail.com>,
        Will Deacon <will@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 54/88] arm64/mm: mark private VM_FAULT_X defines as vm_fault_t
Date:   Wed,  7 Jun 2023 22:16:11 +0200
Message-ID: <20230607200900.930340957@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230607200854.030202132@linuxfoundation.org>
References: <20230607200854.030202132@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Min-Hua Chen <minhuadotchen@gmail.com>

[ Upstream commit d91d580878064b880f3574ac35b98d8b70ee8620 ]

This patch fixes several sparse warnings for fault.c:

arch/arm64/mm/fault.c:493:24: sparse: warning: incorrect type in return expression (different base types)
arch/arm64/mm/fault.c:493:24: sparse:    expected restricted vm_fault_t
arch/arm64/mm/fault.c:493:24: sparse:    got int
arch/arm64/mm/fault.c:501:32: sparse: warning: incorrect type in return expression (different base types)
arch/arm64/mm/fault.c:501:32: sparse:    expected restricted vm_fault_t
arch/arm64/mm/fault.c:501:32: sparse:    got int
arch/arm64/mm/fault.c:503:32: sparse: warning: incorrect type in return expression (different base types)
arch/arm64/mm/fault.c:503:32: sparse:    expected restricted vm_fault_t
arch/arm64/mm/fault.c:503:32: sparse:    got int
arch/arm64/mm/fault.c:511:24: sparse: warning: incorrect type in return expression (different base types)
arch/arm64/mm/fault.c:511:24: sparse:    expected restricted vm_fault_t
arch/arm64/mm/fault.c:511:24: sparse:    got int
arch/arm64/mm/fault.c:670:13: sparse: warning: restricted vm_fault_t degrades to integer
arch/arm64/mm/fault.c:670:13: sparse: warning: restricted vm_fault_t degrades to integer
arch/arm64/mm/fault.c:713:39: sparse: warning: restricted vm_fault_t degrades to integer

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Min-Hua Chen <minhuadotchen@gmail.com>
Link: https://lore.kernel.org/r/20230502151909.128810-1-minhuadotchen@gmail.com
Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/mm/fault.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index 0d2be8eb87ec8..c9faa5570d245 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -376,8 +376,8 @@ static void do_bad_area(unsigned long addr, unsigned int esr, struct pt_regs *re
 	}
 }
 
-#define VM_FAULT_BADMAP		0x010000
-#define VM_FAULT_BADACCESS	0x020000
+#define VM_FAULT_BADMAP		((__force vm_fault_t)0x010000)
+#define VM_FAULT_BADACCESS	((__force vm_fault_t)0x020000)
 
 static vm_fault_t __do_page_fault(struct mm_struct *mm, unsigned long addr,
 			   unsigned int mm_flags, unsigned long vm_flags,
-- 
2.39.2



