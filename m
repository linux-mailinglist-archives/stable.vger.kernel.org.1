Return-Path: <stable+bounces-63193-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F7029417DE
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 18:17:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50D531F24F23
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 16:17:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72B5E189504;
	Tue, 30 Jul 2024 16:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="E/akJ6Bb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 326841A616E;
	Tue, 30 Jul 2024 16:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722356025; cv=none; b=armr/8n5J0l6NI5Bhyi6FxDWwBLJjDxzf5yoKi3MtbsAK3zfzw+i6SJGW9kRam4AFc5Vsg/chuipV+Zc0eLmqxF20ZrQKusCM1rgLz/erNn6WZZ/3hjN8GkFJNPFBSHrCmuO7pAnMyw3Gudu3Mu6lVqy7+TNj4YoL8Aq8B6LVOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722356025; c=relaxed/simple;
	bh=1Noa6vJaoDbwDWT/wG56nqciPqT3xb/v5a2tu7kcoPU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j/yFrxGHUgk9zWuFXNsOXGE+/jrT4GHIFi8TovKsjWnAKVoTFfSUICPS1/g9qB9qy0u6jte1oXuwq43IGCev8CKIqw+ipoModnnizFtGUYvqHKYORnHDoVJzovx+jRdv5vcXN6rFz4vgdzHuDAC7JDfSFRWD/BJFV0V2wuQ2lHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=E/akJ6Bb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E442C32782;
	Tue, 30 Jul 2024 16:13:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722356024;
	bh=1Noa6vJaoDbwDWT/wG56nqciPqT3xb/v5a2tu7kcoPU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=E/akJ6BbqB1OcRRDF1PtDR00TstLnxeVjFLnaq/kCN7DwApr40Qbw65AFqf9JOqx+
	 AKORGuaUwlCUj29a1E1z1rYbWsDSgb9Gw/A+MNGGuhGlU8TGmpCYMsW1O1yfgc6mv0
	 1q//pDbfX1zd7DXt6FQTTThq5qYkwuydu6C+fYY4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
	Andy Shevchenko <andy@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 107/568] firmware: turris-mox-rwtm: Do not complete if there are no waiters
Date: Tue, 30 Jul 2024 17:43:34 +0200
Message-ID: <20240730151644.058104900@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240730151639.792277039@linuxfoundation.org>
References: <20240730151639.792277039@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Marek Behún <kabel@kernel.org>

[ Upstream commit 0bafb172b111ab27251af0eb684e7bde9570ce4c ]

Do not complete the "command done" completion if there are no waiters.
This can happen if a wait_for_completion() timed out or was interrupted.

Fixes: 389711b37493 ("firmware: Add Turris Mox rWTM firmware driver")
Signed-off-by: Marek Behún <kabel@kernel.org>
Reviewed-by: Andy Shevchenko <andy@kernel.org>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/firmware/turris-mox-rwtm.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/turris-mox-rwtm.c b/drivers/firmware/turris-mox-rwtm.c
index 2de0fb139ce17..efd35d308aac9 100644
--- a/drivers/firmware/turris-mox-rwtm.c
+++ b/drivers/firmware/turris-mox-rwtm.c
@@ -2,7 +2,7 @@
 /*
  * Turris Mox rWTM firmware driver
  *
- * Copyright (C) 2019 Marek Behún <kabel@kernel.org>
+ * Copyright (C) 2019, 2024 Marek Behún <kabel@kernel.org>
  */
 
 #include <linux/armada-37xx-rwtm-mailbox.h>
@@ -174,6 +174,9 @@ static void mox_rwtm_rx_callback(struct mbox_client *cl, void *data)
 	struct mox_rwtm *rwtm = dev_get_drvdata(cl->dev);
 	struct armada_37xx_rwtm_rx_msg *msg = data;
 
+	if (completion_done(&rwtm->cmd_done))
+		return;
+
 	rwtm->reply = *msg;
 	complete(&rwtm->cmd_done);
 }
-- 
2.43.0




