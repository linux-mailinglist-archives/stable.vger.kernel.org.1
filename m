Return-Path: <stable+bounces-132506-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 633EDA882A9
	for <lists+stable@lfdr.de>; Mon, 14 Apr 2025 15:41:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 755AC1888CB0
	for <lists+stable@lfdr.de>; Mon, 14 Apr 2025 13:39:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF37628F523;
	Mon, 14 Apr 2025 13:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t2PdMGNG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D19928F51C;
	Mon, 14 Apr 2025 13:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744637293; cv=none; b=CrvHzPdh5Sxxf6aelC+Dh2rAClhIv9pove6ieGJmTjI2WaI785ssswIaiySh6cY2gsA+d7VHdO/34UJqEpbcqHa1AhXWaF33zxI2wZZRTbHaKWfgMZGtMT8RsG7WGBPtOiFLq6Fiz9vsacj5GPa7BFNsssA9gngN8WIecQ4wm/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744637293; c=relaxed/simple;
	bh=D6E+ftwKaEDnlOgH7CxwdYq9Pjv4XAYi+CX9eMqeQas=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CXE+glswF1WITZR7aZ9dB0rRJWeqA8UulrQ9ZwlS8LaNXHpjB+Dao/xe2Kmx1cBE6YCrDLpoIID2IxziJ+ER9tLSo7+UjDywUFaTmWdckkTj1sEN7hYN44hGJTaJQazgBW8QlnD7qV8T0iYjeEgMbWtF6Z6GJd73+Uyt7VVH7cI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t2PdMGNG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E20B2C4CEE2;
	Mon, 14 Apr 2025 13:28:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744637293;
	bh=D6E+ftwKaEDnlOgH7CxwdYq9Pjv4XAYi+CX9eMqeQas=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=t2PdMGNGhB1O1gGOOrXqJjX7XLV3HZqQhpx4EabrEYB3tD5RyAAdweG3coo3of5e+
	 fU4Xl7xTD4wLO45T5a0pJF/PfFnVSodGW007U9lbJNWPXnNOpWNwP90igx6H+szxxh
	 bhGDHoRYqs7BlkNLJFA6trx2PSl807nf81hael//AhDj2eMc9uDA4QiT8UTdxWRLXH
	 e5BNnS1VD/ZXG0WWbGdVYNpzP6m4bdoHJDLWIbV4NZc6/SbAJQG+bHIMRwn3aN3/Qx
	 ne6JoT+AoibBiX8RqW1TakWYbTzWWbgue35NygXJy4T4YzQF+z91HOnSGFLbMpyBtX
	 5LRfkkNeGBoUg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Uday Shankar <ushankar@purestorage.com>,
	Christoph Hellwig <hch@lst.de>,
	Sasha Levin <sashal@kernel.org>,
	kbusch@kernel.org,
	sagi@grimberg.me,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 6.13 18/34] nvme: multipath: fix return value of nvme_available_path
Date: Mon, 14 Apr 2025 09:27:12 -0400
Message-Id: <20250414132729.679254-18-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250414132729.679254-1-sashal@kernel.org>
References: <20250414132729.679254-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.13.11
Content-Transfer-Encoding: 8bit

From: Uday Shankar <ushankar@purestorage.com>

[ Upstream commit e3105f54a51554fb1bbf19dcaf93c4411d2d6c8a ]

The function returns bool so we should return false, not NULL. No
functional changes are expected.

Signed-off-by: Uday Shankar <ushankar@purestorage.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/multipath.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index a85d190942bdf..bc3b037737c8c 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -427,7 +427,7 @@ static bool nvme_available_path(struct nvme_ns_head *head)
 	struct nvme_ns *ns;
 
 	if (!test_bit(NVME_NSHEAD_DISK_LIVE, &head->flags))
-		return NULL;
+		return false;
 
 	list_for_each_entry_srcu(ns, &head->list, siblings,
 				 srcu_read_lock_held(&head->srcu)) {
-- 
2.39.5


