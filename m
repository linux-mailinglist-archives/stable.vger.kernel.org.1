Return-Path: <stable+bounces-132472-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBEFDA8824A
	for <lists+stable@lfdr.de>; Mon, 14 Apr 2025 15:32:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0529C17B080
	for <lists+stable@lfdr.de>; Mon, 14 Apr 2025 13:31:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6122A27F730;
	Mon, 14 Apr 2025 13:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BZ+Sjidy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EE0427F728;
	Mon, 14 Apr 2025 13:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744637215; cv=none; b=QFx5hcmU/DW2KlDg7LlfZ6ijSLATFMMGUCT92Xi0twmcxKa6wOEwrCjl20n6ZUSTlkoARbTl/o2Kiq8Zn2rG76EAJ4NG3s1t0KrabA54MXo6nwUwa3OyamSjhjbGnfTbkwDvCE4vXChAX2gdR+ARIjs/f3iCc6Ezh+IQw+QZYMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744637215; c=relaxed/simple;
	bh=3mmWf7aL2pXLiP/H5JF5mbA92xb7zwsGt3ckJCNigyM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rHGZgbGhSAti67raLMrISu3UnW/q/RnZr0udDONYWQZT0CasBGcI6Z2Qr9xUzvn+AJ2lKIcycAHMupVe97STEP+LnC3ZEomSkUijTkK+9Ce5xptcNj+VG0PxYgNTEOPXNkXeHmybTIWv+j69L8UlQFeOG5142QzuKid9T3WaIVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BZ+Sjidy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC91AC4CEE9;
	Mon, 14 Apr 2025 13:26:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744637214;
	bh=3mmWf7aL2pXLiP/H5JF5mbA92xb7zwsGt3ckJCNigyM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BZ+Sjidy3r1jI83G4iRLZ2lnrsspoVeYJbBif4HpO7EN9fNG3T850QejrxwjFvzXZ
	 RkOBhyoA1jFrtBMndDmgd/vxVRrOiXHxo/7oLjMFM+A/P7VL9eD0wSyOy39KUCfABc
	 onGGDRwn6rDGzvgF+qGpgIkhNLHIpGlytq70kVS2zEm6LCNOYlXpBhmb0r27xeH5og
	 AB6eaPK/FIRAQVQYpCiXYimzr4UtHfFtTlSv8sFMMhhpFYe7KKC6cZ1eTppuzDi2yh
	 qW1kBLXKv1Aa30s+V6NmnlNHKi5FrSGSbAnP1gXq0xF1kn9eYMFkQZ8h7P3sHqXy+o
	 PMQ9848a3jSKQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Uday Shankar <ushankar@purestorage.com>,
	Christoph Hellwig <hch@lst.de>,
	Sasha Levin <sashal@kernel.org>,
	kbusch@kernel.org,
	sagi@grimberg.me,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 6.14 18/34] nvme: multipath: fix return value of nvme_available_path
Date: Mon, 14 Apr 2025 09:25:54 -0400
Message-Id: <20250414132610.677644-18-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250414132610.677644-1-sashal@kernel.org>
References: <20250414132610.677644-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.2
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
index 2a76355650830..f39823cde62c7 100644
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


