Return-Path: <stable+bounces-98160-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96FFA9E2A88
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 19:13:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DE2C1664C2
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 18:13:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EA6B1FC0FD;
	Tue,  3 Dec 2024 18:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sl3ms3bT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4B901F8901
	for <stable@vger.kernel.org>; Tue,  3 Dec 2024 18:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733249622; cv=none; b=azwkQroB/aqeqsRxmIGnb0pTY6vvS/LAmOuCL3L3EZgbkR3QheqSXIkUyeudEyaSAVS3KW9YAr8CBFMY76gu6W0TkDWaLJW9cLe86PmXm9BulnWEQv4S1YkQH6Be58QiydzFwTl4UZ0sPIhmqNWuY4ROUAsjOjFcyRNHHfYQQYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733249622; c=relaxed/simple;
	bh=/Az+hhvtBqhlIbI6qoyG3vBI2JK04wplhHsjMA/yTYI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=coZXyoTz6mnwJi9GFSJK+XngI1Zu2A2fXAufRC90ajxFe2F54QqvN4xjqw3IlkWeWtQFf2wLuF92A5WPpHAephzum0s6SddTIuSdL/XPfm2EKTtSuc/d6DI1pcvRwR+Ss7sNJ6zKG4h96s6pz6I41ulrLy1aE2EPmSH9jRp4fAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sl3ms3bT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58310C4CECF;
	Tue,  3 Dec 2024 18:13:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733249621;
	bh=/Az+hhvtBqhlIbI6qoyG3vBI2JK04wplhHsjMA/yTYI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Sl3ms3bTAJjv8H1M1sE9nx+lJ//z0BWHa3Z1vpdelH4vmeiNZ+JKYhe61y4Texwnn
	 3qqURcNXSnIpvn1P7E3OOGutg/M/GeMvyhE2OEjozhiwHIsNoAaPgdgI5cz1zpn8tn
	 9cgEjXvBV25/0AntqW0ldrR4cVjxeiM2uOt7g+PJh6CHWrXFK9VQ3DfL1Xu2CSmgxF
	 83/Txxe2DjGINY/uz7nF5BNSmOQu/6u/hSqRSEKTv6nTaO1pGXPFGpgEVLN0telzeK
	 /jjuY8QmifEzhl/CAYlANhbj0uYEIaKv5k5/t/XrjVeaHRNuo/j1amo4IXs2frdly3
	 D3zFG4ez16rbg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.12 v3 3/3] net: fec: make PPS channel configurable
Date: Tue,  3 Dec 2024 13:13:40 -0500
Message-ID: <20241202131517-fc149c7c7424f7e6@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241202155800.3564611-4-csokas.bence@prolan.hu>
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

Found matching upstream commit: 566c2d83887f0570056833102adc5b88e681b0c7

WARNING: Author mismatch between patch and found commit:
Backport author: =?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>
Commit author: Francesco Dolcini <francesco.dolcini@toradex.com>


Status in newer kernel trees:
6.12.y | Not found

Note: The patch differs from the upstream commit:
---
Failed to apply patch cleanly, falling back to interdiff...
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.12.y       |  Success    |  Success   |

