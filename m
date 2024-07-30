Return-Path: <stable+bounces-62658-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35081940D15
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 11:11:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A067CB2A620
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 09:04:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA090194087;
	Tue, 30 Jul 2024 09:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="df/UTeRk"
X-Original-To: stable@vger.kernel.org
Received: from out203-205-221-240.mail.qq.com (out203-205-221-240.mail.qq.com [203.205.221.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CF83442C;
	Tue, 30 Jul 2024 09:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722330232; cv=none; b=fvmRHM6cvqCwlWZiDDWtyy7S0kDT7bcKs/ezPkjpBzTNtZOidIsxPxZptcxLAneFHgSSKAlIeizf/N8qnW8rc5BtrkTj+J5HXHPXBI1in3vKMD3rTppbet4XXP2NBFa4V/+WlaBFlq3KnM3bhaTE9c8bP73CXWRjpjugeDwcclI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722330232; c=relaxed/simple;
	bh=aT6YWkhZEjQkMgQHoHWRPl+epeU7SgJNatRtcANLLYU=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=CoqXdFWkmHAdowJTR5LkyQTidO7LSui437cxaPymWyWUp9Ey5lsKxnJNrQTNbHfo922lHkMKzKQBWfMxtVGC7FBANMpf96WaiVNyqSHPSGKxTHYfTLfmLz26gNLwwKHkl8zWrQca4rmwhM1rE+fatLEmzXYJLVn1bfI0R3aDOOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=df/UTeRk; arc=none smtp.client-ip=203.205.221.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1722330222; bh=aT6YWkhZEjQkMgQHoHWRPl+epeU7SgJNatRtcANLLYU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=df/UTeRk6OMrA44J1VPz4wDecfgCMZAf1keSpOP7+/rg0OgQCdoquWal6kHhEbrIF
	 7NwPXCW2leY9hKPZQW0R74UBLQq+EM6ThDqtzaJhtzbbqHVYVRYf4E3gOkDVn3TL4m
	 hBTCPwmfkZB9rleklXdgC+0vH3jma24KTxpoK/Bo=
Received: from localhost.localdomain ([36.111.64.84])
	by newxmesmtplogicsvrsza29-0.qq.com (NewEsmtp) with SMTP
	id E632620; Tue, 30 Jul 2024 17:03:38 +0800
X-QQ-mid: xmsmtpt1722330218txljhelz7
Message-ID: <tencent_0C989DE2631E74C23BA8B60EA234C4B2FA0A@qq.com>
X-QQ-XMAILINFO: NQR8mRxMnur9EFx0+urXeijJN/+EJfxmwlNIY4BESdMbuBo+oGNSI8+KoUd3B9
	 CnZUyf58rLslEK8uADQd6L6gQC3EZPf19y1NH5bDfHV4gj46tViFU5jD25hF40HSPR5YoWGyPfdy
	 fI4Uk9W7J+dodq6c6lZfC2vAIoLvzDblfNJp/q0ZwqD42T3t4Ji4UJF0kUzyblNyrHZKFzMlpYLs
	 nHO2TrS6KqgF4U9XJc7kDdySW6PWTvv1Y50NJ7L61gIx3bKhD8eSJ6ElQs/dB3TfyawecUlebuB3
	 J8XmqxbtzZzS78JaaKQ0A0ujk7GaEUEIapOvn562ELhyeV9PIU5uN0wyP0pLLY2YuuBebYC8hj/K
	 YBkc2nlqptrxW2L5ssUN3/tYNB+U+gnT5mXfwnSAjBDixDZEymuU4xWlu1Ie3Q8ONXQD491cvAbK
	 3WQIk9/ZN7Nf2p2oZj9vtY172XmpIF4U/UPyDEl877d6t6S2qyUuA/KNG/XnPVDcs5lmO271Wrbo
	 ZtNzyUgarDYdDPmgMuwYg2D5igxikBKT6oL2G2SErjPKnkbT4ep/RdJJcLPzlEFxgv5ok5p7VUKD
	 5/oMucmjCLU48ea3ebIy8bb9SN9pn1hrtLODBNcEUSYWG8858A4Ha7Qrq0KCE+b6zHd6s+m6/b0P
	 tMS0JMLfdmT37iiUZPL6R65t11YqLUyDF4KBGOODOU4PFCqN2OueE3NWa+OPnhQyIxUdQJZpfGVk
	 wjy8UoMsaK09RhQuPgxz/pqEsSX4OXECX3YZR+d8imUq1ihqFFkyAo2BiEpoaMOLoTBJz5auwGqS
	 3mtu/m90/1giQMqqBI3eTBLjcb+sDe1pz7QGqcPsSVHvpr6M0teqIIciHaq/5FHKp3f4miqlOQor
	 hxCWCDmJgsxjHOKe1epvf9Vw1+stby01YmNL/6jOJKfzp3NNIkTxCaQZJ5LLpAQ1t+DFayBkN6e4
	 2uhny4FV7VorVH8mseI1Qo8wqAZtiyZp/4lD2cFKbllYUd7xAheVnODUT3hZdj
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
From: wujing <realwujing@qq.com>
To: peterz@infradead.org
Cc: dongml2@chinatelecom.cn,
	linux-kernel@vger.kernel.org,
	mingo@redhat.com,
	realwujing@qq.com,
	yuanql9@chinatelecom.cn,
	stable@vger.kernel.org,
	mengong8.dong@gmail.com
Subject: Re: Re: [PATCH] sched/fair: Correct CPU selection from isolated domain
Date: Tue, 30 Jul 2024 17:03:38 +0800
X-OQ-MSGID: <20240730090338.28438-1-realwujing@qq.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240730082239.GF33588@noisy.programming.kicks-ass.net>
References: <20240730082239.GF33588@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> If you're trying to backport something, I think you forgot to Cc stable
> and provide the proper upstream commit.
>
> As is this isn't something I can do anything with. The patch does not
> apply to any recent kernel and AFAICT this issue has long since been
> fixed.

When fixing this bug, I didn't pay much attention to upstream changes.
Upon reviewing the history of relevant commits, I found that they have
been merged and reverted multiple times:

```bash
git log -S 'cpumask_test_cpu(cpu, sched_domain_span(sd))' --oneline \
kernel/sched/fair.c

8aeaffef8c6e sched/fair: Take the scheduling domain into account in select_idle_smt()
3e6efe87cd5c sched/fair: Remove redundant check in select_idle_smt()
3e8c6c9aac42 sched/fair: Remove task_util from effective utilization in feec()
c722f35b513f sched/fair: Bring back select_idle_smt(), but differently
6cd56ef1df39 sched/fair: Remove select_idle_smt()
df3cb4ea1fb6 sched/fair: Fix wrong cpu selecting from isolated domain
```

The latest upstream commit 8aeaffef8c6e is not applicable to linux-4.19.y.
The current patch has been tested on linux-4.19.y and I am looking forward
to its inclusion in the stable version.


