Return-Path: <stable+bounces-153113-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D520CADD263
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 17:41:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34EED3A19E2
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 15:41:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68A972EA487;
	Tue, 17 Jun 2025 15:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="F9gAEoLR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23F7D2ECD0B;
	Tue, 17 Jun 2025 15:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750174905; cv=none; b=KJei69rfdTRl8FESiykAw2j/VUulzclaLRgkaKewi88QWE9jYaojmJ6B/DJw3aSeaHSQKcsRsRh/ltozB8VPbxCkNhTimN6msGYjqsShslsI7DhdcEJLXD14EfAW3PrGz1FHBSoFDO7/oKlX8f0oKg9dVicEbunYFGjNuXOdcJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750174905; c=relaxed/simple;
	bh=qMsh8x4/dHokZtJFTUKEvS9Unmxtxnj6wvuEGYp2Ndk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KfcOwzYv0cZwbZz7erF7ZJ0q7Y0BHcjEKfYIkwJHA3QA+ZilUw+BQIfpjxYDmxDGAjzQERYcwkan76g1U7oqxieh8veXjNTNSZNVdzjCCjYTrnkvxk8ZkL4/ezQ0wPT8XfPRyYFYZdPyfyy++tWNquYUC+6dTkWdQlwLZ/DuGpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=F9gAEoLR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8867DC4CEE3;
	Tue, 17 Jun 2025 15:41:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750174905;
	bh=qMsh8x4/dHokZtJFTUKEvS9Unmxtxnj6wvuEGYp2Ndk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=F9gAEoLRkqoV4yWa/PdmR6WvYWy+Ggs4xlioZQqaiF/JmRg9SH8KNWlBugXh69psz
	 hZq0LyJ0+nfcapFxPz8KGfLHNVS9t/L3funrRJiYTFZJTnynWzlod0VUxUxjJoE+9t
	 /CidAi6l8dcRP3QiMEwbb/AynLEkv3tFcDkvsCiM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Yu Kuai <yukuai3@huawei.com>,
	Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.15 032/780] brd: fix aligned_sector from brd_do_discard()
Date: Tue, 17 Jun 2025 17:15:40 +0200
Message-ID: <20250617152452.813141217@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250617152451.485330293@linuxfoundation.org>
References: <20250617152451.485330293@linuxfoundation.org>
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

6.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yu Kuai <yukuai3@huawei.com>

[ Upstream commit d4099f8893b057ad7e8d61df76bdeaf807ebd679 ]

The calculation is just wrong, fix it by round_up().

Fixes: 9ead7efc6f3f ("brd: implement discard support")
Signed-off-by: Yu Kuai <yukuai3@huawei.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Link: https://lore.kernel.org/r/20250506061756.2970934-3-yukuai1@huaweicloud.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/block/brd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/brd.c b/drivers/block/brd.c
index 292f127cae0ab..9549cd71e083b 100644
--- a/drivers/block/brd.c
+++ b/drivers/block/brd.c
@@ -224,7 +224,7 @@ static int brd_do_bvec(struct brd_device *brd, struct page *page,
 
 static void brd_do_discard(struct brd_device *brd, sector_t sector, u32 size)
 {
-	sector_t aligned_sector = (sector + PAGE_SECTORS) & ~PAGE_SECTORS;
+	sector_t aligned_sector = round_up(sector, PAGE_SECTORS);
 	struct page *page;
 
 	size -= (aligned_sector - sector) * SECTOR_SIZE;
-- 
2.39.5




