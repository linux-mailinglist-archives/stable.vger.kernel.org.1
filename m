Return-Path: <stable+bounces-90436-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 141429BE840
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 13:22:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 979651F22B41
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 12:22:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7A031DFD83;
	Wed,  6 Nov 2024 12:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Gm6KUgbz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5A171DF740;
	Wed,  6 Nov 2024 12:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730895765; cv=none; b=u8jH55wqWZ180ag3dMJL0JEZIqAFrovcJwiFK0cSr+CFyE9hVuNxDvp1z3X5dAwbDZeF2ZyWx5UbIQFP3ikD1r+vj9j+YE7RsSCSd/cVlpTRNCQ/EB7b/lqx+vJa/rt4q1iod7NvkyjYVgU66FaAAx3KyITyH5n+kIY03oK2D3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730895765; c=relaxed/simple;
	bh=sZi/yOITUMOe6eXeFnolS77jq5vsawUrIorL+ltkCFE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N59ZfAXRJk2G3XvxxKJez7XpxJlovz1/0HfgZ2DpyDfm1SMpqEV/mlzy8GiptA7Igt+vNnostI5qCW1jo6OsS3EdYoTVTi567GR3te6yhswCzu77SA2CtFuPxOdpYpx+rz7J/p68WAEDcFVBLd0rfucZn/VMG2W6rf/rThj9EeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Gm6KUgbz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C053C4CED4;
	Wed,  6 Nov 2024 12:22:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1730895765;
	bh=sZi/yOITUMOe6eXeFnolS77jq5vsawUrIorL+ltkCFE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Gm6KUgbzaMN1b/A16TAjtPlah59NR46BKTvqETxavA81qHtP3GsseZAgqEGk3qhIB
	 QAPB/fNKx2kydMx0OvpmJU6tOi1ctG+G+ovHOVnndcyAuufqyd0gCQtpa0Hx8uMsaP
	 vYIWEGo9S1k1lKDSORK4NUUdVY45Dvfpp+u4yYuc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Andrey Skvortsov <andrej.skvortzov@gmail.com>,
	Stephen Boyd <sboyd@kernel.org>
Subject: [PATCH 4.19 292/350] clk: Fix slab-out-of-bounds error in devm_clk_release()
Date: Wed,  6 Nov 2024 13:03:40 +0100
Message-ID: <20241106120328.039709557@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241106120320.865793091@linuxfoundation.org>
References: <20241106120320.865793091@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andrey Skvortsov <andrej.skvortzov@gmail.com>

commit 66fbfb35da47f391bdadf9fa7ceb88af4faa9022 upstream.

Problem can be reproduced by unloading snd_soc_simple_card, because in
devm_get_clk_from_child() devres data is allocated as `struct clk`, but
devm_clk_release() expects devres data to be `struct devm_clk_state`.

