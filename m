Return-Path: <stable+bounces-71193-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B262C961258
	for <lists+stable@lfdr.de>; Tue, 27 Aug 2024 17:30:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 111ECB23174
	for <lists+stable@lfdr.de>; Tue, 27 Aug 2024 15:29:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 405F91CDFA7;
	Tue, 27 Aug 2024 15:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hJoVVqIl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2FCB1C57AB;
	Tue, 27 Aug 2024 15:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724772406; cv=none; b=uVfroVk+jlzwV/NY8/kCp/fIZAojHXlIeYt+jeVgE9ciB2k084nxLphOzt4AgT2NqVFfXrnCHv1rFTNCFDWUIaWHVxqhcuDHb+ChwCAp6e64vBjq0wfc91KxYP1zbN1zHAXP0Pvz2rBC1RHcCJMcm+t0pG+ECRBAqhDW9iLdqJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724772406; c=relaxed/simple;
	bh=bPjE1eatdQdG+KGua4ZrylIj4wOqlxbB8NWlbbNuYJc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o/ckJFjUzIgEXfWFf7Tp/q+eQ3rup9OFHqdxpR0yLwInaBb7Pb3UbMOCoN+c2fCRtKjLNlS9jtkp/PfCDiCVHODtQYVKDmHsRrdXouDcJ1FSMznQM4AKa8BXpffOz/P2UK7fqrH+s62pkDhlrUqUrwStPUQGDCDCrJ/q6bizrPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hJoVVqIl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44312C4DE18;
	Tue, 27 Aug 2024 15:26:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1724772405;
	bh=bPjE1eatdQdG+KGua4ZrylIj4wOqlxbB8NWlbbNuYJc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hJoVVqIl/h7Ff9rjPL52yO0WR7PeV6k5uzs34cWa3MqwJibSmbrRf8YvhCKR2VHmy
	 WVVYFlocv6dl0jKCgmD1kn+LQSXDZ2nOg0/7Qi9/tKwVlP0Ek+7/H8wImh5tFCP5Zr
	 /BzLo2xgQn5PjKui55Rg6sNudHh51DeRerfQJ7IQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Li Nan <linan122@huawei.com>,
	Yu Kuai <yukuai3@huawei.com>,
	Song Liu <song@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 174/321] md: clean up invalid BUG_ON in md_ioctl
Date: Tue, 27 Aug 2024 16:38:02 +0200
Message-ID: <20240827143844.854371916@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240827143838.192435816@linuxfoundation.org>
References: <20240827143838.192435816@linuxfoundation.org>
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

From: Li Nan <linan122@huawei.com>

[ Upstream commit 9dd8702e7cd28ebf076ff838933f29cf671165ec ]

'disk->private_data' is set to mddev in md_alloc() and never set to NULL,
and users need to open mddev before submitting ioctl. So mddev must not
have been freed during ioctl, and there is no need to check mddev here.
Clean up it.

Signed-off-by: Li Nan <linan122@huawei.com>
Reviewed-by: Yu Kuai <yukuai3@huawei.com>
Signed-off-by: Song Liu <song@kernel.org>
Link: https://lore.kernel.org/r/20240226031444.3606764-4-linan666@huaweicloud.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/md/md.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index b87c6ef0da8ab..297c86f5c70b5 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -7614,11 +7614,6 @@ static int md_ioctl(struct block_device *bdev, fmode_t mode,
 
 	mddev = bdev->bd_disk->private_data;
 
-	if (!mddev) {
-		BUG();
-		goto out;
-	}
-
 	/* Some actions do not requires the mutex */
 	switch (cmd) {
 	case GET_ARRAY_INFO:
-- 
2.43.0




