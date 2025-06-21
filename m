Return-Path: <stable+bounces-155230-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2036EAE2887
	for <lists+stable@lfdr.de>; Sat, 21 Jun 2025 12:15:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 837313BF4F8
	for <lists+stable@lfdr.de>; Sat, 21 Jun 2025 10:15:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACC011F2B88;
	Sat, 21 Jun 2025 10:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c68+PB/N"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CB6F1F0E29
	for <stable@vger.kernel.org>; Sat, 21 Jun 2025 10:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750500921; cv=none; b=Yd/kSrK5cR1hvIVaAu0sJ+D47J5QIlHTDA/gt79TeRyXR5j0rlvS03G+FzoQXsUy/Kv3iB2PUvv16v5Nh2U1esP2S2oJOtbQKewPMlbpLMmLhLpQn52nKbPmRs1gNmMGWCUm/4bg6+xvfkSM+1B5GxBP+ijaVsG5dtnJwypdMWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750500921; c=relaxed/simple;
	bh=xuAlHzaOu2CRR56MAOOofOfuvRF6M/i0y5XMIt3Y10A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tSt32R5Ip7hE1BoKdNPvdgBFqYsbrJgPO6BW2NSyKEE5+oYg2GiDJ0LhDNCgdXUoFE+cI11keJrmhMFwXuSARLz7fxHWSI17BsMvJdcp5nYRowhGr+jZa0dfoGE4ZQQJqWrDSwJnsbfzkKu5btIFdMfxgjyCCgDixZznM3TdO+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c68+PB/N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9926CC4CEE7;
	Sat, 21 Jun 2025 10:15:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750500918;
	bh=xuAlHzaOu2CRR56MAOOofOfuvRF6M/i0y5XMIt3Y10A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=c68+PB/N/UkvmuNYDFY5s0KMtvdN0UJvBREqvEAcTvIdlXWygnvlE4/FwO5ONsrpw
	 W3vHvGdBw9+1Rwp2kvX2qtKvLosGP7W3GTszLgbyvTR+aon+lBcwVEubDXzZXekpGl
	 uLWZRRXL+zku4OcxYCNmY0L8Cin5nVA3wHdOrvet1i3Kew1VPf1x0fkYRYM8A0586f
	 OW563wY3guX7qNGPxK6jRN30nrayGb6OfEnZ5TaSjTz5aLH5gTGIKvT99/A3cRTQqR
	 DXhxn6AU1u0Ejj+81xNlowc4CkE95gy7u21bGvav4Yis8fSNl6kPDkb2v7U7KVBj0x
	 Rdh7iqCyQ7V7g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Gavin Guo <gavinguo@igalia.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.4.y] mm/huge_memory: fix dereferencing invalid pmd migration entry
Date: Sat, 21 Jun 2025 06:15:16 -0400
Message-Id: <20250621054648-7390730af94fad42@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250621053831.3647699-1-gavinguo@igalia.com>
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

The upstream commit SHA1 provided is correct: be6e843fc51a584672dfd9c4a6a24c8cb81d5fb7

Status in newer kernel trees:
6.15.y | Present (exact SHA1)
6.12.y | Present (different SHA1: 6166c3cf4054)
6.6.y | Not found
6.1.y | Not found
5.15.y | Not found
5.10.y | Not found

Note: The patch differs from the upstream commit:
---
1:  be6e843fc51a5 < -:  ------------- mm/huge_memory: fix dereferencing invalid pmd migration entry
-:  ------------- > 1:  0cef68ff0d759 mm/huge_memory: fix dereferencing invalid pmd migration entry
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.4.y        |  Success    |  Success   |

