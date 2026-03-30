Return-Path: <stable+bounces-231120-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wAT0AEVJymkQ7QUAu9opvQ
	(envelope-from <stable+bounces-231120-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 11:58:29 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 54D75358B6D
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 11:58:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1084930A8C2D
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 09:51:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CEEC3ACA7A;
	Mon, 30 Mar 2026 09:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OO67eA+a"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 412483822BA
	for <stable@vger.kernel.org>; Mon, 30 Mar 2026 09:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774864308; cv=none; b=W4/GUEf2bB3VT76FGcTFi4gwsjw/O+753uEGbPvtfin/dUCKHDbTKwPM5D3CtuxXF1w+OwgG0zmpbVp6XLLxZ2JiaugrU0QfZG54nLxMuCCNbIBWMj52V6DZRcGY2E0yXn+eaaMeKS0ipls8QH2ew2KtObiIZwgTTzS3cW07YT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774864308; c=relaxed/simple;
	bh=Ufuz2Xc4sGcebTWkSCE9jo9T5RgRWN2BnUZtkKlad0A=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=NElqT3ZS7uzzvq0BvLNT9UFb1K445fVIHByddh3F29WZH0hIJ13N0d8lkanpojqQpAm93znVKPNVQ4BnMXSYlMZAJRbDfmTzOS39WKkdCD3nXRlFCuDr0hLV9POMXrjTiImGngJVVcHFCNg4cSH99Gs7Gf0Ugs5JvIJXHgc46+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OO67eA+a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 870C0C4CEF7;
	Mon, 30 Mar 2026 09:51:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774864308;
	bh=Ufuz2Xc4sGcebTWkSCE9jo9T5RgRWN2BnUZtkKlad0A=;
	h=Subject:To:Cc:From:Date:From;
	b=OO67eA+aI/6kVKjkvwemGtTzOODVh+Q0o1KccaWqweSuT/WAhlKkhMukUS7o2amdk
	 OJMw8P4608EL0AvZQPoJpUiyIcx/oRXGj2KavI+LFsjMWu8NNW/SdyR1GwB9N7HFHF
	 /VUCCmKl1Ltjz4FCr3MtsN7uD06sPwrazkSdNMic=
Subject: FAILED: patch "[PATCH] mm/mseal: update VMA end correctly on merge" failed to apply to 6.18-stable tree
To: ljs@kernel.org,akpm@linux-foundation.org,antonius@bluedragonsec.com,david@kernel.org,jannh@google.com,jeffxu@chromium.org,liam.howlett@oracle.com,pfalcato@suse.de,stable@vger.kernel.org,vbabka@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 30 Mar 2026 11:51:44 +0200
Message-ID: <2026033044-debug-embargo-40fb@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-231120-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[chromium.org:email,linuxfoundation.org:dkim,bluedragonsec.com:email,oracle.com:email,gregkh:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.de:email]
X-Rspamd-Queue-Id: 54D75358B6D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 2697dd8ae721db4f6a53d4f4cbd438212a80f8dc
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026033044-debug-embargo-40fb@gregkh' --subject-prefix 'PATCH 6.18.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 2697dd8ae721db4f6a53d4f4cbd438212a80f8dc Mon Sep 17 00:00:00 2001
From: "Lorenzo Stoakes (Oracle)" <ljs@kernel.org>
Date: Fri, 27 Mar 2026 17:31:04 +0000
Subject: [PATCH] mm/mseal: update VMA end correctly on merge

Previously we stored the end of the current VMA in curr_end, and then upon
iterating to the next VMA updated curr_start to curr_end to advance to the
next VMA.

However, this doesn't take into account the fact that a VMA might be
updated due to a merge by vma_modify_flags(), which can result in curr_end
being stale and thus, upon setting curr_start to curr_end, ending up with
an incorrect curr_start on the next iteration.

Resolve the issue by setting curr_end to vma->vm_end unconditionally to
ensure this value remains updated should this occur.

While we're here, eliminate this entire class of bug by simply setting
const curr_[start/end] to be clamped to the input range and VMAs, which
also happens to simplify the logic.

Link: https://lkml.kernel.org/r/20260327173104.322405-1-ljs@kernel.org
Fixes: 6c2da14ae1e0 ("mm/mseal: rework mseal apply logic")
Signed-off-by: Lorenzo Stoakes (Oracle) <ljs@kernel.org>
Reported-by: Antonius <antonius@bluedragonsec.com>
Closes: https://lore.kernel.org/linux-mm/CAK8a0jwWGj9-SgFk0yKFh7i8jMkwKm5b0ao9=kmXWjO54veX2g@mail.gmail.com/
Suggested-by: David Hildenbrand (ARM) <david@kernel.org>
Acked-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
Reviewed-by: Pedro Falcato <pfalcato@suse.de>
Acked-by: David Hildenbrand (Arm) <david@kernel.org>
Cc: Jann Horn <jannh@google.com>
Cc: Jeff Xu <jeffxu@chromium.org>
Cc: Liam Howlett <liam.howlett@oracle.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/mm/mseal.c b/mm/mseal.c
index 316b5e1dec78..ac58643181f7 100644
--- a/mm/mseal.c
+++ b/mm/mseal.c
@@ -56,7 +56,6 @@ static int mseal_apply(struct mm_struct *mm,
 		unsigned long start, unsigned long end)
 {
 	struct vm_area_struct *vma, *prev;
-	unsigned long curr_start = start;
 	VMA_ITERATOR(vmi, mm, start);
 
 	/* We know there are no gaps so this will be non-NULL. */
@@ -66,6 +65,7 @@ static int mseal_apply(struct mm_struct *mm,
 		prev = vma;
 
 	for_each_vma_range(vmi, vma, end) {
+		const unsigned long curr_start = MAX(vma->vm_start, start);
 		const unsigned long curr_end = MIN(vma->vm_end, end);
 
 		if (!(vma->vm_flags & VM_SEALED)) {
@@ -79,7 +79,6 @@ static int mseal_apply(struct mm_struct *mm,
 		}
 
 		prev = vma;
-		curr_start = curr_end;
 	}
 
 	return 0;


