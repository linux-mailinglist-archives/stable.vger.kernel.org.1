Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 233A978ABF7
	for <lists+stable@lfdr.de>; Mon, 28 Aug 2023 12:36:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231543AbjH1KgF (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 28 Aug 2023 06:36:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231567AbjH1Kfh (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 28 Aug 2023 06:35:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08458AB
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 03:35:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9A8E563ECD
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 10:35:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A941CC433C7;
        Mon, 28 Aug 2023 10:35:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693218934;
        bh=bqFbwKGVNiVpfqWAFVEAv4ZM+Df/wyi4udTl0wxNEgo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mN9T4B/0zpxXduBDkDODUFRvKrZawYRSkkv6HRqueK6Z54bWLZJSPe9Crab/ZcqPY
         NX5b+qgAuuxilhaAZ4F0peRWUuiHYDXOFOw3lPGj3+/cbboECXfIaZ+wN4vqK5ei/V
         hq8Foi5TNqB+IMEnV5Nz64AqtCm+ElGB5iOEWIjM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 014/158] MIPS: dec: prom: Address -Warray-bounds warning
Date:   Mon, 28 Aug 2023 12:11:51 +0200
Message-ID: <20230828101157.821090122@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230828101157.322319621@linuxfoundation.org>
References: <20230828101157.322319621@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Gustavo A. R. Silva <gustavoars@kernel.org>

[ Upstream commit 7b191b9b55df2a844bd32d1d380f47a7df1c2896 ]

Zero-length arrays are deprecated, and we are replacing them with flexible
array members instead. So, replace zero-length array with flexible-array
member in struct memmap.

Address the following warning found after building (with GCC-13) mips64
with decstation_64_defconfig:
In function 'rex_setup_memory_region',
    inlined from 'prom_meminit' at arch/mips/dec/prom/memory.c:91:3:
arch/mips/dec/prom/memory.c:72:31: error: array subscript i is outside array bounds of 'unsigned char[0]' [-Werror=array-bounds=]
   72 |                 if (bm->bitmap[i] == 0xff)
      |                     ~~~~~~~~~~^~~
In file included from arch/mips/dec/prom/memory.c:16:
./arch/mips/include/asm/dec/prom.h: In function 'prom_meminit':
./arch/mips/include/asm/dec/prom.h:73:23: note: while referencing 'bitmap'
   73 |         unsigned char bitmap[0];

This helps with the ongoing efforts to globally enable -Warray-bounds.

This results in no differences in binary output.

Link: https://github.com/KSPP/linux/issues/79
Link: https://github.com/KSPP/linux/issues/323
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/mips/include/asm/dec/prom.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/include/asm/dec/prom.h b/arch/mips/include/asm/dec/prom.h
index 1e1247add1cf8..908e96e3a3117 100644
--- a/arch/mips/include/asm/dec/prom.h
+++ b/arch/mips/include/asm/dec/prom.h
@@ -70,7 +70,7 @@ static inline bool prom_is_rex(u32 magic)
  */
 typedef struct {
 	int pagesize;
-	unsigned char bitmap[0];
+	unsigned char bitmap[];
 } memmap;
 
 
-- 
2.40.1



