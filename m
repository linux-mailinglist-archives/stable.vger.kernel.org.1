Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 908B57B8A17
	for <lists+stable@lfdr.de>; Wed,  4 Oct 2023 20:32:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244353AbjJDScK (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 4 Oct 2023 14:32:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244351AbjJDScK (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Oct 2023 14:32:10 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1C68BF
        for <stable@vger.kernel.org>; Wed,  4 Oct 2023 11:32:06 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F8E5C433C9;
        Wed,  4 Oct 2023 18:32:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696444326;
        bh=AE2jKM4YfL0eyMJKQd1xX7Z1zL5eIgLpYUr9RtNMFi8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mxtYh9FKKOHjgEqUhJ1ggUHK/+CILjEkFcnorbrDWCIIhkPmyW66dyAZ71WOIdfeG
         nkjzJ28ei1ZyilXBQhK1HcGATmsfAr/gnpm4+7Dnfk3NL0EOA4XpCsEgVrCgOWbVew
         5zB8A3ZrIEslG8I9q7PiEz108FTKRsKazVsV/yD0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 182/321] efi/x86: Ensure that EFI_RUNTIME_MAP is enabled for kexec
Date:   Wed,  4 Oct 2023 19:55:27 +0200
Message-ID: <20231004175237.664378430@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231004175229.211487444@linuxfoundation.org>
References: <20231004175229.211487444@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ard Biesheuvel <ardb@kernel.org>

[ Upstream commit aba7e066c738d4b349413a271b2a236aa55bacbc ]

CONFIG_EFI_RUNTIME_MAP needs to be enabled in order for kexec to be able
to provide the required information about the EFI runtime mappings to
the incoming kernel, regardless of whether kexec_load() or
kexec_file_load() is being used. Without this information, kexec boot in
EFI mode is not possible.

The CONFIG_EFI_RUNTIME_MAP option is currently directly configurable if
CONFIG_EXPERT is enabled, so that it can be turned on for debugging
purposes even if KEXEC is not enabled. However, the upshot of this is
that it can also be disabled even when it shouldn't.

So tweak the Kconfig declarations to avoid this situation.

Reported-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index e36261b4ea14f..68ce4f786dcd1 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1955,6 +1955,7 @@ config EFI
 	select UCS2_STRING
 	select EFI_RUNTIME_WRAPPERS
 	select ARCH_USE_MEMREMAP_PROT
+	select EFI_RUNTIME_MAP if KEXEC_CORE
 	help
 	  This enables the kernel to use EFI runtime services that are
 	  available (such as the EFI variable services).
@@ -2030,7 +2031,6 @@ config EFI_MAX_FAKE_MEM
 config EFI_RUNTIME_MAP
 	bool "Export EFI runtime maps to sysfs" if EXPERT
 	depends on EFI
-	default KEXEC_CORE
 	help
 	  Export EFI runtime memory regions to /sys/firmware/efi/runtime-map.
 	  That memory map is required by the 2nd kernel to set up EFI virtual
-- 
2.40.1



