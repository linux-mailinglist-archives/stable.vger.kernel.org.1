Return-Path: <stable+bounces-273319-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Oy40OrdYUWqcCwMAu9opvQ
	(envelope-from <stable+bounces-273319-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 10 Jul 2026 22:40:23 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 422EB73E6F0
	for <lists+stable@lfdr.de>; Fri, 10 Jul 2026 22:40:23 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux-foundation.org header.s=korg header.b=2WDM5Sin;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-273319-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-273319-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1B1F43052048
	for <lists+stable@lfdr.de>; Fri, 10 Jul 2026 20:34:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75676372698;
	Fri, 10 Jul 2026 20:34:10 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFDFB1C3BF7;
	Fri, 10 Jul 2026 20:34:08 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783715650; cv=none; b=Z62zsx6BlFNhJE52LhKtC33ubxhwIVC4Wljf7TmRr7EdSwGakkJMEPg/DQ7YbBOo+f+D21VjnTgPNgFHoFd2mr2nvR2Ik5oA3VQ8I1WwUFbyJ0a29C8FDZqqmYMI92kqW86pfOb10NSkxBpQ2Vhi2aF9ma0pQzMvlDDurYo82ZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783715650; c=relaxed/simple;
	bh=0SILCpB5R4+7+/RS0uXDGf6tz0OkVwzGv+PBTeQuPaY=;
	h=Date:To:From:Subject:Message-Id; b=bWWl7n9MK3R75d91KSgn/cS3hGw+VCJqbFZQ2Mboq2z+KN0NdDNf0cMZRwxqGfaBMPZNDPlENZGSRHcajlvokmwFaXKT6RsWKfY9w+qElQ4sBpmfsWIf86xGXexZf+PHseOYd0ukjd/FlQ8EE2yrHy+4P48J8QZYxwnYy3/jXaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=2WDM5Sin; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 620AC1F000E9;
	Fri, 10 Jul 2026 20:34:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1783715648;
	bh=ODNyXEY//HWOo41ndrF6FuXvv0eOcOPTyeZmdGu6H7I=;
	h=Date:To:From:Subject;
	b=2WDM5Sinmjw1f7gTf3xlBYLRRj1sAue3QUpXrcucW3bTJ0vNV690YhnWRUMrQpMfp
	 itCSPErZOaBDYaud+ieNEJt4eqvJWt1ZDXeojGfpj6mOdV9WAVpVWZf08sX6kWszgf
	 Jz0tq/cUmstAg+W7H+KBRmK/+fRYgu6yPnsXdMG4=
Date: Fri, 10 Jul 2026 13:34:08 -0700
To: mm-commits@vger.kernel.org,stable@vger.kernel.org,piaojun@huawei.com,mark@fasheh.com,junxiao.bi@oracle.com,joseph.qi@linux.alibaba.com,jlbec@evilplan.org,heming.zhao@suse.com,gechangwei@live.cn,security@auditcode.ai,akpm@linux-foundation.org
From: Andrew Morton <akpm@linux-foundation.org>
Subject: + ocfs2-validate-rl_used-against-rl_count-in-refcount-block-validator.patch added to mm-nonmm-unstable branch
Message-Id: <20260710203408.620AC1F000E9@smtp.kernel.org>
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
	TAGGED_FROM(0.00)[bounces-273319-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:mm-commits@vger.kernel.org,m:stable@vger.kernel.org,m:piaojun@huawei.com,m:mark@fasheh.com,m:junxiao.bi@oracle.com,m:joseph.qi@linux.alibaba.com,m:jlbec@evilplan.org,m:heming.zhao@suse.com,m:gechangwei@live.cn,m:security@auditcode.ai,m:akpm@linux-foundation.org,s:lists@lfdr.de];
	DMARC_NA(0.00)[linux-foundation.org];
	FREEMAIL_TO(0.00)[vger.kernel.org,huawei.com,fasheh.com,oracle.com,linux.alibaba.com,evilplan.org,suse.com,live.cn,auditcode.ai,linux-foundation.org];
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
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 422EB73E6F0


The patch titled
     Subject: ocfs2: validate rl_used against rl_count in refcount block validator
has been added to the -mm mm-nonmm-unstable branch.  Its filename is
     ocfs2-validate-rl_used-against-rl_count-in-refcount-block-validator.patch

This patch will shortly appear at
     https://git.kernel.org/pub/scm/linux/kernel/git/akpm/25-new.git/tree/patches/ocfs2-validate-rl_used-against-rl_count-in-refcount-block-validator.patch

This patch will later appear in the mm-nonmm-unstable branch at
    git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm

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
From: Ibrahim Hashimov <security@auditcode.ai>
Subject: ocfs2: validate rl_used against rl_count in refcount block validator
Date: Thu, 9 Jul 2026 15:26:09 +0200

ocfs2_find_refcount_rec_in_rl() walks the on-disk refcount record array
with:

	for (; i < le16_to_cpu(rb->rf_records.rl_used); i++) {
		rec = &rb->rf_records.rl_recs[i];
		...

rl_recs[] lives in a single metadata block (4096 bytes on the common
configuration), so its real capacity is fixed by
ocfs2_refcount_recs_per_rb(sb) (247 records for a 4K block with the
16-byte ocfs2_refcount_rec).  rl_used and rl_count are both read directly
off disk by ocfs2_validate_refcount_block() and are never checked against
that capacity, nor against each other, before any refcount/reflink/CoW
operation walks the array.

A crafted (or corrupted) refcount block with rl_used == 0xffff makes the
loop above walk far past the end of the block, dereferencing rl_recs[i]
for i up to 65534.  The resulting index is then handed to the sibling
ocfs2_insert_refcount_rec(), whose insert-shift does:

	if (index < le16_to_cpu(rf_list->rl_used))
		memmove(&rf_list->rl_recs[index + 1],
			&rf_list->rl_recs[index],
			(le16_to_cpu(rf_list->rl_used) - index) *
			 sizeof(struct ocfs2_refcount_rec));

i.e.  a memmove() of up to (0xffff - index) * 16 bytes (~1 MiB) from an
offset already past the block.  This is reachable from an ordinary reflink
(FICLONE) against a crafted/corrupted ocfs2 image: attaching an extent
whose cpos sorts past every real record in the leaf forces the lookup to
run off the end instead of returning early on a match.  The attacker model
is local: CAP_SYS_ADMIN mounting a crafted or corrupted ocfs2 image, or a
raw write to the block device backing an already-mounted ocfs2 filesystem.

ocfs2_validate_refcount_block() already validates the block's ECC,
signature, rf_blkno and rf_fs_generation, but never rl_count/rl_used
against the block's actual on-disk capacity.  This is the same class of
gap that ocfs2_validate_extent_block() (fs/ocfs2/alloc.c) already closes
for the sibling extent-list header, which checks both the record capacity
and the "used" bound before any code walks h_list.l_recs[]:

	if (le16_to_cpu(eb->h_list.l_count) != ocfs2_extent_recs_per_eb(sb)) {
		rc = ocfs2_error(...);
		goto bail;
	}

	if (le16_to_cpu(eb->h_list.l_next_free_rec) >
	    le16_to_cpu(eb->h_list.l_count)) {
		rc = ocfs2_error(...);
		goto bail;
	}

Add the equivalent pair of checks to ocfs2_validate_refcount_block():
reject a refcount block whose rl_count does not match the fixed per-block
capacity returned by ocfs2_refcount_recs_per_rb(), and reject rl_used >
rl_count.  Both checks are skipped when OCFS2_REFCOUNT_TREE_FL is set,
because in that case the same union bytes hold an ocfs2_extent_list
(rf_list), not the refcount record list (rf_records) -- that layout is
already validated separately by ocfs2_validate_extent_block() when the
referenced extent block is read.  This mirrors the existing
"!(rb->rf_flags & OCFS2_REFCOUNT_TREE_FL)" guard used elsewhere in this
file (e.g.  ocfs2_get_refcount_rec()) to decide whether rf_records or
rf_list is the live member of the union.

With this in place, a forged rl_used/rl_count is caught at block
validation time (ocfs2_error()), consistent with every other corruption
check in this function, instead of driving an out-of-bounds read in
ocfs2_find_refcount_rec_in_rl() and a subsequent out-of-bounds memmove()
in ocfs2_insert_refcount_rec().

Verified against a crafted image on a v6.19 KASAN (KASAN_GENERIC) build:
replaying the same reflink (FICLONE) reliably hit a KASAN report in
__ocfs2_increase_refcount()/ocfs2_insert_refcount_rec() before this patch,
and triggers no report once ocfs2_validate_refcount_block() rejects the
forged rl_used/rl_count.

Link: https://lore.kernel.org/20260709132609.44233-1-security@auditcode.ai
Fixes: f2c870e3b12e ("ocfs2: Add ocfs2_read_refcount_block.")
Signed-off-by: Ibrahim Hashimov <security@auditcode.ai>
Reviewed-by: Joseph Qi <joseph.qi@linux.alibaba.com>
Cc: Mark Fasheh <mark@fasheh.com>
Cc: Joel Becker <jlbec@evilplan.org>
Cc: Junxiao Bi <junxiao.bi@oracle.com>
Cc: Changwei Ge <gechangwei@live.cn>
Cc: Jun Piao <piaojun@huawei.com>
Cc: Heming Zhao <heming.zhao@suse.com>
Assisted-by: AuditCode-AI:2026.07
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 fs/ocfs2/refcounttree.c |   27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

--- a/fs/ocfs2/refcounttree.c~ocfs2-validate-rl_used-against-rl_count-in-refcount-block-validator
+++ a/fs/ocfs2/refcounttree.c
@@ -116,6 +116,33 @@ static int ocfs2_validate_refcount_block
 				 le32_to_cpu(rb->rf_fs_generation));
 		goto out;
 	}
