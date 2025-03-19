Return-Path: <stable+bounces-124906-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F8F9A68A0D
	for <lists+stable@lfdr.de>; Wed, 19 Mar 2025 11:54:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 320F419C28C5
	for <lists+stable@lfdr.de>; Wed, 19 Mar 2025 10:54:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D052D253F24;
	Wed, 19 Mar 2025 10:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kzi/PtIm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9069B253B71
	for <stable@vger.kernel.org>; Wed, 19 Mar 2025 10:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742381665; cv=none; b=RDEsaapT8BDE2gpal6Y2v4Rfm3hgli4RheFUycJ6WehewwxN9/oeIlifhAj7Snhm9n7OXYIacPER4b/pD3uMYcQkGtNb3XuBRCcReDV6N5CfkJzllhBljl4V7ANnZ2zYvCrAR1eYqG2oSnqnVDA1AuM+TTgxBUiiOZQd1op0W/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742381665; c=relaxed/simple;
	bh=llgHNs8Z9NHWkzL2CtcPvluh94W+svwd5wIFCFnOzCQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fF7Z5bNow3w4bW3m/u9uuDnTUlEmwplMLTcXEZ21c45SCyLsP1aILo6BLGmt6lxRVIvZCnq2EWoxA7k/TBCOzAeKUt2XBgfRA6zTbLsY4Jla5XdUzwk1pZcDiGkhunWmAhbKhXhJ2lHNVWlsRNw/lLhFFT1o6RaAMSO0KYsG8tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kzi/PtIm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89717C4CEEC;
	Wed, 19 Mar 2025 10:54:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742381665;
	bh=llgHNs8Z9NHWkzL2CtcPvluh94W+svwd5wIFCFnOzCQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kzi/PtImrcQBZJhr5+cTzMOLpk7LoUb4TVbnoSgmFB6SPoHE0ZX7+8z18GPx0ypaI
	 PGgSlz8dBjImF9SYvVq9B2WgSCHNhL/j9ghxEgdw7licpZWPfrPud47zsAuD9DTkF2
	 UkwfWL7sAC0AVdbUjf+OnAc50WtvJOuxIdLU3xrsMPoKz+/xHUY3tROAaJZtBF+GDM
	 aKKTfkr7yPBzippnCbmhm+2RqRCeW0XNAeW780qqLUcqXtvtn55GqOiiZ3+wgZLqY/
	 Q2HLJTn7iYGrSzDPJDPLOKfYLJjBfK8vUCJxunjCdD+qOU+blrVlsCNB534pccAhJw
	 dGQD6xUFA3aoA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Pablo Neira Ayuso <pablo@netfilter.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH -stable,6.6 1/2] netfilter: nf_tables: allow clone callbacks to sleep
Date: Wed, 19 Mar 2025 06:54:23 -0400
Message-Id: <20250319064749-fb4e36806f33728f@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250318220305.224701-2-pablo@netfilter.org>
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

The upstream commit SHA1 provided is correct: fa23e0d4b756d25829e124d6b670a4c6bbd4bf7e

WARNING: Author mismatch between patch and upstream commit:
Backport author: Pablo Neira Ayuso<pablo@netfilter.org>
Commit author: Florian Westphal<fw@strlen.de>

Status in newer kernel trees:
6.13.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)

Note: The patch differs from the upstream commit:
---
1:  fa23e0d4b756d < -:  ------------- netfilter: nf_tables: allow clone callbacks to sleep
-:  ------------- > 1:  594a1dd5138a6 Linux 6.6.83
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.6.y        |  Success    |  Success   |

