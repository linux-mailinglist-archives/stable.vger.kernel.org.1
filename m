Return-Path: <stable+bounces-172637-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE558B329CC
	for <lists+stable@lfdr.de>; Sat, 23 Aug 2025 17:45:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 16B2C7B8417
	for <lists+stable@lfdr.de>; Sat, 23 Aug 2025 15:44:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 139541E9B22;
	Sat, 23 Aug 2025 15:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wyEyccGI"
X-Original-To: Stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C855786323
	for <Stable@vger.kernel.org>; Sat, 23 Aug 2025 15:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755963936; cv=none; b=LcuWGC/yhnwO9ZTXSKni8/zPSGeqwrHL47YJ9ArtDuBHajvlgO342yTl5GGtbAGynbOrUCahvL3SzeBOjjESaZnzsMjbcALPCbqkwigy/2ytqzYseKEczmaHih+9m3vWtLaIF7Ajo/4EqrkKo4pArYX9+dwHRbG1rUeREODrIjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755963936; c=relaxed/simple;
	bh=e+Zmeg1qVV7yLgj6mSxxFCxZf6CLLssdyPNuMnS1plg=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=F/7e7/FG3rWo4CWMdOXydquHwBPIGjSsGAAHfhR0mp5FvIMk6iF+97xz8uuPSIxuYaGJCZ/Oe+IdMIz/OrVBrq1XKuI0nOZux+HSrAaIb1vjV2XTQ6/EQaxHREKj4jtBqHTyea6fh/pJDVPa9n2xj242T8TyAelB+BGatK90ZP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wyEyccGI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49ED4C4CEE7;
	Sat, 23 Aug 2025 15:45:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755963936;
	bh=e+Zmeg1qVV7yLgj6mSxxFCxZf6CLLssdyPNuMnS1plg=;
	h=Subject:To:Cc:From:Date:From;
	b=wyEyccGIaupjLAzhh2C6Ee6fl9JXfV2Jwt900Jw7MoOL5h3n+Q7a+Bb47McJwmISp
	 7gA1MujPKnrUCl5Gg6W8ZWvEopYi3SrMtnnMc2+KXhrUBhs1dOxvD1ZVXLQEn8Fovl
	 QAnnaHkuyiIOqIraHdcARZGXK1zM7t28lxpD3AWU=
Subject: FAILED: patch "[PATCH] iio: light: as73211: Ensure buffer holes are zeroed" failed to apply to 6.6-stable tree
To: Jonathan.Cameron@huawei.com,Stable@vger.kernel.org,andy@kernel.org,mazziesaccount@gmail.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sat, 23 Aug 2025 17:45:17 +0200
Message-ID: <2025082317-deprecate-tropics-e5fc@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 433b99e922943efdfd62b9a8e3ad1604838181f2
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025082317-deprecate-tropics-e5fc@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 433b99e922943efdfd62b9a8e3ad1604838181f2 Mon Sep 17 00:00:00 2001
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Date: Sat, 2 Aug 2025 17:44:21 +0100
Subject: [PATCH] iio: light: as73211: Ensure buffer holes are zeroed

Given that the buffer is copied to a kfifo that ultimately user space
can read, ensure we zero it.

Fixes: 403e5586b52e ("iio: light: as73211: New driver")
Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>
Reviewed-by: Andy Shevchenko <andy@kernel.org>
Link: https://patch.msgid.link/20250802164436.515988-2-jic23@kernel.org
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

diff --git a/drivers/iio/light/as73211.c b/drivers/iio/light/as73211.c
index 68f60dc3c79d..32719f584c47 100644
--- a/drivers/iio/light/as73211.c
+++ b/drivers/iio/light/as73211.c
@@ -639,7 +639,7 @@ static irqreturn_t as73211_trigger_handler(int irq __always_unused, void *p)
 	struct {
 		__le16 chan[4];
 		aligned_s64 ts;
-	} scan;
+	} scan = { };
 	int data_result, ret;
 
 	mutex_lock(&data->mutex);


