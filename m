Return-Path: <stable+bounces-38499-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5567B8A0EEE
	for <lists+stable@lfdr.de>; Thu, 11 Apr 2024 12:19:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FCCB282AE2
	for <lists+stable@lfdr.de>; Thu, 11 Apr 2024 10:19:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3EAE14601B;
	Thu, 11 Apr 2024 10:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ArRTakGh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 741BE140E3D;
	Thu, 11 Apr 2024 10:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712830754; cv=none; b=tTv3/E+F6j4eRCIC6kC8k3DofXdnoaz4FwR15zxxCOelvTACcAWYTjlT01SZsDw2LEI6uxzGS5zFFlF9Ayk3YnwEDq4s8k8Nu9Ib17gzsBwWcNC+Aj9emPkA105awCq456jFIx4C2NRON6Wmen7RGnGnUJVMVdNqP27HUQkX8ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712830754; c=relaxed/simple;
	bh=yFsM3djUTWz6F+nrIcFu/ksQwLW9XlBzxaWkNXmeDkw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n947jJXbXs2etzZL68ButDse6IuuKGIAs7ftthItLKOjP0vv7Wvp3FvWEdGlAGFOp9t56YR4emENu7jNPuozxKnnocCiroJiAi01KlUhlSrADxj1Tkp7P+XfQwbEX8QEQdi+JT5Az/1ed9MysEHhvpndz+fB2OwzjB4ATOHlAsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ArRTakGh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CA40C433C7;
	Thu, 11 Apr 2024 10:19:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712830753;
	bh=yFsM3djUTWz6F+nrIcFu/ksQwLW9XlBzxaWkNXmeDkw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ArRTakGhu4il9fygFBBQUMRaoxhYGTG5UfZ3yJ4ifPGLEVZZvOc+9olRub+dJLYhe
	 78n4CfjN64KNR5sFdcsv9BinMW3SqQhiLS/fFUZ1QXoNw6pD2Pd4MgE6s6c6+AJXKW
	 klpQOTENpzPcU+xysPVZn9svpL6+Swa6YFC5I+bc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Siddh Raman Pant <code@siddh.me>,
	Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>,
	Genjian Zhang <zhanggenjian@kylinos.cn>,
	syzbot+a8e049cd3abd342936b6@syzkaller.appspotmail.com
Subject: [PATCH 5.4 104/215] loop: Check for overflow while configuring loop
Date: Thu, 11 Apr 2024 11:55:13 +0200
Message-ID: <20240411095428.037325067@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240411095424.875421572@linuxfoundation.org>
References: <20240411095424.875421572@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Siddh Raman Pant <code@siddh.me>

[ Upstream commit c490a0b5a4f36da3918181a8acdc6991d967c5f3 ]

The userspace can configure a loop using an ioctl call, wherein
a configuration of type loop_config is passed (see lo_ioctl()'s
case on line 1550 of drivers/block/loop.c). This proceeds to call
loop_configure() which in turn calls loop_set_status_from_info()
(see line 1050 of loop.c), passing &config->info which is of type
loop_info64*. This function then sets the appropriate values, like
the offset.

loop_device has lo_offset of type loff_t (see line 52 of loop.c),
which is typdef-chained to long long, whereas loop_info64 has
lo_offset of type __u64 (see line 56 of include/uapi/linux/loop.h).

The function directly copies offset from info to the device as
follows (See line 980 of loop.c):
	lo->lo_offset = info->lo_offset;

This results in an overflow, which triggers a warning in iomap_iter()
due to a call to iomap_iter_done() which has:
	WARN_ON_ONCE(iter->iomap.offset > iter->pos);

Thus, check for negative value during loop_set_status_from_info().

Bug report: https://syzkaller.appspot.com/bug?id=c620fe14aac810396d3c3edc9ad73848bf69a29e

Reported-and-tested-by: syzbot+a8e049cd3abd342936b6@syzkaller.appspotmail.com
Cc: stable@vger.kernel.org
Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Siddh Raman Pant <code@siddh.me>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Link: https://lore.kernel.org/r/20220823160810.181275-1-code@siddh.me
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Genjian Zhang <zhanggenjian@kylinos.cn>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/block/loop.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1298,6 +1298,11 @@ loop_set_status_from_info(struct loop_de
 
 	lo->lo_offset = info->lo_offset;
 	lo->lo_sizelimit = info->lo_sizelimit;
+
+	/* loff_t vars have been assigned __u64 */
+	if (lo->lo_offset < 0 || lo->lo_sizelimit < 0)
+		return -EOVERFLOW;
+
 	memcpy(lo->lo_file_name, info->lo_file_name, LO_NAME_SIZE);
 	memcpy(lo->lo_crypt_name, info->lo_crypt_name, LO_NAME_SIZE);
 	lo->lo_file_name[LO_NAME_SIZE-1] = 0;



