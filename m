Return-Path: <stable+bounces-142898-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E239CAB002C
	for <lists+stable@lfdr.de>; Thu,  8 May 2025 18:19:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA6559C5522
	for <lists+stable@lfdr.de>; Thu,  8 May 2025 16:19:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50BDC280A5E;
	Thu,  8 May 2025 16:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lIlX8IxJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 110A128032C
	for <stable@vger.kernel.org>; Thu,  8 May 2025 16:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746721170; cv=none; b=bQSgJUcoa3hwEvLmpsOCbR9ocnQVcXMDMOnKZmsmA1SY26lo3GsENOQfQyB0Vwit1bIEw3CVky8eeYsc7cOlkiBSt+TCVaMkB1PZ0aUJNJe5hOKHkLHhSWuJy8NTQ0kuTsZ7xF1Rwvzfuz91WLZEw9cAzbAqwOnpogbSZ7tXfs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746721170; c=relaxed/simple;
	bh=RVIKDl/EugWmSnvOXT9bd2yaYW36FECzGaIqHt8JOYc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AoOipQJWQZ/4EMGK/EpTbWVyQEjvfmYbEuQlpns1Ouq3OGork8XpFdKfrRqeSaSePZxy4IboOoe3u+wsdsbhbxbTrvszIg/PvjC7X2SNECEYbrI8xofcZNkZmgMKAQvS/zojl9co848XOzodWBDCEFHOe7gJNrhiH6VNCscKnC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lIlX8IxJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E2DEC4CEEE;
	Thu,  8 May 2025 16:19:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746721169;
	bh=RVIKDl/EugWmSnvOXT9bd2yaYW36FECzGaIqHt8JOYc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lIlX8IxJ7jyok2WhEyEBY0aqlHpCYOKaGRLSpbZfmfSDg0UqyNPAHkZeyPQ+GSIah
	 rYvO4mSnfZ08Uou8q/EkRj7z83VAF/xTP9lWPag2vriYw/Lm1SlmKIZSfI5mHKTOZF
	 1fRZQGmLxcxpL1+6gQ7GGpoO4rTQ+P4nBsmaEFOmMJvPQq/SzRaj6rLz8ovKTK8mlr
	 X8zp3EhAeFJZ+nLvpZY91ZHKLOS9IZ4RJfn/IoJ82Hv1+zukP049EMxPKp7NbE+Nek
	 a8VeJEujV1Siwo7odCMt9RsO/xXH6UWhUKvl7Q0uCLzNpPNwc1ZAll7mRbgUa4JYtu
	 pHQKEsDpn/1kw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Yu Kuai <yukuai1@huaweicloud.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH v6.1] md: move initialization and destruction of 'io_acct_set' to md.c
Date: Thu,  8 May 2025 12:19:26 -0400
Message-Id: <20250507083005-e59e898b9f88e24f@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250506012417.312790-1-yukuai1@huaweicloud.com>
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

The upstream commit SHA1 provided is correct: c567c86b90d4715081adfe5eb812141a5b6b4883

WARNING: Author mismatch between patch and upstream commit:
Backport author: Yu Kuai<yukuai1@huaweicloud.com>
Commit author: Yu Kuai<yukuai3@huawei.com>

Status in newer kernel trees:
6.14.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (exact SHA1)

Note: The patch differs from the upstream commit:
---
1:  c567c86b90d47 ! 1:  421676e64b498 md: move initialization and destruction of 'io_acct_set' to md.c
    @@ Metadata
      ## Commit message ##
         md: move initialization and destruction of 'io_acct_set' to md.c
     
    +    commit c567c86b90d4715081adfe5eb812141a5b6b4883 upstream.
    +
         'io_acct_set' is only used for raid0 and raid456, prepare to use it for
         raid1 and raid10, so that io accounting from different levels can be
         consistent.
    @@ Commit message
         Reviewed-by: Xiao Ni <xni@redhat.com>
         Signed-off-by: Song Liu <song@kernel.org>
         Link: https://lore.kernel.org/r/20230621165110.1498313-2-yukuai1@huaweicloud.com
    +    [Yu Kuai: This is the relied patch for commit 4a05f7ae3371 ("md/raid10:
    +    fix missing discard IO accounting"), kernel will panic while issuing
    +    discard to raid10 without this patch]
    +    Signed-off-by: Yu Kuai <yukuai3@huawei.com>
     
      ## drivers/md/md.c ##
     @@ drivers/md/md.c: int md_run(struct mddev *mddev)
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

