Return-Path: <stable+bounces-155155-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 87739AE1E47
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 17:14:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C61A179FE4
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 15:14:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87FA82BF3D8;
	Fri, 20 Jun 2025 15:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2pqmiKsj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4014328937B
	for <stable@vger.kernel.org>; Fri, 20 Jun 2025 15:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750432485; cv=none; b=XOJiH/Ro88e3bq8IRx5lTuLLpDyXaWSqWrZlPzqbG6S8u0tWakmAsdLvVxgInmmXkyJKEI9s4bavxKiVnUw7Y/B2DYRC6c80oPJahXuKQ2cg9g9IBh6Nl5HYVnPT+1aBuav4ZMY4bUd87sXTsFP7o0wJxnOWjvMyl8hqN9NCzNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750432485; c=relaxed/simple;
	bh=yDuEmY2fkWV+wHIT/Gpjtxh/MdVxBodQBeiJijYTtp8=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=oQ/TA7bP5kz239e12+mLeH4In4ADRMrn+uAgL+12HFJ9xe0dSpKX5JGknvdAENNgSiyhz67bS3H/9DbJyI64c3v5Upi0zG7bZreBEAxTZna/VtsPq3gD4ebv4IXUJW1MTczy7LJbWBCdlKyrbbNA0yxJ6BtkcrE34z3ZBn2LhUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2pqmiKsj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80EB1C4CEF1;
	Fri, 20 Jun 2025 15:14:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750432484;
	bh=yDuEmY2fkWV+wHIT/Gpjtxh/MdVxBodQBeiJijYTtp8=;
	h=Subject:To:Cc:From:Date:From;
	b=2pqmiKsjWzJaQxn66BXfMoBMfM9AHzFrV/xQKQ0BrdY4f2RUhjJRReKLyLTufbRG5
	 smyHu7axwZ61ezx9+4ZYEYh1+bLytnUleou9XD4OcX2NqNPN+6MvB4L0WerdynjuOm
	 BLNBCtPzLz84hV23GEL6izKxvZ/n0n4G/PCuPseM=
Subject: FAILED: patch "[PATCH] platform/x86: ideapad-laptop: use usleep_range() for EC" failed to apply to 5.10-stable tree
To: i@rong.moe,Emmet_Z@outlook.com,felixonmars@archlinux.org,i@hack3r.moe,ilpo.jarvinen@linux.intel.com,jeffbai@aosc.io,minhld139@gmail.com,zhangjianfei3@gmail.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 20 Jun 2025 17:14:36 +0200
Message-ID: <2025062036-chihuahua-antidote-eca5@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 5808c34216954cd832bd4b8bc52dfa287049122b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025062036-chihuahua-antidote-eca5@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 5808c34216954cd832bd4b8bc52dfa287049122b Mon Sep 17 00:00:00 2001
From: Rong Zhang <i@rong.moe>
Date: Mon, 26 May 2025 04:18:07 +0800
Subject: [PATCH] platform/x86: ideapad-laptop: use usleep_range() for EC
 polling
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

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
Tested-by: Felix Yan <felixonmars@archlinux.org>
Tested-by: Eric Long <i@hack3r.moe>
Tested-by: Jianfei Zhang <zhangjianfei3@gmail.com>
Tested-by: Mingcong Bai <jeffbai@aosc.io>
Tested-by: Minh Le <minhld139@gmail.com>
Tested-by: Sicheng Zhu <Emmet_Z@outlook.com>
Signed-off-by: Rong Zhang <i@rong.moe>
Link: https://lore.kernel.org/r/20250525201833.37939-1-i@rong.moe
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

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


