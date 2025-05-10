Return-Path: <stable+bounces-143076-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF1D6AB2156
	for <lists+stable@lfdr.de>; Sat, 10 May 2025 07:45:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CF2FA042A7
	for <lists+stable@lfdr.de>; Sat, 10 May 2025 05:45:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C43641C6FE8;
	Sat, 10 May 2025 05:45:49 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from sgoci-sdnproxy-4.icoremail.net (sgoci-sdnproxy-4.icoremail.net [129.150.39.64])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2550829D0B
	for <stable@vger.kernel.org>; Sat, 10 May 2025 05:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.150.39.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746855949; cv=none; b=gbWb0HY2q9WY0uaxr++mMq0b4JFoUXBTTUphOWngtKBI1UcrPBSn7f++WN4K/5/eddsBasjtOL0lnth8Iusytwmn0CW7th3c8EoVpCNW9Giuw0X41SIrWHeF3T49sZ1gdep923R6GiHDfhiosQ4YaIO7RAoHMqrMMnfF31CviiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746855949; c=relaxed/simple;
	bh=9oEEu/SAZUgR46EFqyXrNEVmVFJ4AANa2p+2/FJiFrM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=k9xMQzUjMlN5g6Ja3Hrig/IaIeBbuZeGh1iSvavVrD+eLuT9waTAXuPGy5MmzY4xaTyYif+cPDgvfLzlcQ35GTpyu/rtFoKGCoWIYbpED+SVkp4Hbr1qxiAKqmxMPdsc6EXAa+FdvY82F6mZPhb2guK7g7+jXcQP2nHG7KPtq+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hust.edu.cn; spf=pass smtp.mailfrom=hust.edu.cn; arc=none smtp.client-ip=129.150.39.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hust.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hust.edu.cn
Received: from hust.edu.cn (unknown [172.16.0.50])
	by app2 (Coremail) with SMTP id HwEQrAAXHnrU5x5oZVhEAQ--.1807S2;
	Sat, 10 May 2025 13:44:52 +0800 (CST)
Received: from ubuntu.localdomain (unknown [10.12.190.56])
	by gateway (Coremail) with SMTP id _____wBXXy_R5x5oyUYiAA--.40730S4;
	Sat, 10 May 2025 13:44:50 +0800 (CST)
From: Zhaoyang Li <lizy04@hust.edu.cn>
To: stable@vger.kernel.org
Cc: dzm91@hust.edu.cn,
	Mark Brown <broonie@kernel.org>,
	Will Deacon <will@kernel.org>,
	Zhaoyang Li <lizy04@hust.edu.cn>
Subject: [PATCH 6.1.y] arm64/sme: Always exit sme_alloc() early with existing storage
Date: Sat, 10 May 2025 13:44:24 +0800
Message-Id: <20250510054424.346532-1-lizy04@hust.edu.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <2024012617-overlap-reborn-e124@gregkh>
References: <2024012617-overlap-reborn-e124@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:HwEQrAAXHnrU5x5oZVhEAQ--.1807S2
Authentication-Results: app2; spf=neutral smtp.mail=lizy04@hust.edu.cn
	;
X-Coremail-Antispam: 1UD129KBjvJXoW7ur17uw4fuw15ZrWrKw17Jrb_yoW8XFW8pF
	WkCw1qkr4UWa40k3sxX3Zrur95Gws5WF45WFZxAw1Fyr1YqFyFgFn8Xry3Xw4Fqr9YgFWa
	9F1YvrWFgFWDAw7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBIb7Iv0xC_KF4lb4IE77IF4wAFc2x0x2IEx4CE42xK8VAvwI8I
	cIk0rVWrJVCq3wA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjx
	v20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1l84ACjcxK
	6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1lnxkEFVAIw2
	0F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I2
	7wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0EF7xvrVAajcxG14v26r4UJVWxJr1lYx0E74
	AGY7Cv6cx26r4fZr1UJr1lYx0Ec7CjxVAajcxG14v26r4UJVWxJr1lOx8S6xCaFVCjc4AY
	6r1j6r4UM4x0Y48IcxkI7VAKI48JMxAIw28IcxkI7VAKI48JMxAIw28IcVCjz48v1sIEY2
	0_GFW3Jr1UJwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I
	3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIx
	AIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAI
	cVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2js
	IEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU0dOzDUUUUU==
X-CM-SenderInfo: rpsqjjixsriko6kx23oohg3hdfq/1tbiAQcRB2gdeuFGkAACsq

From: Mark Brown <broonie@kernel.org>

[ Upstream commit dc7eb8755797ed41a0d1b5c0c39df3c8f401b3d9 ]

When sme_alloc() is called with existing storage and we are not flushing we
will always allocate new storage, both leaking the existing storage and
corrupting the state. Fix this by separating the checks for flushing and
for existing storage as we do for SVE.

Callers that reallocate (eg, due to changing the vector length) should
call sme_free() themselves.

Fixes: 5d0a8d2fba50 ("arm64/ptrace: Ensure that SME is set up for target when writing SSVE state")
Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/20240115-arm64-sme-flush-v1-1-7472bd3459b7@kernel.org
Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Zhaoyang Li <lizy04@hust.edu.cn>
---
 arch/arm64/kernel/fpsimd.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index 43afe07c74fd..3a08c7609d1e 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -1234,8 +1234,10 @@ void fpsimd_release_task(struct task_struct *dead_task)
  */
 void sme_alloc(struct task_struct *task, bool flush)
 {
-	if (task->thread.za_state && flush) {
-		memset(task->thread.za_state, 0, za_state_size(task));
+	if (task->thread.za_state) {
+		if (flush)
+			memset(task->thread.za_state, 0,
+			       za_state_size(task));
 		return;
 	}
 
-- 
2.25.1