+
+	/*
+	 * rf_records (rl_count/rl_used/rl_recs[]) is only meaningful when
+	 * this block is not an interior tree block (OCFS2_REFCOUNT_TREE_FL);
+	 * in that case the same union bytes hold an extent list (rf_list)
+	 * instead, which is validated by ocfs2_validate_extent_block().
+	 */
+	if (!(le32_to_cpu(rb->rf_flags) & OCFS2_REFCOUNT_TREE_FL)) {
+		if (le16_to_cpu(rb->rf_records.rl_count) !=
+		    ocfs2_refcount_recs_per_rb(sb)) {
+			rc = ocfs2_error(sb,
+					 "Refcount block #%llu has an invalid rl_count of %u\n",
+					 (unsigned long long)bh->b_blocknr,
+					 le16_to_cpu(rb->rf_records.rl_count));
+			goto out;
+		}
+
+		if (le16_to_cpu(rb->rf_records.rl_used) >
+		    le16_to_cpu(rb->rf_records.rl_count)) {
+			rc = ocfs2_error(sb,
+					 "Refcount block #%llu has an invalid rl_used of %u (rl_count %u)\n",
+					 (unsigned long long)bh->b_blocknr,
+					 le16_to_cpu(rb->rf_records.rl_used),
+					 le16_to_cpu(rb->rf_records.rl_count));
+			goto out;
+		}
+	}
 out:
 	return rc;
 }
_

Patches currently in -mm which might be from security@auditcode.ai are

ocfs2-validate-rl_used-against-rl_count-in-refcount-block-validator.patch


