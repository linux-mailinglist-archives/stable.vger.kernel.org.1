Return-Path: <stable+bounces-124216-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3883A5ED76
	for <lists+stable@lfdr.de>; Thu, 13 Mar 2025 09:02:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 598E73ADB78
	for <lists+stable@lfdr.de>; Thu, 13 Mar 2025 08:02:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 371B01D61BB;
	Thu, 13 Mar 2025 08:02:49 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 064602E3391;
	Thu, 13 Mar 2025 08:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741852969; cv=none; b=uJN1XVYQWPBVkSDz0DOGIAHVq6rybKSApbz9szaJv7ahDK8bYndGQCbubVGNh8UV1C4n9DRHhCLGAewcBbMZejsnKqYYut8gNzrBGOXBvXXQpqCiAj7lwp81xYoP00UxTYPM3LXMtfZo0lHHBBwaCCRtOFe7YLN8EYihjLPRjOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741852969; c=relaxed/simple;
	bh=bVAxUrDNMF7/87dKl8ntYRsXmIQa6n5Pwu3NQrYXZJo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MQrmsS8TWv29dPGWncSNQxh/H1M6Vud2mTobXjnSgD08JjVclrDywthB50loHNWD/RCBBy0JwCKuCRfUPUqu7E3AK9FtFv/O+9s4F6zJ32xsrIAbVwPremxGlzV4niV1azXLQ/RUtLsMmf6XVMut/X/82iUKgxracpkOZNpPFvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from icess-ProLiant-DL380-Gen10.. (unknown [183.174.60.14])
	by APP-03 (Coremail) with SMTP id rQCowAA3PAwMkdJncq_UFA--.3004S2;
	Thu, 13 Mar 2025 16:02:28 +0800 (CST)
From: Ma Ke <make24@iscas.ac.cn>
To: geoff@infradead.org,
	maddy@linux.ibm.com,
	mpe@ellerman.id.au,
	npiggin@gmail.com,
	christophe.leroy@csgroup.eu,
	naveen@kernel.org,
	arnd.bergmann@de.ibm.com
Cc: linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	Ma Ke <make24@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] [POWERPC] ps3: fix error handling in ps3_system_bus_device_register()
Date: Thu, 13 Mar 2025 16:02:19 +0800
Message-Id: <20250313080219.306311-1-make24@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowAA3PAwMkdJncq_UFA--.3004S2
X-Coremail-Antispam: 1UD129KBjvdXoW7GF13GrWUGF4kuFW8uFyUZFb_yoWkuFb_tw
	4Ivas3X3yxJFsrKFn5CF13Crn3GF9IqrWYqr42q3Wxta4rXayq93y8XFyUJw4UWas7Ar45
	AFn8Kr43A3WSkjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbSkFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_
	Gr1UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Cr
	1j6rxdM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVAC
	Y4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJV
	W8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI2
	0VAGYxC7M4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS14v26r1q6r43MxAIw28Icx
	kI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2Iq
	xVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42
	IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY
	6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aV
	CY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VU122NtUUUUU==
X-CM-SenderInfo: ppdnvj2u6l2u1dvotugofq/

Once device_register() failed, we should call put_device() to
decrement reference count for cleanup. Or it could cause memory leak.

As comment of device_register() says, 'NOTE: _Never_ directly free
@dev after calling this function, even if it returned an error! Always
use put_device() to give up the reference initialized in this function
instead.'

Found by code review.

Cc: stable@vger.kernel.org
Fixes: a3d4d6435b56 ("[POWERPC] ps3: add ps3 platform system bus support")
Signed-off-by: Ma Ke <make24@iscas.ac.cn>
---
 arch/powerpc/platforms/ps3/system-bus.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/powerpc/platforms/ps3/system-bus.c b/arch/powerpc/platforms/ps3/system-bus.c
index afbaabf182d0..c477d0ee523a 100644
--- a/arch/powerpc/platforms/ps3/system-bus.c
+++ b/arch/powerpc/platforms/ps3/system-bus.c
@@ -769,6 +769,9 @@ int ps3_system_bus_device_register(struct ps3_system_bus_device *dev)
 	pr_debug("%s:%d add %s\n", __func__, __LINE__, dev_name(&dev->core));
 
 	result = device_register(&dev->core);
+	if (result)
+		put_device(&dev->core);
+
 	return result;
 }
 
-- 
2.25.1


