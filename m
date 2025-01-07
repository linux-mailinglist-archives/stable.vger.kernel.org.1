Return-Path: <stable+bounces-107865-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E8469A04503
	for <lists+stable@lfdr.de>; Tue,  7 Jan 2025 16:44:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C83283A133A
	for <lists+stable@lfdr.de>; Tue,  7 Jan 2025 15:44:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4A7B1F3D5B;
	Tue,  7 Jan 2025 15:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N4udjKS0"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE2E41F37AB
	for <stable@vger.kernel.org>; Tue,  7 Jan 2025 15:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736264637; cv=none; b=E8RDWvP2uiPMiwReN59aF6fSrieDppzS6/a2fWZCJRJBvpV9X94xvcBqjg59I1j66FOGC298ZZ2YOT7MjBmPrxNbMIqGXIO8LYS4yDdtn4h7dAbmpHDg8RPw4gVH3LIteJa6Zp09kapKmP1+DPkVlvVHxPwbdnS6jvBGtFt9LSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736264637; c=relaxed/simple;
	bh=kff/5MuiUSshICdL0Pz3Kwaact1TDCjVUg2HjOr3gSg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=klGjWUPxEnyhv2qcCXcnR6hoUhCxNsiALTgEjwv1OLxCRZAYC1lbY5xgwkjjZY0Y8tDKRlsqrN0n8hvUgtYT0Ai7O+4//px97TJHV+fxSy6lOnik+34/mTLN9S6gVoEvKUFJK8a1goYfocHXIF1SH20oAftlRa7h2UEWtRELuNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N4udjKS0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736264633;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=be/xDpPjneQ7+z88xrOgXMm6ql8CC9vSv4tySFvSNk8=;
	b=N4udjKS0AjQdA/wTSL3Ltv2Zqt24ZQN27aEcnbHauGnjRzp8kfghqGJEWhg3v4COHUQ1GY
	fT6xUamRVF7kIzcvfGuhaxJ7mXNjkJttkBR1DoIz6uwAJ59QG6wMd3Xke9AVPS+mvwIeat
	+rVLQELcQxpokl+p7kxJwu3GP3mpOAA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-245-dhKMVOxCNGiKNfMeq9uFEg-1; Tue, 07 Jan 2025 10:43:52 -0500
X-MC-Unique: dhKMVOxCNGiKNfMeq9uFEg-1
X-Mimecast-MFC-AGG-ID: dhKMVOxCNGiKNfMeq9uFEg
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-38a684a096eso1709414f8f.2
        for <stable@vger.kernel.org>; Tue, 07 Jan 2025 07:43:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736264629; x=1736869429;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=be/xDpPjneQ7+z88xrOgXMm6ql8CC9vSv4tySFvSNk8=;
        b=Ej2zGD7K9Dt9N+HrnFCHWcRzyDgRDqz6u40KFfBb733m+vuOyf3st0nhrI3bWGTcWy
         0ieCfGQtg339sf6Nbh9ogmJo/QIfcPaxfDEfREj2iiwzwmQ6OVgbFeBPpcEncneONCYU
         Rlu1qzkIYGoJh9cxwS8ZRP/wkLyaVrK+5Y//OrMvuVlmaWXvyV+V6PJ/FH3K3GmbB616
         URusEWsg9eIruC9ClQYGxHuuadUMxcxe4OaOJFKKvXKtrqBfAvxDmNYExpaByztN3lOq
         da+utgqTftd4G7LzjIfGbIuHo8M3Ojcbz2o6kBi8Dd400Px6KMORTPRiev8+Ruam3CY8
         XwxA==
X-Forwarded-Encrypted: i=1; AJvYcCWkU7euUF5df2alETlsIxR+zIsSk//xiuKJQnbw80smpeXguMWxaYekMv11sdImlwRGMJwr2cM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3JoxsA3sbwSOmWLggCe3Yq8So8jfOeXn+76bVDWQX3i2G2T8u
	3PFkI1GltY1aB4CEGvIa1+TDR73VGsYJ7B93BeovZWDUO/DOzz+6h5kmXihx3JgkMBiKv/iPjXn
	G2OlaoK/NdIUzv7dUQ/ObXwt0HRi7uYxN5j2g7alUZupERIVx+dYq3A==
X-Gm-Gg: ASbGncv8bzB1R5gLslE7ZYKnd6s4zn5NRh/oyBiMlkgafOnxUTeL4pK+/kLhp8x+S/m
	SwzdnOK2zBgb+7G0iOGr4+9Aq1EpYHxGPiZ+IDpSTB99VwDlmjrFH6VweHEdcvjXxnu81FUOp8w
	h3mXm+3Yd3BymozDaDeTH+ssyrUnwJyDYfX94diN50GtOetfHdtcjoUzYLKM1ih/Wn4/3h8goEJ
	nGZ7SBqVa43e6ll8O3vMO/FErqnuMtwkq47Rhe0x5evWzqQVb7o+9bOZCQ/7yqH1zYNH/pv5L5b
	LavCDxhve9eoEmuLnQc0cG0CMGBypwl/53J0wQ5Erg==
X-Received: by 2002:a05:6000:1f88:b0:386:4034:f9a0 with SMTP id ffacd0b85a97d-38a22408cbemr49437405f8f.52.1736264629539;
        Tue, 07 Jan 2025 07:43:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IECHU3QXEd9DSMtt+gL3jnHOKISExr8ZSLHane3TsnWNkBR9T163eXOTOHhVFPDdEe315KvNw==
X-Received: by 2002:a05:6000:1f88:b0:386:4034:f9a0 with SMTP id ffacd0b85a97d-38a22408cbemr49437388f8f.52.1736264629175;
        Tue, 07 Jan 2025 07:43:49 -0800 (PST)
Received: from localhost (p200300cbc719170056dc6a88b509d3f3.dip0.t-ipconnect.de. [2003:cb:c719:1700:56dc:6a88:b509:d3f3])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-38a1c828d39sm52310207f8f.9.2025.01.07.07.43.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jan 2025 07:43:48 -0800 (PST)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org,
	linux-s390@vger.kernel.org,
	David Hildenbrand <david@redhat.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Janosch Frank <frankja@linux.ibm.com>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Thomas Huth <thuth@redhat.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	stable@vger.kernel.org
Subject: [PATCH v1 1/4] KVM: s390: vsie: fix some corner-cases when grabbing vsie pages
Date: Tue,  7 Jan 2025 16:43:41 +0100
Message-ID: <20250107154344.1003072-2-david@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250107154344.1003072-1-david@redhat.com>
References: <20250107154344.1003072-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
---
 arch/s390/kvm/vsie.c | 25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
index 150b9387860ad..0fb527b33734c 100644
--- a/arch/s390/kvm/vsie.c
+++ b/arch/s390/kvm/vsie.c
@@ -1362,8 +1362,14 @@ static struct vsie_page *get_vsie_page(struct kvm *kvm, unsigned long addr)
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
 
@@ -1393,15 +1399,20 @@ static struct vsie_page *get_vsie_page(struct kvm *kvm, unsigned long addr)
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
@@ -1496,7 +1507,9 @@ void kvm_s390_vsie_destroy(struct kvm *kvm)
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
-- 
2.47.1


