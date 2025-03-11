Return-Path: <stable+bounces-123367-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B6D61A5C52A
	for <lists+stable@lfdr.de>; Tue, 11 Mar 2025 16:12:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 840B5188B66C
	for <lists+stable@lfdr.de>; Tue, 11 Mar 2025 15:09:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56E9B25E446;
	Tue, 11 Mar 2025 15:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="A+zQ1Tgv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 131B08632E;
	Tue, 11 Mar 2025 15:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741705749; cv=none; b=DPOgvhcaxnCOHBdYG5teYh+cYKgbaW6O3t8xYXd+oIbBD3BDXsoC3HqbEMOC4wlusGiZphg+k4ZmPkhuWC4GGghYDN9fjL6IeNyekaz7LVFDIK+NMiO63+M+NCQvX143lvuSZzeXHvVXP4nJ0s3xN2UByCXo4Z0mz1vluv6bpqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741705749; c=relaxed/simple;
	bh=Ym2VEnu5WJVo97veq9NTRnECKNTMZSLl4EymodKE488=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t1CykAknUbPvTuoYk63FXqFSvZNY3ZYGX6ErVv5PuUFRlKRYJyWVAruNGUW1Q9xzMZPSxROBg/MU4bBPjXFgNEcAx3+lKAcwHxEesNp8ySNKuHAVy/XB/0FtWzAh6sN2iHwreu9Pwnl4Gob3ot3iM8im22cA3PrYj9ubQR2pg4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=A+zQ1Tgv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C894C4CEE9;
	Tue, 11 Mar 2025 15:09:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741705748;
	bh=Ym2VEnu5WJVo97veq9NTRnECKNTMZSLl4EymodKE488=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=A+zQ1TgvxLX6w+qbWzVcrqUqMyJfxenZ+tlUxbkwoJaDwNEuLUBAayR8b0K2hPaBd
	 zLuJHb7HgKtgSzmOrSPQCATKGcGFzpCSZaV81eGR3P9L0cbtzleTFJ2aqdN5RpLkTE
	 ylTJjhT5U5RxlUAhUgmgpMrOpufQN0N4+Nz5rvPE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	David Hildenbrand <david@redhat.com>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	Christoph Schlameuss <schlameuss@linux.ibm.com>
Subject: [PATCH 5.4 124/328] KVM: s390: vsie: fix some corner-cases when grabbing vsie pages
Date: Tue, 11 Mar 2025 15:58:14 +0100
Message-ID: <20250311145719.828332387@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250311145714.865727435@linuxfoundation.org>
References: <20250311145714.865727435@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Hildenbrand <david@redhat.com>

commit 5f230f41fdd9e799f43a699348dc572bca7159aa upstream.

We try to reuse the same vsie page when re-executing the vsie with a
given SCB address. The result is that we use the same shadow SCB --
residing in the vsie page -- and can avoid flushing the TLB when
re-running the vsie on a CPU.

So, when we allocate a fresh vsie page, or when we reuse a vsie page for
a different SCB address -- reusing the shadow SCB in different context --
we set ihcpu=0xffff to trigger the flush.

However, after we looked up the SCB address in the radix tree, but before
we grabbed the vsie page by raising the refcount to 2, someone could reuse
the vsie page for a different SCB address, adjusting page->index and the
radix tree. In that case, we would be reusing the vsie page with a
wrong page->index.

Another corner case is that we might set the SCB address for a vsie
page, but fail the insertion into the radix tree. Whoever would reuse
that page would remove the corresponding radix tree entry -- which might
now be a valid entry pointing at another page, resulting in the wrong
vsie page getting removed from the radix tree.

Let's handle such races better, by validating that the SCB address of a
vsie page didn't change after we grabbed it (not reuse for a different
SCB; the alternative would be performing another tree lookup), and by
setting the SCB address to invalid until the insertion in the tree
succeeded (SCB addresses are aligned to 512, so ULONG_MAX is invalid).

These scenarios are rare, the effects a bit unclear, and these issues were
only found by code inspection. Let's CC stable to be safe.

Fixes: a3508fbe9dc6 ("KVM: s390: vsie: initial support for nested virtualization")
Cc: stable@vger.kernel.org
Signed-off-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Reviewed-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
Tested-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
Message-ID: <20250107154344.1003072-2-david@redhat.com>
Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/s390/kvm/vsie.c |   25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

--- a/arch/s390/kvm/vsie.c
+++ b/arch/s390/kvm/vsie.c
@@ -1228,8 +1228,14 @@ static struct vsie_page *get_vsie_page(s
 	page = radix_tree_lookup(&kvm->arch.vsie.addr_to_page, addr >> 9);
 	rcu_read_unlock();
 	if (page) {
-		if (page_ref_inc_return(page) == 2)
-			return page_to_virt(page);
+		if (page_ref_inc_return(page) == 2) {
+			if (page->index == addr)
+				return page_to_virt(page);
+			/*
+			 * We raced with someone reusing + putting this vsie
+			 * page before we grabbed it.
+			 */
+		}
 		page_ref_dec(page);
 	}
 
@@ -1259,15 +1265,20 @@ static struct vsie_page *get_vsie_page(s
 			kvm->arch.vsie.next++;
 			kvm->arch.vsie.next %= nr_vcpus;
 		}
-		radix_tree_delete(&kvm->arch.vsie.addr_to_page, page->index >> 9);
+		if (page->index != ULONG_MAX)
+			radix_tree_delete(&kvm->arch.vsie.addr_to_page,
+					  page->index >> 9);
 	}
-	page->index = addr;
-	/* double use of the same address */
+	/* Mark it as invalid until it resides in the tree. */
+	page->index = ULONG_MAX;
+
+	/* Double use of the same address or allocation failure. */
 	if (radix_tree_insert(&kvm->arch.vsie.addr_to_page, addr >> 9, page)) {
 		page_ref_dec(page);
 		mutex_unlock(&kvm->arch.vsie.mutex);
 		return NULL;
 	}
+	page->index = addr;
 	mutex_unlock(&kvm->arch.vsie.mutex);
 
 	vsie_page = page_to_virt(page);
@@ -1360,7 +1371,9 @@ void kvm_s390_vsie_destroy(struct kvm *k
 		vsie_page = page_to_virt(page);
 		release_gmap_shadow(vsie_page);
 		/* free the radix tree entry */
-		radix_tree_delete(&kvm->arch.vsie.addr_to_page, page->index >> 9);
+		if (page->index != ULONG_MAX)
+			radix_tree_delete(&kvm->arch.vsie.addr_to_page,
+					  page->index >> 9);
 		__free_page(page);
 	}
 	kvm->arch.vsie.page_count = 0;



