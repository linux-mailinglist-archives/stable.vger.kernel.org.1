Return-Path: <stable+bounces-134838-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B264A95263
	for <lists+stable@lfdr.de>; Mon, 21 Apr 2025 16:03:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF6753AD106
	for <lists+stable@lfdr.de>; Mon, 21 Apr 2025 14:03:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A2F325634;
	Mon, 21 Apr 2025 14:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IgS0O+6V"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4C3418B03
	for <stable@vger.kernel.org>; Mon, 21 Apr 2025 14:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745244218; cv=none; b=t3ZytS1AvY5p9MRMR6n/hQwwWdD0vYsFb4+g5sVFYGBiAGvs4Jhbu6iMDx5ZtjuEt8b9q2MKuD6xsC359O/0h6C/msKYgJdaPLpT3p3hDf6jugbBgUVzDIJoDNW/EddULuXyHir7aIWNvEieyqrIdLSNrSY/LBMMk7Dl7mXNWAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745244218; c=relaxed/simple;
	bh=ON0d90f5kBUO0VxNelEkDErDplsF5cakMCzVEFl4B+4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ZTYSvUxPMOoCPA/6c0iqrLgcJx5Bvtr/lpj6ZdDQcz/PY47YtWDyuPEX1/OGoXJNfUOyQbtRc0x0zmc6MGqPUQjSoerJ18llnfoG0RpU4V0uYnfyPwpWJC+bgfB7+guliqeIXAvQr31D+GF8fchHhskDkg2hekHqEBBBVF6gs+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IgS0O+6V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77237C4CEE4;
	Mon, 21 Apr 2025 14:03:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745244217;
	bh=ON0d90f5kBUO0VxNelEkDErDplsF5cakMCzVEFl4B+4=;
	h=Subject:To:Cc:From:Date:From;
	b=IgS0O+6VQm87hJC6BpPrerTBascx6IeWs576G4y1QPDNHhIvTPEfGEkrloGFlSHAr
	 JRKwwW1FOA40lr5bRQ0H5EpEmZSCMH7Y9qBeqOQ4qO4PJcl+M3ZPqJPOoJnozO/NQh
	 +S8GBElqvnr796romr5ss+WdVpft+LWnRNImI6oQ=
Subject: FAILED: patch "[PATCH] platform/x86: alienware-wmi-wmax: Add G-Mode support to" failed to apply to 6.14-stable tree
To: kuurtb@gmail.com,ilpo.jarvinen@linux.intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 21 Apr 2025 16:03:29 +0200
Message-ID: <2025042129-reliance-rewrap-6d6b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.14-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.14.y
git checkout FETCH_HEAD
git cherry-pick -x 5ff79cabb23a2f14d2ed29e9596aec908905a0e6
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025042129-reliance-rewrap-6d6b@gregkh' --subject-prefix 'PATCH 6.14.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 5ff79cabb23a2f14d2ed29e9596aec908905a0e6 Mon Sep 17 00:00:00 2001
From: Kurt Borja <kuurtb@gmail.com>
Date: Fri, 11 Apr 2025 11:14:35 -0300
Subject: [PATCH] platform/x86: alienware-wmi-wmax: Add G-Mode support to
 Alienware m16 R1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Some users report the Alienware m16 R1 models, support G-Mode. This was
manually verified by inspecting their ACPI tables.

Cc: stable@vger.kernel.org
Signed-off-by: Kurt Borja <kuurtb@gmail.com>
Link: https://lore.kernel.org/r/20250411-awcc-support-v1-1-09a130ec4560@gmail.com
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

diff --git a/drivers/platform/x86/dell/alienware-wmi-wmax.c b/drivers/platform/x86/dell/alienware-wmi-wmax.c
index 3d3014b5adf0..5b6a0c866be2 100644
--- a/drivers/platform/x86/dell/alienware-wmi-wmax.c
+++ b/drivers/platform/x86/dell/alienware-wmi-wmax.c
@@ -67,7 +67,7 @@ static const struct dmi_system_id awcc_dmi_table[] __initconst = {
 			DMI_MATCH(DMI_SYS_VENDOR, "Alienware"),
 			DMI_MATCH(DMI_PRODUCT_NAME, "Alienware m16 R1 AMD"),
 		},
-		.driver_data = &generic_quirks,
+		.driver_data = &g_series_quirks,
 	},
 	{
 		.ident = "Alienware m17 R5",


