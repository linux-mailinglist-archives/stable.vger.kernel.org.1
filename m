Return-Path: <stable+bounces-41789-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 45CB08B687D
	for <lists+stable@lfdr.de>; Tue, 30 Apr 2024 05:24:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE8351F22498
	for <lists+stable@lfdr.de>; Tue, 30 Apr 2024 03:24:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB807FC12;
	Tue, 30 Apr 2024 03:24:42 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0006D6FB1
	for <stable@vger.kernel.org>; Tue, 30 Apr 2024 03:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714447482; cv=none; b=r04ZyU/Uh+QhNkjXwZ9zczq1QbSk7XcMc3bnNIKfpiYi8jFAV/FgF/1Olt9VCPWg9gDvIkeuixNpAMErzW6zlGjSA+kkBtqtDr/9Dj1lHy7Bz4iC+8AEMt5wZMKnP9RtaCodLpOPsdFoKklSUM3RR9Hbl9UXQnTV0sRsWvpjjwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714447482; c=relaxed/simple;
	bh=xlh1s0qjKpnf8kbV/PzHG56yUQnbTC71swCQcv3tYMc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kd8Rk2tYmauqlNWCcGIGNpdzraDFFoLsYXH2vQhD5bTvQbf4l06jq1/UBl597/EOnklhjLkBJy5iIZspjBQ52IDVg7ZWwcRTpSOnRqWrmHC+9DagN8A+kyXOJEYh3AORpaBxgCaY+i1PsQK/h7z/EfKNaBg04q8iwhfeysYIJIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from xmz-huawei.. (unknown [120.221.12.99])
	by APP-01 (Coremail) with SMTP id qwCowABnbBhiZDBm0YJtAQ--.46749S2;
	Tue, 30 Apr 2024 11:24:22 +0800 (CST)
From: Mingzheng Xing <xingmingzheng@iscas.ac.cn>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org
Cc: Baoquan He <bhe@redhat.com>,
	Mingzheng Xing <xingmingzheng@iscas.ac.cn>,
	Chen Jiahao <chenjiahao16@huawei.com>
Subject: [PATCH v2] Revert "riscv: kdump: fix crashkernel reserving problem on RISC-V"
Date: Tue, 30 Apr 2024 11:24:03 +0800
Message-Id: <20240430032403.19562-1-xingmingzheng@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowABnbBhiZDBm0YJtAQ--.46749S2
X-Coremail-Antispam: 1UD129KBjvJXoW7CFW8tw13trW3Ary7tw1UZFb_yoW8Ww13pr
	4xCws8JrWFkFn7GayrJw1xuFyFgasagry3Wr43Aw1fJF43try5GwnYqFy3Xryjgr4rKFy3
	AF4q9r1v9rW5J3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyG14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r1j
	6r4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr
	1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv
	7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r
	1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCF04k20xvY0x0E
	wIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E74
	80Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0
	I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04
	k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7Cj
	xVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7VUj6pB7UUUUU==
X-CM-SenderInfo: 50lqwzhlqj6xxhqjqxpvfd2hldfou0/1tbiCQ8DCmYwMTKbUAABsQ

This reverts commit 1d6cd2146c2b58bc91266db1d5d6a5f9632e14c0 which was
mistakenly added into v6.6.y and the commit corresponding to the 'Fixes:'
tag is invalid. For more information, see link [1].

This will result in the loss of Crashkernel data in /proc/iomem, and kdump
failed:

```
Memory for crashkernel is not reserved
Please reserve memory by passing"crashkernel=Y@X" parameter to kernel
Then try to loading kdump kernel
```

After revert, kdump works fine. Tested on QEMU riscv.

Link: https://lore.kernel.org/linux-riscv/ZSiQRDGLZk7lpakE@MiWiFi-R3L-srv [1]
Cc: Baoquan He <bhe@redhat.com>
Cc: Chen Jiahao <chenjiahao16@huawei.com>
Signed-off-by: Mingzheng Xing <xingmingzheng@iscas.ac.cn>
---

v1 -> v2:

- Changed the commit message
- Added Cc:

v1:
https://lore.kernel.org/stable/20240416085647.14376-1-xingmingzheng@iscas.ac.cn

 arch/riscv/kernel/setup.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
index aac853ae4eb74..e600aab116a40 100644
--- a/arch/riscv/kernel/setup.c
+++ b/arch/riscv/kernel/setup.c
@@ -173,6 +173,19 @@ static void __init init_resources(void)
 	if (ret < 0)
 		goto error;
 
+#ifdef CONFIG_KEXEC_CORE
+	if (crashk_res.start != crashk_res.end) {
+		ret = add_resource(&iomem_resource, &crashk_res);
+		if (ret < 0)
+			goto error;
+	}
+	if (crashk_low_res.start != crashk_low_res.end) {
+		ret = add_resource(&iomem_resource, &crashk_low_res);
+		if (ret < 0)
+			goto error;
+	}
+#endif
+
 #ifdef CONFIG_CRASH_DUMP
 	if (elfcorehdr_size > 0) {
 		elfcorehdr_res.start = elfcorehdr_addr;
-- 
2.34.1


