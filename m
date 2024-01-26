Return-Path: <stable+bounces-15939-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4984983E4CF
	for <lists+stable@lfdr.de>; Fri, 26 Jan 2024 23:11:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A783E286A18
	for <lists+stable@lfdr.de>; Fri, 26 Jan 2024 22:11:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E381A250E8;
	Fri, 26 Jan 2024 22:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EKytL/J7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A328F24B5B
	for <stable@vger.kernel.org>; Fri, 26 Jan 2024 22:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706306975; cv=none; b=gfnl+TLJtJTX7Afe1c12vSjWuPBK7Wn51WWjpSwGkacmk0Jew36CFLR+XU6VTGWh/VoeCVUrJZROU5dO33jISTN+j8tDa7OND6F6KpZuU30Loyc/wC+ucoqqGPfluYVvkE52zK/y92BI/tRlz2iwrY3ojtmGi4e92Ht+DYxVUWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706306975; c=relaxed/simple;
	bh=isky8ePgYg8YtwL81nsN2ImiKKjGVwuXD7iQdbmdOzQ=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=so3YXiUOrp4wTO6roK/uFA0yA5ATrNkj/Hm4AojwuLlnqIPJhVriJ1NG49khFCJAgQCxIy1tlw3G9arr/Vn8HDZ4P4xUcxbL/DWwmzHBchQhb4KXOvfZ5lHUOWVrz2VfNk83gnKW6W3nfwbSv9XG38+7WYCx/vTrfSQIW0VKpcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=EKytL/J7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68720C41674;
	Fri, 26 Jan 2024 22:09:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706306975;
	bh=isky8ePgYg8YtwL81nsN2ImiKKjGVwuXD7iQdbmdOzQ=;
	h=Subject:To:Cc:From:Date:From;
	b=EKytL/J7Z2bhnB7Kwurv+Oz5KfzEW7t8+pWNfQiEdHszX0+dOM0iIrk0j9hSmE88L
	 TJXSnHCWvptPP2uSTfb+4Q4QOqR+kKi49opgIrG1lmZMmEUqpiJ6kEKpQP+hVCEPAq
	 nF+XCLKRMVpCKZKukuddVHQsLh0i59J72POaF1cc=
Subject: FAILED: patch "[PATCH] PM / devfreq: Fix buffer overflow in trans_stat_show" failed to apply to 5.10-stable tree
To: ansuelsmth@gmail.com,cw00.choi@samsung.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 26 Jan 2024 14:09:34 -0800
Message-ID: <2024012634-unbounded-bullfight-568f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 08e23d05fa6dc4fc13da0ccf09defdd4bbc92ff4
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024012634-unbounded-bullfight-568f@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:

08e23d05fa6d ("PM / devfreq: Fix buffer overflow in trans_stat_show")
b5d281f6c16d ("PM / devfreq: Rework freq_table to be local to devfreq struct")
05723e71234b ("PM / devfreq: passive: Reduce duplicate code when passive_devfreq case")
8c37d01e1a86 ("PM / devfreq: passive: Fix get_target_freq when not using required-opp")
86ad9a24f21e ("PM / devfreq: Add required OPPs support to passive governor")
5f1a9066fcb2 ("PM / devfreq: Add governor attribute flag for specifc sysfs nodes")
0dd25a0d12a1 ("PM / devfreq: Add governor feature flag")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 08e23d05fa6dc4fc13da0ccf09defdd4bbc92ff4 Mon Sep 17 00:00:00 2001
From: Christian Marangi <ansuelsmth@gmail.com>
Date: Tue, 24 Oct 2023 20:30:15 +0200
Subject: [PATCH] PM / devfreq: Fix buffer overflow in trans_stat_show

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

diff --git a/Documentation/ABI/testing/sysfs-class-devfreq b/Documentation/ABI/testing/sysfs-class-devfreq
index 5e6b74f30406..1e7e0bb4c14e 100644
--- a/Documentation/ABI/testing/sysfs-class-devfreq
+++ b/Documentation/ABI/testing/sysfs-class-devfreq
@@ -52,6 +52,9 @@ Description:
 
 			echo 0 > /sys/class/devfreq/.../trans_stat
 
