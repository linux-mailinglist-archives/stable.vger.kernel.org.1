Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADB52703B7D
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 20:03:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243723AbjEOSDd (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 14:03:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244714AbjEOSDJ (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 14:03:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA3EC1EC0D
        for <stable@vger.kernel.org>; Mon, 15 May 2023 11:00:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 11E7963030
        for <stable@vger.kernel.org>; Mon, 15 May 2023 18:00:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16AE5C4339C;
        Mon, 15 May 2023 18:00:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684173627;
        bh=4WNKpJY51Zen0nKoUa08679tEHk7wFaULPhPhN7AHgQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=058wieNPR1Shy4ba2/cXi5Djw0vepcladIG6MgQpJa11Q9trb/A9vac3l7cnlMPBw
         8l609SBLxmKTiA2TwJLdtdyVdONKx2Qe33JSht/NVwHeeR2HtlnzZ//oDTSlSEwnWC
         q6r+B2R4eaiWjN3kRxDNJz9GJZPG0EnIm21EBiD8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Randy Dunlap <rdunlap@infradead.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 155/282] powerpc/mpc512x: fix resource printk format warning
Date:   Mon, 15 May 2023 18:28:53 +0200
Message-Id: <20230515161726.867012373@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161722.146344674@linuxfoundation.org>
References: <20230515161722.146344674@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

[ Upstream commit 7538c97e2b80ff6b7a8ea2ecf16a04355461b439 ]

Use "%pa" format specifier for resource_size_t to avoid a compiler
printk format warning.

../arch/powerpc/platforms/512x/clock-commonclk.c: In function 'mpc5121_clk_provide_backwards_compat':
../arch/powerpc/platforms/512x/clock-commonclk.c:989:44: error: format '%x' expects argument of type 'unsigned int', but argument 4 has type 'resource_size_t' {aka 'long long unsigned int'} [-Werror=format=]
  989 |         snprintf(devname, sizeof(devname), "%08x.%s", res.start, np->name); \
      |                                            ^~~~~~~~~  ~~~~~~~~~
      |                                                          |
      |                                                          resource_size_t {aka long long unsigned int}

Prevents 24 such warnings.

Fixes: 01f25c371658 ("clk: mpc512x: add backwards compat to the CCF code")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://msgid.link/20230223070116.660-2-rdunlap@infradead.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/platforms/512x/clock-commonclk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/512x/clock-commonclk.c b/arch/powerpc/platforms/512x/clock-commonclk.c
index 30342b60aa63f..42c3d40355d90 100644
--- a/arch/powerpc/platforms/512x/clock-commonclk.c
+++ b/arch/powerpc/platforms/512x/clock-commonclk.c
@@ -984,7 +984,7 @@ static void mpc5121_clk_provide_migration_support(void)
 
 #define NODE_PREP do { \
 	of_address_to_resource(np, 0, &res); \
-	snprintf(devname, sizeof(devname), "%08x.%s", res.start, np->name); \
+	snprintf(devname, sizeof(devname), "%pa.%s", &res.start, np->name); \
 } while (0)
 
 #define NODE_CHK(clkname, clkitem, regnode, regflag) do { \
-- 
2.39.2



