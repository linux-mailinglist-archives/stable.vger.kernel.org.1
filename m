Return-Path: <stable+bounces-64920-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CFC4943C7C
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 02:38:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F30D6B27109
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 00:38:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97F491C0DF4;
	Thu,  1 Aug 2024 00:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OH0AJr4h"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55D9E1C0DF1;
	Thu,  1 Aug 2024 00:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722471429; cv=none; b=qwrmaf3Ex0DtuTmpD3Q6hVyLrx0RWPHrzntwnsWjd6ciGPo9+JxacIt9PSr0V73EF3heLOMjNBhL3VF9vQYmp1kdLtlidPmrudqHF2bSXR6u9PMQeDody2jlP75jb9PAYf7ZUIQIk7pix6G08dKckY1nLPrECKtvXzx4QXie0NE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722471429; c=relaxed/simple;
	bh=BvkC1kCVClVzmp9N9tEVoKyMTepRgzaH/KBwijVY7Mg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YSWlTjt77lswEUetGIPryAah7mgHN2hsZlG8yuJ70N16pta3oBLU0de5jXyR4ayM7ezBFOdD+zMNnCgSWLstBBts44LQpRzGEMtEVhxd/bhAcYtE9OPVm1p03gbwbbtk2dtBQf+IavjBida3gVfKzIzp+F7sw/CzYjcqo1IL6ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OH0AJr4h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 597FEC32786;
	Thu,  1 Aug 2024 00:17:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722471429;
	bh=BvkC1kCVClVzmp9N9tEVoKyMTepRgzaH/KBwijVY7Mg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OH0AJr4h3tomIAkHztclF7osCoGXyxL5x4KzpnZpbyNqOV84RQljQCL75TikxB9Se
	 aaR9aIvOiSedScRdhfs9Hj1I7ZBueeuFIh+flmjWYHzOyQY5rnIi0ETLjcbNwVnGrH
	 n4T4kUfDSdhHVSgzP2STvHhZkRWi1Sw0/nxDV76sl0wIluSxPaaQEZTNO6iJZ1Z2+4
	 ve18LEo+Wwk3R66DDUjZrIBL4NPN5w3f1zJG5HmH+21SQnSMfvk2PgjhGJOAnJlEcg
	 ijBn3BFa45n2ayW8z89icrBO4UdpKt6+tb3r1OvwkYapkCj6j1fDW763D3S8HgCrTD
	 wmvWvb0dMiSeg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
	David Hildenbrand <david@redhat.com>,
	Oscar Salvador <osalvador@suse.de>,
	Palmer Dabbelt <palmer@rivosinc.com>,
	Sasha Levin <sashal@kernel.org>,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alexghiti@rivosinc.com,
	peterlin@andestech.com,
	christophe.leroy@csgroup.eu,
	akpm@linux-foundation.org,
	suagrfillet@gmail.com,
	linux-riscv@lists.infradead.org
Subject: [PATCH AUTOSEL 6.10 095/121] riscv: mm: Take memory hotplug read-lock during kernel page table dump
Date: Wed, 31 Jul 2024 20:00:33 -0400
Message-ID: <20240801000834.3930818-95-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240801000834.3930818-1-sashal@kernel.org>
References: <20240801000834.3930818-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.2
Content-Transfer-Encoding: 8bit

From: Björn Töpel <bjorn@rivosinc.com>

[ Upstream commit 37992b7f1097ba79ca75ba5a26ddcf0f54f91a08 ]

During memory hot remove, the ptdump functionality can end up touching
stale data. Avoid any potential crashes (or worse), by holding the
memory hotplug read-lock while traversing the page table.

This change is analogous to arm64's commit bf2b59f60ee1 ("arm64/mm:
Hold memory hotplug lock while walking for kernel page table dump").

Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Oscar Salvador <osalvador@suse.de>
Signed-off-by: Björn Töpel <bjorn@rivosinc.com>
Link: https://lore.kernel.org/r/20240605114100.315918-8-bjorn@kernel.org
Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/riscv/mm/ptdump.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/riscv/mm/ptdump.c b/arch/riscv/mm/ptdump.c
index 1289cc6d3700c..9d5f657a251b3 100644
--- a/arch/riscv/mm/ptdump.c
+++ b/arch/riscv/mm/ptdump.c
@@ -6,6 +6,7 @@
 #include <linux/efi.h>
 #include <linux/init.h>
 #include <linux/debugfs.h>
+#include <linux/memory_hotplug.h>
 #include <linux/seq_file.h>
 #include <linux/ptdump.h>
 
@@ -370,7 +371,9 @@ bool ptdump_check_wx(void)
 
 static int ptdump_show(struct seq_file *m, void *v)
 {
+	get_online_mems();
 	ptdump_walk(m, m->private);
+	put_online_mems();
 
 	return 0;
 }
-- 
2.43.0


