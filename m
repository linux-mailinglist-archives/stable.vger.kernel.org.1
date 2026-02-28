Return-Path: <stable+bounces-220704-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iFtkFxhAo2kR+wQAu9opvQ
	(envelope-from <stable+bounces-220704-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:20:56 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 48FE81C6DD9
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:20:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6DF1730A906E
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:09:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 766DD3FB040;
	Sat, 28 Feb 2026 17:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EAImG10Y"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3844531716E;
	Sat, 28 Feb 2026 17:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300584; cv=none; b=ZkcwShgxznlBATR7V9qg0u5pW/4FBSM8IyiXg/lYqWo8BUh4Eli+1twDbdXEMVdUj1vXZ+1t0vHgVM/nr7u928y/o2ntWl3cZMewe5GXOvVLwN2j3pedKajq+mcKnSLTgLUFNEtPzmW3a9o6gAcx7ceNMj6WH93tCP/PBNKmRS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300584; c=relaxed/simple;
	bh=uyuwHoRo/ZWZHG1r0TNz72203WGOTdwB80ya0qW2DuQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=idh9gFrSy0wccGzAfyDTqQ3sIIV3wlNQDt/6Acyu6AYsf2oH0tmerFk4c4/z/x4ljbRuUOFSYNdGe76a1dcAnw11GPP2wev0LydAiY77E5n2iRuwwRTBe6c45Icz58nQZ85WHwQVXr8VyRwNS95bGBxyy/Coo4XvJdWnIbrnMJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EAImG10Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 831E9C116D0;
	Sat, 28 Feb 2026 17:43:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300584;
	bh=uyuwHoRo/ZWZHG1r0TNz72203WGOTdwB80ya0qW2DuQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EAImG10YY+Jrk0M/krqkvUnLYuBoIQOu/fbL/f1Zy09UxhhDYJqYjvw0SjNe6scqe
	 M841fjhmn+3ADmO2DN6ioCis+lIpZwGOQUGRcDTWck90NQS6HFu1UqZYzIL6tZCX2y
	 mUkYlGuvMAkTG8EH8q1EmN4gNoE1mlicZdfUvAsF9N5E2cJWUcnSo/nVwSxX6L7o5j
	 vDqa+BrDEF4gvfl5k1V+VZVwp9h5Dtp0Izd1V9H7vblJW+0r7LBOUbH7g+dRUMlDjT
	 cctkMfXXwXCFY2BpmkdM6zQseFkBrAgGS/nCMsrbLUjPzxfm5GpDO6STHgiWSZkluS
	 zKJyEQhTCpAGA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Mikulas Patocka <mpatocka@redhat.com>,
	Ondrej Kozina <okozina@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 625/844] dm-integrity: fix recalculation in bitmap mode
Date: Sat, 28 Feb 2026 12:28:58 -0500
Message-ID: <20260228173244.1509663-626-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220704-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 48FE81C6DD9
X-Rspamd-Action: no action

From: Mikulas Patocka <mpatocka@redhat.com>

[ Upstream commit 118ba36e446c01e3cd34b3eedabf1d9436525e1d ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/md/dm-integrity.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/md/dm-integrity.c b/drivers/md/dm-integrity.c
index 79d60495454a5..ba52631052503 100644
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


