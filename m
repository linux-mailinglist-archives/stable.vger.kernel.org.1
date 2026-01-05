Return-Path: <stable+bounces-204761-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 799C1CF41A9
	for <lists+stable@lfdr.de>; Mon, 05 Jan 2026 15:29:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0BA383067664
	for <lists+stable@lfdr.de>; Mon,  5 Jan 2026 14:26:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67553349AFF;
	Mon,  5 Jan 2026 12:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xPEX6xkc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2573E349AFC
	for <stable@vger.kernel.org>; Mon,  5 Jan 2026 12:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767617314; cv=none; b=SEiRhVW1Mv8MkSpKEaNiqiBDFPLiqGbNYvs7Gmg/HOMqa3339M0gWDU7mitQmB/rMBs1lzx2NPcepcc0Nt+y5sHV+oskZ0UVrOBv92JAYr6QuouXlBGkTS28wes2RebNnUI85d0BFuIN/Ha9bNJ+SulVzqJX0bvYehFWC0QXF0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767617314; c=relaxed/simple;
	bh=4JvE87Q/waNmFRnL8i7mws4FdVIkXYWHZiZ9+zaETrk=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=kKAr2aN59M7RGWe+GmK5+fwms6x06kdynv9DcIWzYMfilaCXqISgWt4f0sdZi67nDu0C2UDVave8fMJZkjlLGNRiBKmMO3QU/dFPkbnG4PXqudUGTvLjtWeLlDGaFxrVZ8IJVyqie8/y3/J/UkbUNA/akUgEdC8fD5Qv5d7F8mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xPEX6xkc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29766C16AAE;
	Mon,  5 Jan 2026 12:48:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767617313;
	bh=4JvE87Q/waNmFRnL8i7mws4FdVIkXYWHZiZ9+zaETrk=;
	h=Subject:To:Cc:From:Date:From;
	b=xPEX6xkcTNXLsuOOcriAA920jq19tWFJXukQ98ggnLyzIPMPRTtBpQbLoUlNEfVSd
	 2xdTzKn3pY+OeEWqgvN+mADpcheEq5gJBsp5Yenw7W3vq6F9kMKiS4eUeVqCdJssj9
	 5QBrEX6WFG0eHLEqoehadQKxct0m5QE7tlAqGhKY=
Subject: FAILED: patch "[PATCH] kasan: unpoison vms[area] addresses with a common tag" failed to apply to 6.6-stable tree
To: maciej.wieczor-retman@intel.com,akpm@linux-foundation.org,andreyknvl@gmail.com,dakr@kernel.org,dvyukov@google.com,elver@google.com,glider@google.com,jiayuan.chen@linux.dev,kees@kernel.org,ryabinin.a.a@gmail.com,stable@vger.kernel.org,urezki@gmail.com,vincenzo.frascino@arm.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 05 Jan 2026 13:48:30 +0100
Message-ID: <2026010530-majesty-gangway-5658@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 6a0e5b333842cf65d6f4e4f0a2a4386504802515
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026010530-majesty-gangway-5658@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 6a0e5b333842cf65d6f4e4f0a2a4386504802515 Mon Sep 17 00:00:00 2001
From: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
Date: Thu, 4 Dec 2025 19:00:11 +0000
Subject: [PATCH] kasan: unpoison vms[area] addresses with a common tag

A KASAN tag mismatch, possibly causing a kernel panic, can be observed on
systems with a tag-based KASAN enabled and with multiple NUMA nodes.  It
was reported on arm64 and reproduced on x86.  It can be explained in the
following points:

1. There can be more than one virtual memory chunk.
2. Chunk's base address has a tag.
3. The base address points at the first chunk and thus inherits
   the tag of the first chunk.
4. The subsequent chunks will be accessed with the tag from the
   first chunk.
5. Thus, the subsequent chunks need to have their tag set to
   match that of the first chunk.

Use the new vmalloc flag that disables random tag assignment in
__kasan_unpoison_vmalloc() - pass the same random tag to all the
vm_structs by tagging the pointers before they go inside
__kasan_unpoison_vmalloc().  Assigning a common tag resolves the pcpu
chunk address mismatch.

[akpm@linux-foundation.org: use WARN_ON_ONCE(), per Andrey]
  Link: https://lkml.kernel.org/r/CA+fCnZeuGdKSEm11oGT6FS71_vGq1vjq-xY36kxVdFvwmag2ZQ@mail.gmail.com
[maciej.wieczor-retman@intel.com: remove unneeded pr_warn()]
  Link: https://lkml.kernel.org/r/919897daaaa3c982a27762a2ee038769ad033991.1764945396.git.m.wieczorretman@pm.me
Link: https://lkml.kernel.org/r/873821114a9f722ffb5d6702b94782e902883fdf.1764874575.git.m.wieczorretman@pm.me
Fixes: 1d96320f8d53 ("kasan, vmalloc: add vmalloc tagging for SW_TAGS")
Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
Reviewed-by: Andrey Konovalov <andreyknvl@gmail.com>
Cc: Alexander Potapenko <glider@google.com>
Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>
Cc: Danilo Krummrich <dakr@kernel.org>
Cc: Dmitriy Vyukov <dvyukov@google.com>
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: Kees Cook <kees@kernel.org>
Cc: Marco Elver <elver@google.com>
Cc: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc: Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: <stable@vger.kernel.org>	[6.1+]
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/mm/kasan/common.c b/mm/kasan/common.c
index b2b40c59ce18..ed489a14dddf 100644
--- a/mm/kasan/common.c
+++ b/mm/kasan/common.c
@@ -584,11 +584,26 @@ void __kasan_unpoison_vmap_areas(struct vm_struct **vms, int nr_vms,
 	unsigned long size;
 	void *addr;
 	int area;
+	u8 tag;
 
-	for (area = 0 ; area < nr_vms ; area++) {
+	/*
+	 * If KASAN_VMALLOC_KEEP_TAG was set at this point, all vms[] pointers
+	 * would be unpoisoned with the KASAN_TAG_KERNEL which would disable
+	 * KASAN checks down the line.
+	 */
+	if (WARN_ON_ONCE(flags & KASAN_VMALLOC_KEEP_TAG))
+		return;
+
+	size = vms[0]->size;
+	addr = vms[0]->addr;
+	vms[0]->addr = __kasan_unpoison_vmalloc(addr, size, flags);
+	tag = get_tag(vms[0]->addr);
+
+	for (area = 1 ; area < nr_vms ; area++) {
 		size = vms[area]->size;
-		addr = vms[area]->addr;
-		vms[area]->addr = __kasan_unpoison_vmalloc(addr, size, flags);
+		addr = set_tag(vms[area]->addr, tag);
+		vms[area]->addr =
+			__kasan_unpoison_vmalloc(addr, size, flags | KASAN_VMALLOC_KEEP_TAG);
 	}
 }
 #endif


