Return-Path: <stable+bounces-204385-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 059A9CEC88F
	for <lists+stable@lfdr.de>; Wed, 31 Dec 2025 21:41:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4C7D3300A28C
	for <lists+stable@lfdr.de>; Wed, 31 Dec 2025 20:41:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D010730CDA4;
	Wed, 31 Dec 2025 20:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m3wW215g"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9014730CD89
	for <stable@vger.kernel.org>; Wed, 31 Dec 2025 20:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767213700; cv=none; b=KPvHIgTpyO0jExzSCxTKFKy9q7p5VO4zNaq6gw6ygIKp5SlqTVWR5RpxbddZarPdOFpY1CnPn5mDlQhKVUqyleuhrZoS/0+aGIjSVD1NTrksMjkcUzJkXJNedjPikuQ6oIOAhLpAOrm0qPKS50h/Rvrun/eLnzoNlb1KMGUyw7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767213700; c=relaxed/simple;
	bh=R0ow8dD/P8ulOCfIDijOdDNl7DfPUma69rac658ykZI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kUtdCtTlIIN9XsVDqbvlfc7xB0DkPs9dIlN7RmfRJpuYOLiO+nYriG9GptdDOpfuU4uz8flrrNRrbrP+Z7hQTafzpSnxMOTT4uqA4uAXS+JULQnWGnTy+uv5iG3WJcse1lySIgpPR2v9DSCwOTI+q5NDl/VrijcJ5MFcgF+Qirg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m3wW215g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B75BC19422;
	Wed, 31 Dec 2025 20:41:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767213700;
	bh=R0ow8dD/P8ulOCfIDijOdDNl7DfPUma69rac658ykZI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=m3wW215gNezponODch1x4IyPsWl4qSX/ctwV7jRNpr41SOcuI031RRRw0tMZFOPJQ
	 V9ZPUBLvD4yectd+bNra1NFJHCfLvS3D4M/WMzzgQSp0Fh8EZrVm4ASZWAPTYvefhs
	 i0YpffFXKB3fNrH9h3QcC5Cd9rf9d6UAD4KwT0FTgQ8JNze7cEdVF7eLQBgN/lw1au
	 I5faeQV+5hx6K5u7eXWCQf8xy9ulgBlKY7VZ2sjHJVnLejE6DTuZla1OoWIKJvKr3u
	 hVdF+WvaTsiD2QTgkDyjA95Vz7+fsjEB4B5PVtpc7OYEsGYdOXzDAOUuDYl/VSWeho
	 gMWFGJsDAxgIA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Gui-Dong Han <hanguidong02@gmail.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 2/2] hwmon: (max16065) Use local variable to avoid TOCTOU
Date: Wed, 31 Dec 2025 15:41:36 -0500
Message-ID: <20251231204136.3475586-2-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251231204136.3475586-1-sashal@kernel.org>
References: <2025122905-unstable-smuggling-c1a3@gregkh>
 <20251231204136.3475586-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Gui-Dong Han <hanguidong02@gmail.com>

[ Upstream commit b8d5acdcf525f44e521ca4ef51dce4dac403dab4 ]

In max16065_current_show, data->curr_sense is read twice: once for the
error check and again for the calculation. Since
i2c_smbus_read_byte_data returns negative error codes on failure, if the
data changes to an error code between the check and the use, ADC_TO_CURR
results in an incorrect calculation.

Read data->curr_sense into a local variable to ensure consistency. Note
that data->curr_gain is constant and safe to access directly.

This aligns max16065_current_show with max16065_input_show, which
already uses a local variable for the same reason.

Link: https://lore.kernel.org/all/CALbr=LYJ_ehtp53HXEVkSpYoub+XYSTU8Rg=o1xxMJ8=5z8B-g@mail.gmail.com/
Fixes: f5bae2642e3d ("hwmon: Driver for MAX16065 System Manager and compatibles")
Cc: stable@vger.kernel.org
Signed-off-by: Gui-Dong Han <hanguidong02@gmail.com>
Link: https://lore.kernel.org/r/20251128124709.3876-1-hanguidong02@gmail.com
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hwmon/max16065.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/hwmon/max16065.c b/drivers/hwmon/max16065.c
index 66d92f705136..5787db933fad 100644
--- a/drivers/hwmon/max16065.c
+++ b/drivers/hwmon/max16065.c
@@ -216,12 +216,13 @@ static ssize_t max16065_current_show(struct device *dev,
 				     struct device_attribute *da, char *buf)
 {
 	struct max16065_data *data = max16065_update_device(dev);
+	int curr_sense = data->curr_sense;
 
-	if (unlikely(data->curr_sense < 0))
-		return data->curr_sense;
+	if (unlikely(curr_sense < 0))
+		return curr_sense;
 
 	return sysfs_emit(buf, "%d\n",
-			  ADC_TO_CURR(data->curr_sense, data->curr_gain));
+			  ADC_TO_CURR(curr_sense, data->curr_gain));
 }
 
 static ssize_t max16065_limit_store(struct device *dev,
-- 
2.51.0


