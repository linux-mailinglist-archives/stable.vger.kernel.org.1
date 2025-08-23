Return-Path: <stable+bounces-172634-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C3D12B329C8
	for <lists+stable@lfdr.de>; Sat, 23 Aug 2025 17:45:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0D9124E22B0
	for <lists+stable@lfdr.de>; Sat, 23 Aug 2025 15:45:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAAFD20FAB2;
	Sat, 23 Aug 2025 15:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="myADEU4X"
X-Original-To: Stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7896119309C
	for <Stable@vger.kernel.org>; Sat, 23 Aug 2025 15:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755963927; cv=none; b=GtyQ/TeNZPcdzYEzB1qmoCA3wxlh/yPVoessbSz+JQi0+JXKEjUSSwh0JoYDQyKcSSUOSpu5LHr7CX+Whru2am5Kbg1Si3pNN+rjs8W+zJnaO2gSFbtW8z1FyU3sdbB6h6LRtmUNvHV1VLgN7L89rA6JLPVi4NpyZiwBJblrO/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755963927; c=relaxed/simple;
	bh=jb8yFWQjGalzqp2Tl4xXjUm8k0diTUZAVliYylDivo4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=HgdJJiVArTNeBbCKmCnqzxsoIsMv7fwg3uil4+imczmU5SZxVL4/Rl4ZmI7XjM1Ox42HwKZLOjQccqYu16Hr/J5J83TiuEAg8+4SWUJ1U3q6scX3DvhGG084QmZf47ebLg7e3llYh3POl0gKNzKHEvooh3K+x1FkePpwtoAR3zE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=myADEU4X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAE2DC116D0;
	Sat, 23 Aug 2025 15:45:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755963927;
	bh=jb8yFWQjGalzqp2Tl4xXjUm8k0diTUZAVliYylDivo4=;
	h=Subject:To:Cc:From:Date:From;
	b=myADEU4XLAUKvs3MzkdRuqnId28NK6Y9vgwvwgL9iffqCbJlg96fY4Y3orALM6pnE
	 XRj64WznFVGZ14j9vPa7azC5irMJzUBI6E/aXllqygpwFw5k/Z57l/ZdB3FU3LI5gi
	 gd72zz4ZGRfgL1P0/mBx20vjHO0c1nBczvoJe49I=
Subject: FAILED: patch "[PATCH] iio: light: as73211: Ensure buffer holes are zeroed" failed to apply to 6.12-stable tree
To: Jonathan.Cameron@huawei.com,Stable@vger.kernel.org,andy@kernel.org,mazziesaccount@gmail.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sat, 23 Aug 2025 17:45:16 +0200
Message-ID: <2025082316-antennae-resurrect-e01a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 433b99e922943efdfd62b9a8e3ad1604838181f2
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025082316-antennae-resurrect-e01a@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

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


