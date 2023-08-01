Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E61F876AEC0
	for <lists+stable@lfdr.de>; Tue,  1 Aug 2023 11:41:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233355AbjHAJl3 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 1 Aug 2023 05:41:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233376AbjHAJlG (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 1 Aug 2023 05:41:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A29D12D72
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 02:38:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0C3B161507
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 09:38:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17F7AC433C7;
        Tue,  1 Aug 2023 09:38:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690882735;
        bh=dapewlmgn1iX7NzDhkWk1UhF7p+4BcincWUQ84QoK8Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CVVkcab/mDsRHa1+uxoFLoGtj9klZqdX32Y7m2lcXsrHxkN2ttLITXcXVm0axl9JO
         PFqlXfUVuCN0ngV2QrZi3Dnl9rosxOiIV1/ctCPKZ3/4ev4a6RcXLHf8hffw6/D3AZ
         xq2DMDU7uwcZLJ3odf6m2wQ5zknJkTKZ3w5HzKj0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Chenguang Zhao <zhaochenguang@kylinos.cn>,
        Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH 6.1 205/228] LoongArch: BPF: Enable bpf_probe_read{, str}() on LoongArch
Date:   Tue,  1 Aug 2023 11:21:03 +0200
Message-ID: <20230801091930.284888819@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230801091922.799813980@linuxfoundation.org>
References: <20230801091922.799813980@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Chenguang Zhao <zhaochenguang@kylinos.cn>

commit de0e30bee86d0f99c696a1fea34474e556a946ec upstream.

Currently nettrace does not work on LoongArch due to missing
bpf_probe_read{,str}() support, with the error message:

     ERROR: failed to load kprobe-based eBPF
     ERROR: failed to load kprobe-based bpf

According to commit 0ebeea8ca8a4d1d ("bpf: Restrict bpf_probe_read{,
str}() only to archs where they work"), we only need to select
CONFIG_ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE to add said support,
because LoongArch does have non-overlapping address ranges for kernel
and userspace.

Cc: stable@vger.kernel.org # 6.1
Signed-off-by: Chenguang Zhao <zhaochenguang@kylinos.cn>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/loongarch/Kconfig |    1 +
 1 file changed, 1 insertion(+)

--- a/arch/loongarch/Kconfig
+++ b/arch/loongarch/Kconfig
@@ -10,6 +10,7 @@ config LOONGARCH
 	select ARCH_ENABLE_MEMORY_HOTPLUG
 	select ARCH_ENABLE_MEMORY_HOTREMOVE
 	select ARCH_HAS_ACPI_TABLE_UPGRADE	if ACPI
+	select ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE
 	select ARCH_HAS_PTE_SPECIAL
 	select ARCH_HAS_TICK_BROADCAST if GENERIC_CLOCKEVENTS_BROADCAST
 	select ARCH_INLINE_READ_LOCK if !PREEMPTION


