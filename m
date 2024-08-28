Return-Path: <stable+bounces-71356-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5067961BAD
	for <lists+stable@lfdr.de>; Wed, 28 Aug 2024 04:02:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D99CB211E6
	for <lists+stable@lfdr.de>; Wed, 28 Aug 2024 02:02:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2409132C8B;
	Wed, 28 Aug 2024 02:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="gh3sXs7p"
X-Original-To: stable@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE8121B960
	for <stable@vger.kernel.org>; Wed, 28 Aug 2024 02:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724810542; cv=none; b=XU5I2932/YD68+hkZK8LMrr3XyikNZFgE+dLVwrDfIMHk5lrmeL15Xk8TGmSfLJCMUHUFeh1WbHNqsNBP3jvXbQhUsaGyUZNTfudt9PZ4KIyZIuc3i8lX3q7xxo3+D+Yz8OyNQCXnCbxh6frCoVFllF2E091xGqHAD6LEl6JKPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724810542; c=relaxed/simple;
	bh=R56vakts+QWxsnymQJLHIPBKAnAs1nuWKOQxsN8TFmc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UP0JLnmZPpNe03YrM4N9T011B9aImAy9XT8NepQkmW28I9gKz8XXxwkQZpJr0ih1PhLdh60m14O0K7LEuGRB98pjtLyo07Q1Ay6T7ugddhZh+ANW/APRrWPQi/iALzraaPyul7x5BIRMkm5X+G9CSTl0qzM050s0weNVWQhg/Gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=gh3sXs7p; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 06E653F078
	for <stable@vger.kernel.org>; Wed, 28 Aug 2024 02:02:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1724810538;
	bh=OO/IsCxvUEnNnlN1ST+oe4oaL5wJMHUETmDqBVkPmKI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version;
	b=gh3sXs7p5On2SeokuD1LKMNMntCoqIm2wGus4fHlAl6llL0RYW7HYFfg3Ikhhph6a
	 DcgIVbcZ/mrTWCkU1dtvA7J4+8MUJWQL2kceF/VGvtTn0jP8RJOZPVCuFcNp3dR0th
	 7Q/0lf1vzWVnFG/mHgPxX4RRb8peU7WQU1kf6GuGwvnQjHOe9USiP9sJCXj25FqE/D
	 kMTNuZZUaLencrqNcmQOlxn9gFrUeNSdDYJTB3ecAcVcwLwt4ttyBie5BQrnjrluPK
	 4uWZulOe4q5c4k2QNPSF2026JxKsfadD9yUyDrIqRrDIjtfcjQA329VyGcqJ4ckuXU
	 WbDEWkYaJySPA==
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2d45800a8f3so6040540a91.1
        for <stable@vger.kernel.org>; Tue, 27 Aug 2024 19:02:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724810535; x=1725415335;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OO/IsCxvUEnNnlN1ST+oe4oaL5wJMHUETmDqBVkPmKI=;
        b=I1Z3YYj0iArJt6PZI25yAsyvEiAhgKrZnrzvgA+9tiOPe7S9zDnEqfJ3t4NZ9t8V7J
         wV6ktsUoJlruSvwiYmR5+/DdJMkASXXaaPXYkZffvw0NoP28FPKZgm2XY/MWyseZb+Pi
         88K/r+sxihVnjc3QR5OtGO1lY1tEYhGySy2K4fjP+zD7N+a2Yu04s2jOEQuZkrTXQYqc
         lxu0QNTAccR7rc9scTGg2aRnln88r7HOgoRHKEIfcpUEHFECq7bxg3vJgEF5vkmppgCl
         9NxPI2cFWlXuJXSQmtYYrwJMvrsOTXQUMWeK6JjCfsam8HgBKzfWkBcKGBL8BGMkFqDb
         1KpQ==
X-Forwarded-Encrypted: i=1; AJvYcCXRgBTHb8yKxwlLguoQqX5N4gZpk6e4raWxBsSlCQLTziewKIoz/q/Op9cIr7i3kzf8HXrL9cI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxngootvfSw8lUtNJ83/Qly/KyGerd4zvH7NjZ2+5pEZ7MAHync
	N0+jIdPbTBUdS1AhjbjIKUszSeeaZJnCq4n827qsX1QogggBtc/qSCiEp3dATiTOKXjDio+dMhI
	0ucoEAB9CaEp5Bm3leETNZ+gRBebRDvPSBWJ81g+XwgGMgDbtPB9Rdl6z/J3V8fJ+FcwsnQ==
