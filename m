Return-Path: <stable+bounces-100666-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61B699ED1F0
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 17:33:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16C98285A39
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 16:33:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F8FF1D619D;
	Wed, 11 Dec 2024 16:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ozVtJFHL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C48571A707A
	for <stable@vger.kernel.org>; Wed, 11 Dec 2024 16:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733934778; cv=none; b=aBd+IbAGr/s7UlD+sjb5g5Sw7/sW3/BGWhaWtG5OI2UYJP5ZwB8Eu0/rVmpUefVuETo+tYb9S8V/r2fYWCrz61lveNghW6MNOqpIFoowosY3mEZqjjm7EagoCJ4WcUXLoHBIHO2Se9LlYf0DOgm/atmmHlItiBYM0RB4orVmsWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733934778; c=relaxed/simple;
	bh=5bipLNImyJg+TKpsPb4aJ4Bw5nKrxrdRnN07ePnCoQc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q7Zooc6rPg6NfahI3YUqxN+honQ+FeW0TConAbkt/zF+h1abmIvzI8O7s9Xysd3vaDvMCNuob/SqXKhgT8AvtLzuoLxyzmMwW2sxIx0N97MyAGmFldOtaTp9gqo+Xuq1UhMLXcjjnfBaLVUvixzWWgYPbqfH3SMeeldiLeBkH6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ozVtJFHL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F160CC4CED2;
	Wed, 11 Dec 2024 16:32:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733934778;
	bh=5bipLNImyJg+TKpsPb4aJ4Bw5nKrxrdRnN07ePnCoQc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ozVtJFHLCexXjMlEIZFnsY+woiZe+NNP7WbNsYlD7wcgu2XYY+Lsfyjf+YSGk8WH4
	 0x03BcnLBW9/nfMH5LR4ZTkzUTkHiykk+uuCo7lguxn9JWQhEwQVTS5baFnePmRopA
	 Ha9gKMPN4FtN3WILesTERAdBVO8pnQYAWbmh5gf+KSZ63Edzs0PpFZotWETcU3QxDA
	 h/9j06OBnKyqLxjesMvux/GolktvnYpCzCtUR+GwrGyBxva6i/7MJUESEMXoE5cXBU
	 qYxesXdsw26WmgbBNOT725D5lNeEd3MsNScJ04VyGGPbg5yDnK+P/1fKJH3TYQP4FQ
	 KMWXs0wVz8SMg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: jianqi.ren.cn@windriver.com,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1.y] cpufreq: amd-pstate: add check for cpufreq_cpu_get's return value
Date: Wed, 11 Dec 2024 11:32:56 -0500
Message-ID: <20241211094948-3e6635f50a74424f@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241211095352.2069266-1-jianqi.ren.cn@windriver.com>
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

The upstream commit SHA1 provided is correct: 5493f9714e4cdaf0ee7cec15899a231400cb1a9f

WARNING: Author mismatch between patch and upstream commit:
Backport author: <jianqi.ren.cn@windriver.com>
Commit author: Anastasia Belova <abelova@astralinux.ru>


Status in newer kernel trees:
6.12.y | Present (exact SHA1)
6.6.y | Not found
6.1.y | Not found

Note: The patch differs from the upstream commit:
---
1:  5493f9714e4cd < -:  ------------- cpufreq: amd-pstate: add check for cpufreq_cpu_get's return value
-:  ------------- > 1:  b42c647770dad cpufreq: amd-pstate: add check for cpufreq_cpu_get's return value
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

