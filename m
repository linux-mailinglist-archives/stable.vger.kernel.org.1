Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C69578EBAA
	for <lists+stable@lfdr.de>; Thu, 31 Aug 2023 13:12:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243187AbjHaLMR (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 31 Aug 2023 07:12:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245399AbjHaLMR (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 31 Aug 2023 07:12:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B28D5E59
        for <stable@vger.kernel.org>; Thu, 31 Aug 2023 04:11:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 610EAB82267
        for <stable@vger.kernel.org>; Thu, 31 Aug 2023 11:11:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA876C433C7;
        Thu, 31 Aug 2023 11:11:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693480316;
        bh=j9XrFukAp2D852mbojUYYSmsaf4gpZoGtBlPSaQBFlE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XehSh6AC3eXTL7LFi5NX+IUC7z8jf5iA9CsspLlGWySOufhtXyemqkO5x32ShvArn
         HZGxZu4ZHOa21S3Aa0/nTziN0oDivwkp9iuWQWdi/ppy1J6r6smsWQ+/6ylQfz7fYs
         00XyKzDM0WorSh0XkNq8eShQ8iSPg97ladRu1nvs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Adam Johnston <adam.johnston@arm.com>,
        James Morse <james.morse@arm.com>,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH 6.1 02/10] module: Expose module_init_layout_section()
Date:   Thu, 31 Aug 2023 13:10:42 +0200
Message-ID: <20230831110831.168071019@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230831110831.079963475@linuxfoundation.org>
References: <20230831110831.079963475@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: James Morse <james.morse@arm.com>

commit 2abcc4b5a64a65a2d2287ba0be5c2871c1552416 upstream.

module_init_layout_section() choses whether the core module loader
considers a section as init or not. This affects the placement of the
exit section when module unloading is disabled. This code will never run,
so it can be free()d once the module has been initialised.

arm and arm64 need to count the number of PLTs they need before applying
relocations based on the section name. The init PLTs are stored separately
so they can be free()d. arm and arm64 both use within_module_init() to
decide which list of PLTs to use when applying the relocation.

Because within_module_init()'s behaviour changes when module unloading
is disabled, both architecture would need to take this into account when
counting the PLTs.

Today neither architecture does this, meaning when module unloading is
disabled there are insufficient PLTs in the init section to load some
modules, resulting in warnings:
| WARNING: CPU: 2 PID: 51 at arch/arm64/kernel/module-plts.c:99 module_emit_plt_entry+0x184/0x1cc
| Modules linked in: crct10dif_common
| CPU: 2 PID: 51 Comm: modprobe Not tainted 6.5.0-rc4-yocto-standard-dirty #15208
| Hardware name: QEMU KVM Virtual Machine, BIOS 0.0.0 02/06/2015
| pstate: 20400005 (nzCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
| pc : module_emit_plt_entry+0x184/0x1cc
| lr : module_emit_plt_entry+0x94/0x1cc
| sp : ffffffc0803bba60
[...]
| Call trace:
|  module_emit_plt_entry+0x184/0x1cc
|  apply_relocate_add+0x2bc/0x8e4
|  load_module+0xe34/0x1bd4
|  init_module_from_file+0x84/0xc0
|  __arm64_sys_finit_module+0x1b8/0x27c
|  invoke_syscall.constprop.0+0x5c/0x104
|  do_el0_svc+0x58/0x160
|  el0_svc+0x38/0x110
|  el0t_64_sync_handler+0xc0/0xc4
|  el0t_64_sync+0x190/0x194

Instead of duplicating module_init_layout_section()s logic, expose it.

Reported-by: Adam Johnston <adam.johnston@arm.com>
Fixes: 055f23b74b20 ("module: check for exit sections in layout_sections() instead of module_init_section()")
Cc: stable@vger.kernel.org
Signed-off-by: James Morse <james.morse@arm.com>
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/moduleloader.h |    5 +++++
 kernel/module/main.c         |    2 +-
 2 files changed, 6 insertions(+), 1 deletion(-)

--- a/include/linux/moduleloader.h
+++ b/include/linux/moduleloader.h
@@ -39,6 +39,11 @@ bool module_init_section(const char *nam
  */
 bool module_exit_section(const char *name);
 
+/* Describes whether within_module_init() will consider this an init section
+ * or not. This behaviour changes with CONFIG_MODULE_UNLOAD.
+ */
+bool module_init_layout_section(const char *sname);
+
 /*
  * Apply the given relocation to the (simplified) ELF.  Return -error
  * or 0.
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -1401,7 +1401,7 @@ long module_get_offset(struct module *mo
 	return ret;
 }
 
-static bool module_init_layout_section(const char *sname)
+bool module_init_layout_section(const char *sname)
 {
 #ifndef CONFIG_MODULE_UNLOAD
 	if (module_exit_section(sname))


