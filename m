Return-Path: <stable+bounces-146311-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E902AC36B8
	for <lists+stable@lfdr.de>; Sun, 25 May 2025 22:18:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5EEE73B4565
	for <lists+stable@lfdr.de>; Sun, 25 May 2025 20:18:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88A4B1990B7;
	Sun, 25 May 2025 20:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rong.moe header.i=i@rong.moe header.b="m9E052xi"
X-Original-To: stable@vger.kernel.org
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A83E12B93;
	Sun, 25 May 2025 20:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748204333; cv=pass; b=TKll7hGmhLk1miCiNG9/GJ6fa1ioJkJmqtwGAHvmgwWwqKr8gQCL7mtLRdUt9y2xVC3E1C/VqOeuMBvEkRJUmFKesvGro1z61vG1J37XiJvkTlZ28zaoG1/MRgb7PYWfTb7HT1chNx6AbtoKUB/esPxyF34NAggYL5Ba/JTGp6Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748204333; c=relaxed/simple;
	bh=s9lHYkvc5oBz7j98KfIQzHiKsdeOkegekBomotUI80Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AhiVL7pdwF8p+TpcXuonPvZ6N7T5xhle6XAY3RAzemaNBk3Xnx3RpRH0tp+xHMbi0GnGNHlz8/gXonyRGA9/k2MfzNxGPa7YOipuawknCNzvzO7Ck6+2aD4hnJKpzyD7PsPywDgLwpKHC9xvEActUYD0OH4W25ZqOQPXBQ7JCqQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rong.moe; spf=pass smtp.mailfrom=rong.moe; dkim=pass (1024-bit key) header.d=rong.moe header.i=i@rong.moe header.b=m9E052xi; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rong.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rong.moe
ARC-Seal: i=1; a=rsa-sha256; t=1748204320; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=V8pScS/lA303Auz0ODxENTLz8QgfA8TmuPswUjFm0qPjOtyjdeSTuBg06h0Z8ELapC2v4HSTvw/GsXmQWUseAdMkU0RPAlpAzLCF83U02Us+Oqmv3A7TrIri5QWG2QnI9+AAWUi3SNzMU79uoYwOcVsjMdHG5CX/s5e0Sgc55Eo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1748204320; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=RvGbuKkqRFrhy2+M+9nl9ydQe9xza+jIrZCt2To8+kU=; 
	b=aXE6tlAwFUzn+UtLllxk417GHOT65G8c7XvSRo6ReCDEtWmuxvaxPasHSOkRmQS65NeXjFtZ38ypmtB9g3RbfS3G+NQjM0rWtN/9LHvQHPP3k7PLaZCIQNJh8p9VXryBZvWc9r8jn8/C2PG38F0yzdQfFYxQdWe5qHqVTWRr070=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=rong.moe;
	spf=pass  smtp.mailfrom=i@rong.moe;
	dmarc=pass header.from=<i@rong.moe>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1748204320;
	s=zmail; d=rong.moe; i=i@rong.moe;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=RvGbuKkqRFrhy2+M+9nl9ydQe9xza+jIrZCt2To8+kU=;
	b=m9E052xiI4GkzY86AOl03du6RDDvfQX7yd7TqkbG0bGRp7Ts5d38AVcYMj1mNBXf
	3feWsoxHSVVpgr6ThgudElP3Ped2HqOBM7rPAQt86j9DDy8e8S8KAmzjxe5BdWxjcy8
	CXJC2dkFTxQt8wrNxXx7I+uLTyPxj8CbLhgXvqfk=
Received: by mx.zohomail.com with SMTPS id 1748204319360849.3143598149691;
	Sun, 25 May 2025 13:18:39 -0700 (PDT)
From: Rong Zhang <i@rong.moe>
To: Ike Panhc <ikepanhc@gmail.com>,
	Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Rong Zhang <i@rong.moe>,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Eric Long <i@hack3r.moe>
Subject: [PATCH] platform/x86: ideapad-laptop: use usleep_range() for EC polling
Date: Mon, 26 May 2025 04:18:07 +0800
Message-ID: <20250525201833.37939-1-i@rong.moe>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

It was reported that ideapad-laptop sometimes causes some recent (since
2024) Lenovo ThinkBook models shut down when:
 - suspending/resuming
 - closing/opening the lid
 - (dis)connecting a charger
 - reading/writing some sysfs properties, e.g., fan_mode, touchpad
 - pressing down some Fn keys, e.g., Brightness Up/Down (Fn+F5/F6)
 - (seldom) loading the kmod

