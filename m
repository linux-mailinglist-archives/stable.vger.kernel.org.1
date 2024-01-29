Return-Path: <stable+bounces-16471-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F440840D1A
	for <lists+stable@lfdr.de>; Mon, 29 Jan 2024 18:08:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D83D61F2B381
	for <lists+stable@lfdr.de>; Mon, 29 Jan 2024 17:08:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 190A51586C7;
	Mon, 29 Jan 2024 17:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HmISt1qv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBCF8159563;
	Mon, 29 Jan 2024 17:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706548043; cv=none; b=GACg0BkgTR2ZVZuMv+Cav+k+EILOYWXLYNxJrdVI2P9n/QvwGkwn4wbhl8Gk1f0xWyywj1xGDuxrUmJV+2j5xASqf5yE2JtbBNDc0+SjXw78/rzosSRG9YmBxp5fFKuwBnp1I55TitZuMo8zRLE9YS4L1eQIBqngIqovuwfdths=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706548043; c=relaxed/simple;
	bh=+hUWxm4qOKew7axXRnKyDNd3yYfdPABqR2tpM3TgXt0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oxMoL7HdLMeF1cu2HU2nBvF8hJGrmw0Pnj0iGOzizCLTvMym0DbOO5XCjc+dgR8wP1/o84NaqjA8D6/bdU1fjJ/fRO4Jrymo0B7paS7RMZ82NdYnspUwfodX5Svw+czjSQy+PHfXzre+xxpNOvaQVZ9gElm0EvQj1Hecco1Ao2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HmISt1qv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96520C433F1;
	Mon, 29 Jan 2024 17:07:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706548043;
	bh=+hUWxm4qOKew7axXRnKyDNd3yYfdPABqR2tpM3TgXt0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HmISt1qvYDnevKVopvJgi8zIN7SWfwCFvgM1+jrOBQIPSzGwn8qFX/T0gRWZhgls8
	 WPCsQpnonUSFBdyXMWOWlNSN11R4FdEeBZ4/Y50zQeNrY36DeOFx2roDbgeyoUAc1v
	 qpIjs3ThT7WhV5W9t/BW641DLgSVfn3BypuFZSwU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Serge Semin <fancer.lancer@gmail.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: [PATCH 6.7 044/346] mips: Fix max_mapnr being uninitialized on early stages
Date: Mon, 29 Jan 2024 09:01:15 -0800
Message-ID: <20240129170017.681111175@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240129170016.356158639@linuxfoundation.org>
References: <20240129170016.356158639@linuxfoundation.org>
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

6.7-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Serge Semin <fancer.lancer@gmail.com>

commit e1a9ae45736989c972a8d1c151bc390678ae6205 upstream.

max_mapnr variable is utilized in the pfn_valid() method in order to
determine the upper PFN space boundary. Having it uninitialized
effectively makes any PFN passed to that method invalid. That in its turn
causes the kernel mm-subsystem occasion malfunctions even after the
max_mapnr variable is actually properly updated. For instance,
pfn_valid() is called in the init_unavailable_range() method in the
framework of the calls-chain on MIPS:
setup_arch()
+-> paging_init()
    +-> free_area_init()
        +-> memmap_init()
            +-> memmap_init_zone_range()
                +-> init_unavailable_range()

Since pfn_valid() always returns "false" value before max_mapnr is
initialized in the mem_init() method, any flatmem page-holes will be left
in the poisoned/uninitialized state including the IO-memory pages. Thus
any further attempts to map/remap the IO-memory by using MMU may fail.
In particular it happened in my case on attempt to map the SRAM region.
The kernel bootup procedure just crashed on the unhandled unaligned access
bug raised in the __update_cache() method:

> Unhandled kernel unaligned access[#1]:
> CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.7.0-rc1-XXX-dirty #2056
> ...
> Call Trace:
> [<8011ef9c>] __update_cache+0x88/0x1bc
> [<80385944>] ioremap_page_range+0x110/0x2a4
> [<80126948>] ioremap_prot+0x17c/0x1f4
> [<80711b80>] __devm_ioremap+0x8c/0x120
> [<80711e0c>] __devm_ioremap_resource+0xf4/0x218
> [<808bf244>] sram_probe+0x4f4/0x930
> [<80889d20>] platform_probe+0x68/0xec
> ...

Let's fix the problem by initializing the max_mapnr variable as soon as
the required data is available. In particular it can be done right in the
paging_init() method before free_area_init() is called since all the PFN
zone boundaries have already been calculated by that time.

Cc: stable@vger.kernel.org
Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/mips/mm/init.c |   12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

--- a/arch/mips/mm/init.c
+++ b/arch/mips/mm/init.c
@@ -422,7 +422,12 @@ void __init paging_init(void)
 		       (highend_pfn - max_low_pfn) << (PAGE_SHIFT - 10));
 		max_zone_pfns[ZONE_HIGHMEM] = max_low_pfn;
 	}
+
+	max_mapnr = highend_pfn ? highend_pfn : max_low_pfn;
+#else
+	max_mapnr = max_low_pfn;
 #endif
+	high_memory = (void *) __va(max_low_pfn << PAGE_SHIFT);
 
 	free_area_init(max_zone_pfns);
 }
@@ -458,13 +463,6 @@ void __init mem_init(void)
 	 */
 	BUILD_BUG_ON(IS_ENABLED(CONFIG_32BIT) && (PFN_PTE_SHIFT > PAGE_SHIFT));
 
-#ifdef CONFIG_HIGHMEM
-	max_mapnr = highend_pfn ? highend_pfn : max_low_pfn;
-#else
-	max_mapnr = max_low_pfn;
-#endif
-	high_memory = (void *) __va(max_low_pfn << PAGE_SHIFT);
-
 	maar_init();
 	memblock_free_all();
 	setup_zero_pages();	/* Setup zeroed pages.  */



