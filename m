Return-Path: <stable+bounces-192692-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 31F28C3EDCA
	for <lists+stable@lfdr.de>; Fri, 07 Nov 2025 09:02:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 127A718820E0
	for <lists+stable@lfdr.de>; Fri,  7 Nov 2025 08:02:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7BEC30E0C2;
	Fri,  7 Nov 2025 08:01:47 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E9172E54AA;
	Fri,  7 Nov 2025 08:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762502507; cv=none; b=TC6fKtEbreQCUbtU3I899+uoKDwPrPmEVnCqdVRHLFsbVZHo8SOZpD7oF1A75FNPKFgfwwfGwmrASG/FvkoC4VpJHeidoMtKNldpZFL45VNgDica6IkH4yL4voCfSHq6hmU2IIWPV88FBa7qziA35twjKyqHUHC8w1XaPNGLSMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762502507; c=relaxed/simple;
	bh=uQtoVfEhislDIn8sEGj3Bst3lX9RqEJuI/gzLz6xqIk=;
	h=From:To:Cc:Subject:Date:Message-Id; b=ZDISZtBvVROhEb5y2koYiU7QNYb7MgkG5+BnEpwe7GcriePAP5MPMG2LR5kRsHUZBJMeeKQwdNYdkBNLD9GJ4H7HyU58u1y0pgAePzPc3YyPFc0+3jXRbounn/fbGOzhgNthqSQ47bR0C1xdP7AhURpefTJPi1NO4so/pdUBzIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [202.112.113.212])
	by APP-05 (Coremail) with SMTP id zQCowADHcO9Opw1p7Z7fAQ--.5941S2;
	Fri, 07 Nov 2025 16:01:27 +0800 (CST)
From: Ma Ke <make24@iscas.ac.cn>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	sdf@fomichev.me,
	atenart@kernel.org,
	kuniyu@google.com,
	yajun.deng@linux.dev,
	gregkh@suse.de,
	ebiederm@xmission.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	Ma Ke <make24@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] net: Fix error handling in netdev_register_kobject
Date: Fri,  7 Nov 2025 16:01:17 +0800
Message-Id: <20251107080117.15099-1-make24@iscas.ac.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID:zQCowADHcO9Opw1p7Z7fAQ--.5941S2
X-Coremail-Antispam: 1UD129KBjvJXoW7AF43XF13Jw1DAryUZFy7Wrg_yoW8Ar48pw
	45Wa9xJrWkKr4j9ws7ZF1kWa40kF1Ikws3Ca4Fyw1S9rs5Xr9agrWUKrWFg3W8AaykuFy5
	tFy7Cw45ZayUZaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUP014x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVWxJr
	0_GcWlnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xv
	F2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r
	4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I
	648v4I1lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFylc2xSY4AK67
	AK6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAF
	wI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc4
	0Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AK
	xVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr
	1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUjXTm3UU
	UUU==
X-CM-SenderInfo: ppdnvj2u6l2u1dvotugofq/
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

After calling device_initialize(), the reference count of the device
is set to 1. If device_add() fails or register_queue_kobjects() fails,
the function returns without calling put_device() to release the
initial reference, causing a memory leak of the device structure.
Similarly, in netdev_unregister_kobject(), after calling device_del(),
there is no call to put_device() to release the initial reference,
leading to a memory leak. Add put_device() in the error paths of
netdev_register_kobject() and after device_del() in
netdev_unregister_kobject() to properly release the device references.

Found by code review.

Cc: stable@vger.kernel.org
Fixes: a1b3f594dc5f ("net: Expose all network devices in a namespaces in sysfs")
Signed-off-by: Ma Ke <make24@iscas.ac.cn>
---
 net/core/net-sysfs.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/net/core/net-sysfs.c b/net/core/net-sysfs.c
index ca878525ad7c..d3895f26a0c8 100644
--- a/net/core/net-sysfs.c
+++ b/net/core/net-sysfs.c
@@ -2327,6 +2327,7 @@ void netdev_unregister_kobject(struct net_device *ndev)
 	pm_runtime_set_memalloc_noio(dev, false);
 
 	device_del(dev);
+	put_device(dev);
 }
 
 /* Create sysfs entries for network device. */
@@ -2357,7 +2358,7 @@ int netdev_register_kobject(struct net_device *ndev)
 
 	error = device_add(dev);
 	if (error)
-		return error;
+		goto out_put_device;
 
 	error = register_queue_kobjects(ndev);
 	if (error) {
@@ -2367,6 +2368,10 @@ int netdev_register_kobject(struct net_device *ndev)
 
 	pm_runtime_set_memalloc_noio(dev, true);
 
+	return 0;
+
+out_put_device:
+	put_device(dev);
 	return error;
 }
 
-- 
2.17.1


