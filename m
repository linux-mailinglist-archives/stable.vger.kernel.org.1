Return-Path: <stable+bounces-126028-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD5D3A6F445
	for <lists+stable@lfdr.de>; Tue, 25 Mar 2025 12:35:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53885169177
	for <lists+stable@lfdr.de>; Tue, 25 Mar 2025 11:33:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57A7F1EA7F5;
	Tue, 25 Mar 2025 11:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sOjiN6ls"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18B6BBA36
	for <stable@vger.kernel.org>; Tue, 25 Mar 2025 11:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742902437; cv=none; b=CG3oubgzfC1dj9qRZokpD6FtUWYCzK2tdpieg2nmj3taYtnitLSx208DsnDhiWsqjra96jm5bkf0icjpVkgLXkg2ORTgMohSIVZ+Y0yO4rLlAoMFReusX6xebf+L/90n5PBtWFqKGIyG+DHZIcKQD2e9vrPbxvopNPEpZFCUt+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742902437; c=relaxed/simple;
	bh=HLz2uHV69vrCkaGQhab/q40tAB7SsfLG83ymQ58tejk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WpGtpGOLYvsuWf+Jc275Q9yeO4edGim+gnzTzOQqAKblJgCIh6yEhnbfuG2y9StIdnpAkZRSNYgtKcJ6sml7r8YJPfuUAn6eGHtC1KbzUlp2guZhS2KajEY3vYKyeFpg2ZmbdhmQ22FVMnldZyBR7HY8xiH4lInhmbp26WIeE3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sOjiN6ls; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79921C4CEE4;
	Tue, 25 Mar 2025 11:33:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742902437;
	bh=HLz2uHV69vrCkaGQhab/q40tAB7SsfLG83ymQ58tejk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sOjiN6lsR1msZ8KdbF6Vdgao+eQC0NO9eeLEm1M7SCQ/e4dW0rPl4sHZAG1HBoyEW
	 DIURwd+IECNwkhge7Qdqu/q5gUz2iEBgJKYPUtVeBLIsviA7Z0waLfZRHnvrS8Av4O
	 NvZpTLdNK4l5+O1Z3Q7C6WgtGlxU93fpHtD4B0i3G/FFwBh986QDA37SfUQ31xiQKh
	 h0InQjkZvJygzqyTqU+LRmMgeEaJd9IoopKKRXyv06ekyjpqRWB/sXfd8MbFvVsmQW
	 G3K0AQI20IB6zR8AINySGKNTwqhknMoiscs9OK1O8ZikqHC4Tpb9j2w8RlIG4V5JGn
	 4p8idevLiUIuQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	ziy@nvidia.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1.y] mm/migrate: fix shmem xarray update during migration
Date: Tue, 25 Mar 2025 07:33:55 -0400
Message-Id: <20250324210259-4c1c4c7f7c182ab8@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250324190144.244275-1-ziy@nvidia.com>
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
⚠️ Found matching upstream commit but patch is missing proper reference to it

Found matching upstream commit: 60cf233b585cdf1f3c5e52d1225606b86acd08b0

Status in newer kernel trees:
6.13.y | Not found
6.12.y | Not found
6.6.y | Not found

Note: The patch differs from the upstream commit:
---
1:  60cf233b585cd < -:  ------------- mm/migrate: fix shmem xarray update during migration
-:  ------------- > 1:  05f98b99ab8a9 mm/migrate: fix shmem xarray update during migration
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

