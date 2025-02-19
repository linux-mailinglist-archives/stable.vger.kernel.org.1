Return-Path: <stable+bounces-118258-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18A09A3BF57
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 14:04:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D61FB3B91E3
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 13:01:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B900C1C8618;
	Wed, 19 Feb 2025 13:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LtC/V3ny"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78BAC2862BB
	for <stable@vger.kernel.org>; Wed, 19 Feb 2025 13:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739970034; cv=none; b=gBLx51X04KiPNCfLXY3sRKQZ4BUQtmZhUIi0LvL3bzVOXlD8W3aEjR06i4IRlImqsJG47JnDYOjFEYFmd0pxnPqyum82RVlbo2xaI2FgT0e5MoNsfza0e6cEEhFze/nB8rzAS0NLWze7xYPHLBoerpqjPqtATHD5jB5WELgjbUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739970034; c=relaxed/simple;
	bh=5k+xPmXfOUGiT9Vh4ABbezSnvipUqQN32RNQ1+iZqcM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HAcyG5X7bMx5QKNNn9hVDM6QLGrBjPN82FspoeWfVoyeGuI0eN7ObYXOXy1In7kRd0GYA7XlpSs//QHZE+K2TP5pt9qGyOft55xpylIC/SxamGQKxBR/ZettUg+L0NvF7aEPaoLLLsNgt0MRTaIjY7zrPX9feubD/R0tECvUFLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LtC/V3ny; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71D26C4CED1;
	Wed, 19 Feb 2025 13:00:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739970034;
	bh=5k+xPmXfOUGiT9Vh4ABbezSnvipUqQN32RNQ1+iZqcM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LtC/V3nyk49ZxIJaPziPs0Hp8ECSFlHXVS0bdH3aELXemcbQJdpLNaBcEQSmshZ1A
	 e7IOOqtdaMX3g/UuwRqHJFhsqE/AITExR4bjUEMBJSUfXMzTIuIo4jFUVqN2L9yVSY
	 4tmKNbFMjl5l5Q1li0vuMCVLI/mUa3mZzu6MNWrYBdgI4M2bY2/U1nvUuwgC4Z6GAw
	 +1xzHG0rxdZO5qM9l0Ld6Yq6WaxZvsAQQNc4zL6YlMmDycYcUiTMvvJ7KrHks9ctUz
	 XTmA9rC6uLPfxOoJ0ubFoJzd21506BK1kF47tEtWOJ7JWe1ORlTtA/GFvwvk4Npswp
	 yiGQZ4qGcItPA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	hagarhem@amazon.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1] block, bfq: fix bfqq uaf in bfq_limit_depth()
Date: Wed, 19 Feb 2025 08:00:29 -0500
Message-Id: <20250219075145-097f67676de32114@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250219090907.30462-2-hagarhem@amazon.com>
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

Summary of potential issues:
❌ Build failures detected

The upstream commit SHA1 provided is correct: e8b8344de3980709080d86c157d24e7de07d70ad

WARNING: Author mismatch between patch and upstream commit:
Backport author: Hagar Hemdan<hagarhem@amazon.com>
Commit author: Yu Kuai<yukuai3@huawei.com>


Status in newer kernel trees:
6.13.y | Present (exact SHA1)
6.12.y | Present (different SHA1: 01a853faaeaf)
6.6.y | Present (different SHA1: 906cdbdd3b01)

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Failed     |  N/A       |

