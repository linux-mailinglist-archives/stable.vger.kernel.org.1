Return-Path: <stable+bounces-43326-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D68B8BF1BF
	for <lists+stable@lfdr.de>; Wed,  8 May 2024 01:33:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FDBF1C21FDD
	for <lists+stable@lfdr.de>; Tue,  7 May 2024 23:33:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 295E5146D50;
	Tue,  7 May 2024 23:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lrvla/Wz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAA80136672;
	Tue,  7 May 2024 23:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715123395; cv=none; b=UI0857FcwIO8eQPMni1Rc/TGswd2JeeAxeN2M6jGkQ/NNrhYViBLBjMgjNfOCrzovRSTBMIYVFeJD2Ve0D3sDkpFHTl2HLFDch3jW/6VS9xWNg2a5i5msltHL232uvsw+MTltE7lTQiJDoLSfMcHh8sbTbdvg1srpPSrT5qOw88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715123395; c=relaxed/simple;
	bh=PY5p4BR22hkl5nUDZo2IeOWjxL4AERGHJeNQcYeqpjc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S4tVjV9l1nq5ZKre5xcxN0wWiphB3JoUBV74pZom/2jfU4OkZ0RghELHXCSlbTpjNerBgB4hf54swuNHSyAjqDYF+TkEOBJ/+IC7xccpI29dQp6Yd1qLnHY7Fyvn5T0SaGCXdmkfXS/91UUTpWKcXJ2rK9627Sl8h+SauWb8H6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lrvla/Wz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C46B7C3277B;
	Tue,  7 May 2024 23:09:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715123395;
	bh=PY5p4BR22hkl5nUDZo2IeOWjxL4AERGHJeNQcYeqpjc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lrvla/Wz6K2mCFIwrABTRGZjj02l9OoERYyMeiyq/bwy9KyPqnqNg5vmD7/SqsWNY
	 V+8JElASEIkXTEjvwtGCLZ9RpbmVRbrhU6RK7TTHMzG+K8MmYpgFIrEhwrNK9IU3C7
	 4zGiCTT3V/QvqZge6LVzt5Iv6bIt4HncQTthemMiqNOWGR8x8vaDnun+J3A2XKE9aE
	 McZlTRVxOz4yCXX5YXbGRmODqSFpzELau/78YHcfkXI/wJvCJBwvSl8t2t6tfIt0fn
	 EF8TdMnxYsuocYqqtiAwyBDP/YQbf32ASE0U54HhTAX3TwRyLpnMrQ/o2Fle6X7TPn
	 BaS6D4yRVHQag==
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
Subject: [PATCH AUTOSEL 6.8 47/52] nvmet-auth: replace pr_debug() with pr_err() to report an error.
Date: Tue,  7 May 2024 19:07:13 -0400
Message-ID: <20240507230800.392128-47-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240507230800.392128-1-sashal@kernel.org>
References: <20240507230800.392128-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.8.9
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
index 9e51c064b0728..fb518b00f71f6 100644
--- a/drivers/nvme/target/auth.c
+++ b/drivers/nvme/target/auth.c
@@ -285,9 +285,9 @@ int nvmet_auth_host_hash(struct nvmet_req *req, u8 *response,
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


