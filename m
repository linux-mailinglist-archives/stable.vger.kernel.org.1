Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D365A78EBB0
	for <lists+stable@lfdr.de>; Thu, 31 Aug 2023 13:12:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237024AbjHaLMe (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 31 Aug 2023 07:12:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242572AbjHaLMe (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 31 Aug 2023 07:12:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1A80E58
        for <stable@vger.kernel.org>; Thu, 31 Aug 2023 04:12:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 068A163C11
        for <stable@vger.kernel.org>; Thu, 31 Aug 2023 11:12:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17E28C433C8;
        Thu, 31 Aug 2023 11:12:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693480330;
        bh=PRW5YXXlBRWMKyiU4LyFllrhgIh2cV5Sm1RlS7mKuJA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vE0fpVJVFNgqYzVUcx4XzuZgrQSdjSEp3tGOmjNeRnjhgInbJKWCoZsNZigm7Ytag
         EapS1epLJKraGxlLTEFitloYXY1rMJxS61rGsnKRNIKCdy9clLWEm/bwCYcPhRMwIW
         lQ/D7ZC1FM4VjsGmYTiRFJjQ0fIm1PAqIA9API20=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Helge Deller <deller@gmx.de>
Subject: [PATCH 6.1 08/10] parisc: sys_parisc: parisc_personality() is called from asm code
Date:   Thu, 31 Aug 2023 13:10:48 +0200
Message-ID: <20230831110831.385798018@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230831110831.079963475@linuxfoundation.org>
References: <20230831110831.079963475@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Helge Deller <deller@gmx.de>

commit b5d89408b9fb21258f7c371d6d48a674f60f7181 upstream.

Signed-off-by: Helge Deller <deller@gmx.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/parisc/kernel/sys_parisc.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/arch/parisc/kernel/sys_parisc.c
+++ b/arch/parisc/kernel/sys_parisc.c
@@ -24,6 +24,7 @@
 #include <linux/personality.h>
 #include <linux/random.h>
 #include <linux/compat.h>
+#include <linux/elf-randomize.h>
 
 /*
  * Construct an artificial page offset for the mapping based on the physical
@@ -339,7 +340,7 @@ asmlinkage long parisc_fallocate(int fd,
 			      ((u64)lenhi << 32) | lenlo);
 }
 
-long parisc_personality(unsigned long personality)
+asmlinkage long parisc_personality(unsigned long personality)
 {
 	long err;
 


