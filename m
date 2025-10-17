Return-Path: <stable+bounces-187520-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 11D4EBEA4FA
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 17:56:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D89341889035
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 15:52:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B6EF2E62BE;
	Fri, 17 Oct 2025 15:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JCyF3oMq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2184F330B1F;
	Fri, 17 Oct 2025 15:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760716308; cv=none; b=VzKKyyqACojSEUomThH/8ROb+2NiRAbrUQwiIrg5xc+wN5TSYjnbCrwiSnu8/x78ncWxBaFVj6zYYueICZ63YiSE0GcUfsY+IsjNwhlJJnmSDsKC8hYWx94jJoQX6A2S8Ug2k7Q/ghSDOn6vc+owjkWynrlDuU8SW/u0RPNG/lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760716308; c=relaxed/simple;
	bh=ylSdk8xgMwsufbGy61/k9DqnrjEvgWrZmijhQrU0Csk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FoH+qf0NCHUgtkf1fCbxXhJCWSHI5yNGDtdJ8ZSln052w9OgxG5NXGi0wRnZg3gE/rSlFBRptw6U6XTA4P7rrLqR62Vo/IyfD3cOGnOTm/GNs3ok9fj8QvSWmUCr0icu8sPPngYIQIttU2e5s2L/Q0dqV/aNBuXYyRv9M+wYuOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JCyF3oMq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AA54C4CEE7;
	Fri, 17 Oct 2025 15:51:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760716307;
	bh=ylSdk8xgMwsufbGy61/k9DqnrjEvgWrZmijhQrU0Csk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JCyF3oMqT0nrqimVgO8elzMRh3gqg7GCSmBZoHZTfeBY3bsnZUew1Ddqh8lbzwq/X
	 VPGe8yRl9uctEHdy9wohxvrNljXPQybstPmQ0m46nwTn9wBUdGIGDkk4mG49vPbdpl
	 46S2mr/NCd+PfDzMdTZfpuFqV8di14XR+3K6CfcQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Yang Shi <yang@os.amperecomputing.com>,
	Carl Worth <carl@os.amperecomputing.com>,
	"Christoph Lameter (Ampere)" <cl@gentwo.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	David Hildenbrand <david@redhat.com>,
	Oscar Salvador <osalvador@suse.de>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Dev Jain <dev.jain@arm.com>,
	Muchun Song <muchun.song@linux.dev>,
	Will Deacon <will@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 5.15 113/276] mm: hugetlb: avoid soft lockup when mprotect to large memory area
Date: Fri, 17 Oct 2025 16:53:26 +0200
Message-ID: <20251017145146.602930311@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251017145142.382145055@linuxfoundation.org>
References: <20251017145142.382145055@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yang Shi <yang@os.amperecomputing.com>

commit f52ce0ea90c83a28904c7cc203a70e6434adfecb upstream.

When calling mprotect() to a large hugetlb memory area in our customer's
workload (~300GB hugetlb memory), soft lockup was observed:

watchdog: BUG: soft lockup - CPU#98 stuck for 23s! [t2_new_sysv:126916]

CPU: 98 PID: 126916 Comm: t2_new_sysv Kdump: loaded Not tainted 6.17-rc7
Hardware name: GIGACOMPUTING R2A3-T40-AAV1/Jefferson CIO, BIOS 5.4.4.1 07/15/2025
pstate: 20400009 (nzCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : mte_clear_page_tags+0x14/0x24
lr : mte_sync_tags+0x1c0/0x240
sp : ffff80003150bb80
x29: ffff80003150bb80 x28: ffff00739e9705a8 x27: 0000ffd2d6a00000
x26: 0000ff8e4bc00000 x25: 00e80046cde00f45 x24: 0000000000022458
x23: 0000000000000000 x22: 0000000000000004 x21: 000000011b380000
x20: ffff000000000000 x19: 000000011b379f40 x18: 0000000000000000
x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000000
x14: 0000000000000000 x13: 0000000000000000 x12: 0000000000000000
x11: 0000000000000000 x10: 0000000000000000 x9 : ffffc875e0aa5e2c
x8 : 0000000000000000 x7 : 0000000000000000 x6 : 0000000000000000
x5 : fffffc01ce7a5c00 x4 : 00000000046cde00 x3 : fffffc0000000000
x2 : 0000000000000004 x1 : 0000000000000040 x0 : ffff0046cde7c000

Call trace:
  mte_clear_page_tags+0x14/0x24
  set_huge_pte_at+0x25c/0x280
  hugetlb_change_protection+0x220/0x430
  change_protection+0x5c/0x8c
  mprotect_fixup+0x10c/0x294
  do_mprotect_pkey.constprop.0+0x2e0/0x3d4
  __arm64_sys_mprotect+0x24/0x44
  invoke_syscall+0x50/0x160
  el0_svc_common+0x48/0x144
  do_el0_svc+0x30/0xe0
  el0_svc+0x30/0xf0
  el0t_64_sync_handler+0xc4/0x148
  el0t_64_sync+0x1a4/0x1a8

Soft lockup is not triggered with THP or base page because there is
cond_resched() called for each PMD size.

Although the soft lockup was triggered by MTE, it should be not MTE
specific.  The other processing which takes long time in the loop may
trigger soft lockup too.

So add cond_resched() for hugetlb to avoid soft lockup.

Link: https://lkml.kernel.org/r/20250929202402.1663290-1-yang@os.amperecomputing.com
Fixes: 8f860591ffb2 ("[PATCH] Enable mprotect on huge pages")
Signed-off-by: Yang Shi <yang@os.amperecomputing.com>
Tested-by: Carl Worth <carl@os.amperecomputing.com>
Reviewed-by: Christoph Lameter (Ampere) <cl@gentwo.org>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Acked-by: David Hildenbrand <david@redhat.com>
Acked-by: Oscar Salvador <osalvador@suse.de>
Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
Reviewed-by: Dev Jain <dev.jain@arm.com>
Cc: Muchun Song <muchun.song@linux.dev>
Cc: Will Deacon <will@kernel.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 mm/hugetlb.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5714,6 +5714,8 @@ unsigned long hugetlb_change_protection(
 			pages++;
 		}
 		spin_unlock(ptl);
+
+		cond_resched();
 	}
 	/*
 	 * Must flush TLB before releasing i_mmap_rwsem: x86's huge_pmd_unshare



