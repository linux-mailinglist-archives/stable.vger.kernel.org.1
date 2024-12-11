Return-Path: <stable+bounces-100675-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C5549ED200
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 17:33:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6004F18811E3
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 16:33:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 513431DD9AC;
	Wed, 11 Dec 2024 16:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s/yfaND4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11CED1A707A
	for <stable@vger.kernel.org>; Wed, 11 Dec 2024 16:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733934803; cv=none; b=o1AQ0hkc3lWCxvCszr7H583zpkr5NtWMv3In8dJZKVtqhvkDX+E2Qx8xOaHVkpVvrWtOjUzWfTM4NrzowNeW2nEVdVsMmzbJigYYki0dCB0fvoxGhpqvXR5bUuHqoVcnW3cyvUGttJ2CJh7bOgQDxpVIZXbiUWsbZQVb3Wg11VU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733934803; c=relaxed/simple;
	bh=QSwi8/mND/o85iEd4mg68dFSZGlHm3JrT9gIeeTs2ww=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cmv7074v3EyoficeUI3RvUXqRfOFKmygDsa6W5XssNJEHIenA4Ud2OKmN33/5TNyO7AQBx9A4FOJ8/YeWLrfX4jyO9wtmBmfq+Gwe+BjMvLvIoeV4aWqlQQOiteZTrymx4rblYPEFwasVMNqjR/HHpNAuEymE25Dn3b+gHwKOsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s/yfaND4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6870BC4CED2;
	Wed, 11 Dec 2024 16:33:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733934802;
	bh=QSwi8/mND/o85iEd4mg68dFSZGlHm3JrT9gIeeTs2ww=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=s/yfaND4LTtDPWjx6bh1poUQKoh8TxDfrgPqARUBpa/EgIMWwpfs/N2Jg7LpzufGC
	 sZSbintV8lkeuke7YlpPYYBBOFTYJ+PDkOs2lpHChRuSjewBS063UTP9Bmo6EPq57b
	 1tsLo4CijQ1AyL5uW4ERfO2cQq5m1UjMe4M4Yepfr520T8x+NN8yW1xEeW+Jj3xn1j
	 CxgE2XcHEhHqfJipvIaQMlpFX5nZxqaV1EugbUuNr3YzN8zX6DPAqjgBj1h2eEbc88
	 JdHdT6s1M67SJ35KyRdRrMWB1rzf93m386z/QQxcF6ZoBUGm6kpNzjBZvpLfd+wiNT
	 twKzFJ1vr0Ikg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: guocai.he.cn@windriver.com,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH V2][5.15.y] gfs2: Fix slab-use-after-free in gfs2_qd_dealloc
Date: Wed, 11 Dec 2024 11:33:21 -0500
Message-ID: <20241211082241-67951664980563fa@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241211081023.3365559-1-guocai.he.cn@windriver.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[ Sasha's backport helper bot ]

Hi,

The claimed upstream commit SHA1 (7ad4e0a4f61c57c3ca291ee010a9d677d0199fba) was not found.
However, I found a matching commit: bdcb8aa434c6d36b5c215d02a9ef07551be25a37

WARNING: Author mismatch between patch and found commit:
Backport author: guocai.he.cn@windriver.com
Commit author: Juntong Deng <juntong.deng@outlook.com>


Status in newer kernel trees:
6.12.y | Present (exact SHA1)
6.6.y | Present (different SHA1: 08a28272faa7)
6.1.y | Present (different SHA1: 7ad4e0a4f61c)
5.15.y | Not found

Note: The patch differs from the upstream commit:
---
1:  bdcb8aa434c6d < -:  ------------- gfs2: Fix slab-use-after-free in gfs2_qd_dealloc
-:  ------------- > 1:  d18e3dbdba1b2 gfs2: Fix slab-use-after-free in gfs2_qd_dealloc
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.15.y       |  Success    |  Success   |

