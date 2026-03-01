Return-Path: <stable+bounces-221657-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IGGNI72ao2l4IAUAu9opvQ
	(envelope-from <stable+bounces-221657-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 02:47:41 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 05B7E1CBC10
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 02:47:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A4605321E414
	for <lists+stable@lfdr.de>; Sun,  1 Mar 2026 01:34:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9412B2EC09F;
	Sun,  1 Mar 2026 01:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h62+imSL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 573F02D5946;
	Sun,  1 Mar 2026 01:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772328816; cv=none; b=usZvW9pN/n6Ic/aiZCWF0oEyZHfcpCrzO0hr/PSf2SzzBxYntZj9QkWwPFZ+IDUICLxdWR1vOvS4mwgeFtL471p/hbL0TPfdbaErL1LdNMPV8z2ywn/7+RCvKYLw/a2MyF+kGbMUkUyDtG7jjFkgmsRjpOGU8UJt7EOseo2GKBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772328816; c=relaxed/simple;
	bh=1LJ9ZgWtEpsI8wlPMxYJTriyhTVOnJQc4CcoLTWUHS4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=J9DJiDXpdalqp61FhO789M0FhC63+VJJtTM5hKvf3b4FIf5iWikH5dHPfrH9dEKltGKGPGwzK+jFCH2ZT41Norvnxm7sGWrs1xfdTD3Wql7yhLj69xvohifKjBBAsxytjlAy1dLvBLGxaR76x54hse2feW4iER5ljnIyXfNbGkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h62+imSL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA16EC19421;
	Sun,  1 Mar 2026 01:33:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772328816;
	bh=1LJ9ZgWtEpsI8wlPMxYJTriyhTVOnJQc4CcoLTWUHS4=;
	h=From:To:Cc:Subject:Date:From;
	b=h62+imSLWrO5gCnEEQfh/Fe2dRad59VkiMe9iQtvGYMpFS9EbVuMQgdnc1oZrKeCd
	 aYSo4ECc740bxCDPMqQ7IeKyUSz+Qp0BmKY9s/mmUH6jJuXkpbwCy0lwjQMqS3WC7P
	 kkEwZi80KSCNPm/kWtJ4QGxgCfRCVINyoLHvlqjSQHNwOq7q99J066/a8iVIyV5Knj
	 fVLWPrOmtTfMcnlwLq5dSVat9KC/YCWB/Sw+HvQ12QxS3trmlUd2KtWV4hCIu8WX+6
	 ijWQYXPQ7BpMTOwiHNakDWj3W9Ie51Shhl94cGOz5ZBoUPsKO+bD7JJTUutPcuwvyk
	 i4ymnCs9FE92g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	kernel@mattwhitlock.name
Cc: Mikulas Patocka <mpatocka@redhat.com>,
	dm-devel@lists.linux.dev
Subject: FAILED: Patch "dm-unstripe: fix mapping bug when there are multiple targets in a table" failed to apply to 6.6-stable tree
Date: Sat, 28 Feb 2026 20:33:34 -0500
Message-ID: <20260301013334.1692833-1-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-221657-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mattwhitlock.name:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 05B7E1CBC10
X-Rspamd-Action: no action

The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 83c10e8dd43628d0bf86486616556cd749a3c310 Mon Sep 17 00:00:00 2001
From: Matt Whitlock <kernel@mattwhitlock.name>
Date: Sun, 18 Jan 2026 13:36:15 -0500
Subject: [PATCH] dm-unstripe: fix mapping bug when there are multiple targets
 in a table

The "unstriped" device-mapper target incorrectly calculates the sector
offset on the mapped device when the target's origin is not zero.

Take for example this hypothetical concatenation of the members of a
two-disk RAID0:

linearized:       0 2097152 unstriped 2 128 0 /dev/md/raid0 0
linearized: 2097152 2097152 unstriped 2 128 1 /dev/md/raid0 0

The intent in this example is to create a single device named
/dev/mapper/linearized that comprises all of the chunks of the first disk
of the RAID0 set, followed by all of the chunks of the second disk of the
RAID0 set.

This fails because dm-unstripe.c's map_to_core function does its
computations based on the sector number within the mapper device rather
than the sector number within the target. The bug turns invisible when
the target's origin is at sector zero of the mapper device, as is the
common case. In the example above, however, what happens is that the
first half of the mapper device gets mapped correctly to the first disk
of the RAID0, but the second half of the mapper device gets mapped past
the end of the RAID0 device, and accesses to any of those sectors return
errors.

Signed-off-by: Matt Whitlock <kernel@mattwhitlock.name>
Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Cc: stable@vger.kernel.org
Fixes: 18a5bf270532 ("dm: add unstriped target")
---
 drivers/md/dm-unstripe.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/md/dm-unstripe.c b/drivers/md/dm-unstripe.c
index e8a9432057dce..17be483595642 100644
--- a/drivers/md/dm-unstripe.c
+++ b/drivers/md/dm-unstripe.c
@@ -117,7 +117,7 @@ static void unstripe_dtr(struct dm_target *ti)
 static sector_t map_to_core(struct dm_target *ti, struct bio *bio)
 {
 	struct unstripe_c *uc = ti->private;
-	sector_t sector = bio->bi_iter.bi_sector;
+	sector_t sector = dm_target_offset(ti, bio->bi_iter.bi_sector);
 	sector_t tmp_sector = sector;
 
 	/* Shift us up to the right "row" on the stripe */
-- 
2.51.0





