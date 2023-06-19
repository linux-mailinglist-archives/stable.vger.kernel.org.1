Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEBF17353F9
	for <lists+stable@lfdr.de>; Mon, 19 Jun 2023 12:51:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232251AbjFSKu7 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 19 Jun 2023 06:50:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232323AbjFSKuV (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Jun 2023 06:50:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33FE31BC7
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 03:49:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1026C60B5B
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 10:49:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BBCFC433C8;
        Mon, 19 Jun 2023 10:49:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687171784;
        bh=V1F8vLYeUEeXICI3qUJDOaqIMmr5RJhZPTfKHvk7ajI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FV8gO8Qb4CZpXpDOnEs0HMCAh+P+Z9yh3DuhzykqMvSkxsBgMClDBf7pusZY1Zps5
         IBw0cqWv2FfFyJkFQdld7BIuQk22KyC9vH37HY9oVUWd78A5LGD3w1mPgm76NR2AdB
         RtZ7lU+nVLwhBtejKH6Qps3ZK2OVGJOHgOda0+pI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Ben Hutchings <benh@debian.org>,
        Helge Deller <deller@gmx.de>
Subject: [PATCH 6.1 155/166] parisc: Delete redundant register definitions in <asm/assembly.h>
Date:   Mon, 19 Jun 2023 12:30:32 +0200
Message-ID: <20230619102202.209885975@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230619102154.568541872@linuxfoundation.org>
References: <20230619102154.568541872@linuxfoundation.org>
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

From: Ben Hutchings <benh@debian.org>

commit b5b2a02bcaac7c287694aa0db4837a07bf178626 upstream.

We define sp and ipsw in <asm/asmregs.h> using ".reg", and when using
current binutils (snapshot 2.40.50.20230611) the definitions in
<asm/assembly.h> using "=" conflict with those:

arch/parisc/include/asm/assembly.h: Assembler messages:
arch/parisc/include/asm/assembly.h:93: Error: symbol `sp' is already defined
arch/parisc/include/asm/assembly.h:95: Error: symbol `ipsw' is already defined

Delete the duplicate definitions in <asm/assembly.h>.

Also delete the definition of gp, which isn't used anywhere.

Signed-off-by: Ben Hutchings <benh@debian.org>
Cc: stable@vger.kernel.org # v6.0+
Signed-off-by: Helge Deller <deller@gmx.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/parisc/include/asm/assembly.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/parisc/include/asm/assembly.h b/arch/parisc/include/asm/assembly.h
index 0f0d4a496fef..75677b526b2b 100644
--- a/arch/parisc/include/asm/assembly.h
+++ b/arch/parisc/include/asm/assembly.h
@@ -90,10 +90,6 @@
 #include <asm/asmregs.h>
 #include <asm/psw.h>
 
-	sp	=	30
-	gp	=	27
-	ipsw	=	22
-
 	/*
 	 * We provide two versions of each macro to convert from physical
 	 * to virtual and vice versa. The "_r1" versions take one argument
-- 
2.41.0



