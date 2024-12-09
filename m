Return-Path: <stable+bounces-100190-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F3BB09E98F5
	for <lists+stable@lfdr.de>; Mon,  9 Dec 2024 15:35:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 891FE1887CBE
	for <lists+stable@lfdr.de>; Mon,  9 Dec 2024 14:35:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E99B1ACEB8;
	Mon,  9 Dec 2024 14:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HthPG+S5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B99723313D
	for <stable@vger.kernel.org>; Mon,  9 Dec 2024 14:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733754903; cv=none; b=SCH3gzLUYfuDDqMse/DRWSxiY/djP5lWVHUs7ANP7vzxR6S1kv81sTXUMXt1h81n2iVjgykz58pnI8zF0E1tpzKGlNkzG8xg7H0gDkUIgdRqwtuXvgCqbhsoLWJcajZS9/PMwU+E4DbetJ/o2nWO0z4GvPApXJzSMPas4CV1w1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733754903; c=relaxed/simple;
	bh=b/VLw35LTvWk63mWTl1MH1DHLcGakjkhQMaG+FJcdZM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LHUjl2HYrLhdQifUhd9UTS67MyCadpAokYOxPwgagr6mR6zuU7B5KyZwLTMOvsH+zE9ORMVJ3Wn+5pRZ7jMZatB0RTR815yT4dEks39RNCCgw4XbYjz8/Gj3bkdjLKyZiVC5g0nDfImzps4mZtVmlwS6xBI6fa0mdYcBCDQJpBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HthPG+S5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15B17C4CED1;
	Mon,  9 Dec 2024 14:35:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733754902;
	bh=b/VLw35LTvWk63mWTl1MH1DHLcGakjkhQMaG+FJcdZM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HthPG+S5JgwxNbEl3T6SBwQ/MSuFOPCXmd2sw8cYig3HImfW8e492kvXb6cXvh1En
	 uXVjLNVlEqdQ6V+Q6b/iaqCxDNtIyRj//nYWYFyT88VB3aNbayXuoyerQ/Qb/j94eq
	 qT9FvEFLL/J/o40RFzkgsmUYOXeUMK/9g7Fmhevr/zavCvHsRisUL2jRvvS07qpAOv
	 R5OTXZa54fuRZmAgyc0WEIzEFnnPUbvvbEJ82hzFy7ugr8ITrZUK6XgwiG+1mpaqSP
	 0EsmTOwI0fG2bqV/XadvyJYvdyLuodVrgrJQlapvvXdEMtANkxDxVG0KwPRra8HPyQ
	 cV4761JFSA3DA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Nikolay Kuratov <kniv@yandex-team.ru>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH v2 6.6 6.12] KVM: x86/mmu: Ensure that kvm_release_pfn_clean() takes exact pfn from kvm_faultin_pfn()
Date: Mon,  9 Dec 2024 09:35:00 -0500
Message-ID: <20241208092103-3423b93a7ab12957@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241208083830.77587-1-kniv@yandex-team.ru>
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

No upstream commit was identified. Using temporary commit for testing.

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.12.y       |  Success    |  Success   |
| stable/linux-6.6.y        |  Success    |  Success   |

