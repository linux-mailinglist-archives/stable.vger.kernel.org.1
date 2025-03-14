Return-Path: <stable+bounces-124494-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0A1DA62158
	for <lists+stable@lfdr.de>; Sat, 15 Mar 2025 00:10:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFD484629DF
	for <lists+stable@lfdr.de>; Fri, 14 Mar 2025 23:10:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98A9C1C860B;
	Fri, 14 Mar 2025 23:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IUSgP9zD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A7A31F92E
	for <stable@vger.kernel.org>; Fri, 14 Mar 2025 23:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741993841; cv=none; b=Uagkp4IL+q0KqC/EQWXduDqhW6dzTpgoU40P/29VxOmhYtj5/Go3mbUW/5AJjJzew1Mf2oEfdyTVN6owDEzoted9fB8RnxM0MS3tfpEJKlFHSz9nBKnYC7jX4pGk3eylnxOChrXfSXM88ZoF1Wxokwqa3SwZpWby3NpmpK8PQbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741993841; c=relaxed/simple;
	bh=RjOKjZ/qHXiBSfvCFQkptWOqkz29VbY/a+ojyx16wuA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZchoFm575BpqZLKgc1pCB6vGmkuhNW9qrA59T9bJO1RvFEDrhPXaVzpZyNJwNjdT2EwEsjvz/Cxjtyjn003hZLFfqW82wmMwSh2f7suTOwg9KugaEjdKL+7o+WmfMQ8S/+8ebQmQ/JCR8J/b+pvs1wHCrZumraxnT+kk/kvF+Lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IUSgP9zD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C288DC4CEE3;
	Fri, 14 Mar 2025 23:10:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741993841;
	bh=RjOKjZ/qHXiBSfvCFQkptWOqkz29VbY/a+ojyx16wuA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IUSgP9zDJ4FQMYkU1gevPep2U8eP/V2qNIwQPJfR4hWxyToY69rZ4hrRVpttHMHmI
	 liBkxfnDpTMd/+EuoOc1uDYPlSSoGV8Cyi45xVfUtL4Otba8YOabLmH1xBgNNhZPhg
	 QC39J/WgtQdHMcUaKmJv2BGeNLAai/UL/h13zwKOYx6sm8hDJmxF2DzUpe6cgyEceM
	 pg9sa/Azu/hN0GfQJLvIcGJRmEvLjwsyEzsfOpE8oNjcJit0psUjxssagUXbIcK1NR
	 7yaXxX08+QgxBGTJSzcEjC70vxMdUTMyKj6ysHznLuBnGy7c1fvg7quliAYnxd9Nnx
	 MZZ8iLv06tMFg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	chenlinxuan@deepin.org
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH stable 6.1] lib/buildid: Handle memfd_secret() files in build_id_parse()
Date: Fri, 14 Mar 2025 19:10:39 -0400
Message-Id: <20250314090232-291778f8e99633f4@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <5602B4F2D8F73293+20250314090247.31170-2-chenlinxuan@deepin.org>
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

The upstream commit SHA1 provided is correct: 5ac9b4e935dfc6af41eee2ddc21deb5c36507a9f

WARNING: Author mismatch between patch and upstream commit:
Backport author: Chen Linxuan<chenlinxuan@deepin.org>
Commit author: Andrii Nakryiko<andrii@kernel.org>

Status in newer kernel trees:
6.13.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Not found

Note: The patch differs from the upstream commit:
---
Failed to apply patch cleanly.
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Failed     |  N/A       |

Build Errors:
Patch failed to apply on stable/linux-6.1.y but no reject information available.

