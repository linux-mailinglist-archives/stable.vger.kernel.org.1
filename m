Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03E09775D95
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 13:39:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234154AbjHILjK (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 07:39:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234147AbjHILjJ (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 07:39:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E6E81FD7
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 04:39:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0E22C635DB
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 11:39:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EE66C433C8;
        Wed,  9 Aug 2023 11:39:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691581148;
        bh=2YsowY+ZjkQKN7sO5bqU4qmT5hqnlEUOIZVxQZ0Sq0U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=G4sJu/fiAg58vApL71hCN3O/fEiQ5dahz3pj1F3tA2J7JpR1sQuIV1qKpat86O0Rr
         5zt5YoqKOUckHju3b29eQLTMG4KShS47vHDMu0eAAxMZ4aJ0tFSwCUxJB3yGrADzaz
         HM1OZlQI1eDOqERPB7O8Ao/s/BSosSR+Ja0qQWmo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Masami Hiramatsu <mhiramat@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Li Huafei <lihuafei1@huawei.com>
Subject: [PATCH 5.10 115/201] x86/kprobes: Retrieve correct opcode for group instruction
Date:   Wed,  9 Aug 2023 12:41:57 +0200
Message-ID: <20230809103647.626120665@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809103643.799166053@linuxfoundation.org>
References: <20230809103643.799166053@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Masami Hiramatsu <mhiramat@kernel.org>

[ Upstream commit d60ad3d46f1d04a282c56159f1deb675c12733fd ]

Since the opcodes start from 0xff are group5 instruction group which is
not 2 bytes opcode but the extended opcode determined by the MOD/RM byte.

The commit abd82e533d88 ("x86/kprobes: Do not decode opcode in resume_execution()")
used insn->opcode.bytes[1], but that is not correct. We have to refer
the insn->modrm.bytes[1] instead.

Fixes: abd82e533d88 ("x86/kprobes: Do not decode opcode in resume_execution()")
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/161469872400.49483.18214724458034233166.stgit@devnote2
Signed-off-by: Li Huafei <lihuafei1@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kernel/kprobes/core.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

--- a/arch/x86/kernel/kprobes/core.c
+++ b/arch/x86/kernel/kprobes/core.c
@@ -464,7 +464,11 @@ static void set_resume_flags(struct kpro
 		break;
 #endif
 	case 0xff:
-		opcode = insn->opcode.bytes[1];
+		/*
+		 * Since the 0xff is an extended group opcode, the instruction
+		 * is determined by the MOD/RM byte.
+		 */
+		opcode = insn->modrm.bytes[0];
 		if ((opcode & 0x30) == 0x10) {
 			/*
 			 * call absolute, indirect


