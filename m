Return-Path: <stable+bounces-181480-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E0A25B95D9C
	for <lists+stable@lfdr.de>; Tue, 23 Sep 2025 14:34:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF73F19C2651
	for <lists+stable@lfdr.de>; Tue, 23 Sep 2025 12:34:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44F21322A3B;
	Tue, 23 Sep 2025 12:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DUBc154P"
X-Original-To: Stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 010B93218DA
	for <Stable@vger.kernel.org>; Tue, 23 Sep 2025 12:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758630854; cv=none; b=HgVtLbhu0kxG7f6ZeOzKeZSNUISq6UUK1o5hX+OtEUCHV5JvPYIX0u7zhT0mnb+Az1l6arbAbFFlfZXUvvZOKlhyL8OD12TDztrHuUUaydGULPCSTtaMBz1bY+0zzp05aC8MEemDl81e+lSwM4kTagQ3IJxM+WLXDprYn+iciFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758630854; c=relaxed/simple;
	bh=iCgBZedTdEyuUJnV47XG4COFVV6pejX05HIE+AS+UIw=;
	h=Subject:To:From:Date:Message-ID:MIME-Version:Content-Type; b=oXPUuzyVU0ST3CNL/WOYM77sKWiWU5X3evWhK0wZcn3GGlJfYcRoocv2gCBoVLT/P/NeFfUDPvOVGY+S5wcz5+8dByXqZtUATWWUEg+cjP28sOgHl6Jiyvtz18t4bXQ7kZyG5b+j+df+1qVYS6UIcd7j8inaXZiuHrbiU2G1hpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DUBc154P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40DC0C4CEF5;
	Tue, 23 Sep 2025 12:34:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1758630853;
	bh=iCgBZedTdEyuUJnV47XG4COFVV6pejX05HIE+AS+UIw=;
	h=Subject:To:From:Date:From;
	b=DUBc154PAGyfdSQVNn+8zzc7/A1KEfkRkwKHWJ9t9zIDZg4YcgtQmyyDZbvYs7k5u
	 eqyUG2z/0jlZDcnAyfeYCfhFyQaIhivnCaXeKNNjvaPfTrjzZAW9k6G5QZliUqLBu4
	 TdyUSgsdQ2WDNn+kjlU4oYToBHpur9TjchD0w77k=
Subject: patch "iio: imu: inv_icm42600: Drop redundant pm_runtime reinitialization in" added to char-misc-next
To: sean@geanix.com,Jonathan.Cameron@huawei.com,Stable@vger.kernel.org
From: <gregkh@linuxfoundation.org>
Date: Tue, 23 Sep 2025 14:19:20 +0200
Message-ID: <2025092320-glade-thirteen-18ad@gregkh>
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
in the char-misc-next branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will also be merged in the next major kernel release
during the merge window.

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



