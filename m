Return-Path: <stable+bounces-54947-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AEA3C913B77
	for <lists+stable@lfdr.de>; Sun, 23 Jun 2024 15:59:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 649731F233CF
	for <lists+stable@lfdr.de>; Sun, 23 Jun 2024 13:59:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2318219D8AB;
	Sun, 23 Jun 2024 13:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="esrB4W0F"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5AF519D8A5;
	Sun, 23 Jun 2024 13:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719150347; cv=none; b=UfUxa00lz42gK+bIVi5VTnkhYvwt/TNem4Z5mJmy79TBkiJWVvCXX6hUbMeVTunZpxvmdyZe67xebeD4QYhJ+95Z4Acd/JahTMwyz0sJ9kYG78LfjKSLic3L7KFUJnqD4y/7p7uh66hn9t0NjDWOe4uN4gOn+dDN9PRchoOe2XE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719150347; c=relaxed/simple;
	bh=ymXZA8LSRBFeCTSXK9QR9TX2OnFX4Blatoipvsm2phk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HSZ7I2+1PwFjbwB7HEJX2OLzfF1pJT5QodpMxvI2YVxXuvC9aS/rlzbIzzF5EUfKHVOuR7jWDdTBrE3oU7fYO1litSV7ynCNd5jYDS5UiU0XDp8HFiu7PyNmRdZ2JBdGHfyqZaov6AA5nwACOsr/phzxR3KYqKe5aiV41xLH0lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=esrB4W0F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B12C9C4AF0A;
	Sun, 23 Jun 2024 13:45:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719150347;
	bh=ymXZA8LSRBFeCTSXK9QR9TX2OnFX4Blatoipvsm2phk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=esrB4W0F1HznJce92hSiAtG/hk9OQkSc4uGxIxc6NCWwjd5ZmeUQEMhIhSpURem1N
	 hzW/JBdlPoYVGuP63SD7PQ3vlR2d/MQDw3xjS3AWDt2Y4yW6gm+QbwEdo3dtgtl8P2
	 S6gBeWoDkPYdRI8IYMAtqg8QL+qSa/ejZQM7thTh+DSubTpIK2wuhypjHdx2dzBYlK
	 G8cSEs4WINpiEWY7zwJISCDVoXIm/+UGLOigivSN2UNCtFjWZwvCBMYocwqV7mIK5j
	 psiZR3g/Ioj95pwV1M+KXNFvO4r4jCtmStMACC9dzE1GnjcP2d5oHsHJNLewtQEwgV
	 CxuIv0xqrrZ1A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Alexander Usyskin <alexander.usyskin@intel.com>,
	Tomas Winkler <tomas.winkler@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.10 2/2] mei: demote client disconnect warning on suspend to debug
Date: Sun, 23 Jun 2024 09:45:43 -0400
Message-ID: <20240623134544.810127-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240623134544.810127-1-sashal@kernel.org>
References: <20240623134544.810127-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.220
Content-Transfer-Encoding: 8bit

From: Alexander Usyskin <alexander.usyskin@intel.com>

[ Upstream commit 1db5322b7e6b58e1b304ce69a50e9dca798ca95b ]

Change level for the "not connected" client message in the write
callback from error to debug.

The MEI driver currently disconnects all clients upon system suspend.
This behavior is by design and user-space applications with
open connections before the suspend are expected to handle errors upon
resume, by reopening their handles, reconnecting,
and retrying their operations.

However, the current driver implementation logs an error message every
time a write operation is attempted on a disconnected client.
Since this is a normal and expected flow after system resume
logging this as an error can be misleading.

Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
Link: https://lore.kernel.org/r/20240530091415.725247-1-tomas.winkler@intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/misc/mei/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/mei/main.c b/drivers/misc/mei/main.c
index 9f6682033ed7e..d8311d41f0a7b 100644
--- a/drivers/misc/mei/main.c
+++ b/drivers/misc/mei/main.c
@@ -329,7 +329,7 @@ static ssize_t mei_write(struct file *file, const char __user *ubuf,
 	}
 
 	if (!mei_cl_is_connected(cl)) {
-		cl_err(dev, cl, "is not connected");
+		cl_dbg(dev, cl, "is not connected");
 		rets = -ENODEV;
 		goto out;
 	}
-- 
2.43.0


