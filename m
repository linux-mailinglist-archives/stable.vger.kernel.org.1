Return-Path: <stable+bounces-139362-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 341C4AA637A
	for <lists+stable@lfdr.de>; Thu,  1 May 2025 21:09:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FED1462F05
	for <lists+stable@lfdr.de>; Thu,  1 May 2025 19:09:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB5D8224B04;
	Thu,  1 May 2025 19:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oOeMjkLa"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A5EF215191
	for <stable@vger.kernel.org>; Thu,  1 May 2025 19:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746126565; cv=none; b=r05D5UbJElK4FynWSdUNC6CkumfbwRQuL0iK0o3BPFEaU5DlYGeYIio1FsOWQGa+05rB8D/pWBrlKwKbsd5szpG6a8qEARZLcmbbKYIdpNmkyaHODmRNrKzzsvWB6vDkiOffu7bvwk7qpRYmOSYGx9gxIloNuatSiiI/q1OIi+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746126565; c=relaxed/simple;
	bh=ZZoLUQnBkF1a2jP9AKVyMOMls6gY23S9RskJOAkmyPg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F8dLiU6fQ5j+kRzo8Az4NSz0BDBlYvfURGKLG1PcDx+0b2lKZ9+AogH6AECMUl6fYeuhNzYagGcI8AmBR3QAtcaEryDWGu33s9Hjqb+HaWWpVakvoKyZ66n6+klJ0/+tBGI+719U6I2ziGYDQUvs90Wc2z6h/UckZMCNZlwfwn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oOeMjkLa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 920E2C4CEE3;
	Thu,  1 May 2025 19:09:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746126565;
	bh=ZZoLUQnBkF1a2jP9AKVyMOMls6gY23S9RskJOAkmyPg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oOeMjkLabprLbG5lnhvXLcniEHvrkuhu6kBKnfSsLIFFhUFvZG+IamMLXVrixDO1X
	 1DRstq3L5m150qZb+K4CYiFGka/SKl5vDXapNos4sB3fliY4aYedaO0aBVbOuksgiQ
	 O08k1Ets2QYKZ9omKX1y2uVZuroIqKWMXNeUIqencVcZyyrCLXmNkbJumInlpCJU3M
	 nihEB73w6ynjXhCnOENJbr+7ea5uBLISBmxF69Q+IG9JzxPxdEHhhs9r3Lw5go7B39
	 6+dGxnc2IX8yfrjTmBfetzzjd6+xZhEbLZqnEJLlNdt0YmnyLZLYGpSoMiqJ6yw98S
	 5F28812zR14wA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Leah Rumancik <leah.rumancik@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1 07/16] xfs: revert commit 44af6c7e59b12
Date: Thu,  1 May 2025 15:09:21 -0400
Message-Id: <20250501124513-0c8ae1b4f079d18c@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250430212704.2905795-8-leah.rumancik@gmail.com>
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

The upstream commit SHA1 provided is correct: 2a009397eb5ae178670cbd7101e9635cf6412b35

WARNING: Author mismatch between patch and upstream commit:
Backport author: Leah Rumancik<leah.rumancik@gmail.com>
Commit author: Darrick J. Wong<djwong@kernel.org>

Status in newer kernel trees:
6.14.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (different SHA1: 20adb1e2f069)

Note: The patch differs from the upstream commit:
---
1:  2a009397eb5ae < -:  ------------- xfs: revert commit 44af6c7e59b12
-:  ------------- > 1:  4bf3fa8a1cd5e xfs: revert commit 44af6c7e59b12
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.6.y        |  Success    |  Success   |

