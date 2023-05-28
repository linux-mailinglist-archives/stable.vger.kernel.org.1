Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6757F713E6F
	for <lists+stable@lfdr.de>; Sun, 28 May 2023 21:35:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230360AbjE1Tff (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 28 May 2023 15:35:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230367AbjE1Tfe (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 28 May 2023 15:35:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05731F4
        for <stable@vger.kernel.org>; Sun, 28 May 2023 12:35:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8D93561E11
        for <stable@vger.kernel.org>; Sun, 28 May 2023 19:35:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACEEAC433EF;
        Sun, 28 May 2023 19:35:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685302524;
        bh=i+XvamVEAtp7ePMofU3wB+K7KjStmURjyq5IdAbTIPo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aLX25nDKwP9aFRw2xAJ+fcR5BeasUcaB01R15/blXMce8Vp0CQnA3auzW9fyy9/wT
         a9zRwIfnNp7qYHfX2hbRi7ehm7DQmhyNMcBgceTB0uFFyRdXS9r1nxq6bSjOMxyJEf
         YL0X6Y69vU3iKZx1PZR1kzRtKHQsWbnF+CTYpsk8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Helge Deller <deller@gmx.de>
Subject: [PATCH 6.1 037/119] parisc: Handle kprobes breakpoints only in kernel context
Date:   Sun, 28 May 2023 20:10:37 +0100
Message-Id: <20230528190836.608323043@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230528190835.386670951@linuxfoundation.org>
References: <20230528190835.386670951@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Helge Deller <deller@gmx.de>

commit df419492e428b6a2bce98d0f613c58a13da6666c upstream.

The kernel kprobes break instructions should only be handled when running
in kernel context.

Cc: <stable@vger.kernel.org> # v5.18+
Signed-off-by: Helge Deller <deller@gmx.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/parisc/kernel/traps.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/arch/parisc/kernel/traps.c
+++ b/arch/parisc/kernel/traps.c
@@ -291,11 +291,11 @@ static void handle_break(struct pt_regs
 	}
 
 #ifdef CONFIG_KPROBES
-	if (unlikely(iir == PARISC_KPROBES_BREAK_INSN)) {
+	if (unlikely(iir == PARISC_KPROBES_BREAK_INSN && !user_mode(regs))) {
 		parisc_kprobe_break_handler(regs);
 		return;
 	}
-	if (unlikely(iir == PARISC_KPROBES_BREAK_INSN2)) {
+	if (unlikely(iir == PARISC_KPROBES_BREAK_INSN2 && !user_mode(regs))) {
 		parisc_kprobe_ss_handler(regs);
 		return;
 	}


