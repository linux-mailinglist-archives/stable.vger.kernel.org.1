Return-Path: <stable+bounces-188104-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CD86FBF1717
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 15:08:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 84D4E4F52FC
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 13:06:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C45F831326D;
	Mon, 20 Oct 2025 13:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U2rJBfhV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D98E130214F
	for <stable@vger.kernel.org>; Mon, 20 Oct 2025 13:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760965613; cv=none; b=txx+wim9KU8uKoBFyRuCqTmRnr8z5p3mvFGXY/i5qV+1Hn+STSWzhf1y8bdM1tmzVR3rd8EJgTnYqDDo6ay5/u2Bkid3MHCOD2o8jxgx1WYyuveHXbMmiSzANyMs3ruRdpYs80ldebZyImePA4v9o9LvJ+PzpOX721AfuxXkeEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760965613; c=relaxed/simple;
	bh=b/W+fEHXOEzB/bImYbbT56LtF6pyhGP9KFnFN1sRsIc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rAHeusjhbtEStq7izyFpcdy1GJnPnMjXEVs+0hHIwI8CS52uqmsnmvqDHHkcCHyEad8RFbwcPdBnU5kxaMQ5ERAJ9f0rWA+h7MQa2+wcs2ynp5yLh8XKH39hi5rpvnj+IdtiS2jkBAPn2rHFix93Dk5Zb3yxbKd3GGW0b1jQaXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U2rJBfhV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 821A8C113D0;
	Mon, 20 Oct 2025 13:06:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760965612;
	bh=b/W+fEHXOEzB/bImYbbT56LtF6pyhGP9KFnFN1sRsIc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=U2rJBfhVTSistD8WIaMM1K2AEd8SPJvyG6fTmCcoY+6yF9mV7bgfi7nnipv+lOrsC
	 ddhnrKPTUXDjs8v+zV0lFdoRmp6qqtE98Mu3RiBpZT7TqGu+fqwx179MLA/KnVBFcv
	 YpPMpsaMCBv7bg6riDdehFCld+RSkT/+t0lWQFtGYfoZziUjERlCQMrMCYllTlvsU3
	 le5N/pHvv/DAvWfdB5qMs/wN/o7odfKIGA9KCVK+D8KCp9ZqTO5vtyHbU7/6Rdcugh
	 e4P/x2QpKLHi+CCbVHSgF43UFF6GdLxlPmuvPA+Xp6U8I967gDaUcTEAaj5kwY1hFx
	 0lspKL8KOk7ig==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: John Garry <john.g.garry@oracle.com>,
	Yu Kuai <yukuai3@huawei.com>,
	Hannes Reinecke <hare@suse.de>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/4] md/raid0: Handle bio_split() errors
Date: Mon, 20 Oct 2025 09:06:46 -0400
Message-ID: <20251020130649.1765603-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025101606-eggshell-static-9bca@gregkh>
References: <2025101606-eggshell-static-9bca@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: John Garry <john.g.garry@oracle.com>

[ Upstream commit 74538fdac3e85aae55eb4ed786478ed2384cb85d ]

Add proper bio_split() error handling. For any error, set bi_status, end
the bio, and return.

Reviewed-by: Yu Kuai <yukuai3@huawei.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: John Garry <john.g.garry@oracle.com>
Link: https://lore.kernel.org/r/20241111112150.3756529-5-john.g.garry@oracle.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Stable-dep-of: 22f166218f73 ("md: fix mssing blktrace bio split events")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/md/raid0.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/md/raid0.c b/drivers/md/raid0.c
index 31bea72bcb01a..67ec633d27e26 100644
--- a/drivers/md/raid0.c
+++ b/drivers/md/raid0.c
@@ -464,6 +464,12 @@ static void raid0_handle_discard(struct mddev *mddev, struct bio *bio)
 		struct bio *split = bio_split(bio,
 			zone->zone_end - bio->bi_iter.bi_sector, GFP_NOIO,
 			&mddev->bio_set);
+
+		if (IS_ERR(split)) {
+			bio->bi_status = errno_to_blk_status(PTR_ERR(split));
+			bio_endio(bio);
+			return;
+		}
 		bio_chain(split, bio);
 		submit_bio_noacct(bio);
 		bio = split;
@@ -606,6 +612,12 @@ static bool raid0_make_request(struct mddev *mddev, struct bio *bio)
 	if (sectors < bio_sectors(bio)) {
 		struct bio *split = bio_split(bio, sectors, GFP_NOIO,
 					      &mddev->bio_set);
+
+		if (IS_ERR(split)) {
+			bio->bi_status = errno_to_blk_status(PTR_ERR(split));
+			bio_endio(bio);
+			return true;
+		}
 		bio_chain(split, bio);
 		raid0_map_submit_bio(mddev, bio);
 		bio = split;
-- 
2.51.0


