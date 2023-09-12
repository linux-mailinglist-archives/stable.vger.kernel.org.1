Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3FF379AF03
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 01:46:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237306AbjIKUv0 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 16:51:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240103AbjIKOgj (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:36:39 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA23ECF0
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:36:34 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C983CC433CB;
        Mon, 11 Sep 2023 14:36:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694442994;
        bh=YuOxKlLGS5eD/wJel0mUY7vO6YlQ8GccahIwrHrhslY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=S2632ThBG/uxjl35DiNg4rKB5ZsyIkU9+xjlygdFPFSdiruTalzWb44DPh1e42T/k
         qb4rZorJDCJ0praG3BF+PNPkiZG4/adaxpuZszKw/TohUw8ccl6l5vSFLlXHKu6+69
         /SWIhWC9VZG/hX6hPNCwJQSBaT9LX8BZfy+AwgOA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com>,
        Pankaj Raghav <p.raghav@samsung.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Chinwen Chang <chinwen.chang@mediatek.com>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Kieran Bingham <kbingham@kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Qun-Wei Lin <qun-wei.lin@mediatek.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 221/737] scripts/gdb: fix lx-lsmod show the wrong size
Date:   Mon, 11 Sep 2023 15:41:20 +0200
Message-ID: <20230911134656.758863474@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134650.286315610@linuxfoundation.org>
References: <20230911134650.286315610@linuxfoundation.org>
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

6.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com>

[ Upstream commit fb40b0537342e1acd5c2daf2ff6780c1d0d2883c ]

'lsmod' shows total core layout size, so we need to sum up all the
sections in core layout in gdb scripts.

/ # lsmod
kasan_test 200704 0 - Live 0xffff80007f640000

Before patch:
(gdb) lx-lsmod
Address            Module                  Size  Used by
0xffff80007f640000 kasan_test             36864  0

After patch:
(gdb) lx-lsmod
Address            Module                  Size  Used by
0xffff80007f640000 kasan_test            200704  0

Link: https://lkml.kernel.org/r/20230710092852.31049-1-Kuan-Ying.Lee@mediatek.com
Fixes: b4aff7513df3 ("scripts/gdb: use mem instead of core_layout to get the module address")
Signed-off-by: Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com>
Reviewed-by: Pankaj Raghav <p.raghav@samsung.com>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Chinwen Chang <chinwen.chang@mediatek.com>
Cc: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Kieran Bingham <kbingham@kernel.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>
Cc: Matthias Brugger <matthias.bgg@gmail.com>
Cc: Qun-Wei Lin <qun-wei.lin@mediatek.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 scripts/gdb/linux/constants.py.in |  3 +++
 scripts/gdb/linux/modules.py      | 12 +++++++++---
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/scripts/gdb/linux/constants.py.in b/scripts/gdb/linux/constants.py.in
index 50a92c4e9984e..fab74ca9df6fc 100644
--- a/scripts/gdb/linux/constants.py.in
+++ b/scripts/gdb/linux/constants.py.in
@@ -64,6 +64,9 @@ LX_GDBPARSED(IRQ_HIDDEN)
 
 /* linux/module.h */
 LX_GDBPARSED(MOD_TEXT)
+LX_GDBPARSED(MOD_DATA)
+LX_GDBPARSED(MOD_RODATA)
+LX_GDBPARSED(MOD_RO_AFTER_INIT)
 
 /* linux/mount.h */
 LX_VALUE(MNT_NOSUID)
diff --git a/scripts/gdb/linux/modules.py b/scripts/gdb/linux/modules.py
index 261f28640f4cd..f76a43bfa15fc 100644
--- a/scripts/gdb/linux/modules.py
+++ b/scripts/gdb/linux/modules.py
@@ -73,11 +73,17 @@ class LxLsmod(gdb.Command):
                 "        " if utils.get_long_type().sizeof == 8 else ""))
 
         for module in module_list():
-            layout = module['mem'][constants.LX_MOD_TEXT]
+            text = module['mem'][constants.LX_MOD_TEXT]
+            text_addr = str(text['base']).split()[0]
+            total_size = 0
+
+            for i in range(constants.LX_MOD_TEXT, constants.LX_MOD_RO_AFTER_INIT + 1):
+                total_size += module['mem'][i]['size']
+
             gdb.write("{address} {name:<19} {size:>8}  {ref}".format(
-                address=str(layout['base']).split()[0],
+                address=text_addr,
                 name=module['name'].string(),
-                size=str(layout['size']),
+                size=str(total_size),
                 ref=str(module['refcnt']['counter'] - 1)))
 
             t = self._module_use_type.get_type().pointer()
-- 
2.40.1



