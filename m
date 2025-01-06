Return-Path: <stable+bounces-107728-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EF31A02E00
	for <lists+stable@lfdr.de>; Mon,  6 Jan 2025 17:42:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 773D3164023
	for <lists+stable@lfdr.de>; Mon,  6 Jan 2025 16:42:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBA861DC99E;
	Mon,  6 Jan 2025 16:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QEw9qgxj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A215D86354;
	Mon,  6 Jan 2025 16:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736181717; cv=none; b=fAJ13r159T9jO5+kuIbP0dHvCLhU6XDsCMTreF6aQwDrwzcZxw+EN1ebrW8WcwRTUY9mCV1nuSky1eHhIG3aiN0g29xkrlZ2Km7HRU1gZXJiKCbxHAZKuhnZLSpkWQHQTQh6f3Du3xzE75Mpqbtev9SG+IEk/neGyPsO56gTwlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736181717; c=relaxed/simple;
	bh=IrRyC4vaKupjSeMIXcC2XYvj4LGYPCKIgeq7EPoSVcU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UgrDCniSM+pGYfm1nOdG8jbA/0SwjgEFRCLqiE1o+nkLTPBICLemFS4kjtoJ+HqsGDAtFGibAuQDntqGzu+d7XnOg4BB24LAaQC5Hg7JL5ENv/gZczy3qJVkqctl3IlNVksOQHca7E5nkpMV9568wRQb5nv1EtlEv+cAyaabQFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QEw9qgxj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D4F1C4CEDF;
	Mon,  6 Jan 2025 16:41:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736181717;
	bh=IrRyC4vaKupjSeMIXcC2XYvj4LGYPCKIgeq7EPoSVcU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QEw9qgxj8/vtHfFp44ozx6N74SzNixU559+ichH6dq5WrO74A4CDCdkOPwJWSwRZt
	 M8a9PRaXh8mgat1abC1RWEwFoLs9WBqgMFz8RlAthrul97c8Vf2qFI7u94cgMaVDBZ
	 T/hBpHiiy5olY/Wf8D1aTaOOiRjFL94ni9kQ+UHQ22GECABlEF1UbtqRj/27reItSd
	 U215Y9j32Ui4THenhatqB4Ga/Vcdagw31ltKte8diPdpO7JTtXgSpRnTIUmbIT4Eh/
	 pyNosAqn4JNn67GrGS54Orz6b8NuJkp0B7LEt+M6ymucBzCYFx2Duzp+UjjCk5lfhx
	 Dn1wLYDzzQuYA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Luis Chamberlain <mcgrof@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	kch@nvidia.com,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 6.12 5/8] nvmet: propagate npwg topology
Date: Mon,  6 Jan 2025 11:41:05 -0500
Message-Id: <20250106164138.1122164-5-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250106164138.1122164-1-sashal@kernel.org>
References: <20250106164138.1122164-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.8
Content-Transfer-Encoding: 8bit

From: Luis Chamberlain <mcgrof@kernel.org>

[ Upstream commit b579d6fdc3a9149bb4d2b3133cc0767130ed13e6 ]

Ensure we propagate npwg to the target as well instead
of assuming its the same logical blocks per physical block.

This ensures devices with large IUs information properly
propagated on the target.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/target/io-cmd-bdev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/target/io-cmd-bdev.c b/drivers/nvme/target/io-cmd-bdev.c
index 0bda83d0fc3e..eaf31c823cbe 100644
--- a/drivers/nvme/target/io-cmd-bdev.c
+++ b/drivers/nvme/target/io-cmd-bdev.c
@@ -36,7 +36,7 @@ void nvmet_bdev_set_limits(struct block_device *bdev, struct nvme_id_ns *id)
 	 */
 	id->nsfeat |= 1 << 4;
 	/* NPWG = Namespace Preferred Write Granularity. 0's based */
-	id->npwg = lpp0b;
+	id->npwg = to0based(bdev_io_min(bdev) / bdev_logical_block_size(bdev));
 	/* NPWA = Namespace Preferred Write Alignment. 0's based */
 	id->npwa = id->npwg;
 	/* NPDG = Namespace Preferred Deallocate Granularity. 0's based */
-- 
2.39.5


