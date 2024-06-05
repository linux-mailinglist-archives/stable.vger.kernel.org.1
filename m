Return-Path: <stable+bounces-48172-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 54A018FCD53
	for <lists+stable@lfdr.de>; Wed,  5 Jun 2024 14:40:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA27D285F62
	for <lists+stable@lfdr.de>; Wed,  5 Jun 2024 12:40:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40035195806;
	Wed,  5 Jun 2024 12:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IT0qW2cl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0DA01957FF;
	Wed,  5 Jun 2024 12:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717589056; cv=none; b=KcMJ6/+YC9XCzxeinNN5rjdHYM7Rf9rlpVnoqwzpIk7QMp3GgJyi1uzTFp0nwbWqwR3d/xPlRIwSj9IU9WYHaaHgQ9nfvVxcLzobZ88hSaQXEaIEovW9JOaLxMrLG84it/rUM9Dsrdp2lsZdV+eJldetKAy6FvQInUTZdQHVEZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717589056; c=relaxed/simple;
	bh=Boibbb9MNlFAY3AzByrj3P2rw8iStYw4ORPbIwyS/c0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f/8BiUqMH2ImGB845rD+uyh0qo5bEukB36UjUmEkPzOt8KKTXDnGoHWoKSK9ld12D2wIpL2ipNv4WKlmHlHDFDFRQ8vKp5sUv6hrYo/bPnBZHsTWX2RsDHiQECW6ZyeKCEL+7R6ERAMN/7vL9AGKH7+fT4ITV0YbPwxUsQ+16h0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IT0qW2cl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D1F7C4AF07;
	Wed,  5 Jun 2024 12:04:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717589055;
	bh=Boibbb9MNlFAY3AzByrj3P2rw8iStYw4ORPbIwyS/c0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IT0qW2clnHKAm7ZvKCl0SfnJbZA2gJQGI00KDl4na6pfBy9ngbTYH4M1PN2Sqzpb7
	 9hfkbY+tDp+UGD4xNl4g9kWxJalvErDSyCFx75d5lr50SDGMUYwWxHj1bGieK570iN
	 XqtoXxDBNyp3EKAfeV1BB0hJQOIvWWw6EZjd2fEXNLBP1P/WnGR2bqBT3CkQA0RNg0
	 25S+z/+4GTyuber/NlnyMT3a5SvlG7H2p55rufhoXFpbbSYDg3HKF4Atg9Dt4TsZg5
	 Rs4kGkFB6TLN1xa1uMseG4PqW+FCahuGWOVvtRGgzUwEXZL+y0eFFHA9BTV18zcigc
	 55Tm0zcHHrgzA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Kundan Kumar <kundan.kumar@samsung.com>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 6.6 04/18] nvme: adjust multiples of NVME_CTRL_PAGE_SIZE in offset
Date: Wed,  5 Jun 2024 08:03:43 -0400
Message-ID: <20240605120409.2967044-4-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240605120409.2967044-1-sashal@kernel.org>
References: <20240605120409.2967044-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.32
Content-Transfer-Encoding: 8bit

From: Kundan Kumar <kundan.kumar@samsung.com>

[ Upstream commit 1bd293fcf3af84674e82ed022c049491f3768840 ]

bio_vec start offset may be relatively large particularly when large
folio gets added to the bio. A bigger offset will result in avoiding the
single-segment mapping optimization and end up using expensive
mempool_alloc further.

Rather than using absolute value, adjust bv_offset by
NVME_CTRL_PAGE_SIZE while checking if segment can be fitted into one/two
PRP entries.

Suggested-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Kundan Kumar <kundan.kumar@samsung.com>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/pci.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index e47172bd84efe..8eac383e18f3a 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -778,7 +778,8 @@ static blk_status_t nvme_map_data(struct nvme_dev *dev, struct request *req,
 		struct bio_vec bv = req_bvec(req);
 
 		if (!is_pci_p2pdma_page(bv.bv_page)) {
-			if (bv.bv_offset + bv.bv_len <= NVME_CTRL_PAGE_SIZE * 2)
+			if ((bv.bv_offset & (NVME_CTRL_PAGE_SIZE - 1)) +
+			     bv.bv_len <= NVME_CTRL_PAGE_SIZE * 2)
 				return nvme_setup_prp_simple(dev, req,
 							     &cmnd->rw, &bv);
 
-- 
2.43.0


