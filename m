Return-Path: <stable+bounces-62709-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 333CA940DD2
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 11:35:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 173A3B284C8
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 09:33:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DF39194159;
	Tue, 30 Jul 2024 09:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="BDkdyyN1"
X-Original-To: stable@vger.kernel.org
Received: from out203-205-221-202.mail.qq.com (out203-205-221-202.mail.qq.com [203.205.221.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 095CD188CC7;
	Tue, 30 Jul 2024 09:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722331822; cv=none; b=r1DHyGfWgTAObTTLnTStxEglEgo874eGBen2nVvSGYZjhICUqBgOA8N4ENft7+vC6p8QoHkXNSSKp96C8p3KY5j2hNK5mv2ENRO+Zc8+9C3PqWG1KN5rDq6xSi0yEUspUfBMfah6Ie9ocUR1wLMv7CsqZ+RvchV4DNi5Q6+SbEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722331822; c=relaxed/simple;
	bh=vavhuKswM/3UJ7RKw8cXf3oDRdQ9aHvYMqr5DHYL9qs=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=RVoOSCUMijASsVTFTHRImR/Q2QOUAd3enwzEaXmAy3qquypQGtwyuXl/ZmJsRKjenWOFKFmYM/w3aqw6V2jE+y6eQRhhNbpxBfkO5RC93++WZZrUv0JF0pbA4u0PB7gJTadbgKTBdAu80SPEBBaJ94PORyv7j/uL0anTFKnVyCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=BDkdyyN1; arc=none smtp.client-ip=203.205.221.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1722331517; bh=60gLN9JdTKEP1C1p1aBTRlyiT21+gnTSf3rmZ1dVFz4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BDkdyyN1CoKwFdjDbkuPpTRfLbvI39D9poAOg9i/6JpkXFZZu01QkcNPMf95FWlkY
	 tFhkknT5kAQfTFJDoOIRHjFDiDksgtInVQhbD5OEdFKxLQcdd6/xl0I9WmvzzrNaph
	 Ah2eMXusay2E3OM1DGozSokk0r2kRl7YtEOLHWqE=
Received: from localhost.localdomain ([36.111.64.84])
	by newxmesmtplogicsvrszc5-2.qq.com (NewEsmtp) with SMTP
	id 64E37C5C; Tue, 30 Jul 2024 17:25:14 +0800
X-QQ-mid: xmsmtpt1722331514ti2mdsjo0
Message-ID: <tencent_A7A264C6C6F9289CAE6046759239DCB45A0A@qq.com>
X-QQ-XMAILINFO: MR/iVh5QLeienvsCx/U4UbqmyHgJAqVZxMmDyd7UbZm0Jje+Yv/zxqQ1QnJIzJ
	 ZqVopIGUHbDdybBNKbul9/nw/sc3vmNfwgdoIf0EqoIQEp6hXpg3qs5SFegTswut74bOq46z1kkr
	 ndnQ+nD/YsFRJmqpwKrQi8HVjahzD1wPDZjr6WHWHAekrjVtkV7kvNdzz7ZpCJ/OEGixLEcpV4zs
	 jcEapJgjSAaPq8KW/+xBSBf9CvrkiHTg7/LRDbtcltFQhb6NyYp5RBp2bG54eyk1BaXE4HcNREmi
	 HfEnlp/EZn0UYs9p7ACh3QOoNsExQS/TXLe250aYIsYNvOgQkBC4qPKpy1Csc16JJ9ovdRfgIqxh
	 7lly1vbtgbZgHRoinmZrEL4IBsj7JVzohxqNXp8Dwk5Wge00G54H5BFIiiOqnOxaoh6hKFJdKQhh
	 P14SjGPRVkd819d8FRHOosO7Mb+5zwlIlTMQiUgNBYDLvMuZQSDOlCFsQxsLG3lNjGByFBxVIXyU
	 QhWnDXC2BS6JJwoEXLD9aseicAJqHBcNSq1jPzJzfdP9vx+YJP6kSQJjKHd+4lpA/GtO/0lgD1S3
	 SRymxWEW2vLmCatg0k8FbZauP0SPbXHhqmLBx7D/A0G/6dwIUHjoquIkyXsOBvD+Y5MvBFB8l9bo
	 2+NfgvEuPmTyHNHjj/HkPNNAKkhJerFdL2IoPJ5GkhIHVXpab6InfWzEvWQoLfSrICk3alMRnzx/
	 HK0ngfTon/aaT6qWIY7ugzHBA3ea8pCz9e+V4B9AtqEpiyfQ7thPR6mSC1oJE8+EPRT5Ml2bTAyA
	 km51CM9aEojt/yzJJ5fSSnCHyXeOHl4mTaRHwNEKEb1tO4Le4vyZcRy3uRtUhJAQEGb9PtJZK2z2
	 FGKF66sq63zLECPLcysYur7ZZ3l2448RtxUJjp5gIYVCc3KkgSuxNxYlhby1iSndWw+TyEytvUL7
	 T8DOvEHBScHZ8tzrlLWOTGymeh+sMKGTG0DFWA/3g72CI+y1ve/I6BzeKiojsZ+cEgPY2AB5Qyyi
	 qAJAYJ0A==
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
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
Date: Tue, 30 Jul 2024 17:25:13 +0800
X-OQ-MSGID: <20240730092513.37979-1-realwujing@qq.com>
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


