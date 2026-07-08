Return-Path: <stable+bounces-272755-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id HAJoGFDTTmpuUwIAu9opvQ
	(envelope-from <stable+bounces-272755-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 09 Jul 2026 00:46:40 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B016D72AEFA
	for <lists+stable@lfdr.de>; Thu, 09 Jul 2026 00:46:39 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=auditcode.ai header.s=zmail header.b=G5ek6yrY;
	dmarc=pass (policy=none) header.from=auditcode.ai;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-272755-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-272755-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E2410302F0CF
	for <lists+stable@lfdr.de>; Wed,  8 Jul 2026 22:46:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66BB2315793;
	Wed,  8 Jul 2026 22:46:36 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from sender-op-o14.zoho.eu (sender-op-o14.zoho.eu [136.143.169.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39FD12E03E4;
	Wed,  8 Jul 2026 22:46:33 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783550796; cv=pass; b=tyDl1Gvwcpkfo7E3VLj9ZC7jxfBStFJtSDi1He2JIWDYm4VW9CbNgekw0UyRY38CvrfGwPKY238TJ4TZDqqjvGAj/Uy/Kpai2H68H761iGSKDmHq2TaDCYo/u4r4sS7T89TzavZ7w8h9ZR3aYWe5+sPuHq+p9HsZcYE5TiP0eIs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783550796; c=relaxed/simple;
	bh=IdLjKUWHVlwK8p1thSjt5pd26TOAvNAKXZTV5lMP/UY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sK/sll/ESMN8D6qs5yCxsC84GPRVnK4tI4IJiZGx1C3rJjVLM9jK8ooFNdTN29oqE/zjtPkUIjDGutSf/lxg2J+25cVpu1SoUrEjaoDLSmKBRP7rYvrDsX3r7l9c7LTPGQeANO9cDuYXFZUN0tL3i9gBsQlMnJpORK9NM0kNzTc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=auditcode.ai; spf=pass smtp.mailfrom=auditcode.ai; dkim=pass (1024-bit key) header.d=auditcode.ai header.i=security@auditcode.ai header.b=G5ek6yrY; arc=pass smtp.client-ip=136.143.169.14
ARC-Seal: i=1; a=rsa-sha256; t=1783550783; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=BD6f7jHYctW9OnW1WkeiiVTW+Bh6cfn4dWwL4XJdDqRHtUvKLb86HBINflPLASWpQ2BUT0s+r8PS/OG16jadUbkH9e6L3xdvphWuU2Ykwe5dSWR4begLY1QFbpBibk+J4+87t94NgUapD/HX0N0k8hkSTw67fR1Fdq6xr9y7efU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1783550783; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=UvKEqvHUn0DLpNmYFQa2M7TyKCELkaUuyUzSxfV9lDE=; 
	b=B57qWVJ+mWdhgUR9Mfx9bG6kBJK89hOgei0EL4eM3Nj9Y1uTVmRhjjQbqO8c01aONWlk5FttznddesOtEjPQUeBDSwFKegjyP2RqqgXOUedfuG8xlCPA9Hu7kJb9So/zxmKKo9y4ku47gQJcGM7VXx8sdfSMFsDPNFdHlnhc2eI=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=auditcode.ai;
	spf=pass  smtp.mailfrom=security@auditcode.ai;
	dmarc=pass header.from=<security@auditcode.ai>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1783550783;
	s=zmail; d=auditcode.ai; i=security@auditcode.ai;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=UvKEqvHUn0DLpNmYFQa2M7TyKCELkaUuyUzSxfV9lDE=;
	b=G5ek6yrYdDIFgIWK4AUTP7RVXevKk6PsYJh49XYSm6rshoHALS18gNkTyG5Wvuff
	tmNZ+a/msiYLTZunA1sdSDOveD7IX/yXaxTFnIfGHgeNB4aPEOCPLpLYk1WXY+EAlIH
	jxKMPq2BjPVbl/I9g7x10Ks5290Epgf1fMWpqnuk=
Received: by mx.zoho.eu with SMTPS id 1783550781426701.195803168272;
	Thu, 9 Jul 2026 00:46:21 +0200 (CEST)
From: Ibrahim Hashimov <security@auditcode.ai>
To: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc: ntfs3@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] fs/ntfs3: fix integer overflow in find_log_rec() causing OOB read
Date: Thu,  9 Jul 2026 00:46:18 +0200
Message-ID: <20260708224618.1328-1-security@auditcode.ai>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[auditcode.ai,none];
	R_DKIM_ALLOW(-0.20)[auditcode.ai:s=zmail];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-272755-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[security@auditcode.ai,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:almaz.alexandrovich@paragon-software.com,m:ntfs3@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[auditcode.ai:+];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[security@auditcode.ai,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B016D72AEFA

find_log_rec() validates the on-disk LFS_RECORD_HDR.client_data_len
field (`len`, a raw u32 read straight from a mounted $LogFile page)
against the log's total available space:

    len = le32_to_cpu(rh->client_data_len);
    rec_len = len + log->record_header_len;
    if (rec_len >= log->total_avail)
            return -EINVAL;

The addition is unchecked. For len in [0xffffffd0, 0xffffffff] (i.e.
log->record_header_len away from UINT_MAX), `rec_len` wraps to a small
u32 value that trivially clears the `rec_len >= log->total_avail`
guard, so a record whose declared length is actually ~4 GiB is
reported as valid and in-page.

Because find_log_rec() wrongly accepts the record, its caller
read_log_rec_lcb() hands it back to log_replay() as good. On the
transaction-table replay leg, log_replay() re-derives the record
length directly from the same raw, still-unclamped client_data_len
field and uses it to size the restart-table blob:

    rec_len = le32_to_cpu(frh->client_data_len);   /* ~0xffffffff */
    ...
    t16 = le16_to_cpu(lrh->redo_off);
    rt  = Add2Ptr(lrh, t16);
    t32 = rec_len - t16;                            /* still ~4 GiB */
    if (!check_rstbl(rt, t32))
            return -EINVAL;

check_rstbl()'s own `bytes < ts` bounds guard is defeated because the
caller-supplied `bytes` (t32) is itself the poisoned ~4 GiB value, so
the guard can never trigger. The subsequent entry-validation loop then
walks `rt->used` (also attacker-controlled) entries of
sizeof(struct RESTART_TABLE) == 0x18 bytes each straight past the end
of the kmalloc(log->page_size) log-page buffer allocated in
read_log_page(), producing an out-of-bounds read that is reachable
simply by mounting a crafted $LogFile (no genuine dirty-page /
crash-recovery state is required). Confirmed via KASAN as a
slab-out-of-bounds read in check_rstbl(), called from log_replay() ->
ntfs_loadlog_and_replay() -> ntfs_fill_super() -> mount(2).

Fix the root cause instead of hardening every downstream consumer of
the poisoned length: make the addition in find_log_rec() overflow-safe
with check_add_overflow(), mirroring the pattern fs/ntfs3/run.c
already uses to validate other attacker-controlled on-disk
length/offset arithmetic decoded from MAPPING_PAIRS runs, e.g.:

    if (check_add_overflow(vcn64, len, &next_vcn))
            return -EINVAL;
    ...
    if (check_add_overflow(lcn, len, &lcn_end))
            return -EINVAL;

(fs/ntfs3/run.c, run_unpack()).

With the overflow rejected instead of silently wrapped, `rec_len` is
only ever a true, non-wrapped sum, so the existing
`rec_len >= log->total_avail` check now correctly rejects any
oversized record up front. log_replay()'s transaction-table leg then
never gets a chance to re-read the poisoned client_data_len, and
check_rstbl() is never invoked with an attacker-inflated `bytes` for
this path.

Verified on a v6.19 KASAN build: mounting a crafted $LogFile whose
client_data_len overflows trips a KASAN slab-out-of-bounds-read
report in check_rstbl() before this fix; with check_add_overflow()
applied, the same image is cleanly rejected during log replay and no
KASAN report fires.

Fixes: b46acd6a6a62 ("fs/ntfs3: Add NTFS journal")
Cc: stable@vger.kernel.org
Signed-off-by: Ibrahim Hashimov <security@auditcode.ai>
Assisted-by: AuditCode-AI:2026.07
---
 fs/ntfs3/fslog.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/ntfs3/fslog.c b/fs/ntfs3/fslog.c
index f038c799e7ac..e5b63a02b827 100644
--- a/fs/ntfs3/fslog.c
+++ b/fs/ntfs3/fslog.c
@@ -7,6 +7,7 @@
 
 #include <linux/blkdev.h>
 #include <linux/fs.h>
+#include <linux/overflow.h>
 #include <linux/random.h>
 #include <linux/slab.h>
 
@@ -2424,7 +2425,8 @@ static int find_log_rec(struct ntfs_log *log, u64 lsn, struct lcb *lcb)
 	 * Check that the length field isn't greater than the total
 	 * available space the log file.
 	 */
-	rec_len = len + log->record_header_len;
+	if (check_add_overflow(len, log->record_header_len, &rec_len))
+		return -EINVAL;
 	if (rec_len >= log->total_avail)
 		return -EINVAL;
 
-- 
2.50.1 (Apple Git-155)


