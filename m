Return-Path: <stable+bounces-132853-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B978DA90663
	for <lists+stable@lfdr.de>; Wed, 16 Apr 2025 16:29:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70AD33A9B29
	for <lists+stable@lfdr.de>; Wed, 16 Apr 2025 14:19:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0249F205AA8;
	Wed, 16 Apr 2025 14:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C/9wmI6C"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4DFF1FCF7C
	for <stable@vger.kernel.org>; Wed, 16 Apr 2025 14:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744813021; cv=none; b=VknJ5rE5v3urjpV/eG9RRka+yuC+41HCloyjOkZZBygxpMNXjVN6mLlT2xttjD3RDvfFl9XvxZqv5e9QSdxgZx/Y6hSr9YrLwWNyhOsHBq7A4PRo4NOEyQPXZh+2PSzGLfXHDaKVGAp5XwUr5AST656ArYfAxzr3k/o8lnALtzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744813021; c=relaxed/simple;
	bh=QvEDFbxaiBBLKHb0atxX1s1nKCRMJ6PdBVc8PZQWlMc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Oyymkd2zqzBvgoqbZO1EsyBDPr8GT4VbBVSi/D6seDwkd9Vlqx8lQ2uCSOV1oXX080Ud/TIr1u5t3owyvoUYHKjWNtycvPEp50iv5kB5Y+ohB/VjC5VJy5Aw+N21BNjMWDnCSTcuAT7sn5appn7qD15bjW8zmgKkCDy9sbli9xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C/9wmI6C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0389FC4CEE2;
	Wed, 16 Apr 2025 14:17:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744813021;
	bh=QvEDFbxaiBBLKHb0atxX1s1nKCRMJ6PdBVc8PZQWlMc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=C/9wmI6C7VI1yMNIgPEY5vp+LaeGtvUHpT+hfkvDAFMZ/VfY6ALQSaLvyT4jgInuW
	 CweJudRJf9BbQoXEKMqYUnNI/MjN46qQ68Fx9jWEUXqkNQEU7duvJkua6UjXa7Sx3L
	 VemHe43ucAgg0mQxgHzDjq2hTZc898qXOZbFbgSXT+tGrUjWsyLnboVC5sZurYauw7
	 F+KRsk0ZXCFB/b6fgD1MB890y2SOGYYdgZJ1bgA0JcQoOVW/TKbjJR38lisE/uxmib
	 X0SK6sU0gyTlSmFwoO3c6XJK8UAos+MXFqz0w6HRS/uJunB+PLafY/zndzZ2UW+JVO
	 pCOIyVlWo7Ylg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	jianqi.ren.cn@windriver.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1.y] btrfs: fix qgroup reserve leaks in cow_file_range
Date: Wed, 16 Apr 2025 10:16:59 -0400
Message-Id: <20250416094747-959a2c701d0fb5ad@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250416005517.387669-1-jianqi.ren.cn@windriver.com>
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
⚠️ Found follow-up fixes in mainline

The upstream commit SHA1 provided is correct: 30479f31d44d47ed00ae0c7453d9b253537005b2

WARNING: Author mismatch between patch and upstream commit:
Backport author: <jianqi.ren.cn@windriver.com>
Commit author: Boris Burkov<boris@bur.io>

Status in newer kernel trees:
6.14.y | Present (exact SHA1)
6.13.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Not found

Found fixes commits:
2b084d820594 btrfs: fix the length of reserved qgroup to free

Note: The patch differs from the upstream commit:
---
1:  30479f31d44d4 < -:  ------------- btrfs: fix qgroup reserve leaks in cow_file_range
-:  ------------- > 1:  34cf514d95e39 btrfs: fix qgroup reserve leaks in cow_file_range
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

