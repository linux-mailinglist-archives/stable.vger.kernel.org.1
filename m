Return-Path: <stable+bounces-144045-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FA03AB46BC
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 23:52:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 199EE1886C3A
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 21:52:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48198299947;
	Mon, 12 May 2025 21:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MDTumlay"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 086C9298CDB
	for <stable@vger.kernel.org>; Mon, 12 May 2025 21:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747086713; cv=none; b=qFzpg/iaOF3WJJ5iO5KHZdn7KdlyodsRCltFvZNkBQcBONGFvpm/Bno2SNbybk/MpeSLW6bQk1awD/HTLNN3Qc+OTB9LNizXSooDveY910dJYVEJdpORX9AcmBUKuQDPyFX0LW8XWU4aVtAyvo0A+fHCUqmnMchcgPl4Ig6RmG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747086713; c=relaxed/simple;
	bh=dbaFZGRzdyKLfG7GRPTt4JpuxsuY9CcLCxXgQl9v8t0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qPA3BIANFfM3kdD/V2LRXjZEuaVtfvQZ3M4MCMewBZFTtll7dQX9ZxY7cP6X/nenGpMCjQ+joFzbcPzkIZ+49fnR97lfBrO3eJjfJZcQhlMg0lg1RUfEW9eD3qVclyvGnzJdFZ5UFJXgkw7xElUlx5re7jQXxwIe3r1fYmYprmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MDTumlay; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 131D5C4CEE7;
	Mon, 12 May 2025 21:51:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747086712;
	bh=dbaFZGRzdyKLfG7GRPTt4JpuxsuY9CcLCxXgQl9v8t0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MDTumlayyc7MEpz/vU4DMcoTw9EHMwdFnHsbTyz0+KaGkKXMfm5IbGDzvD7QW7Mhr
	 QgfHMK5GW86uAamulWtee5Wq6FW78euCYTAPgZuXNb3qi/x9ky+0jN+HxtKFYO6dvV
	 tiLgu1RaWbHXZR7b510k5wHBmzSr0pzDWUpZToTOq6ds2cU2GPffvJbPR1wM4yJwP+
	 M1EE7mu6JZGRVlcSY18LXfTgmYAahqcYzJV+muC2iBNyEv5quJIhoFkUNwNFrfzDjZ
	 HxN6OzWEKI5Nikacd9Y7D3DvnC06qplCOZ4ElMype2b6N4sTUfhNtDohEgFB8jtf7P
	 x4dPXs7zAMw/Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: jianqi.ren.cn@windriver.com,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1.y] netfilter: nf_tables: fix memleak in map from abort path
Date: Mon, 12 May 2025 17:51:48 -0400
Message-Id: <20250512170721-b16de47a5a8dd571@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250512030252.3329782-1-jianqi.ren.cn@windriver.com>
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

The upstream commit SHA1 provided is correct: 86a1471d7cde792941109b93b558b5dc078b9ee9

WARNING: Author mismatch between patch and upstream commit:
Backport author: <jianqi.ren.cn@windriver.com>
Commit author: Pablo Neira Ayuso<pablo@netfilter.org>

Status in newer kernel trees:
6.14.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (different SHA1: a1bd2a38a1c6)

Note: The patch differs from the upstream commit:
---
1:  86a1471d7cde7 < -:  ------------- netfilter: nf_tables: fix memleak in map from abort path
-:  ------------- > 1:  6b7fecff39202 netfilter: nf_tables: fix memleak in map from abort path
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

