Return-Path: <stable+bounces-252147-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oLezHMb3DWry4wUAu9opvQ
	(envelope-from <stable+bounces-252147-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:04:54 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EC1445953DB
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:04:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 00E8930FA0F6
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 17:59:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83C413F888B;
	Wed, 20 May 2026 17:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="f7flWz51"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 640CB3FB05D;
	Wed, 20 May 2026 17:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779299917; cv=none; b=SAeBejJJrFzRhvRc4fFbhfWZlHChe0/AuNv5EaZ31zFgEHpqscY00XYfv6i4zqKcAjpBeDPldUeOffAnMDYBMlOUCf4xGmnc36iO0rjULBO8kY1nJyRJyYC6tL7VMM62cAsYVw4g/2B1mYSJRlK0yQgbn+VwycywSlzlbMU7frI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779299917; c=relaxed/simple;
	bh=qwcc+IUb6amthOQsTONK9TxTGy5WoRCcNV3cI4UEGC8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lE+imMT2zJN08ldvtOXk3lTbLAUfawSBz5bQO/Q9jAFRLchSxXnsgSEngfxWzN9Whx1b/k35pWo2QhGJZO1kCvoWWlTysfrMPvCqiq0mcGCCmTlDQO4WL4ycruyxLameYEX9YupMe3hm8/nn6CTP3ZmQuhlHpYUSb8PgfecUcv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=f7flWz51; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 651351F00893;
	Wed, 20 May 2026 17:58:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779299912;
	bh=QppCUaz5LiwWQtufzPZzFN9vWHlfIuvWip30x49TS/M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=f7flWz5155tZg7ZUUaGVQt+FKueLbMNr1xNEckOnsAwc//KWD4EeT/xamVTkp/hn+
	 jrjbsVmw1t+2DSgv8xuGNVST37AUNY4q4vABBr+DjDf9I7TuIfEsMWP2MOsXcpQtMD
	 0UOVW2Crq28QYay2G8SQPtaTKQcAFrBLoVVZX6SE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Aaron Sacks <contact@xchglabs.com>,
	Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 6.18 892/957] KVM: Reject wrapped offset in kvm_reset_dirty_gfn()
Date: Wed, 20 May 2026 18:22:55 +0200
Message-ID: <20260520162153.915437037@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162134.554764788@linuxfoundation.org>
References: <20260520162134.554764788@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-252147-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,msgid.link:url,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,xchglabs.com:email]
X-Rspamd-Queue-Id: EC1445953DB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Aaron Sacks <contact@xchglabs.com>

commit 577a8d3bae0531f0e5ccfac919cd8192f920a804 upstream.

kvm_reset_dirty_gfn() guards the gfn range with

	if (!memslot || (offset + __fls(mask)) >= memslot->npages)
		return;

but offset is u64 and the addition is unchecked.  The check can be
silently bypassed by a u64 wrap.

The dirty ring backing those entries is MAP_SHARED at
KVM_DIRTY_LOG_PAGE_OFFSET of the vcpu fd, so the VMM can rewrite the
slot and offset fields of any entry between when the kernel pushes
them and when KVM_RESET_DIRTY_RINGS consumes them.  On reset,
kvm_dirty_ring_reset() re-reads the values via READ_ONCE() and feeds
them straight back into this check; only the flags handshake is
treated as the handover, the slot/offset payload is taken on trust.

Crafting two entries

	entry[i].offset   = 0xffffffffffffffc1
	entry[i+1].offset = 0

makes the coalescing loop in kvm_dirty_ring_reset() compute

	delta = (s64)(0 - 0xffffffffffffffc1) = 63

which falls in [0, BITS_PER_LONG), so it folds entry[i+1] into the
existing mask by setting bit 63.  The trailing kvm_reset_dirty_gfn()
call then sees offset = 0xffffffffffffffc1 and __fls(mask) = 63;
the sum is 0 in u64 and the bounds check passes.

That offset propagates into kvm_arch_mmu_enable_log_dirty_pt_masked()
unchanged.  On the legacy MMU path -- kvm_memslots_have_rmaps() ==
true, i.e. shadow paging, any VM that has allocated shadow roots, or
a write-tracked slot -- it reaches gfn_to_rmap(), which indexes
slot->arch.rmap[0][] with a near-U64_MAX gfn.  That is an
out-of-bounds load of a kvm_rmap_head, followed by a conditional
clear of PT_WRITABLE_MASK in whatever the loaded pointer points at.
The path is reachable from any process holding /dev/kvm.

Range-check offset on its own first, so the addition cannot wrap.
memslot->npages is bounded well below U64_MAX, so once offset <
npages holds, offset + __fls(mask) (with __fls(mask) < BITS_PER_LONG)
stays in range.

Fixes: fb04a1eddb1a ("KVM: X86: Implement ring-based dirty memory tracking")
Cc: stable@vger.kernel.org
Signed-off-by: Aaron Sacks <contact@xchglabs.com>
Link: https://patch.msgid.link/20260512060742.1628959-1-contact@xchglabs.com/
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 virt/kvm/dirty_ring.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/virt/kvm/dirty_ring.c
+++ b/virt/kvm/dirty_ring.c
@@ -63,7 +63,8 @@ static void kvm_reset_dirty_gfn(struct k
 
 	memslot = id_to_memslot(__kvm_memslots(kvm, as_id), id);
 
-	if (!memslot || (offset + __fls(mask)) >= memslot->npages)
+	if (!memslot || offset >= memslot->npages ||
+	    offset + __fls(mask) >= memslot->npages)
 		return;
 
 	KVM_MMU_LOCK(kvm);



