Return-Path: <stable+bounces-274335-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id pHDXGZFOVmqv3AAAu9opvQ
	(envelope-from <stable+bounces-274335-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 16:58:25 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 646DA756296
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 16:58:24 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=JvaJ6Sx7;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-274335-lists+stable=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="stable+bounces-274335-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CE79B302559A
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 14:52:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC9A048C8B9;
	Tue, 14 Jul 2026 14:52:10 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5740748C8C7
	for <stable@vger.kernel.org>; Tue, 14 Jul 2026 14:52:09 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784040730; cv=none; b=H4uMiWjsCug9V/L/Z0glReKI6Ql3f4LTtj/BSLoyZ2PnuyH3oZoLcwyTml4siRUmGxhTbPtDin/nv+Y1SNj/cDqOLK7H/vYuHYTLsCxS9HFtQPgSnd9fWsxmiu7YC81au09R4pgW2hNdpNdHwZ5KXMqIwpalZpum7y7bwWJWKVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784040730; c=relaxed/simple;
	bh=ovSXpTa1Oye6zbR175Q8rIEwQfkQFDUxmgweZlRZv8o=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=C3fUFe5M0/0lChnhwaaBDjc3aNGUOaDeDQ9AqGx2T31k/Dcin+SzIK9nGXTUXrt0eDAF+DQEIhjgAhAmUu9yt7hyNughfOpy7vewtV5oq6XcRHlIMEz3bkxpVG19wS5qXzHqFzJqeMduQXyFk4nRm4kOxl0wc5fnWwWRggHifmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JvaJ6Sx7; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCB041F000E9;
	Tue, 14 Jul 2026 14:52:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784040729;
	bh=S4dmAiRiOl8FI1XqXNwyaSc4nXeQpuYkPqWh2AERuDY=;
	h=Subject:To:Cc:From:Date;
	b=JvaJ6Sx7HgpjpVAamWQuLwtcB/YWbPxyenO31fegI8lg/iiQZYQUS4Rna8QMMR5D7
	 QT+mJDXTII4MKvhvZxYBITPq62kvguzLlN/uy9j/XFJWoRGVr6duKES0xsFUOxgBYz
	 /yP1iI8DRWuSnSCCDiyheWBljsHnJCkqdAfjNuss=
Subject: FAILED: patch "[PATCH] mm/slab: do not limit zeroing to orig_size when only red" failed to apply to 6.6-stable tree
To: vbabka@kernel.org,hao.li@linux.dev,harry@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 14 Jul 2026 16:52:03 +0200
Message-ID: <2026071403-afar-policy-60a2@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-274335-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:vbabka@kernel.org,m:hao.li@linux.dev,m:harry@kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gregkh:mid,msgid.link:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp,linuxfoundation.org:from_mime,linuxfoundation.org:dkim,linux.dev:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 646DA756296


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 648927ceb84021a25a0fbd5673740956f318d534
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026071403-afar-policy-60a2@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 648927ceb84021a25a0fbd5673740956f318d534 Mon Sep 17 00:00:00 2001
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Date: Wed, 10 Jun 2026 17:40:03 +0200
Subject: [PATCH] mm/slab: do not limit zeroing to orig_size when only red
 zoning is enabled

When init (zeroing) on allocation is requested, for kmalloc() we
generally have to zero the full object size even if a smaller size is
requested, in order to provide krealloc()'s __GFP_ZERO guarantees.

But if we track the requested size, krealloc() uses that information to
do the right thing, so we can zero only the requested size. With red
zoning also enabled, any extra size became part of the red zone, so it
must not be zeroed and thus we must zero only the requested size.

However the current check is imprecise, and will trigger also when only
SLAB_RED_ZONE is enabled without SLAB_STORE_USER (which enables tracking
the requested size). This means enabling red zoning alone can compromise
krealloc()'s __GFP_ZERO contract.

Fix this by using slub_debug_orig_size() instead, which is the exact
check for whether the requested size is tracked. We don't need to care
if red zoning is also enabled or not. Also update and expand the
comment accordingly.

Fixes: 9ce67395f5a0 ("mm/slub: only zero requested size of buffer for kzalloc when debug enabled")
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260610-slab_alloc_flags-v2-1-7190909db118@kernel.org
Reviewed-by: Harry Yoo (Oracle) <harry@kernel.org>
Reviewed-by: Hao Li <hao.li@linux.dev>
Signed-off-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>

diff --git a/mm/slub.c b/mm/slub.c
index ff83345d7f95..e9f827a24a1e 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -4574,15 +4574,17 @@ bool slab_post_alloc_hook(struct kmem_cache *s, struct list_lru *lru,
 	gfp_t init_flags = flags & gfp_allowed_mask;
 
 	/*
-	 * For kmalloc object, the allocated memory size(object_size) is likely
-	 * larger than the requested size(orig_size). If redzone check is
-	 * enabled for the extra space, don't zero it, as it will be redzoned
-	 * soon. The redzone operation for this extra space could be seen as a
-	 * replacement of current poisoning under certain debug option, and
-	 * won't break other sanity checks.
+	 * For kmalloc object, the allocated size (object_size) can be larger
+	 * than the requested size (orig_size). We however need to zero the
+	 * whole object_size to handle possible later krealloc() with
+	 *__GFP_ZERO properly.
+	 *
+	 * But if we keep track of the requested size, krealloc() uses that
+	 * information. Additionally if red zoning is enabled, the extra space
+	 * is also red zone, so we should not overwrite it. So limit zeroing to
+	 * orig_size if we track it.
 	 */
-	if (kmem_cache_debug_flags(s, SLAB_STORE_USER | SLAB_RED_ZONE) &&
-	    (s->flags & SLAB_KMALLOC))
+	if (slub_debug_orig_size(s))
 		zero_size = orig_size;
 
 	/*


