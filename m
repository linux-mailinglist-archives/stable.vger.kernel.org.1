Return-Path: <stable+bounces-139731-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F548AA9B41
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 20:11:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8732D179485
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 18:11:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8794D26F450;
	Mon,  5 May 2025 18:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aLv7B0b0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 427D026E15F;
	Mon,  5 May 2025 18:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746468685; cv=none; b=LyMtUlhrSYq7knldKOF5tbKxxZDKiivXyI1Y6H15sP8LxsTNyYpgqmhJUAfQ2ozXHwBM848UJZVxPzifkINA4lcUyz7nPBx6I0lsngUvIwFtpS6Z+mIii65MfIumQEgH9jobiL/qcIXrf637XcbUgILkJahP1P4jROOmvBIBDLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746468685; c=relaxed/simple;
	bh=W1ueBdjzvtcPTR7EMcZ9r0VXqmz0pOyWvCci9BiX3W8=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ke5AiXI/kb+QuiuHHUYzvcyiOZ1Q3U4CRuEeL61Wv3MTH8OOep2WYuYbU3keqZDacL+Vls4kO1YEn2bzgr4awDfNZOQjTScO6POzXsxbUEmgyXZReynyRQXN2Wz3vXwwPHZJHmkNqCQpjVEONFM8sV4gk2VhOkDJfA2nwo5NACI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aLv7B0b0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7908CC4CEE4;
	Mon,  5 May 2025 18:11:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746468684;
	bh=W1ueBdjzvtcPTR7EMcZ9r0VXqmz0pOyWvCci9BiX3W8=;
	h=Date:From:To:Subject:From;
	b=aLv7B0b0aIX7v9pWXJxSatLPQu2BavklkcYFrn1fZjUibMc2OodkB1C7oWkX+/MAp
	 LOIvBepZ7RjAgUIe2FuWtBG/W4xlv9y/fJ1vudQ5x/zGSyfo3WdoOymWn8euJg5HM8
	 nkI70a7ko+qib9vXzR+NuihYC1QhwTBPG2DEDGa9NqLd18V034pDve0mHQ5XRbiUyb
	 GB7sw7mVZPk2eBr0wqSVtKQKsI/kbhvvPOqbv/RJMWTb7uW2qb7gnT/vZYMR6cUdPp
	 88zGoqjOgq1muCxZNeJcZHX1gP3vD/uEU3Qn3+A8VjYkaa6Vl8ZrNoYDsAv3Rmvq7j
	 3K1HKokxGzeDA==
Date: Mon, 5 May 2025 14:11:20 -0400
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org, workflows@vger.kernel.org
Subject: [ANNOUNCE] AUTOSEL: Modern AI-powered Linux Kernel Stable Backport
 Classifier
Message-ID: <aBj_SEgFTXfrPVuj@lappy>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

Hello folks,

I'm pleased to announce the release of AUTOSEL, a complete rewrite of the
stable kernel patch selection tool that Julia Lawall and I presented back in
2018[1].  Unlike the previous version that relied on word statistics and older
neural network techniques, AUTOSEL leverages modern large language models and
embedding technology to provide significantly more accurate recommendations.

## What is AUTOSEL?

AUTOSEL automatically analyzes Linux kernel commits to determine whether they
should be backported to stable kernel trees. It examines commit messages, code
changes, and historical backporting patterns to make intelligent recommendations.

This is a complete rewrite of the original tool[1], with several major improvements:

1. Uses large language models (Claude, OpenAI, NVIDIA models) for semantic understanding
2. Implements embeddings-based similar commit retrieval for better context
3. Provides detailed explanations for each recommendation
4. Supports batch processing for efficient analysis of multiple commits

## Key Features

- Support for multiple LLM providers (Claude, OpenAI, NVIDIA)
- Self-contained embeddings using Candle
- Optional CUDA acceleration for faster analysis
- Detailed explanations of backporting decisions
- Extensive test coverage and validation

## Getting Started

```
git clone https://git.sr.ht/~sashal/autosel
cd autosel
cargo build --release
```

To analyze a specific commit:
```
./target/release/autosel --kernel-repo ~/linux --models claude --commit <SHA>
```

For more information, see the README.md file in the repository.

[1] https://lwn.net/Articles/764647/

-- 
Thanks,
Sasha

