Return-Path: <stable+bounces-134837-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C2F50A95262
	for <lists+stable@lfdr.de>; Mon, 21 Apr 2025 16:03:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85F6F18941D7
	for <lists+stable@lfdr.de>; Mon, 21 Apr 2025 14:03:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E683C26AD9;
	Mon, 21 Apr 2025 14:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xDMvMYDr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A60D1800
	for <stable@vger.kernel.org>; Mon, 21 Apr 2025 14:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745244215; cv=none; b=RGkPzrtuC/MWbbXakKQdCe25smGwtg1kW58DRDhCV2mVYglytPLy6WoMtWbX8IciKDIhmQwWAgBC1PpyzP1CfgzhEYBY2CiQn8RlFZ07AL0k994s2cRdacSbbhj8g5f0L4L7ELFn/n0sUnUl+b9VVhVHevZ5w7RXKl8HkAiBjJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745244215; c=relaxed/simple;
	bh=U9gvo7soiWPcPMV1WTh63zrQbE1xhnc8RAO0BDUV1es=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=SSkiJA9Td4Y5WIxce+8UEFJd9Yc7Ok85Im+DEgn+K/UE1KzolkAQxvEq06+PjNF1M+JVj+5t9Fq7k9JrEtJXrR8PDk5/32V/KV/Vgnh0pYGLVhwp465YLal5OIE4U+sD1tNrLc1Z6X61QTK5H6MwwPwOFlpZfwXoNUCOXYn4BFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xDMvMYDr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB0A4C4CEE4;
	Mon, 21 Apr 2025 14:03:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745244215;
	bh=U9gvo7soiWPcPMV1WTh63zrQbE1xhnc8RAO0BDUV1es=;
	h=Subject:To:Cc:From:Date:From;
	b=xDMvMYDrDIBdmvNwWGKUeTlikJJ2SjWzSM2Fe4NkYIcV9gGG+j+tboCXZ08w9J95f
	 F7AhdZ/ZXH1WWaSxvffiLwYj8puVAFqWRTQ8brS2ZxUINJYiJqehrm2ckeIAS6kVvP
	 2gnWnvuP5ukDxiREd1u6iNL01e8EyMdBzxHzyZLU=
Subject: FAILED: patch "[PATCH] platform/x86: alienware-wmi-wmax: Extend support to more" failed to apply to 6.6-stable tree
To: kuurtb@gmail.com,ilpo.jarvinen@linux.intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 21 Apr 2025 16:03:25 +0200
Message-ID: <2025042125-modulator-obstacle-0076@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 202a861205905629c5f10ce0a8358623485e1ae9
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025042125-modulator-obstacle-0076@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

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


