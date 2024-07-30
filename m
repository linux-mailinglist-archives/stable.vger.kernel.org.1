Return-Path: <stable+bounces-63325-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 66810941863
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 18:21:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1441F287502
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 16:21:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADF5A187FEC;
	Tue, 30 Jul 2024 16:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CsLUMtdC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CD811A617E;
	Tue, 30 Jul 2024 16:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722356465; cv=none; b=YuV0g5Qdj02BHDABjgcI9cZQ20Rhb0Pkb6MYo136Kq622+/cumvxW9gstzjeKbu3Lbpv0W04lIWpez5MpwYHGIDE4g1z19neBPNGA3piL+oUm7Vloy8HXWKtOgINhZDGSLHEqiHFLhxaPGAL0eVPsiACYQF96kaOlsP8ujeyanw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722356465; c=relaxed/simple;
	bh=iupP99qE3w6T4VRl7oxiK5i5nb0kizAFML0BEjnfxxg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PQSCLVVfhV45ObuSqbzZtkVE8SCZU5uOSaTBZSMCRAMvph5hWkfpsI/GSA/QESwkmgyD8LsHWxWEM+4lDx2+6IGYZzxZExKNI5LzGxp5WcyIWAty5Wag7pum6muzkAn1yFMlUcY0+76hXFF/iO45TCzDSpADuh/od0CkYMN2wFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CsLUMtdC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE17EC32782;
	Tue, 30 Jul 2024 16:21:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722356465;
	bh=iupP99qE3w6T4VRl7oxiK5i5nb0kizAFML0BEjnfxxg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CsLUMtdCe/dCKVLNuBWmQtd3ClCY/Qv9KZi3/2u4H7Anr5arK0ei3r9uMweJMRXnh
	 LGWKxq8PLNxXNj8pIrVQ061aeMj14MXz2ZyGExwSq2uIUo+Nn1mWbcYVHm/xOHAU1M
	 AnauMmK6jVr6DzYQl+bqbn62ZbP0jyyXLFxvxj9k=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Leon Romanovsky <leon@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 194/440] RDMA/cache: Release GID table even if leak is detected
Date: Tue, 30 Jul 2024 17:47:07 +0200
Message-ID: <20240730151623.446618224@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240730151615.753688326@linuxfoundation.org>
References: <20240730151615.753688326@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Leon Romanovsky <leonro@nvidia.com>

[ Upstream commit a92fbeac7e94a420b55570c10fe1b90e64da4025 ]

When the table is released, we nullify pointer to GID table, it means
that in case GID entry leak is detected, we will leak table too.

Delete code that prevents table destruction.

Fixes: b150c3862d21 ("IB/core: Introduce GID entry reference counts")
Link: https://lore.kernel.org/r/a62560af06ba82c88ef9194982bfa63d14768ff9.1716900410.git.leon@kernel.org
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/core/cache.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/infiniband/core/cache.c b/drivers/infiniband/core/cache.c
index 4084d05a45102..c319664ca74b3 100644
--- a/drivers/infiniband/core/cache.c
+++ b/drivers/infiniband/core/cache.c
@@ -794,7 +794,6 @@ static struct ib_gid_table *alloc_gid_table(int sz)
 static void release_gid_table(struct ib_device *device,
 			      struct ib_gid_table *table)
 {
-	bool leak = false;
 	int i;
 
 	if (!table)
@@ -803,15 +802,12 @@ static void release_gid_table(struct ib_device *device,
 	for (i = 0; i < table->sz; i++) {
 		if (is_gid_entry_free(table->data_vec[i]))
 			continue;
-		if (kref_read(&table->data_vec[i]->kref) > 1) {
-			dev_err(&device->dev,
-				"GID entry ref leak for index %d ref=%u\n", i,
-				kref_read(&table->data_vec[i]->kref));
-			leak = true;
-		}
+
+		WARN_ONCE(true,
+			  "GID entry ref leak for dev %s index %d ref=%u\n",
+			  dev_name(&device->dev), i,
+			  kref_read(&table->data_vec[i]->kref));
 	}
-	if (leak)
-		return;
 
 	mutex_destroy(&table->lock);
 	kfree(table->data_vec);
-- 
2.43.0




