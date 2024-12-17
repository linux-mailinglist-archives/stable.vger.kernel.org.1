Return-Path: <stable+bounces-104492-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7709F9F4B59
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 13:55:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC59B16F54E
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 12:55:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04BEF1F2360;
	Tue, 17 Dec 2024 12:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qDK27wJa"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9F441F03FC
	for <stable@vger.kernel.org>; Tue, 17 Dec 2024 12:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734440142; cv=none; b=cumJZaZVJf/D4K/zG78OS2t75TKJatE3eb7vQn5cVTZZvAAuCyFb9lOo0XEiKewlu+Do0Vs/1Oa8CsaSqa4DpHlz6MHHw8IMe0ydAr4lNt1DbUqFlQ3OEYDOsNeJo3btQg68zT/gGu4hoku9EzeAaLxHyOLdTZQ/ixfHyvPTbNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734440142; c=relaxed/simple;
	bh=JbQcwK3IQg56kOB93T4triT31+WF229AxWcVQUmpe8U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HWk2Jsja3KAxDv/B6zvpzxqEM6EokE+/6RXa/lP26RPZPGiZr6WvLMMyLWe9oS9JvvXckxGgB9Z/mBzEkqGnHrIcsQ1RbFk/LfuvyzCOBsZuDAnZJvybZ0hlBkYIvamZ1DmdQq2au6UNtV1POoGhPoDQSUkfxmoYqUD221JvucI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qDK27wJa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5573C4CED3;
	Tue, 17 Dec 2024 12:55:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734440142;
	bh=JbQcwK3IQg56kOB93T4triT31+WF229AxWcVQUmpe8U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qDK27wJa6eDKdSGwpGbgkYkIJDjLvCERHxv6yMLkcmATMvheh6khKO60xH/Y+5MXq
	 Vmc+e7SvxvRfGymzaulVAFg8Q5CJoPHyq8koaURnS+VeKLRNkqr5XvAueg3zs7p/Nd
	 D0L5P8ObBSSQCePDzdZMmMIPWhRbl4XMp3eIcBeBdi8aP1X57D8kd81pmWVLelRlmF
	 TKX82doXIX8cFQM1wb6gBNxl3Na1vtiK7eoQzRYGTrubJuXNVrz2HsqCVbpXnkg2y5
	 tV70djyFH5aDHXLUWv84tDFD70PeTrD5jZj9rLo+SmayZUl8w/IZ7rMUExiRrNOaYq
	 Sao7WCntusZsA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Shung-Hsi Yu <shung-hsi.yu@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH stable 6.6 v2 1/2] selftests/bpf: Add netlink helper library
Date: Tue, 17 Dec 2024 07:55:40 -0500
Message-Id: <20241217071107-2e0131aaa8a24b51@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20241217072821.43545-2-shung-hsi.yu@suse.com>
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

The upstream commit SHA1 provided is correct: 51f1892b5289f0c09745d3bedb36493555d6d90c

WARNING: Author mismatch between patch and upstream commit:
Backport author: Shung-Hsi Yu <shung-hsi.yu@suse.com>
Commit author: Daniel Borkmann <daniel@iogearbox.net>


Status in newer kernel trees:
6.12.y | Present (exact SHA1)
6.6.y | Not found

Note: The patch differs from the upstream commit:
---
1:  51f1892b5289 ! 1:  cd5b69e7d9ea selftests/bpf: Add netlink helper library
    @@ Metadata
      ## Commit message ##
         selftests/bpf: Add netlink helper library
     
    +    [ Upstream commit 51f1892b5289f0c09745d3bedb36493555d6d90c ]
    +
         Add a minimal netlink helper library for the BPF selftests. This has been
         taken and cut down and cleaned up from iproute2. This covers basics such
         as netdevice creation which we need for BPF selftests / BPF CI given
    @@ Commit message
         Acked-by: Martin KaFai Lau <martin.lau@kernel.org>
         Link: https://lore.kernel.org/r/20231024214904.29825-7-daniel@iogearbox.net
         Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
    +    Signed-off-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
     
      ## tools/testing/selftests/bpf/Makefile ##
     @@ tools/testing/selftests/bpf/Makefile: endef
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.6.y        |  Success    |  Success   |

