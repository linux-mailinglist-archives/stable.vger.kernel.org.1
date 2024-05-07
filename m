Return-Path: <stable+bounces-43371-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D43F98BF22B
	for <lists+stable@lfdr.de>; Wed,  8 May 2024 01:43:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 891101F2141A
	for <lists+stable@lfdr.de>; Tue,  7 May 2024 23:43:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D652175552;
	Tue,  7 May 2024 23:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lkpi17zb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF655172BDB;
	Tue,  7 May 2024 23:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715123525; cv=none; b=Qy/EgEb7PDl9fVF43xD9R+yvd3K0yoyel0TuQGhJDsFiq/ua1ylryHVA1Ikmf6D4JNt6A3Yu9YzYK1yN17AzhalCPN1NBc3B6SacR5KPWDynRbkKC/WvFxGxtCLIeSdP8D7y/KHCNVnmh3dHaxxPDDlYkAbrcJqY8s+68odf8aE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715123525; c=relaxed/simple;
	bh=xKGJxFne+UyiXVYKvVnAuWWupcJYyWxk89f2UMkT1LM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=deK2Fb7vhUB0tYqhS7y3KOHu1RCBIwyVPf3zN4hJ65GG7xKgEnwUSYM2WEoNQKlttPgKCLPrHwsGVwO015zG222DLP7logmkFsTjwEJ8MGsWVUK+s0APHcIAGhbEG6tYa4/3zf5gvd/G5BZhgYJAQ4EJH38CbsM6lWJc1giyidA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lkpi17zb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9ED9EC4AF17;
	Tue,  7 May 2024 23:12:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715123525;
	bh=xKGJxFne+UyiXVYKvVnAuWWupcJYyWxk89f2UMkT1LM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Lkpi17zbfKyeJ2xHZsVSOG49pFs+gQQqSlbCv85OrvjXrQ9uY1Q0StKAfXOL6pyvj
	 70UqcxMRamH9OTvFhxCfj6Hu0drHeRvz6Lt4Qx4XZozE9wtjT7GwWlilIDb2OCIrUl
	 fYvH9mSX8YoP+vIS1XWk3NGFKN3jF3PlQTJHdm4het1DUcQCx0tKP3eBEmtLlHCXI2
	 inmjDlTPPoKQZZNOmapR1xFA0nxLH4VAnJxAsZstlC9BUAy83po85Ys6dU87k1Ftzm
	 JBWB9p3diejr+aeOLcp60401qcikJtDULZQOSxcUWJm9IFKMh4RQH0hm9hlWx19nRX
	 TZGlZcL862LuQ==
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
Subject: [PATCH AUTOSEL 6.6 39/43] nvmet-auth: replace pr_debug() with pr_err() to report an error.
Date: Tue,  7 May 2024 19:10:00 -0400
Message-ID: <20240507231033.393285-39-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240507231033.393285-1-sashal@kernel.org>
References: <20240507231033.393285-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.30
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


