Return-Path: <stable+bounces-20730-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 412CA85AB8F
	for <lists+stable@lfdr.de>; Mon, 19 Feb 2024 19:53:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 716A11C21BF7
	for <lists+stable@lfdr.de>; Mon, 19 Feb 2024 18:53:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B4434A3B;
	Mon, 19 Feb 2024 18:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="iUuD+X+U"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4B8541A82
	for <stable@vger.kernel.org>; Mon, 19 Feb 2024 18:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708368821; cv=none; b=XPfruvk8HJBdByb+JBcl6mRiSBIbNIQMa6pvmjBwrRzVpK5dl75+ggYeGz+vCi9z9OWINDuFKGa3CFXIyectKmVfllEmgNgh6imldnaZ5v/xD19q6bna9ykp6+8AzukbYNH1VjI+CekgneEBlMvE81qb1MBRFSWG6dtZPZdHSB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708368821; c=relaxed/simple;
	bh=ilDw7v0hX8W6Q9mbII7GKwpwIU5Ax/EU+UqZemPhwFQ=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=R0v8EcHWls2K4IQEvJJswUjy2AXvCwYCrDj62MuSnF5N0Cu86JNyBzShs6s+c/wdTFX787sCYKTZvduLnT+zWofT+VyGGFpTkDYBhJuSUgU1HHc1BRiIQD5v/P16NrMRE1dJllNPn1bapkuLuWpK9JgOIlTMgVDoJJF264WAtEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=iUuD+X+U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 783C8C433C7;
	Mon, 19 Feb 2024 18:53:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708368819;
	bh=ilDw7v0hX8W6Q9mbII7GKwpwIU5Ax/EU+UqZemPhwFQ=;
	h=Subject:To:Cc:From:Date:From;
	b=iUuD+X+UWW1XX26NsBDEvxA6PrnZR4iOPoe6+p6gKOqwFGLkUdE4sGyz1gKj7ZJ7/
	 hm5WE8YzZgHmnGF8vBF6zVzEAG2ebfNcb05Z2GTtJr0TKmcoJ19K6KGH5HYW/v8qF/
	 w9LDiDS/cQknmPTMhCB2yoFKlP7I/3aeZFKlcQBg=
Subject: FAILED: patch "[PATCH] hwmon: (coretemp) Fix out-of-bounds memory access" failed to apply to 6.7-stable tree
To: rui.zhang@intel.com,linux@roeck-us.net,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 19 Feb 2024 19:53:37 +0100
Message-ID: <2024021936-mulch-prone-c0a6@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.7-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.7.y
git checkout FETCH_HEAD
git cherry-pick -x 4e440abc894585a34c2904a32cd54af1742311b3
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024021936-mulch-prone-c0a6@gregkh' --subject-prefix 'PATCH 6.7.y' HEAD^..

Possible dependencies:

4e440abc8945 ("hwmon: (coretemp) Fix out-of-bounds memory access")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 4e440abc894585a34c2904a32cd54af1742311b3 Mon Sep 17 00:00:00 2001
From: Zhang Rui <rui.zhang@intel.com>
Date: Fri, 2 Feb 2024 17:21:34 +0800
Subject: [PATCH] hwmon: (coretemp) Fix out-of-bounds memory access

Fix a bug that pdata->cpu_map[] is set before out-of-bounds check.
The problem might be triggered on systems with more than 128 cores per
package.

Fixes: 7108b80a542b ("hwmon/coretemp: Handle large core ID value")
Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Cc: <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/20240202092144.71180-2-rui.zhang@intel.com
Signed-off-by: Guenter Roeck <linux@roeck-us.net>

diff --git a/drivers/hwmon/coretemp.c b/drivers/hwmon/coretemp.c
index ba82d1e79c13..e78c76919111 100644
--- a/drivers/hwmon/coretemp.c
+++ b/drivers/hwmon/coretemp.c
@@ -509,18 +509,14 @@ static int create_core_data(struct platform_device *pdev, unsigned int cpu,
 	if (pkg_flag) {
 		attr_no = PKG_SYSFS_ATTR_NO;
 	} else {
-		index = ida_alloc(&pdata->ida, GFP_KERNEL);
+		index = ida_alloc_max(&pdata->ida, NUM_REAL_CORES - 1, GFP_KERNEL);
 		if (index < 0)
 			return index;
+
 		pdata->cpu_map[index] = topology_core_id(cpu);
 		attr_no = index + BASE_SYSFS_ATTR_NO;
 	}
 
-	if (attr_no > MAX_CORE_DATA - 1) {
-		err = -ERANGE;
-		goto ida_free;
-	}
-
 	tdata = init_temp_data(cpu, pkg_flag);
 	if (!tdata) {
 		err = -ENOMEM;


