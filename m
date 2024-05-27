Return-Path: <stable+bounces-47102-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C5BFF8D0C98
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 21:21:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79A481F21BDC
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 19:21:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C674615FCFE;
	Mon, 27 May 2024 19:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wO77G6Nq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84A08168C4;
	Mon, 27 May 2024 19:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716837676; cv=none; b=jNKqOafDAB/GL/gMw2OKZuITiUCWVY07hLGEzlUqoIhQ5mCT3OOPZI+DYDcWRJy27oPPkaRdVPqrw4bGu6XkNbD38CfWB0z8C9KM33zdc6VU/dEv9nGMCYPAgWjf+JaBhloAcIR3T5TvHL+/0CrntgyLFzmTewOSKWWk9uzvOkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716837676; c=relaxed/simple;
	bh=p1pNQIDU/9/jmP2UpD23qKU8mnlatV84MV7x96i8/sA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=apvRR5iUv2fkOymAyLjXA1TW5/GfTQbQ95OiiiuPY2texottxRgYkc18gmm03yP9UfqNSMHgUHjkEpDrtErzeeWAEzHj0TnZqBybVK5g4OhH1BVOEDtVQr9XCRIjceIpGvXVecDGOTiE8WVswWu1c2rY5eSHFNJzuIoRsNWheWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wO77G6Nq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17017C2BBFC;
	Mon, 27 May 2024 19:21:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1716837676;
	bh=p1pNQIDU/9/jmP2UpD23qKU8mnlatV84MV7x96i8/sA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=wO77G6NqJS8hduw0PxVqbyabGr2KfXl4PXBWiP0z2uZwI+YlwlUv6d8PMbyHqJC4d
	 /bU5122yLK3180gajKzX2rjh6XrYZwFaTgbAoMoG879LfqK1S5JRYTpElMPz607urs
	 2/IHJEk3oekGCYjLyXcS9tap1S/22LQIn7+6kNAI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Maurizio Lombardi <mlombard@redhat.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 102/493] nvmet-auth: return the error code to the nvmet_auth_host_hash() callers
Date: Mon, 27 May 2024 20:51:44 +0200
Message-ID: <20240527185633.849296575@linuxfoundation.org>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240527185626.546110716@linuxfoundation.org>
References: <20240527185626.546110716@linuxfoundation.org>
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

6.8-stable review patch.  If anyone has any objections, please let me know.

------------------

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




