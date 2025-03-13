Return-Path: <stable+bounces-124300-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF258A5F495
	for <lists+stable@lfdr.de>; Thu, 13 Mar 2025 13:34:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD5EF17E820
	for <lists+stable@lfdr.de>; Thu, 13 Mar 2025 12:33:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A129267710;
	Thu, 13 Mar 2025 12:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HX311cFU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE48B26770A
	for <stable@vger.kernel.org>; Thu, 13 Mar 2025 12:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741869109; cv=none; b=E9DxuoFvCXhYmh6FaUZSwBdWDuv5Z1wXQuCE/E3ZtnZasNWheWDJsN14FcYlt3OZncgAdTK3H9I3RLabqixIXFWZ++R4oGOWt3bsfbPTnNj/wT/3iyVK76urNUQrzXqn48XZ6N/nx2vP1hRE3XtTfHLh8I8zsYKDryYwl9LymjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741869109; c=relaxed/simple;
	bh=3nfspt8I7UReni5wM9rJ7qXihHLFQMxi/WWo1waKCdE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ceJfaENkHzi917wAqVOLVHALDyZkdeBfR2UcOcNHQ1cVBzLVsoGur5+O/v+hrOPjfeFpRWlq3ujcTjUTkunHdolX12+TdZL6IEAAjsZYoflNziDIAloVb1rMQcEbG8D7g71seDalerYMC1Ig3F7NJhYiE2/bzPdms7nS5JmeA7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HX311cFU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9886C4CEDD;
	Thu, 13 Mar 2025 12:31:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741869109;
	bh=3nfspt8I7UReni5wM9rJ7qXihHLFQMxi/WWo1waKCdE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HX311cFUMNlN2PteRXlkvF0CakTjD6ldw3k7mT1fNFyxN9OmDzgRF+MJMKoOiSI4n
	 MuamckELZTGVYEKJsugZCGzEs4+6fG2O8BBXuzMvOPYoQchJLkg31Iz58vXbZs63Gd
	 tUG4Bv6SMQZGTfol65cIiJVgsCBuViK03cTP2xsPqbn1MJiSv7sV7xQ62JKFz8iGDb
	 WQd3LSs9k/uKM5xwnIhKx/Mr8gqzKy+y2DhoniZMDt1V4DBzgFqXbqm8qpOCXVc3KZ
	 9fitxxDDc4wp58PiQ3cAtZt0j16te6Im2E92ZU24drS6oTEKc/gvrdaOH6soUqU0rL
	 ttkt7AXFCBYkw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: jianqi.ren.cn@windriver.com,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.6.y] bpf: Use raw_spinlock_t in ringbuf
Date: Thu, 13 Mar 2025 08:31:47 -0400
Message-Id: <20250313053619-89e5abb5d0055f2b@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250313072155.167331-1-jianqi.ren.cn@windriver.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

[ Sasha's backport helper bot ]

Hi,

✅ All tests passed successfully. No issues detected.
No action required from the submitter.

The upstream commit SHA1 provided is correct: 8b62645b09f870d70c7910e7550289d444239a46

WARNING: Author mismatch between patch and upstream commit:
Backport author: <jianqi.ren.cn@windriver.com>
Commit author: Wander Lairson Costa<wander.lairson@gmail.com>

Status in newer kernel trees:
6.13.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)

Note: The patch differs from the upstream commit:
---
1:  8b62645b09f87 ! 1:  3e6400175c393 bpf: Use raw_spinlock_t in ringbuf
    @@ Metadata
      ## Commit message ##
         bpf: Use raw_spinlock_t in ringbuf
     
    +    [ Upstream commit 8b62645b09f870d70c7910e7550289d444239a46 ]
    +
         The function __bpf_ringbuf_reserve is invoked from a tracepoint, which
         disables preemption. Using spinlock_t in this context can lead to a
         "sleep in atomic" warning in the RT variant. This issue is illustrated
    @@ Commit message
         Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
         Acked-by: Daniel Borkmann <daniel@iogearbox.net>
         Link: https://lore.kernel.org/r/20240920190700.617253-1-wander@redhat.com
    +    Signed-off-by: Jianqi Ren <jianqi.ren.cn@windriver.com>
    +    Signed-off-by: He Zhe <zhe.he@windriver.com>
     
      ## kernel/bpf/ringbuf.c ##
     @@ kernel/bpf/ringbuf.c: struct bpf_ringbuf {
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.6.y        |  Success    |  Success   |