KASAN report:
 ==================================================================
 BUG: KASAN: slab-out-of-bounds in devm_clk_release+0x20/0x54
 Read of size 8 at addr ffffff800ee09688 by task (udev-worker)/287

 Call trace:
  dump_backtrace+0xe8/0x11c
  show_stack+0x1c/0x30
  dump_stack_lvl+0x60/0x78
  print_report+0x150/0x450
  kasan_report+0xa8/0xf0
  __asan_load8+0x78/0xa0
  devm_clk_release+0x20/0x54
  release_nodes+0x84/0x120
  devres_release_all+0x144/0x210
  device_unbind_cleanup+0x1c/0xac
  really_probe+0x2f0/0x5b0
  __driver_probe_device+0xc0/0x1f0
  driver_probe_device+0x68/0x120
  __driver_attach+0x140/0x294
  bus_for_each_dev+0xec/0x160
  driver_attach+0x38/0x44
  bus_add_driver+0x24c/0x300
  driver_register+0xf0/0x210
  __platform_driver_register+0x48/0x54
  asoc_simple_card_init+0x24/0x1000 [snd_soc_simple_card]
  do_one_initcall+0xac/0x340
  do_init_module+0xd0/0x300
  load_module+0x2ba4/0x3100
  __do_sys_init_module+0x2c8/0x300
  __arm64_sys_init_module+0x48/0x5c
  invoke_syscall+0x64/0x190
  el0_svc_common.constprop.0+0x124/0x154
  do_el0_svc+0x44/0xdc
  el0_svc+0x14/0x50
  el0t_64_sync_handler+0xec/0x11c
  el0t_64_sync+0x14c/0x150

 Allocated by task 287:
  kasan_save_stack+0x38/0x60
  kasan_set_track+0x28/0x40
  kasan_save_alloc_info+0x20/0x30
  __kasan_kmalloc+0xac/0xb0
  __kmalloc_node_track_caller+0x6c/0x1c4
  __devres_alloc_node+0x44/0xb4
  devm_get_clk_from_child+0x44/0xa0
  asoc_simple_parse_clk+0x1b8/0x1dc [snd_soc_simple_card_utils]
  simple_parse_node.isra.0+0x1ec/0x230 [snd_soc_simple_card]
  simple_dai_link_of+0x1bc/0x334 [snd_soc_simple_card]
  __simple_for_each_link+0x2ec/0x320 [snd_soc_simple_card]
  asoc_simple_probe+0x468/0x4dc [snd_soc_simple_card]
  platform_probe+0x90/0xf0
  really_probe+0x118/0x5b0
  __driver_probe_device+0xc0/0x1f0
  driver_probe_device+0x68/0x120
  __driver_attach+0x140/0x294
  bus_for_each_dev+0xec/0x160
  driver_attach+0x38/0x44
  bus_add_driver+0x24c/0x300
  driver_register+0xf0/0x210
  __platform_driver_register+0x48/0x54
  asoc_simple_card_init+0x24/0x1000 [snd_soc_simple_card]
  do_one_initcall+0xac/0x340
  do_init_module+0xd0/0x300
  load_module+0x2ba4/0x3100
  __do_sys_init_module+0x2c8/0x300
  __arm64_sys_init_module+0x48/0x5c
  invoke_syscall+0x64/0x190
  el0_svc_common.constprop.0+0x124/0x154
  do_el0_svc+0x44/0xdc
  el0_svc+0x14/0x50
  el0t_64_sync_handler+0xec/0x11c
  el0t_64_sync+0x14c/0x150

 The buggy address belongs to the object at ffffff800ee09600
  which belongs to the cache kmalloc-256 of size 256
 The buggy address is located 136 bytes inside of
  256-byte region [ffffff800ee09600, ffffff800ee09700)

 The buggy address belongs to the physical page:
 page:000000002d97303b refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x4ee08
 head:000000002d97303b order:1 compound_mapcount:0 compound_pincount:0
 flags: 0x10200(slab|head|zone=0)
 raw: 0000000000010200 0000000000000000 dead000000000122 ffffff8002c02480
 raw: 0000000000000000 0000000080100010 00000001ffffffff 0000000000000000
 page dumped because: kasan: bad access detected

 Memory state around the buggy address:
  ffffff800ee09580: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
  ffffff800ee09600: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 >ffffff800ee09680: 00 fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
                       ^
  ffffff800ee09700: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
  ffffff800ee09780: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ==================================================================

Fixes: abae8e57e49a ("clk: generalize devm_clk_get() a bit")
Signed-off-by: Andrey Skvortsov <andrej.skvortzov@gmail.com>
Link: https://lore.kernel.org/r/20230805084847.3110586-1-andrej.skvortzov@gmail.com
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/clk/clk-devres.c |   13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

--- a/drivers/clk/clk-devres.c
+++ b/drivers/clk/clk-devres.c
@@ -163,18 +163,19 @@ EXPORT_SYMBOL(devm_clk_put);
 struct clk *devm_get_clk_from_child(struct device *dev,
 				    struct device_node *np, const char *con_id)
 {
-	struct clk **ptr, *clk;
+	struct devm_clk_state *state;
+	struct clk *clk;
 
-	ptr = devres_alloc(devm_clk_release, sizeof(*ptr), GFP_KERNEL);
-	if (!ptr)
+	state = devres_alloc(devm_clk_release, sizeof(*state), GFP_KERNEL);
+	if (!state)
 		return ERR_PTR(-ENOMEM);
 
 	clk = of_clk_get_by_name(np, con_id);
 	if (!IS_ERR(clk)) {
-		*ptr = clk;
-		devres_add(dev, ptr);
+		state->clk = clk;
+		devres_add(dev, state);
 	} else {
-		devres_free(ptr);
+		devres_free(state);
 	}
 
 	return clk;



