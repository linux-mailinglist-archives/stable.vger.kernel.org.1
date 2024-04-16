Return-Path: <stable+bounces-39994-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 51E988A668C
	for <lists+stable@lfdr.de>; Tue, 16 Apr 2024 10:57:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE513281AD4
	for <lists+stable@lfdr.de>; Tue, 16 Apr 2024 08:57:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ADA184D0A;
	Tue, 16 Apr 2024 08:57:06 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D65484D09
	for <stable@vger.kernel.org>; Tue, 16 Apr 2024 08:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713257826; cv=none; b=d+ctNsWyu0kEXbTQAO8gPelcRNHjczKMJOTg1l4YWpBstx+b/yuhBuMNgiq/8GBbHKbwWLZdbgTNgfv5u4mtspRCX8vKQ3MXBY+z+OzlX4nbmSmLhNm/IyMGsaM7MmLCCoVtqr4npNmzSaY4jEl3LpT9h1/uudd28aC1FJi+v44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713257826; c=relaxed/simple;
	bh=BYaKL0mKSGy3afKqzT/8sIfTS/gUhFccGBES8R9FyGA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QfchB41GUjT6afBYBcu1HP3ZcYytwvyFl5XBqEBm2UEntjM9SvUvXciXFpRoI03XyscY+jjkO2LGrIcsIReBuXNstpW7pTu7EiL0IPiN6o8SRCPoAYbtPwqvwacrSBdNgRvv+lLNvgD4qwOnQluNP37fxi1+d/sWdoNswYooN7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from xmz-huawei.. (unknown [120.221.12.99])
	by APP-05 (Coremail) with SMTP id zQCowACnNBJRPR5mLarnAw--.16697S2;
	Tue, 16 Apr 2024 16:56:50 +0800 (CST)
From: Mingzheng Xing <xingmingzheng@iscas.ac.cn>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org,
	Mingzheng Xing <xingmingzheng@iscas.ac.cn>
Subject: [PATCH] Revert "riscv: kdump: fix crashkernel reserving problem on RISC-V"
Date: Tue, 16 Apr 2024 16:56:47 +0800
Message-Id: <20240416085647.14376-1-xingmingzheng@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowACnNBJRPR5mLarnAw--.16697S2
X-Coremail-Antispam: 1UD129KBjvJXoW7tFWkXFy8Cw4fZFy8tr4ruFg_yoW8Wr18pr
	4xCws3JrWFyFnrGayfJrZ7uFyFvas29ry3Xr47Aw1fJF43tr15KwnYqFy7Xry5Kr4FgFy2
	yFWqkr1v9FW5J3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUym14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1l42xK82IYc2Ij64vI
	r41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8Gjc
	xK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1Y6r17MIIYrxkI7VAKI48JMIIF0xvE2Ix0
	cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8V
	AvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E
	14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x0JUqQ6JUUUUU=
X-CM-SenderInfo: 50lqwzhlqj6xxhqjqxpvfd2hldfou0/1tbiBgwJCmYd+6bUOQABsD

This reverts commit 1d6cd2146c2b58bc91266db1d5d6a5f9632e14c0 which has been
merged into the mainline commit 39365395046f ("riscv: kdump: use generic
interface to simplify crashkernel reservation"), but the latter's series of
patches are not included in the 6.6 branch.

This will result in the loss of Crash kernel data in /proc/iomem, and kdump
loading the kernel will also cause an error:

```
Memory for crashkernel is not reserved
Please reserve memory by passing"crashkernel=Y@X" parameter to kernel
Then try to loading kdump kernel
```

After revert this patch, verify that it works properly on QEMU riscv.

Link: https://lore.kernel.org/linux-riscv/ZSiQRDGLZk7lpakE@MiWiFi-R3L-srv
Signed-off-by: Mingzheng Xing <xingmingzheng@iscas.ac.cn>
---
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


