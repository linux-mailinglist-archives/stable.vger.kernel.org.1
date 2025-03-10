Return-Path: <stable+bounces-121693-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AD09A59130
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 11:29:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49903169DB5
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 10:29:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 700D81A7046;
	Mon, 10 Mar 2025 10:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DDcDYxDK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3107B18C02E
	for <stable@vger.kernel.org>; Mon, 10 Mar 2025 10:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741602586; cv=none; b=loEwoSoMLhtRc2Cu0BxLigANow4owXwkkOa2Kdt7kos679nNsmgli2Voz7X5T6qUZz2GWxFc6HeKxeP8Zp2p5uSATgNqF0M+OkC4/KzKHTbqkTVP+QQ7aPje3p1C1MFJPsY3hwDVvet9yiMh04a99osNfck2x6OSvOqlC0fdocI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741602586; c=relaxed/simple;
	bh=8TnljjKwTdfxvxcf7AZjTy/6B5S1fLVGmvMW6ncEBKw=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=q9WiccnMVMThI6yUB21/sXeJplKa/S21BxDPJDtOaglP7j2pVxKiHO83iHF7yuDN/dL0TIbcXANJ22PDd5BgTLWA3FFjnwXCSUp4++sgqDF40osC5vvXsxDYGfmFxVeNm1cu4tgk7JcvsV75H4HbFjcXjcC0SB/7ZaQiHmDkDUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DDcDYxDK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3BA3C4CEEC;
	Mon, 10 Mar 2025 10:29:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741602586;
	bh=8TnljjKwTdfxvxcf7AZjTy/6B5S1fLVGmvMW6ncEBKw=;
	h=Subject:To:Cc:From:Date:From;
	b=DDcDYxDKcWyd9Cjw2SChFue8R2qLR41J0AHKi3RIQQxKlHZrdB4I4I3EZ2xGBfPeE
	 R5ISjb/FOmOGbgTPtyc0vVCmIW9/v51YrLZ8bDPQ7waqa7g7b0xMUF0oc68fwlYMvF
	 AYfnMdXQwZsNMieSOl3eatNxnOnzFnYudpH8iZsc=
Subject: FAILED: patch "[PATCH] cdx: Fix possible UAF error in driver_override_show()" failed to apply to 5.15-stable tree
To: chenqiuji666@gmail.com,gregkh@linuxfoundation.org,stable@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 10 Mar 2025 11:29:35 +0100
Message-ID: <2025031035-unmoving-oak-e2a9@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 91d44c1afc61a2fec37a9c7a3485368309391e0b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025031035-unmoving-oak-e2a9@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 91d44c1afc61a2fec37a9c7a3485368309391e0b Mon Sep 17 00:00:00 2001
From: Qiu-ji Chen <chenqiuji666@gmail.com>
Date: Sat, 18 Jan 2025 15:08:33 +0800
Subject: [PATCH] cdx: Fix possible UAF error in driver_override_show()

Fixed a possible UAF problem in driver_override_show() in drivers/cdx/cdx.c

This function driver_override_show() is part of DEVICE_ATTR_RW, which
includes both driver_override_show() and driver_override_store().
These functions can be executed concurrently in sysfs.

The driver_override_store() function uses driver_set_override() to
update the driver_override value, and driver_set_override() internally
locks the device (device_lock(dev)). If driver_override_show() reads
cdx_dev->driver_override without locking, it could potentially access
a freed pointer if driver_override_store() frees the string
concurrently. This could lead to printing a kernel address, which is a
security risk since DEVICE_ATTR can be read by all users.

Additionally, a similar pattern is used in drivers/amba/bus.c, as well
as many other bus drivers, where device_lock() is taken in the show
function, and it has been working without issues.

This potential bug was detected by our experimental static analysis
tool, which analyzes locking APIs and paired functions to identify
data races and atomicity violations.

Fixes: 1f86a00c1159 ("bus/fsl-mc: add support for 'driver_override' in the mc-bus")
Cc: stable <stable@kernel.org>
Signed-off-by: Qiu-ji Chen <chenqiuji666@gmail.com>
Link: https://lore.kernel.org/r/20250118070833.27201-1-chenqiuji666@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/cdx/cdx.c b/drivers/cdx/cdx.c
index c573ed2ee71a..7811aa734053 100644
--- a/drivers/cdx/cdx.c
+++ b/drivers/cdx/cdx.c
@@ -473,8 +473,12 @@ static ssize_t driver_override_show(struct device *dev,
 				    struct device_attribute *attr, char *buf)
 {
 	struct cdx_device *cdx_dev = to_cdx_device(dev);
+	ssize_t len;
 
-	return sysfs_emit(buf, "%s\n", cdx_dev->driver_override);
+	device_lock(dev);
+	len = sysfs_emit(buf, "%s\n", cdx_dev->driver_override);
+	device_unlock(dev);
+	return len;
 }
 static DEVICE_ATTR_RW(driver_override);
 


