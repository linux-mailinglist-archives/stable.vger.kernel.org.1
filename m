Return-Path: <stable+bounces-172635-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38ECEB329C9
	for <lists+stable@lfdr.de>; Sat, 23 Aug 2025 17:45:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 214CA17128B
	for <lists+stable@lfdr.de>; Sat, 23 Aug 2025 15:45:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06D2721257A;
	Sat, 23 Aug 2025 15:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0+NQOgY6"
X-Original-To: Stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB49E8F40
	for <Stable@vger.kernel.org>; Sat, 23 Aug 2025 15:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755963930; cv=none; b=YNsFEUk47HPPNyIpFXg7J3Uvu3O6BFfNSYzFjNa5FAlavq7BFVnnTeeD9T1Nnd7M7aFt+D9gO2b5DFU5EGiIZb+rSlDSzxh5h4qlRJ416z49+BHeDU4OhnkA4CLL+iWRCkKwtDVKjpf/oPAotkLhVYFQsYFrjjnycEvZEi0L4pY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755963930; c=relaxed/simple;
	bh=jsHnZfzGcG5vLtqFPyPNXwKvOItZHcyspQxYPsGtZUA=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Y+n5Vx71RhIVqSyDSGGmZaBEua9cZDWSznGJ1f7OU9kxH5uoCUkfYomqN0dfcW/cpU7l/d0NJkuRA9NFbhp0+ozevw4Xp8WYRbAhWulvC9Hu4TT/9wf/nyb28sQ8EU0+puYRbUjlXlnhQpYY0oFkf8gK2BE3oNgN2YidaePxrC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0+NQOgY6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA233C4CEE7;
	Sat, 23 Aug 2025 15:45:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755963930;
	bh=jsHnZfzGcG5vLtqFPyPNXwKvOItZHcyspQxYPsGtZUA=;
	h=Subject:To:Cc:From:Date:From;
	b=0+NQOgY66x+Surj0mkDhJ27UOM/eziYLvl0ts12upYIoC6oh9A+E9/jTNeKAEBZK6
	 nm+4HsAd9MUxmlqXce8f/2qOeO9A1QlBCdi1LgV87nU2tx0NGUMLH38LU/RB7D3uLh
	 G3He2ZnN4mwCFH5Zvd4Vo+8+8nMr14zY+54fKaFE=
Subject: FAILED: patch "[PATCH] iio: light: as73211: Ensure buffer holes are zeroed" failed to apply to 6.1-stable tree
To: Jonathan.Cameron@huawei.com,Stable@vger.kernel.org,andy@kernel.org,mazziesaccount@gmail.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sat, 23 Aug 2025 17:45:17 +0200
Message-ID: <2025082317-tattling-pending-3706@gregkh>
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
git cherry-pick -x 433b99e922943efdfd62b9a8e3ad1604838181f2
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025082317-tattling-pending-3706@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

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


