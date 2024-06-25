Return-Path: <stable+bounces-55166-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 498F6916264
	for <lists+stable@lfdr.de>; Tue, 25 Jun 2024 11:35:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C24F1C212A0
	for <lists+stable@lfdr.de>; Tue, 25 Jun 2024 09:35:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C56571494AF;
	Tue, 25 Jun 2024 09:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="n9bxUCJ4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E4F0FBEF;
	Tue, 25 Jun 2024 09:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719308105; cv=none; b=qLe/zgvcLB8ub2EUWQLQdBEuhrEOvKF6QFF7xLWMXuwNBVlUTwcnAn93SNlct1T94Dio2D+Ab96Qe0eyPHyfyKb0CAu8NE98UZzPO8JJHSsXQ8RO9xgC8JUPtgml3NLhzhyq6sEjlJMM32M/Q38RJ7mN8zKGAQh/E9rUdkk1SuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719308105; c=relaxed/simple;
	bh=aCatiaAqY1HabtQU+B7oOl+i5BGbNr1iD+gbIm93PcM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kYJjdSKp56WAY4aTOoXEwb25tPVhj0Y8GFEs4dbaeMJqkWU5pu92oGXfUaSKlSDqlyDTj6XLF2MoJeb0LYBK3qWZeDE38gSem3vKaAkXYjsAyb8eOBHkdHp3RJUW1KBaqRSBywDi1nVuUj5fOhODFGnK+lkRJLSemBm5umsDfec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=n9bxUCJ4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D430C32781;
	Tue, 25 Jun 2024 09:35:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1719308104;
	bh=aCatiaAqY1HabtQU+B7oOl+i5BGbNr1iD+gbIm93PcM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=n9bxUCJ4Pp7m53sqJaGSyT9q+JvH8/aSm728LuUA8pzTu9eKdRDBBzXogsCkEndl4
	 K3MDr1y7aT9QMGrste1vU/EdnO3sC1gVDVr7pJ2gPkTEovr6bCgmmDmS4sqzo6VCP/
	 khhF11PvvxO3G42xmN2N6SgK4Lvw6pBNVIejG/l4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Jan Kara <jack@suse.cz>,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.9 001/250] fs/writeback: bail out if there is no more inodes for IO and queued once
Date: Tue, 25 Jun 2024 11:29:19 +0200
Message-ID: <20240625085548.092907113@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240625085548.033507125@linuxfoundation.org>
References: <20240625085548.033507125@linuxfoundation.org>
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

6.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kemeng Shi <shikemeng@huaweicloud.com>

[ Upstream commit d92109891f21cf367caa2cc6dff11a4411d917f4 ]

For case there is no more inodes for IO in io list from last wb_writeback,
We may bail out early even there is inode in dirty list should be written
back. Only bail out when we queued once to avoid missing dirtied inode.

This is from code reading...

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
Link: https://lore.kernel.org/r/20240228091958.288260-3-shikemeng@huaweicloud.com
Reviewed-by: Jan Kara <jack@suse.cz>
[brauner@kernel.org: fold in memory corruption fix from Jan in [1]]
Link: https://lore.kernel.org/r/20240405132346.bid7gibby3lxxhez@quack3 [1]
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/fs-writeback.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index e4f17c53ddfcf..d31853032a931 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -2069,6 +2069,7 @@ static long wb_writeback(struct bdi_writeback *wb,
 	struct inode *inode;
 	long progress;
 	struct blk_plug plug;
+	bool queued = false;
 
 	blk_start_plug(&plug);
 	for (;;) {
@@ -2111,8 +2112,10 @@ static long wb_writeback(struct bdi_writeback *wb,
 			dirtied_before = jiffies;
 
 		trace_writeback_start(wb, work);
-		if (list_empty(&wb->b_io))
+		if (list_empty(&wb->b_io)) {
 			queue_io(wb, work, dirtied_before);
+			queued = true;
+		}
 		if (work->sb)
 			progress = writeback_sb_inodes(work->sb, wb, work);
 		else
@@ -2127,7 +2130,7 @@ static long wb_writeback(struct bdi_writeback *wb,
 		 * mean the overall work is done. So we keep looping as long
 		 * as made some progress on cleaning pages or inodes.
 		 */
-		if (progress) {
+		if (progress || !queued) {
 			spin_unlock(&wb->list_lock);
 			continue;
 		}
-- 
2.43.0




