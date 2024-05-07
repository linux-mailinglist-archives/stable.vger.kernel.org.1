Return-Path: <stable+bounces-43325-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CFC968BF1BC
	for <lists+stable@lfdr.de>; Wed,  8 May 2024 01:33:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D7F21C21D86
	for <lists+stable@lfdr.de>; Tue,  7 May 2024 23:33:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEE93146A7A;
	Tue,  7 May 2024 23:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S26LMnI4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D7EE146A6E;
	Tue,  7 May 2024 23:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715123394; cv=none; b=EjoGakFk1N7eshY7GCAkDF+srOtcd0lJp5dkiiTEIaPDTLXEDtK6GfPzLPUOhaSwm10TJxGtqxLF61mzBLthWcyP2QfXjjcFzeXXo+GaouYnGJ349iBxKQtlqed2Eq1zBZGX/4vh+9Q5et6YCaNDpeDHCqbKln589H0BBDVwfUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715123394; c=relaxed/simple;
	bh=uiAzBqoKilL7XrDCrfA109bLqKJzCbNHim/HtuZpb4s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Su5O1QVhbPNjnQJGldHpbmT6Q2tHicMPcZ+0pZDquT7F8gaCF6zPlOplHGMoJO8T8Khvm2hqqY2WNxxM9c1hAcKgYtHvFAlaz/mYBH0uCxGvJYZI7+42GG3dzSguGXDKBD6XYBi8zICZNMlyENshIwV/y+fv2s3t5sjvYJntuNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S26LMnI4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B633C3277B;
	Tue,  7 May 2024 23:09:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715123394;
	bh=uiAzBqoKilL7XrDCrfA109bLqKJzCbNHim/HtuZpb4s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=S26LMnI4pf/I/FLhHgdjYKRTWjWLSa417nzETJ+s5Q4VPqw3W1BEnfeCKfMwD1NDT
	 hwr2a4P2V34QZXfI8envXosMfPbdnuVcU3TjBftNclakw4n9Pb/+szNUG1gen6DoPw
	 7ZOKCo7XjCVHo/kfXvTj/4dWXSjlh4q8N+m762jN3ewhkqPxi+IcZy+ciT+8FNIWmT
	 ROZ0vbqG4rhrSyKNsGNDB8m9AItNU1md2ijx8tQr5baJapGZFFoeYlRJJ0y2GtaPFX
	 scOEAHk8nxWdz85zVuMTigznVEUPdVJXY7KxdEWeMMv58RleeHCs/0aL9pLH67I9MT
	 o/iTzfAFCnDyg==
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
Subject: [PATCH AUTOSEL 6.8 46/52] nvmet-auth: return the error code to the nvmet_auth_host_hash() callers
Date: Tue,  7 May 2024 19:07:12 -0400
Message-ID: <20240507230800.392128-46-sashal@kernel.org>
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
index 3ddbc3880cac8..9e51c064b0728 100644
--- a/drivers/nvme/target/auth.c
+++ b/drivers/nvme/target/auth.c
@@ -370,7 +370,7 @@ int nvmet_auth_host_hash(struct nvmet_req *req, u8 *response,
 	nvme_auth_free_key(transformed_key);
 out_free_tfm:
 	crypto_free_shash(shash_tfm);
-	return 0;
+	return ret;
 }
 
 int nvmet_auth_ctrl_hash(struct nvmet_req *req, u8 *response,
-- 
2.43.0


