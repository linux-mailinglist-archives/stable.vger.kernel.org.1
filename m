Return-Path: <stable+bounces-100479-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D90159EBA1A
	for <lists+stable@lfdr.de>; Tue, 10 Dec 2024 20:25:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C539A16766B
	for <lists+stable@lfdr.de>; Tue, 10 Dec 2024 19:25:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E298921423E;
	Tue, 10 Dec 2024 19:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wcr6i7Jo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A21CE224AEC
	for <stable@vger.kernel.org>; Tue, 10 Dec 2024 19:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733858706; cv=none; b=SuQ4uRu7bo5x4c6018NanJyNs1H1nDDWkaCMWBYGfSPlyAd2QI6lFwTdRxOdqI5tBd/iSiGoYYs7fiu34WXvK7melNnfpjXgP7GVqiD3IfSxjq/NDj0cfxA4ppCOkqBRGfH8zf+vUEg1D64XCc34Qc6kPyLwthCSuC/s/K+yyA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733858706; c=relaxed/simple;
	bh=x6/VdCYZrF8UY/vjPwNgbYE/tiF2aGi2jC75fKt5khg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FkozvNXlcEVRFuTxEP/wkNwrFXmqhgucc4Z+3Tnv/PfJJqeyy5hoeqCcYU221Za5WJf/LVgLpkNXdQifqT/aaYzRrNm15jJUtiLr5ZNRegi50xBIyo6uc/uRDa3fxiqZc40qFBTPrE0dAzBmPMbAX8wc4NgeEjW/XiCMp035Q9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wcr6i7Jo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A562C4CED6;
	Tue, 10 Dec 2024 19:25:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733858706;
	bh=x6/VdCYZrF8UY/vjPwNgbYE/tiF2aGi2jC75fKt5khg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Wcr6i7Jo+Vd8jrUU47bQXreurUmYFdqstcoOXMaczeCbljF40sYu29KqMjPv36GTg
	 nWE9BAXkHGPu7LCJTvcXFaEFw5mUlV04ggAfwFwZ2x09EhZ0eS9idhY+dM/Ku+AWNd
	 Mq/fBOH8jloXXE3RrvjaLnkhRXrJHWwVSU0SRNpyTmGkO8VUrIG1GakOANjThSFfJN
	 Mgf03Le5hF7D+6D/mGqmw5iolZEmTHNhrOX5mNyMXrDZqxdiC689ryZHdoTCuD7fQc
	 tBNAxyqBXRar1l1yZjgHqdi6gbSw5vT+OvxTRRW2tAtQSRd08SAon4GAAcbC2QrHjO
	 jgvsVdiNOJrLw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: jianqi.ren.cn@windriver.com,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1.y] net/mlx5e: Don't call cleanup on profile rollback failure
Date: Tue, 10 Dec 2024 14:25:04 -0500
Message-ID: <20241210091510-2d1c66c7eef78b03@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241210065555.3784562-1-jianqi.ren.cn@windriver.com>
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

The upstream commit SHA1 provided is correct: 4dbc1d1a9f39c3711ad2a40addca04d07d9ab5d0

WARNING: Author mismatch between patch and upstream commit:
Backport author: <jianqi.ren.cn@windriver.com>
Commit author: Cosmin Ratiu <cratiu@nvidia.com>


Status in newer kernel trees:
6.12.y | Present (exact SHA1)
6.6.y | Not found
6.1.y | Not found

Note: The patch differs from the upstream commit:
---
1:  4dbc1d1a9f39c < -:  ------------- net/mlx5e: Don't call cleanup on profile rollback failure
-:  ------------- > 1:  81b952a1b76b8 net/mlx5e: Don't call cleanup on profile rollback failure
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

