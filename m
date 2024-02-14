Return-Path: <stable+bounces-20184-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 40AC9854C9B
	for <lists+stable@lfdr.de>; Wed, 14 Feb 2024 16:26:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3A1A1F21FBF
	for <lists+stable@lfdr.de>; Wed, 14 Feb 2024 15:26:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2311A5B671;
	Wed, 14 Feb 2024 15:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Yrv8m9II"
X-Original-To: Stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6ABF43157
	for <Stable@vger.kernel.org>; Wed, 14 Feb 2024 15:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707924365; cv=none; b=YdEHgok50ucpKGL5G3crZKp3NJWiTjvc6undwMrJrYyyrPA3iWBAO+nS/8dVXIPQVBkh8ZVkeFhZE8d7K9hL3ZUi9ycUMdmmO8c6o0OeB2yZEVG9VPMqpZgssWbdZwJwn6YZlIjzo5h7jMCE1YuFD4XoHbbzrSKn5soQhBllOeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707924365; c=relaxed/simple;
	bh=k2pMBFaBnGbC/LIWFlSKXYBbw2Z9l0Z4LKs+jvBHeec=;
	h=Subject:To:From:Date:Message-ID:MIME-Version:Content-Type; b=be1wWZ5IguawykjHl0MNn2PjzgZGoa/kr1k9/V/VX3ySLav7EpFsACf7DL4EH41Zdh9Lol2qSQFXvYpBC9QWCbc33sO3106xQvJPmMatQZYIgWb5kMBJ8o0teu1dQluKGTPORt3bA4aDXgO5cNvdF0feN7yORglOZaM35kr4r2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Yrv8m9II; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA23BC433F1;
	Wed, 14 Feb 2024 15:26:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707924365;
	bh=k2pMBFaBnGbC/LIWFlSKXYBbw2Z9l0Z4LKs+jvBHeec=;
	h=Subject:To:From:Date:From;
	b=Yrv8m9IIUf+SD/Czuc4xZ27HMSFLmDG2oLtP1UqADqrt4Fd7CV2nrV5Yl7XphTN3W
	 6o16uRNpkj9bH3SAOex9GMGfezEOXVjI6vg+7hhA0gUDXDY7UhPRfeDhFH6QLQtXtm
	 QkcwzVNIwfuu2uc1fa32i/oM1etXBmS7suYiIbHk=
Subject: patch "iio: core: fix memleak in iio_device_register_sysfs" added to char-misc-linus
To: dinghao.liu@zju.edu.cn,Jonathan.Cameron@huawei.com,Stable@vger.kernel.org
From: <gregkh@linuxfoundation.org>
Date: Wed, 14 Feb 2024 16:26:02 +0100
Message-ID: <2024021402-woof-jot-1a2d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


This is a note to let you know that I've just added the patch titled

    iio: core: fix memleak in iio_device_register_sysfs

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-linus branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will hopefully also be merged in Linus's tree for the
next -rc kernel release.

If you have any questions about this process, please let me know.


From 95a0d596bbd0552a78e13ced43f2be1038883c81 Mon Sep 17 00:00:00 2001
From: Dinghao Liu <dinghao.liu@zju.edu.cn>
Date: Fri, 8 Dec 2023 15:31:19 +0800
Subject: iio: core: fix memleak in iio_device_register_sysfs

When iio_device_register_sysfs_group() fails, we should
free iio_dev_opaque->chan_attr_group.attrs to prevent
potential memleak.

Fixes: 32f171724e5c ("iio: core: rework iio device group creation")
Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>
Link: https://lore.kernel.org/r/20231208073119.29283-1-dinghao.liu@zju.edu.cn
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/industrialio-core.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index 9a85752124dd..173dc00762a1 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -1584,10 +1584,13 @@ static int iio_device_register_sysfs(struct iio_dev *indio_dev)
 	ret = iio_device_register_sysfs_group(indio_dev,
 					      &iio_dev_opaque->chan_attr_group);
 	if (ret)
-		goto error_clear_attrs;
+		goto error_free_chan_attrs;
 
 	return 0;
 
+error_free_chan_attrs:
+	kfree(iio_dev_opaque->chan_attr_group.attrs);
+	iio_dev_opaque->chan_attr_group.attrs = NULL;
 error_clear_attrs:
 	iio_free_chan_devattr_list(&iio_dev_opaque->channel_attr_list);
 
-- 
2.43.1



