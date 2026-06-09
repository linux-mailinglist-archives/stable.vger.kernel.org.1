Return-Path: <stable+bounces-262158-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id lLNjOhtrJ2qywQIAu9opvQ
	(envelope-from <stable+bounces-262158-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 09 Jun 2026 03:23:39 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 44B3B65B978
	for <lists+stable@lfdr.de>; Tue, 09 Jun 2026 03:23:39 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux-foundation.org header.s=korg header.b=k8BuAip2;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-262158-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-262158-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0F914304B265
	for <lists+stable@lfdr.de>; Tue,  9 Jun 2026 01:22:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE36A301474;
	Tue,  9 Jun 2026 01:22:39 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C12872F8EAE;
	Tue,  9 Jun 2026 01:22:38 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780968159; cv=none; b=dlbzw2x1oygcWx9mjNdYmxbpLcmBtk0Eiao6UBWkKAU3ca139tMjpAOFDdI9HKCaerQ0arpv7lzbHl3VGX3vK9Cy11IV7y9VLLt1ja1jD04poIkpnidc+hOj0IxQ7t7pf+jogwtj8fy39DA2T/1EQfMIgsPSD/Tg6Jdgi/hj4zU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780968159; c=relaxed/simple;
	bh=O1+v4LCShKD6A32fmWAIJZLyDlo37pG4F+BaAGF0buk=;
	h=Date:To:From:Subject:Message-Id; b=p0JtEkMqp2iu1t6hIZs6qhEIRAE05rYVnAJ49KUkEaGpjArO1LEidzbAT40F5m8UQu/PwEuKMglv+bsund1BA3V+tq8QrPaLZpgi5ec0rYDsA5ocKyzp+e4yju0zd3LwexzZrW7a0dz9ig1MncuNHSknT+Vxld62zGPMlu3x+Rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=k8BuAip2; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 957CC1F00898;
	Tue,  9 Jun 2026 01:22:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1780968158;
	bh=lgYtFOKnT9VEL/cEG9aAa7jUaMRyoj5EyO57nZCwrug=;
	h=Date:To:From:Subject;
	b=k8BuAip2adeb85B9JV0RH0vhPunmcxgH7t099nkuoSyPK1VR5pAs4m+xXuPyy+jW6
	 ImPsYVnBDxyBkmthQBHONO+4E1AAXlNReJxV2k3MJ5rz2V0iO7e8uUkSOx1+ujJW+q
	 BU27KiFgxQxr2/gQ4Bt5qAEurXX/zPPBloRudn0c=
Date: Mon, 08 Jun 2026 18:22:38 -0700
To: mm-commits@vger.kernel.org,vbabka@kernel.org,surenb@google.com,stable@vger.kernel.org,sashiko-bot@kernel.org,rppt@kernel.org,peterx@redhat.com,mhocko@suse.com,ljs@kernel.org,david@kernel.org,balbirs@nvidia.com,kas@kernel.org,akpm@linux-foundation.org
From: Andrew Morton <akpm@linux-foundation.org>
Subject: [merged mm-stable] mm-huge_memory-preserve-pmd_swp_uffd_wp-on-device-private-pmd-downgrade.patch removed from -mm tree
Message-Id: <20260609012238.957CC1F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-262158-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:mm-commits@vger.kernel.org,m:vbabka@kernel.org,m:surenb@google.com,m:stable@vger.kernel.org,m:sashiko-bot@kernel.org,m:rppt@kernel.org,m:peterx@redhat.com,m:mhocko@suse.com,m:ljs@kernel.org,m:david@kernel.org,m:balbirs@nvidia.com,m:kas@kernel.org,m:akpm@linux-foundation.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[linux-foundation.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[akpm@linux-foundation.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[13];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akpm@linux-foundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[smtp.kernel.org:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,suse.com:email,vger.kernel.org:from_smtp,linux-foundation.org:dkim,linux-foundation.org:email,linux-foundation.org:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 44B3B65B978


The quilt patch titled
     Subject: mm/huge_memory: preserve pmd_swp_uffd_wp on device-private PMD downgrade
has been removed from the -mm tree.  Its filename was
     mm-huge_memory-preserve-pmd_swp_uffd_wp-on-device-private-pmd-downgrade.patch

This patch was dropped because it was merged into the mm-stable branch
of git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm

------------------------------------------------------
From: "Kiryl Shutsemau (Meta)" <kas@kernel.org>
Subject: mm/huge_memory: preserve pmd_swp_uffd_wp on device-private PMD downgrade
Date: Fri, 29 May 2026 18:23:28 +0100

change_non_present_huge_pmd() rewrites a writable device-private PMD swap
entry into a readable one without carrying pmd_swp_uffd_wp() across.  The
PTE-level change_softleaf_pte() does this correctly; mirror that here,
matching what copy_huge_pmd() does for the fork path.  Without the carry,
a plain mprotect() over a UFFD_WP-marked device-private THP strips the bit
and the trap is bypassed on swap-in.

Link: https://lore.kernel.org/20260529172331.356655-5-kas@kernel.org
Fixes: 368076f52ebe ("mm/huge_memory: add device-private THP support to PMD operations")
Signed-off-by: Kiryl Shutsemau <kas@kernel.org>
Reported-by: Sashiko AI review <sashiko-bot@kernel.org>
Reviewed-by: Balbir Singh <balbirs@nvidia.com>
Cc: David Hildenbrand <david@kernel.org>
Cc: Lorenzo Stoakes <ljs@kernel.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: Peter Xu <peterx@redhat.com>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Vlastimil Babka <vbabka@kernel.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 mm/huge_memory.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/mm/huge_memory.c~mm-huge_memory-preserve-pmd_swp_uffd_wp-on-device-private-pmd-downgrade
+++ a/mm/huge_memory.c
@@ -2565,6 +2565,8 @@ static void change_non_present_huge_pmd(
 	} else if (softleaf_is_device_private_write(entry)) {
 		entry = make_readable_device_private_entry(swp_offset(entry));
 		newpmd = swp_entry_to_pmd(entry);
+		if (pmd_swp_uffd_wp(*pmd))
+			newpmd = pmd_swp_mkuffd_wp(newpmd);
 	} else {
 		newpmd = *pmd;
 	}
_

Patches currently in -mm which might be from kas@kernel.org are



