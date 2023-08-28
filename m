Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4833778ACD2
	for <lists+stable@lfdr.de>; Mon, 28 Aug 2023 12:43:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229651AbjH1Kmn (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 28 Aug 2023 06:42:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231945AbjH1KmV (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 28 Aug 2023 06:42:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FD85195
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 03:42:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D9DE7640D8
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 10:42:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED10EC433C8;
        Mon, 28 Aug 2023 10:42:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693219337;
        bh=FHre1k4pz3DXKkesddZrHpQzIo6+Gr6KEwUjnQebgx8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NbEKCfEvUPOy7cRYNpR4m2mgptK2DlMEAUb9Yk8bM5WWCvMzKs4mBak0uaZZLWQ3F
         joN48QKpwM5hBuO3ygD0dsFI3NgKbIPtCWFdYQCuNdFetDvz23CyECOKt8DpLvKK+9
         2/OzyNxSjn4if5r6+wX7N8wS775fMl3GKzr4QFlc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Michael Ellerman <mpe@ellerman.id.au>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.4 130/158] ibmveth: Use dcbf rather than dcbfl
Date:   Mon, 28 Aug 2023 12:13:47 +0200
Message-ID: <20230828101201.828143161@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230828101157.322319621@linuxfoundation.org>
References: <20230828101157.322319621@linuxfoundation.org>
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

From: Michael Ellerman <mpe@ellerman.id.au>

commit bfedba3b2c7793ce127680bc8f70711e05ec7a17 upstream.

When building for power4, newer binutils don't recognise the "dcbfl"
extended mnemonic.

dcbfl RA, RB is equivalent to dcbf RA, RB, 1.

Switch to "dcbf" to avoid the build error.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/ibm/ibmveth.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/ethernet/ibm/ibmveth.c
+++ b/drivers/net/ethernet/ibm/ibmveth.c
@@ -196,7 +196,7 @@ static inline void ibmveth_flush_buffer(
 	unsigned long offset;
 
 	for (offset = 0; offset < length; offset += SMP_CACHE_BYTES)
-		asm("dcbfl %0,%1" :: "b" (addr), "r" (offset));
+		asm("dcbf %0,%1,1" :: "b" (addr), "r" (offset));
 }
 
 /* replenish the buffers for a pool.  note that we don't need to


