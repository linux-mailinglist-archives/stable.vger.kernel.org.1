Return-Path: <stable+bounces-242679-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +x11DHI392nQdgIAu9opvQ
	(envelope-from <stable+bounces-242679-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 03 May 2026 13:54:26 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 83AEF4B568D
	for <lists+stable@lfdr.de>; Sun, 03 May 2026 13:54:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 86459300797E
	for <lists+stable@lfdr.de>; Sun,  3 May 2026 11:48:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5AE1319847;
	Sun,  3 May 2026 11:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RHx3YXgn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69C5B2E093A
	for <stable@vger.kernel.org>; Sun,  3 May 2026 11:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777808906; cv=none; b=dHm8dp09vPmbTIg5IgAirMktwLaUZ3PfkPZtxsu444Tt57pld6O9o5RvIt1QZfIygQMh4MrqXSl2GWL+PzX+oDl5CLjxnfUpy7sIapV4g3mtusNTBASzFLmS4IikLZp4+Y+NR+0CJbY+L1cgztlp5xChjeQ1b0Zu29rhS4Jb7dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777808906; c=relaxed/simple;
	bh=3BQmFoNBU5tMjC1C37bKkk0zz6h69OBMBF30nd5Ot0M=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=o8LP3CcadNscu90foS+GU68P1WyvaIVE9pwG6O1S90PmgDxIeS8L6yf00DSXJRMTuXkj0pzz8Ehb2OnuGeVx7f4dZQWz3Q+nRBG+oYe1m7IRDiGQTvGSXcuKbpyyLlmU34CuZ4InwOUXUsZ7svO8C8kGPVoNVsOt95zHNsYwIME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RHx3YXgn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7184C2BCB4;
	Sun,  3 May 2026 11:48:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777808906;
	bh=3BQmFoNBU5tMjC1C37bKkk0zz6h69OBMBF30nd5Ot0M=;
	h=Subject:To:Cc:From:Date:From;
	b=RHx3YXgn13Y+5cawMAxuAPilDfIfGvZLh6G9i/ssoKsbewMThmhm8jkx9Qr3WKyHx
	 +wEv696w1sBWjds1LJfnin+D31rKKCWP19+EMNfqwbk3kz8tMmFC4wYBUizYfx5JIt
	 Tg0xJoqbohxEFUHddoF98OjBcGC/2hmSMO1daqTQ=
Subject: FAILED: patch "[PATCH] mm/swap: fix swap cache memcg accounting" failed to apply to 7.0-stable tree
To: alex@ghiti.fr,akpm@linux-foundation.org,baohua@kernel.org,bhe@redhat.com,chrisl@kernel.org,hannes@cmpxchg.org,kasong@tencent.com,nphamcs@gmail.com,shikemeng@huaweicloud.com,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 03 May 2026 13:48:23 +0200
Message-ID: <2026050323-multiple-goatskin-d808@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 83AEF4B568D
X-Rspamd-Action: add header
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [7.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	SEM_URIBL(3.50)[huaweicloud.com:email];
	MID_RHS_NOT_FQDN(0.50)[];
	MAILLIST(-0.15)[generic];
	BAD_REP_POLICIES(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-242679-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[linuxfoundation.org,none];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	R_DKIM_ALLOW(0.00)[linuxfoundation.org:s=korg];
	GREYLIST(0.00)[pass,body];
	FREEMAIL_TO(0.00)[ghiti.fr,linux-foundation.org,kernel.org,redhat.com,cmpxchg.org,tencent.com,gmail.com,huaweicloud.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_NO_DN(0.00)[];
	R_SPF_ALLOW(0.00)[+ip4:172.105.105.114];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Spam: Yes


The patch below does not apply to the 7.0-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-7.0.y
git checkout FETCH_HEAD
git cherry-pick -x 9acbe135588e25070e963c0f066019cbeeb30c07
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026050323-multiple-goatskin-d808@gregkh' --subject-prefix 'PATCH 7.0.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 9acbe135588e25070e963c0f066019cbeeb30c07 Mon Sep 17 00:00:00 2001
From: Alexandre Ghiti <alex@ghiti.fr>
Date: Fri, 20 Mar 2026 06:05:59 +0100
Subject: [PATCH] mm/swap: fix swap cache memcg accounting

The swap readahead path was recently refactored and while doing this, the
order between the charging of the folio in the memcg and the addition of
the folio in the swap cache was inverted.

Since the accounting of the folio is done while adding the folio to the
swap cache and the folio is not charged in the memcg yet, the accounting
is then done at the node level, which is wrong.

Fix this by charging the folio in the memcg before adding it to the swap cache.

Link: https://lkml.kernel.org/r/20260320050601.1833108-1-alex@ghiti.fr
Fixes: 2732acda82c9 ("mm, swap: use swap cache as the swap in synchronize layer")
Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
Acked-by: Kairui Song <kasong@tencent.com>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
Reviewed-by: Nhat Pham <nphamcs@gmail.com>
Acked-by: Chris Li <chrisl@kernel.org>
Cc: Alexandre Ghiti <alex@ghiti.fr>
Cc: Baoquan He <bhe@redhat.com>
Cc: Barry Song <baohua@kernel.org>
Cc: Kemeng Shi <shikemeng@huaweicloud.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/mm/swap_state.c b/mm/swap_state.c
index 6313b59d7eab..1415a5c54a43 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -472,6 +472,10 @@ static struct folio *__swap_cache_prepare_and_add(swp_entry_t entry,
 
 	__folio_set_locked(folio);
 	__folio_set_swapbacked(folio);
+
+	if (!charged && mem_cgroup_swapin_charge_folio(folio, NULL, gfp, entry))
+		goto failed;
+
 	for (;;) {
 		ret = swap_cache_add_folio(folio, entry, &shadow);
 		if (!ret)
@@ -492,11 +496,6 @@ static struct folio *__swap_cache_prepare_and_add(swp_entry_t entry,
 			goto failed;
 	}
 
-	if (!charged && mem_cgroup_swapin_charge_folio(folio, NULL, gfp, entry)) {
-		swap_cache_del_folio(folio);
-		goto failed;
-	}
-
 	memcg1_swapin(entry, folio_nr_pages(folio));
 	if (shadow)
 		workingset_refault(folio, shadow);


