Return-Path: <stable+bounces-134836-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9515AA95261
	for <lists+stable@lfdr.de>; Mon, 21 Apr 2025 16:03:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E77018934D0
	for <lists+stable@lfdr.de>; Mon, 21 Apr 2025 14:03:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D897E250EC;
	Mon, 21 Apr 2025 14:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="r6cyHmCU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98FA418B03
	for <stable@vger.kernel.org>; Mon, 21 Apr 2025 14:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745244212; cv=none; b=f04q9arx6nIAfdBZJG4MQ/k5wIo5dZGKrOhyLFL0uUaYk+O9cxIWZ8DIK3EXwn15pfuY+QKJFustPeVJvopnlTqRx0+Js1Jkjwg04RUiyL6OzLq9XDMcMHLQk4zHmWRcjNNgefWXCjpw6khLFriPH0rh9VciIgA7lvk5JbLp0b8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745244212; c=relaxed/simple;
	bh=x66aWWJLsQta1ljSnhmMYDFtqn4Y/s8omweIjWVQFW4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ksvjfxqbyUYOO8wkegnRfNiuysKOTObbbbPOGwBnzBP/Intss7mF7rTTl4+RiPw1mJnzZdi+a0l4FBeF9oJw7aWbKsBbTDLLScuFpVP64hNYLku6OJV2io+VU2GAaNf5HGhzogApL9Kb47qJou3aLSjNzJW+teK9Ej8liyFrdkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=r6cyHmCU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01F04C4CEE4;
	Mon, 21 Apr 2025 14:03:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745244212;
	bh=x66aWWJLsQta1ljSnhmMYDFtqn4Y/s8omweIjWVQFW4=;
	h=Subject:To:Cc:From:Date:From;
	b=r6cyHmCU8KxrZhX5B2HQBG66/oEaISA7XEE6wFH+EfCVw55A7zI3NBWLMv7GARXmN
	 65lKDonG+OBrNtV1w62grYFoSDiuwy/AnDfc8uBNgEVZsFj6BO7cjrh4WAxyvwgWoY
	 CzmB2Qth/SBiP4zCMUtedWzKjV/7nGsYnGk0/CbM=
Subject: FAILED: patch "[PATCH] platform/x86: alienware-wmi-wmax: Extend support to more" failed to apply to 6.12-stable tree
To: kuurtb@gmail.com,ilpo.jarvinen@linux.intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 21 Apr 2025 16:03:24 +0200
Message-ID: <2025042124-stumble-unveiling-ee19@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 202a861205905629c5f10ce0a8358623485e1ae9
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025042124-stumble-unveiling-ee19@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 202a861205905629c5f10ce0a8358623485e1ae9 Mon Sep 17 00:00:00 2001
From: Kurt Borja <kuurtb@gmail.com>
Date: Fri, 11 Apr 2025 11:14:36 -0300
Subject: [PATCH] platform/x86: alienware-wmi-wmax: Extend support to more
 laptops
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Extend thermal control support to:

 - Alienware Area-51m R2
 - Alienware m16 R1
 - Alienware m16 R2
 - Dell G16 7630
 - Dell G5 5505 SE

Cc: stable@vger.kernel.org
Signed-off-by: Kurt Borja <kuurtb@gmail.com>
Link: https://lore.kernel.org/r/20250411-awcc-support-v1-2-09a130ec4560@gmail.com
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

diff --git a/drivers/platform/x86/dell/alienware-wmi-wmax.c b/drivers/platform/x86/dell/alienware-wmi-wmax.c
index 5b6a0c866be2..0c3be03385f8 100644
--- a/drivers/platform/x86/dell/alienware-wmi-wmax.c
+++ b/drivers/platform/x86/dell/alienware-wmi-wmax.c
@@ -61,6 +61,22 @@ static struct awcc_quirks generic_quirks = {
 static struct awcc_quirks empty_quirks;
 
 static const struct dmi_system_id awcc_dmi_table[] __initconst = {
+	{
+		.ident = "Alienware Area-51m R2",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Alienware"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Alienware Area-51m R2"),
+		},
+		.driver_data = &generic_quirks,
+	},
+	{
+		.ident = "Alienware m16 R1",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Alienware"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Alienware m16 R1"),
+		},
+		.driver_data = &g_series_quirks,
+	},
 	{
 		.ident = "Alienware m16 R1 AMD",
 		.matches = {
@@ -69,6 +85,14 @@ static const struct dmi_system_id awcc_dmi_table[] __initconst = {
 		},
 		.driver_data = &g_series_quirks,
 	},
+	{
+		.ident = "Alienware m16 R2",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Alienware"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Alienware m16 R2"),
+		},
+		.driver_data = &generic_quirks,
+	},
 	{
 		.ident = "Alienware m17 R5",
 		.matches = {
@@ -93,6 +117,14 @@ static const struct dmi_system_id awcc_dmi_table[] __initconst = {
 		},
 		.driver_data = &generic_quirks,
 	},
+	{
+		.ident = "Alienware x15 R2",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Alienware"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Alienware x15 R2"),
+		},
+		.driver_data = &generic_quirks,
+	},
 	{
 		.ident = "Alienware x17 R2",
 		.matches = {
@@ -125,6 +157,14 @@ static const struct dmi_system_id awcc_dmi_table[] __initconst = {
 		},
 		.driver_data = &g_series_quirks,
 	},
+	{
+		.ident = "Dell Inc. G16 7630",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Dell G16 7630"),
+		},
+		.driver_data = &g_series_quirks,
+	},
 	{
 		.ident = "Dell Inc. G3 3500",
 		.matches = {
@@ -149,6 +189,14 @@ static const struct dmi_system_id awcc_dmi_table[] __initconst = {
 		},
 		.driver_data = &g_series_quirks,
 	},
+	{
+		.ident = "Dell Inc. G5 5505",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "G5 5505"),
+		},
+		.driver_data = &g_series_quirks,
+	},
 };
 
 enum WMAX_THERMAL_INFORMATION_OPERATIONS {


