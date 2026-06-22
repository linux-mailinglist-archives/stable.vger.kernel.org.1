Return-Path: <stable+bounces-267819-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 3oqRDp+9OWpwwwcAu9opvQ
	(envelope-from <stable+bounces-267819-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 23 Jun 2026 00:56:31 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A94C6B2B7B
	for <lists+stable@lfdr.de>; Tue, 23 Jun 2026 00:56:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=sOSrwB0B;
	dkim=pass header.d=suse.com header.s=susede1 header.b=r1vkQ3mc;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-267819-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-267819-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=suse.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 082803032046
	for <lists+stable@lfdr.de>; Mon, 22 Jun 2026 22:56:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A107C37AA7F;
	Mon, 22 Jun 2026 22:56:12 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2363B283FE6
	for <stable@vger.kernel.org>; Mon, 22 Jun 2026 22:56:10 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782168972; cv=none; b=qTjZtE44W1Pb95Q5Uz5tHCteHNIjK+Z5nBGf807KSi2Bd5QlI2eiL8rRPoMQlyUbl5L1LorDmH1L5CH8J1loBrp45M7lYUBmxCqTu6jhFK8rgE9zZj2Be67bMASBWwI46qEDzXPU+jA5eE+2ULNVsYBgePG3rotETtOvWJerIQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782168972; c=relaxed/simple;
	bh=aE4zOPksyvDe6M7IPzuddw/Z7bnLdRCTy3Rk5LxMLdU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OdYQMIOmeGWK5zS5HK/o0aFlaonlsMcNAH48kJwMQJrQQVui86c2r7R3G4U9EnjSZ+7y4x0yt+iZ+cugynpRZGwdURzTJzUNUJ90dY/2rzqjjpOJ4JPiVWdU60Ih1Q2PuxA7WUwg83VGOYpDWo1pVtfCTi03yAHcHlegvPciXqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=sOSrwB0B; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=r1vkQ3mc; arc=none smtp.client-ip=195.135.223.130
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E9F1770AD6;
	Mon, 22 Jun 2026 22:56:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1782168967; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k2OHDwc38vlocbMIzqDd7Ne3P/Tn0061xwzxeVJdjF0=;
	b=sOSrwB0BO+KGgCQt2PcbLrDbuFd4nKcwRyPl3tiFK4ZZp3FEmzB8lYgJrOlDMPBwIbwpZq
	5NMgxfqF69Jmdkim23dr+kn5nYn8WqvAY3hYj+tYflD+RqZflEo0HMTPA64h9a5pfx2Yln
	GTzuA/qi/92bweOUfkWhG2QZ51aNODA=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1782168966; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k2OHDwc38vlocbMIzqDd7Ne3P/Tn0061xwzxeVJdjF0=;
	b=r1vkQ3mcA9ITHDfFKkc/jeJPtLIYr0FQsmXGNtlOpbKvtLss8oCivjorRTbMEw9MBG9Gw1
	tQC51HARozAgDuS/kK1PZHYYpTe3L363/VkifQU4o2mBDWgqfBDHO4ZQfcmycbhcBLO5NU
	5s2i1/XKt0WJLyJVXP6xW+VHJK7EIIk=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A56DC779A8;
	Mon, 22 Jun 2026 22:56:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id oCCOFYW9OWq0OQAAD6G6ig
	(envelope-from <wqu@suse.com>); Mon, 22 Jun 2026 22:56:05 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH v2 2/2] btrfs: reject inline file extent item in get_new_location()
Date: Tue, 23 Jun 2026 08:25:41 +0930
Message-ID: <619560576690f592ba60044c4761bd7fca204ae9.1782168847.git.wqu@suse.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1782168847.git.wqu@suse.com>
References: <cover.1782168847.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Spam-Level: 
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	TAGGED_FROM(0.00)[bounces-267819-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:linux-btrfs@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_SENDER(0.00)[wqu@suse.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wqu@suse.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	DKIM_TRACE(0.00)[suse.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,suse.com:dkim,suse.com:email,suse.com:mid,suse.com:from_mime,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8A94C6B2B7B

Commit a6908f88c9da ("btrfs: validate data reloc tree file extent item
members") introduced extra checks on file extent items for data reloc
inodes, but it checks file extent offset without checking if the file
extent is inlined.

This can lead to either false alerts (as the offset member is inside the
inlined data) or even read beyond the item range.

This has already triggered a warning in a syzbot report.
Although the root fix is to avoid compression for data reloc inodes, for
the sake of consistency, reject inlined file extents first.

Fixes: a6908f88c9da ("btrfs: validate data reloc tree file extent item members")
Cc: stable@vger.kernel.org
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/relocation.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index e1dd9939f4f1..f5fac0e34494 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -893,6 +893,13 @@ static int get_new_location(struct inode *reloc_inode, u64 *new_bytenr,
 	leaf = path->nodes[0];
 	fi = btrfs_item_ptr(leaf, path->slots[0],
 			    struct btrfs_file_extent_item);
+	if (unlikely(btrfs_file_extent_type(leaf, fi) == BTRFS_FILE_EXTENT_INLINE)) {
+		btrfs_print_leaf(leaf);
+		btrfs_err(fs_info,
+	"unexpected inline file extent item for data reloc inode %llu key offset %llu",
+			  btrfs_ino(BTRFS_I(reloc_inode)), bytenr);
+		return -EUCLEAN;
+	}
 
 	/*
 	 * The cluster-boundary key searched above is always written by
-- 
2.54.0