X-Received: by 2002:a17:90b:1645:b0:2c8:65cf:e820 with SMTP id 98e67ed59e1d1-2d646b9d4e7mr13234904a91.2.1724810535356;
        Tue, 27 Aug 2024 19:02:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHaqRnAzLipaAU0/AAz8UtFhoQkawaOMi5Rga23xq6LTzXbpZJrLjzbTJNZPOb3NU2D5/hzvw==
X-Received: by 2002:a17:90b:1645:b0:2c8:65cf:e820 with SMTP id 98e67ed59e1d1-2d646b9d4e7mr13234879a91.2.1724810534924;
        Tue, 27 Aug 2024 19:02:14 -0700 (PDT)
Received: from localhost.localdomain ([240f:74:7be:1:f997:a3d0:7709:1130])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d8446fc536sm238072a91.57.2024.08.27.19.02.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 19:02:14 -0700 (PDT)
From: Koichiro Den <koichiro.den@canonical.com>
To: koichiro.den@canonical.com
Cc: Christian Marangi <ansuelsmth@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH 1/1] PM / devfreq: Fix buffer overflow in trans_stat_show
Date: Wed, 28 Aug 2024 11:01:39 +0900
Message-ID: <20240828020150.2469014-2-koichiro.den@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240828020150.2469014-1-koichiro.den@canonical.com>
References: <20240828020150.2469014-1-koichiro.den@canonical.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Christian Marangi <ansuelsmth@gmail.com>

Fix buffer overflow in trans_stat_show().

Convert simple snprintf to the more secure scnprintf with size of
PAGE_SIZE.

Add condition checking if we are exceeding PAGE_SIZE and exit early from
loop. Also add at the end a warning that we exceeded PAGE_SIZE and that
stats is disabled.

Return -EFBIG in the case where we don't have enough space to write the
full transition table.

Also document in the ABI that this function can return -EFBIG error.

Link: https://lore.kernel.org/all/20231024183016.14648-2-ansuelsmth@gmail.com/
Cc: stable@vger.kernel.org
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218041
Fixes: e552bbaf5b98 ("PM / devfreq: Add sysfs node for representing frequency transition information.")
Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
(backported from commit 08e23d05fa6dc4fc13da0ccf09defdd4bbc92ff4)
[koichiroden: Adjusted context due to missing commits:
 commit b5d281f6c16d ("PM / devfreq: Rework freq_table to be local to devfreq struct")
 commit a03dacb0316f ("PM / devfreq: Add cpu based scaling support to passive governor")
 commit 483d557ee9a3 ("PM / devfreq: Clean up the devfreq instance name in sysfs attr")
 commit 1ebd0bc0e8ad ("PM / devfreq: Move statistics to separate struct devfreq_stats")
 commit 14a343968199 ("PM / devfreq: Add clearing transitions stats")
 commit b76b3479dab9 ("PM / devfreq: Change time stats to 64-bit")
 commit 5c0f6c795957 ("PM / devfreq: Add new interrupt_driven flag for governors")]
CVE-2023-52614
Signed-off-by: Koichiro Den <koichiro.den@canonical.com>
---
 Documentation/ABI/testing/sysfs-class-devfreq |  2 +
 drivers/devfreq/devfreq.c                     | 60 +++++++++++++------
 2 files changed, 43 insertions(+), 19 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-class-devfreq b/Documentation/ABI/testing/sysfs-class-devfreq
index 75897e2fde43..f95b69551b60 100644
--- a/Documentation/ABI/testing/sysfs-class-devfreq
+++ b/Documentation/ABI/testing/sysfs-class-devfreq
@@ -61,6 +61,8 @@ Description:
 		In order to activate this ABI, the devfreq target device
 		driver should provide the list of available frequencies
 		with its profile.
