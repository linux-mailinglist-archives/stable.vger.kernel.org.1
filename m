Return-Path: <stable+bounces-263215-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id fH6jNDkKMGpKMQUAu9opvQ
	(envelope-from <stable+bounces-263215-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 15 Jun 2026 16:20:41 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C7846870F2
	for <lists+stable@lfdr.de>; Mon, 15 Jun 2026 16:20:41 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=RxPzfdqb;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-263215-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-263215-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9C2B0305C589
	for <lists+stable@lfdr.de>; Mon, 15 Jun 2026 14:20:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D0163EEAEB;
	Mon, 15 Jun 2026 14:20:18 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E90FF3ECBF9
	for <stable@vger.kernel.org>; Mon, 15 Jun 2026 14:20:16 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781533218; cv=none; b=g8yFO8GcgYE7wg0U3QkuOlwqOmb8d5PJzfBOaHBTwJ4Y5EA6+0nFMHJtaurXtNwEMz6x/7P+/dYF3061nw2MO22GPC3aENQ9uqIyq8jRAnm6gKJsuLybWzoGrCULdVx6tukm1LHnkCxZS4kAFcYdhPpW1vVkePA8mkbPfTvvjok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781533218; c=relaxed/simple;
	bh=juYASjf1D6ugQPBkomhXKA/ydwaIGM6WXocmCJQW2fo=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=J4G4h+anBleVUbRwHtjeQquSpMmHzI19up11nWleNoY12JzU1up6P/jUtA8f6sCtvSvIVZ5IHaBCB6Es2tVUKIivdyD4ZbxWs/6A+hHGHExm6/MuReky1qeq3r4XmvrWSSlJMVAoq7E69mdvK+YKqvEUlNEv4diCYMP4nIQl+y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RxPzfdqb; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82C4C1F000E9;
	Mon, 15 Jun 2026 14:20:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781533216;
	bh=nztbE1Ly6FSDAcZtgZf2zMKuYFmr+f8oaBd9xXZHO2A=;
	h=Subject:To:Cc:From:Date;
	b=RxPzfdqbBmvU0az62tinWGHFR6Q4gOOmlqLzMZO+PgldSNmQR3aBJksHuHFaVETAr
	 36qOnItbh0oEQQsLTBqB0AUQ8UVs7dX2C2UWBe9qUJXfnukyul+LgJC6/i87//+KuC
	 t7/YCaY7gw952zQ+kfgQ+wnWNSR2oEdNKt85QV2o=
Subject: FAILED: patch "[PATCH] mm/huge_memory: update file PMD counter before folio_put()" failed to apply to 6.6-stable tree
To: yintirui@huawei.com,akpm@linux-foundation.org,baohua@kernel.org,baolin.wang@linux.alibaba.com,chenjun102@huawei.com,david@kernel.org,dev.jain@arm.com,lance.yang@linux.dev,liam@infradead.org,ljs@kernel.org,npache@redhat.com,ryan.roberts@arm.com,stable@vger.kernel.org,vbabka@kernel.org,wangkefeng.wang@huawei.com,yang.shi@linux.alibaba.com,ziy@nvidia.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 15 Jun 2026 16:19:08 +0200
Message-ID: <2026061508-robin-cupid-c1e8@gregkh>
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
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-263215-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:yintirui@huawei.com,m:akpm@linux-foundation.org,m:baohua@kernel.org,m:baolin.wang@linux.alibaba.com,m:chenjun102@huawei.com,m:david@kernel.org,m:dev.jain@arm.com,m:lance.yang@linux.dev,m:liam@infradead.org,m:ljs@kernel.org,m:npache@redhat.com,m:ryan.roberts@arm.com,m:stable@vger.kernel.org,m:vbabka@kernel.org,m:wangkefeng.wang@huawei.com,m:yang.shi@linux.alibaba.com,m:ziy@nvidia.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_TWELVE(0.00)[18];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2C7846870F2


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 8d878059924f12c1bc24556a92ec56add74de3c8
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026061508-robin-cupid-c1e8@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 8d878059924f12c1bc24556a92ec56add74de3c8 Mon Sep 17 00:00:00 2001
From: Yin Tirui <yintirui@huawei.com>
Date: Tue, 26 May 2026 18:13:37 +0800
Subject: [PATCH] mm/huge_memory: update file PMD counter before folio_put()

__split_huge_pmd_locked() updates the file/shmem RSS counter after
dropping the PMD mapping's folio reference.  If folio_put() drops the last
reference, mm_counter_file() can later read freed folio state via
folio_test_swapbacked().

Move the counter update before folio_put().

Link: https://lore.kernel.org/20260526101337.1984081-1-yintirui@huawei.com
Fixes: fadae2953072 ("thp: use mm_file_counter to determine update which rss counter")
Signed-off-by: Yin Tirui <yintirui@huawei.com>
Reviewed-by: Lorenzo Stoakes <ljs@kernel.org>
Acked-by: David Hildenbrand (arm) <david@kernel.org>
Reviewed-by: Lance Yang <lance.yang@linux.dev>
Reviewed-by: Dev Jain <dev.jain@arm.com>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Barry Song <baohua@kernel.org>
Cc: Chen Jun <chenjun102@huawei.com>
Cc: Kefeng Wang <wangkefeng.wang@huawei.com>
Cc: Liam R. Howlett <liam@infradead.org>
Cc: Nico Pache <npache@redhat.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: Vlastimil Babka <vbabka@kernel.org>
Cc: Yang Shi <yang.shi@linux.alibaba.com>
Cc: Zi Yan <ziy@nvidia.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 1f78b73a0ca4..653f2dc03403 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3133,7 +3133,9 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
 			if (!folio_test_referenced(folio) && pmd_young(old_pmd))
 				folio_set_referenced(folio);
 			folio_remove_rmap_pmd(folio, page, vma);
+			add_mm_counter(mm, mm_counter_file(folio), -HPAGE_PMD_NR);
 			folio_put(folio);
+			return;
 		}
 		add_mm_counter(mm, mm_counter_file(folio), -HPAGE_PMD_NR);
 		return;


