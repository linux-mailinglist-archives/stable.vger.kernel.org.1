Return-Path: <stable+bounces-75087-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C17E19732DB
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 12:27:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77BBC1F22E2A
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 10:27:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1469E1917D7;
	Tue, 10 Sep 2024 10:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GDeFEaGV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7D1D18FC93;
	Tue, 10 Sep 2024 10:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725963711; cv=none; b=EStm3L0M8jXCubn25+E3CD8e/Empxh8a4C8oQf/GuLPMdMoAstwyUVbkiueAfbBst85l0oI7GAdNzxBmckRqhe/AfDfWu2Otzlbm53mp/AuI7OaN9FONppNr5KQwVRBZNtA8N4weq0jd8AL0jj+P5vWpCKOKZSi2U4HNdafwmeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725963711; c=relaxed/simple;
	bh=HI6MekB+u2iWUs+RNWCpnzjTQvh4DQaZk8O/tFx6uLg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eMiIgWhSfqsj1j3KYt8WYFx4t3DVmEBfAC5M77lccN0y7nTpj0ob0TGQgJi7U3F7kIoGP0CyGFT2/kWfLxiqtX8oExaSm5jRP+62uPE74ORs8NWBURDQzJTJV1Qhww1jYjCOsZZH4vrmViI+zKexn74Xl+m00lnZ+LmbJ5sxXCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GDeFEaGV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5024CC4CEC6;
	Tue, 10 Sep 2024 10:21:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725963711;
	bh=HI6MekB+u2iWUs+RNWCpnzjTQvh4DQaZk8O/tFx6uLg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GDeFEaGVBkmTwQKHKyqRqx/Bot+1GdMoWjx7wz0eb43lLl9lJP/3sYct4LwZtJbwn
	 AtNja9ZbGJuedXYf06olIEuiDT0FYOazqdZ4mE844TbOsvFF9kYFiOfcLgZz3fJEDx
	 ZCC+2KxqG/8z0f+aRT2i6oZnZx9gDUBUw5W30jak=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Guenter Roeck <linux@roeck-us.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 143/214] hwmon: (lm95234) Fix underflows seen when writing limit attributes
Date: Tue, 10 Sep 2024 11:32:45 +0200
Message-ID: <20240910092604.599647481@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240910092558.714365667@linuxfoundation.org>
References: <20240910092558.714365667@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Guenter Roeck <linux@roeck-us.net>

[ Upstream commit af64e3e1537896337405f880c1e9ac1f8c0c6198 ]

DIV_ROUND_CLOSEST() after kstrtol() results in an underflow if a large
negative number such as -9223372036854775808 is provided by the user.
Fix it by reordering clamp_val() and DIV_ROUND_CLOSEST() operations.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hwmon/lm95234.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/hwmon/lm95234.c b/drivers/hwmon/lm95234.c
index ac169a994ae0..db2aecdfbd17 100644
--- a/drivers/hwmon/lm95234.c
+++ b/drivers/hwmon/lm95234.c
@@ -301,7 +301,8 @@ static ssize_t tcrit2_store(struct device *dev, struct device_attribute *attr,
 	if (ret < 0)
 		return ret;
 
-	val = clamp_val(DIV_ROUND_CLOSEST(val, 1000), 0, index ? 255 : 127);
+	val = DIV_ROUND_CLOSEST(clamp_val(val, 0, (index ? 255 : 127) * 1000),
+				1000);
 
 	mutex_lock(&data->update_lock);
 	data->tcrit2[index] = val;
@@ -350,7 +351,7 @@ static ssize_t tcrit1_store(struct device *dev, struct device_attribute *attr,
 	if (ret < 0)
 		return ret;
 
-	val = clamp_val(DIV_ROUND_CLOSEST(val, 1000), 0, 255);
+	val = DIV_ROUND_CLOSEST(clamp_val(val, 0, 255000), 1000);
 
 	mutex_lock(&data->update_lock);
 	data->tcrit1[index] = val;
@@ -391,7 +392,7 @@ static ssize_t tcrit1_hyst_store(struct device *dev,
 	if (ret < 0)
 		return ret;
 
-	val = DIV_ROUND_CLOSEST(val, 1000);
+	val = DIV_ROUND_CLOSEST(clamp_val(val, -255000, 255000), 1000);
 	val = clamp_val((int)data->tcrit1[index] - val, 0, 31);
 
 	mutex_lock(&data->update_lock);
@@ -431,7 +432,7 @@ static ssize_t offset_store(struct device *dev, struct device_attribute *attr,
 		return ret;
 
 	/* Accuracy is 1/2 degrees C */
-	val = clamp_val(DIV_ROUND_CLOSEST(val, 500), -128, 127);
+	val = DIV_ROUND_CLOSEST(clamp_val(val, -64000, 63500), 500);
 
 	mutex_lock(&data->update_lock);
 	data->toffset[index] = val;
-- 
2.43.0




