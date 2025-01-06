Return-Path: <stable+bounces-106787-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DF7DA02168
	for <lists+stable@lfdr.de>; Mon,  6 Jan 2025 10:04:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C239C188069E
	for <lists+stable@lfdr.de>; Mon,  6 Jan 2025 09:04:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 162701D619E;
	Mon,  6 Jan 2025 09:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="fCLJmzAV"
X-Original-To: stable@vger.kernel.org
Received: from out203-205-221-239.mail.qq.com (out203-205-221-239.mail.qq.com [203.205.221.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85AA31C5F21;
	Mon,  6 Jan 2025 09:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736154258; cv=none; b=VK268m/Fs98C/3vyU9PHCucFRqfop0AZPFvXiqpKfxVXsqi5tE4sO/4SZ4h1qhYIqzvenSNVLy4qr7Bl8u6jcMBrBi9sQ5mWQAAksObTZx6Yg3awLClnzmBkVn+BTKc1PNi9IUdMZIlIsLkP/6otivcZFxOlaTvwl4fvH25frRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736154258; c=relaxed/simple;
	bh=Fwda7ENx6jfw7Tv5idKqtnAlSTwBTZLMw4Fp/soVc+k=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=fh8zx/y8QX0zJVzw7YwMfxeNLpAgwQNY/baUQnGj/v4aHz4AAdpEgfmQ31F3EZPN4MHlkO+sSVk1S8BP36kLxHvOJosIGmfLdwtlaAcFrhwgufqWU2pdCt0QAqOt0XEq/jSrYHHpP12CB6ayPHj8jhLx2HY8nvBgzwcRXYelRaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=fCLJmzAV; arc=none smtp.client-ip=203.205.221.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1736154247; bh=+340KkDQwCYYi+sjsr57zo5fiNS8/fmuOnbgQDlfNvU=;
	h=From:To:Cc:Subject:Date;
	b=fCLJmzAVMw9osaFzU5qHR6CThtktxGGbFuRKFMr5Wt3aGAtnqsVelsEDYU/d8dzhB
	 cSxPv0k+MWgbDE5J9SLggtVWxJ3JkkjhTEDK1M2nu1OWXgsSjdTurheZp5H6akeYRw
	 un1uqgt5y0fuDHkfifZXRHC8Nz7HeYv8OVQVuAYY=
Received: from localhost.localdomain ([101.227.46.164])
	by newxmesmtplogicsvrszc25-0.qq.com (NewEsmtp) with SMTP
	id 10525C45; Mon, 06 Jan 2025 17:04:05 +0800
X-QQ-mid: xmsmtpt1736154245tsquxuqxm
Message-ID: <tencent_44452B098A632CA84FCB293DA658E7BD4306@qq.com>
X-QQ-XMAILINFO: MTEKjEyAppcsDb0OiELRUSiBbE5BpZjZAZaShOeukoqvwhDJ3IprKeths7UWfz
	 PRJ1DDVYSygIQzxOR7VvEVIMJPVBP10joay4UTJQMLuLGUxCTS1NUeYYA3C6g83MfYRkaa2AWe/r
	 HVdgFKTwKOqB8IbW4K9r/svKIF7BAaQCeVqneFhR82z8e52mXHZ1T8AGwSXIR1NWvCBOV/787HbU
	 p1Ts9qlHUpyvY01XezekdSKKwZrkynnIBK6Lz3DOcBxEYqI6AUSguLjG5bFHsrrGM+iPC9L7B8Nz
	 NEiqx4tNSZQiq2XT6iXfS/9vjirST3CPWvpXg7BgRKT9H9mZY+l3CvFbAazq0JS56b2cjveOHkHf
	 z+V+xpeTTVTEigrLDy9Y2d5K0CWn6TIxybzrdR8F20Oiou5RPUpeUNpr8b8wZBJyapH65z4sNXAh
	 0BMityR3tpBi/+uOodojFDgU35rJCxgFKWrH3zI9ba/A8YJBLBzKyiEHh8mJW3jWkzCC/n42VnfU
	 js6undVcPVUL9II+eYX/BdgcPpa1ntUrxEIaO+QWOIo0w1cxr9iFbZZR73gk5KeMW4m1Q2Ubv5/X
	 YWa3Rr72dwdIWhpJVQpRySQPoyydwS9nYrE2/0TxBDRCGc2qCgqsF2MvuYOrYQRP5tbn8woaD/Zf
	 3TZ3JUunCAJ2H03BKUNXpa/Yl3ItnAFlW/r28abUAKCsK0hMO7WjMPoR+dtMtPgwWSjsU9WO8l8J
	 mFGZQ/fOWZPmT/fsFJsjd06UJOSwUN01hX5eTHStwwMU49yRbBrf4RDaEsnuWyUZOMiKyYV2JW8Q
	 xJW37lGOQczFgqTafKqT1dKzBA+ALdk/tYsy9MkXRF6mM0F6e1oyMF9d8MFMBp8flsjMRUABL9TO
	 KqIc2o9GRM6GIHYSiVdu1MeqXkfkWtQX8BuXL5h/thY1I/UOxenTcRAwcftCLGZ8ypCnxe2xuCVA
	 vMCZ1HhUYa1FWUqC7/k4fvabyQHxc16R2OtIvgJ2ebS3uN9DDswGa25J2IJE42gOo2W+b636NilN
	 aLSr6p9Kel3a7/6plHn84JJ3S7fZgOEqdStcWtX0QMDLUQ00caE/oxXIDb2GI=
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
From: wujing <realwujing@qq.com>
To: gregkh@linuxfoundation.org,
	sasha.levin@linux.microsoft.com
Cc: mingo@redhat.com,
	peterz@infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	wujing <realwujing@qq.com>,
	QiLiang Yuan <yuanql9@chinatelecom.cn>
Subject: [PATCH] sched/fair: Fix ksmd and kthreadd running on isolated CPU0 on arm64 systems
Date: Mon,  6 Jan 2025 17:04:03 +0800
X-OQ-MSGID: <20250106090403.102026-1-realwujing@qq.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This bug can be reproduced on Kunpeng arm64 and Phytium arm physical machines,
as well as in virtual machine environments, based on the linux-4.19.y stable
branch:
1. Check the number of CPUs on the system:
   nproc --all
   96

2. Add the parameter isolcpus=0-85 to the grub configuration,
update grub, and reboot.

3. Check the ksmd process:

   ps aux | grep -i ksmd
   root      502  0.0  0.0      0     0 ?        S    10:00   0:00 [ksmd]

   ps -o pid,psr,comm -p 502
   PID PSR COMMAND
   502   0 ksmd

4. Check the kthreadd process:

   ps aux | grep -i kthreadd
   root        2  0.0  0.0      0     0 ?        S    10:00   0:00 [kthreadd]

   ps -o pid,psr,comm -p 2
   PID PSR COMMAND
     2   0 kthreadd

From the output above, it can be seen that both ksmd and kthreadd are still
running on CPU0, which is unreasonable since CPU0 has been isolated.

Signed-off-by: wujing <realwujing@qq.com>
Signed-off-by: QiLiang Yuan <yuanql9@chinatelecom.cn>
---
 kernel/sched/fair.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 0950cabfc1d0..454021ff70a1 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6211,7 +6211,7 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int t
 
 	this_sd = rcu_dereference(*this_cpu_ptr(&sd_llc));
 	if (!this_sd)
-		return -1;
+		return housekeeping_any_cpu(HK_FLAG_DOMAIN);
 
 	/*
 	 * Due to large variance we need a large fuzz factor; hackbench in
-- 
2.39.5