+		If the transition table is bigger than PAGE_SIZE, reading
+		this will return an -EFBIG error.
 
 What:		/sys/class/devfreq/.../userspace/set_freq
 Date:		September 2011
diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index 31e6cb5211bc..7a6115c23ec8 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -1403,12 +1403,12 @@ static ssize_t trans_stat_show(struct device *dev,
 			       struct device_attribute *attr, char *buf)
 {
 	struct devfreq *devfreq = to_devfreq(dev);
-	ssize_t len;
+	ssize_t len = 0;
 	int i, j;
 	unsigned int max_state = devfreq->profile->max_state;
 
 	if (max_state == 0)
-		return sprintf(buf, "Not Supported.\n");
+		return scnprintf(buf, PAGE_SIZE, "Not Supported.\n");
 
 	mutex_lock(&devfreq->lock);
 	if (!devfreq->stop_polling &&
@@ -1418,32 +1418,54 @@ static ssize_t trans_stat_show(struct device *dev,
 	}
 	mutex_unlock(&devfreq->lock);
 
-	len = sprintf(buf, "     From  :   To\n");
-	len += sprintf(buf + len, "           :");
-	for (i = 0; i < max_state; i++)
-		len += sprintf(buf + len, "%10lu",
-				devfreq->profile->freq_table[i]);
+	len += scnprintf(buf + len, PAGE_SIZE - len, "     From  :   To\n");
+	len += scnprintf(buf + len, PAGE_SIZE - len, "           :");
+	for (i = 0; i < max_state; i++) {
+		if (len >= PAGE_SIZE - 1)
+			break;
+		len += scnprintf(buf + len, PAGE_SIZE - len, "%10lu",
+				 devfreq->profile->freq_table[i]);
+	}
+	if (len >= PAGE_SIZE - 1)
+		return PAGE_SIZE - 1;
 
-	len += sprintf(buf + len, "   time(ms)\n");
+	len += scnprintf(buf + len, PAGE_SIZE - len, "   time(ms)\n");
 
 	for (i = 0; i < max_state; i++) {
+		if (len >= PAGE_SIZE - 1)
+			break;
 		if (devfreq->profile->freq_table[i]
 					== devfreq->previous_freq) {
-			len += sprintf(buf + len, "*");
+			len += scnprintf(buf + len, PAGE_SIZE - len, "*");
 		} else {
-			len += sprintf(buf + len, " ");
+			len += scnprintf(buf + len, PAGE_SIZE - len, " ");
+		}
+		if (len >= PAGE_SIZE - 1)
+			break;
+
+		len += scnprintf(buf + len, PAGE_SIZE - len, "%10lu:",
+				 devfreq->profile->freq_table[i]);
+		for (j = 0; j < max_state; j++) {
+			if (len >= PAGE_SIZE - 1)
+				break;
+			len += scnprintf(buf + len, PAGE_SIZE - len, "%10u",
+					 devfreq->trans_table[(i * max_state) + j]);
 		}
-		len += sprintf(buf + len, "%10lu:",
-				devfreq->profile->freq_table[i]);
-		for (j = 0; j < max_state; j++)
-			len += sprintf(buf + len, "%10u",
-				devfreq->trans_table[(i * max_state) + j]);
-		len += sprintf(buf + len, "%10u\n",
-			jiffies_to_msecs(devfreq->time_in_state[i]));
+		if (len >= PAGE_SIZE - 1)
+			break;
+		len += scnprintf(buf + len, PAGE_SIZE - len, "%10u\n",
+				 jiffies_to_msecs(devfreq->time_in_state[i]));
+	}
+
+	if (len < PAGE_SIZE - 1)
+		len += scnprintf(buf + len, PAGE_SIZE - len, "Total transition : %u\n",
+				 devfreq->total_trans);
+
+	if (len >= PAGE_SIZE - 1) {
+		pr_warn_once("devfreq transition table exceeds PAGE_SIZE. Disabling\n");
+		return -EFBIG;
 	}
 
-	len += sprintf(buf + len, "Total transition : %u\n",
-					devfreq->total_trans);
 	return len;
 }
 static DEVICE_ATTR_RO(trans_stat);
-- 
2.43.0


