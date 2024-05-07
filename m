Return-Path: <stable+bounces-43397-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC09D8BF26D
	for <lists+stable@lfdr.de>; Wed,  8 May 2024 01:49:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9467FB2714D
	for <lists+stable@lfdr.de>; Tue,  7 May 2024 23:49:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18F4E1CB303;
	Tue,  7 May 2024 23:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ljKwahNs"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8CDB1C9EDD;
	Tue,  7 May 2024 23:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715123600; cv=none; b=Ls5As22T59kOkCbLZkPaR9nNjXWlj2q/MQJTzgBqHSFpQ6xV48MB3daXleqFEhcleM01XWU/fKgdmdkYggOSPGGJ1BDDWnk5f8jH8oBAZ37bYGEDHyjEWZne4uQRl0APX4Vciqj3ExwnAdBbjSVizP2sxhdKnY1kyoGfkWu8IH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715123600; c=relaxed/simple;
	bh=xKGJxFne+UyiXVYKvVnAuWWupcJYyWxk89f2UMkT1LM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nD7u5s3ncs0I36934pRoCyJzJOANV1SfhzW1EEe/eMlgB1MPTmsY/b/SPOl0OSjLt9B21SQ42X9Mspx0kfpO86K/+jK6gqZkog5CoQjJG0qzXthppo7KR10VqcJRmIIAnZHaKNT16HpaY+ORIjZK1TP9+XCHiyPNxbyNJ9iL0D0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ljKwahNs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3843C2BBFC;
	Tue,  7 May 2024 23:13:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715123599;
	bh=xKGJxFne+UyiXVYKvVnAuWWupcJYyWxk89f2UMkT1LM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ljKwahNs+XuoBF6GUQTLSjF/185ub19j7A3Jh2f0nOIh2x1988JxM0fdlm1MLdC6g
	 pLIxbg7tmw/kk5r0NPIKysRIEM0o3YPlN4cyHnCjBGb7EPXt/ys/hct5ZJyox43d19
	 RJTQG0OpV4O1XBlYli2AGcgPq1jcwIgzfJ1Lzu/RbvO4NJ5EdQ7pxxugp6jncyZ70N
	 JbAwZ4rdFzTmNSDkNivqiHG5koRSrHH2DLNtT5SzfTOKLpWY4LP95hZfu3bD5z85u+
	 bRMVd01a4G7bsz1NSe0vn5UYYvAzzOGdTNV3Nj2Oej2qsP8nsiw5oWQGw68EUiqQ9w
	 73LJj9lv1Z2gg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Maurizio Lombardi <mlombard@redhat.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	hare@suse.de,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 6.1 22/25] nvmet-auth: replace pr_debug() with pr_err() to report an error.
Date: Tue,  7 May 2024 19:12:09 -0400
Message-ID: <20240507231231.394219-22-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240507231231.394219-1-sashal@kernel.org>
References: <20240507231231.394219-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.90
Content-Transfer-Encoding: 8bit

From: Maurizio Lombardi <mlombard@redhat.com>

[ Upstream commit 445f9119e70368ccc964575c2a6d3176966a9d65 ]

In nvmet_auth_host_hash(), if a mismatch is detected in the hash length
the kernel should print an error.

Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/target/auth.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/target/auth.c b/drivers/nvme/target/auth.c
index 1f7d492c4dc26..e900525b78665 100644
--- a/drivers/nvme/target/auth.c
+++ b/drivers/nvme/target/auth.c
@@ -284,9 +284,9 @@ int nvmet_auth_host_hash(struct nvmet_req *req, u8 *response,
 	}
 
 	if (shash_len != crypto_shash_digestsize(shash_tfm)) {
-		pr_debug("%s: hash len mismatch (len %d digest %d)\n",
-			 __func__, shash_len,
-			 crypto_shash_digestsize(shash_tfm));
+		pr_err("%s: hash len mismatch (len %d digest %d)\n",
+			__func__, shash_len,
+			crypto_shash_digestsize(shash_tfm));
 		ret = -EINVAL;
 		goto out_free_tfm;
 	}
-- 
2.43.0


