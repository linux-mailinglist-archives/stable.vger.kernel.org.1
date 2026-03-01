Return-Path: <stable+bounces-221382-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WGAHMTGWo2l7HQUAu9opvQ
	(envelope-from <stable+bounces-221382-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 02:28:17 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C4C091CAB0E
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 02:28:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A1F503047D8A
	for <lists+stable@lfdr.de>; Sun,  1 Mar 2026 01:22:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA8392749C1;
	Sun,  1 Mar 2026 01:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LvJiwaYh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D61A2BD0B;
	Sun,  1 Mar 2026 01:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772328121; cv=none; b=dFOcYQqxBDu5DkpeTG2KSGGvth7z8kbviP8IqAS0m2s88/UoiHsmDyd1WL1qjp8bHwXH8GXa8OCXyPwQrvOdDwmIlJoo+Df20PCN8Ar92KBt+V6zBHJGwaZCABmUJMHPViTq+WsPX/RHPiTbeZh5te6+IDigDhHl9dcs1PLKjmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772328121; c=relaxed/simple;
	bh=B0uiqKLhCH0bkKZ7PLi2LlNFMi1S+qX4duXZwiZB7xA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=emcmmeGyTt/YuDCWGuVRHsbaH151CSdTf1grWyXiXLvqRdutfF9ycmnx85BcnDV9R3QjJ4EMY+xrOlTQvN7m0cdfPE4QykVH6vGkxlGlE0i1YUdKw4cCFfIrKWbML9KMZJoo3MzK8INserstvjS18vh+K7DB2kycXE574tSkNyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LvJiwaYh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3B2BC19421;
	Sun,  1 Mar 2026 01:22:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772328121;
	bh=B0uiqKLhCH0bkKZ7PLi2LlNFMi1S+qX4duXZwiZB7xA=;
	h=From:To:Cc:Subject:Date:From;
	b=LvJiwaYhKD/QgXbc3n28Oa/hBNX1Hx7LfPnSX/u4vwrLhHQNL/X1GlewfqolJpl2y
	 wbkyTfE5WWQSiyr0ShqvV/kOd3Jc1oeI0wINcoquVMDKzvkTjNjsE5HymFK6Jy/OrF
	 jx5bm7hPRf72hmFCIiSKbOyNZyv68jeFi5RBGo4IVX12SfV7FQt8J76rvcxCzDZhdf
	 BZyJccAjInKQagJFKojVC+jUUh29tDRCakkzsDGDIPN4Ce3kRJts1iDZVqy9EzYsbW
	 hCsqtp9sm1H5aeX0XR3IteUC9mcLlHz6D+v1x0VG83lGzDygDRk2CE/XmT2Gy7wzQg
	 9eSEHtvm3K4BQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	mpatocka@redhat.com
Cc: Ondrej Kozina <okozina@redhat.com>,
	dm-devel@lists.linux.dev
Subject: FAILED: Patch "dm-integrity: fix recalculation in bitmap mode" failed to apply to 6.12-stable tree
Date: Sat, 28 Feb 2026 20:21:59 -0500
Message-ID: <20260301012159.1678115-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: ignore
X-stable: review
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-221382-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C4C091CAB0E
X-Rspamd-Action: no action

The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 118ba36e446c01e3cd34b3eedabf1d9436525e1d Mon Sep 17 00:00:00 2001
From: Mikulas Patocka <mpatocka@redhat.com>
Date: Mon, 19 Jan 2026 15:06:02 +0100
Subject: [PATCH] dm-integrity: fix recalculation in bitmap mode

There's a logic quirk in the handling of suspend in the bitmap mode:

This is the sequence of calls if we are reloading a dm-integrity table:
* dm_integrity_ctr reads a superblock with the flag SB_FLAG_DIRTY_BITMAP
  set.
* dm_integrity_postsuspend initializes a journal and clears the flag
  SB_FLAG_DIRTY_BITMAP.
* dm_integrity_resume sees the superblock with SB_FLAG_DIRTY_BITMAP set -
  thus it interprets the journal as if it were a bitmap.

This quirk causes recalculation problem if the user increases the size of
the device in the bitmap mode.

Fix this by reading a fresh copy on the superblock in
dm_integrity_resume. This commit also fixes another logic quirk - the
branch that sets bitmap bits if the device was extended should only be
executed if the flag SB_FLAG_DIRTY_BITMAP is set.

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Tested-by: Ondrej Kozina <okozina@redhat.com>
Fixes: 468dfca38b1a ("dm integrity: add a bitmap mode")
Cc: stable@vger.kernel.org
---
 drivers/md/dm-integrity.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/md/dm-integrity.c b/drivers/md/dm-integrity.c
index 380527f43b2a1..a9c0157bf42fe 100644
--- a/drivers/md/dm-integrity.c
+++ b/drivers/md/dm-integrity.c
@@ -3788,14 +3788,27 @@ static void dm_integrity_resume(struct dm_target *ti)
 	struct dm_integrity_c *ic = ti->private;
 	__u64 old_provided_data_sectors = le64_to_cpu(ic->sb->provided_data_sectors);
 	int r;
+	__le32 flags;
 
 	DEBUG_print("resume\n");
 
 	ic->wrote_to_journal = false;
 
+	flags = ic->sb->flags & cpu_to_le32(SB_FLAG_RECALCULATING);
+	r = sync_rw_sb(ic, REQ_OP_READ);
+	if (r)
+		dm_integrity_io_error(ic, "reading superblock", r);
+	if ((ic->sb->flags & flags) != flags) {
+		ic->sb->flags |= flags;
+		r = sync_rw_sb(ic, REQ_OP_WRITE | REQ_FUA);
+		if (unlikely(r))
+			dm_integrity_io_error(ic, "writing superblock", r);
+	}
+
 	if (ic->provided_data_sectors != old_provided_data_sectors) {
 		if (ic->provided_data_sectors > old_provided_data_sectors &&
 		    ic->mode == 'B' &&
+		    ic->sb->flags & cpu_to_le32(SB_FLAG_DIRTY_BITMAP) &&
 		    ic->sb->log2_blocks_per_bitmap_bit == ic->log2_blocks_per_bitmap_bit) {
 			rw_journal_sectors(ic, REQ_OP_READ, 0,
 					   ic->n_bitmap_blocks * (BITMAP_BLOCK_SIZE >> SECTOR_SHIFT), NULL);
-- 
2.51.0





