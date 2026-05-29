Return-Path: <stable+bounces-256676-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wEmEMF3NGWqNzAgAu9opvQ
	(envelope-from <stable+bounces-256676-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 19:31:09 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id ED4336067BF
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 19:31:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 80A9F30854CC
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 17:24:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EB5B385D7B;
	Fri, 29 May 2026 17:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CP/1ymRV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59BD7382F16;
	Fri, 29 May 2026 17:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780075461; cv=none; b=hXRAkivpcsGYuO2FHETgB6tKzHW/OAoinXJKFjY1zl733jZUVxk2RXWuce+KJA5X9fq1C9dPtrK6+isRPRXvWP7LHtjrVL2oOZ3/G3nXuEC/DUkyEFhLVD0RHt6d7yCLL4v6sLxEMglJpiFMOREQ7sIl7kYb4CwoLYpVC8mvt4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780075461; c=relaxed/simple;
	bh=zAhzZ6g2VJ/vzQqtegJOWymYQRoeShAfuNrc5d3THSY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rDMpjKlwSlXT62H3tGv/abmgTnT4Mp7qhLu1lnAulrdhbaHy/AyEh7L0PEHU7DGezccjDPIoxXVPfr2+WschrgNX3Xho+XiShshgubueGD5ytBwyMb+38gafcHtHUMlRxc7AffIy3UV3lLBrTXYn1sF0ccTcpqF0aaYZS36fKWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CP/1ymRV; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F3861F00898;
	Fri, 29 May 2026 17:24:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780075460;
	bh=iVoJCbkI8s/nRA3AM39fhnw9JOfOtPPsCwAz6Lm0b5Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CP/1ymRVjopu0mbNo8SQ13KnvFis4z0GUsv4n98d6LfjMJzaw4bVpCWrsy0bWsDo5
	 SNfXxNNj/rG9GwZV5YwwtfvXEnbnq2Ttyc76h3lEAPmqCLsNogeTialbWZlp1cBgjQ
	 6guZ6WiAYxF1lk9tetZZLqCxgbzUc+uiEY3SlC1aJOFJHfsmoPRi9ZesmbN5BQKcsT
	 7j72n6vXeGh4V+gUxbip/MepYAhUw3hrqgg40B54uEtvpOS+RWndrKLg08WCUVKk7B
	 EhC3OWm+oVznXAi/kvucVClV2vZ1QDMUiT9OiOGs5V+aBPnVCFux6SEePMFBZRnnFo
	 XBaOmyYSeh1eg==
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfauth.phl.internal (Postfix) with ESMTP id EFD09F4006E;
	Fri, 29 May 2026 13:24:18 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Fri, 29 May 2026 13:24:18 -0400
X-ME-Sender: <xms:wssZahfg1iyrILJmAVPn7Y5U71gDd_f-OFbYItmdd0KPr3aLCPjhIQ>
    <xme:wssZamzjlwLLUcujOH6KKlzR-PvvDyHa9Z2NXBsaygguBo-FVd16klFtnkK_fjf2E
    iW5z3kLcn-qSM7tzlzLMePx-KqFEv0KSlzt9hFSIFlAcFD2mI6XjA4>
X-ME-Received: <xmr:wssZaqLnOfsoBBQMQHAYUIYoUG0jX5HCxDlCdtIvnFwAQp9bt9GS9MxcWwivOA>
X-ME-Proxy-Cause: dmFkZTFrgX5MM3DUSJ7xzqsXiT9K7Mp6hFpPFfxmC0MA+iN7AjFohwvWx7oxJHZ+5oTsa/
    eNprXeJ/674yJe1dHbWF7GZb1XnToVb0R4autdIDJiozLrBStYEb9fpXa/2JrApUqbrre1
    LdBuyJn9i8qKcJffyvK1YIhy0raIMBiWiOnHjwA5r86k+Zhi6bSohRFuPzPhOdP14jnWJI
    /xiWZuCo09JkwaiWtT4Gp2J4EUMHafSQnln9uaxNuylCfDh3CVEdSw0SaHR74GjGjlbPAf
    5lIf5oHRJw+wgkoNP7G5YvX9mPChAnbwGYXnMrRN1deEijcEXsq+k9G0Lzj5Q5OMaNJVZP
    ynHfTSCMN2Wglln7FwCeGxWcRR9bI2b3w8oJShKhvuMKIwP0IBVzf44fyIK2FGEUvOK548
    Eq/sQNY5Z1h23soaVM4lhxLQFbLksIU3Fsd8HKslIEZ0s+EQ8tfFmkcDNslrl9b1g0noyB
    LxGGX71AMWfXhsgBQSLBvluF8XBHVSeIQ9sxPjxnVVXsDHHaAwEFV3ywTZoDM30+wwW2T+
    e1UAgp4FmIIfSe+xihledFa9IIacTucEedO4UqqAbpFgVcLaeNQxsxaRON9wmaMXnTxUnr
    JggfNJowpV6m3GFgUHO3Qq9TKFsPiXlu4b06H73uaWUCYGZiIDRpW/m3fzVA
X-ME-Proxy: <xmx:wssZanuLzrazh-39vUG6hczDKFciamDflbxJP20bLeZXbscQwzr4GQ>
    <xmx:wssZakRt97rWJ0ocgpp2stNMAFQhYcJTUDdwRcMkHcbBIFbSX100Iw>
    <xmx:wssZagTcunkjrPIn-hJ-SoryF7MMRp0AG6MRenIXzsmao8VRQswdtw>
    <xmx:wssZaoph53enRFsixzoXKibo1H-xB5oMXn2GCdjnyo1Ofv9-X8AqiQ>
    <xmx:wssZaoDPxFfR1qG98TB-qkzqNA8guPLhR4muQ4DkAhvNNa4Y2T4nAvuh>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 29 May 2026 13:24:18 -0400 (EDT)
From: "Kiryl Shutsemau (Meta)" <kas@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Lorenzo Stoakes <ljs@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	David Hildenbrand <david@kernel.org>,
	"Kiryl Shutsemau (Meta)" <kas@kernel.org>,
	stable@vger.kernel.org,
	Sashiko AI review <sashiko-bot@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Peter Xu <peterx@redhat.com>,
	Pedro Falcato <pfalcato@suse.de>,
	Alice Ryhl <aliceryhl@google.com>
Subject: [PATCH 6/6] userfaultfd: build __VMA_UFFD_FLAGS from config-gated masks
Date: Fri, 29 May 2026 18:23:30 +0100
Message-ID: <20260529172331.356655-7-kas@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260529172331.356655-1-kas@kernel.org>
References: <20260529172331.356655-1-kas@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo];
	TAGGED_FROM(0.00)[bounces-256676-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[104.64.211.4:from];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FROM_NEQ_ENVFROM(0.00)[kas@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[100.90.174.1:received,100.103.45.18:received,10.202.2.42:received,10.202.2.163:received];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: ED4336067BF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The VMA flags bitmap is a single word today: NUM_VMA_FLAG_BITS is
BITS_PER_LONG, so on 32-bit vma_flags_t holds only 32 bits. (The bitmap
type exists so this can grow past BITS_PER_LONG later; until it does,
anything declared above the first word is out of range on 32-bit.) The bit
enum nevertheless declares some bits unconditionally above BITS_PER_LONG --
VMA_UFFD_MINOR_BIT is 41, with VM_UFFD_MINOR == VM_NONE on 32-bit so no VMA
actually carries the bit.

__VMA_UFFD_FLAGS feeds VMA_UFFD_MINOR_BIT to mk_vma_flags() unconditionally.
On 32-bit that becomes __set_bit(41, &one_long), a write one word past the
end of the single-word bitmap. The compiler folds the out-of-bounds store
with wraparound (1UL << (41 % 32) == bit 9) into the first word; bit 9 is
already in __VMA_UFFD_FLAGS so the mask happens to come out right today, but
it is an out-of-bounds write all the same, and any high-numbered bit whose
mod-BITS_PER_LONG position is otherwise unused would silently OR an extra
bit into the mask.

Rather than feed bit numbers that may not exist on the current build to
mk_vma_flags(), build the mask from whole per-mode masks that collapse to
EMPTY_VMA_FLAGS when their feature is unavailable. Add
mk_vma_flags_from_masks() for that, and define VMA_UFFD_MISSING / _WP /
_MINOR alongside the VM_UFFD_* flags, gating VMA_UFFD_MINOR on the same
config as VM_UFFD_MINOR (which implies 64BIT, where bit 41 fits). An
out-of-range bit is then never materialised, on any arch, and the in-range
fast path stays a compile-time constant.

Fixes: 9ea35a25d51b ("mm: introduce VMA flags bitmap type")
Cc: stable@vger.kernel.org
Reported-by: Sashiko AI review <sashiko-bot@kernel.org>
Suggested-by: Lorenzo Stoakes <ljs@kernel.org>
Signed-off-by: Kiryl Shutsemau <kas@kernel.org>
Assisted-by: Claude:claude-opus-4-8
---
 include/linux/mm.h            | 39 +++++++++++++++++++++++++++++++++++
 include/linux/userfaultfd_k.h |  4 ++--
 2 files changed, 41 insertions(+), 2 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 0f2612a70fb1..485df9c2dbdd 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -496,6 +496,21 @@ enum {
 #else
 #define VM_UFFD_MINOR	VM_NONE
 #endif
+
+/*
+ * vma_flags_t masks for the userfaultfd VMA flags. VMA_UFFD_MINOR is gated on
+ * the same config as VM_UFFD_MINOR -- which implies 64BIT, where the bit fits
+ * -- so an out-of-range bit is never fed to mk_vma_flags() on a build whose
+ * bitmap cannot hold it.
+ */
+#define VMA_UFFD_MISSING	mk_vma_flags(VMA_UFFD_MISSING_BIT)
+#define VMA_UFFD_WP		mk_vma_flags(VMA_UFFD_WP_BIT)
+#ifdef CONFIG_HAVE_ARCH_USERFAULTFD_MINOR
+#define VMA_UFFD_MINOR		mk_vma_flags(VMA_UFFD_MINOR_BIT)
+#else
+#define VMA_UFFD_MINOR		EMPTY_VMA_FLAGS
+#endif
+
 #ifdef CONFIG_64BIT
 #define VM_ALLOW_ANY_UNCACHED	INIT_VM_FLAG(ALLOW_ANY_UNCACHED)
 #define VM_SEALED		INIT_VM_FLAG(SEALED)
@@ -1238,6 +1253,30 @@ static __always_inline void vma_flags_set_mask(vma_flags_t *flags,
 #define vma_flags_set(flags, ...) \
 	vma_flags_set_mask(flags, mk_vma_flags(__VA_ARGS__))
 
+static __always_inline vma_flags_t __mk_vma_flags_from_masks(size_t count,
+		const vma_flags_t *masks)
+{
+	vma_flags_t flags = EMPTY_VMA_FLAGS;
+	size_t i;
+
+	for (i = 0; i < count; i++)
+		vma_flags_set_mask(&flags, masks[i]);
+	return flags;
+}
+
+/*
+ * Combine pre-computed vma_flags_t masks into one value, e.g.:
+ *
+ * vma_flags_t flags = mk_vma_flags_from_masks(VMA_UFFD_WP, VMA_UFFD_MINOR);
+ *
+ * Unlike mk_vma_flags(), which takes bit numbers, this takes whole masks --
+ * each of which may be EMPTY_VMA_FLAGS when its feature is unavailable -- so a
+ * bit that does not exist on the current build is never materialised.
+ */
+#define mk_vma_flags_from_masks(...)					\
+	__mk_vma_flags_from_masks(COUNT_ARGS(__VA_ARGS__),		\
+		(const vma_flags_t []){__VA_ARGS__})
+
 /* Clear all of the to-clear flags in flags, non-atomically. */
 static __always_inline void vma_flags_clear_mask(vma_flags_t *flags,
 		vma_flags_t to_clear)
diff --git a/include/linux/userfaultfd_k.h b/include/linux/userfaultfd_k.h
index 3ec8e1071673..68edac4dcd78 100644
--- a/include/linux/userfaultfd_k.h
+++ b/include/linux/userfaultfd_k.h
@@ -23,8 +23,8 @@
 /* The set of all possible UFFD-related VM flags. */
 #define __VM_UFFD_FLAGS (VM_UFFD_MISSING | VM_UFFD_WP | VM_UFFD_MINOR)
 
-#define __VMA_UFFD_FLAGS mk_vma_flags(VMA_UFFD_MISSING_BIT, VMA_UFFD_WP_BIT, \
-				      VMA_UFFD_MINOR_BIT)
+#define __VMA_UFFD_FLAGS mk_vma_flags_from_masks(VMA_UFFD_MISSING, VMA_UFFD_WP, \
+						 VMA_UFFD_MINOR)
 
 /*
  * CAREFUL: Check include/uapi/asm-generic/fcntl.h when defining
-- 
2.54.0


