Return-Path: <stable+bounces-134840-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7577A95265
	for <lists+stable@lfdr.de>; Mon, 21 Apr 2025 16:03:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09C1317337F
	for <lists+stable@lfdr.de>; Mon, 21 Apr 2025 14:03:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B3D7800;
	Mon, 21 Apr 2025 14:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="v46kify2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 097C423B0
	for <stable@vger.kernel.org>; Mon, 21 Apr 2025 14:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745244224; cv=none; b=lP7hjPadTDcyQOCCuNm68SqhEuDVc4OsOgYmyetloPR8zmpDnARDdE3z+s02WzaoBErio0DxrqIK90Mp7dZi8gZu3gnfUhyABf3h8OGk6aPNK5bkGOfDiVmadChGgkKIgk/Edn7xdtU5vm5uEP3732cOUupe3i6lgzxNWNEIPTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745244224; c=relaxed/simple;
	bh=hQnHTEDs5emEmeLuU6sFlZ3MKNnZl3SCHEPUI3ueh6I=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=fSz0lOUAAv9wAeKVkpbsZGUW2i1DLzWZhPtHOu6J4TNj6rYyJdmaAQoGqkAahJS5hYG3n9GEjUzA0rpP/P1yutKA8Ku6L0i8YGnhA7sR9dvUdKpX4lfM0Tpgrr+IgGkY9+9AV7Vb0vOCvUs6XPgumlgYwuDaTV1wUddTu3LDATk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=v46kify2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29C5DC4CEE4;
	Mon, 21 Apr 2025 14:03:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745244223;
	bh=hQnHTEDs5emEmeLuU6sFlZ3MKNnZl3SCHEPUI3ueh6I=;
	h=Subject:To:Cc:From:Date:From;
	b=v46kify2uLZ+/YqMcqBAThphIwLOsHTPPEnJL6pg9SjHRiR8Zsq9arSwa2mqxJ5cx
	 VIcNxPocNm+ZMtysdXb4ioCbYFb63bS9lu3sAdnqscLyRDjcCR9mx7+xTeO8gO2FhI
	 6bowwKtQVmkUqydvac4grb3VRIjG8MSceZMevJ5o=
Subject: FAILED: patch "[PATCH] platform/x86: alienware-wmi-wmax: Add G-Mode support to" failed to apply to 6.12-stable tree
To: kuurtb@gmail.com,ilpo.jarvinen@linux.intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 21 Apr 2025 16:03:30 +0200
Message-ID: <2025042130-gothic-grazing-a9c7@gregkh>
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
git cherry-pick -x 5ff79cabb23a2f14d2ed29e9596aec908905a0e6
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025042130-gothic-grazing-a9c7@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

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


