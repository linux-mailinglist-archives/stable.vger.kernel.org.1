Return-Path: <stable+bounces-270281-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id f5xOHuKxRWo7EAsAu9opvQ
	(envelope-from <stable+bounces-270281-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 02:33:38 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 808446F2A2B
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 02:33:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux-foundation.org header.s=korg header.b=KMH9MiQV;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-270281-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-270281-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B01E13038167
	for <lists+stable@lfdr.de>; Thu,  2 Jul 2026 00:32:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 424F61F3BAC;
	Thu,  2 Jul 2026 00:32:25 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDD2C431E53;
	Thu,  2 Jul 2026 00:32:23 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782952345; cv=none; b=uhME3A98Yly2ooFMiSfKaV9M5Bzyhp/K0//3e5/ChkV2GlLAMJS/ePcj0LweFtyXKR0Mczc70mO9W/4jdW17s97PEppliKly6a8PDVSczaOc71nkUg/RDg1Fn+Inn4ypwYrcxYkZdZrkG5kb17hp6OnG9z/0+fAYRJD8kx7NEmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782952345; c=relaxed/simple;
	bh=+NIsTwvWHACM3Yz5EP0EQfv55ysBa1WuTH0Bywo+aUY=;
	h=Date:To:From:Subject:Message-Id; b=IqC4A3sMrI+MY46HkqEkbKGlPqMrbmG7ySK7sOs0xG59qcwr0DRSrF67HUcFvJ5BueHI7/Y69PSeMoDsC7xNF5vdT6segqvpr0wdfKqbxE751chVjfA6+lZ1NMV2B7bFvl1fsT89s2DzrvNUGWjqmTqMdws9MRKj9mDULk2jIlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=KMH9MiQV; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CEFA1F000E9;
	Thu,  2 Jul 2026 00:32:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1782952343;
	bh=OCTsahi7cPsMEYQZE+icz78dBTjEfh+NvNJzY5qKVHM=;
	h=Date:To:From:Subject;
	b=KMH9MiQV6phsEMN7Za//6DzSZWNiVbQDf4qzbUHGhoOWMEqo7eS4FNLFXcTnIdv4C
	 diHAqMxzPOLrMhecplv4WVDSKAfyPso/0uUlt8kCpGvrk3ONE2j7lio95MOrJqj2xu
	 jI3NabbCDH4xZEjjbzpWDJ+JqbX0mwuFj1OCNdZY=
Date: Wed, 01 Jul 2026 17:32:23 -0700
To: mm-commits@vger.kernel.org,willy@infradead.org,stable@vger.kernel.org,jack@suse.cz,hughd@google.com,brauner@kernel.org,yanzhen20011121@163.com,akpm@linux-foundation.org
From: Andrew Morton <akpm@linux-foundation.org>
Subject: + mm-fix-mapping_seek_hole_data-overflow-on-last-page.patch added to mm-new branch
Message-Id: <20260702003223.7CEFA1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[akpm@linux-foundation.org,stable@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-270281-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:mm-commits@vger.kernel.org,m:willy@infradead.org,m:stable@vger.kernel.org,m:jack@suse.cz,m:hughd@google.com,m:brauner@kernel.org,m:yanzhen20011121@163.com,m:akpm@linux-foundation.org,s:lists@lfdr.de];
	DMARC_NA(0.00)[linux-foundation.org];
	FREEMAIL_TO(0.00)[vger.kernel.org,infradead.org,suse.cz,google.com,kernel.org,163.com,linux-foundation.org];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[akpm@linux-foundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_HAS_DN(0.00)[];
	TO_DN_NONE(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,linux-foundation.org:dkim,linux-foundation.org:email,linux-foundation.org:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,suse.cz:email,smtp.kernel.org:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 808446F2A2B


The patch titled
     Subject: mm: fix mapping_seek_hole_data() overflow on last page
has been added to the -mm mm-new branch.  Its filename is
     mm-fix-mapping_seek_hole_data-overflow-on-last-page.patch

This patch will shortly appear at
     https://git.kernel.org/pub/scm/linux/kernel/git/akpm/25-new.git/tree/patches/mm-fix-mapping_seek_hole_data-overflow-on-last-page.patch

This patch will later appear in the mm-new branch at
    git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm

Note, mm-new is a provisional staging ground for work-in-progress
patches, and acceptance into mm-new is a notification for others take
notice and to finish up reviews.  Please do not hesitate to respond to
review feedback and post updated versions to replace or incrementally
fixup patches in mm-new.

The mm-new branch of mm.git is not included in linux-next

If a few days of testing in mm-new is successful, the patch will me moved
into mm.git's mm-unstable branch, which is included in linux-next

Before you just go and hit "reply", please:
   a) Consider who else should be cc'ed
   b) Prefer to cc a suitable mailing list as well
   c) Ideally: find the original patch on the mailing list and do a
      reply-to-all to that, adding suitable additional cc's

*** Remember to use Documentation/process/submit-checklist.rst when testing your code ***

The -mm tree is included into linux-next via various
branches at git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
and is updated there most days

------------------------------------------------------
From: Zhen Yan <yanzhen20011121@163.com>
Subject: mm: fix mapping_seek_hole_data() overflow on last page
Date: Tue, 30 Jun 2026 20:50:47 +0800

A local unprivileged process can create a shmem/tmpfs file with i_size ==
LLONG_MAX using memfd_create() and fallocate().  If the last page is
present in the page cache, lseek(SEEK_HOLE) on that page returns
0x8000000000000000 as a successful offset, which is LLONG_MIN when stored
in loff_t.

The same file has readable data at the last byte, but SEEK_DATA from that
offset returns ENXIO.

The overflow is in mapping_seek_hole_data():

  pos = round_up((u64)pos + 1, seek_size);

For the final page below LLONG_MAX, the next page boundary is
0x8000000000000000, which is then used as a signed file offset.  When
assigned to the loff_t pos, this overflows to LLONG_MIN, so a subsequent
"pos > end" comparison does not catch it.

Keep mapping_seek_hole_data() inside its documented [start, end) search
range: compute round_up() into a u64 variable and compare against (u64)end
so the overflow is detected, then clamp pos to end when the rounded-up
value goes past the search limit.

Link: https://lore.kernel.org/20260630125047.703170-1-yanzhen20011121@163.com
Signed-off-by: Zhen Yan <yanzhen20011121@163.com>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Hugh Dickins <hughd@google.com>
Cc: Jan Kara <jack@suse.cz>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 mm/filemap.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

--- a/mm/filemap.c~mm-fix-mapping_seek_hole_data-overflow-on-last-page
+++ a/mm/filemap.c
@@ -3229,6 +3229,7 @@ loff_t mapping_seek_hole_data(struct add
 	while ((folio = find_get_entry(&xas, max, XA_PRESENT))) {
 		loff_t pos = (u64)xas.xa_index << PAGE_SHIFT;
 		size_t seek_size;
+		u64 next;
 
 		if (start < pos) {
 			if (!seek_data)
@@ -3237,7 +3238,11 @@ loff_t mapping_seek_hole_data(struct add
 		}
 
 		seek_size = seek_folio_size(&xas, folio);
-		pos = round_up((u64)pos + 1, seek_size);
+		next = round_up((u64)pos + 1, seek_size);
+		if (next > (u64)end)
+			pos = end;
+		else
+			pos = next;
 		start = folio_seek_hole_data(&xas, mapping, folio, start, pos,
 				seek_data);
 		if (start < pos)
_

Patches currently in -mm which might be from yanzhen20011121@163.com are

mm-fix-mapping_seek_hole_data-overflow-on-last-page.patch


