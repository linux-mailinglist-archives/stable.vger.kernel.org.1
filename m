Return-Path: <stable+bounces-163309-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CCBA4B09934
	for <lists+stable@lfdr.de>; Fri, 18 Jul 2025 03:34:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6878D1886FBA
	for <lists+stable@lfdr.de>; Fri, 18 Jul 2025 01:34:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC42B157A72;
	Fri, 18 Jul 2025 01:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z3cKR/ah"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CD093398B
	for <stable@vger.kernel.org>; Fri, 18 Jul 2025 01:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752802465; cv=none; b=JZyvpRYRKky7BmRGm6wLTiK+Tm4QNrBOvbEBonrebfwQjJJbXc8mznFr1qBzm/zcdHU1zaTCgO9iZeoxjq0rNzzTAmVMOofLpV/q9MZIdcFj5QlHLhUp8+dAyCBIyiVvjXoXYtD6FbPOEtEeOdPjfuu/bvyo8VkGV4fD8YiDTN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752802465; c=relaxed/simple;
	bh=zOKISdUsHZ9Vy4ox+08/M6EY9J3fDTywP7z6gtiKcAA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XijI6eUFvwGrnR9ODBbBQo4yA58U0ZI1+JOBdKn8BMeJyaltjBuk/N32KNl2FsF2T5TSnTqk63nnYqC0DwV6bII2VWHPrKMdWZZCZhB5CyaoUFhP1v7Ct30b50cycm2qba625IuV2/x8gWND9kw0MRPHTaEFCjiQIvqF9jVoPG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z3cKR/ah; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 103F0C4CEE3;
	Fri, 18 Jul 2025 01:34:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752802464;
	bh=zOKISdUsHZ9Vy4ox+08/M6EY9J3fDTywP7z6gtiKcAA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Z3cKR/ah6SJJj5TvW5ZlM2Vy4D6HGliQalA4t/L+LzRghpPdjXsFK5q29nr2PZl3A
	 QHpNnw1vXtO9U8lYk1MgHT+JxGh/sShqgWbtkCiAPoLTehjmdoHhKsWtAM6IOrEwIN
	 K3Y8fBKfnDqXiNWS2T75FAWNtNszrm2qz644N9b2cVgHd2G6OOgnFYh0SE2iJ9VYfP
	 PnX5ooHOTAJE+x3lCN9QQED1Hb9e0pZh6PqbKSVsGOI4TriFq7k3A4iskhI5A3cOjd
	 UNX3B7hVJgaF+ECSeAWkwOULPzmdBQVDO9gaEYoZxXJVEvmIEwScPFr0v+rN1SdEbS
	 OCB9mPlUkvSEg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	shung-hsi.yu@suse.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH stable 6.6 2/2] Revert "selftests/bpf: dummy_st_ops should reject 0 for non-nullable params"
Date: Thu, 17 Jul 2025 21:34:22 -0400
Message-Id: <1752798028-8ce3e42b@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250717080928.221475-3-shung-hsi.yu@suse.com>
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
ℹ️ This is part 2/2 of a series
⚠️ Could not find matching upstream commit

No upstream commit was identified. Using temporary commit for testing.

NOTE: These results are for this patch alone. Full series testing will be
performed when all parts are received.

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| 6.6                       | Success     | Success    |

