Return-Path: <stable+bounces-160203-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5033FAF9585
	for <lists+stable@lfdr.de>; Fri,  4 Jul 2025 16:30:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5E40588110
	for <lists+stable@lfdr.de>; Fri,  4 Jul 2025 14:30:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C696188734;
	Fri,  4 Jul 2025 14:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YoUp/Cyk"
X-Original-To: Stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F10F172614
	for <Stable@vger.kernel.org>; Fri,  4 Jul 2025 14:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751639449; cv=none; b=jp7CFuY0qrsdutrQTQDqH7ASXcP/KW7EA4PuKTMLYWk0ocKIXMB/YpHFsW+cRY4Yjpthu8QqrJ79JUAlwa5EuRpb24u5ycv3vGx5vThf9mE4bJ7AaRmGjvVwninVYZlrkXccALx+uLilPltnyV7vmaAvmcwBP47D8i/Hff86wgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751639449; c=relaxed/simple;
	bh=YjVP6SDWyUnbnZZF/refBtI9ax44As7xsM/sCZed9Go=;
	h=Subject:To:From:Date:Message-ID:MIME-Version:Content-Type; b=t6IxMwxY4nqMUlyn4jGFPF03iyWnOzh4diODbQrPP6VqCFsY/mwySzFt1H5YZT23dF87/xUyAoT84VVyh/+2A7xwjqgIlVGj5P3WEVHy5nxSN584iagUBbvfdG1AnmR2pq5skpsUK6+KxBvqwJw42cNJ2BuyfTfKEDKQUBvk2es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YoUp/Cyk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FBDEC4CEE3;
	Fri,  4 Jul 2025 14:30:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751639448;
	bh=YjVP6SDWyUnbnZZF/refBtI9ax44As7xsM/sCZed9Go=;
	h=Subject:To:From:Date:From;
	b=YoUp/CykhotFEYot7RlbDLeccXKs58m1rbZRkVyXyVzCZQ9KsNttc1olly/2hbIJW
	 20G3lvL4v7GvgV3ndHQ2vOZUH5W2q1eNjtb+nitRXHj+rQo3FBKKDCfI4LOrVpbGkk
	 dGGS+cM1wWjnLN2Zwa4eFQD+IoECBRi42xmyouDQ=
Subject: patch "iio: backend: fix out-of-bound write" added to char-misc-linus
To: markus.burri@mt.com,Jonathan.Cameron@huawei.com,Stable@vger.kernel.org,nuno.sa@analog.com
From: <gregkh@linuxfoundation.org>
Date: Fri, 04 Jul 2025 16:30:45 +0200
Message-ID: <2025070445-hurdle-snarl-7d76@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


This is a note to let you know that I've just added the patch titled

    iio: backend: fix out-of-bound write

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-linus branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will hopefully also be merged in Linus's tree for the
next -rc kernel release.

If you have any questions about this process, please let me know.


From da9374819eb3885636934c1006d450c3cb1a02ed Mon Sep 17 00:00:00 2001
From: Markus Burri <markus.burri@mt.com>
Date: Thu, 8 May 2025 15:06:07 +0200
Subject: iio: backend: fix out-of-bound write
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The buffer is set to 80 character. If a caller write more characters,
count is truncated to the max available space in "simple_write_to_buffer".
But afterwards a string terminator is written to the buffer at offset count
without boundary check. The zero termination is written OUT-OF-BOUND.

Add a check that the given buffer is smaller then the buffer to prevent.

Fixes: 035b4989211d ("iio: backend: make sure to NULL terminate stack buffer")
Signed-off-by: Markus Burri <markus.burri@mt.com>
Reviewed-by: Nuno Sá <nuno.sa@analog.com>
Link: https://patch.msgid.link/20250508130612.82270-2-markus.burri@mt.com
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/industrialio-backend.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/industrialio-backend.c b/drivers/iio/industrialio-backend.c
index c1eb9ef9db08..266e1b29bf91 100644
--- a/drivers/iio/industrialio-backend.c
+++ b/drivers/iio/industrialio-backend.c
@@ -155,11 +155,14 @@ static ssize_t iio_backend_debugfs_write_reg(struct file *file,
 	ssize_t rc;
 	int ret;
 
+	if (count >= sizeof(buf))
+		return -ENOSPC;
+
 	rc = simple_write_to_buffer(buf, sizeof(buf) - 1, ppos, userbuf, count);
 	if (rc < 0)
 		return rc;
 
-	buf[count] = '\0';
+	buf[rc] = '\0';
 
 	ret = sscanf(buf, "%i %i", &back->cached_reg_addr, &val);
 
-- 
2.50.0



