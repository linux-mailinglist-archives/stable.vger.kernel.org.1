Return-Path: <stable+bounces-89997-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37F129BDC65
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 03:21:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 731ED1C22FC0
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 02:21:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D22B1DD0E1;
	Wed,  6 Nov 2024 02:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I2uOBv1M"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A2CE18FC7E;
	Wed,  6 Nov 2024 02:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730859128; cv=none; b=EZnK4FbiTyYJvyYOhxGxYeYV5+a4QC/iEmAPFfgF1H8gqf2uGsByEuEZ41iAbRWZewkX6qIq3n70SDqaW0EKnJohFriIoEpbm2R0ukZI8U5ugoXKvwP98rvv4uIY02ry2s5oW2S2tuha43e3oLVoSc/tXGN62+cyCwvZvzHWriA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730859128; c=relaxed/simple;
	bh=KleIl4yJ8yfZ62BodLKA6r11H/0Q0ZkqPjQZhhON9TM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OLx5QOOJdbqvY9riNwCtlflyc54UTRKcP+V+JMvh37gfnIM82QyP2LN81vC2u18TWQiNKI0js6BSKTuiHBhaAE40xkcJBMXQ5ZF7SWbN3CoEPd2nJKJYpwhEUY3egRqC4KWlBn6Nnu0nkLycfWIPy7qQ/ikhuqL3njRD3nxnWMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I2uOBv1M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06605C4CECF;
	Wed,  6 Nov 2024 02:12:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730859127;
	bh=KleIl4yJ8yfZ62BodLKA6r11H/0Q0ZkqPjQZhhON9TM=;
	h=From:To:Cc:Subject:Date:From;
	b=I2uOBv1M2+zRa4lLww8g5dX6//iA6Ox/VvB9lMCGt0XoAouKXDjMwAh1m4GngYEW+
	 T2/zkaKe+TWRUwaQ0mEB19SWmN8NRrClL4vBGwoeYMMnf40/z27mUBoiYLPvfh1M3j
	 gBJ7LZxP31X5VvnEfZT8fYSEdY4+X92ThLq8GLG093A54hLRzaWszSpQax09YT1Swv
	 nrhDELgQOZtcmyvDsipXbuTMDQ9s2S6DbUwtQn8U7xqMpKkrz95yRxoKfu28txJ8PG
	 b71bZNJ0hXpYaYsVx/gLuK2kow8o0xv7iZEhYLoHtbD3uqEgMFsAvP8NrgJjJ1tmHf
	 G4VOKKkVNIT0Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	alexander.usyskin@intel.com
Cc: stable <stable@kernel.org>,
	Rohit Agarwal <rohiagar@chromium.org>,
	Brian Geffon <bgeffon@google.com>,
	Tomas Winkler <tomasw@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org
Subject: FAILED: Patch "mei: use kvmalloc for read buffer" failed to apply to v5.15-stable tree
Date: Tue,  5 Nov 2024 21:12:03 -0500
Message-ID: <20241106021203.182660-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: ignore
X-stable: review
Content-Transfer-Encoding: 8bit

The patch below does not apply to the v5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 4adf613e01bf99e1739f6ff3e162ad5b7d578d1a Mon Sep 17 00:00:00 2001
From: Alexander Usyskin <alexander.usyskin@intel.com>
Date: Tue, 15 Oct 2024 15:31:57 +0300
Subject: [PATCH] mei: use kvmalloc for read buffer

Read buffer is allocated according to max message size, reported by
the firmware and may reach 64K in systems with pxp client.
Contiguous 64k allocation may fail under memory pressure.
Read buffer is used as in-driver message storage and not required
to be contiguous.
Use kvmalloc to allow kernel to allocate non-contiguous memory.

Fixes: 3030dc056459 ("mei: add wrapper for queuing control commands.")
Cc: stable <stable@kernel.org>
Reported-by: Rohit Agarwal <rohiagar@chromium.org>
Closes: https://lore.kernel.org/all/20240813084542.2921300-1-rohiagar@chromium.org/
Tested-by: Brian Geffon <bgeffon@google.com>
Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
Acked-by: Tomas Winkler <tomasw@gmail.com>
Link: https://lore.kernel.org/r/20241015123157.2337026-1-alexander.usyskin@intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/misc/mei/client.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/mei/client.c b/drivers/misc/mei/client.c
index 9d090fa07516f..be011cef12e5d 100644
--- a/drivers/misc/mei/client.c
+++ b/drivers/misc/mei/client.c
@@ -321,7 +321,7 @@ void mei_io_cb_free(struct mei_cl_cb *cb)
 		return;
 
 	list_del(&cb->list);
-	kfree(cb->buf.data);
+	kvfree(cb->buf.data);
 	kfree(cb->ext_hdr);
 	kfree(cb);
 }
@@ -497,7 +497,7 @@ struct mei_cl_cb *mei_cl_alloc_cb(struct mei_cl *cl, size_t length,
 	if (length == 0)
 		return cb;
 
-	cb->buf.data = kmalloc(roundup(length, MEI_SLOT_SIZE), GFP_KERNEL);
+	cb->buf.data = kvmalloc(roundup(length, MEI_SLOT_SIZE), GFP_KERNEL);
 	if (!cb->buf.data) {
 		mei_io_cb_free(cb);
 		return NULL;
-- 
2.43.0





