Return-Path: <stable+bounces-74701-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B59279730DF
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 12:05:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F2FC287529
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 10:05:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13FEA18DF69;
	Tue, 10 Sep 2024 10:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="O8ZN9B2Q"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C231618D643;
	Tue, 10 Sep 2024 10:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725962573; cv=none; b=K4O9Nu9flB3HQsKgwJk7XX+Jfk1eYw3ZMIWLFOUFONa0JGLXQ41saqQg9JOuwqwoaecFGxo7llUtDvvlMzAysnVcOUJbNLeDAiZHwjJ++HYBbpXwAYnS6D2zrw5eB70vlUmPdToesItsnOwIiZIhlTprAz2WZHMGYXjiLvasNYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725962573; c=relaxed/simple;
	bh=EnxtgUtckf6Q4aS6bAWAI/rIPJwznHj11fEJo08bU7c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SzcE1ioQ3u3GAAFnOxrxboQ7Erz4kZJf/dgSXp6C/2fqG7BxOiu6xoDZ/UvV9KBxynbR58H/UnGYZnaXv+ZZvDb2Cxeybe75JHipS9o9BJTHgKuB8du4xWr+w2L0rOtJJd5kI6CDsJSZzmUITOaDKYOfDIB9hUYaeFsGhO/j3l4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=O8ZN9B2Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 486A9C4CEC3;
	Tue, 10 Sep 2024 10:02:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725962573;
	bh=EnxtgUtckf6Q4aS6bAWAI/rIPJwznHj11fEJo08bU7c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=O8ZN9B2QVcBwIBLA0oaOOz6zgAY+sYzB2Xf3stsDyq52w9eLyyIXA9rwMQ98/qFPi
	 x2ACSBWlV7dIuH7pDEQzePQ1FUnlzNbg5r8UQInrsgG1g/xFH2nUvP+dCKA1se1mKA
	 BSz+XN8HZmFVR4V4wqdpyk0HK4jtJvqUnZ53lQLw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Guenter Roeck <linux@roeck-us.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 079/121] hwmon: (w83627ehf) Fix underflows seen when writing limit attributes
Date: Tue, 10 Sep 2024 11:32:34 +0200
Message-ID: <20240910092549.649898368@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240910092545.737864202@linuxfoundation.org>
References: <20240910092545.737864202@linuxfoundation.org>
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

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Guenter Roeck <linux@roeck-us.net>

[ Upstream commit 5c1de37969b7bc0abcb20b86e91e70caebbd4f89 ]

DIV_ROUND_CLOSEST() after kstrtol() results in an underflow if a large
negative number such as -9223372036854775808 is provided by the user.
Fix it by reordering clamp_val() and DIV_ROUND_CLOSEST() operations.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hwmon/w83627ehf.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/w83627ehf.c b/drivers/hwmon/w83627ehf.c
index eb171d15ac48..e4e5bb911558 100644
--- a/drivers/hwmon/w83627ehf.c
+++ b/drivers/hwmon/w83627ehf.c
@@ -1506,7 +1506,7 @@ store_target_temp(struct device *dev, struct device_attribute *attr,
 	if (err < 0)
 		return err;
 
-	val = clamp_val(DIV_ROUND_CLOSEST(val, 1000), 0, 127);
+	val = DIV_ROUND_CLOSEST(clamp_val(val, 0, 127000), 1000);
 
 	mutex_lock(&data->update_lock);
 	data->target_temp[nr] = val;
@@ -1532,7 +1532,7 @@ store_tolerance(struct device *dev, struct device_attribute *attr,
 		return err;
 
 	/* Limit the temp to 0C - 15C */
-	val = clamp_val(DIV_ROUND_CLOSEST(val, 1000), 0, 15);
+	val = DIV_ROUND_CLOSEST(clamp_val(val, 0, 15000), 1000);
 
 	mutex_lock(&data->update_lock);
 	if (sio_data->kind == nct6775 || sio_data->kind == nct6776) {
-- 
2.43.0




