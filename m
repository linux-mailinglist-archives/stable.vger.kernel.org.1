Return-Path: <stable+bounces-128396-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 628DCA7C905
	for <lists+stable@lfdr.de>; Sat,  5 Apr 2025 13:58:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33E1F1753BC
	for <lists+stable@lfdr.de>; Sat,  5 Apr 2025 11:58:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E78BF1C28E;
	Sat,  5 Apr 2025 11:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M/pEfXc9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A74858F64
	for <stable@vger.kernel.org>; Sat,  5 Apr 2025 11:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743854286; cv=none; b=g9AVHs1mJJ+4eG8tFhQfcb3Epvgq6KyWzCvv+byfIqjKCiymd0bJZxDn5vqEy2TIV7V0ApsEmmSoeqxFV5Hpn8+921nV1zztTwhMrXk1QstwkuuPCS6NVgQlji+lrsBo+GqirRxRfPzC9e9jLBkyyWxt+ltkh9SlWPCznwSL210=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743854286; c=relaxed/simple;
	bh=jx5Yt7E4AeXwatyaORRyo6Srpzs/Suo3O9p/k4kD8hY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SZF3uQIMzfdykXuOMJFU1sX0KhpVss2LDEA/DiaxtTjnMGdi+Zkp8SV9FWJ68kh2+Y7G5Ek7VYQFHiWYz0G5fSzJLNrxNEzBjqlUjUFWPA7j5uzLrNuYSUMinDxSpKTRkpjTlkivMv8W+JYNJ822j9Qm9x2o8BJJQbEctgy8O94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M/pEfXc9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE075C4CEE4;
	Sat,  5 Apr 2025 11:58:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743854286;
	bh=jx5Yt7E4AeXwatyaORRyo6Srpzs/Suo3O9p/k4kD8hY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=M/pEfXc9A+p1lm+1PUwNtgeDoG37rtdqEAy6/jDl5N5IrTqoVU4Cj43/F8YgCZVue
	 1IBLfTEt8czQbvXDWfMhH7davzX2RSgK8x8M48iIfXnx7JmUCt8aVHZNCoJLnhSqCz
	 Vr/bqG9FMqhSRwyrbSifAGBhjygPWLuLYKMeGIFe394cI4EMkQX2mPe2xywT6TNv3c
	 0sisnf540D7KslwRqJKpR4vprurWKqxZbkxAGgpgHht57cQQRkt/Qg/nJQckbUE36z
	 oVC1CTD3B2jteHSlbNPip8QSCUHpXpHVUH2IBri0s03LEU11eRIgi8AGOqrkr4Xrk6
	 bUUCwzEpELsGQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH RESEND 6.1 08/12] KVM: arm64: Remove VHE host restore of CPACR_EL1.SMEN
Date: Sat,  5 Apr 2025 07:58:04 -0400
Message-Id: <20250405022909-07719438c53cfd8f@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250404-stable-sve-6-1-v1-8-cd5c9eb52d49@kernel.org>
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

The upstream commit SHA1 provided is correct: 407a99c4654e8ea65393f412c421a55cac539f5b

WARNING: Author mismatch between patch and upstream commit:
Backport author: Mark Brown<broonie@kernel.org>
Commit author: Mark Rutland<mark.rutland@arm.com>

Status in newer kernel trees:
6.14.y | Present (exact SHA1)
6.13.y | Present (different SHA1: 905ca554d9f2)
6.12.y | Present (different SHA1: cb53828d6911)
6.6.y | Present (different SHA1: 30253b3eb685)

Note: The patch differs from the upstream commit:
---
1:  407a99c4654e8 < -:  ------------- KVM: arm64: Remove VHE host restore of CPACR_EL1.SMEN
-:  ------------- > 1:  8e60a714ba3bb Linux 6.1.132
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.6.y        |  Success    |  Success   |

