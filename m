Return-Path: <stable+bounces-139318-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2475CAA60E3
	for <lists+stable@lfdr.de>; Thu,  1 May 2025 17:49:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C71CA1BA4EE1
	for <lists+stable@lfdr.de>; Thu,  1 May 2025 15:49:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84157202C49;
	Thu,  1 May 2025 15:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mKaMXGL/"
X-Original-To: Stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43B47200BBC
	for <Stable@vger.kernel.org>; Thu,  1 May 2025 15:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746114539; cv=none; b=dBsLMYEPUC8zsdGBKHEQXNMN8EW61Z6Y/4IedaWshoXG9Bkl3UStcVu7BaIq27LBPHoIQlYo0AfZYEFL+pHEcfvZuf/6zZp5ujg97eIEuqZILDmFOgzw7N+Hd2U9BzxXh6PPkoFf5nA6buEONSaeO2HeE5rN/+b9+9kO3RM6QDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746114539; c=relaxed/simple;
	bh=geat0C/5931pKUb5x74Bh+MsLhwvwCDlEQV1FJcP4FQ=;
	h=Subject:To:From:Date:Message-ID:MIME-Version:Content-Type; b=HDqVWW9hlbGFl4v/WB2Uta2urHtA21fkUNvUtX41NE6EmpCccz1NwtUgxNKXBa7wgXKKDFdID2eXT+++yMSsgJQPa2Op4Hp5RGxJZZXrIF8M8QBU1RIqlbyF//Dql9DbdaY9/JFW9lsPO35cJcVOlrmD72Lc7DJazzC08WahqRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mKaMXGL/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 907E6C4CEE3;
	Thu,  1 May 2025 15:48:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1746114539;
	bh=geat0C/5931pKUb5x74Bh+MsLhwvwCDlEQV1FJcP4FQ=;
	h=Subject:To:From:Date:From;
	b=mKaMXGL/CGRvEIIBjUJxp5a3Ea5up0qMYvfTG+0vi4IgIbP7L3lye4S15QTwyA2gT
	 sa9+XpQpz2iWV2tgrPbPc7ATj9LOc8zZGcULhv/8/tCSW/ZbupatIdjjisbvco+H4d
	 JHPA3SStDX5Zbzl7YeYPRYHdBy7MoVLcDMbNMqU8=
Subject: patch "iio: imu: st_lsm6dsx: fix possible lockup in st_lsm6dsx_read_fifo" added to char-misc-linus
To: s.seva@4sigma.it,Jonathan.Cameron@huawei.com,Stable@vger.kernel.org,lorenzo@kernel.org
From: <gregkh@linuxfoundation.org>
Date: Thu, 01 May 2025 17:48:53 +0200
Message-ID: <2025050153-herself-prowess-407b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


This is a note to let you know that I've just added the patch titled

    iio: imu: st_lsm6dsx: fix possible lockup in st_lsm6dsx_read_fifo

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-linus branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will hopefully also be merged in Linus's tree for the
next -rc kernel release.

If you have any questions about this process, please let me know.


From 159ca7f18129834b6f4c7eae67de48e96c752fc9 Mon Sep 17 00:00:00 2001
From: Silvano Seva <s.seva@4sigma.it>
Date: Tue, 11 Mar 2025 09:49:47 +0100
Subject: iio: imu: st_lsm6dsx: fix possible lockup in st_lsm6dsx_read_fifo

Prevent st_lsm6dsx_read_fifo from falling in an infinite loop in case
pattern_len is equal to zero and the device FIFO is not empty.

Fixes: 290a6ce11d93 ("iio: imu: add support to lsm6dsx driver")
Signed-off-by: Silvano Seva <s.seva@4sigma.it>
Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>
Link: https://patch.msgid.link/20250311085030.3593-2-s.seva@4sigma.it
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
index 0a7cd8c1aa33..480a9b31065c 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
@@ -392,6 +392,9 @@ int st_lsm6dsx_read_fifo(struct st_lsm6dsx_hw *hw)
 	if (fifo_status & cpu_to_le16(ST_LSM6DSX_FIFO_EMPTY_MASK))
 		return 0;
 
+	if (!pattern_len)
+		pattern_len = ST_LSM6DSX_SAMPLE_SIZE;
+
 	fifo_len = (le16_to_cpu(fifo_status) & fifo_diff_mask) *
 		   ST_LSM6DSX_CHAN_SIZE;
 	fifo_len = (fifo_len / pattern_len) * pattern_len;
-- 
2.49.0



