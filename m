Return-Path: <stable+bounces-204660-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 74BE1CF3216
	for <lists+stable@lfdr.de>; Mon, 05 Jan 2026 12:04:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 480F73044857
	for <lists+stable@lfdr.de>; Mon,  5 Jan 2026 10:59:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE86832ED31;
	Mon,  5 Jan 2026 10:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hKvaySjP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E7FF32E14F
	for <stable@vger.kernel.org>; Mon,  5 Jan 2026 10:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767610790; cv=none; b=Luc7i6pFAMvgWQ20zdHpJJ+AfiWyIStaIoSF503L3C8rXtJHSM8PBDvgVrjDo3ZQTdE6cZCTTC/099EW4t0jAnyF6o6hsWtWpDdvYqbVszKMAAzdPiUW7wAdOPvpLxe4Qpw6RyQc0FEmOhNQ8fro8lPbRB4mNSjrb+pyCLNesAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767610790; c=relaxed/simple;
	bh=1etz6QzbXvp5kamJv8NVz6/FY5HqOArgEYmHkWf/6qg=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=YgQ2ktR0P3LGwym1MVtd05J24re037CuwbbohKxkZkBuCTBPpqysKg4y4Vev41oH/VngpNh0orgGSyi1dpd3AT/ahCboNO8lwzzmwxB4QWe7L8nftVPuO2kHyEU8QSvuusHkqBkgIoPs+YQm3h3PJKulTe4gSJqzRYXWTJoraHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hKvaySjP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCC55C116D0;
	Mon,  5 Jan 2026 10:59:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767610790;
	bh=1etz6QzbXvp5kamJv8NVz6/FY5HqOArgEYmHkWf/6qg=;
	h=Subject:To:Cc:From:Date:From;
	b=hKvaySjPt24yrNNE9EW9NwWvdpNuwkS7Zs43opz9oFleM/pWOnSYNblX3obXmz2SF
	 yi5Sv0HwpirYBTaAv77EbNUVeb8xGNAhg82LEYdc3dTX+LspmYAlnXw6dF0GvVmf2p
	 Mbnu/wBN9SsY7e2sFJpqvRYOPOrU7opvgIa+T4iA=
Subject: FAILED: patch "[PATCH] media: vpif_display: fix section mismatch" failed to apply to 5.15-stable tree
To: johan@kernel.org,hverkuil+cisco@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 05 Jan 2026 11:59:47 +0100
Message-ID: <2026010547-tactile-dancing-dce5@gregkh>
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
git cherry-pick -x 59ca64bf98e4209df8ace8057d31ae3c80f948cd
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026010547-tactile-dancing-dce5@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 59ca64bf98e4209df8ace8057d31ae3c80f948cd Mon Sep 17 00:00:00 2001
From: Johan Hovold <johan@kernel.org>
Date: Fri, 17 Oct 2025 07:33:21 +0200
Subject: [PATCH] media: vpif_display: fix section mismatch

Platform drivers can be probed after their init sections have been
discarded (e.g. on probe deferral or manual rebind through sysfs) so the
probe function must not live in init.

Note that commit ffa1b391c61b ("V4L/DVB: vpif_cap/disp: Removed section
mismatch warning") incorrectly suppressed the modpost warning.

Fixes: ffa1b391c61b ("V4L/DVB: vpif_cap/disp: Removed section mismatch warning")
Fixes: e7332e3a552f ("V4L/DVB (12176): davinci/vpif_display: Add VPIF display driver")
Cc: stable@vger.kernel.org	# 2.6.32
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Hans Verkuil <hverkuil+cisco@kernel.org>

diff --git a/drivers/media/platform/ti/davinci/vpif_display.c b/drivers/media/platform/ti/davinci/vpif_display.c
index 70c89549f4b6..1e7815e9f8e0 100644
--- a/drivers/media/platform/ti/davinci/vpif_display.c
+++ b/drivers/media/platform/ti/davinci/vpif_display.c
@@ -1214,7 +1214,7 @@ static int vpif_probe_complete(void)
  * vpif_probe: This function creates device entries by register itself to the
  * V4L2 driver and initializes fields of each channel objects
  */
-static __init int vpif_probe(struct platform_device *pdev)
+static int vpif_probe(struct platform_device *pdev)
 {
 	struct vpif_subdev_info *subdevdata;
 	struct i2c_adapter *i2c_adap;
@@ -1390,7 +1390,7 @@ static int vpif_resume(struct device *dev)
 
 static SIMPLE_DEV_PM_OPS(vpif_pm_ops, vpif_suspend, vpif_resume);
 
-static __refdata struct platform_driver vpif_driver = {
+static struct platform_driver vpif_driver = {
 	.driver	= {
 			.name	= VPIF_DRIVER_NAME,
 			.pm	= &vpif_pm_ops,


