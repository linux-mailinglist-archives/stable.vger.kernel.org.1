Return-Path: <stable+bounces-137085-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F667AA0C21
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 14:51:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C5391B66104
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 12:51:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E8E92253F6;
	Tue, 29 Apr 2025 12:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bSEMHkV0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DCB92701C4
	for <stable@vger.kernel.org>; Tue, 29 Apr 2025 12:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745931058; cv=none; b=LehE8eiwKZWjPYHaavWmIHDJy/Z8t2DzmbOQVkhjuvpd7gf85Js7naA8jXu3Q2PLNkmqNQ61YimSCJpLy1m+JCEKYDnTQEUrdK7XMt4vQZbpIXvitwGF93isXjBFT9Nsm5xU2BHaUSe4GeUpvSVYj/R/NbA/IZ7YUi/yWFftLkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745931058; c=relaxed/simple;
	bh=ZfcPVq4JWbIYBlBzf1oMaD1lDC210ASOvbNN+0DF9EI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EShZ0CjfmG4zXIBpdkGFN1l2mbuGJLT0m+ry6Cn6WnB/IOItgXOvX1dyeFsSFc8VOE2xWA/X5cfsEZ7NmJVYVe9vbZzcFI0Etn8LmaEe1zQQJGapxcG9KjxLDgyKvkB/q82DxJS40G2uKIEv37Gv8CdY0S2T4MuGuIOiawboebI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bSEMHkV0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C809C4CEE3;
	Tue, 29 Apr 2025 12:50:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745931058;
	bh=ZfcPVq4JWbIYBlBzf1oMaD1lDC210ASOvbNN+0DF9EI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bSEMHkV0kPnIhQ1kX3x87AdvzBPlqPkqbh83Qwgw7txxaHm9+6I2gGkYgkBxh4eKj
	 hI9Tnbf7L9xUjAT7aWaLH2N5/n8dJPecZ+pr2s9oFxkMu4sf3FAvUbg90n3oMixfBm
	 hTfBUd8Cbsug+MdY0NEfs4lp5ufcqgwknspVpqwCOViB6o8qbHvxMzxGYBoYaK4+xV
	 GEij9wyEFUz3fZmynNBzQFt3l19RtZDerRc3qAmkYyIGZ6y3ORA6BcWpxx4DuEHbgl
	 rQv2/TSWRNUB+dY+bNVle3PJbaaYzr1QDHdxynGeG3ZFqB7q+jzLqhtkwu+lnpFTV8
	 /Gy6WZrvlqfbg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1.y 4/4] net: dsa: mv88e6xxx: enable STU methods for 6320 family
Date: Tue, 29 Apr 2025 08:50:53 -0400
Message-Id: <20250428222633-17c54c23eea68194@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250428082956.21502-4-kabel@kernel.org>
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

The upstream commit SHA1 provided is correct: 1428a6109b20e356188c3fb027bdb7998cc2fb98

Status in newer kernel trees:
6.14.y | Present (different SHA1: 1864c8b85c76)
6.12.y | Not found
6.6.y | Not found

Note: The patch differs from the upstream commit:
---
1:  1428a6109b20e < -:  ------------- net: dsa: mv88e6xxx: enable STU methods for 6320 family
-:  ------------- > 1:  2cf974022b3e9 net: dsa: mv88e6xxx: enable .port_set_policy() for 6320 family
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.6.y        |  Success    |  Success   |

