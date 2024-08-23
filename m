Return-Path: <stable+bounces-70049-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2289595CFA8
	for <lists+stable@lfdr.de>; Fri, 23 Aug 2024 16:26:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4780C1C2173F
	for <lists+stable@lfdr.de>; Fri, 23 Aug 2024 14:26:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFF201AED3B;
	Fri, 23 Aug 2024 14:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NvSvme9C"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB86F1AED27;
	Fri, 23 Aug 2024 14:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724421987; cv=none; b=R17r3X7ihk5W9WZwIr6GqAYCmzqEHeW0kOZKRqBRrGe351FiTj4PIt+u/N5rXiW03YQJ3wQC645fWRL+sSJrieEDC7rR2g9rnJomk9c47ArW9C7ZxG91Sjvou0l+OkFU/nTxXZGkA7HC6nw9glbvlDJs4J2tNzLKzSlENa50Qlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724421987; c=relaxed/simple;
	bh=ftaZRHD5hqouTbzrWn8/bG8js8icJYEI7jfe3BGfZUg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rVow5/kHBYrPM6sDCcf+/lPQSD5Tbo/Yh4SVfpqXrB0BZmf9y/zMX5UxcTi0gR4kO2tRxP04tuwrIt3MhjNJ9PmRf0TtGEpfuP0Krr+jayeriRBTJeKQE5XzKbe9KzlCArwio8ecleSVfOUKfP/U/73Ew2dh3Xar2zSUKjq8MN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NvSvme9C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71F5CC4AF0B;
	Fri, 23 Aug 2024 14:06:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724421986;
	bh=ftaZRHD5hqouTbzrWn8/bG8js8icJYEI7jfe3BGfZUg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NvSvme9C5VVOK3ggAvnHDua1VCmJ/xyhRCuzwJU7uuva6P+YUFdajgOSZbBfiX7wV
	 VzCLAqhdFCnF8idoPdmapqCx+L3uUAlLSRKl+kJyD8CBCpxGqhT/zQejuspGUlTr24
	 WfD3MbT0YhqKOOdxGwNpq8Afaya5X/EhBnE2lBib/sOjg/dabFdoNboEaKzp3ZunnG
	 j023RCkpmUmqAS/RiQUfkutmz665I9dnmv+lils8THKbnCuCFrlwJe/sDUByKOmyW0
	 qjnweb1lb0xP9/oJw0P0SYN9j7iGtJrMvqnbWYobUlVAAE3DsWHjRiQcrjWNTWkf4f
	 P4J/RhzJpd18Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Stefan Wiehler <stefan.wiehler@nokia.com>,
	Rob Herring <robh@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	saravanak@google.com,
	devicetree@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 6/7] of/irq: Prevent device address out-of-bounds read in interrupt map walk
Date: Fri, 23 Aug 2024 10:06:01 -0400
Message-ID: <20240823140611.1975950-6-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240823140611.1975950-1-sashal@kernel.org>
References: <20240823140611.1975950-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.282
Content-Transfer-Encoding: 8bit

From: Stefan Wiehler <stefan.wiehler@nokia.com>

[ Upstream commit b739dffa5d570b411d4bdf4bb9b8dfd6b7d72305 ]

