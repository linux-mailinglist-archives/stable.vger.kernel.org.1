Return-Path: <stable+bounces-48869-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 74D308FEAE1
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 16:21:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F40BD284DC1
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 14:21:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BECB1A1884;
	Thu,  6 Jun 2024 14:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="em/+I5HY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AA71199237;
	Thu,  6 Jun 2024 14:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717683187; cv=none; b=Fwh0XFI11uxcAKQmW2jf+SZaG8LafcQ6Hl5q8+2cnuDl7wBaKKsgO7kODgSBXLJjcUiTkjoXt4LIN6RCG6KheNzWcOs+CTkZIrlzOiQLhyw7/tkxJ+L1v3VR7us4d3plSoME0R2YGwohsnVVK+BkEjx9YIzZX21ZxriOgDVW9CM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717683187; c=relaxed/simple;
	bh=0JxE85b3CszNpYXXpRFZABDWrTIX6bQFki914venLmQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cRgRvWAF+xTmvslPRiONC0WLZuuz6jtrPiarTEy4z1nBW7apsafIyNf1fkt8gKtXAFbAOLpisSLOTfGe6bAgt+WanJKKgzuoqWZ5v7sEYsSCDY3ObsntfKlZr2b0gj1Zf5LRsEQ4it/TtQBAHai4fAZ4Pu3J1f0uPs/EaH+bu6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=em/+I5HY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC154C2BD10;
	Thu,  6 Jun 2024 14:13:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1717683187;
	bh=0JxE85b3CszNpYXXpRFZABDWrTIX6bQFki914venLmQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=em/+I5HYMLCBDzJyzSAN+MPmrqbPDopytArxsgL3UHQKiz6xBMeanCNvrGrWBUeCY
	 cPzmtyEoZl6PtLSHm5p+d1Ko7MzlypQSoz4gVzQ7T016C8sPQ2hzS09VDZxGAWNI9b
	 gSHT6keUHsQn9BMNPx+KCaQbUdb1PGLE0x+wL9A4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Maurizio Lombardi <mlombard@redhat.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 061/473] nvmet-auth: replace pr_debug() with pr_err() to report an error.
Date: Thu,  6 Jun 2024 15:59:50 +0200
Message-ID: <20240606131701.909599374@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240606131659.786180261@linuxfoundation.org>
References: <20240606131659.786180261@linuxfoundation.org>
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




