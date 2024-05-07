Return-Path: <stable+bounces-43396-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 163B28BF268
	for <lists+stable@lfdr.de>; Wed,  8 May 2024 01:49:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3137283559
	for <lists+stable@lfdr.de>; Tue,  7 May 2024 23:49:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE16F1C9EB9;
	Tue,  7 May 2024 23:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d5poKbz+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE0F91C9EAC;
	Tue,  7 May 2024 23:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715123598; cv=none; b=Cw3jr83ZKp95rsU4PMF6uhnN7+eVLmgvFWn6XETU4J4Y0vK7thelTdgME7zUmhj7TTePwt322Ag9DUOQh4zfN5qZVGgsgXAHOm8WxDEkIG9Mzp7zFzy2Tb8IzOQyhQMrxu2aSKVjfakWCyTXM1K9xqmoBSWLVWTS79jf+phPjYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715123598; c=relaxed/simple;
	bh=y1rhdDOxe21+WMY9S2759/oEbYoQ9ExkWEChZFtqQuo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UYeoV2JY8LcaLyjCTWdVRqxb06++3hjrOkWTpTp/9RnS37b+68FaVFLUSeIFjFJpp8w5Jw9W1ohpmhTVR01pVyMj8beyQWJ3nSdH95Bsapinjs2y8oBH5aNX49W2XQxsZgeKvWv7tWbYYz7MQA36YnPG+MEEeYS3UQObZAL1kFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d5poKbz+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5945CC3277B;
	Tue,  7 May 2024 23:13:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715123598;
	bh=y1rhdDOxe21+WMY9S2759/oEbYoQ9ExkWEChZFtqQuo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=d5poKbz+XIfeWAuj9CL0E5nptCBZgdxzevG6xlVtCP+5vLTjzQy0iigkbh38waqLi
	 PWxH21PCMlXxH+hU/bMi5coWgsUtUs09wbQgJyXoNItnGRYVcwPWyFm86qU0v26HfI
	 g++P7qTaJpbBWYJiZXyxLQaMkYM9P0Vg7yJCJ+RwwxQYADeVncX4uo5XlS/eLw/t9n
	 rOcYDISGsXZl2lRRpy5LBbfiCrUaGzFhtX4Vdaq0mzjtECz4YXoloOr7Bc64BPPO8r
	 WSybXCKIW5dTfDplAljB9caSdmWKjhDdaEceUnVj9tENHvgHGTDBvfwMo7wGyPdzyt
	 devtIrrOthd6A==
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
Subject: [PATCH AUTOSEL 6.1 21/25] nvmet-auth: return the error code to the nvmet_auth_host_hash() callers
Date: Tue,  7 May 2024 19:12:08 -0400
Message-ID: <20240507231231.394219-21-sashal@kernel.org>
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

[ Upstream commit 46b8f9f74f6d500871985e22eb19560b21f3bc81 ]

If the nvmet_auth_host_hash() function fails, the error code should
be returned to its callers.

Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/target/auth.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/target/auth.c b/drivers/nvme/target/auth.c
index 4dcddcf95279b..1f7d492c4dc26 100644
--- a/drivers/nvme/target/auth.c
+++ b/drivers/nvme/target/auth.c
@@ -368,7 +368,7 @@ int nvmet_auth_host_hash(struct nvmet_req *req, u8 *response,
 	kfree_sensitive(host_response);
 out_free_tfm:
 	crypto_free_shash(shash_tfm);
-	return 0;
+	return ret;
 }
 
 int nvmet_auth_ctrl_hash(struct nvmet_req *req, u8 *response,
-- 
2.43.0


