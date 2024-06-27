Return-Path: <stable+bounces-56016-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E80E91B2EB
	for <lists+stable@lfdr.de>; Fri, 28 Jun 2024 01:42:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99B8E1C210D1
	for <lists+stable@lfdr.de>; Thu, 27 Jun 2024 23:42:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E01D1A2FCA;
	Thu, 27 Jun 2024 23:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="hSdBEOnw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33645199E93;
	Thu, 27 Jun 2024 23:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719531762; cv=none; b=iGxt07FAksHELe3ZlgP5X6GHl1cYCzGRqp8Hjfug2oQdSsEG4o0dLzSGSLCeoUKgNLgFaPVjTG+BJDixSanrEIMefojkp3ThKuWnaoY/xxp0pGe/CbzmrRQqZ+7mBVWx+NM2enEW2e9zTuRcZDl3wsK7hdvakW8ltgfUv5H2/ZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719531762; c=relaxed/simple;
	bh=UVmXA6jUe19uYVXpaid2zVROzXeTnX2Qz2Ei3VixeGI=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=QadlaqOuj2OVNmuVP1jXIkLcph1kNSybXJGQFS4E+gNEwWwRlsufuJJMnTaeSE4CYGj+ILNfuzTsGP5DvKVDQt6T/rPPNKnSPcZcHicqhHKp7o7TifV05277wId3YZf/fIpK0rUh3L2VJ3dQk7gz/gCt4peGwKKStt5mTGFcsIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=hSdBEOnw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B3C5C2BBFC;
	Thu, 27 Jun 2024 23:42:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1719531761;
	bh=UVmXA6jUe19uYVXpaid2zVROzXeTnX2Qz2Ei3VixeGI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hSdBEOnwgwj0D7ivvCKaG2MzGpG7X1/xOASAqSCdx66S8uAQhtbH5EgwNig9AQaXA
	 4x7T5+LTTrXKqFusK2+W9TVgvn4sLq0D1aThH0Dq39fuyFwOtktFzwpQL0S+x+ssz/
	 q7VVvvbtyFm5EROtYYSrE/lm5QoZ4G+0AvweuIr8=
Date: Thu, 27 Jun 2024 16:42:40 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Yang Shi <yang@os.amperecomputing.com>
Cc: peterx@redhat.com, yangge1116@126.com, david@redhat.com,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Vivek Kasireddy <vivek.kasireddy@intel.com>
Subject: Re: [v2 linus-tree PATCH] mm: gup: do not call try_grab_folio() in
 slow path
Message-Id: <20240627164240.47ae4e1d0e7b1ddb11aedaf3@linux-foundation.org>
In-Reply-To: <20240627231601.1713119-1-yang@os.amperecomputing.com>
References: <20240627231601.1713119-1-yang@os.amperecomputing.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 27 Jun 2024 16:16:01 -0700 Yang Shi <yang@os.amperecomputing.com> wrote:

> The try_grab_folio() is supposed to be used in fast path and it elevates
> folio refcount by using add ref unless zero.  We are guaranteed to have
> at least one stable reference in slow path, so the simple atomic add
> could be used.  The performance difference should be trivial, but the
> misuse may be confusing and misleading.
> 
> In another thread [1] a kernel warning was reported when pinning folio
> in CMA memory when launching SEV virtual machine.  The splat looks like:
> 
> [  464.325306] WARNING: CPU: 13 PID: 6734 at mm/gup.c:1313 __get_user_pages+0x423/0x520
> [  464.325464] CPU: 13 PID: 6734 Comm: qemu-kvm Kdump: loaded Not tainted 6.6.33+ #6
> [  464.325477] RIP: 0010:__get_user_pages+0x423/0x520
> [  464.325515] Call Trace:
> [  464.325520]  <TASK>
> [  464.325523]  ? __get_user_pages+0x423/0x520
> [  464.325528]  ? __warn+0x81/0x130
> [  464.325536]  ? __get_user_pages+0x423/0x520
> [  464.325541]  ? report_bug+0x171/0x1a0
> [  464.325549]  ? handle_bug+0x3c/0x70
> [  464.325554]  ? exc_invalid_op+0x17/0x70
> [  464.325558]  ? asm_exc_invalid_op+0x1a/0x20
> [  464.325567]  ? __get_user_pages+0x423/0x520
> [  464.325575]  __gup_longterm_locked+0x212/0x7a0
> [  464.325583]  internal_get_user_pages_fast+0xfb/0x190
> [  464.325590]  pin_user_pages_fast+0x47/0x60
> [  464.325598]  sev_pin_memory+0xca/0x170 [kvm_amd]
> [  464.325616]  sev_mem_enc_register_region+0x81/0x130 [kvm_amd]
> 
> Per the analysis done by yangge, when starting the SEV virtual machine,
> it will call pin_user_pages_fast(..., FOLL_LONGTERM, ...) to pin the
> memory.  But the page is in CMA area, so fast GUP will fail then
> fallback to the slow path due to the longterm pinnalbe check in
> try_grab_folio().
> The slow path will try to pin the pages then migrate them out of CMA
> area.  But the slow path also uses try_grab_folio() to pin the page,
> it will also fail due to the same check then the above warning
> is triggered.
> 

The remainder of mm-unstable actually applies OK on top of this.

I applied the below as a fixup to Vivek's "mm/gup: introduce
memfd_pin_folios() for pinning memfd folios".  After this, your v1
patch reverts cleanly.

--- a/mm/gup.c~mm-gup-introduce-memfd_pin_folios-for-pinning-memfd-folios-fix
+++ a/mm/gup.c
@@ -3856,14 +3856,15 @@ long memfd_pin_folios(struct file *memfd
 				    next_idx != folio_index(fbatch.folios[i]))
 					continue;
 
-				folio = try_grab_folio(&fbatch.folios[i]->page,
-						       1, FOLL_PIN);
-				if (!folio) {
+				if (try_grab_folio(fbatch.folios[i],
+						       1, FOLL_PIN)) {
 					folio_batch_release(&fbatch);
 					ret = -EINVAL;
 					goto err;
 				}
 
+				folio = fbatch.folios[i];
+
 				if (nr_folios == 0)
 					*offset = offset_in_folio(folio, start);
 
_



