Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 950EC703473
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 18:48:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243001AbjEOQsd (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 12:48:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243028AbjEOQs2 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 12:48:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED97C44A8
        for <stable@vger.kernel.org>; Mon, 15 May 2023 09:48:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 80C1662933
        for <stable@vger.kernel.org>; Mon, 15 May 2023 16:48:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72ADBC433D2;
        Mon, 15 May 2023 16:48:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684169299;
        bh=8e4YA33vgLUYXKPtW7j+Y7qdMP1hdQK6O3SG0vW0ssE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HSQiJMGmaaClxRhczrUYGkp8IvPWkQzacEdff9fOj7qtqO/pMMSMC7AZKbkTrl6Bh
         Me64qes18XIGASDOBVqVz1RI8inPDqPEC2ih3LUBf+47Yr0O+x9uCxCp/VZTB5a04f
         s5/jWCPciqi3HVYiidXWkXdF5LAzI1VRcFZboWbs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Will Deacon <will@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 015/246] arm64: Fix label placement in record_mmu_state()
Date:   Mon, 15 May 2023 18:23:47 +0200
Message-Id: <20230515161723.069855342@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161722.610123835@linuxfoundation.org>
References: <20230515161722.610123835@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Neeraj Upadhyay <quic_neeraju@quicinc.com>

[ Upstream commit 4e8f6e44bce8da3b0e2df37b12839f4bc9c9cabe ]

Fix label so that pre_disable_mmu_workaround() is called
before clearing sctlr_el1.M.

Fixes: 2ced0f30a426 ("arm64: head: Switch endianness before populating the ID map")
Signed-off-by: Neeraj Upadhyay <quic_neeraju@quicinc.com>
Acked-by: Ard Biesheuvel <ardb@kernel.org>
Link: https://lore.kernel.org/r/20230425095700.22005-1-quic_neeraju@quicinc.com
Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/kernel/head.S | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index b98970907226b..e92caebff46a0 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -150,8 +150,8 @@ CPU_BE( tbz	x19, #SCTLR_ELx_EE_SHIFT, 1f	)
 	pre_disable_mmu_workaround
 	msr	sctlr_el2, x19
 	b	3f
-	pre_disable_mmu_workaround
-2:	msr	sctlr_el1, x19
+2:	pre_disable_mmu_workaround
+	msr	sctlr_el1, x19
 3:	isb
 	mov	x19, xzr
 	ret
-- 
2.39.2



