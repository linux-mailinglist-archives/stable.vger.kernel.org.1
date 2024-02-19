Return-Path: <stable+bounces-20736-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A538685AB95
	for <lists+stable@lfdr.de>; Mon, 19 Feb 2024 19:54:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 461ED1F23507
	for <lists+stable@lfdr.de>; Mon, 19 Feb 2024 18:54:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49E5C433BD;
	Mon, 19 Feb 2024 18:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="L1xoFb00"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B857566B
	for <stable@vger.kernel.org>; Mon, 19 Feb 2024 18:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708368841; cv=none; b=JGAK6T5r1Nsh9u0NXZAdASrjxmc2p7LV5zS1tS2U7Rkd6T476a2eUWef3Iix/MOv3aa9zhQ8e0xF3V89+nJBBHs75qojwsUQYRrKQ2DAxLhte9Iw8xDaTcyoi1JP6Qp4B7lXrqgwoUhbOfpTX4fCcVeYiZAd4O/RqiYcKNokudw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708368841; c=relaxed/simple;
	bh=IyFeGRC9FCg23DwpEoJry4Wez6TMECEJA7GDCtR2BlU=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=LH8oLAyo8HcAa8OGvMdTZkn2Ab2Kf8D4aunCf3BE2I52ynzejPOR7kRvnAWRhh3A8Nzfcgr4IXxcOkM9RejlbPIZhB6ItVeTFz6DhBQ69pVYwuNSj0D7eocJEIXeq6H4hI5C6f4dwCplCa40phaSR+nvyriCFpcHG/vMxorRXts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=L1xoFb00; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A168C433F1;
	Mon, 19 Feb 2024 18:53:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708368840;
	bh=IyFeGRC9FCg23DwpEoJry4Wez6TMECEJA7GDCtR2BlU=;
	h=Subject:To:Cc:From:Date:From;
	b=L1xoFb00Yb1lPsvytu8Frjj0t70I1svfYVO37rp9S4Kk5ZznUn04FAIBEQXPWVdhf
	 NwDi0SWduH9IoCXSrKq7i/VMKN/mbZQvRc3ZYy5Dmy4KW0pd/t9dvMsDaa59v4Shto
	 cdqgK265GgJtul0I9fKxenodXVxheQrGgTQ+ehfw=
Subject: FAILED: patch "[PATCH] hwmon: (coretemp) Fix out-of-bounds memory access" failed to apply to 4.19-stable tree
To: rui.zhang@intel.com,linux@roeck-us.net,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 19 Feb 2024 19:53:41 +0100
Message-ID: <2024021941-jelly-tubular-7919@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 4.19-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-4.19.y
git checkout FETCH_HEAD
git cherry-pick -x 4e440abc894585a34c2904a32cd54af1742311b3
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024021941-jelly-tubular-7919@gregkh' --subject-prefix 'PATCH 4.19.y' HEAD^..

Possible dependencies:

4e440abc8945 ("hwmon: (coretemp) Fix out-of-bounds memory access")
7108b80a542b ("hwmon/coretemp: Handle large core ID value")

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


