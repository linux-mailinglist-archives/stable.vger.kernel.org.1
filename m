Return-Path: <stable+bounces-106792-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F3F34A021DF
	for <lists+stable@lfdr.de>; Mon,  6 Jan 2025 10:30:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9834A161C62
	for <lists+stable@lfdr.de>; Mon,  6 Jan 2025 09:30:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 627891D9337;
	Mon,  6 Jan 2025 09:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="RrNO/dgP"
X-Original-To: stable@vger.kernel.org
Received: from out162-62-58-211.mail.qq.com (out162-62-58-211.mail.qq.com [162.62.58.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96E0C1D9324;
	Mon,  6 Jan 2025 09:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.58.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736155784; cv=none; b=OEgSxTlwbwBadeJEnYAbL6sxYPp8BldcEiiivmVB18KuH+TNI6gisMHd1y1CMjswuqbKig/SauU8QvGIIRrGmzpcaPC2m3so7DfrST3epZHLfWxeylOvAj1lmo2LAk0pYHejpTgfsooJsT8spN2ikw7hGOJdBO/UBsilZn7wtzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736155784; c=relaxed/simple;
	bh=rru6PLmrgyfj1x9vmlK7bt52bJgxOGXtSo7CS+zIpFw=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=usa+JQpKvC4DfyrcDZAFNhMoDEWasGg//Rhtg7h4OaXdglkRrzmwbWhalUreqCA2hhLXa9w1ddZRAbwhL7I31zhJA3JjYauvEG5zJgxt8Ab8k/2HqPkDx48juXJ1+Wi+r013CUzB/y/OCedF/DEhQVL3gTrAdQUVqBGaRYGKFTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=RrNO/dgP; arc=none smtp.client-ip=162.62.58.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1736155468; bh=dnX7ibADsVzqp+F5wDH5DMd0+ecoDGczfnfcWBLU/oo=;
	h=From:To:Cc:Subject:Date;
	b=RrNO/dgPz2Ht7uPJBJi9qeZkiUGSI4FLkN6OkXEtzAIzIfAIcvqUj6/BR5Tvu0a01
	 aEhhLAXzdNC8SeYfLwr+tOZcUS8FFjPs2N4rAF7JS63zwZKf4votYDoDW01z4PqqcA
	 oz2a2HRIXmfIEJBFwaHgwnf+gKKB7VvWZhc5hRtQ=
Received: from localhost.localdomain ([101.227.46.164])
	by newxmesmtplogicsvrszb16-1.qq.com (NewEsmtp) with SMTP
	id 61A070E8; Mon, 06 Jan 2025 17:24:26 +0800
X-QQ-mid: xmsmtpt1736155466tddbugve5
Message-ID: <tencent_521DBA5B61506A63077CEC4EE730C53BCD09@qq.com>
X-QQ-XMAILINFO: MllZffuBkEb5Ljyv7yHduB5LNU/Cx8FlR7TfEJIh/3qF28sND14RK6VJw2Cnb1
	 Q+4YGl1+MM9hHzuLT2WanaIp1GTXCzlibwRURMr2/tPX5ojDUKbAXlMiFmsOCC5lABRocNXSvldN
	 MhKwMRgcqvZUk5L3FZBu+UqdLWu8mnrTegJtPEY8KMohkUxXYOT6d/DWZQ+g8RYKjIxkqCEVweEt
	 kWzOGd7NN7/4d6OumexiicjVhi3NvlTDsZk6Z1PcIIKrho7D53JxEhbBZqKNFwkJLTNnBb5jHZ6a
	 uNkHFctZ8u9RlgOHDudwJSAQ+yKiA2MVpYSE8cA1DOe3LzJJGuP8I/YY2C8u2YWcmasoxhYM+KZA
	 V+4c2DW8RJ2zHzZX30bhXNOzwpOQt3fRPq9DSgJv5aaVXmaiI2D/DiJ/0WAk+ihgl6YgUrDW03rY
	 3Kk38S3SOic2TtlEmzk/Hq2GaWNujPbCAnmTcnb6JLV834jDmy3ltPtjQeq5l43YI+nFMaBGvxRp
	 aUG4bv9wBIShpB3jA1JCSk5rLPMUtyCWoChAgzM7rJqdqxENFzO2KQEFawiK+CDQA5HCg58oGZlJ
	 pakpFH0vDAf4Dky8Rg/L402iyw3mxHLgrVyxTVe3EEjNYom6tHXeZ6seKwQZ6oM9cBZXsmpxAxQI
	 YI/jxHMENuY+5PXu+9YqvYFpS8Hl/mccH9qvTiWl39JBwv0FPEbT4mJzwfPXwuytXUr0K6RT96wV
	 2xd8zq8At+CT6bMrOyy3MB7nWx00tY+U4rLkgveVuE26eyFQskD9H/B9BmfCFOvQB/SkxsNN4Fkd
	 vf7asgE3tsFZ7cicYZU3D3QS7YylepbjuCTbGpWgWe4khvhR9r7t1frZWXT0YnKs6OsL/1rMtBvc
	 Y8RQeFjwlHUXaZpOukBa2d7QM8eEHkxRbMxv96VopflqebepFfY8UwmCFuDD/KBqT58obo0MJv5R
	 01ObPyPOHhFKCNldsKm7GOkPhtXfaDXcG55k5vAHIBXN3JShhT75+SwBGanCYTLe9EOWNQ8CVGE+
	 pZMAq08Ub+XWdgXJ0Z/OdX5lSESBidrZdE1W841z9+KbSYrmS7wA5IgaQV1Nc=
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
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
Date: Mon,  6 Jan 2025 17:24:21 +0800
X-OQ-MSGID: <20250106092421.111988-1-realwujing@qq.com>
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

Cc: stable@vger.kernel.org # 4.19.x
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


