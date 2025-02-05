Return-Path: <stable+bounces-112502-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CEA2AA28D11
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 14:57:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01DB2168EDC
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 13:56:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 909C01684B0;
	Wed,  5 Feb 2025 13:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tOyaGT1q"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CF241553AB;
	Wed,  5 Feb 2025 13:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738763782; cv=none; b=hY+3skMadZouxJOsAEWm3PD6J5H2H24igrMBFrOatXL1EP+sJSxvO5okz8pAIjvgUIbhzzcVQsCnZEGXn9aIMk+wT7hJBREMUpflhvTftjgWWyLe16qCrQK9A+vtN+is9xEOguQmI0oHQTloahDC2v5K43RVyKjcMJLdt+v7QPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738763782; c=relaxed/simple;
	bh=JJ37HfIC9nzRfGyfAKHtoR11UN0E6zPgPZq86fFB4WY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=epWvuJpz8qgIjs0LYYsjmCKmjzIXZQKM5Qq5y11aRzKror7MxEeN+2xnJTLR7W/9HHPk2nU4j7Y3l1IhjKsFWAwP3UQ2I/AafoUkyuV71CkL745yEHAcRjDLk1H4SufNxYEThLJZ3WN3fzB1Dbw7LKvEnHxp9GW2vIB0uyl3qN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tOyaGT1q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA4DDC4CED6;
	Wed,  5 Feb 2025 13:56:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1738763782;
	bh=JJ37HfIC9nzRfGyfAKHtoR11UN0E6zPgPZq86fFB4WY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tOyaGT1qjvUL8Pdz/a8bn2+qrFdoEjoWiqCD79fuZU95NQaowh8h5psnynU9rNUJJ
	 5BAxm7ckBEJwJGVmQ28fh5LoqnDLLjZ8Fd6pfCSOOUoG+qklh/YH7VSxlZNZI5qLKS
	 UO4wo3DsGA0F4G7CDIPyDubpvftw/2vgGE8C2zr8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Rob Herring (Arm)" <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Will McVicker <willmcvicker@google.com>,
	Pankaj Dubey <pankaj.dubey@samsung.com>,
	Lee Jones <lee@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 105/393] mfd: syscon: Fix race in device_node_get_regmap()
Date: Wed,  5 Feb 2025 14:40:24 +0100
Message-ID: <20250205134424.310231429@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250205134420.279368572@linuxfoundation.org>
References: <20250205134420.279368572@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Rob Herring (Arm) <robh@kernel.org>

[ Upstream commit 805f7aaf7fee14a57b56af01d270edf6c10765e8 ]

It is possible for multiple, simultaneous callers calling
device_node_get_regmap() with the same node to fail to find an entry in
the syscon_list. There is a period of time while the first caller is
calling of_syscon_register() that subsequent callers also fail to find
an entry in the syscon_list and then call of_syscon_register() a second
time.

Fix this by keeping the lock held until after of_syscon_register()
completes and adds the node to syscon_list. Convert the spinlock to a
mutex as many of the functions called in of_syscon_register() such as
kzalloc() and of_clk_get() may sleep.

Fixes: bdb0066df96e ("mfd: syscon: Decouple syscon interface from platform devices")
Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Tested-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Tested-by: Will McVicker <willmcvicker@google.com>
Tested-by: Pankaj Dubey <pankaj.dubey@samsung.com>
Reviewed-by: Pankaj Dubey <pankaj.dubey@samsung.com>
Link: https://lore.kernel.org/r/20241217-syscon-fixes-v2-1-4f56d750541d@kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mfd/syscon.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/mfd/syscon.c b/drivers/mfd/syscon.c
index 2ce15f60eb107..729e79e1be49f 100644
--- a/drivers/mfd/syscon.c
+++ b/drivers/mfd/syscon.c
@@ -15,6 +15,7 @@
 #include <linux/io.h>
 #include <linux/init.h>
 #include <linux/list.h>
+#include <linux/mutex.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/of_platform.h>
@@ -27,7 +28,7 @@
 
 static struct platform_driver syscon_driver;
 
-static DEFINE_SPINLOCK(syscon_list_slock);
+static DEFINE_MUTEX(syscon_list_lock);
 static LIST_HEAD(syscon_list);
 
 struct syscon {
@@ -54,6 +55,8 @@ static struct syscon *of_syscon_register(struct device_node *np, bool check_res)
 	struct resource res;
 	struct reset_control *reset;
 
+	WARN_ON(!mutex_is_locked(&syscon_list_lock));
+
 	struct syscon *syscon __free(kfree) = kzalloc(sizeof(*syscon), GFP_KERNEL);
 	if (!syscon)
 		return ERR_PTR(-ENOMEM);
@@ -144,9 +147,7 @@ static struct syscon *of_syscon_register(struct device_node *np, bool check_res)
 	syscon->regmap = regmap;
 	syscon->np = np;
 
-	spin_lock(&syscon_list_slock);
 	list_add_tail(&syscon->list, &syscon_list);
-	spin_unlock(&syscon_list_slock);
 
 	return_ptr(syscon);
 
@@ -167,7 +168,7 @@ static struct regmap *device_node_get_regmap(struct device_node *np,
 {
 	struct syscon *entry, *syscon = NULL;
 
-	spin_lock(&syscon_list_slock);
+	mutex_lock(&syscon_list_lock);
 
 	list_for_each_entry(entry, &syscon_list, list)
 		if (entry->np == np) {
@@ -175,11 +176,11 @@ static struct regmap *device_node_get_regmap(struct device_node *np,
 			break;
 		}
 
-	spin_unlock(&syscon_list_slock);
-
 	if (!syscon)
 		syscon = of_syscon_register(np, check_res);
 
+	mutex_unlock(&syscon_list_lock);
+
 	if (IS_ERR(syscon))
 		return ERR_CAST(syscon);
 
@@ -210,7 +211,7 @@ int of_syscon_register_regmap(struct device_node *np, struct regmap *regmap)
 		return -ENOMEM;
 
 	/* check if syscon entry already exists */
-	spin_lock(&syscon_list_slock);
+	mutex_lock(&syscon_list_lock);
 
 	list_for_each_entry(entry, &syscon_list, list)
 		if (entry->np == np) {
@@ -223,12 +224,12 @@ int of_syscon_register_regmap(struct device_node *np, struct regmap *regmap)
 
 	/* register the regmap in syscon list */
 	list_add_tail(&syscon->list, &syscon_list);
-	spin_unlock(&syscon_list_slock);
+	mutex_unlock(&syscon_list_lock);
 
 	return 0;
 
 err_unlock:
-	spin_unlock(&syscon_list_slock);
+	mutex_unlock(&syscon_list_lock);
 	kfree(syscon);
 	return ret;
 }
-- 
2.39.5




