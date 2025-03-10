Return-Path: <stable+bounces-121692-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EB1FA5912F
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 11:29:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D43916A406
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 10:29:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5034F192D83;
	Mon, 10 Mar 2025 10:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ss69CWD/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F8B81A7046
	for <stable@vger.kernel.org>; Mon, 10 Mar 2025 10:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741602578; cv=none; b=kFEOBNFiPrhQ67kpai/kS01C24cPvu0lw7E88zaFeC96grLEAGF/l82G2UPVXV/W6NMVvt2Invx2pElPsQGbd/QYAaA0ZwKdFtJRocqOzfQ19WIsnVuKabsE92Bs7cvl5znwCbhpdFxc+uT8lT8OHlASoelAU8UQ0azKPZi+wJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741602578; c=relaxed/simple;
	bh=B95DSFQWdDbeh1ESaG8UgzKdV+WPlQ9zQxF7N9w+TgA=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=POTLfcFmsHCsBbClv2iFyu4WQ8echolEbpYYhPzQ36hEaf+uF7gqalZnhlqkA8zyMOqjduprxIBxb0tG65kkgF6Wd3n22scxm+d7wSjzTJFCxKYbkGQHcIn7CTlun6vNkX0Vlw2Sfdb/9oLPph2gPr429QhPawg/2UqJm0xWqvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ss69CWD/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 337AAC4CEED;
	Mon, 10 Mar 2025 10:29:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741602577;
	bh=B95DSFQWdDbeh1ESaG8UgzKdV+WPlQ9zQxF7N9w+TgA=;
	h=Subject:To:Cc:From:Date:From;
	b=ss69CWD/QRJb5vi3K8aUE/P942CnTqT6ee605Al/zFDLUzOL3NTmp1EYVFW9dP02H
	 iMF8dj6d4ycK2MkY7CBkIxxRnxL6gx5AoMHLPbR35vcYUvFz+aNp3pHRi/A2ohb1jV
	 CW7WhxcOnXK5rUCsSDYJ/5ZDw9y2hv29GPjQtu4w=
Subject: FAILED: patch "[PATCH] cdx: Fix possible UAF error in driver_override_show()" failed to apply to 6.1-stable tree
To: chenqiuji666@gmail.com,gregkh@linuxfoundation.org,stable@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 10 Mar 2025 11:29:34 +0100
Message-ID: <2025031034-faction-uphold-6310@gregkh>
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
git cherry-pick -x 91d44c1afc61a2fec37a9c7a3485368309391e0b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025031034-faction-uphold-6310@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

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
 