When of_irq_parse_raw() is invoked with a device address smaller than
the interrupt parent node (from #address-cells property), KASAN detects
the following out-of-bounds read when populating the initial match table
(dyndbg="func of_irq_parse_* +p"):

  OF: of_irq_parse_one: dev=/soc@0/picasso/watchdog, index=0
  OF:  parent=/soc@0/pci@878000000000/gpio0@17,0, intsize=2
  OF:  intspec=4
  OF: of_irq_parse_raw: ipar=/soc@0/pci@878000000000/gpio0@17,0, size=2
  OF:  -> addrsize=3
  ==================================================================
  BUG: KASAN: slab-out-of-bounds in of_irq_parse_raw+0x2b8/0x8d0
  Read of size 4 at addr ffffff81beca5608 by task bash/764

  CPU: 1 PID: 764 Comm: bash Tainted: G           O       6.1.67-484c613561-nokia_sm_arm64 #1
  Hardware name: Unknown Unknown Product/Unknown Product, BIOS 2023.01-12.24.03-dirty 01/01/2023
  Call trace:
   dump_backtrace+0xdc/0x130
   show_stack+0x1c/0x30
   dump_stack_lvl+0x6c/0x84
   print_report+0x150/0x448
   kasan_report+0x98/0x140
   __asan_load4+0x78/0xa0
   of_irq_parse_raw+0x2b8/0x8d0
   of_irq_parse_one+0x24c/0x270
   parse_interrupts+0xc0/0x120
   of_fwnode_add_links+0x100/0x2d0
   fw_devlink_parse_fwtree+0x64/0xc0
   device_add+0xb38/0xc30
   of_device_add+0x64/0x90
   of_platform_device_create_pdata+0xd0/0x170
   of_platform_bus_create+0x244/0x600
   of_platform_notify+0x1b0/0x254
   blocking_notifier_call_chain+0x9c/0xd0
   __of_changeset_entry_notify+0x1b8/0x230
   __of_changeset_apply_notify+0x54/0xe4
   of_overlay_fdt_apply+0xc04/0xd94
   ...

  The buggy address belongs to the object at ffffff81beca5600
   which belongs to the cache kmalloc-128 of size 128
  The buggy address is located 8 bytes inside of
   128-byte region [ffffff81beca5600, ffffff81beca5680)

  The buggy address belongs to the physical page:
  page:00000000230d3d03 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x1beca4
  head:00000000230d3d03 order:1 compound_mapcount:0 compound_pincount:0
  flags: 0x8000000000010200(slab|head|zone=2)
  raw: 8000000000010200 0000000000000000 dead000000000122 ffffff810000c300
  raw: 0000000000000000 0000000000200020 00000001ffffffff 0000000000000000
  page dumped because: kasan: bad access detected

  Memory state around the buggy address:
   ffffff81beca5500: 04 fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
   ffffff81beca5580: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
  >ffffff81beca5600: 00 fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
                        ^
   ffffff81beca5680: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
   ffffff81beca5700: 00 00 00 00 00 00 fc fc fc fc fc fc fc fc fc fc
  ==================================================================
  OF:  -> got it !

Prevent the out-of-bounds read by copying the device address into a
buffer of sufficient size.

Signed-off-by: Stefan Wiehler <stefan.wiehler@nokia.com>
Link: https://lore.kernel.org/r/20240812100652.3800963-1-stefan.wiehler@nokia.com
Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/of/irq.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/of/irq.c b/drivers/of/irq.c
index 352e14b007e78..ad0cb49e233ac 100644
--- a/drivers/of/irq.c
+++ b/drivers/of/irq.c
@@ -288,7 +288,8 @@ int of_irq_parse_one(struct device_node *device, int index, struct of_phandle_ar
 	struct device_node *p;
 	const __be32 *addr;
 	u32 intsize;
-	int i, res;
+	int i, res, addr_len;
+	__be32 addr_buf[3] = { 0 };
 
 	pr_debug("of_irq_parse_one: dev=%pOF, index=%d\n", device, index);
 
@@ -297,13 +298,19 @@ int of_irq_parse_one(struct device_node *device, int index, struct of_phandle_ar
 		return of_irq_parse_oldworld(device, index, out_irq);
 
 	/* Get the reg property (if any) */
-	addr = of_get_property(device, "reg", NULL);
+	addr = of_get_property(device, "reg", &addr_len);
+
+	/* Prevent out-of-bounds read in case of longer interrupt parent address size */
+	if (addr_len > (3 * sizeof(__be32)))
+		addr_len = 3 * sizeof(__be32);
+	if (addr)
+		memcpy(addr_buf, addr, addr_len);
 
 	/* Try the new-style interrupts-extended first */
 	res = of_parse_phandle_with_args(device, "interrupts-extended",
 					"#interrupt-cells", index, out_irq);
 	if (!res)
-		return of_irq_parse_raw(addr, out_irq);
+		return of_irq_parse_raw(addr_buf, out_irq);
 
 	/* Look for the interrupt parent. */
 	p = of_irq_find_parent(device);
@@ -333,7 +340,7 @@ int of_irq_parse_one(struct device_node *device, int index, struct of_phandle_ar
 
 
 	/* Check if there are any interrupt-map translations to process */
-	res = of_irq_parse_raw(addr, out_irq);
+	res = of_irq_parse_raw(addr_buf, out_irq);
  out:
 	of_node_put(p);
 	return res;
-- 
2.43.0


