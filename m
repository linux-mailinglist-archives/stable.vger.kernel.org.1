Return-Path: <stable+bounces-62734-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 46C95940EB0
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 12:11:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9C161F26817
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 10:11:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F00E1991A7;
	Tue, 30 Jul 2024 10:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="Ohbt2RK5"
X-Original-To: stable@vger.kernel.org
Received: from out203-205-221-240.mail.qq.com (out203-205-221-240.mail.qq.com [203.205.221.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3839B197A9F;
	Tue, 30 Jul 2024 10:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722334279; cv=none; b=RlppvLSqpb75oljhe5GWaCqv/rGCS5H125qUkewBVs48nAawfmBW60Gm9Qxlv4ABMwObT+3OvOdkqpxhDlyQkR9ZCxoKgxqqq3ZaiypDawnLqtbr0DfZLrNg1BCGGmDbHAbKeaXbPTJTGmyC+XTjYwMd2HLAB4GHp0fmAOww6no=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722334279; c=relaxed/simple;
	bh=FtrnbrfAmCKXlknarmYd/TWw6g5+8+rtYnvD70zTvNI=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=ayjxzZK8sWXvKNHs1ar6niPzNBSYs2UotJMOctKWbSntyW8DR6ZruiPK2FxCIM2MdjtK656gOyKMKvPV4NLxVK9/dgBx0K4xvjqc9gDBPqfkblN2/UySIdAkwnVTt6IPwgAtg3Dby3SgjQfJnroiBbBKIs6zhkQH0TMcmANDGCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=Ohbt2RK5; arc=none smtp.client-ip=203.205.221.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1722334273; bh=PLMcArhzuuAKwrdf7sy/491o8NduT+1VCqvCj3//12U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Ohbt2RK5wFku2xQiD1v8xHT/hASgUv7tEaeJZ8TmrWVGOrFOpvYNm1GChz77wtMRL
	 38PSxFBjyCJ/bANiUzMKrtKcoHisBZPgXI+4+l8J9rKYK56XXhvMmBg0vzBUjwMARt
	 rZf7jPo0dsadGRP9Uasth6es3eIp9T/l/E2C5l5Q=
Received: from localhost.localdomain ([36.111.64.84])
	by newxmesmtplogicsvrszc5-2.qq.com (NewEsmtp) with SMTP
	id 2CA97060; Tue, 30 Jul 2024 18:11:10 +0800
X-QQ-mid: xmsmtpt1722334270t5qglkr8y
Message-ID: <tencent_16253196C5C7F0141593B633CA21A0150505@qq.com>
X-QQ-XMAILINFO: OKkKo7I1HxIeyPzr2ei58d1lwO6YM6ke1aeoyErQNfKKDIeoQVy7O+ipIxkWG4
	 xjlN/HM0vNybHghs3tSHJyT6QZLjAJfQTRVfxHFtqrkRNM8rvudCaTRLK7kgIXGzsK8i/q+GmdR4
	 6+V0MfpOnFGomHi4UyxKbSnPisVSICLtfN5ubwT7oiBmxdVUJE26VgwjjL1f6HMzIHT+mOLSLQp2
	 QZ/EkYvixc15mvIqaAkZLIkmd2+8X8lbz2tmLyQMCQikosoeb3l670/sCV/XStHKxlVfjt1ECLbQ
	 ld39Gp8lc7JtE6W5ZYEpw3phAlvVBw9gL+p4/zwpzUWS0QD/D9ezK+F73ClEtRZeihzJhelezdKe
	 6Hq2GIwgwVeYB4ZihQWhQZmdaibPG4m/xtJismEJmAneRPwqxoBf/EiMGcdCA+zEBqkrFA3dQA1s
	 vdBFbf2If2l8yzVQTP0WskBHtpwjA72i92WWIX6pWsDDtAgUfEk3AexblQjkNMRnnhHRMl1JvtCJ
	 M/1nsgWHZg5Qr5gKqGDcntW1wuIDmi2BQbX+NpP1pLlKoa6kUbO7l2CKwqAvlQ+ZfAO2J55C9bgi
	 cBC3nIuOUxK8fUlKx9LgZAXDo06LXWwvsZOs2c+6HVRFgxgFkBHBZXrvEIqzi537Dy/IC0O2bUJ6
	 PMTvZfV1O64gIE9BafZiB7pFgjRU9vltCHgvll4u2YBSV+WVAGK/cvim03ZJhK7o7cUB3AyamnTu
	 VCZTBjK7/xR9dLkl333ug7Oa/WZp74n+t8VuCGx6xzgAViv50H5Zv4hSPfaDW74UL/BSnkEglZRw
	 sJozO4nt4Xs3Ha88Xn2cG2wJJ4p/zOYbbzDwuKpcRttWg3UjCe7UpIhO0lpxE6k2CTX5xSr2Wqn7
	 LHOM5aLdIzOK1uaF364uhQz646c1O68vSSJ3En7Xdx/3sUtg+sP5r+gRxjfri661vrGu33gU+0OQ
	 gc7FmveYMAGoHGTi9o5UmI4GPu/5dzYHU5fpJqQ+GEC6Ui929r3wZkDlczQSJErNMQ5HGmySr44F
	 LYGMmYkhqjOmKm6+R68im2Q+ocO5E=
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
From: wujing <realwujing@qq.com>
To: gregkh@linuxfoundation.org
Cc: dongml2@chinatelecom.cn,
	linux-kernel@vger.kernel.org,
	menglong8.dong@gmail.com,
	mingo@redhat.com,
	peterz@infradead.org,
	realwujing@qq.com,
	stable@vger.kernel.org,
	yuanql9@chinatelecom.cn
Subject: Re: Re: [PATCH] sched/fair: Correct CPU selection from isolated domain
Date: Tue, 30 Jul 2024 18:11:06 +0800
X-OQ-MSGID: <20240730101107.58814-1-realwujing@qq.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <2024073011-operating-pointless-7ab9@gregkh>
References: <2024073011-operating-pointless-7ab9@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> On Tue, Jul 30, 2024 at 05:40:17PM +0800, wujing wrote:
> > > What "current patch"?
> > >
> > > confused,
> > >
> > > greg k-h
> >
> > The current patch is in my first email.
>
> What message exactly?  I don't see any such message on the stable list.
>
> > Please ignore the previous two emails.
> > The "current patch" mentioned in the earlier emails refers to the upstream
> > status, but the latest upstream patch can no longer be applied to linux-4.19.y.
>
> Again, please read:
>     https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
> for how to do this properly.
>
> thanks,
>
> greg k-h

The email you just replied to is correct.

I reviewed the link in the email, and according to the link,
the patch I submitted meets the third criterion. I have noted
Upstream commit <8aeaffef8c6e> in the patch log.



From 9d4ecc9314088c2b0aa39c2248fb5e64042f1eef Mon Sep 17 00:00:00 2001
From: wujing <realwujing@gmail.com>
Date: Tue, 30 Jul 2024 15:35:53 +0800
Subject: [PATCH] sched/fair: Correct CPU selection from isolated domain

We encountered an issue where the kernel thread `ksmd` runs on the PMD
dedicated isolated core, leading to high latency in OVS packets.

Upon analysis, we discovered that this is caused by the current
select_idle_smt() function not taking the sched_domain mask into account.

Upstream commit <8aeaffef8c6e>

Kernel version: linux-4.19.y

Signed-off-by: wujing <realwujing@qq.com>
Signed-off-by: QiLiang Yuan <yuanql9@chinatelecom.cn>
---
 kernel/sched/fair.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 09f82c84474b..0950cabfc1d0 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6171,7 +6171,8 @@ static int select_idle_smt(struct task_struct *p, struct sched_domain *sd, int t
 		return -1;

 	for_each_cpu(cpu, cpu_smt_mask(target)) {
-		if (!cpumask_test_cpu(cpu, &p->cpus_allowed))
+		if (!cpumask_test_cpu(cpu, &p->cpus_allowed) ||
+			!cpumask_test_cpu(cpu, sched_domain_span(sd)))
 			continue;
 		if (available_idle_cpu(cpu))
 			return cpu;
--
2.45.2


