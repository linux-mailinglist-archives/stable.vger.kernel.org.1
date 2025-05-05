Return-Path: <stable+bounces-141657-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 32412AAB55A
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 07:26:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 012E83AC79F
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 05:21:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 330F3498CA1;
	Tue,  6 May 2025 00:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nzyOrXO0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 548732F5F95;
	Mon,  5 May 2025 23:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746487064; cv=none; b=h4Yo7/jsv9wo+m5oL1Yu189ub7FFf5zurD++wM5KuamTy+6BxhbfjRuSuEsrGeCP/IIWMQYheIT8sdDXcK2LzOWXnmiekglz18zbfvZtt3dInh3qxOzn5FaJHrLdB8DyAXi268lj7ckE8w7nhYqBaLis7n35H79XVAmtX17xKMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746487064; c=relaxed/simple;
	bh=yHsbA/Yy80CKLzVxffermAhP8qR6DnaOEHWNnHxxUwI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RbJQBAPTNn/hFDlnZ19dbfDjv3WlRs+IjKkoBus6kaPlX38z6SXceH9j8u8mqBcpT2cmU7davS1hL2H/96RFwTFjWhc5J2fTfMx/P3yWg/f3QROYQcvsveanfdrvvYeuLSfLWYxPvcLmd7lB//DW/sy0fpjMbJJyW8Zq+74JBZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nzyOrXO0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 718FAC4CEEF;
	Mon,  5 May 2025 23:17:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746487063;
	bh=yHsbA/Yy80CKLzVxffermAhP8qR6DnaOEHWNnHxxUwI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nzyOrXO0f0zFYGbLuME8CYMhCGPq1pV5HxupmXmq42PzqHC6XZrUR6wuarnexeai7
	 YdHZI1hVutvJ/svudlmwFi4UsojoG7luPBEwoohKEYpSx3xkAsFy/+n7Z66xUW/aA5
	 GeR9V12oj4Z/By8G0MT9AcBjpHqNLRf3R0UaHpg2Qx2YUKgXh7Z0Y+fsQjhtdz5eFF
	 0Uqs9R+vDCLHOLJkE/osm69TowvP3y2DrC8/nVumQQ8OwE8sjt257rU+GXd2D79wef
	 95wW67cfiyOl+kubaSEd58raNZtIUAY52lNqSW4e58QjsuvxzeHtQQedY2P/KFtEqe
	 rnF+Na6a+xeQA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Andrey Vatoropin <a.vatoropin@crpt.ru>,
	Guenter Roeck <linux@roeck-us.net>,
	Sasha Levin <sashal@kernel.org>,
	jdelvare@suse.com,
	linux-hwmon@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 134/153] hwmon: (xgene-hwmon) use appropriate type for the latency value
Date: Mon,  5 May 2025 19:13:01 -0400
Message-Id: <20250505231320.2695319-134-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505231320.2695319-1-sashal@kernel.org>
References: <20250505231320.2695319-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.181
Content-Transfer-Encoding: 8bit

From: Andrey Vatoropin <a.vatoropin@crpt.ru>

[ Upstream commit 8df0f002827e18632dcd986f7546c1abf1953a6f ]

The expression PCC_NUM_RETRIES * pcc_chan->latency is currently being
evaluated using 32-bit arithmetic.

Since a value of type 'u64' is used to store the eventual result,
and this result is later sent to the function usecs_to_jiffies with
input parameter unsigned int, the current data type is too wide to
store the value of ctx->usecs_lat.

Change the data type of "usecs_lat" to a more suitable (narrower) type.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Andrey Vatoropin <a.vatoropin@crpt.ru>
Link: https://lore.kernel.org/r/20250204095400.95013-1-a.vatoropin@crpt.ru
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hwmon/xgene-hwmon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/xgene-hwmon.c b/drivers/hwmon/xgene-hwmon.c
index 60a8ff56c38e9..9e82ba43f5cd2 100644
--- a/drivers/hwmon/xgene-hwmon.c
+++ b/drivers/hwmon/xgene-hwmon.c
@@ -110,7 +110,7 @@ struct xgene_hwmon_dev {
 
 	phys_addr_t		comm_base_addr;
 	void			*pcc_comm_addr;
-	u64			usecs_lat;
+	unsigned int		usecs_lat;
 };
 
 /*
-- 
2.39.5


