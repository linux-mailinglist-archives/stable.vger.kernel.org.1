Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA4C179B395
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:00:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350399AbjIKVh5 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 17:37:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239161AbjIKONU (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:13:20 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E8E4DE
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:13:16 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86E45C433C8;
        Mon, 11 Sep 2023 14:13:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694441595;
        bh=AbwiWjaYMsJfe0YQua/ztPzpdSU4H0GAbpUqpa21mlE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kFt+nnJE6XwT8FuSm8XY/VjKfNEPkCB/qv7jjHTZz+aUS5GbouaiiELPstTj2Srwq
         DZRQoyvqw+lCEF+ebnsmqZ1RfBS0Mzyj7Ky/pno/fEqXYtDXCimkmRflKXK7RbUT4O
         zbyz/u1+XXXVfS8UFZaKrbLQN/ASFQFcbJQKbocM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Nicholas Piggin <npiggin@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 437/739] powerpc/pseries: Fix hcall tracepoints with JUMP_LABEL=n
Date:   Mon, 11 Sep 2023 15:43:56 +0200
Message-ID: <20230911134703.376877620@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134650.921299741@linuxfoundation.org>
References: <20230911134650.921299741@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nicholas Piggin <npiggin@gmail.com>

[ Upstream commit 750bd41aeaeb1f0e0128aa4f8fcd6dd759713641 ]

With JUMP_LABEL=n, hcall_tracepoint_refcount's address is being tested
instead of its value. This results in the tracing slowpath always being
taken unnecessarily.

Fixes: 9a10ccb29c0a2 ("powerpc/pseries: move hcall_tracepoint_refcount out of .toc")
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://msgid.link/20230509091600.70994-1-npiggin@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/platforms/pseries/hvCall.S | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/platforms/pseries/hvCall.S b/arch/powerpc/platforms/pseries/hvCall.S
index 35254ac7af5ee..ca0674b0b683e 100644
--- a/arch/powerpc/platforms/pseries/hvCall.S
+++ b/arch/powerpc/platforms/pseries/hvCall.S
@@ -91,6 +91,7 @@ BEGIN_FTR_SECTION;						\
 	b	1f;						\
 END_FTR_SECTION(0, 1);						\
 	LOAD_REG_ADDR(r12, hcall_tracepoint_refcount) ;		\
+	ld	r12,0(r12);					\
 	std	r12,32(r1);					\
 	cmpdi	r12,0;						\
 	bne-	LABEL;						\
-- 
2.40.1



