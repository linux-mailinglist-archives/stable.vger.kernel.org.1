Return-Path: <stable+bounces-223259-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yGqoGvO6qWkoDgEAu9opvQ
	(envelope-from <stable+bounces-223259-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 05 Mar 2026 18:18:43 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 56F712160B9
	for <lists+stable@lfdr.de>; Thu, 05 Mar 2026 18:18:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id F0775309A80B
	for <lists+stable@lfdr.de>; Thu,  5 Mar 2026 17:14:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7849D3E9F7A;
	Thu,  5 Mar 2026 17:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZGiIbA9t"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B4903E3D8A
	for <stable@vger.kernel.org>; Thu,  5 Mar 2026 17:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772730785; cv=none; b=ZjlU0mxUrEeLfSTt2oXqZl51+V6JALkAhhcX2qClnV350nBr1JjkSHf3Mj+JesMAIiTx7fg3pYXEki6lJZPRYHQrQpKiU0xvhGzgqi2e7H+woVa5u6396PirXzV73brEAL1eYQ9/VjKvXuV7ovYp04+8/rXZvj7T8v5OzyGLVJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772730785; c=relaxed/simple;
	bh=ixNnjRisEKC2+6IAmQnjI9ab+lvosDmX4lcTWF/0UkA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LboUKVw6DsWKzoX9rOsxGziGc7knpSrU+F1pJf4HV7aB65ByHe5HSa+6gLulB9hyheBAVksXP8qYweciRazLHbq485mBcOlDvuShv0iSmM8kfOJv75fWDd7wR3+prjBKcXgei/xfUJcti0OBHmkDhjmpcFd6pGo6v3/EQu8Zc40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZGiIbA9t; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c73939e0314so367760a12.1
        for <stable@vger.kernel.org>; Thu, 05 Mar 2026 09:13:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772730784; x=1773335584; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Tnolfb6uQBsYaAshkkXBLdzTSf21J1HsPObGa5E2rzU=;
        b=ZGiIbA9tZD1LkwuijnPqvA6nmvxLl6WuSxt81BKxinbPGtntWDXPhqkr1/uiJFjaH5
         PefThkHP/tmY8+gyh+zeeHkEAKs4iECirniuCHi0njpjiKMu7+1U5uonKmuk3Wcfw83d
         hlSUoWqfpOIP/h7dDHIxbdlyRQdUjeu2CDQb2yemlsOytCO0kSd7yguw1M9t8kqZHcQ/
         VHZxwyns/ugG8eUAViJAYiVSFTsKP8jkhEa7reutatBpcoe7tVwrd+Y5INBsrkH1kuRO
         SssdRs5mb+BPnmp7nClWGZDFwb9Sw6mFWWQ/QGqZLBxDO6LWKYdrL6xrpKqQyXRaUabG
         Dm5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772730784; x=1773335584;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Tnolfb6uQBsYaAshkkXBLdzTSf21J1HsPObGa5E2rzU=;
        b=CW3wAvX3L2IWv0GBb8Y/70CG3DDYKBbXFq0sglSm4p7h9ajyPjjuNHHTtHulOE4mYm
         j9B4MaQDR2AHG4R6K6RT88qsax7QvhgmBqggmKVgqHNaaDyOvoOEkG3QZqrdSpMQxaso
         e3eYshUUVmmIuUKU5tSJXy8XUHM8IxRWrofmIbRB017CL5EULulsLvei9UoEZAMeQQjj
         BvuLVz3ukAAI/wDfPJxnnrhjbqZrJ5zHq7ipp2HHiWmCWnsK4Sf0u8x4EBM21c6tRryt
         svIxx8B3yEZTxKn3G3lNFbLKcId2chDg7092iNmVTjCXEuR1fob8b6x4bMq+BQLupGh8
         kxsA==
X-Forwarded-Encrypted: i=1; AJvYcCWTBMCtz+eEpOouK8it17GrA3Ug9bYGAWHSo6Pai4yvg4I4nab8tiqXcjxz36mW2/3rPZ2iAWE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyglnKqzggzSnzR75pJYzt2QY4r7NC481nhnmxaLBUeAF/B2VPw
	eeMM0/zE6YFZ8LYkh1DV2XWdhz8cOqpV6i17P8QPJdy4PsUp3QVb1Ku5ywGrHQJmBN2KEWPAIjM
	/3ClOmg==
X-Received: from pgix2.prod.google.com ([2002:a63:db42:0:b0:c6d:cc16:8cee])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:6e8a:b0:38d:f2a1:a43f
 with SMTP id adf61e73a8af0-39854a814d6mr239546637.42.1772730783352; Thu, 05
 Mar 2026 09:13:03 -0800 (PST)
Date: Thu,  5 Mar 2026 09:08:27 -0800
In-Reply-To: <cover.1771630983.git.ackerleytng@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1771630983.git.ackerleytng@google.com>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <177272511649.1531226.15957182226632150956.b4-ty@google.com>
Subject: Re: [PATCH v2 0/2] Test MADV_COLLAPSE on guest_memfd
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, kartikey406@gmail.com, pbonzini@redhat.com, 
	shuah@kernel.org, kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Ackerley Tng <ackerleytng@google.com>
Cc: vannapurve@google.com, Liam.Howlett@oracle.com, akpm@linux-foundation.org, 
	baohua@kernel.org, baolin.wang@linux.alibaba.com, david@kernel.org, 
	dev.jain@arm.com, i@maskray.me, lance.yang@linux.dev, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, lorenzo.stoakes@oracle.com, 
	npache@redhat.com, ryan.roberts@arm.com, shy828301@gmail.com, 
	stable@vger.kernel.org, syzbot+33a04338019ac7e43a44@syzkaller.appspotmail.com, 
	ziy@nvidia.com
Content-Type: text/plain; charset="utf-8"
X-Rspamd-Queue-Id: 56F712160B9
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-223259-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[google.com,gmail.com,redhat.com,kernel.org,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[25];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[seanjc@google.com,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[google.com,oracle.com,linux-foundation.org,kernel.org,linux.alibaba.com,arm.com,maskray.me,linux.dev,vger.kernel.org,kvack.org,redhat.com,gmail.com,syzkaller.appspotmail.com,nvidia.com];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable,33a04338019ac7e43a44];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Fri, 20 Feb 2026 23:54:34 +0000, Ackerley Tng wrote:
> syzkaller identified that khugepaged, operating on guest_memfd memory,
> could cause guest_memfd folios to get collapsed, leading to a WARNing
> during fault [1].
> 
> Add selftest to guard against similar regressions.
> 
> Changes in v2:
> 
> [...]

Applied to kvm-x86 selftests, thanks!

[1/2] KVM: selftests: Wrap madvise() to assert success
      https://github.com/kvm-x86/linux/commit/58f5d8eebd5c
[2/2] KVM: selftests: Test MADV_COLLAPSE on guest_memfd
      https://github.com/kvm-x86/linux/commit/9830209b4ae8

--
https://github.com/kvm-x86/linux/tree/next

