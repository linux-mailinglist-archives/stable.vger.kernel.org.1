Return-Path: <stable+bounces-124704-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A12FA65902
	for <lists+stable@lfdr.de>; Mon, 17 Mar 2025 17:52:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95F713B5181
	for <lists+stable@lfdr.de>; Mon, 17 Mar 2025 16:47:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 384BA1DE2BC;
	Mon, 17 Mar 2025 16:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BsJy89gE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAF401DD88E
	for <stable@vger.kernel.org>; Mon, 17 Mar 2025 16:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742229603; cv=none; b=EJo6mtqhxjGNlo0H09hekXCTvWNcQ9BHEIsHGwB4odG8aMQ4HihORT6yWOAh/AYXvrUoSYRyC7oHjVBDkCNf6e5B3awcgG1+faprdo0jZHsCxa6PjgPD19wtGO6MYkFw4N8p5IZ+PSgj417keGNpvmaOHyWd/+QZK1EPI+neEvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742229603; c=relaxed/simple;
	bh=JD1f06hm8IORQJFMEdggc1GtGjm4IvguCnHe2j+upTI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NwOTaK4IzdQW0JHveogkbCr4t7T4TCnsEQBoT0TCp0yT9sx/+qMwWEJ5xQPwnnR3k2RXkLAcwm4Uv/ZXimxv9RiuDoM1tkxOOwEvd06z8Vk0/DQj+XN+iePiqJPlHnpKgdvlt0OoF+2hfCGlIGKU4rSfpuCPShWaSukvwCKwqX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BsJy89gE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 597F9C4CEE3;
	Mon, 17 Mar 2025 16:40:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742229602;
	bh=JD1f06hm8IORQJFMEdggc1GtGjm4IvguCnHe2j+upTI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BsJy89gERTuWVpyiVbQaI/6JNs9YtS6gtsODMyK+CzMBSoezjp2s52qlRagkGIBX/
	 dc7YwXdqHxmoX6mb21IBy5MLsE2XeEpGb4TaZD0AOkLh4OBxMYodOP8B22pBkK8ApB
	 LQN0py4TL0qgaY4HGSgMHcQfxpKqEdtxThw01ss1NEgvavN3xchVnJKuGICKE+tES1
	 1S/U8mPFF7uBo+mEbWz1sNGiaUYvXbAE/+9Yx1sI7xYTzAPWuauW+K+DLJroMXwdDG
	 e2s+Xu0oKNDv4oG6zew6PC9V69W/bfe9jKuHQQVKJGhRqRu4n50u2xT9EtMNFk370x
	 lfU2b4xaF2FmQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: jianqi.ren.cn@windriver.com,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.6.y] netfilter: nf_tables: use timestamp to check for set element timeout
Date: Mon, 17 Mar 2025 12:40:00 -0400
Message-Id: <20250317090052-5b3956b9ea4de9f2@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250317081632.2997440-1-jianqi.ren.cn@windriver.com>
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

The upstream commit SHA1 provided is correct: 7395dfacfff65e9938ac0889dafa1ab01e987d15

WARNING: Author mismatch between patch and upstream commit:
Backport author: <jianqi.ren.cn@windriver.com>
Commit author: Pablo Neira Ayuso<pablo@netfilter.org>

Status in newer kernel trees:
6.13.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)

Note: The patch differs from the upstream commit:
---
Failed to apply patch cleanly.
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.6.y        |  Success    |  Success   |

