Return-Path: <stable+bounces-25709-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A564E86D8B7
	for <lists+stable@lfdr.de>; Fri,  1 Mar 2024 02:24:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 943FCB226DC
	for <lists+stable@lfdr.de>; Fri,  1 Mar 2024 01:24:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA18C2B9C6;
	Fri,  1 Mar 2024 01:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="llhdVEWl"
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.6])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2059D2E3F9
	for <stable@vger.kernel.org>; Fri,  1 Mar 2024 01:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709256286; cv=none; b=QTIT4J2t2Vsc3ygebNE5dPwZliKgbQ936w3x8diTQ4NNCBcYjmPHQNnD4k7CwVlFjzqMvy7+rBMYn7QJjHc4mU1EBZSAiGUAg37yNUqRL7goIXgPhNvZg7bOFOtdmBvkmEWEW0ltxd6ccSCVlKTtnM/yGAqVtCD3/HjhDd1Cvo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709256286; c=relaxed/simple;
	bh=ddO+vaPFr8wczH7Xw3KlmXH+rU3xHKclnerM9eMBgFQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Y6LH8kyFOL+GHW89BUCZPwePBTku3sFa1BjZAQqP2qPHMjS+W1GZxxYNfSonkgAHvOXuDpQY1NyDzGinzZjb/uJgZRwWp8iGTs8Cy1RjGr9cxef1sqiV83bCbl9P8OkDW0kT8wkvwHZtWLOQGYuHEuNrHy5LguacHizAg7GMrgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=llhdVEWl; arc=none smtp.client-ip=220.197.31.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=RQsxh
	LQeP7zTe9uqV+xUV9NFx2bDBH1Lqec4fhz8SUY=; b=llhdVEWl1zWbYrSpKPJKn
	w1q8v87RWwjxcpXciUa++phleyyt6ShsL9AnXLDzAZiUu54n2FbY66USZBZzCcGZ
	3exkk+x/IOR/ZKjWGMmqLea7aW0jCFl6dXkftKKeOpC6DEzwYw/3woWQ4U/4kvIX
	K78IOqZAlvua3J3Ykp+wLM=
Received: from localhost.localdomain (unknown [116.128.244.171])
	by gzga-smtp-mta-g0-0 (Coremail) with SMTP id _____wDHr7+NLeFlC0ffBA--.60409S12;
	Fri, 01 Mar 2024 09:22:11 +0800 (CST)
From: Genjian <zhanggenjian@126.com>
To: 1192843200@qq.com
Cc: Siddh Raman Pant <code@siddh.me>,
	syzbot+a8e049cd3abd342936b6@syzkaller.appspotmail.com,
	stable@vger.kernel.org,
	Matthew Wilcox <willy@infradead.org>,
	Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>,
	Genjian Zhang <zhanggenjian@kylinos.cn>
Subject: [PATCH 4.19.y 8/9] loop: Check for overflow while configuring loop
Date: Fri,  1 Mar 2024 09:19:43 +0800
Message-Id: <20240301011944.2197153-9-zhanggenjian@126.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240301011944.2197153-1-zhanggenjian@126.com>
References: <20240301011944.2197153-1-zhanggenjian@126.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDHr7+NLeFlC0ffBA--.60409S12
X-Coremail-Antispam: 1Uf129KBjvJXoW7Zr1xur4Utw4DAF45AFW5Wrg_yoW8Kw18pF
	43WryUZ3yrKF4UCFsrt34kXryrW3WDGFy3G39Fy345u390vrnavry7Cr93ur95JryUZFWS
	gFn3Jry8Z3WUZrUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07b7g4hUUUUU=
X-CM-SenderInfo: x2kd0wxjhqyxldq6ij2wof0z/1tbiyAiUfmWWf0l6ZQABsx

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
---
 drivers/block/loop.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 0fefd21f0c71..c1caa3e2355f 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1271,6 +1271,11 @@ loop_set_status_from_info(struct loop_device *lo,
 
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
-- 
2.25.1


