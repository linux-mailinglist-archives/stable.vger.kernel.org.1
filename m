Return-Path: <stable+bounces-178661-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 64BD7B47F90
	for <lists+stable@lfdr.de>; Sun,  7 Sep 2025 22:39:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C5A21B204B0
	for <lists+stable@lfdr.de>; Sun,  7 Sep 2025 20:39:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8990321ADAE;
	Sun,  7 Sep 2025 20:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vopfCUvd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45E104315A;
	Sun,  7 Sep 2025 20:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757277552; cv=none; b=FImLbmDaxewVwpy80fFKdK+YwwosaAink6j97PFZVfLFvTjZuyuOksauud4d24ODzjxONE40+ymFqRzfd4oU6TeTqfbfakFERuPBL5L37TQUXCw6FG95RplouW2pX5fsRFZWiHeP+e02K9Wjp8R64k/uqb9pYPjMqgog75C2ehQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757277552; c=relaxed/simple;
	bh=GCuMyo7uoBtYNdsXSM36Af4lUh4ETgGDlpkyCY603Xg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cUzhNcdiqBUxix+oGhk84dCMF6PJrr/gQnO9I10bVfHAFKPgzCLxdQ9A+MW6BraVI5nYt1FUYDn4pBg7Tt/YgSJRcF3hkahNcKwm3QvQhuihaDjAFV0fofqp9DsdbTrEMudJVApN3q69CGBW5vHJjMBWbdhULyBSEmPWlc3Caj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vopfCUvd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC498C4CEF0;
	Sun,  7 Sep 2025 20:39:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1757277552;
	bh=GCuMyo7uoBtYNdsXSM36Af4lUh4ETgGDlpkyCY603Xg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vopfCUvdxsuU6qI/EVvyMV1YBK9GvakkuT4ZRTJ74x2p/gw3tJucZHojlf0iO9uvM
	 J3eFMLkxH+NC6/EYBjAsb3w9nYRjHdfzZLM0jDpF3yEkcBI11DtlhKr2rs26Q7VET9
	 rJeLN/LqnKQNcRgpR132fiEsIZ5wTVYCLvncd6jY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Sungbae Yoo <sungbaey@nvidia.com>,
	Sumit Garg <sumit.garg@oss.qualcomm.com>,
	Jens Wiklander <jens.wiklander@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.16 023/183] tee: optee: ffa: fix a typo of "optee_ffa_api_is_compatible"
Date: Sun,  7 Sep 2025 21:57:30 +0200
Message-ID: <20250907195616.332439451@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250907195615.802693401@linuxfoundation.org>
References: <20250907195615.802693401@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sungbae Yoo <sungbaey@nvidia.com>

[ Upstream commit 75dbd4304afe574fcfc4118a5b78776a9f48fdc4 ]

Fixes optee_ffa_api_is_compatbile() to optee_ffa_api_is_compatible()
because compatbile is a typo of compatible.

Fixes: 4615e5a34b95 ("optee: add FF-A support")
Signed-off-by: Sungbae Yoo <sungbaey@nvidia.com>
Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tee/optee/ffa_abi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tee/optee/ffa_abi.c b/drivers/tee/optee/ffa_abi.c
index f9ef7d94cebd7..a963eed70c1d4 100644
--- a/drivers/tee/optee/ffa_abi.c
+++ b/drivers/tee/optee/ffa_abi.c
@@ -657,7 +657,7 @@ static int optee_ffa_do_call_with_arg(struct tee_context *ctx,
  * with a matching configuration.
  */
 
-static bool optee_ffa_api_is_compatbile(struct ffa_device *ffa_dev,
+static bool optee_ffa_api_is_compatible(struct ffa_device *ffa_dev,
 					const struct ffa_ops *ops)
 {
 	const struct ffa_msg_ops *msg_ops = ops->msg_ops;
@@ -908,7 +908,7 @@ static int optee_ffa_probe(struct ffa_device *ffa_dev)
 	ffa_ops = ffa_dev->ops;
 	notif_ops = ffa_ops->notifier_ops;
 
-	if (!optee_ffa_api_is_compatbile(ffa_dev, ffa_ops))
+	if (!optee_ffa_api_is_compatible(ffa_dev, ffa_ops))
 		return -EINVAL;
 
 	if (!optee_ffa_exchange_caps(ffa_dev, ffa_ops, &sec_caps,
-- 
2.50.1




