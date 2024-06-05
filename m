Return-Path: <stable+bounces-48203-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 927D28FCDA2
	for <lists+stable@lfdr.de>; Wed,  5 Jun 2024 14:48:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EE0B28AE66
	for <lists+stable@lfdr.de>; Wed,  5 Jun 2024 12:48:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14EE21ABCA8;
	Wed,  5 Jun 2024 12:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EAQQbUVP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C46231A3BB5;
	Wed,  5 Jun 2024 12:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717589133; cv=none; b=lfH7QHPd6Ujlc9WXFHpAfqeq875QgiIRgAhfyUFzFhDz8OFyk4zdMKSnP8IhJF4yiMOaAwKaAYVAkzqhM8PndcPSKT5hdC4WAcuJg4Z6PgvLl0zoKaWqL7bDiVLbAirt2Bg5ll75UGRBvXUWwY3V0m6Lgf2jnSSBDGRQI4nWERY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717589133; c=relaxed/simple;
	bh=//SKX54MzotBgE+LBA+Gyqj8vD5W61QkI0xBfJbktjM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c5tk/8iw++q4qtnN1PgeW9SoqGNACfDsea7LrwQ70qFYL8xAAA9kL+4Q45ldehxNnwgszwwUhhhALUhzw9DrNG/3tpzaj6aPNTd8uCwN6x8c/GBTRsdzaBjCcMmE+7+pndbEYzPsDZtfQfNcHBwTXN9FAiprtdjlusvQamJSYLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EAQQbUVP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4628C4AF0A;
	Wed,  5 Jun 2024 12:05:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717589133;
	bh=//SKX54MzotBgE+LBA+Gyqj8vD5W61QkI0xBfJbktjM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EAQQbUVPDubT99Vb1zdpGue0cPvs64UfH27dlxBWdisyAuElGQZ3cDHceue0YZiAp
	 83sCV6MmKsytyrGWb/qirfDQo8n1zIDv/2fHCDwjF1KpFB2FW50huKibKP+QZLCnWm
	 p+j3FQzBQ+h9UYgZ0mxnODFcqQYj0SHOAqIAQ/An1Dz77I+RBvJ4IqPJ8fCIFpyGGF
	 PIMnrSiz+bnrgsGQeufqCrh9qk6nghDzw8LEJ2SfWvH589UEXIfEvRgN1glroCOfiB
	 6aLzUT9RDr4J7ayf0mFtRdE6TLQA2TLffaweD2ieeMklTHdVjG7MciQ41DuWWSfP9w
	 KYjWUNOy0IpVQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Kundan Kumar <kundan.kumar@samsung.com>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 5.15 03/12] nvme: adjust multiples of NVME_CTRL_PAGE_SIZE in offset
Date: Wed,  5 Jun 2024 08:05:13 -0400
Message-ID: <20240605120528.2967750-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240605120528.2967750-1-sashal@kernel.org>
References: <20240605120528.2967750-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.160
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
index 7bb74112fef37..5a3ba7e390546 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -836,7 +836,8 @@ static blk_status_t nvme_map_data(struct nvme_dev *dev, struct request *req,
 		struct bio_vec bv = req_bvec(req);
 
 		if (!is_pci_p2pdma_page(bv.bv_page)) {
-			if (bv.bv_offset + bv.bv_len <= NVME_CTRL_PAGE_SIZE * 2)
+			if ((bv.bv_offset & (NVME_CTRL_PAGE_SIZE - 1)) +
+			     bv.bv_len <= NVME_CTRL_PAGE_SIZE * 2)
 				return nvme_setup_prp_simple(dev, req,
 							     &cmnd->rw, &bv);
 
-- 
2.43.0