+		If the transition table is bigger than PAGE_SIZE, reading
+		this will return an -EFBIG error.
+
 What:		/sys/class/devfreq/.../available_frequencies
 Date:		October 2012
 Contact:	Nishanth Menon <nm@ti.com>
diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index b3a68d5833bd..907f50ab70ed 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -1688,7 +1688,7 @@ static ssize_t trans_stat_show(struct device *dev,
 			       struct device_attribute *attr, char *buf)
 {
 	struct devfreq *df = to_devfreq(dev);
-	ssize_t len;
+	ssize_t len = 0;
 	int i, j;
 	unsigned int max_state;
 
@@ -1697,7 +1697,7 @@ static ssize_t trans_stat_show(struct device *dev,
 	max_state = df->max_state;
 
 	if (max_state == 0)
-		return sprintf(buf, "Not Supported.\n");
+		return scnprintf(buf, PAGE_SIZE, "Not Supported.\n");
 
 	mutex_lock(&df->lock);
 	if (!df->stop_polling &&
@@ -1707,31 +1707,52 @@ static ssize_t trans_stat_show(struct device *dev,
 	}
 	mutex_unlock(&df->lock);
 
-	len = sprintf(buf, "     From  :   To\n");
-	len += sprintf(buf + len, "           :");
-	for (i = 0; i < max_state; i++)
-		len += sprintf(buf + len, "%10lu",
-				df->freq_table[i]);
+	len += scnprintf(buf + len, PAGE_SIZE - len, "     From  :   To\n");
+	len += scnprintf(buf + len, PAGE_SIZE - len, "           :");
+	for (i = 0; i < max_state; i++) {
+		if (len >= PAGE_SIZE - 1)
+			break;
+		len += scnprintf(buf + len, PAGE_SIZE - len, "%10lu",
+				 df->freq_table[i]);
+	}
+	if (len >= PAGE_SIZE - 1)
+		return PAGE_SIZE - 1;
 
-	len += sprintf(buf + len, "   time(ms)\n");
+	len += scnprintf(buf + len, PAGE_SIZE - len, "   time(ms)\n");
 
 	for (i = 0; i < max_state; i++) {
+		if (len >= PAGE_SIZE - 1)
+			break;
 		if (df->freq_table[i] == df->previous_freq)
-			len += sprintf(buf + len, "*");
+			len += scnprintf(buf + len, PAGE_SIZE - len, "*");
 		else
-			len += sprintf(buf + len, " ");
+			len += scnprintf(buf + len, PAGE_SIZE - len, " ");
+		if (len >= PAGE_SIZE - 1)
+			break;
+
+		len += scnprintf(buf + len, PAGE_SIZE - len, "%10lu:",
+				 df->freq_table[i]);
+		for (j = 0; j < max_state; j++) {
+			if (len >= PAGE_SIZE - 1)
+				break;
+			len += scnprintf(buf + len, PAGE_SIZE - len, "%10u",
+					 df->stats.trans_table[(i * max_state) + j]);
+		}
+		if (len >= PAGE_SIZE - 1)
+			break;
+		len += scnprintf(buf + len, PAGE_SIZE - len, "%10llu\n", (u64)
+				 jiffies64_to_msecs(df->stats.time_in_state[i]));
+	}
 
-		len += sprintf(buf + len, "%10lu:", df->freq_table[i]);
-		for (j = 0; j < max_state; j++)
-			len += sprintf(buf + len, "%10u",
-				df->stats.trans_table[(i * max_state) + j]);
+	if (len < PAGE_SIZE - 1)
+		len += scnprintf(buf + len, PAGE_SIZE - len, "Total transition : %u\n",
+				 df->stats.total_trans);
 
-		len += sprintf(buf + len, "%10llu\n", (u64)
-			jiffies64_to_msecs(df->stats.time_in_state[i]));
+	if (len >= PAGE_SIZE - 1) {
+		pr_warn_once("devfreq transition table exceeds PAGE_SIZE. Disabling\n");
+		return -EFBIG;
 	}
 
-	len += sprintf(buf + len, "Total transition : %u\n",
-					df->stats.total_trans);
 	return len;
 }
 


