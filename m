Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9754A79AD4F
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 01:39:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348735AbjIKVad (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 17:30:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241954AbjIKPSw (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 11:18:52 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A18EFA
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 08:18:48 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4EDCC433C8;
        Mon, 11 Sep 2023 15:18:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694445528;
        bh=tIGQ3zOs2/+RBI6Z6/VwcDlN1+uiVLed1A5nyT5scik=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zHi1HegtLri1oA03dJtQAT+Hp5p438ln7chXdVRVyKz5rtzVHuhvDflSIZ5cnOn3N
         Dxsi9e9xoq9U34JsL30tXD6p200Y/Zw+6hL60LAgg3YMMsPBtpCxyPERdFt81/nZw8
         pe2No/x3lK9DpNDF4Yjne8lx9sa4k5196CZdjPPU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Nicholas Piggin <npiggin@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 379/600] powerpc/pseries: Fix hcall tracepoints with JUMP_LABEL=n
Date:   Mon, 11 Sep 2023 15:46:52 +0200
Message-ID: <20230911134644.859913570@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134633.619970489@linuxfoundation.org>
References: <20230911134633.619970489@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

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
index 762eb15d3bd42..fc50b9c27c1ba 100644
--- a/arch/powerpc/platforms/pseries/hvCall.S
+++ b/arch/powerpc/platforms/pseries/hvCall.S
@@ -89,6 +89,7 @@ BEGIN_FTR_SECTION;						\
 	b	1f;						\
 END_FTR_SECTION(0, 1);						\
 	LOAD_REG_ADDR(r12, hcall_tracepoint_refcount) ;		\
+	ld	r12,0(r12);					\
 	std	r12,32(r1);					\
 	cmpdi	r12,0;						\
 	bne-	LABEL;						\
-- 
2.40.1



