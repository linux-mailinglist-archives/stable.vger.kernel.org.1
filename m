Return-Path: <stable+bounces-22103-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA65385DA5D
	for <lists+stable@lfdr.de>; Wed, 21 Feb 2024 14:31:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1FDA1C20ADD
	for <lists+stable@lfdr.de>; Wed, 21 Feb 2024 13:31:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30A127C093;
	Wed, 21 Feb 2024 13:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KZePX3qj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1E4269D2E;
	Wed, 21 Feb 2024 13:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708522032; cv=none; b=t55qUUklH+XFI2eOh48jP0dslkifczzygE/SOdeE+SQQ01ITjNIpdwaesLE26C4xhWHaX3jWMIv3JaahThKoKXyLIpDFszgv/Ew5xmy1z2zcr8THseTIh+t3E0VctVYbdw1Oz9h+cuuFnQYcFwjfYC9GBSMIbbRiZ7reQ4+RniM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708522032; c=relaxed/simple;
	bh=veyKJxBsYuK6924tX5te1/noMjdpOIt3Be0EHAomdP4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JPc6K4qPiHphIqwVDCs48ssrpVIANtBbSa5xNSATE6PlHtz2UBPzMjw2I+v1wxaQyJHQIu98nRmnvtkPXUNgIbfJe200leUV/iXKKRsTx17YDMGpip+y6DRm2CvQzPuHoNiponw/ReZoPtDfqLtou3RUFAfp+DYT7BNAPNxFrdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KZePX3qj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 502DBC433C7;
	Wed, 21 Feb 2024 13:27:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708522031;
	bh=veyKJxBsYuK6924tX5te1/noMjdpOIt3Be0EHAomdP4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KZePX3qjtRIWePYfosqLbp8uw6D5fNVTaucgJgJzpjpqhvnEhrar/2ZrLk39VHIMR
	 T0WPrmjBmDrA9DppTucu9+zu7ISIwjHxOihH16oG1Ztaq7HDI5n99RH5vKvbBXyoj0
	 5SIKYe/WmCf9a552G9+uNX+Y94jMlmN76850Is4c=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Serge Semin <fancer.lancer@gmail.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: [PATCH 5.15 022/476] mips: Fix max_mapnr being uninitialized on early stages
Date: Wed, 21 Feb 2024 14:01:13 +0100
Message-ID: <20240221130008.712006932@linuxfoundation.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240221130007.738356493@linuxfoundation.org>
References: <20240221130007.738356493@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

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
@@ -417,7 +417,12 @@ void __init paging_init(void)
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
@@ -453,13 +458,6 @@ void __init mem_init(void)
 	 */
 	BUILD_BUG_ON(IS_ENABLED(CONFIG_32BIT) && (_PFN_SHIFT > PAGE_SHIFT));
 
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



