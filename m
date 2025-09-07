Return-Path: <stable+bounces-178781-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DC9EB4800A
	for <lists+stable@lfdr.de>; Sun,  7 Sep 2025 22:45:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C2713B3F09
	for <lists+stable@lfdr.de>; Sun,  7 Sep 2025 20:45:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00205211A28;
	Sun,  7 Sep 2025 20:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IBjrZ8P6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0BE97E107;
	Sun,  7 Sep 2025 20:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757277937; cv=none; b=fyeA0JCNp+pADvr7zTtThN7G0Bj5EU/PCQyKdu9Vk3UM4Uzsb6orzpMbnUXnS0H/Jl9KsMop4Lb2dtfkiU7puyCQxVZ6CThh1SoR1ZIaAMjvimYu6MdThg7lEwe4iicJOvPUSx4H6QAx3xO+VI0MOSFbUV32frozAxisPPfcxt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757277937; c=relaxed/simple;
	bh=nW9dFkpreZKZF8Bw5NKnKWWtum8P+TpCVMBF0kjJ2uY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U1K2u9+yAPLnJZXoJ6TEs+xeDRS4eWvkjtMKbAXgPUFl2Xt3Qxb6LYj+Iqnl4//FNh/hP2ESsEaKwrUj2c3abZGXwRi/3VltSLGO9tkm03h1GW+smyQ0Ls82NQpM9CnDT2UVGnAdzb8tyUHh6oxU1c7WvYrujJu6W5PyIBy3PYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IBjrZ8P6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33EFAC4CEF0;
	Sun,  7 Sep 2025 20:45:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1757277937;
	bh=nW9dFkpreZKZF8Bw5NKnKWWtum8P+TpCVMBF0kjJ2uY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IBjrZ8P6w+kWkGAzsurI/nGia7lFxyOD3djbh76DaEcCVZkAJQH+dMtrPaSblePIZ
	 mL5OvgPn2Mg2wSfBaCyq9QiyU8fc9bxA6t5ru5hKxo07AQ3U3Nu1JUOYaQnZA7nEsT
	 wN75E48efjsSrIc7qFy6DS1sQvYMDgO72F4qMFt0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Li Nan <linan122@huawei.com>,
	Yu Kuai <yukuai3@huawei.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.16 171/183] md: prevent incorrect update of resync/recovery offset
Date: Sun,  7 Sep 2025 21:59:58 +0200
Message-ID: <20250907195619.879073788@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250907195615.802693401@linuxfoundation.org>
References: <20250907195615.802693401@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Li Nan <linan122@huawei.com>

[ Upstream commit 7202082b7b7a256d04ec96131c7f859df0a79f64 ]

In md_do_sync(), when md_sync_action returns ACTION_FROZEN, subsequent
call to md_sync_position() will return MaxSector. This causes
'curr_resync' (and later 'recovery_offset') to be set to MaxSector too,
which incorrectly signals that recovery/resync has completed, even though
disk data has not actually been updated.

To fix this issue, skip updating any offset values when the sync action
is FROZEN. The same holds true for IDLE.

Fixes: 7d9f107a4e94 ("md: use new helpers in md_do_sync()")
Signed-off-by: Li Nan <linan122@huawei.com>
Link: https://lore.kernel.org/linux-raid/20250904073452.3408516-1-linan666@huaweicloud.com
Signed-off-by: Yu Kuai <yukuai3@huawei.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/md/md.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index 8746b22060a7c..3f355bb85797f 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -9089,6 +9089,11 @@ void md_do_sync(struct md_thread *thread)
 	}
 
 	action = md_sync_action(mddev);
+	if (action == ACTION_FROZEN || action == ACTION_IDLE) {
+		set_bit(MD_RECOVERY_INTR, &mddev->recovery);
+		goto skip;
+	}
+
 	desc = md_sync_action_name(action);
 	mddev->last_sync_action = action;
 
-- 
2.51.0




