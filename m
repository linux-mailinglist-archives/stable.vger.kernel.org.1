Return-Path: <stable+bounces-164930-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 34709B13AB6
	for <lists+stable@lfdr.de>; Mon, 28 Jul 2025 14:46:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F37B73B5C18
	for <lists+stable@lfdr.de>; Mon, 28 Jul 2025 12:45:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A5B1266581;
	Mon, 28 Jul 2025 12:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qNz/ChsA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B36B266562
	for <stable@vger.kernel.org>; Mon, 28 Jul 2025 12:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753706753; cv=none; b=BEp/i3bA//kZzu69qFDb9bIQs97Z7vUqEQja4QdziEIqVc2KdiE1fTkYTuWXhO5MMxAkiY7KXR1bXjIYNt8wWA9tEVzViscHxO0+dPrez9KKl8LrGGpiedmXjQRKjb3gBNpHoMrOkRqLpjWBDRQ9PvCEHN03QbWl1k2kSCrjAzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753706753; c=relaxed/simple;
	bh=i42EqhQaRDYhHZEYn6W5HmOujbnDOqcp7yAHOaoxSnw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XUWFv8Eg/Uz45YhxMD2JT61AZkmj892o4fe254Z7DZwzUKv2lIwEv8saRLpfqxrLmRI2bprLYCmd5uktvdkqiQXWcfSenCZQaQFCgvgLX620IQx+RhMuB1KFzcfwoT8ACgRSJ+45j5uOqeW2nmuqwvx8wrJVzgJCsouvUlK4Yf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qNz/ChsA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D54A0C4CEF7;
	Mon, 28 Jul 2025 12:45:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753706752;
	bh=i42EqhQaRDYhHZEYn6W5HmOujbnDOqcp7yAHOaoxSnw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qNz/ChsAkm/oDIJBHnmLT7WLbK1nx5L4FNhOqcgZ/WBicMNYXlQM2Vg2RVncqZZcR
	 XbmAS6L5LkmhaHkdVaHEpj72+L3+udPSpGfOuijdl/yRF8yOY81P5ZCt3EAcEeglZ6
	 UJTDBzmTYGGub05qVa1Y2XPzbWnEmqkNovKPXonHhp0oKyeVP6rh1CruATfKb4iPnR
	 eHQ13NwvlwMnmDAFKX7TcU2vdsHm27Sl1C3+qNupd0lQxys75lMHNc06z1H2iS/uwk
	 BM31nxR5zEGwjAoXQKNfPPqjL7NcptSxfYhXjSQbADYGvKWmX78Ge+2dBhZhQmegFs
	 hTMO72KEftJtA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.6 5/5] sched,freezer: Remove unnecessary warning in __thaw_task
Date: Mon, 28 Jul 2025 08:45:49 -0400
Message-Id: <1753684648-09273728@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250728025444.34009-6-chenridong@huaweicloud.com>
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

The upstream commit SHA1 provided is correct: 9beb8c5e77dc10e3889ff5f967eeffba78617a88

WARNING: Author mismatch between patch and upstream commit:
Backport author: Chen Ridong <chenridong@huaweicloud.com>
Commit author: Chen Ridong <chenridong@huawei.com>

Status in newer kernel trees:
6.15.y | Not found
6.12.y | Not found

Note: Could not generate a diff with upstream commit:
---
Note: Could not generate diff - patch failed to apply for comparison
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| 6.6                       | Success     | Success    |

