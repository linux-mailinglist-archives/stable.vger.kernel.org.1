Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 225AD73E93E
	for <lists+stable@lfdr.de>; Mon, 26 Jun 2023 20:34:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232280AbjFZSeA (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 26 Jun 2023 14:34:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232284AbjFZSd7 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 26 Jun 2023 14:33:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1721FDA
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 11:33:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9682A60F40
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 18:33:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4E0DC433C0;
        Mon, 26 Jun 2023 18:33:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687804436;
        bh=s91xc+b49aRIeahADLlpFRGHjYPIxXCRT0Db06lUIgI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=f+4JKL6L1h2dJW3H085hkmB+QesE8bGefpkbPBJZw1xro4hSQLbUyX8I75B3tErNJ
         9q8D/azD1iYQrKS9bkoSRIbREHzP59pftHkrN9CcvzksWyhDzr6vQs4Qek1fXoawMk
         J/mnaxEJ6pjiowVJi0mB7T8+e/spMIyxvbU63Qpc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 156/170] s390/purgatory: disable branch profiling
Date:   Mon, 26 Jun 2023 20:12:05 +0200
Message-ID: <20230626180807.475253438@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230626180800.476539630@linuxfoundation.org>
References: <20230626180800.476539630@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Alexander Gordeev <agordeev@linux.ibm.com>

[ Upstream commit 03c5c83b70dca3729a3eb488e668e5044bd9a5ea ]

Avoid linker error for randomly generated config file that
has CONFIG_BRANCH_PROFILE_NONE enabled and make it similar
to riscv, x86 and also to commit 4bf3ec384edf ("s390: disable
branch profiling for vdso").

Reviewed-by: Vasily Gorbik <gor@linux.ibm.com>
Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/s390/purgatory/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/s390/purgatory/Makefile b/arch/s390/purgatory/Makefile
index d237bc6841cb8..4cbf306b8181f 100644
--- a/arch/s390/purgatory/Makefile
+++ b/arch/s390/purgatory/Makefile
@@ -26,6 +26,7 @@ KBUILD_CFLAGS += -Wno-pointer-sign -Wno-sign-compare
 KBUILD_CFLAGS += -fno-zero-initialized-in-bss -fno-builtin -ffreestanding
 KBUILD_CFLAGS += -c -MD -Os -m64 -msoft-float -fno-common
 KBUILD_CFLAGS += -fno-stack-protector
+KBUILD_CFLAGS += -DDISABLE_BRANCH_PROFILING
 KBUILD_CFLAGS += $(CLANG_FLAGS)
 KBUILD_CFLAGS += $(call cc-option,-fno-PIE)
 KBUILD_AFLAGS := $(filter-out -DCC_USING_EXPOLINE,$(KBUILD_AFLAGS))
-- 
2.39.2



