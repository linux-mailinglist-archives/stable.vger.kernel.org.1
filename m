Return-Path: <stable+bounces-119880-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3006AA48F1D
	for <lists+stable@lfdr.de>; Fri, 28 Feb 2025 04:27:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AB15A7A7B71
	for <lists+stable@lfdr.de>; Fri, 28 Feb 2025 03:26:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41E6816F265;
	Fri, 28 Feb 2025 03:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="HYG69VvP"
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D29BE14A4DF;
	Fri, 28 Feb 2025 03:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740713256; cv=none; b=uR8Awiu0VlmJQEOfB+7mELw3fiRoD94d2I4kbbaZvTFDMQJzfBjo38oq+JEa8XzR7KjDq0nzVFiZJeGrJQ0tuXHKIyShShuy1MHDVcPAUstgFLOxZKFUklyveXsT8kMLPAYgrxSczeNn5rQSoWL1+9l5E9gmoIkxOLVpRrgJQec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740713256; c=relaxed/simple;
	bh=42jlYnLuKDhskB3kk6Sbtyrl5aakp19MNrnmogmDXzY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lB0wtfWQ1Fuabzjy/vtK0W9hzuGTeDRpnQUxS1DfUQ7X5s5ca+Tm4qUdG1NkK7s/Q9C2opkrUZto7tfq3NG/7CYFOHaaI3ULyPRn0oXK9eRR3PmbMmdltrZmTRRyBU041KAFvoVbBNzBxsrXwi9OMjQGcaVOmUcoFmab5QmAQfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=HYG69VvP; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=P95FE
	Xvftqpy2CJ7poGrPUvDjDKXYMp27W5tWezeZeI=; b=HYG69VvPoLP4yawKaEQFs
	gITM2Hp0Z8UP++caJNFIKpx0myNHOQXclysZtZpcr+sgE/ADlafsmTU+d8RKxrSq
	0jnOh5Auou4x8hME3Ha7XxfsysJui2Y+njcXH9F39LvQ5vYUyXnjK4ji72jDjDrk
	f3nRBFQYP8GtTTY7Hv6ISM=
Received: from icess-ProLiant-DL380-Gen10.. (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wBnq08ZLcFnrvq6PA--.50291S4;
	Fri, 28 Feb 2025 11:27:22 +0800 (CST)
From: Haoxiang Li <haoxiang_li2024@163.com>
To: morbidrsa@gmail.com,
	gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	Haoxiang Li <haoxiang_li2024@163.com>,
	stable@vger.kernel.org
Subject: [PATCH] mcb: fix a double free bug in chameleon_parse_gdd()
Date: Fri, 28 Feb 2025 11:27:20 +0800
Message-Id: <20250228032720.3745459-1-haoxiang_li2024@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wBnq08ZLcFnrvq6PA--.50291S4
X-Coremail-Antispam: 1Uf129KBjvdXoWruFyDGryrKF15uw48ZF13urg_yoW3KFg_Gr
	409rW7ZF40kFW3Kry3Jr1Svry8tanFgrZ5ur47t393Ars5WryqqryrZF1fKrykWF1xuFyU
	Ca4DKryIkrW2gjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRWGQhUUUUUU==
X-CM-SenderInfo: xkdr5xpdqjszblsqjki6rwjhhfrp/xtbB0goCbmfBJpfOVAAAs5

In chameleon_parse_gdd(), if mcb_device_register() fails, 'mdev'
would be released in mcb_device_register() via put_device().
Thus, goto 'err' label and free 'mdev' again causes a double free.
Just return if mcb_device_register() fails.

Fixes: 3764e82e5150 ("drivers: Introduce MEN Chameleon Bus")
Cc: stable@vger.kernel.org
Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
---
 drivers/mcb/mcb-parse.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mcb/mcb-parse.c b/drivers/mcb/mcb-parse.c
index 02a680c73979..bf0d7d58c8b0 100644
--- a/drivers/mcb/mcb-parse.c
+++ b/drivers/mcb/mcb-parse.c
@@ -96,7 +96,7 @@ static int chameleon_parse_gdd(struct mcb_bus *bus,
 
 	ret = mcb_device_register(bus, mdev);
 	if (ret < 0)
-		goto err;
+		return ret;
 
 	return 0;
 
-- 
2.25.1


