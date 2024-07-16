Return-Path: <stable+bounces-59422-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B1DD93286B
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 16:26:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2068A2858CE
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 14:26:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC08719D8AB;
	Tue, 16 Jul 2024 14:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fNWyAFgV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A3B919D8A9;
	Tue, 16 Jul 2024 14:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721139936; cv=none; b=qdFXpjHlsGiaUDhQEEbzmA4c+rVM6NOI+zVSduKorea/9ONDBVE5ajRl7G7je9qRXaufOV1uSBfF/JNJC86MKq+Ci5PUOhVOdSmvMi6f/pP0jsNOu+K3i4PCH6sReOla1rQ/ywMsqmBjMwQ9I99c/Dh+mVh2B+31qx9QL7J8+lM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721139936; c=relaxed/simple;
	bh=GetdLgWuS9LJx19DF+x6VeDsh1GD/sT8WCGs+6TCgjw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nU8aaEjVMCngDHG4OA1vRjLGAIrQ05NdsIBUM5mBBLslYZ9yjMBY6Ig2h8fYqiUuCzzXDfxLUv2ZBVRwqy1LRO92zOdXmz9iH9Bx9189oUSccexUo5Gn/741dwc/KERMmjNeO5FBwM++mXapWqLAPRc1ThvP8BaHB7wm3hZ/k9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fNWyAFgV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C112AC4AF0D;
	Tue, 16 Jul 2024 14:25:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721139936;
	bh=GetdLgWuS9LJx19DF+x6VeDsh1GD/sT8WCGs+6TCgjw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fNWyAFgVf3ulJkrNVxaUF1EM6HBc+FRlCO1BEPGpPamvdUvUkdwpekG5s9WiX18Kd
	 /8PJ/iaiW76jA4xRovga2xFGyACsZTaYxN7xAwuaUxPEdhm8kZFbsMfe4w7+fSCDII
	 lCQUiaOnkd/VmMr8nZrJwdOLw9KlEPBaXN+dCz+IiLSk3V/j71cKeF/Bgi4WzaEGB/
	 YwuwvtgGbVABGL9bwkcx+nXl8jV5a0QnM0L98Zrg/iUxltX4mM/ySi38TubEIaejEw
	 FWJdCTtVK1w+Sg0p0TSXAs2aNYqeuzhrvm7cqVaUqHXL0bHi00mKfJZp6hm3rk6/JE
	 7ykNeNRI1tWpA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Mark-PK Tsai <mark-pk.tsai@mediatek.com>,
	"ming-jen . chang" <ming-jen.chang@mediatek.com>,
	Jens Wiklander <jens.wiklander@linaro.org>,
	Sasha Levin <sashal@kernel.org>,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	op-tee@lists.trustedfirmware.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH AUTOSEL 6.9 06/22] tee: optee: ffa: Fix missing-field-initializers warning
Date: Tue, 16 Jul 2024 10:24:13 -0400
Message-ID: <20240716142519.2712487-6-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240716142519.2712487-1-sashal@kernel.org>
References: <20240716142519.2712487-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.9.9
Content-Transfer-Encoding: 8bit

From: Mark-PK Tsai <mark-pk.tsai@mediatek.com>

[ Upstream commit e0556255a53d6d3d406a28362dffd972018a997c ]

The 'missing-field-initializers' warning was reported
when building with W=2.
This patch use designated initializers for
'struct ffa_send_direct_data' to suppress the warning
and clarify the initialization intent.

Signed-off-by: ming-jen.chang <ming-jen.chang@mediatek.com>
Signed-off-by: Mark-PK Tsai <mark-pk.tsai@mediatek.com>
Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tee/optee/ffa_abi.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/tee/optee/ffa_abi.c b/drivers/tee/optee/ffa_abi.c
index ecb5eb079408e..c5a3e25c55dab 100644
--- a/drivers/tee/optee/ffa_abi.c
+++ b/drivers/tee/optee/ffa_abi.c
@@ -660,7 +660,9 @@ static bool optee_ffa_api_is_compatbile(struct ffa_device *ffa_dev,
 					const struct ffa_ops *ops)
 {
 	const struct ffa_msg_ops *msg_ops = ops->msg_ops;
-	struct ffa_send_direct_data data = { OPTEE_FFA_GET_API_VERSION };
+	struct ffa_send_direct_data data = {
+		.data0 = OPTEE_FFA_GET_API_VERSION,
+	};
 	int rc;
 
 	msg_ops->mode_32bit_set(ffa_dev);
@@ -677,7 +679,9 @@ static bool optee_ffa_api_is_compatbile(struct ffa_device *ffa_dev,
 		return false;
 	}
 
-	data = (struct ffa_send_direct_data){ OPTEE_FFA_GET_OS_VERSION };
+	data = (struct ffa_send_direct_data){
+		.data0 = OPTEE_FFA_GET_OS_VERSION,
+	};
 	rc = msg_ops->sync_send_receive(ffa_dev, &data);
 	if (rc) {
 		pr_err("Unexpected error %d\n", rc);
@@ -698,7 +702,9 @@ static bool optee_ffa_exchange_caps(struct ffa_device *ffa_dev,
 				    unsigned int *rpc_param_count,
 				    unsigned int *max_notif_value)
 {
-	struct ffa_send_direct_data data = { OPTEE_FFA_EXCHANGE_CAPABILITIES };
+	struct ffa_send_direct_data data = {
+		.data0 = OPTEE_FFA_EXCHANGE_CAPABILITIES,
+	};
 	int rc;
 
 	rc = ops->msg_ops->sync_send_receive(ffa_dev, &data);
-- 
2.43.0


