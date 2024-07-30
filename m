Return-Path: <stable+bounces-63301-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 07EA894184A
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 18:20:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7C4C1F21A2C
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 16:20:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41079187FF9;
	Tue, 30 Jul 2024 16:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZLczkUpc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBB341A617E;
	Tue, 30 Jul 2024 16:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722356385; cv=none; b=Q5hkupG3lr5fSglAxtU+kKyJ7SN2C4K81q+hz+lrcFad/xP0r00xupNWkskmO7JZA9/ZCF9QFv9VFAD6MyJaoxUqLtVuleecPCDgAZekPdwDBTtRRMDgxVqzqbV+IMN3r1TJx7yr3PD107jQZl0YaRLBkxbeaJSvWWKTdTj0gGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722356385; c=relaxed/simple;
	bh=t0nqM5ioZ9JIKtlKaGz7M8LajSL+GaGAV5kkljiaFxI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mwr2k3YfkSqAsTEuYR/kki/EqX4j+ihA6080nxBogVTgVDWiJP3oWjPEO1WxPFbiZShUDm2aviCX1rc+MhpW4rfRBJeALTcPEjM4V9Ie2sFBfXp6HOqpKRII+KxtIWnrP+ymRcSozO9QbRZbOgVioqnGgX1VimNhttG4pocxZno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZLczkUpc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69222C32782;
	Tue, 30 Jul 2024 16:19:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722356384;
	bh=t0nqM5ioZ9JIKtlKaGz7M8LajSL+GaGAV5kkljiaFxI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZLczkUpcnzBTZQMLmYSdNEvr92CtvdTG1OVHvBgnczwYXaBeE9GYYHe0uDmk2Z+Vf
	 Q9ZJkR3tUwKJqwiR6kuTYJFA5AkYkPNszepfMkBl7SHQFMx672nAxk9wE5SMGSZXQ/
	 AMMHG7m6JjWWr7PirAybS+YOTD/qFYrUm3/pH/ac=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
	Andy Shevchenko <andy@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.10 145/809] firmware: turris-mox-rwtm: Do not complete if there are no waiters
Date: Tue, 30 Jul 2024 17:40:21 +0200
Message-ID: <20240730151730.333741540@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240730151724.637682316@linuxfoundation.org>
References: <20240730151724.637682316@linuxfoundation.org>
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

6.10-stable review patch.  If anyone has any objections, please let me know.

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
index 31d962cdd6eb2..f1f9160c4195f 100644
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




