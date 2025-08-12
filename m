Return-Path: <stable+bounces-167128-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 150CAB224F7
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 12:53:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BC3E3A1E96
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 10:52:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BF472EB5B9;
	Tue, 12 Aug 2025 10:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IuDS2MZw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DC7B2E7641
	for <stable@vger.kernel.org>; Tue, 12 Aug 2025 10:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754995923; cv=none; b=Wf/fnlfPeVipasKueAiFIaSIN3kgDNJxfkhcRLwKQpOsxP+mqbtjiVW6/c3GgU8k63cT9skig+M3k0sx4SHIKlguN0zyseB7zkBBasMU+YgyC5rBLYYkE1hDQzQcNzTnbr66TEs/TWNnh4ZrVm5zsDD5U2YUhOopduZFg9zBNj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754995923; c=relaxed/simple;
	bh=SHUUFZSaf973il2yejBrGPjJhmnxUXluSVHzcJlgUwc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jf2VzCBFXwSJyWSODuMcih4jVnVu5VzRZiEBytLSNwNaRDPhsDxzJGT4uAMpYbxHbYXPeyPYzqQt5zpy2T9Np+Nt3jaBHxWDQELqeUCvQ4SGe6n/9ZoCNZket97K/Ac6P6Byt0x/0dXzYdlUlmfgWNC0VhtBLbDBaLHpcMefn2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IuDS2MZw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 117CCC4CEF0;
	Tue, 12 Aug 2025 10:52:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754995922;
	bh=SHUUFZSaf973il2yejBrGPjJhmnxUXluSVHzcJlgUwc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IuDS2MZwLpOi4teycX4ggJUs/u/S+O7l9zHY2NSfoeElTBchS26LmI0ZRxZ0Xf/Ug
	 zJX5fjz0CwgVIUgd4bunu849CrIpk6cfR892i6ZqKGU6Z07kXRp3Gb31CEPROKesXm
	 har9IhWd9qGMUrPGcZJMzu3Y77vgHyXJ8NOp63OgqMJheRZL4eau3l+yTp4A6woEJu
	 j/RnwckNcK4bF1DYwX8XQNLQ2nK1f0u7BwGZObS+/5KcXFeWjVrLPPJ2M0Nufst4tz
	 t+QiPK18JysY7giLscRSn27H/tNAO5vbR1wI5ArkW0Mbg97xRWh7UQwDU8BXMNpOhk
	 KU8rzWEWpsQYg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.4 4/6] kbuild: Add CLANG_FLAGS to as-instr
Date: Tue, 12 Aug 2025 00:12:19 -0400
Message-Id: <1754967490-a8b4f4a3@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250811235151.1108688-5-nathan@kernel.org>
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

The upstream commit SHA1 provided is correct: cff6e7f50bd315e5b39c4e46c704ac587ceb965f

Status in newer kernel trees:
6.15.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (exact SHA1)
6.1.y | Present (different SHA1: ae5a2797e742)
5.15.y | Present (different SHA1: f85d6a08cc9f)
5.10.y | Present (different SHA1: 58c2cac0e779)

Note: Could not generate a diff with upstream commit:
---
Note: Could not generate diff - patch failed to apply for comparison
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| 5.4                       | Success     | Success    |

