Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40C617ECF40
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:47:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235268AbjKOTrU (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:47:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235263AbjKOTrT (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:47:19 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C2D7AB
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:47:16 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BCA5C433C7;
        Wed, 15 Nov 2023 19:47:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700077635;
        bh=nShVZs+q69FMRGysNgylFDvkBj/s+gEjSvL840s25eE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=X3cryE1SXEjCvfEUOQ9//8jTaM3QGBaBVyAl4Ynl1mWe8d/UoPBty0aHzJzpbEMwU
         it9Z0zaEysFRsziVXVcvpPcqee8bRmKmCK5fn4/11eNuqof9/iRPD8t4c+EW8QpH6M
         3VkdhYyheOKUxGPHEdfld9ast3C0563aBcpYrtOY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
        Daniel Gomez <da.gomez@samsung.com>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Kieran Bingham <kbingham@kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Pankaj Raghav <p.raghav@samsung.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 417/603] scripts/gdb: fix usage of MOD_TEXT not defined when CONFIG_MODULES=n
Date:   Wed, 15 Nov 2023 14:16:02 -0500
Message-ID: <20231115191641.760091643@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115191613.097702445@linuxfoundation.org>
References: <20231115191613.097702445@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Clément Léger <cleger@rivosinc.com>

[ Upstream commit 16501630bdeb107141a0139ddc33f92ab5582c6f ]

MOD_TEXT is only defined if CONFIG_MODULES=y which lead to loading failure
of the gdb scripts when kernel is built without CONFIG_MODULES=y:

Reading symbols from vmlinux...
Traceback (most recent call last):
  File "/foo/vmlinux-gdb.py", line 25, in <module>
    import linux.constants
  File "/foo/scripts/gdb/linux/constants.py", line 14, in <module>
    LX_MOD_TEXT = gdb.parse_and_eval("MOD_TEXT")
                  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
gdb.error: No symbol "MOD_TEXT" in current context.

Add a conditional check on CONFIG_MODULES to fix this error.

Link: https://lkml.kernel.org/r/20231031134848.119391-1-da.gomez@samsung.com
Fixes: b4aff7513df3 ("scripts/gdb: use mem instead of core_layout to get the module address")
Signed-off-by: Clément Léger <cleger@rivosinc.com>
Tested-by: Daniel Gomez <da.gomez@samsung.com>
Signed-off-by: Daniel Gomez <da.gomez@samsung.com>
Cc: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Kieran Bingham <kbingham@kernel.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>
Cc: Pankaj Raghav <p.raghav@samsung.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 scripts/gdb/linux/constants.py.in | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/scripts/gdb/linux/constants.py.in b/scripts/gdb/linux/constants.py.in
index e3517d4ab8ec9..04c87b570aabe 100644
--- a/scripts/gdb/linux/constants.py.in
+++ b/scripts/gdb/linux/constants.py.in
@@ -66,10 +66,11 @@ LX_GDBPARSED(IRQD_LEVEL)
 LX_GDBPARSED(IRQ_HIDDEN)
 
 /* linux/module.h */
-LX_GDBPARSED(MOD_TEXT)
-LX_GDBPARSED(MOD_DATA)
-LX_GDBPARSED(MOD_RODATA)
-LX_GDBPARSED(MOD_RO_AFTER_INIT)
+if IS_BUILTIN(CONFIG_MODULES):
+    LX_GDBPARSED(MOD_TEXT)
+    LX_GDBPARSED(MOD_DATA)
+    LX_GDBPARSED(MOD_RODATA)
+    LX_GDBPARSED(MOD_RO_AFTER_INIT)
 
 /* linux/mount.h */
 LX_VALUE(MNT_NOSUID)
-- 
2.42.0



