Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 934BE6FAB2F
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 13:10:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233445AbjEHLK3 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 07:10:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233379AbjEHLKJ (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 07:10:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4805D33150
        for <stable@vger.kernel.org>; Mon,  8 May 2023 04:10:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D15E062B28
        for <stable@vger.kernel.org>; Mon,  8 May 2023 11:10:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC2ECC433D2;
        Mon,  8 May 2023 11:10:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683544203;
        bh=5reWMY1QyHJiEfO03ZqIWcrgIdzY0sVbUP63ahsyz9c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JJb9Mj1ur9j3SlOuMgcQEFm2qHrX7PRB+7uJGDdgw7XuWAw/JozLFysMuuJgzNoG7
         XoNreg99EQd9rpM+4ipZQ7YutrCK1ukwld92y+8CYoTcuVYAHF9PmvdvHgKm0t67Oa
         ReOIwIv7RbYtqtrOzXLgSvNoTasl2ejgWu8gB7r0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Puranjay Mohan <puranjay12@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 334/694] libbpf: Fix arm syscall regs spec in bpf_tracing.h
Date:   Mon,  8 May 2023 11:42:49 +0200
Message-Id: <20230508094443.286856394@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094432.603705160@linuxfoundation.org>
References: <20230508094432.603705160@linuxfoundation.org>
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

From: Puranjay Mohan <puranjay12@gmail.com>

[ Upstream commit 06943ae675945c762bb8d5edc93d203f2b041d8d ]

The syscall register definitions for ARM in bpf_tracing.h doesn't define
the fifth parameter for the syscalls. Because of this some KPROBES based
selftests fail to compile for ARM architecture.

Define the fifth parameter that is passed in the R5 register (uregs[4]).

Fixes: 3a95c42d65d5 ("libbpf: Define arm syscall regs spec in bpf_tracing.h")
Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Link: https://lore.kernel.org/bpf/20230223095346.10129-1-puranjay12@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/lib/bpf/bpf_tracing.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/lib/bpf/bpf_tracing.h b/tools/lib/bpf/bpf_tracing.h
index 6db88f41fa0df..2cd888733b1c9 100644
--- a/tools/lib/bpf/bpf_tracing.h
+++ b/tools/lib/bpf/bpf_tracing.h
@@ -204,6 +204,7 @@ struct pt_regs___s390 {
 #define __PT_PARM2_SYSCALL_REG __PT_PARM2_REG
 #define __PT_PARM3_SYSCALL_REG __PT_PARM3_REG
 #define __PT_PARM4_SYSCALL_REG __PT_PARM4_REG
+#define __PT_PARM5_SYSCALL_REG uregs[4]
 #define __PT_PARM6_SYSCALL_REG uregs[5]
 #define __PT_PARM7_SYSCALL_REG uregs[6]
 
-- 
2.39.2



