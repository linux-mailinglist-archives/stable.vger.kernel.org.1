Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 391CF6FAE44
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 13:43:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236147AbjEHLnM (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 07:43:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236149AbjEHLmm (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 07:42:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93739106DD
        for <stable@vger.kernel.org>; Mon,  8 May 2023 04:42:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7370E635A6
        for <stable@vger.kernel.org>; Mon,  8 May 2023 11:42:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D1DBC433EF;
        Mon,  8 May 2023 11:42:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683546129;
        bh=0oGm11D0PIbWTxsNcfMSl4OkxvvJn+/xNKnxpwoZmJA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bSSNBnYjrwLfAWZTiKsGQsY2g4r1d22XuuS2b5efyzZ1iqaeZkud3XM7eZsFS79Gw
         qbYQ/vws10kSclKMwc5pLXUK3lljB5gxTzKmu7lwJ6y4aK6M6jOzbieNCzg36cDvGZ
         Tpj3lCGplMuyh+c4kuH90SmM5uuBO8E/ApJHvmN4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Florian Fainelli <f.fainelli@gmail.com>,
        Antonio Borneo <antonio.borneo@foss.st.com>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        John Ogness <john.ogness@linutronix.de>,
        Kieran Bingham <kbingham@kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 267/371] scripts/gdb: raise error with reduced debugging information
Date:   Mon,  8 May 2023 11:47:48 +0200
Message-Id: <20230508094822.650892909@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094811.912279944@linuxfoundation.org>
References: <20230508094811.912279944@linuxfoundation.org>
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

From: Florian Fainelli <f.fainelli@gmail.com>

[ Upstream commit 8af055ae25bff48f57227f5e3d48a4306f3dd1c4 ]

If CONFIG_DEBUG_INFO_REDUCED is enabled in the kernel configuration, we
will typically not be able to load vmlinux-gdb.py and will fail with:

Traceback (most recent call last):
  File "/home/fainelli/work/buildroot/output/arm64/build/linux-custom/vmlinux-gdb.py", line 25, in <module>
    import linux.utils
  File "/home/fainelli/work/buildroot/output/arm64/build/linux-custom/scripts/gdb/linux/utils.py", line 131, in <module>
    atomic_long_counter_offset = atomic_long_type.get_type()['counter'].bitpos
KeyError: 'counter'

Rather be left wondering what is happening only to find out that reduced
debug information is the cause, raise an eror.  This was not typically a
problem until e3c8d33e0d62 ("scripts/gdb: fix 'lx-dmesg' on 32 bits arch")
but it has since then.

Link: https://lkml.kernel.org/r/20230406215252.1580538-1-f.fainelli@gmail.com
Fixes: e3c8d33e0d62 ("scripts/gdb: fix 'lx-dmesg' on 32 bits arch")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
Cc: Antonio Borneo <antonio.borneo@foss.st.com>
Cc: Jan Kiszka <jan.kiszka@siemens.com>
Cc: John Ogness <john.ogness@linutronix.de>
Cc: Kieran Bingham <kbingham@kernel.org>
Cc: Petr Mladek <pmladek@suse.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 scripts/gdb/linux/constants.py.in | 2 ++
 scripts/gdb/vmlinux-gdb.py        | 5 ++++-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/scripts/gdb/linux/constants.py.in b/scripts/gdb/linux/constants.py.in
index 2efbec6b6b8db..08f0587d15ea1 100644
--- a/scripts/gdb/linux/constants.py.in
+++ b/scripts/gdb/linux/constants.py.in
@@ -39,6 +39,8 @@
 
 import gdb
 
+LX_CONFIG(CONFIG_DEBUG_INFO_REDUCED)
+
 /* linux/clk-provider.h */
 if IS_BUILTIN(CONFIG_COMMON_CLK):
     LX_GDBPARSED(CLK_GET_RATE_NOCACHE)
diff --git a/scripts/gdb/vmlinux-gdb.py b/scripts/gdb/vmlinux-gdb.py
index 4136dc2c59df2..cd03de50c3bec 100644
--- a/scripts/gdb/vmlinux-gdb.py
+++ b/scripts/gdb/vmlinux-gdb.py
@@ -22,6 +22,10 @@ except:
     gdb.write("NOTE: gdb 7.2 or later required for Linux helper scripts to "
               "work.\n")
 else:
+    import linux.constants
+    if linux.constants.LX_CONFIG_DEBUG_INFO_REDUCED:
+        raise gdb.GdbError("Reduced debug information will prevent GDB "
+                           "from having complete types.\n")
     import linux.utils
     import linux.symbols
     import linux.modules
@@ -32,7 +36,6 @@ else:
     import linux.lists
     import linux.rbtree
     import linux.proc
-    import linux.constants
     import linux.timerlist
     import linux.clk
     import linux.genpd
-- 
2.39.2



