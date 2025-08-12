Return-Path: <stable+bounces-167132-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C80CB224FC
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 12:53:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52ADA1889EC3
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 10:52:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CAF62EBDD5;
	Tue, 12 Aug 2025 10:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WjurytST"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C4BB2EBBBB
	for <stable@vger.kernel.org>; Tue, 12 Aug 2025 10:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754995934; cv=none; b=SDW6FmM/R4Fjn9jkaD8Qno82YpJVarXRyngOkRTEQWCqC89ranwn+0GdraIjuIm6NsxWNW0KPtyhK00VU82vykMqsfnFKH6Zp3nER7SY59v7NsqQVyjNiylpvvKQAOdnVEmall+yr2sDZZWBuUjKncbUGr26c3vGV6Ox9oOCvVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754995934; c=relaxed/simple;
	bh=K9z3em2z+rNHfiO2kVcdJYBqm3B8nlhbUmdhKigFqsA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pPhpFB3yMC9jGMvEzjFyrKER9rlGNzamML8BAiHM+u3UFy6aKKVw+Y4QDFETiCS42hljBjqCiYtep2oFCCADqgOhUBfwEQU7DRT7l04hpsRPfJ/TOmbIhFibFOEQ+zA4Z+ft+dOiwfEEI63f983mVdVDiKory/9CVtK0Skq4Ok8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WjurytST; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23419C4CEF0;
	Tue, 12 Aug 2025 10:52:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754995933;
	bh=K9z3em2z+rNHfiO2kVcdJYBqm3B8nlhbUmdhKigFqsA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WjurytSTqSdgVA9Vdlfz6/MFIzgqJrqab+fQsIyKCLIkqJ71BloYXaKMSlhhCd3T6
	 bNLNSgO2SpTGbQ0XOwAS/TVsmaFP5HLeGxl4FHPqitLRGZ+iGeLPHgXmCXBjDsPGGh
	 cJE1K0WxLNgDDYiNjovHv+LCBEan+WYTiMUgRtjufd3EtsysLMl8aNzS0PgKdtmxBy
	 59WZyyJhZ4TbCy278gTyoz28RKasX6rk7z7AbTfvfdK0qe5upBwoBroOlbT1glnoZs
	 pqwDKosorl6fFViRI6wMD3++E97bQbK4PDj68nQDU7LyNSH3OfrOXmTmyv31y7MzTp
	 CWeiQ4TvUAWFg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.4 6/6] kbuild: Add KBUILD_CPPFLAGS to as-option invocation
Date: Tue, 12 Aug 2025 00:12:30 -0400
Message-Id: <1754967704-4a8c2799@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250811235151.1108688-7-nathan@kernel.org>
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

The upstream commit SHA1 provided is correct: 43fc0a99906e04792786edf8534d8d58d1e9de0c

Status in newer kernel trees:
6.15.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (exact SHA1)
6.1.y | Present (different SHA1: 0f8b3913b3fd)
5.15.y | Present (different SHA1: 510ce6a1393c)
5.10.y | Present (different SHA1: 79a4fba715fa)

Note: Could not generate a diff with upstream commit:
---
Note: Could not generate diff - patch failed to apply for comparison
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| 5.4                       | Success     | Success    |

