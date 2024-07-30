Return-Path: <stable+bounces-62715-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10E3B940DBD
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 11:33:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B16CC2858AB
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 09:33:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA86E195B14;
	Tue, 30 Jul 2024 09:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="MqSPO/PR"
X-Original-To: stable@vger.kernel.org
Received: from out203-205-221-205.mail.qq.com (out203-205-221-205.mail.qq.com [203.205.221.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3C57194C74;
	Tue, 30 Jul 2024 09:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722331848; cv=none; b=re6w7SM3GUKrhWPo9v7cxSOpmZFI0UglIxpZa5nF3+T4h2fLomatsh04GRzk9EBBSZ9jIOXITdGWUvyW/LiwvItfnqJJ1/bzsLRkxXDhxeTCMBa+nCJuGSDO30oIp5bvRs3HKTKGg2gf0kBqo4zczn1k4EXYZEbLnqiQdeTOYxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722331848; c=relaxed/simple;
	bh=vavhuKswM/3UJ7RKw8cXf3oDRdQ9aHvYMqr5DHYL9qs=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=WI+LYJS0oGeTVq3PWR8AmqGxUZcdrytCLBmy8zZPamTm1zHs91XWKbzo/nbGxQIehZ1XIohBMQZP1v/+K9Ssmz58fYB4NOhp1/wVA2iK/uTJSg8uOfg1t7c1f9P7d3OaxCPUnMql8NRIi7BCPSFcGqfsAA0o08kni5bgzLGQhiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=MqSPO/PR; arc=none smtp.client-ip=203.205.221.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1722331843; bh=60gLN9JdTKEP1C1p1aBTRlyiT21+gnTSf3rmZ1dVFz4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MqSPO/PRhwWo8+C5zAo0ZlWv1+sF7fT5+ClqK0a5AURaI4N5z/hSHCNuTzYFRjeDk
	 8e/vRvcKl1OuB6JB728AUVKE84/114BssU0uSby0ZBIzZS47QsWye+EQNIGQ8K8Owx
	 sRaT/Ea1UlPbH3lDfpAV6M2A+VaYSEf+EH0sew5o=
Received: from localhost.localdomain ([36.111.64.84])
	by newxmesmtplogicsvrsza10-0.qq.com (NewEsmtp) with SMTP
	id 7A824A46; Tue, 30 Jul 2024 17:30:40 +0800
X-QQ-mid: xmsmtpt1722331840tofj11b2h
Message-ID: <tencent_CFCCB84E378797D6279497D81F9FA5530607@qq.com>
X-QQ-XMAILINFO: NnYhxYSyuBnLh1NkCPE+E5UInBNFFnzezAUa4xpj/YzVcCVfWE72pj9Po61oyj
	 Wfpo4GlRPti7QqA9UX1erGpejJIDVgnrFIyj3jXXe/OdhzEkwTgYrCl5qo3CzJxaEVY62SHp88oL
	 gQShgj7yOiouIlTzQSq0OEhQOUFH3J/mBBHGhvWZgWhOD1fpH2S1DpuZ2zOSBbbtf9S5dFC29/fc
	 FI5Hmz9Nj5VwHX39CMi/rrdX8SQ/qni4fyVHmO18XLxMvkuPYDW92TRu2ijZlr0sdraRSjjiQpbT
	 aC6u+vrOfkTy2FqmckbGdNcAnlYYuUBKt7Mkdo/Iu+ETH1ZtoI6NaVhXxeszNEFTzVP7aO3DYKUv
	 8QO+OwgVZsqeBk2Gwdowl13nPh6DriXY2coJFhYgbQFENAryaWhUCsiiZ0ttRruZSNqiujNTm7S7
	 iGruSBV668LERl8r+cuvSa9nZ7HcRJFzL/TFFue0WGdXQeEtBsfEOuQ4PbwH/l3K4y43V85LqFfh
	 yKRcp7FPNXr28/VXCFziWWBKu+zC7q4+V7C/rpM6JX0UViIEvghvLdO+hyRoUAXTB7ClZ5X+NjUw
	 u04k2AoFiY8k4WtD0HJGkr+zyWZRYclwIXJAByVuInJh+7ALZfrzRrUcppwq1pFm7gOwy4fqTlZY
	 hEGUEk1zbfeiGZ+XzY2V0b880c/l0AVzAs4eD4jc2g08kVXGVB+76QQRVucTchcI/5SoeLT3781r
	 zNq5lx78nW5wtm2ouG7TWSH/pmRMkIBrTwj1dM3eYwBXg9RH99UN8BoE2yqGOWNY1NBv6Uf0hLQ8
	 6F3wkbdqRH0d4iMUfGb1/OOKKLesfERsWkpkHRsOX1OlFx6GYavk16nYKupSMjj9U5GmmMkU8Q3h
	 pq+ZxXxS6IodI1HZXSgZon8TzuwLVkNBkQKgn0mGksxGyqaET/3N7wkKwRpI0x12OK6SQNs0pBt5
	 KXIbugF5j6/UA4SLbNlY0snAzKibe28jG0iAQhNpLKVavHRcbdDBq6i+hxeGyvluoQZcNTZiakBq
	 LSexlPgEI2gNtE4PTNICNeoxNDqIYSitMv8LtJaoyEh02KGJkHRguMMsKQ/IM=
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
Subject: Re: Re: Re: [PATCH] sched/fair: Correct CPU selection from isolated domain
Date: Tue, 30 Jul 2024 17:30:40 +0800
X-OQ-MSGID: <20240730093040.40352-1-realwujing@qq.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <2024073032-ferret-obtrusive-3ce4@gregkh>
References: <2024073032-ferret-obtrusive-3ce4@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> What "current patch"?
>
> confused,
>
> greg k-h

```bash
git remote -v
stable  git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git (fetch)
stable  git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git (push)
```

```bash
git branch
*master
```

In the git repository information provided above, 8aeaffef8c6e is one of the
output items from the command `git log -S 'cpumask_test_cpu(cpu, \
sched_domain_span(sd))' --oneline kernel/sched/fair.c`.


