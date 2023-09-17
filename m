Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD4DC7A3AF0
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 22:11:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240525AbjIQUKt (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 16:10:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240613AbjIQUKe (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 16:10:34 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E99BB5
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 13:10:28 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B756C433C7;
        Sun, 17 Sep 2023 20:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694981428;
        bh=OUKDi2uMrP28Uikek4Ixfzm4Qrx1+nRqC0pIgid3PHc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hZiQTN0TXTreLsE/9zBL5JhlqCbcTlTx2MPJYZzYJQ8K7UKZhxnB1pi4U2N6oY/od
         LpboRlr9CH+rnwZgsjsGodqBOedKJEVIyVesWEExswtIua95xCl7vnT1PcKlys2LWz
         jmpkI5wsN0nsxUv2WXAfI3Saz1uaqPyG7M8vgfdc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        "stable@vger.kernel.org, robh+dt@kernel.org, frowand.list@gmail.com,
        zohar@linux.ibm.com, dmitry.kasatkin@gmail.com,
        devicetree@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, Nathan Chancellor" 
        <nathan@kernel.org>, Rob Herring <robh@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH 5.15 052/511] of: kexec: Mark ima_{free,stable}_kexec_buffer() as __init
Date:   Sun, 17 Sep 2023 21:07:59 +0200
Message-ID: <20230917191115.135922367@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191113.831992765@linuxfoundation.org>
References: <20230917191113.831992765@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nathan Chancellor <nathan@kernel.org>

This commit has no direct upstream equivalent.

After commit d48016d74836 ("mm,ima,kexec,of: use memblock_free_late from
ima_free_kexec_buffer") in 5.15, there is a modpost warning for certain
configurations:

  WARNING: modpost: vmlinux.o(.text+0xb14064): Section mismatch in reference from the function ima_free_kexec_buffer() to the function .init.text:__memblock_free_late()
  The function ima_free_kexec_buffer() references
  the function __init __memblock_free_late().
  This is often because ima_free_kexec_buffer lacks a __init
  annotation or the annotation of __memblock_free_late is wrong.

In mainline, there is no issue because ima_free_kexec_buffer() is marked
as __init, which was done as part of commit b69a2afd5afc ("x86/kexec:
Carry forward IMA measurement log on kexec") in 6.0, which is not
suitable for stable.

Mark ima_free_kexec_buffer() and its single caller
ima_load_kexec_buffer() as __init in 5.15, as ima_load_kexec_buffer() is
only called from ima_init(), which is __init, clearing up the warning.

Signed-off-by: Nathan Chancellor <nathan@kernel.org>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/of/kexec.c                 |    2 +-
 include/linux/of.h                 |    2 +-
 security/integrity/ima/ima.h       |    2 +-
 security/integrity/ima/ima_kexec.c |    2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

--- a/drivers/of/kexec.c
+++ b/drivers/of/kexec.c
@@ -165,7 +165,7 @@ int ima_get_kexec_buffer(void **addr, si
 /**
  * ima_free_kexec_buffer - free memory used by the IMA buffer
  */
-int ima_free_kexec_buffer(void)
+int __init ima_free_kexec_buffer(void)
 {
 	int ret;
 	unsigned long addr;
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -574,7 +574,7 @@ void *of_kexec_alloc_and_setup_fdt(const
 				   unsigned long initrd_len,
 				   const char *cmdline, size_t extra_fdt_size);
 int ima_get_kexec_buffer(void **addr, size_t *size);
-int ima_free_kexec_buffer(void);
+int __init ima_free_kexec_buffer(void);
 #else /* CONFIG_OF */
 
 static inline void of_core_init(void)
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -122,7 +122,7 @@ struct ima_kexec_hdr {
 extern const int read_idmap[];
 
 #ifdef CONFIG_HAVE_IMA_KEXEC
-void ima_load_kexec_buffer(void);
+void __init ima_load_kexec_buffer(void);
 #else
 static inline void ima_load_kexec_buffer(void) {}
 #endif /* CONFIG_HAVE_IMA_KEXEC */
--- a/security/integrity/ima/ima_kexec.c
+++ b/security/integrity/ima/ima_kexec.c
@@ -137,7 +137,7 @@ void ima_add_kexec_buffer(struct kimage
 /*
  * Restore the measurement list from the previous kernel.
  */
-void ima_load_kexec_buffer(void)
+void __init ima_load_kexec_buffer(void)
 {
 	void *kexec_buffer = NULL;
 	size_t kexec_buffer_size = 0;


