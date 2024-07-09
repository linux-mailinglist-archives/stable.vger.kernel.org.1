Return-Path: <stable+bounces-58781-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E6AE92BFD1
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 18:26:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FBC71C229B1
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 16:26:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 323E61AB513;
	Tue,  9 Jul 2024 16:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iwAvnTni"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E357F1AB502;
	Tue,  9 Jul 2024 16:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720542051; cv=none; b=EKJrts4+eoT1GwaiAj8gDTLmKI4tDS9k1o723b0rUTb87zqsuysy39IsZRcpf1HGfGHMXhEK7kW8hnsqBRVsvs5X9XLorgaGmw4QKjWaO7iMX2VI6QF3yXhHnRSFa/vtUgDrKmV0R8QeTl7+LCqQAz7j2FfLNsiJzI9iEAoS4oU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720542051; c=relaxed/simple;
	bh=D9H8wdEEMOSwAlm1ZCn+yMnYzuqGdKpm93UdqURfZfo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Efzab69ciBnldveMkc/eucSy9zJYjm4pja3iK9o7e0sGyoC0L2QmfH3/HhSV/IL+GLyWXKEpuvA6h4IDXafIYMRlY5Bf7tGm+BehAph5/jkYhh6EhxZ8ImWPrPzJV/sZY4VKv3djlVfpq/+sHDU/0Bq88UG28zDeN7A9UyKyvMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iwAvnTni; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9823C3277B;
	Tue,  9 Jul 2024 16:20:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720542050;
	bh=D9H8wdEEMOSwAlm1ZCn+yMnYzuqGdKpm93UdqURfZfo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iwAvnTniFZ6oVBzolUUeNduZnFJo7g6FWClL73ooNCpxhPpf4/eqQhEF6KnaSniXU
	 jgE+r3xQD7rOVk1l5pahwOtv9mPGljr5ZUUhfUUtkN0mEs+iESyTR84vBpUZBcmuT+
	 tikFzre2C5G0dT4vWK7aPgxbhTyoDG+4JBbY7rZ8xJn/H3mxHIwRIRalIznrCo2QdQ
	 uNDYuNf53FmXUiJnL64uliMHjAMiGZflKccJHbbQ1n+3Ph75uZYrYJ6NcuQ0Ibd4S5
	 NRkoTpnhFWvqBQrEJGz8m5kirU9hSsVebpX+LpNVLA6ayabPLpz1Lp2gRwLEGZpbCa
	 OgOFyFVBkCJMQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Boyang Yu <yuboyang@dapustor.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	sagi@grimberg.me,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 6.9 19/40] nvme: fix NVME_NS_DEAC may incorrectly identifying the disk as EXT_LBA.
Date: Tue,  9 Jul 2024 12:18:59 -0400
Message-ID: <20240709162007.30160-19-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240709162007.30160-1-sashal@kernel.org>
References: <20240709162007.30160-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.9.8
Content-Transfer-Encoding: 8bit

From: Boyang Yu <yuboyang@dapustor.com>

[ Upstream commit 9570a48847e3acfa1a741cef431c923325ddc637 ]

The value of NVME_NS_DEAC is 3,
which means NVME_NS_METADATA_SUPPORTED | NVME_NS_EXT_LBAS. Provide a
unique value for this feature flag.

Fixes 1b96f862eccc ("nvme: implement the DEAC bit for the Write Zeroes command")
Signed-off-by: Boyang Yu <yuboyang@dapustor.com>
Reviewed-by: Kanchan Joshi <joshi.k@samsung.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/nvme.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index d7bcc6d51e84e..3f2b0d41e4819 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -503,7 +503,7 @@ static inline bool nvme_ns_head_multipath(struct nvme_ns_head *head)
 enum nvme_ns_features {
 	NVME_NS_EXT_LBAS = 1 << 0, /* support extended LBA format */
 	NVME_NS_METADATA_SUPPORTED = 1 << 1, /* support getting generated md */
-	NVME_NS_DEAC,		/* DEAC bit in Write Zeores supported */
+	NVME_NS_DEAC = 1 << 2,		/* DEAC bit in Write Zeores supported */
 };
 
 struct nvme_ns {
-- 
2.43.0