The issue has existed since the launch day of such models, and there
have been some out-of-tree workarounds (see Link:) for the issue. One
disables some functionalities, while another one simply shortens
IDEAPAD_EC_TIMEOUT. The disabled functionalities have read_ec_data() in
their call chains, which calls schedule() between each poll.

It turns out that these models suffer from the indeterminacy of
schedule() because of their low tolerance for being polled too
frequently. Sometimes schedule() returns too soon due to the lack of
ready tasks, causing the margin between two polls to be too short.
In this case, the command is somehow aborted, and too many subsequent
polls (they poll for "nothing!") may eventually break the state machine
in the EC, resulting in a hard shutdown. This explains why shortening
IDEAPAD_EC_TIMEOUT works around the issue - it reduces the total number
of polls sent to the EC.

Even when it doesn't lead to a shutdown, frequent polls may also disturb
the ongoing operation and notably delay (+ 10-20ms) the availability of
EC response. This phenomenon is unlikely to be exclusive to the models
mentioned above, so dropping the schedule() manner should also slightly
improve the responsiveness of various models.

Fix these issues by migrating to usleep_range(150, 300). The interval is
chosen to add some margin to the minimal 50us and considering EC
responses are usually available after 150-2500us based on my test. It
should be enough to fix these issues on all models subject to the EC bug
without introducing latency on other models.

Tested on ThinkBook 14 G7+ ASP and solved both issues. No regression was
introduced in the test on a model without the EC bug (ThinkBook X IMH,
thanks Eric).

Link: https://github.com/ty2/ideapad-laptop-tb2024g6plus/commit/6c5db18c9e8109873c2c90a7d2d7f552148f7ad4
Link: https://github.com/ferstar/ideapad-laptop-tb/commit/42d1e68e5009529d31bd23f978f636f79c023e80
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218771
Fixes: 6a09f21dd1e2 ("ideapad: add ACPI helpers")
Cc: stable@vger.kernel.org
Tested-by: Eric Long <i@hack3r.moe>
Signed-off-by: Rong Zhang <i@rong.moe>
---
 drivers/platform/x86/ideapad-laptop.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/ideapad-laptop.c b/drivers/platform/x86/ideapad-laptop.c
index ede483573fe0..b5e4da6a6779 100644
--- a/drivers/platform/x86/ideapad-laptop.c
+++ b/drivers/platform/x86/ideapad-laptop.c
@@ -15,6 +15,7 @@
 #include <linux/bug.h>
 #include <linux/cleanup.h>
 #include <linux/debugfs.h>
+#include <linux/delay.h>
 #include <linux/device.h>
 #include <linux/dmi.h>
 #include <linux/i8042.h>
@@ -267,6 +268,20 @@ static void ideapad_shared_exit(struct ideapad_private *priv)
  */
 #define IDEAPAD_EC_TIMEOUT 200 /* in ms */
 
+/*
+ * Some models (e.g., ThinkBook since 2024) have a low tolerance for being
+ * polled too frequently. Doing so may break the state machine in the EC,
+ * resulting in a hard shutdown.
+ *
+ * It is also observed that frequent polls may disturb the ongoing operation
+ * and notably delay the availability of EC response.
+ *
+ * These values are used as the delay before the first poll and the interval
+ * between subsequent polls to solve the above issues.
+ */
+#define IDEAPAD_EC_POLL_MIN_US 150
+#define IDEAPAD_EC_POLL_MAX_US 300
+
 static int eval_int(acpi_handle handle, const char *name, unsigned long *res)
 {
 	unsigned long long result;
@@ -383,7 +398,7 @@ static int read_ec_data(acpi_handle handle, unsigned long cmd, unsigned long *da
 	end_jiffies = jiffies + msecs_to_jiffies(IDEAPAD_EC_TIMEOUT) + 1;
 
 	while (time_before(jiffies, end_jiffies)) {
-		schedule();
+		usleep_range(IDEAPAD_EC_POLL_MIN_US, IDEAPAD_EC_POLL_MAX_US);
 
 		err = eval_vpcr(handle, 1, &val);
 		if (err)
@@ -414,7 +429,7 @@ static int write_ec_cmd(acpi_handle handle, unsigned long cmd, unsigned long dat
 	end_jiffies = jiffies + msecs_to_jiffies(IDEAPAD_EC_TIMEOUT) + 1;
 
 	while (time_before(jiffies, end_jiffies)) {
-		schedule();
+		usleep_range(IDEAPAD_EC_POLL_MIN_US, IDEAPAD_EC_POLL_MAX_US);
 
 		err = eval_vpcr(handle, 1, &val);
 		if (err)

base-commit: a5806cd506af5a7c19bcd596e4708b5c464bfd21
-- 
2.49.0


