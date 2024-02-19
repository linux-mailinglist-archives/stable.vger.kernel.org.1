Return-Path: <stable+bounces-20732-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87E7C85AB91
	for <lists+stable@lfdr.de>; Mon, 19 Feb 2024 19:53:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9278CB21983
	for <lists+stable@lfdr.de>; Mon, 19 Feb 2024 18:53:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D88B482C0;
	Mon, 19 Feb 2024 18:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rO/vCfAk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44E8441A81
	for <stable@vger.kernel.org>; Mon, 19 Feb 2024 18:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708368827; cv=none; b=gwDNgeUcW7t14hQndMbPSjdv8TO/fUbBz76LpaiHm6/ECbmDX3lYeT5KtBpojpUHkdV4XtILJeN6GtoQdywoiUzzevgmqzwu/L3gvuu2ODoJaKBJO2ClEcCHD2DwvnyG+d6JZhXjJn3D0GWxuK9+jYZpDB0tjoBPrAEF2FZgczY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708368827; c=relaxed/simple;
	bh=C2W4GmbcQ93Kz/kshEkZ11RaowYQP24lhl8aUCIMN78=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=g7so6/EZU2AAdsThlj3GEmrYDOlGpnIpH9QXWR+cHmm61c867GgEITPDFUrkyNqd7rTtmRtcWzTEHfYRWvQWcLdlEWsSesZQlccA9gdKOKrp4ZG2I5/QpoSSHdJFOVzAo0f/xPUFq9U89LDlqa17+nF5owDAjtuPvuV3UyzQfS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rO/vCfAk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A98BBC433C7;
	Mon, 19 Feb 2024 18:53:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708368827;
	bh=C2W4GmbcQ93Kz/kshEkZ11RaowYQP24lhl8aUCIMN78=;
	h=Subject:To:Cc:From:Date:From;
	b=rO/vCfAkGenOJZMGLrsa6K0XDCEVwHqLTrl6+dSvJ3lfcYbnTbZ8UjBoQGNZEDG9x
	 BYROYMQFeN4QXppuMk4JSNlncxx65ID2TLkMlD41fgEvlOaAaKTTkpeCb7S5KHN6Kk
	 To8QBQoZVd8m6kXBZrWfzaqESYkMNJdq1bWE+Ldw=
Subject: FAILED: patch "[PATCH] hwmon: (coretemp) Fix out-of-bounds memory access" failed to apply to 6.1-stable tree
To: rui.zhang@intel.com,linux@roeck-us.net,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 19 Feb 2024 19:53:38 +0100
Message-ID: <2024021938-relieving-boneless-4cca@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 4e440abc894585a34c2904a32cd54af1742311b3
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024021938-relieving-boneless-4cca@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

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


