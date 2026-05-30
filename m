Return-Path: <stable+bounces-258774-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wLDcG/wsG2pa/wgAu9opvQ
	(envelope-from <stable+bounces-258774-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 20:31:24 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C245E611E25
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 20:31:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3139030177AC
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 18:24:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 546FB21B191;
	Sat, 30 May 2026 18:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="F/gYzE3W"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30E0C17555;
	Sat, 30 May 2026 18:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780165494; cv=none; b=Jr49zu/ck0WQZq0SCmJDX5yBoAlfStFzr8muAS/A6+pGW0DDzyTOa9n+SI4q5oXIrGTz1VoOetaf5Eq4Zjtpvx5qbPO6AATDs4NYFOYNUb4uJQM+tR7Ycz8D5c2WuXgChAj742P4cvRndeXVtHPJJe6qt0wGsci7yaVGp12tA0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780165494; c=relaxed/simple;
	bh=BjlifChOd3kGMEwlDu66fe+lC7cVJ8uPBuyZlqpnbxk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xd0zFkLTyWWBa7rwPJAnIdnLtwYVXjT0FCetKaJqO3o3AfUMnQymRcmoPRlqxDMy989OLD3i4yucQVMu/GtdukRWst5qn4S0UOxLFikhTp2Ewttjw2yEiA/YwBuAG9gmGzSakYsijcpaNGfuqLMHa77KNnliiqHQCwV8DOWm/PI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=F/gYzE3W; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7254C1F00893;
	Sat, 30 May 2026 18:24:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780165493;
	bh=YRO1fblf2gBs5NioQQUM63HXz/DrVX50odqcNA0NHlg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=F/gYzE3W/XjwTyd8Qej9uAVSOyShZeSBEe2cmthzQ2uTXtoBXxR8ZKzAuPuajYeD7
	 6ZHQlAFM4eIgqniTaYv9wOIQFppZB/tnjQPLn8VL09uPpCgaXFGS6WSRoZ4UW4XJs6
	 jfdjCAAPQGLLGJ3AejGM0ksTLgqOeDe6YerFm1YM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Liam Merwick <liam.merwick@oracle.com>,
	Sean Christopherson <seanjc@google.com>
Subject: [PATCH 5.10 065/589] KVM: SEV: Drop WARN on large size for KVM_MEMORY_ENCRYPT_REG_REGION
Date: Sat, 30 May 2026 17:59:06 +0200
Message-ID: <20260530160226.307728475@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260530160224.570625122@linuxfoundation.org>
References: <20260530160224.570625122@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-258774-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.995];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,oracle.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: C245E611E25
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sean Christopherson <seanjc@google.com>

commit 8acffeef5ef720c35e513e322ab08e32683f32f2 upstream.

Drop the WARN in sev_pin_memory() on npages overflowing an int, as the
WARN is comically trivially to trigger from userspace, e.g. by doing:

  struct kvm_enc_region range = {
          .addr = 0,
          .size = -1ul,
  };

  __vm_ioctl(vm, KVM_MEMORY_ENCRYPT_REG_REGION, &range);

Note, the checks in sev_mem_enc_register_region() that presumably exist to
verify the incoming address+size are completely worthless, as both "addr"
and "size" are u64s and SEV is 64-bit only, i.e. they _can't_ be greater
than ULONG_MAX.  That wart will be cleaned up in the near future.

	if (range->addr > ULONG_MAX || range->size > ULONG_MAX)
		return -EINVAL;

Opportunistically add a comment to explain why the code calculates the
number of pages the "hard" way, e.g. instead of just shifting @ulen.

Fixes: 78824fabc72e ("KVM: SVM: fix svn_pin_memory()'s use of get_user_pages_fast()")
Cc: stable@vger.kernel.org
Reviewed-by: Liam Merwick <liam.merwick@oracle.com>
Tested-by: Liam Merwick <liam.merwick@oracle.com>
Link: https://patch.msgid.link/20260313003302.3136111-2-seanjc@google.com
Signed-off-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kvm/svm/sev.c |   11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -338,10 +338,16 @@ static struct page **sev_pin_memory(stru
 	if (ulen == 0 || uaddr + ulen < uaddr)
 		return ERR_PTR(-EINVAL);
 
-	/* Calculate number of pages. */
+	/*
+	 * Calculate the number of pages that need to be pinned to cover the
+	 * entire range.  Note!  This isn't simply ulen >> PAGE_SHIFT, as KVM
+	 * doesn't require the incoming address+size to be page aligned!
+	 */
 	first = (uaddr & PAGE_MASK) >> PAGE_SHIFT;
 	last = ((uaddr + ulen - 1) & PAGE_MASK) >> PAGE_SHIFT;
 	npages = (last - first + 1);
+	if (npages > INT_MAX)
+		return ERR_PTR(-EINVAL);
 
 	locked = sev->pages_locked + npages;
 	lock_limit = rlimit(RLIMIT_MEMLOCK) >> PAGE_SHIFT;
@@ -350,9 +356,6 @@ static struct page **sev_pin_memory(stru
 		return ERR_PTR(-ENOMEM);
 	}
 
-	if (WARN_ON_ONCE(npages > INT_MAX))
-		return ERR_PTR(-EINVAL);
-
 	/* Avoid using vmalloc for smaller buffers. */
 	size = npages * sizeof(struct page *);
 	if (size > PAGE_SIZE)



