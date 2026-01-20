Return-Path: <stable+bounces-210540-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UCJFNP+ZcGnHYgAAu9opvQ
	(envelope-from <stable+bounces-210540-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 10:18:55 +0100
X-Original-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 29A69543CC
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 10:18:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CB48E867544
	for <lists+stable@lfdr.de>; Tue, 20 Jan 2026 13:15:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBC313DA7FE;
	Tue, 20 Jan 2026 13:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cji5i8Da"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABC1B3491F6
	for <stable@vger.kernel.org>; Tue, 20 Jan 2026 13:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768914847; cv=none; b=JbzyXsptX83uS81J4Cvt1vLJfIkkCxtvP0AyEVYFESvQl+uwW4VXoYxdWfwFUVgnz1V+XFOjcUGHzJXwb3KIzkINCRBHZTIcoNOhxNqYvaJH1xRHSqWmkAXSIlCSW6Lr1AnbO0suJ64brADELd1CBXR5pnl3zLeX242Omt0AehM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768914847; c=relaxed/simple;
	bh=TPrmhATyhlHtwPEsGxSguZyJGDFAwvlmHvpTQS5C/n4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=YJchR+uOCKivPQN7y0bGx7KmgKufQQ0alN2Chvo60BR4pgqfoNqyCLCX1Un2DKBjodbeB5irdxLzeFuREve0ULJwACE9otUqaQElp712wI61cUrRn0VKISvbkS/9qyHZvPsV/Mj66CRyF2PlqE0lSuegYMtG1/aSW4DgE0uKdjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cji5i8Da; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5FB6C16AAE;
	Tue, 20 Jan 2026 13:14:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1768914847;
	bh=TPrmhATyhlHtwPEsGxSguZyJGDFAwvlmHvpTQS5C/n4=;
	h=Subject:To:Cc:From:Date:From;
	b=cji5i8Da0koXytcvreuTyOL3Ke2Kl9W7WTKOLDtaTvZ1XgAwe1udDGbRvUHyxkhPA
	 1vJqeLzgAYJSITTWhHBxLXJ7rnmV2iNpZV8g6Nhy4sNur4Bbn0vE4Wy7Fo73xYo8eL
	 Fr2C8nvwQ7m7lIDuGdCseI5eflUyQ9vocjCEN3Nw=
Subject: FAILED: patch "[PATCH] mm/vma: enforce VMA fork limit on unfaulted,faulted mremap" failed to apply to 6.18-stable tree
To: lorenzo.stoakes@oracle.com,aha310510@gmail.com,akpm@linux-foundation.org,david@kernel.org,harry.yoo@oracle.com,jannh@google.com,liam.howlett@oracle.com,pfalcato@suse.de,riel@surriel.com,stable@vger.kernel.org,vbabka@suse.cz,yeoreum.yun@arm.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 20 Jan 2026 14:14:04 +0100
Message-ID: <2026012004-conduit-immorally-15d5@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [2.54 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-210540-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[oracle.com,gmail.com,linux-foundation.org,kernel.org,google.com,suse.de,surriel.com,vger.kernel.org,suse.cz,arm.com];
	DMARC_POLICY_ALLOW(0.00)[linuxfoundation.org,none];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	TO_DN_NONE(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 29A69543CC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 3b617fd3d317bf9dd7e2c233e56eafef05734c9d
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026012004-conduit-immorally-15d5@gregkh' --subject-prefix 'PATCH 6.18.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 3b617fd3d317bf9dd7e2c233e56eafef05734c9d Mon Sep 17 00:00:00 2001
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Date: Mon, 5 Jan 2026 20:11:49 +0000
Subject: [PATCH] mm/vma: enforce VMA fork limit on unfaulted,faulted mremap
 merge too

The is_mergeable_anon_vma() function uses vmg->middle as the source VMA.
However when merging a new VMA, this field is NULL.

In all cases except mremap(), the new VMA will either be newly established
and thus lack an anon_vma, or will be an expansion of an existing VMA thus
we do not care about whether VMA is CoW'd or not.

In the case of an mremap(), we can end up in a situation where we can
accidentally allow an unfaulted/faulted merge with a VMA that has been
forked, violating the general rule that we do not permit this for reasons
of anon_vma lock scalability.

Now we have the ability to be aware of the fact we are copying a VMA and
also know which VMA that is, we can explicitly check for this, so do so.

This is pertinent since commit 879bca0a2c4f ("mm/vma: fix incorrectly
disallowed anonymous VMA merges"), as this patch permits unfaulted/faulted
merges that were previously disallowed running afoul of this issue.

While we are here, vma_had_uncowed_parents() is a confusing name, so make
it simple and rename it to vma_is_fork_child().

Link: https://lkml.kernel.org/r/6e2b9b3024ae1220961c8b81d74296d4720eaf2b.1767638272.git.lorenzo.stoakes@oracle.com
Fixes: 879bca0a2c4f ("mm/vma: fix incorrectly disallowed anonymous VMA merges")
Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Reviewed-by: Harry Yoo <harry.yoo@oracle.com>
Reviewed-by: Jeongjun Park <aha310510@gmail.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
Cc: David Hildenbrand (Red Hat) <david@kernel.org>
Cc: Jann Horn <jannh@google.com>
Cc: Liam Howlett <liam.howlett@oracle.com>
Cc: Pedro Falcato <pfalcato@suse.de>
Cc: Rik van Riel <riel@surriel.com>
Cc: Yeoreum Yun <yeoreum.yun@arm.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/mm/vma.c b/mm/vma.c
index 9df9e3b78604..dc92f3dd8514 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -67,18 +67,13 @@ struct mmap_state {
 		.state = VMA_MERGE_START,				\
 	}
 
-/*
- * If, at any point, the VMA had unCoW'd mappings from parents, it will maintain
- * more than one anon_vma_chain connecting it to more than one anon_vma. A merge
- * would mean a wider range of folios sharing the root anon_vma lock, and thus
- * potential lock contention, we do not wish to encourage merging such that this
- * scales to a problem.
- */
-static bool vma_had_uncowed_parents(struct vm_area_struct *vma)
+/* Was this VMA ever forked from a parent, i.e. maybe contains CoW mappings? */
+static bool vma_is_fork_child(struct vm_area_struct *vma)
 {
 	/*
 	 * The list_is_singular() test is to avoid merging VMA cloned from
-	 * parents. This can improve scalability caused by anon_vma lock.
+	 * parents. This can improve scalability caused by the anon_vma root
+	 * lock.
 	 */
 	return vma && vma->anon_vma && !list_is_singular(&vma->anon_vma_chain);
 }
@@ -115,11 +110,19 @@ static bool is_mergeable_anon_vma(struct vma_merge_struct *vmg, bool merge_next)
 	VM_WARN_ON(src && src_anon != src->anon_vma);
 
 	/* Case 1 - we will dup_anon_vma() from src into tgt. */
-	if (!tgt_anon && src_anon)
-		return !vma_had_uncowed_parents(src);
+	if (!tgt_anon && src_anon) {
+		struct vm_area_struct *copied_from = vmg->copied_from;
+
+		if (vma_is_fork_child(src))
+			return false;
+		if (vma_is_fork_child(copied_from))
+			return false;
+
+		return true;
+	}
 	/* Case 2 - we will simply use tgt's anon_vma. */
 	if (tgt_anon && !src_anon)
-		return !vma_had_uncowed_parents(tgt);
+		return !vma_is_fork_child(tgt);
 	/* Case 3 - the anon_vma's are already shared. */
 	return src_anon == tgt_anon;
 }


