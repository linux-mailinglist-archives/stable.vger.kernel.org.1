Return-Path: <stable+bounces-220705-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KIsoLmpAo2kR+wQAu9opvQ
	(envelope-from <stable+bounces-220705-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:22:18 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ACFA1C6E54
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:22:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AD06B30A857D
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:10:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 944433FB05F;
	Sat, 28 Feb 2026 17:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X07/2TYl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57BA03FB059;
	Sat, 28 Feb 2026 17:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300585; cv=none; b=kx1O9LRVm5N22DA4fpu791xlfHVMG3VCvMyM1t5G72xjPg+NYf4z1Mu/f3Ep0IAulsUasXrfp2puMIsBt9XF94c82wPPFA/cD4BUJu9Ujqoha99Np0zd9sFw4ixOMeoeFO51G3ctlIsyCf5pjsonCGUpoten3hzFg5jrkPjKi1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300585; c=relaxed/simple;
	bh=SsTQtT95nhRfD4rfSWy0JtnaIw6wyjoP8Ex2NMbIeYY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kJXeJHZmJavRY2v4ANY7NUJkNh7qlcppbrI5RboJHagz70J7GnqePap6OaTHT368f0qk1bn/HhV3OMI7u7UbuziavsH0SNlzQR8Eh1YLTnQbg4CUyTJLDJj1FO7kr7dhOEbtVvFnsnslfMl9EK4vsGLLkfBAznsKvziJ+w9hE28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X07/2TYl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E3C3C2BCAF;
	Sat, 28 Feb 2026 17:43:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300585;
	bh=SsTQtT95nhRfD4rfSWy0JtnaIw6wyjoP8Ex2NMbIeYY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=X07/2TYlVSFayZC6+tAX2ufXMrvSlBRYlQsLBLX0s+/hXKEJ0udXU4oDNQP9JY91a
	 y1qjHp6M6Pfk5hdkx3MQ7Yblr0VyI1boBAj6qUViCG6y654CzkS31nUz3bqwqH0E5x
	 oR90yD6YgZ9dR01m/YnaA5mTh/DXfNweOMYmGepJFaQ36ildliWN/VaATC4naoUagh
	 JJPEd/J6WrfeobUYsjkKcxPJy0lEqcTGAyZPL+UG4P6l1L3xoZ8mFyt6LCvtE92X8t
	 gGigvFFzntCetus22ma8+dOOK1EyQaPCyt75fkFu8ChFAcMjVsnYiE3TEEM5fkXWhb
	 ZLEtxFiJ+bwUA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Matt Whitlock <kernel@mattwhitlock.name>,
	Mikulas Patocka <mpatocka@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 626/844] dm-unstripe: fix mapping bug when there are multiple targets in a table
Date: Sat, 28 Feb 2026 12:28:59 -0500
Message-ID: <20260228173244.1509663-627-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220705-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
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
X-Rspamd-Queue-Id: 5ACFA1C6E54
X-Rspamd-Action: no action

From: Matt Whitlock <kernel@mattwhitlock.name>

[ Upstream commit 83c10e8dd43628d0bf86486616556cd749a3c310 ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
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


