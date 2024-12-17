Return-Path: <stable+bounces-104406-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D1BB99F3F43
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 01:45:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F4027A4A12
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 00:44:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E66A956446;
	Tue, 17 Dec 2024 00:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s9tCVVG0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A32C453368
	for <stable@vger.kernel.org>; Tue, 17 Dec 2024 00:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734396137; cv=none; b=RJdMGViTVz9GGCaUg9Ty6pRP8AxIiuw2KMz5w6p4n+q5Wk0CunA4w4phyI61bHPIsLfH2G3DVsTzIjHcR6wIoB3bA+jR0THVQdMzJjKX7uN/yj2bywfP3oq36yRPvCrgwbdaFt+142KyZxIetVJyw1PMoHiNDdXbx2+kMvoyxm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734396137; c=relaxed/simple;
	bh=5iAxd4CnXzl0u9I/oLXfSb/3Hp+5qO0mVyQFCsXfX/E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qz/h8Oe2ZI8HtOqCCi3cXgoeaMkQnQkHQYavd0IPwnZy3AouVS1JiHIgaHmaFvkhQL63ztNVaW1nQxGd6HZ7LzE2/tON+mjjeticPQYdYv4dAOJ/cm0vLCk0dZOLGoJl7aAAsERb9HfTJVImE3ud4138OLtPfA6PplMx/HA5TV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s9tCVVG0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0D04C4CED7;
	Tue, 17 Dec 2024 00:42:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734396137;
	bh=5iAxd4CnXzl0u9I/oLXfSb/3Hp+5qO0mVyQFCsXfX/E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=s9tCVVG0U/wwfDiaZsLkR3eng1ecDkIxLmgOq8DmwJ0UEVoMtDx9oe3tBdDiJYVZE
	 k1HYa/8EOgvRyU3oxwPp/iDcTL+yT1/FLkvNpKKZlfkxemZUczgnyZV3+O9Yosi0Ea
	 9u2MNIrw0DMQbr/XJgwXtdlAS3f89Eam1Cplxz2J0rigOxizW1y/L1yncycdcD+6jM
	 uAjmMfejmTHCBzi0dUyLtxReiqXWCQGz8JYds7tEm/EU09LONa1qooB9O04ndUjefj
	 q+OLnYjsTmsF3o1AOc26pUXLTpUHaXNeSk8p3U9Etcy7b0qojuoy4boJfXnoAh/E0j
	 KC4OPkEtXTBlA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jiasheng Jiang <jiashengjiangcool@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.10.y] drm/i915: Fix memory leak by correcting cache object name in error handler
Date: Mon, 16 Dec 2024 19:42:15 -0500
Message-Id: <20241216193233-9161e6336005fb92@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20241216161840.4815-1-jiashengjiangcool@gmail.com>
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

Found matching upstream commit: 2828e5808bcd5aae7fdcd169cac1efa2701fa2dd

WARNING: Author mismatch between patch and found commit:
Backport author: Jiasheng Jiang <jiashengjiangcool@gmail.com>
Commit author: Jiasheng Jiang <jiashengjiangcool@outlook.com>


Status in newer kernel trees:
6.12.y | Present (different SHA1: 1c7f63e645a9)
6.6.y | Present (different SHA1: c98cff29e48f)
6.1.y | Present (different SHA1: 237fe21e40c7)
5.15.y | Present (different SHA1: a4d0c3c28c3b)
5.10.y | Not found

Note: The patch differs from the upstream commit:
---
1:  2828e5808bcd < -:  ------------ drm/i915: Fix memory leak by correcting cache object name in error handler
-:  ------------ > 1:  e0b528005793 drm/i915: Fix memory leak by correcting cache object name in error handler
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.10.y       |  Success    |  Success   |

