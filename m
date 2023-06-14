Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA225713FA0
	for <lists+stable@lfdr.de>; Sun, 28 May 2023 21:47:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231326AbjE1TrV (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 28 May 2023 15:47:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231331AbjE1TrU (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 28 May 2023 15:47:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FE049C
        for <stable@vger.kernel.org>; Sun, 28 May 2023 12:47:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2E4E561FAA
        for <stable@vger.kernel.org>; Sun, 28 May 2023 19:47:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D016C433D2;
        Sun, 28 May 2023 19:47:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685303238;
        bh=f1E0OZKK6d9gSe++Y1lhd+dV8AWB+uRdmXfa7ZE9KBE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aVP0kZzx10zsnG+znA+XoeLyawZd1HMdeKEP4tC6Oe7kkLX0NpcO1DJi/TcjwR3Z4
         dswMwiToHACi/VdJOc574SHNgmmix6TCC79c+Y1EtrZcc2BkdQtViCTW9ffBh16Yoy
         h//rZDHjAcn/mvX/JnwPO1auOPQbbXckBN80agHU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Helge Deller <deller@gmx.de>
Subject: [PATCH 5.10 173/211] parisc: Handle kgdb breakpoints only in kernel context
Date:   Sun, 28 May 2023 20:11:34 +0100
Message-Id: <20230528190847.791049854@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230528190843.514829708@linuxfoundation.org>
References: <20230528190843.514829708@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Helge Deller <deller@gmx.de>

commit 6888ff04e37d01295620a73f3f7efbc79f6ef152 upstream.

The kernel kgdb break instructions should only be handled when running
in kernel context.

Cc: <stable@vger.kernel.org> # v5.4+
Signed-off-by: Helge Deller <deller@gmx.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/parisc/kernel/traps.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/arch/parisc/kernel/traps.c
+++ b/arch/parisc/kernel/traps.c
@@ -305,8 +305,8 @@ static void handle_break(struct pt_regs
 #endif
 
 #ifdef CONFIG_KGDB
-	if (unlikely(iir == PARISC_KGDB_COMPILED_BREAK_INSN ||
-		iir == PARISC_KGDB_BREAK_INSN)) {
+	if (unlikely((iir == PARISC_KGDB_COMPILED_BREAK_INSN ||
+		iir == PARISC_KGDB_BREAK_INSN)) && !user_mode(regs)) {
 		kgdb_handle_exception(9, SIGTRAP, 0, regs);
 		return;
 	}


