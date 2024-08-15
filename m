Return-Path: <stable+bounces-68387-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9792C9531F0
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 16:00:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2936F282069
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 14:00:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F9F3176AD7;
	Thu, 15 Aug 2024 14:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NowKLP7/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2825762D2;
	Thu, 15 Aug 2024 14:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723730408; cv=none; b=PyTfn4y3F1HOjksef2x1M9bOw7Ue3lVZ2aIU5WKOE4ZwlzfMPoNO2xo56OFLtEm+OKLWwhvTTYPwyVnfaczsVRfVYHOR7Q9W+9FHNPHRxq4u4jCoJcgIqngb9gQu3BfPTLM0RnAJasCQCiFCpc16F1dMA/dcztUV9QGM03HRNys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723730408; c=relaxed/simple;
	bh=fpp/m58/eQEDIfFuZm/3XkOOwkOvMh4Wv5WL2gUb9WQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pCWIVLxF9XfcEqYUFqaHL3V4bOzONZSLIgr7ukj1rr80XfrCJcyy4yk0hgfXisi/87ToqbfgxRnTfZfg5NTggJ2SGarLz1Iz9s2ySAZYtnMcWLSsgYOsZleNKpfd/wSHbRLvmiGOGkwjl/Mcpd909n7acqZRejRLVkOqTH8rGsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NowKLP7/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 392D0C32786;
	Thu, 15 Aug 2024 14:00:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723730407;
	bh=fpp/m58/eQEDIfFuZm/3XkOOwkOvMh4Wv5WL2gUb9WQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NowKLP7/jKoOsxpUPRAPGSllSD7wxWY6k6U9ZQMUpvuZpFcrhxgFBw/W7hBpMrizb
	 fmgDfQkxj4Mx3n4VAHTSVE3UBcUlwUCveG1O3NGLIDyRGGerVnPr/Xln98jz2VJl+k
	 pmLTLxD8Gnz/TJRxdZV3L31CW9Hg6y0++4KD4gWE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Yu Kuai <yukuai3@huawei.com>,
	Song Liu <song@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 369/484] md/raid5: avoid BUG_ON() while continue reshape after reassembling
Date: Thu, 15 Aug 2024 15:23:47 +0200
Message-ID: <20240815131955.689713593@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240815131941.255804951@linuxfoundation.org>
References: <20240815131941.255804951@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yu Kuai <yukuai3@huawei.com>

[ Upstream commit 305a5170dc5cf3d395bb4c4e9239bca6d0b54b49 ]

Currently, mdadm support --revert-reshape to abort the reshape while
reassembling, as the test 07revert-grow. However, following BUG_ON()
can be triggerred by the test:

kernel BUG at drivers/md/raid5.c:6278!
invalid opcode: 0000 [#1] PREEMPT SMP PTI
irq event stamp: 158985
CPU: 6 PID: 891 Comm: md0_reshape Not tainted 6.9.0-03335-g7592a0b0049a #94
RIP: 0010:reshape_request+0x3f1/0xe60
Call Trace:
 <TASK>
 raid5_sync_request+0x43d/0x550
 md_do_sync+0xb7a/0x2110
 md_thread+0x294/0x2b0
 kthread+0x147/0x1c0
 ret_from_fork+0x59/0x70
 ret_from_fork_asm+0x1a/0x30
 </TASK>

Root cause is that --revert-reshape update the raid_disks from 5 to 4,
while reshape position is still set, and after reassembling the array,
reshape position will be read from super block, then during reshape the
checking of 'writepos' that is caculated by old reshape position will
fail.

Fix this panic the easy way first, by converting the BUG_ON() to
WARN_ON(), and stop the reshape if checkings fail.

Noted that mdadm must fix --revert-shape as well, and probably md/raid
should enhance metadata validation as well, however this means
reassemble will fail and there must be user tools to fix the wrong
metadata.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
Signed-off-by: Song Liu <song@kernel.org>
Link: https://lore.kernel.org/r/20240611132251.1967786-13-yukuai1@huaweicloud.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/md/raid5.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index bcd43cca94f9f..87b713142e15d 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -6007,7 +6007,9 @@ static sector_t reshape_request(struct mddev *mddev, sector_t sector_nr, int *sk
 	safepos = conf->reshape_safe;
 	sector_div(safepos, data_disks);
 	if (mddev->reshape_backwards) {
-		BUG_ON(writepos < reshape_sectors);
+		if (WARN_ON(writepos < reshape_sectors))
+			return MaxSector;
+
 		writepos -= reshape_sectors;
 		readpos += reshape_sectors;
 		safepos += reshape_sectors;
@@ -6025,14 +6027,18 @@ static sector_t reshape_request(struct mddev *mddev, sector_t sector_nr, int *sk
 	 * to set 'stripe_addr' which is where we will write to.
 	 */
 	if (mddev->reshape_backwards) {
-		BUG_ON(conf->reshape_progress == 0);
+		if (WARN_ON(conf->reshape_progress == 0))
+			return MaxSector;
+
 		stripe_addr = writepos;
-		BUG_ON((mddev->dev_sectors &
-			~((sector_t)reshape_sectors - 1))
-		       - reshape_sectors - stripe_addr
-		       != sector_nr);
+		if (WARN_ON((mddev->dev_sectors &
+		    ~((sector_t)reshape_sectors - 1)) -
+		    reshape_sectors - stripe_addr != sector_nr))
+			return MaxSector;
 	} else {
-		BUG_ON(writepos != sector_nr + reshape_sectors);
+		if (WARN_ON(writepos != sector_nr + reshape_sectors))
+			return MaxSector;
+
 		stripe_addr = sector_nr;
 	}
 
-- 
2.43.0




