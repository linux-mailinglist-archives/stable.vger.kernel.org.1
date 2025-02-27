Return-Path: <stable+bounces-119786-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30B42A47402
	for <lists+stable@lfdr.de>; Thu, 27 Feb 2025 05:12:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 696E93A53D1
	for <lists+stable@lfdr.de>; Thu, 27 Feb 2025 04:12:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4FFD1E521C;
	Thu, 27 Feb 2025 04:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="FqBqiK88"
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73390155C83;
	Thu, 27 Feb 2025 04:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740629534; cv=none; b=qf3Ppux+SoWQsWJXpVeQ1b96eAp7n4Np+OaBwUofIsFzY/6L6Gy00xt5TR9YK34U3A9VMxqfmJmI5nxBUV7jSIoVJDmpVHWhJVp61RzZASiZc5Vyb7+OAKhkIhOKHmWqf9j/ocPUQ8USLKlS2tycflb2mAiOa/fqzZURZ+IqQAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740629534; c=relaxed/simple;
	bh=ybY/sARb+gPAvCAk6Va97MKMqDLi75HCr3W/1QuDbMs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=a6L+llLHhSCw4tuaN95/xi4Zr+/R2xtcEND/rwkO7fiOX0/NpcwKMsF5WYDnzyk8ZtBpBUdzi6KbCRWLqkFXU5rRgLUu2YWfEAlJhn3iSYMNVXBtXH45QP+13kM4xvbju8wGVjYfaWXVCSbxMKpLOCLu/qqnPy3M8hvyBNWN7NY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=FqBqiK88; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=sbeia
	VhCJsLMybPrAPQBZ4W7ilebZ7V3fMGQzrDnTS0=; b=FqBqiK88aC2iOBfzZXzha
	ls4fwk3FySNvb1NIhUQ32CJS5s7um1ZQP0NzXBHnKoJOfSb+flhXp++99fMiXsT1
	R/6vHN2KHzl/iL54tzRs1vH2HjWVn7eUR9ChelP4K1g87MJHchplXgp+ij5N94td
	tBqkoLSfDTmKzVvYOLlylo=
Received: from icess-ProLiant-DL380-Gen10.. (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wD3r2_15b9no7HcOw--.42050S4;
	Thu, 27 Feb 2025 12:11:34 +0800 (CST)
From: Haoxiang Li <haoxiang_li2024@163.com>
To: mporter@kernel.crashing.org,
	alex.bou9@gmail.com,
	akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org,
	Haoxiang Li <haoxiang_li2024@163.com>,
	stable@vger.kernel.org,
	Yang Yingliang <yangyingliang@huawei.com>
Subject: [PATCH] rapidio: Add check for rio_add_net() in rio_scan_alloc_net()
Date: Thu, 27 Feb 2025 12:11:31 +0800
Message-Id: <20250227041131.3680761-1-haoxiang_li2024@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3r2_15b9no7HcOw--.42050S4
X-Coremail-Antispam: 1Uf129KBjvdXoW7GrW3ur18WrWUKF43ZFWkZwb_yoWDCrb_WF
	4fWw4fXrZYkF4xtrn09r4avrWS9r48Xrs7uFWaq393JFW3ZwnYgry8urW5G3y7u3y8Crn3
	Z3Wqgr18ur17ujkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRWGQhUUUUUU==
X-CM-SenderInfo: xkdr5xpdqjszblsqjki6rwjhhfrp/1tbiqAQBbme-3Uf9WgAAsm

The return value of rio_add_net() should be checked. If it fails,
put_device() should be called to free the memory and give up the
reference initialized in rio_add_net().

Fixes: e6b585ca6e81 ("rapidio: move net allocation into core code")
Cc: stable@vger.kernel.org
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
---
 drivers/rapidio/rio-scan.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/rapidio/rio-scan.c b/drivers/rapidio/rio-scan.c
index fdcf742b2adb..b9daacc7f1ec 100644
--- a/drivers/rapidio/rio-scan.c
+++ b/drivers/rapidio/rio-scan.c
@@ -871,7 +871,10 @@ static struct rio_net *rio_scan_alloc_net(struct rio_mport *mport,
 		dev_set_name(&net->dev, "rnet_%d", net->id);
 		net->dev.parent = &mport->dev;
 		net->dev.release = rio_scan_release_dev;
-		rio_add_net(net);
+		if (rio_add_net(net)) {
+			put_device(&net->dev);
+			net = NULL;
+		}
 	}
 
 	return net;
-- 
2.25.1


