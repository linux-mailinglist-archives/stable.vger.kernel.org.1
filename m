Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1A7978EB83
	for <lists+stable@lfdr.de>; Thu, 31 Aug 2023 13:11:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345907AbjHaLLD (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 31 Aug 2023 07:11:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345892AbjHaLLC (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 31 Aug 2023 07:11:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0066E7A
        for <stable@vger.kernel.org>; Thu, 31 Aug 2023 04:10:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 20DED63AC2
        for <stable@vger.kernel.org>; Thu, 31 Aug 2023 11:10:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3436FC433C7;
        Thu, 31 Aug 2023 11:10:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693480214;
        bh=zPpv2aLu7jJw0RdUThs9LWQkmbVKExbqEehY2Tzcio8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Viw1c0QT7HgbkACzgCo53hyyBs5hByhEYqCkC9Rvr7EO5yMU5wDOrJbR5IEowtt3K
         e/WA9pGAxgXr6waf4w7tda/1bpTl/2/snI5TDhV9ZXFJqARKF6hlIK1zQcH10s3Ikv
         ybCOV3vS+x4Dm+9FWLw0bBGEsMNi8CUSohRAiKLA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, YueHaibing <yuehaibing@huawei.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 5.4 2/3] powerpc/pmac/smp: Drop unnecessary volatile qualifier
Date:   Thu, 31 Aug 2023 13:09:56 +0200
Message-ID: <20230831110828.977406916@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230831110828.874071888@linuxfoundation.org>
References: <20230831110828.874071888@linuxfoundation.org>
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

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: YueHaibing <yuehaibing@huawei.com>

commit a4037d1f1fc4e92b69d7196d4568c33078d465ea upstream.

core99_l2_cache/core99_l3_cache do not need to be marked as volatile,
remove it.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://lore.kernel.org/r/20200303085604.24952-1-yuehaibing@huawei.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/powerpc/platforms/powermac/smp.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/arch/powerpc/platforms/powermac/smp.c
+++ b/arch/powerpc/platforms/powermac/smp.c
@@ -664,8 +664,8 @@ static void core99_init_caches(int cpu)
 {
 #ifndef CONFIG_PPC64
 	/* L2 and L3 cache settings to pass from CPU0 to CPU1 on G4 cpus */
-	volatile static long int core99_l2_cache;
-	volatile static long int core99_l3_cache;
+	static long int core99_l2_cache;
+	static long int core99_l3_cache;
 
 	if (!cpu_has_feature(CPU_FTR_L2CR))
 		return;


