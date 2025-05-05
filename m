Return-Path: <stable+bounces-141497-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 54079AAB722
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 08:04:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8ADB4E67B1
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 06:01:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAEE53402FC;
	Tue,  6 May 2025 00:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lfAMemGA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD222281501;
	Mon,  5 May 2025 23:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746486483; cv=none; b=nRLhFEaLQtmDcv8M8oqlAVF1h9WFxjwn3df/hrEomNNM9iXcEAu91uPj2KPyrsn2YGRAc2JYgUPWj2jhlB2F2VC0uaElkqDT4j8SDi7MT6JI9t1PvHzkIzrPSsfQPsjYZlVu9uLQsCo8JXCNcrsqpepKUbP04To4Lf/9vDIMQd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746486483; c=relaxed/simple;
	bh=6YRcUTK56kXBcBxkiILEyGZQmGqLy6xAnl8/69Hwbgg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KWDw37CxsLrsMrR+y7pa3DWb3B9cXWpdLveBDU5GhAW+ENjSXFCXLP/f7n05j6yUqafjZcbCpHWaVfCB/BAkLmaePImsLxTUZ8jcR6zd4t61IaMAXk+Ff97U2TVGgeUHRwDxoJshg/mCscNl3k4IhNbNhnCN6PHj5OkDIVVXHBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lfAMemGA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5033CC4CEED;
	Mon,  5 May 2025 23:08:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746486482;
	bh=6YRcUTK56kXBcBxkiILEyGZQmGqLy6xAnl8/69Hwbgg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lfAMemGApZ2I4Zv1VfplsQMwuEFVUqJdyR40DTXbw9hlutDGRqxBGyHYF7tnFbNgJ
	 faGD1Iv5npPqiQ14fzJBWg2wDfyvZPQ1PacXnXy9dwhFXzl7TgJzdnu20FvVl9hJ0S
	 mWQIPReCn5zdz/ROmxcHxFvDWosVJCD7bmyKQxugRGz5yRe/3tG1EIFbsWTAT1INhh
	 bMLTYUUaOGjBXXABPVYNx1xevlCGNCrSTnKq3noMv4dPTH4wSccpOZtMmq9WQcj1Cz
	 L9Mwbj/BUniDTLRQKs5A5Vwz+YQksEZgvCfU2+u6x92s7QuM+27F82G4qhE0AdyUbu
	 MYOB/FmYpuNwg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>,
	andreas.noever@gmail.com,
	michael.jamet@intel.com,
	westeri@kernel.org,
	YehezkelShB@gmail.com,
	linux-usb@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 053/212] thunderbolt: Do not add non-active NVM if NVM upgrade is disabled for retimer
Date: Mon,  5 May 2025 19:03:45 -0400
Message-Id: <20250505230624.2692522-53-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505230624.2692522-1-sashal@kernel.org>
References: <20250505230624.2692522-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.136
Content-Transfer-Encoding: 8bit

From: Mika Westerberg <mika.westerberg@linux.intel.com>

[ Upstream commit ad79c278e478ca8c1a3bf8e7a0afba8f862a48a1 ]

This is only used to write a new NVM in order to upgrade the retimer
firmware. It does not make sense to expose it if upgrade is disabled.
This also makes it consistent with the router NVM upgrade.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/thunderbolt/retimer.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/thunderbolt/retimer.c b/drivers/thunderbolt/retimer.c
index 5bd5c22a5085d..d2038337ea03b 100644
--- a/drivers/thunderbolt/retimer.c
+++ b/drivers/thunderbolt/retimer.c
@@ -89,9 +89,11 @@ static int tb_retimer_nvm_add(struct tb_retimer *rt)
 	if (ret)
 		goto err_nvm;
 
-	ret = tb_nvm_add_non_active(nvm, nvm_write);
-	if (ret)
-		goto err_nvm;
+	if (!rt->no_nvm_upgrade) {
+		ret = tb_nvm_add_non_active(nvm, nvm_write);
+		if (ret)
+			goto err_nvm;
+	}
 
 	rt->nvm = nvm;
 	return 0;
-- 
2.39.5


