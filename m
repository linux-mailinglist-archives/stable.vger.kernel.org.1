Return-Path: <stable+bounces-205202-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 08E60CFB283
	for <lists+stable@lfdr.de>; Tue, 06 Jan 2026 22:49:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4DC86309E339
	for <lists+stable@lfdr.de>; Tue,  6 Jan 2026 21:46:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABF20349AFF;
	Tue,  6 Jan 2026 17:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YBbqfcMJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A893349AFA;
	Tue,  6 Jan 2026 17:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767719913; cv=none; b=fsvGWYl3qsZj0fwjsOWNiKwDjMy8g6z0u2FJG5kqUgfvPY6S2TuK1Z9tA8bwJHNP2V2lkqpa78P9kwIUgc5fq41PQyAkvSQr3yRMNBPL5ZuVf46O6KaBYHhlMiM8YIQRPwegB5QNoJksJhMpH9igEJDDQyM+oUMrqFHSpVZbWfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767719913; c=relaxed/simple;
	bh=h1p6wF8Rg7h9CPAqditkrVWDgu1IRcB7XbBN4/XZFX8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q+4J1q3JsuEPHnrC3G0GzBa2ubiSQKolYEAxpM530PGB3RTBb1fySQgh18djo6P1uC0hxwDy8Xks30AGeqfE5mnecq8FBmserU9vC90jNzVWHJ0SwKHOEvni6Ja21XHmmDyic97X22NlOKmNDwVBK81xR5HeP71dT8VbGauNEzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YBbqfcMJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD82FC116C6;
	Tue,  6 Jan 2026 17:18:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767719913;
	bh=h1p6wF8Rg7h9CPAqditkrVWDgu1IRcB7XbBN4/XZFX8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YBbqfcMJaQaQnneiMXEIbramN9/9asuqg9KSQ7RGW0OkztQOMAKG6wBq62ncezvqh
	 lF9RIaUyeA/9rBdlT2/ug4K1N2M0cSt0ebVMNTg7dfAgq2WghS/pYR77OFOOPdG3CZ
	 Wzb4WKUCJfrGSjsei3fMvkmTBfiTem6VwDg8kx04=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Yuhao Jiang <danisjiang@gmail.com>,
	Junrui Luo <moonafterrain@outlook.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 079/567] hwmon: (ibmpex) fix use-after-free in high/low store
Date: Tue,  6 Jan 2026 17:57:41 +0100
Message-ID: <20260106170454.254350669@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260106170451.332875001@linuxfoundation.org>
References: <20260106170451.332875001@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Junrui Luo <moonafterrain@outlook.com>

[ Upstream commit 6946c726c3f4c36f0f049e6f97e88c510b15f65d ]

The ibmpex_high_low_store() function retrieves driver data using
dev_get_drvdata() and uses it without validation. This creates a race
condition where the sysfs callback can be invoked after the data
structure is freed, leading to use-after-free.

Fix by adding a NULL check after dev_get_drvdata(), and reordering
operations in the deletion path to prevent TOCTOU.

Reported-by: Yuhao Jiang <danisjiang@gmail.com>
Reported-by: Junrui Luo <moonafterrain@outlook.com>
Fixes: 57c7c3a0fdea ("hwmon: IBM power meter driver")
Signed-off-by: Junrui Luo <moonafterrain@outlook.com>
Link: https://lore.kernel.org/r/MEYPR01MB7886BE2F51BFE41875B74B60AFA0A@MEYPR01MB7886.ausprd01.prod.outlook.com
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hwmon/ibmpex.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/ibmpex.c b/drivers/hwmon/ibmpex.c
index 228c5f6c6f38..129f3a9e8fe9 100644
--- a/drivers/hwmon/ibmpex.c
+++ b/drivers/hwmon/ibmpex.c
@@ -277,6 +277,9 @@ static ssize_t ibmpex_high_low_store(struct device *dev,
 {
 	struct ibmpex_bmc_data *data = dev_get_drvdata(dev);
 
+	if (!data)
+		return -ENODEV;
+
 	ibmpex_reset_high_low_data(data);
 
 	return count;
@@ -508,6 +511,9 @@ static void ibmpex_bmc_delete(struct ibmpex_bmc_data *data)
 {
 	int i, j;
 
+	hwmon_device_unregister(data->hwmon_dev);
+	dev_set_drvdata(data->bmc_device, NULL);
+
 	device_remove_file(data->bmc_device,
 			   &sensor_dev_attr_reset_high_low.dev_attr);
 	device_remove_file(data->bmc_device, &dev_attr_name.attr);
@@ -521,8 +527,7 @@ static void ibmpex_bmc_delete(struct ibmpex_bmc_data *data)
 		}
 
 	list_del(&data->list);
-	dev_set_drvdata(data->bmc_device, NULL);
-	hwmon_device_unregister(data->hwmon_dev);
+
 	ipmi_destroy_user(data->user);
 	kfree(data->sensors);
 	kfree(data);
-- 
2.51.0




