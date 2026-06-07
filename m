Return-Path: <stable+bounces-261283-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id rGZzN9lHJWqkFwIAu9opvQ
	(envelope-from <stable+bounces-261283-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 07 Jun 2026 12:28:41 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 72EDF64FADE
	for <lists+stable@lfdr.de>; Sun, 07 Jun 2026 12:28:41 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=Hkta6gPe;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-261283-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-261283-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 02BE53014749
	for <lists+stable@lfdr.de>; Sun,  7 Jun 2026 10:26:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C7753264CE;
	Sun,  7 Jun 2026 10:26:00 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFB3B212564;
	Sun,  7 Jun 2026 10:25:58 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780827960; cv=none; b=YD0WWJlBHF98X/SuhO9cDYHaQeER4fty9JSr4frCkkcTX0EeJGu8SUbtYSUXXsBBU5jYmgNzoSdWpJRjE6eVh1VZQnLAQ/Kw0cbtgE8WKE+vJMpxBTHwBReyfOrqyF4DTK+5uWMetIocC9oofFtZSePMKMmFxbxCqJIcvqOTFzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780827960; c=relaxed/simple;
	bh=8P8LCJNZWG7PkocNuXIJ3t3Uny3ak8TTlhcjeEgd5YE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DKGoshwdaRXleJhwTDgel7RGz+EeM6K2MBPCIHQd6qUZtUWhKSOkr9nG4nm3ty/MGuX/cGa3k4GMkWZsDyUqMW3JjhK3FjrYXvzad3tTPEX+73BqZgpqE6FOvQKSiW/y334oz7dGCqA+g/9RpNGaOtEHSTGbv3sD43Cnql2sqWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Hkta6gPe; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 320761F00893;
	Sun,  7 Jun 2026 10:25:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780827958;
	bh=rz14DbPQuNodPcgbz5gk6LWlBSV8xWw8vTOdKN2cvGc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Hkta6gPeO2lg7A1otCCKq5TVZoH0Hd4jTRiPW/woxKwoKJGdZU7vLrZEk2Sj5ER79
	 klUsvLbRtOd4VHKshJLWNshJossAP8pdHF0Dv+/PzyZQfgmiKISPOcdi1zvS6yvHjo
	 hXs6k7zJ/OhAdSSd3kN1iBFBKPcpnWL96H3P0x6M=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Sunny Patel <nueralspacetech@gmail.com>,
	"David Hildenbrand (Arm)" <david@kernel.org>,
	Huang Ying <ying.huang@linux.alibaba.com>,
	Alistair Popple <apopple@nvidia.com>,
	Balbir Singh <balbirs@nvidia.com>,
	Byungchul Park <byungchul@sk.com>,
	Gregory Price <gourry@gourry.net>,
	Joshua Hahn <joshua.hahnjy@gmail.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Rakie Kim <rakie.kim@sk.com>,
	Zi Yan <ziy@nvidia.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 7.0 140/332] mm/migrate_device: fix pgtable leak in migrate_vma_insert_huge_pmd_page
Date: Sun,  7 Jun 2026 11:58:29 +0200
Message-ID: <20260607095733.235733630@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260607095728.031258202@linuxfoundation.org>
References: <20260607095728.031258202@linuxfoundation.org>
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
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-261283-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:nueralspacetech@gmail.com,m:david@kernel.org,m:ying.huang@linux.alibaba.com,m:apopple@nvidia.com,m:balbirs@nvidia.com,m:byungchul@sk.com,m:gourry@gourry.net,m:joshua.hahnjy@gmail.com,m:matthew.brost@intel.com,m:rakie.kim@sk.com,m:ziy@nvidia.com,m:akpm@linux-foundation.org,m:joshuahahnjy@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,kernel.org,linux.alibaba.com,nvidia.com,sk.com,gourry.net,intel.com,linux-foundation.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 72EDF64FADE

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sunny Patel <nueralspacetech@gmail.com>

commit 2c6f81d58741349298f51ff697d988cb42881453 upstream.

When migrate_vma_insert_huge_pmd_page() jumps to unlock_abort due
to a PMD check failure, the pgtable allocated earlier via
pte_alloc_one() is never freed, causing a memory leak.

Added free_abort label to release the pgtable in error path.

Link: https://lore.kernel.org/20260501115122.23288-1-nueralspacetech@gmail.com
Fixes: a30b48bf1b24 ("mm/migrate_device: implement THP migration of zone device pages")
Signed-off-by: Sunny Patel <nueralspacetech@gmail.com>
Acked-by: David Hildenbrand (Arm) <david@kernel.org>
Reviewed-by: Huang Ying <ying.huang@linux.alibaba.com>
Cc: Alistair Popple <apopple@nvidia.com>
Cc: Balbir Singh <balbirs@nvidia.com>
Cc: Byungchul Park <byungchul@sk.com>
Cc: Gregory Price <gourry@gourry.net>
Cc: Joshua Hahn <joshua.hahnjy@gmail.com>
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Rakie Kim <rakie.kim@sk.com>
Cc: Zi Yan <ziy@nvidia.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 mm/migrate_device.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/mm/migrate_device.c
+++ b/mm/migrate_device.c
@@ -846,7 +846,7 @@ static int migrate_vma_insert_huge_pmd_p
 	} else {
 		if (folio_is_zone_device(folio) &&
 		    !folio_is_device_coherent(folio)) {
-			goto abort;
+			goto free_abort;
 		}
 		entry = folio_mk_pmd(folio, vma->vm_page_prot);
 		if (vma->vm_flags & VM_WRITE)
@@ -899,6 +899,8 @@ static int migrate_vma_insert_huge_pmd_p
 
 unlock_abort:
 	spin_unlock(ptl);
+free_abort:
+	pte_free(vma->vm_mm, pgtable);
 abort:
 	for (i = 0; i < HPAGE_PMD_NR; i++)
 		src[i] &= ~MIGRATE_PFN_MIGRATE;



