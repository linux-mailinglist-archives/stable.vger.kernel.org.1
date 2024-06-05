Return-Path: <stable+bounces-48189-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9714D8FCE11
	for <lists+stable@lfdr.de>; Wed,  5 Jun 2024 14:59:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 18064B218A1
	for <lists+stable@lfdr.de>; Wed,  5 Jun 2024 12:44:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 467273DAC1F;
	Wed,  5 Jun 2024 12:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VNNQ8w73"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 026631C776A;
	Wed,  5 Jun 2024 12:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717589100; cv=none; b=q/Zw6rYtPAu5PAO0UJP9sdfKjQCO2pR2ecccGGRisE4HioxQu8ROcaGz80NILk+x+yvfRGON0swbx0Hqvb49JjeSxbTFc/hiWVWhvy1u61qj5WyWo9KNRAqNrFFDsMs/a7jL2la4lZYii17EwIApyyPi8Vw/BBy4bphjkAiNTQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717589100; c=relaxed/simple;
	bh=B0k5s6buZQwPBJm0xzZLzHx/9pO9n+AEcUzQ/fkRK88=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WV2TVeLFq6bDLas52mOgJ/R218M/dndOezw/1Rm1fXupQmHPks1QELebrjzX4p2Bx2tICXD+70sSPqypzVOztUpjXbvpvUUt/u2JnwfMWTYa778EmLU9/uh4WBIdvTNFsHIZwhEL+KSddXGMvM21weBnfvtb1fX+VSdKR18MgPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VNNQ8w73; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00A01C32786;
	Wed,  5 Jun 2024 12:04:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717589099;
	bh=B0k5s6buZQwPBJm0xzZLzHx/9pO9n+AEcUzQ/fkRK88=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VNNQ8w73Ql4nrJ0cgbCU/RgrgjqLtlhHM6LkwoOv0Mpk2Hw1GxgT+P0Exb1w+dxuG
	 2SgtTJx805IpzBA45MRc7xwMILnHAOddtlPmG+xQRoEYbr8bjQXp3NbOZ1oxEE/Rb5
	 oNh1a3ZZfvGi6+9fjcRwy5dd/OpAmLNxo2MTSi+XQUyZWifWkSKDbe9OQLuYHr+InF
	 T4mP8WdCWgPNGdy4oTQLNykWVv/zywgW6dOjUO1KjG0onpc3m0IY/HlQVBWPAEUU0y
	 FcP03EmPpXsjlyIKxfeKwHF+az/hFLFSNbevLroQg1EaZzawBN064yiJGdEkL5VQE6
	 HNVOOKdhziQpg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Kundan Kumar <kundan.kumar@samsung.com>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 6.1 03/14] nvme: adjust multiples of NVME_CTRL_PAGE_SIZE in offset
Date: Wed,  5 Jun 2024 08:04:36 -0400
Message-ID: <20240605120455.2967445-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240605120455.2967445-1-sashal@kernel.org>
References: <20240605120455.2967445-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.92
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
index 5ff09f2cacab7..32e89ea853a47 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -824,7 +824,8 @@ static blk_status_t nvme_map_data(struct nvme_dev *dev, struct request *req,
 		struct bio_vec bv = req_bvec(req);
 
 		if (!is_pci_p2pdma_page(bv.bv_page)) {
-			if (bv.bv_offset + bv.bv_len <= NVME_CTRL_PAGE_SIZE * 2)
+			if ((bv.bv_offset & (NVME_CTRL_PAGE_SIZE - 1)) +
+			     bv.bv_len <= NVME_CTRL_PAGE_SIZE * 2)
 				return nvme_setup_prp_simple(dev, req,
 							     &cmnd->rw, &bv);
 
-- 
2.43.0


