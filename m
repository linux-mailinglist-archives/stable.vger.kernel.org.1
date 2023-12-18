Return-Path: <stable+bounces-7553-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A378481730E
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 15:14:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B32B1F21E23
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 14:14:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E57913D54D;
	Mon, 18 Dec 2023 14:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="W/Gd7aDd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8E893A1CD;
	Mon, 18 Dec 2023 14:12:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07632C433C7;
	Mon, 18 Dec 2023 14:12:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702908779;
	bh=0tN1aTYg83dKsuf5k85G6TRH3e4EBhsxIJ9BMHVV5RU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=W/Gd7aDd6ewBHPFLjxZz7mIiZkOxzgW5RZvmYBDUNr4U1fObsATijDAf+J13UWDeC
	 lsj9BY8WuDU1zjCmPLJI82FVZcKQxEZrdP249B6upR+DE6R2xrHgV3oFjRg/ieDuA9
	 lsTNVm+S1//k5LPhrgBxvFKKC77DqMHv0ZoLi4/Q=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	David Hildenbrand <david@redhat.com>,
	Mike Rapoport <rppt@kernel.org>,
	Michal Hocko <mhocko@suse.com>,
	Oscar Salvador <osalvador@suse.de>,
	Jianyong Wu <Jianyong.Wu@arm.com>,
	"Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
	Vineet Gupta <vgupta@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Huacai Chen <chenhuacai@kernel.org>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Christian Borntraeger <borntraeger@de.ibm.com>,
	Eric Biederman <ebiederm@xmission.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Shahab Vahedi <shahab@synopsys.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 06/83] mm/memory_hotplug: handle memblock_add_node() failures in add_memory_resource()
Date: Mon, 18 Dec 2023 14:51:27 +0100
Message-ID: <20231218135050.029727472@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231218135049.738602288@linuxfoundation.org>
References: <20231218135049.738602288@linuxfoundation.org>
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

From: David Hildenbrand <david@redhat.com>

[ Upstream commit 53d38316ab2017a7c0d733765b521700aa357ec9 ]

Patch series "mm/memory_hotplug: full support for add_memory_driver_managed() with CONFIG_ARCH_KEEP_MEMBLOCK", v2.

Architectures that require CONFIG_ARCH_KEEP_MEMBLOCK=y, such as arm64,
don't cleanly support add_memory_driver_managed() yet.  Most
prominently, kexec_file can still end up placing kexec images on such
driver-managed memory, resulting in undesired behavior, for example,
having kexec images located on memory not part of the firmware-provided
memory map.

Teaching kexec to not place images on driver-managed memory is
especially relevant for virtio-mem.  Details can be found in commit
7b7b27214bba ("mm/memory_hotplug: introduce
add_memory_driver_managed()").

Extend memblock with a new flag and set it from memory hotplug code when
applicable.  This is required to fully support virtio-mem on arm64,
making also kexec_file behave like on x86-64.

This patch (of 2):

If memblock_add_node() fails, we're most probably running out of memory.
While this is unlikely to happen, it can happen and having memory added
without a memblock can be problematic for architectures that use
memblock to detect valid memory.  Let's fail in a nice way instead of
silently ignoring the error.

Link: https://lkml.kernel.org/r/20211004093605.5830-1-david@redhat.com
Link: https://lkml.kernel.org/r/20211004093605.5830-2-david@redhat.com
Signed-off-by: David Hildenbrand <david@redhat.com>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: Jianyong Wu <Jianyong.Wu@arm.com>
Cc: "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>
Cc: Vineet Gupta <vgupta@kernel.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Huacai Chen <chenhuacai@kernel.org>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: Heiko Carstens <hca@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Eric Biederman <ebiederm@xmission.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Shahab Vahedi <shahab@synopsys.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Stable-dep-of: c7206e7bd214 ("MIPS: Loongson64: Handle more memory types passed from firmware")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/memory_hotplug.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index bf611c55fc66b..bc52a9d201ea6 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1384,8 +1384,11 @@ int __ref add_memory_resource(int nid, struct resource *res, mhp_t mhp_flags)
 
 	mem_hotplug_begin();
 
-	if (IS_ENABLED(CONFIG_ARCH_KEEP_MEMBLOCK))
-		memblock_add_node(start, size, nid);
+	if (IS_ENABLED(CONFIG_ARCH_KEEP_MEMBLOCK)) {
+		ret = memblock_add_node(start, size, nid);
+		if (ret)
+			goto error_mem_hotplug_end;
+	}
 
 	ret = __try_online_node(nid, false);
 	if (ret < 0)
@@ -1458,6 +1461,7 @@ int __ref add_memory_resource(int nid, struct resource *res, mhp_t mhp_flags)
 		rollback_node_hotadd(nid);
 	if (IS_ENABLED(CONFIG_ARCH_KEEP_MEMBLOCK))
 		memblock_remove(start, size);
+error_mem_hotplug_end:
 	mem_hotplug_done();
 	return ret;
 }
-- 
2.43.0




