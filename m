Return-Path: <stable+bounces-240843-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0PmyKKd062kQNAAAu9opvQ
	(envelope-from <stable+bounces-240843-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 15:48:23 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 366C245FACB
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 15:48:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C385D30A2DFB
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 13:39:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFB563D5643;
	Fri, 24 Apr 2026 13:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tVkyOqJb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9273A3563D4;
	Fri, 24 Apr 2026 13:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777037983; cv=none; b=cxmv1j+Vu5XK8lZlViKKHmY0m1MFk+9RkUJy8c4oFtVUnCDOgYKDJan10EVToUD0lHjVd4Fr+YLVMgGBBQFJiXijlFkvLIl1TLCDbFAx6qO+0iMUN8CK9GRWo5YEXlKnBpfR8ZchrxsDo/9HhDEVoQCToGOkSqz3lmkIYbLTyA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777037983; c=relaxed/simple;
	bh=R4a5R6E8mEh4EK3KTagrYZ8cJOUsoRVo4beMRu7Jj4k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AEsUIJNK/nBqqFLFKL+PkKDzCWsM9Q1by9f5wwPT9+ioVYZKwRAUgstX2arvMwBXGbDEPjPshOFM5hve0T3sGylUpyzpMVn6OtM58AqFvfFiFFYeKRmaEllWvXOpQtZ3Nj2BexZsTGqkx68/RWyYwj6o1GWi6++zhgFArawDOKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tVkyOqJb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28939C19425;
	Fri, 24 Apr 2026 13:39:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777037983;
	bh=R4a5R6E8mEh4EK3KTagrYZ8cJOUsoRVo4beMRu7Jj4k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tVkyOqJbFTZwjrXnMZPwpaIMnUWuFnbtQW3EmqWw7FSty0IRddDUb+rM6qf9/0tzA
	 62AhOg9bSXDmKP49jkT6vxie29lLsw80JithpAVWgsSk392ZcM+AdKtoaBUPHAJc3r
	 C2Bkdsp9ceA0+X+fWgcBr+Kw/0e8gd4pg0DlCQZg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	stable <stable@kernel.org>
Subject: [PATCH 6.6 145/166] fs/ntfs3: validate rec->used in journal-replay file record check
Date: Fri, 24 Apr 2026 15:30:59 +0200
Message-ID: <20260424132603.423782030@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260424132532.812258529@linuxfoundation.org>
References: <20260424132532.812258529@linuxfoundation.org>
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
X-Rspamd-Queue-Id: 366C245FACB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-240843-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid]

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

commit 0ca0485e4b2e837ebb6cbd4f2451aba665a03e4b upstream.

check_file_record() validates rec->total against the record size but
never validates rec->used.  The do_action() journal-replay handlers read
rec->used from disk and use it to compute memmove lengths:

  DeleteAttribute:    memmove(attr, ..., used - asize - roff)
  CreateAttribute:    memmove(..., attr, used - roff)
  change_attr_size:   memmove(..., used - PtrOffset(rec, next))

When rec->used is smaller than the offset of a validated attribute, or
larger than the record size, these subtractions can underflow allowing
us to copy huge amounts of memory in to a 4kb buffer, generally
considered a bad idea overall.

This requires a corrupted filesystem, which isn't a threat model the
kernel really needs to worry about, but checking for such an obvious
out-of-bounds value is good to keep things robust, especially on journal
replay

Fix this up by bounding rec->used correctly.

This is much like commit b2bc7c44ed17 ("fs/ntfs3: Fix slab-out-of-bounds
read in DeleteIndexEntryRoot") which checked different values in this
same switch statement.

Cc: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Fixes: b46acd6a6a62 ("fs/ntfs3: Add NTFS journal")
Cc: stable <stable@kernel.org>
Assisted-by: gregkh_clanker_t1000
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/ntfs3/fslog.c |   12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

--- a/fs/ntfs3/fslog.c
+++ b/fs/ntfs3/fslog.c
@@ -2789,13 +2789,14 @@ static inline bool check_file_record(con
 	u16 fn = le16_to_cpu(rec->rhdr.fix_num);
 	u16 ao = le16_to_cpu(rec->attr_off);
 	u32 rs = sbi->record_size;
+	u32 used = le32_to_cpu(rec->used);
 
 	/* Check the file record header for consistency. */
 	if (rec->rhdr.sign != NTFS_FILE_SIGNATURE ||
 	    fo > (SECTOR_SIZE - ((rs >> SECTOR_SHIFT) + 1) * sizeof(short)) ||
 	    (fn - 1) * SECTOR_SIZE != rs || ao < MFTRECORD_FIXUP_OFFSET_1 ||
 	    ao > sbi->record_size - SIZEOF_RESIDENT || !is_rec_inuse(rec) ||
-	    le32_to_cpu(rec->total) != rs) {
+	    le32_to_cpu(rec->total) != rs || used > rs || used < ao) {
 		return false;
 	}
 
@@ -2807,6 +2808,15 @@ static inline bool check_file_record(con
 		return false;
 	}
 
+	/*
+	 * The do_action() handlers compute memmove lengths as
+	 * "rec->used - <offset of validated attr>", which underflows when
+	 * rec->used is smaller than the attribute walk reached.  At this
+	 * point attr is the ATTR_END marker; rec->used must cover it.
+	 */
+	if (used < PtrOffset(rec, attr) + sizeof(attr->type))
+		return false;
+
 	return true;
 }
 



