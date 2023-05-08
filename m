Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A40876FA9AF
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 12:54:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235280AbjEHKy1 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 06:54:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235290AbjEHKx4 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 06:53:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37E3D2DD70
        for <stable@vger.kernel.org>; Mon,  8 May 2023 03:53:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 171E361572
        for <stable@vger.kernel.org>; Mon,  8 May 2023 10:53:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF0BBC433D2;
        Mon,  8 May 2023 10:53:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683543194;
        bh=W8lqNiXZSDiPJgwfLs3aykEqTVqtcqZXDhKB4Xg3YeI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=s7qiQ5LshMbulegmDEP8rY6qBNpb77MK+YX15kMKt/6/Wg+JLJU+TKFypHO3O6IOx
         z3ZHcP2M4XLo6I9T4eYD+ME4fVR6zwjWp5ciRK2Ul6h5pIv1BIleLuIoXOu/wSvpQD
         FcQOqQVOez4XwKSjfetxN05fbYLkNSNFqZlUIbKI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Danny Tsen <dtsen@linux.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 6.3 003/694] powerpc/boot: Fix boot wrapper code generation with CONFIG_POWER10_CPU
Date:   Mon,  8 May 2023 11:37:18 +0200
Message-Id: <20230508094432.724052536@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094432.603705160@linuxfoundation.org>
References: <20230508094432.603705160@linuxfoundation.org>
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

From: Nicholas Piggin <npiggin@gmail.com>

commit 648a1783fe2551f5a091c9a5f8f463cb2cbf8745 upstream.

-mcpu=power10 will generate prefixed and pcrel code by default, which
we do not support. The general kernel disables these with cflags, but
those were missed for the boot wrapper.

Fixes: 4b2a9315f20d ("powerpc/64s: POWER10 CPU Kconfig build option")
Cc: stable@vger.kernel.org # v6.1+
Reported-by: Danny Tsen <dtsen@linux.ibm.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://msgid.link/20230407040909.230998-1-npiggin@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/powerpc/boot/Makefile |    2 ++
 1 file changed, 2 insertions(+)

--- a/arch/powerpc/boot/Makefile
+++ b/arch/powerpc/boot/Makefile
@@ -34,6 +34,8 @@ endif
 
 BOOTCFLAGS    := -Wall -Wundef -Wstrict-prototypes -Wno-trigraphs \
 		 -fno-strict-aliasing -O2 -msoft-float -mno-altivec -mno-vsx \
+		 $(call cc-option,-mno-prefixed) $(call cc-option,-mno-pcrel) \
+		 $(call cc-option,-mno-mma) \
 		 $(call cc-option,-mno-spe) $(call cc-option,-mspe=no) \
 		 -pipe -fomit-frame-pointer -fno-builtin -fPIC -nostdinc \
 		 $(LINUXINCLUDE)


