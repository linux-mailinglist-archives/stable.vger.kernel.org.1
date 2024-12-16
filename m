Return-Path: <stable+bounces-104373-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E8549F3492
	for <lists+stable@lfdr.de>; Mon, 16 Dec 2024 16:33:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4BB811886CE3
	for <lists+stable@lfdr.de>; Mon, 16 Dec 2024 15:33:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79559139CEF;
	Mon, 16 Dec 2024 15:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="U9ph6lo/"
X-Original-To: Stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E9EA136337
	for <Stable@vger.kernel.org>; Mon, 16 Dec 2024 15:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734363181; cv=none; b=RXZtAHFpic6I7xFB9YMd4EElJJe7VzhJwAxYmqAz2Ss6sSjMEqjonWRMdtx8cwFvlCxImPo76YghyTHDTWaGcfW1ocjEQorBDlvDBXiKwyuA76Ts7/IFq3O+oM6GvxEwvCnfK1v4oSLaOZ9whAoXFaLt+Xeq8b92/IE4nGAtaMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734363181; c=relaxed/simple;
	bh=MTZcgGcH7u8jf2J8V8d+9NLazxYoCEZ2O31bmN7TWwI=;
	h=Subject:To:From:Date:Message-ID:MIME-Version:Content-Type; b=kogWBNkaNRuyrtwe6JacwuZmY1QQzcBi+vS/5Jgqh26o5u8dxn3Vd3+6NmssaRJ+3/rPsEeQcsglR49zocHtvqjjWHZivQpSk5h5jTAzzCRqLEYXb2pKj9Qc3Kb1rlG1NAr//V5OuwGHJ/6A1SbiWrAXURRiifUIaivOGqdTeL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=U9ph6lo/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FD07C4CED0;
	Mon, 16 Dec 2024 15:32:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734363180;
	bh=MTZcgGcH7u8jf2J8V8d+9NLazxYoCEZ2O31bmN7TWwI=;
	h=Subject:To:From:Date:From;
	b=U9ph6lo/anweZHr1uhpEC2HNOwJB5WNj4sUeXdG2B4cWQ0uns+qY5lEHX9/z7qIaE
	 T7LCZ/dUKcd6tKvyWVCkeD9ZYjsWuH14xrcWBz5VYnmBXYoe+0dRY0WhxqqqJWdVG3
	 08ZD7DRzcV9VdWWD8I6cRyK6/EYV+eQVnXsGrlPE=
Subject: patch "iio: inkern: call iio_device_put() only on mapped devices" added to char-misc-linus
To: joe@pf.is.s.u-tokyo.ac.jp,Jonathan.Cameron@huawei.com,Stable@vger.kernel.org
From: <gregkh@linuxfoundation.org>
Date: Mon, 16 Dec 2024 16:31:45 +0100
Message-ID: <2024121645-unwired-fraternal-d257@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


This is a note to let you know that I've just added the patch titled

    iio: inkern: call iio_device_put() only on mapped devices

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-linus branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will hopefully also be merged in Linus's tree for the
next -rc kernel release.

If you have any questions about this process, please let me know.


From 64f43895b4457532a3cc524ab250b7a30739a1b1 Mon Sep 17 00:00:00 2001
From: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
Date: Wed, 4 Dec 2024 20:13:42 +0900
Subject: iio: inkern: call iio_device_put() only on mapped devices

In the error path of iio_channel_get_all(), iio_device_put() is called
on all IIO devices, which can cause a refcount imbalance. Fix this error
by calling iio_device_put() only on IIO devices whose refcounts were
previously incremented by iio_device_get().

Fixes: 314be14bb893 ("iio: Rename _st_ functions to loose the bit that meant the staging version.")
Signed-off-by: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
Link: https://patch.msgid.link/20241204111342.1246706-1-joe@pf.is.s.u-tokyo.ac.jp
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/inkern.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
index 136b225b6bc8..9050a59129e6 100644
--- a/drivers/iio/inkern.c
+++ b/drivers/iio/inkern.c
@@ -500,7 +500,7 @@ struct iio_channel *iio_channel_get_all(struct device *dev)
 	return_ptr(chans);
 
 error_free_chans:
-	for (i = 0; i < nummaps; i++)
+	for (i = 0; i < mapind; i++)
 		iio_device_put(chans[i].indio_dev);
 	return ERR_PTR(ret);
 }
-- 
2.47.1



