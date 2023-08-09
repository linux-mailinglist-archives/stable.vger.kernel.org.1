Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D324775B28
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 13:14:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233390AbjHILOx (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 07:14:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233392AbjHILOw (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 07:14:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48A5D10F3
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 04:14:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DCFCE63159
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 11:14:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECDE2C433C7;
        Wed,  9 Aug 2023 11:14:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691579691;
        bh=6FMxgJ1s/T9kUA97OsxYGFxf4sgRKGw3uC3xZAKkG7Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KS7PfbUo0ZugOl77cOdGva+AFH7wCCH+1GTTZ4WePGF3FnC4nGeiBPqNRJny7u7ND
         te0au0v1FAFh2MfhVldBKSg4DLSpl2caK7QUKZR1gpbvnSUupytrOp8Jh60f1m9vLz
         vAJG6XokvAyBR2JDlWpoc5oB3ThaoZIt0CElBLd0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Vineet Gupta <vgupta@synopsys.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 082/323] ARCv2: entry: avoid a branch
Date:   Wed,  9 Aug 2023 12:38:40 +0200
Message-ID: <20230809103701.872766574@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809103658.104386911@linuxfoundation.org>
References: <20230809103658.104386911@linuxfoundation.org>
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

From: Vineet Gupta <vgupta@synopsys.com>

[ Upstream commit ab854bfcd310b5872fe12eb8d3f2c30fe427f8f7 ]

Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
Stable-dep-of: 92e2921eeafd ("ARC: define ASM_NL and __ALIGN(_STR) outside #ifdef __ASSEMBLY__ guard")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arc/include/asm/entry-arcv2.h | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/arc/include/asm/entry-arcv2.h b/arch/arc/include/asm/entry-arcv2.h
index 3209a67629606..beaf655666cbd 100644
--- a/arch/arc/include/asm/entry-arcv2.h
+++ b/arch/arc/include/asm/entry-arcv2.h
@@ -100,12 +100,11 @@
 	; 2. Upon entry SP is always saved (for any inspection, unwinding etc),
 	;    but on return, restored only if U mode
 
+	lr	r9, [AUX_USER_SP]			; U mode SP
+
 	mov.nz	r9, sp
 	add.nz	r9, r9, SZ_PT_REGS - PT_sp - 4		; K mode SP
-	bnz	1f
 
-	lr	r9, [AUX_USER_SP]			; U mode SP
-1:
 	PUSH	r9					; SP (pt_regs->sp)
 
 	PUSH	fp
-- 
2.39.2



