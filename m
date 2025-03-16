Return-Path: <stable+bounces-124522-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A60CAA6347B
	for <lists+stable@lfdr.de>; Sun, 16 Mar 2025 08:24:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E320B16ED76
	for <lists+stable@lfdr.de>; Sun, 16 Mar 2025 07:24:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA0ED150997;
	Sun, 16 Mar 2025 07:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="D3yo/aEO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A6394C80
	for <stable@vger.kernel.org>; Sun, 16 Mar 2025 07:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742109895; cv=none; b=l8Tcl56ENi1mCy3VMtVKvk2qX2U7I3WVEaSrNwXtD2WyheMAyrxYoZnAk0RZi98xjSHRMnJZbaY78WAVUVpF0S6+c4zK2F4B1Rx6/g90aH2EPP0QYSNWalwKXZLC7OyQwiQebW//5299MxgKTDHlnSM8uL4o2MuaSdYKySUrvJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742109895; c=relaxed/simple;
	bh=iXmrQgsTitjdilvSIyYOCmWDrvxLDXemF0popOeUvNY=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=T8+Tjeak3HqLITiKFcRtC7bbNbbv4q0WJKz29Mfe0+moFbyQM0/gG8h5+SyB+GKMsYDQ1xHfWPqE/qmBw/PSPeBEisJWBSUduuQfIqp6N1NUqRu86fn5HOltdeh6pkCZEjoC7/t7VpA+Cccc+mWoXl9B+9kIPgzDkTFK1ZCcAdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=D3yo/aEO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2C63C4CEDD;
	Sun, 16 Mar 2025 07:24:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1742109894;
	bh=iXmrQgsTitjdilvSIyYOCmWDrvxLDXemF0popOeUvNY=;
	h=Subject:To:Cc:From:Date:From;
	b=D3yo/aEOXHXmdrIrIh1iX2TiRZ3gssOaw4yPbX0x17Cs/xL/Lh09RkGwcZjM62EVk
	 Yflz6+GmS2+mhdbhFYjy4Fz3As280+E4NEcPJ8RSi3TOF33HvqzkmVE5TQ5s8i0ump
	 OElVV/PCJ0So9vwU7tVcPqeWUyY2LdmsIlv2iLhk=
Subject: FAILED: patch "[PATCH] arm64: mm: Populate vmemmap at the page level if not section" failed to apply to 5.15-stable tree
To: quic_zhenhuah@quicinc.com,catalin.marinas@arm.com,david@redhat.com,osalvador@suse.de,will@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 16 Mar 2025 08:23:27 +0100
Message-ID: <2025031627-capture-pouring-5da4@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x d4234d131b0a3f9e65973f1cdc71bb3560f5d14b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025031627-capture-pouring-5da4@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From d4234d131b0a3f9e65973f1cdc71bb3560f5d14b Mon Sep 17 00:00:00 2001
From: Zhenhua Huang <quic_zhenhuah@quicinc.com>
Date: Tue, 4 Mar 2025 15:27:00 +0800
Subject: [PATCH] arm64: mm: Populate vmemmap at the page level if not section
 aligned

On the arm64 platform with 4K base page config, SECTION_SIZE_BITS is set
to 27, making one section 128M. The related page struct which vmemmap
points to is 2M then.
Commit c1cc1552616d ("arm64: MMU initialisation") optimizes the
vmemmap to populate at the PMD section level which was suitable
initially since hot plug granule is always one section(128M). However,
commit ba72b4c8cf60 ("mm/sparsemem: support sub-section hotplug")
introduced a 2M(SUBSECTION_SIZE) hot plug granule, which disrupted the
existing arm64 assumptions.

The first problem is that if start or end is not aligned to a section
boundary, such as when a subsection is hot added, populating the entire
section is wasteful.

The next problem is if we hotplug something that spans part of 128 MiB
section (subsections, let's call it memblock1), and then hotplug something
that spans another part of a 128 MiB section(subsections, let's call it
memblock2), and subsequently unplug memblock1, vmemmap_free() will clear
the entire PMD entry which also supports memblock2 even though memblock2
is still active.

Assuming hotplug/unplug sizes are guaranteed to be symmetric. Do the
fix similar to x86-64: populate to pages levels if start/end is not aligned
with section boundary.

Cc: stable@vger.kernel.org # v5.4+
Fixes: ba72b4c8cf60 ("mm/sparsemem: support sub-section hotplug")
Acked-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Zhenhua Huang <quic_zhenhuah@quicinc.com>
Reviewed-by: Oscar Salvador <osalvador@suse.de>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Link: https://lore.kernel.org/r/20250304072700.3405036-1-quic_zhenhuah@quicinc.com
Signed-off-by: Will Deacon <will@kernel.org>

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index b4df5bc5b1b8..1dfe1a8efdbe 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -1177,8 +1177,11 @@ int __meminit vmemmap_populate(unsigned long start, unsigned long end, int node,
 		struct vmem_altmap *altmap)
 {
 	WARN_ON((start < VMEMMAP_START) || (end > VMEMMAP_END));
+	/* [start, end] should be within one section */
+	WARN_ON_ONCE(end - start > PAGES_PER_SECTION * sizeof(struct page));
 
-	if (!IS_ENABLED(CONFIG_ARM64_4K_PAGES))
+	if (!IS_ENABLED(CONFIG_ARM64_4K_PAGES) ||
+	    (end - start < PAGES_PER_SECTION * sizeof(struct page)))
 		return vmemmap_populate_basepages(start, end, node, altmap);
 	else
 		return vmemmap_populate_hugepages(start, end, node, altmap);


