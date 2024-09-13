Return-Path: <stable+bounces-76066-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B58B978007
	for <lists+stable@lfdr.de>; Fri, 13 Sep 2024 14:33:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F37F5281A1F
	for <lists+stable@lfdr.de>; Fri, 13 Sep 2024 12:33:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B5471DA0E7;
	Fri, 13 Sep 2024 12:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xCRCnhGl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDDCD1D932B
	for <stable@vger.kernel.org>; Fri, 13 Sep 2024 12:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726230786; cv=none; b=p+s5xR6+aN/yLliUZmzwn/Ft+2DVcIrkuS23GGHfA56jAFzrn5GtRTBQsN5AVtW8XTV9LZey1pFQqyfAk+pMvjyloXEDcnj8MYCnZHkJB1PrInnkAB/CqF9c0w8+F9aH05oFoCiuaq/sBJn9LED4DC8NPWM0lKZAaNiTKcal3Jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726230786; c=relaxed/simple;
	bh=wgyKd8oipLyUnyzICLot1morGm90LY1JFhnIbTfjxfg=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=rmLm4bm0AARpaLHU7noPL8NHV3wfE6+G602UyghnPe4q+zv/J/7l7bd7NvYGgzWnlCWgilbiDwKNXj0OwfP1S9sPOB+8bLVbopUeNhoTQkRmmSgUKl85R6KvzFwzz490s4rqigww1SOJNBmMinTuY10KnR4Fc0a5W3sIk/jYun8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xCRCnhGl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C407C4CEC0;
	Fri, 13 Sep 2024 12:33:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1726230786;
	bh=wgyKd8oipLyUnyzICLot1morGm90LY1JFhnIbTfjxfg=;
	h=Subject:To:Cc:From:Date:From;
	b=xCRCnhGlEninGuL6IKBh7XV4qMR2Ph9Y0JBb+TIfXs9LhghcG9JaY6qE+wvUcZ//n
	 TNONKeHvyeY1ITurwNFkN65tLZm+uVsrK0zwQAAgkK2CFudsouI10CkAOzatV0Iwmm
	 zlUMI3ZxBWSZvSvarg/MKACyPYl9+a8126gEcnlE=
Subject: FAILED: patch "[PATCH] platform/x86: panasonic-laptop: Allocate 1 entry extra in the" failed to apply to 5.10-stable tree
To: hdegoede@redhat.com,ilpo.jarvinen@linux.intel.com,jharmison@redhat.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 13 Sep 2024 14:33:03 +0200
Message-ID: <2024091303-dash-sensitive-4aee@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 33297cef3101d950cec0033a0dce0a2d2bd59999
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024091303-dash-sensitive-4aee@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:

33297cef3101 ("platform/x86: panasonic-laptop: Allocate 1 entry extra in the sinf array")
f1aaf914654a ("platform/x86: panasonic-laptop: Replace ACPI prints with pr_*() macros")
d5a81d8e864b ("platform/x86: panasonic-laptop: Add support for optical driver power in Y and W series")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 33297cef3101d950cec0033a0dce0a2d2bd59999 Mon Sep 17 00:00:00 2001
From: Hans de Goede <hdegoede@redhat.com>
Date: Mon, 9 Sep 2024 13:32:26 +0200
Subject: [PATCH] platform/x86: panasonic-laptop: Allocate 1 entry extra in the
 sinf array
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Some DSDT-s have an off-by-one bug where the SINF package count is
one higher than the SQTY reported value, allocate 1 entry extra.

Also make the SQTY <-> SINF package count mismatch error more verbose
to help debugging similar issues in the future.

This fixes the panasonic-laptop driver failing to probe() on some
devices with the following errors:

[    3.958887] SQTY reports bad SINF length SQTY: 37 SINF-pkg-count: 38
[    3.958892] Couldn't retrieve BIOS data
[    3.983685] Panasonic Laptop Support - With Macros: probe of MAT0019:00 failed with error -5

Fixes: 709ee531c153 ("panasonic-laptop: add Panasonic Let's Note laptop extras driver v0.94")
Cc: stable@vger.kernel.org
Tested-by: James Harmison <jharmison@redhat.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Link: https://lore.kernel.org/r/20240909113227.254470-2-hdegoede@redhat.com
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

diff --git a/drivers/platform/x86/panasonic-laptop.c b/drivers/platform/x86/panasonic-laptop.c
index 39044119d2a6..ebd81846e2d5 100644
--- a/drivers/platform/x86/panasonic-laptop.c
+++ b/drivers/platform/x86/panasonic-laptop.c
@@ -337,7 +337,8 @@ static int acpi_pcc_retrieve_biosdata(struct pcc_acpi *pcc)
 	}
 
 	if (pcc->num_sifr < hkey->package.count) {
-		pr_err("SQTY reports bad SINF length\n");
+		pr_err("SQTY reports bad SINF length SQTY: %lu SINF-pkg-count: %u\n",
+		       pcc->num_sifr, hkey->package.count);
 		status = AE_ERROR;
 		goto end;
 	}
@@ -994,6 +995,12 @@ static int acpi_pcc_hotkey_add(struct acpi_device *device)
 		return -ENODEV;
 	}
 
+	/*
+	 * Some DSDT-s have an off-by-one bug where the SINF package count is
+	 * one higher than the SQTY reported value, allocate 1 entry extra.
+	 */
+	num_sifr++;
+
 	pcc = kzalloc(sizeof(struct pcc_acpi), GFP_KERNEL);
 	if (!pcc) {
 		pr_err("Couldn't allocate mem for pcc");


