Return-Path: <stable+bounces-119804-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4A57A476A5
	for <lists+stable@lfdr.de>; Thu, 27 Feb 2025 08:34:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E90AC16BC39
	for <lists+stable@lfdr.de>; Thu, 27 Feb 2025 07:34:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB06C21CC78;
	Thu, 27 Feb 2025 07:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="j4Cmhru9"
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72D162563;
	Thu, 27 Feb 2025 07:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740641677; cv=none; b=RaRifcIHdeBO6aNFlewEFQjzg6KEhk4abdu8l3RSUwRvMKw0amjQsxH/H/k4dSTzR2IJduINcPveiWmL71ouTXwV6A/XxG3Euf1eSkggUog34rVhbtXvfUa+BR1/+JMVBgHc3k+8eC7WKpPN2MqSvMpF1VDwYVU8MXResN+M3zQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740641677; c=relaxed/simple;
	bh=1XtWTTDwdqru/LxpCSfu/zYkg/F9BKXSllDXArlX4YM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=f656Kirh6G0Gnw/5KQSEPnMZzoNvaL9IR1VLDErSH0DmTXa4GZedjRNWoWudGBcV/0kf6MiaoPYxf3El8xZXqrET0WwrU2rBteY3OSZOMvPK2eg3lval8tl/XOyHbtqKCQ3QTL5WofbT3Jo69vXUKwZdr9ijne8d5slBfbEr5ZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=j4Cmhru9; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=wIfO5
	6z05F/fTzzXfikezxZ/hLJ2OSnyqGxAmSDvH4M=; b=j4Cmhru9VjqhsM3mNkIqh
	MvA+dSmh16/ToVQuO8FVkbkX+iy0XoB/cW2z/hkfW9ufFOQ3VysuJLAIahgGhzJC
	qGEawq2QcLm6ME5yhY+jp/mT9j3yZDT32Y7zKddkohbyuCsyDJghKgndwiuUh48o
	iaBqjuSFeWeVlJijIJEVHk=
Received: from icess-ProLiant-DL380-Gen10.. (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wD3b+t1FcBnBEGUOw--.21925S4;
	Thu, 27 Feb 2025 15:34:14 +0800 (CST)
From: Haoxiang Li <haoxiang_li2024@163.com>
To: mporter@kernel.crashing.org,
	alex.bou9@gmail.com,
	haoxiang_li2024@163.com,
	akpm@linux-foundation.org,
	error27@gmail.com
Cc: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2] rapidio: fix an API misues when rio_add_net() fails
Date: Thu, 27 Feb 2025 15:34:09 +0800
Message-Id: <20250227073409.3696854-1-haoxiang_li2024@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3b+t1FcBnBEGUOw--.21925S4
X-Coremail-Antispam: 1Uf129KBjvdXoW7XF1ktr15GF1rXr45Kr4UJwb_yoWkJrgE9w
	1v9rn7Xws5AF48Kry5Gwn5Zw4F93WxJrs3Ar4jgFZ3GrZ3XrnFgr1UZrs5tw15uF1rZF97
	Za48Kr1rCw47WjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sREsXoUUUUUU==
X-CM-SenderInfo: xkdr5xpdqjszblsqjki6rwjhhfrp/xtbBkAwBbmfAEhRbwwAAsK

rio_add_net() calls device_register() and fails when device_register()
fails. Thus, put_device() should be used rather than kfree().
Add "mport->net = NULL;" to avoid a use after free issue.

Fixes: e8de370188d0 ("rapidio: add mport char device driver")
Cc: stable@vger.kernel.org
Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
---
Changes in v2:
- Add "mport->net = NULL;" to avoid a use after free issue. Thanks, Dan!
---
 drivers/rapidio/devices/rio_mport_cdev.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/rapidio/devices/rio_mport_cdev.c b/drivers/rapidio/devices/rio_mport_cdev.c
index 27afbb9d544b..cbf531d0ba68 100644
--- a/drivers/rapidio/devices/rio_mport_cdev.c
+++ b/drivers/rapidio/devices/rio_mport_cdev.c
@@ -1742,7 +1742,8 @@ static int rio_mport_add_riodev(struct mport_cdev_priv *priv,
 		err = rio_add_net(net);
 		if (err) {
 			rmcd_debug(RDEV, "failed to register net, err=%d", err);
-			kfree(net);
+			put_device(&net->dev);
+			mport->net = NULL;
 			goto cleanup;
 		}
 	}
-- 
2.25.1


