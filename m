Return-Path: <stable+bounces-181477-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 81FFDB95D7E
	for <lists+stable@lfdr.de>; Tue, 23 Sep 2025 14:26:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7B96C4E2E29
	for <lists+stable@lfdr.de>; Tue, 23 Sep 2025 12:26:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E01CB322C9F;
	Tue, 23 Sep 2025 12:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OdRwEs/y"
X-Original-To: Stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AAB3315D43
	for <Stable@vger.kernel.org>; Tue, 23 Sep 2025 12:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758630372; cv=none; b=Yt3ZUeSJ91dn7xC2OTp7lDwobelRFh/TX84bSt+Vh4I+PJjKDxpCAKiwTeZEA11i9o4cuyXW/4o8I25YAMPHkPTrDIzisCgBx6h6VeNRlbbTZ+xe3Cak+BFzrP54TR+De4VCZEIg7UlkVDy4Ym1xPOr11HW5rfETjlfR4Vxlaz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758630372; c=relaxed/simple;
	bh=cpc3/6UeTLBNX9hZuRkQdfqUln08jJaFfJOYbCQ57bs=;
	h=Subject:To:From:Date:Message-ID:MIME-Version:Content-Type; b=BxTmnnSX2QVVKWDMxBs1DjTOSkyb4/2su3eOL3VxEJ49pdelGFDBN1dVhBWJC/eSqc6gPnNj2SKhAepD0jarpGlDsBXOLXKXah6ryZoLupUj8x67dOM3imtoAbmWbh1LkRDA2lbEiW7rPOSWl7PRkkMqdiUEqS1cZFiNMzs9N/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OdRwEs/y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24907C4CEF5;
	Tue, 23 Sep 2025 12:26:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1758630372;
	bh=cpc3/6UeTLBNX9hZuRkQdfqUln08jJaFfJOYbCQ57bs=;
	h=Subject:To:From:Date:From;
	b=OdRwEs/ytcigOY6l2lgmQAeQ4u+jNJdieF3N2YlaKHAU4Q1e2q6Kld2fQmXWEg8xa
	 U5NlEWzeoQvg6z9mFjyOE5lHANLErUYLoe23b3lzt5oSsC0OJ/KHRy17ZAbZFDOlvc
	 0S1MPmaYSPGWr/eJpPEQo9bexxOe4xDf97Ds9rRQ=
Subject: patch "iio: imu: inv_icm42600: Drop redundant pm_runtime reinitialization in" added to char-misc-testing
To: sean@geanix.com,Jonathan.Cameron@huawei.com,Stable@vger.kernel.org
From: <gregkh@linuxfoundation.org>
Date: Tue, 23 Sep 2025 14:17:41 +0200
Message-ID: <2025092341-clarinet-reoccupy-5613@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


This is a note to let you know that I've just added the patch titled

    iio: imu: inv_icm42600: Drop redundant pm_runtime reinitialization in

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-testing branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will be merged to the char-misc-next branch sometime soon,
after it passes testing, and the merge window is open.

If you have any questions about this process, please let me know.


From a95a0b4e471a6d8860f40c6ac8f1cad9dde3189a Mon Sep 17 00:00:00 2001
From: Sean Nyekjaer <sean@geanix.com>
Date: Mon, 1 Sep 2025 09:49:14 +0200
Subject: iio: imu: inv_icm42600: Drop redundant pm_runtime reinitialization in
 resume

Remove unnecessary calls to pm_runtime_disable(), pm_runtime_set_active(),
and pm_runtime_enable() from the resume path. These operations are not
required here and can interfere with proper pm_runtime state handling,
especially when resuming from a pm_runtime suspended state.

Fixes: 31c24c1e93c3 ("iio: imu: inv_icm42600: add core of new inv_icm42600 driver")
Signed-off-by: Sean Nyekjaer <sean@geanix.com>
Link: https://patch.msgid.link/20250901-icm42pmreg-v3-2-ef1336246960@geanix.com
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/imu/inv_icm42600/inv_icm42600_core.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
index 76d8e4f14d87..41b275ecc7e2 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
@@ -917,10 +917,6 @@ static int inv_icm42600_resume(struct device *dev)
 			goto out_unlock;
 	}
 
-	pm_runtime_disable(dev);
-	pm_runtime_set_active(dev);
-	pm_runtime_enable(dev);
-
 	/* restore sensors state */
 	ret = inv_icm42600_set_pwr_mgmt0(st, st->suspended.gyro,
 					 st->suspended.accel,
-- 
2.51.0



