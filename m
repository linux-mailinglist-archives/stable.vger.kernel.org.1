Return-Path: <stable+bounces-139320-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 625C9AA60E5
	for <lists+stable@lfdr.de>; Thu,  1 May 2025 17:49:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16B579A30F3
	for <lists+stable@lfdr.de>; Thu,  1 May 2025 15:48:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95D42202981;
	Thu,  1 May 2025 15:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CymeL047"
X-Original-To: Stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54B9E1BF37
	for <Stable@vger.kernel.org>; Thu,  1 May 2025 15:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746114551; cv=none; b=nosfe4Y6p2HZA/60XT4DRO554D7HVw+jfoO+8PJJXLlpxIWUXRP7EUygYdm/fjLvMd5KxvvK1Tlzdm7q9I4rN8ph91iIvGrtZQdpVtSTB7ZCCiBBG3uB7notvjtUA8MlfDcLHfxbvLnfyvS64px6/t6OObTzbbtBDI46NBLQCJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746114551; c=relaxed/simple;
	bh=WVbWYywLwyv+s+062JUmricpNvy3tkytMbx1wIoFbpU=;
	h=Subject:To:From:Date:Message-ID:MIME-Version:Content-Type; b=Q7XldkJ8EFQc3iIFwVU5aSI3cXy623TFuvBvt2gxfY1nnQM14TPCRIMIPT8Mx5/yMCbSlrKX+eIqKLIbFF6+HGYydXa0HtQjzebNYBU/GR8HURk8inNIVhaDWslazLoUd5ChYwowrP4IIoDsilqvx9+T2GYnCIoZcgqK5FN8zzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CymeL047; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 712C6C4CEE3;
	Thu,  1 May 2025 15:49:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1746114550;
	bh=WVbWYywLwyv+s+062JUmricpNvy3tkytMbx1wIoFbpU=;
	h=Subject:To:From:Date:From;
	b=CymeL0479NLtz23p4vyBMtJYtSncb0cbATKvojsfK3S4Lz0+igfUcIdAMA0FOKf8N
	 jJkE/kMQqjpLEkbNfeFB7zqC7NgZywgrp7cNBa/8Ewd1OLg1/bmMrShJmKguPFXzFU
	 tVvFYyHv0ZzK3lvHu4KNEccJkbwyh/s6KutNYNQ4=
Subject: patch "iio: imu: st_lsm6dsx: fix possible lockup in" added to char-misc-linus
To: s.seva@4sigma.it,Jonathan.Cameron@huawei.com,Stable@vger.kernel.org,lorenzo@kernel.org
From: <gregkh@linuxfoundation.org>
Date: Thu, 01 May 2025 17:48:53 +0200
Message-ID: <2025050153-abrasive-delouse-b7cd@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


This is a note to let you know that I've just added the patch titled

    iio: imu: st_lsm6dsx: fix possible lockup in

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-linus branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will hopefully also be merged in Linus's tree for the
next -rc kernel release.

If you have any questions about this process, please let me know.


From 8114ef86e2058e2554111b793596f17bee23fa15 Mon Sep 17 00:00:00 2001
From: Silvano Seva <s.seva@4sigma.it>
Date: Tue, 11 Mar 2025 09:49:49 +0100
Subject: iio: imu: st_lsm6dsx: fix possible lockup in
 st_lsm6dsx_read_tagged_fifo

Prevent st_lsm6dsx_read_tagged_fifo from falling in an infinite loop in
case pattern_len is equal to zero and the device FIFO is not empty.

Fixes: 801a6e0af0c6 ("iio: imu: st_lsm6dsx: add support to LSM6DSO")
Signed-off-by: Silvano Seva <s.seva@4sigma.it>
Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>
Link: https://patch.msgid.link/20250311085030.3593-4-s.seva@4sigma.it
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
index 480a9b31065c..8a9d2593576a 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
@@ -626,6 +626,9 @@ int st_lsm6dsx_read_tagged_fifo(struct st_lsm6dsx_hw *hw)
 	if (!fifo_len)
 		return 0;
 
+	if (!pattern_len)
+		pattern_len = ST_LSM6DSX_TAGGED_SAMPLE_SIZE;
+
 	for (read_len = 0; read_len < fifo_len; read_len += pattern_len) {
 		err = st_lsm6dsx_read_block(hw,
 					    ST_LSM6DSX_REG_FIFO_OUT_TAG_ADDR,
-- 
2.49.0



