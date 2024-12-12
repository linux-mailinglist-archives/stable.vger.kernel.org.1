Return-Path: <stable+bounces-103335-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ECD89EF650
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 18:24:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DEAA028CCBC
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 17:24:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5B802165F0;
	Thu, 12 Dec 2024 17:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZLF8cinW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0C0C211493;
	Thu, 12 Dec 2024 17:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734024256; cv=none; b=BKmszkqHmsx+fGyYaa7MwaeE7EhRNuWo1Hgj4MKc5MGbu4CMu3Av5lGC6u+XmgJiMmUhCuFGM8SkPNztJs8mo1q88+jTmwErAe8mpQsDXERdQFRH/HlQjNxgn/2q7uGFzbhDLdfSUiNwuGbPajx1NlhfsuZV6tkAZ/lUljI1OSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734024256; c=relaxed/simple;
	bh=XBmjGgtxAL/johVWuKYRYw/W1qAvVmtFwzvHfOELPrM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BO4el7zUNmBatIAUfFqKCUJd+4Di71RL2z4VDqKjdlgRO1JgTr42JnLfzLWEMJtlBReZ3qdDPIj+zXtMzXwYctL8RcgPi3jc/G6FNIZiV2a7acaySU8t+yQKrrzoyWd+z69XfyxJSnG00+rDgjp3EVwah5lOHa/yjg/RSmGBC+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZLF8cinW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A8FCC4CED0;
	Thu, 12 Dec 2024 17:24:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734024256;
	bh=XBmjGgtxAL/johVWuKYRYw/W1qAvVmtFwzvHfOELPrM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZLF8cinWq6enZa58XtfmpisC9OEu0VYEDHD0XsHZh9+Czfcf/TLFfGhnEBZnPjnf5
	 Zh2DUO2LYQQ+sFqc0cO6IRLzRQ3lCb5uLI05jDOUOV//+S8WWSaI1Bg9VWm4DJcMRv
	 LtiNKrDLsZIA8qb3DugjQB3ao5m8yYQqeZpRBst4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jinjie Ruan <ruanjinjie@huawei.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 236/459] misc: apds990x: Fix missing pm_runtime_disable()
Date: Thu, 12 Dec 2024 15:59:34 +0100
Message-ID: <20241212144302.897604007@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241212144253.511169641@linuxfoundation.org>
References: <20241212144253.511169641@linuxfoundation.org>
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

From: Jinjie Ruan <ruanjinjie@huawei.com>

[ Upstream commit 3c5d8b819d27012264edd17e6ae7fffda382fe44 ]

The pm_runtime_disable() is missing in probe error path,
so add it to fix it.

Fixes: 92b1f84d46b2 ("drivers/misc: driver for APDS990X ALS and proximity sensors")
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
Link: https://lore.kernel.org/r/20240923035556.3009105-1-ruanjinjie@huawei.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/misc/apds990x.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/misc/apds990x.c b/drivers/misc/apds990x.c
index 45f5b997a0e10..5b17288ecc2f0 100644
--- a/drivers/misc/apds990x.c
+++ b/drivers/misc/apds990x.c
@@ -1148,7 +1148,7 @@ static int apds990x_probe(struct i2c_client *client,
 		err = chip->pdata->setup_resources();
 		if (err) {
 			err = -EINVAL;
-			goto fail3;
+			goto fail4;
 		}
 	}
 
@@ -1156,7 +1156,7 @@ static int apds990x_probe(struct i2c_client *client,
 				apds990x_attribute_group);
 	if (err < 0) {
 		dev_err(&chip->client->dev, "Sysfs registration failed\n");
-		goto fail4;
+		goto fail5;
 	}
 
 	err = request_threaded_irq(client->irq, NULL,
@@ -1167,15 +1167,17 @@ static int apds990x_probe(struct i2c_client *client,
 	if (err) {
 		dev_err(&client->dev, "could not get IRQ %d\n",
 			client->irq);
-		goto fail5;
+		goto fail6;
 	}
 	return err;
-fail5:
+fail6:
 	sysfs_remove_group(&chip->client->dev.kobj,
 			&apds990x_attribute_group[0]);
-fail4:
+fail5:
 	if (chip->pdata && chip->pdata->release_resources)
 		chip->pdata->release_resources();
+fail4:
+	pm_runtime_disable(&client->dev);
 fail3:
 	regulator_bulk_disable(ARRAY_SIZE(chip->regs), chip->regs);
 fail2:
-- 
2.43.0




