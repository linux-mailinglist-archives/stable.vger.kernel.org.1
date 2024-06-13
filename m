Return-Path: <stable+bounces-51425-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CCFA907040
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 14:27:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 43DB3B29983
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 12:23:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 183C1145FFF;
	Thu, 13 Jun 2024 12:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mRCUNfkM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8895145FED;
	Thu, 13 Jun 2024 12:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718281260; cv=none; b=u2fpp/JYlaQhVpxAEivS0SBaz7P5CD6MinsR9AxAIinf0M9PKR7osRFsfTpegz2Suocfpej9pTf5vPCeyRPRX1WD2RS/uu8C9TG1XUbHZVc5ygM+duX/GHZgluyGfRQsZxHerPRjv9YZ4XHsFVFgG+V8MohL8kD7pyRj+X6kiLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718281260; c=relaxed/simple;
	bh=iEAIyWCeRU0Qbr8ZD7gfYl+FfA5njovQcr8qj4SEXfo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Clf0zXTL0wlpiSULfK25haqYwTE47IP5r1vyDqNuS0crYJgBYvB03CDqfKRJIgL29mUP1Y9clCHhQtc3Cg+w/qjdbuK9LqPvHnUUnAC7r+D7gJaa/eLblMIMuuKLTgpe8o/sHINDZcblnUwVJ6HAAzjf7SUI96LzS87mwV+8DH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mRCUNfkM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13609C2BBFC;
	Thu, 13 Jun 2024 12:20:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718281260;
	bh=iEAIyWCeRU0Qbr8ZD7gfYl+FfA5njovQcr8qj4SEXfo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mRCUNfkM/4quDXbSmdtEXksOhPpmRR4lolebWSf9i4ED5U4OrY1Cr6n9AXYtAHpip
	 6jly59KBX2XGSEWDF4FNVOomD4gF4AvzgtyvqUHDtAq0z5cWPz98TO+tOXgf4pF7AF
	 doOgAnifQhvHbN9FOFpweciJMb4+C/2nnXpobl4c=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Arnd Bergmann <arnd@arndb.de>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 193/317] Input: ims-pcu - fix printf string overflow
Date: Thu, 13 Jun 2024 13:33:31 +0200
Message-ID: <20240613113255.021978798@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240613113247.525431100@linuxfoundation.org>
References: <20240613113247.525431100@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arnd Bergmann <arnd@arndb.de>

[ Upstream commit bf32bceedd0453c70d9d022e2e29f98e446d7161 ]

clang warns about a string overflow in this driver

drivers/input/misc/ims-pcu.c:1802:2: error: 'snprintf' will always be truncated; specified size is 10, but format string expands to at least 12 [-Werror,-Wformat-truncation]
drivers/input/misc/ims-pcu.c:1814:2: error: 'snprintf' will always be truncated; specified size is 10, but format string expands to at least 12 [-Werror,-Wformat-truncation]

Make the buffer a little longer to ensure it always fits.

Fixes: 628329d52474 ("Input: add IMS Passenger Control Unit driver")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Link: https://lore.kernel.org/r/20240326223825.4084412-7-arnd@kernel.org
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/input/misc/ims-pcu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/input/misc/ims-pcu.c b/drivers/input/misc/ims-pcu.c
index 08b9b5cdb943e..e5cb20e7f57b1 100644
--- a/drivers/input/misc/ims-pcu.c
+++ b/drivers/input/misc/ims-pcu.c
@@ -42,8 +42,8 @@ struct ims_pcu_backlight {
 #define IMS_PCU_PART_NUMBER_LEN		15
 #define IMS_PCU_SERIAL_NUMBER_LEN	8
 #define IMS_PCU_DOM_LEN			8
-#define IMS_PCU_FW_VERSION_LEN		(9 + 1)
-#define IMS_PCU_BL_VERSION_LEN		(9 + 1)
+#define IMS_PCU_FW_VERSION_LEN		16
+#define IMS_PCU_BL_VERSION_LEN		16
 #define IMS_PCU_BL_RESET_REASON_LEN	(2 + 1)
 
 #define IMS_PCU_PCU_B_DEVICE_ID		5
-- 
2.43.0




