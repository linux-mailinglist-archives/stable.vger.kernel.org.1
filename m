Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A80A6FA66C
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 12:19:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234377AbjEHKTb (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 06:19:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234425AbjEHKTU (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 06:19:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9261D855
        for <stable@vger.kernel.org>; Mon,  8 May 2023 03:19:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 40BE6624F1
        for <stable@vger.kernel.org>; Mon,  8 May 2023 10:19:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 512F5C433EF;
        Mon,  8 May 2023 10:19:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683541157;
        bh=W8lqNiXZSDiPJgwfLs3aykEqTVqtcqZXDhKB4Xg3YeI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GnA8nyx5futy6es6gBD3F7cHJaR9XyEk2RhHwJQWjUUKNyk08PxDBaqd2fdublAfz
         BxuLAw+OvsuVUGUeqkMVs47kL/8cX+JaCIiyPhe51mEr4Uazu5ckr9xtoCrzvXOnEw
         mhCRgkaCIUR8WjTcoGxb7PY/xY9dLISuYLDb++zk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Danny Tsen <dtsen@linux.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 6.2 024/663] powerpc/boot: Fix boot wrapper code generation with CONFIG_POWER10_CPU
Date:   Mon,  8 May 2023 11:37:30 +0200
Message-Id: <20230508094429.227794099@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094428.384831245@linuxfoundation.org>
References: <20230508094428.384831245@linuxfoundation.org>
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


