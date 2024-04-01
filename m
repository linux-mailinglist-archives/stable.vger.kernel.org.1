Return-Path: <stable+bounces-33972-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B95F5893D24
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 17:50:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B8712830E4
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 15:50:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7224646551;
	Mon,  1 Apr 2024 15:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yLDv3lT9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CBBB481C2;
	Mon,  1 Apr 2024 15:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711986596; cv=none; b=rU6CHU43FFmm8GYvA1BC8wYgvY6dvqRetzTnQeS/MHYGs0/dUzrc9mpckGGx5MJr6gEjauODlgw0jLc62jTI9+4GfuryuyKAOQCJ0qC687u1bfEi2d+T9Bpz8nG+TN3xIH/L4kjDevB/96P4FpxeNFawvNr8CLOwzOgpDRAlVQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711986596; c=relaxed/simple;
	bh=/m/2xlzz1/6w3VEwgXG2oBL25mT1Meu+DFnj0SQHrew=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XDlZK5mTQEELDXaTpJSBLLU1ir/MtdF3+XrfqJRDiUQ2LRLjEkb46vCPY0oZQ+BqkZUbKOqrHrii06Whwjlal6Q+lcoECUe/AzT3+8/w0+CrLlWX0hbbyPRyLVQYdahrWbjvcQbCdsbmvYLNnSujyVvMtPLCdHZD76TuxwAK2t8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yLDv3lT9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 944E4C43399;
	Mon,  1 Apr 2024 15:49:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711986596;
	bh=/m/2xlzz1/6w3VEwgXG2oBL25mT1Meu+DFnj0SQHrew=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=yLDv3lT9almx2umNhvV8ZXGBm25FaODS32zdbxowPIp1AND9Y3RFfs+SK/exHbOvQ
	 uyxNNG7xI0MlvuYFn/u9PdCQKVAdoj/ggXLW7MAeQSN5NDNieghBnHDaoHjO78z+J7
	 i+h0tSsZFV17wqgfFdi44tqHLdwNkEGxhUZXWV20=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Li Lingfeng <lilingfeng3@huawei.com>,
	Song Liu <song@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 024/399] md: use RCU lock to protect traversal in md_spares_need_change()
Date: Mon,  1 Apr 2024 17:39:50 +0200
Message-ID: <20240401152549.885069737@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240401152549.131030308@linuxfoundation.org>
References: <20240401152549.131030308@linuxfoundation.org>
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

From: Li Lingfeng <lilingfeng3@huawei.com>

[ Upstream commit 570b9147deb6b07b955b55e06c714ca12a5f3e16 ]

Since md_start_sync() will be called without the protect of mddev_lock,
and it can run concurrently with array reconfiguration, traversal of rdev
in it should be protected by RCU lock.
Commit bc08041b32ab ("md: suspend array in md_start_sync() if array need
reconfiguration") added md_spares_need_change() to md_start_sync(),
casusing use of rdev without any protection.
Fix this by adding RCU lock in md_spares_need_change().

Fixes: bc08041b32ab ("md: suspend array in md_start_sync() if array need reconfiguration")
Cc: stable@vger.kernel.org # 6.7+
Signed-off-by: Li Lingfeng <lilingfeng3@huawei.com>
Signed-off-by: Song Liu <song@kernel.org>
Link: https://lore.kernel.org/r/20240104133629.1277517-1-lilingfeng@huaweicloud.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/md/md.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index d344e6fa3b26f..fbe528ed236f6 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -9277,9 +9277,14 @@ static bool md_spares_need_change(struct mddev *mddev)
 {
 	struct md_rdev *rdev;
 
-	rdev_for_each(rdev, mddev)
-		if (rdev_removeable(rdev) || rdev_addable(rdev))
+	rcu_read_lock();
+	rdev_for_each_rcu(rdev, mddev) {
+		if (rdev_removeable(rdev) || rdev_addable(rdev)) {
+			rcu_read_unlock();
 			return true;
+		}
+	}
+	rcu_read_unlock();
 	return false;
 }
 
-- 
2.43.0




