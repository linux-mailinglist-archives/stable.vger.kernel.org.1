Return-Path: <stable+bounces-155153-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 41DBAAE1E45
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 17:14:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B99F65A1CF0
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 15:14:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F4DD29617F;
	Fri, 20 Jun 2025 15:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="b7B41U7T"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CB2528937B
	for <stable@vger.kernel.org>; Fri, 20 Jun 2025 15:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750432479; cv=none; b=FYrvY4Q9Ae+mnicWo7/38ZTLfaIbn5fTPGOTIe2+5jtERd/VT76+go06lgzjt04CK5MEycbMo06YArLrIsGaKdM8eV+XMUCNXFJc5D7C7k3l+PLUkOzeUAVW3IyTWa3LG9pCYRgFg3emtwqucfcWJ2ygL//QGGiF9HTy7lHEYk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750432479; c=relaxed/simple;
	bh=Ode0dH7L6WDThU/THRmAKezyL105XUiYuuN7c4outA8=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=rLjDBBsLrtk1TuTjMIZEVX3nONdB3imNH9+UdFGmmXoJ4fzK/IIe956J2uwccYmlnkVDKaS4Z2/KukYtYsTKDiaSKSAWDDcrXstCqoHyWHSMNk5M6MV655dkTfGF/e6xUAaGWoL+21JEQTTMaEZ8Okie4a1bo0/8kAlkIochA7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=b7B41U7T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B006DC4CEF0;
	Fri, 20 Jun 2025 15:14:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750432479;
	bh=Ode0dH7L6WDThU/THRmAKezyL105XUiYuuN7c4outA8=;
	h=Subject:To:Cc:From:Date:From;
	b=b7B41U7TBbJq+wm5/xJOgCNkvkio+gHtH9uf8VlEI7Koqd+j4lmufLHBnmo3kW0zR
	 IOFA6ceeMZPBEmaaGvffnx708A8RmXB+H7py4lu+7o0qpSXGST5DmhoqprV9xMreCq
	 Vuk4PkrPePLsQZ25dNkJBZCDVPZy2zpkvR43a3h8=
Subject: FAILED: patch "[PATCH] platform/x86: ideapad-laptop: use usleep_range() for EC" failed to apply to 6.1-stable tree
To: i@rong.moe,Emmet_Z@outlook.com,felixonmars@archlinux.org,i@hack3r.moe,ilpo.jarvinen@linux.intel.com,jeffbai@aosc.io,minhld139@gmail.com,zhangjianfei3@gmail.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 20 Jun 2025 17:14:34 +0200
Message-ID: <2025062034-morbidity-saddling-e68c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 5808c34216954cd832bd4b8bc52dfa287049122b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025062034-morbidity-saddling-e68c@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

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


