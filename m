Return-Path: <stable+bounces-74500-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F7F5972F98
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 11:53:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 486381F23CD0
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 09:53:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EAE6188A1E;
	Tue, 10 Sep 2024 09:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Slc4o6yL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0107186E4B;
	Tue, 10 Sep 2024 09:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725961987; cv=none; b=fnD4451Vgr+AJAzmgMea7m1eFPLma+hQCeSCVs9xpizofbXgrrs9+BUFSFtyh0FqiZ1tMpp8X4XnbhfRRZIs/eQCYuGCoTIk5/Fel8KiJ9CG0CPhH/osmH8zfW/EHBdRzXqR61K0jmM6lMUWK5V41+ndX4eBtpxKmM+6yPg/4AY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725961987; c=relaxed/simple;
	bh=LwsWSTxvxLZILB2jczU0/VXGt2YCTEaKP4Z0f+wfcdI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B8mnn1BZICk+UZr+puKZYxktRjbRym0oAvnp+dtC/TIEKBzYv86cQGXXWxe/QDpjtKT+nPX2eieg3uVQNwbyzP9jq1fvhbz944wDlaDAujsVE0tDp/18RCLj2yl3IKqwpA0GnSl1PgUYQtHBoB1J9yygNpnj+5GHMHDmzlP96wU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Slc4o6yL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 579F5C4CEC3;
	Tue, 10 Sep 2024 09:53:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725961987;
	bh=LwsWSTxvxLZILB2jczU0/VXGt2YCTEaKP4Z0f+wfcdI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Slc4o6yLeESUjslvix0C/OdbbXvBcjgUiT90WGNzMqka15k5sz+/atYryZFtOZRKF
	 8RoyP8Sw0d9QTuHteDR6j5gUQjoCRaRYj3SdsOPuo3mVsas/gm1dpV+bpkQ30EJ+SV
	 60rQY6BTTnLmtv77EbyE+HPoA7h2mU8GeV6XBMCc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Guenter Roeck <linux@roeck-us.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.10 220/375] hwmon: (lm95234) Fix underflows seen when writing limit attributes
Date: Tue, 10 Sep 2024 11:30:17 +0200
Message-ID: <20240910092629.933604826@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240910092622.245959861@linuxfoundation.org>
References: <20240910092622.245959861@linuxfoundation.org>
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

6.10-stable review patch.  If anyone has any objections, please let me know.

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
index 67b9d7636ee4..37e8e9679aeb 100644
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




