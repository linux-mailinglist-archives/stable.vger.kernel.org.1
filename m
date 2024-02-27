Return-Path: <stable+bounces-24049-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B20988692DD
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 14:39:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 70E7FB2D8BD
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 13:34:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0756213B2A7;
	Tue, 27 Feb 2024 13:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="smw9yl/B"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B97762F2D;
	Tue, 27 Feb 2024 13:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709040887; cv=none; b=Fi/gZ+f/ToIlOGmUBX2b6ywVXtP/8nEF9M1rYIUQu+jsJG/OsbuosC2nb1pT4NsjnlzJBLwSNic6Ia2alaI4qY74TJFn2R2ysjCjcvMDIUoj0aQVFWPz/YlMgSHkeBcLq+YonrkSxm8x+IRfB397uhWEqqTQ0n4yB3232wuH4Fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709040887; c=relaxed/simple;
	bh=/P6IKKkQzixXYqd/3hyN4qQOumRBWVxhlS87HTsGqHc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sSSBKPYZFNQ08CS1664llQQ3d0rF/yHApq2PRlFixIE4oq03WJPfWOqyk7L4JsgkcqxZGx8Eg8fw0Xrw678GMzecRo/uQ5SBKewjvgboA1Mqj73Em+4DIE41+Y3yHLljG2wKf4ovBlsfTwSIO7PlAle4n75UWoQJb+fkwZcvy2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=smw9yl/B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 480D5C43394;
	Tue, 27 Feb 2024 13:34:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709040887;
	bh=/P6IKKkQzixXYqd/3hyN4qQOumRBWVxhlS87HTsGqHc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=smw9yl/BhV/p0Xz1I4YFy0sy+lhUAKcC6tND5APIIRUge3S5E1dQpbmJ0QfX392WO
	 sHe7nW7bJK3/t6LN8y9BSenJc8jYD03HXnvviKEZ+QkaJ7VIMbOoGHtbtPbDvpxWpw
	 GCf/pTxbFDn0M00An/0fzU6FZE28f1ei+2BjsXc0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Oreoluwa Babatunde <quic_obabatun@quicinc.com>,
	Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH 6.7 144/334] LoongArch: Call early_init_fdt_scan_reserved_mem() earlier
Date: Tue, 27 Feb 2024 14:20:02 +0100
Message-ID: <20240227131635.106378105@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240227131630.636392135@linuxfoundation.org>
References: <20240227131630.636392135@linuxfoundation.org>
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

From: Huacai Chen <chenhuacai@loongson.cn>

commit 9fa304b9f8ec440e614af6d35826110c633c4074 upstream.

The unflatten_and_copy_device_tree() function contains a call to
memblock_alloc(). This means that memblock is allocating memory before
any of the reserved memory regions are set aside in the arch_mem_init()
function which calls early_init_fdt_scan_reserved_mem(). Therefore,
there is a possibility for memblock to allocate from any of the
reserved memory regions.

Hence, move the call to early_init_fdt_scan_reserved_mem() to be earlier
in the init sequence, so that the reserved memory regions are set aside
before any allocations are done using memblock.

Cc: stable@vger.kernel.org
Fixes: 88d4d957edc707e ("LoongArch: Add FDT booting support from efi system table")
Signed-off-by: Oreoluwa Babatunde <quic_obabatun@quicinc.com>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/loongarch/kernel/setup.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/arch/loongarch/kernel/setup.c
+++ b/arch/loongarch/kernel/setup.c
@@ -366,6 +366,8 @@ void __init platform_init(void)
 	acpi_gbl_use_default_register_widths = false;
 	acpi_boot_table_init();
 #endif
+
+	early_init_fdt_scan_reserved_mem();
 	unflatten_and_copy_device_tree();
 
 #ifdef CONFIG_NUMA
@@ -399,8 +401,6 @@ static void __init arch_mem_init(char **
 
 	check_kernel_sections_mem();
 
-	early_init_fdt_scan_reserved_mem();
-
 	/*
 	 * In order to reduce the possibility of kernel panic when failed to
 	 * get IO TLB memory under CONFIG_SWIOTLB, it is better to allocate



