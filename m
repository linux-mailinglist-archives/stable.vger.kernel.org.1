Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 950EA703780
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 19:22:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244089AbjEORWA (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 13:22:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244046AbjEORVl (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 13:21:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39B501157F
        for <stable@vger.kernel.org>; Mon, 15 May 2023 10:19:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1AB2B62C4B
        for <stable@vger.kernel.org>; Mon, 15 May 2023 17:19:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0762EC433D2;
        Mon, 15 May 2023 17:19:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684171184;
        bh=/4Cmt3xNe5p47FhOZ2B3mNMwtPAWH2t44j6oe8ANPCs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=I2ER7eymTyLu71mhLJ/tSVvWuuaHWWrPyv8dlVB/AJDJpqadRP5qzV0rAGz3rGBmF
         14zzctc6IV90Nw6V+lNftCQdFxD4rqpvZozU0IMTd0lZHYkmLg4d7IAXzd+BJaz3q4
         H8a7ucMhqksM5RTKNJYEw1ur837fETGKP0lTiwj4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, "Borislav Petkov (AMD)" <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>, stable@kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 6.2 127/242] x86/retbleed: Fix return thunk alignment
Date:   Mon, 15 May 2023 18:27:33 +0200
Message-Id: <20230515161725.712966144@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161721.802179972@linuxfoundation.org>
References: <20230515161721.802179972@linuxfoundation.org>
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

From: Borislav Petkov (AMD) <bp@alien8.de>

commit 9a48d604672220545d209e9996c2a1edbb5637f6 upstream.

SYM_FUNC_START_LOCAL_NOALIGN() adds an endbr leading to this layout
(leaving only the last 2 bytes of the address):

  3bff <zen_untrain_ret>:
  3bff:       f3 0f 1e fa             endbr64
  3c03:       f6                      test   $0xcc,%bl

  3c04 <__x86_return_thunk>:
  3c04:       c3                      ret
  3c05:       cc                      int3
  3c06:       0f ae e8                lfence

However, "the RET at __x86_return_thunk must be on a 64 byte boundary,
for alignment within the BTB."

Use SYM_START instead.

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Cc: <stable@kernel.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/lib/retpoline.S |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/arch/x86/lib/retpoline.S
+++ b/arch/x86/lib/retpoline.S
@@ -144,8 +144,8 @@ SYM_CODE_END(__x86_indirect_jump_thunk_a
  */
 	.align 64
 	.skip 63, 0xcc
-SYM_FUNC_START_NOALIGN(zen_untrain_ret);
-
+SYM_START(zen_untrain_ret, SYM_L_GLOBAL, SYM_A_NONE)
+	ANNOTATE_NOENDBR
 	/*
 	 * As executed from zen_untrain_ret, this is:
 	 *


