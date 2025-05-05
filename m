Return-Path: <stable+bounces-139625-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B0A0AA8D9D
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 09:56:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6A2CF7A2433
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 07:54:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A95111E5B7D;
	Mon,  5 May 2025 07:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1sPJ85r6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68C531A2393
	for <stable@vger.kernel.org>; Mon,  5 May 2025 07:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746431725; cv=none; b=QmCF6mfbbFl36DvcuHuT3Q+UCUSGfHDYRDMCdIGvENcNCt2rP8mS6DgrTuVwKYLqIifan2RLLrdbXcdRQ/ehQILsleWAIAJe3u3a1lAfArDWC04sEfWzR+0SDab9JIQAlLfN9pBfpSNb15sh1JSH0AGqs1konmCrcaPFKz4NxRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746431725; c=relaxed/simple;
	bh=8A4QKA8PJ9cIwudQhZzjdT/KhdQmbcK7SoPuE9w7fuA=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Gf6cYoH0tPyG4spRv7LrQiPUto8MJGji/nFzoRuT+GdNzTRyvqAfG17oBZCy6VyxJCzTr6bvlNzbR0hwcITtVE81UPR4llyT8da6VoouTyJmpZcO0ZM+kfPDGa4QEhLAYcZvsjb+pv/KJYAdbh4VBBjWjxZL8HopQDQSVJ8QV90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1sPJ85r6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B488C4CEF2;
	Mon,  5 May 2025 07:55:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1746431724;
	bh=8A4QKA8PJ9cIwudQhZzjdT/KhdQmbcK7SoPuE9w7fuA=;
	h=Subject:To:Cc:From:Date:From;
	b=1sPJ85r6Cy27VnksjK5zgu5OjM2z2nw+42RwdDlWFkeqyxqKvwqFYIdhC7P9jWq8Q
	 j//VqYY9NinLh4Du5tAeuJ54r+COo80a9OX0fLO5djUZr+gVpDvrODNKN9ofIM9w/K
	 Xc2F0T/B8iNuZGLNg8j6MOVmk4EVfHHbL0BQoehE=
Subject: FAILED: patch "[PATCH] platform/x86: alienware-wmi-wmax: Add support for Alienware" failed to apply to 5.15-stable tree
To: kuurtb@gmail.com,ilpo.jarvinen@linux.intel.com,romain.thery@ik.me
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 05 May 2025 09:54:59 +0200
Message-ID: <2025050559-nappy-trouble-9e98@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 246f9bb62016c423972ea7f2335a8e0ed3521cde
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025050559-nappy-trouble-9e98@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 246f9bb62016c423972ea7f2335a8e0ed3521cde Mon Sep 17 00:00:00 2001
From: Kurt Borja <kuurtb@gmail.com>
Date: Sat, 19 Apr 2025 12:45:29 -0300
Subject: [PATCH] platform/x86: alienware-wmi-wmax: Add support for Alienware
 m15 R7
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Extend thermal control support to Alienware m15 R7.

Cc: stable@vger.kernel.org
Tested-by: Romain THERY <romain.thery@ik.me>
Signed-off-by: Kurt Borja <kuurtb@gmail.com>
Link: https://lore.kernel.org/r/20250419-m15-r7-v1-1-18c6eaa27e25@gmail.com
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

diff --git a/drivers/platform/x86/dell/alienware-wmi-wmax.c b/drivers/platform/x86/dell/alienware-wmi-wmax.c
index 3f9e1e986ecf..08b82c151e07 100644
--- a/drivers/platform/x86/dell/alienware-wmi-wmax.c
+++ b/drivers/platform/x86/dell/alienware-wmi-wmax.c
@@ -69,6 +69,14 @@ static const struct dmi_system_id awcc_dmi_table[] __initconst = {
 		},
 		.driver_data = &generic_quirks,
 	},
+	{
+		.ident = "Alienware m15 R7",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Alienware"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Alienware m15 R7"),
+		},
+		.driver_data = &generic_quirks,
+	},
 	{
 		.ident = "Alienware m16 R1",
 		.matches = {


