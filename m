Return-Path: <stable+bounces-164370-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5829EB0E99B
	for <lists+stable@lfdr.de>; Wed, 23 Jul 2025 06:33:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DA9A56352E
	for <lists+stable@lfdr.de>; Wed, 23 Jul 2025 04:33:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE83F1DE2B5;
	Wed, 23 Jul 2025 04:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p9SBk7Ji"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF04C2AE72
	for <stable@vger.kernel.org>; Wed, 23 Jul 2025 04:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753245229; cv=none; b=GJ6wcJ3SZ4qsqSkSo5VyoCRZ2OBiyZ8lTrtRSoSplQt7stYC8f7OVHfdfhHAcILcqpRIx//bxH3WkXYAbBmS7606+AWH3AeSUKl39GGfAdjt3xxRjq4Duq4fqdkNRCHCIVOn0NaZYi7moyd80/CI/nnDoZDCEqC4VGxOo8UZMck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753245229; c=relaxed/simple;
	bh=w6F8dMi7AcPtwR1FDq9qzMPYhKuMR2HUUG7kbm3stzo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RjAjotFLASzNYaqZMxdSbkWJAbo1J2UhcHfUE+Tda/q1NYf2Lesfq+NySr6BdiiGbfZAA0zEp/7ItwZ7vP0BPP2oeiCvPcquivEv+MV9FkDf8S0STKCOix6SrFJ5K+WflyPi2G0r/zDL6yuv5UxSPRIYws1RkxpEPSJEV2e342U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p9SBk7Ji; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 771E9C4CEE7;
	Wed, 23 Jul 2025 04:33:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753245229;
	bh=w6F8dMi7AcPtwR1FDq9qzMPYhKuMR2HUUG7kbm3stzo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=p9SBk7JiO8Ce93D9yj1BwlMGW/4m/J+Q01fnOY7AyqB8FHcp/9X41d0EVMIspWRVy
	 w4K/lWU8jiYA8xWKdApkYNQgkkEEZJ7DqkXz4NYxfc8bmqOuwjlcwDOzLfXIplhAMm
	 AgxUwd1SnPhFgViIgWL32lECD3gqrVFTFiinQHrbtzW8H5Pce6ter4oHz7zSg7T2+B
	 aP4rlDMbfEkzChXwiNgZtOwUxiBPPsv4gG4UmWQVsSVVbR5HIWyNo6H9U7W+J41a0u
	 h/IQ3Tz/Yr7L3K8lbwjLFzu3xqhju4Tkz0nSc4STysjY02IZVvR66JFL+h7oJFmizd
	 ZDgqpvEY1MEcQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	siddhi.katage@oracle.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15.y 2/4] sched: Add wrapper for get_wchan() to keep task blocked
Date: Wed, 23 Jul 2025 00:33:46 -0400
Message-Id: <1753233307-cd68108b@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250722062642.309842-3-siddhi.katage@oracle.com>
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
ℹ️ This is part 2/4 of a series
⚠️ Found follow-up fixes in mainline

The upstream commit SHA1 provided is correct: 42a20f86dc19f9282d974df0ba4d226c865ab9dd

WARNING: Author mismatch between patch and upstream commit:
Backport author: Siddhi Katage <siddhi.katage@oracle.com>
Commit author: Kees Cook <keescook@chromium.org>

Status in newer kernel trees:
6.15.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (exact SHA1)
6.1.y | Present (exact SHA1)

Found fixes commits:
b88f55389ad2 profiling: remove profile=sleep support

Note: Could not generate a diff with upstream commit:
---
Note: Could not generate diff - patch failed to apply for comparison
---

NOTE: These results are for this patch alone. Full series testing will be
performed when all parts are received.

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| 5.15                      | Success     | Success    |

