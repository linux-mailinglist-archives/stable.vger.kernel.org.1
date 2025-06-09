Return-Path: <stable+bounces-151976-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FF88AD16E1
	for <lists+stable@lfdr.de>; Mon,  9 Jun 2025 04:34:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6BEEC7A4281
	for <lists+stable@lfdr.de>; Mon,  9 Jun 2025 02:33:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91D2A2459C9;
	Mon,  9 Jun 2025 02:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="URS5hqG5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5159B2459C8
	for <stable@vger.kernel.org>; Mon,  9 Jun 2025 02:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749436483; cv=none; b=u9FA4iHazul01xMf405snPxULvxsniiQ1JqWL/hVvtcnWhh/taNlZWxQbWsN6OKFskKHqbPSsRog7lu+7qj+5yY4MD3uDjDObeUfkz+oVwDIuHa6M2SvlIZcddEx799d6kxCRUVlsh24O1/K8LCgdP0HBiIHqJ8Ta87OQIw8rfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749436483; c=relaxed/simple;
	bh=BkI1hSVyufupZ2glf1ZIMU0KC2l5Q3nCcpRR1rPF2bI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fOni8jWQm6DlpAGXq8hZh5ktiZfIXQX9eJCa6kCHI4KTNWygH9W7Dt+tnsdsJvdQH/gef3cEYAee0I6rGtrvYnvC4ej/E8ljIebMKu7M4rBA9XuW8WKQkclVfML2iAaC6neTKtePhc9FFNGUB99en0eot3EMHScnVM7KzeC+lBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=URS5hqG5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 562B2C4CEEE;
	Mon,  9 Jun 2025 02:34:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749436482;
	bh=BkI1hSVyufupZ2glf1ZIMU0KC2l5Q3nCcpRR1rPF2bI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=URS5hqG5pDRHfvkIgdkeLwJWzB4DRTly9g4/LuXxmv/Cqb5ZKxrl+rGoAxqNid0YT
	 ZZY2FI97XR4j07VUd0U+E+3oaWkxpe8iaNBD14somiHczX3TYKnEEFuXDMbpflIOrw
	 okVm3GQlW9mxJET5ccmnwR8jHO9oCEemrzR0umiYRWFsMkBUQEXD46Gy4t2BMp1JWU
	 j2IqmS/FUGfX9Jtn5FGPIYTPnc926KBY22Hje5rqi4AN3/Elm26RIVe84KVODPDTsE
	 y1yhhfcLqQR15blu4cIDIgw4uBxUVEUoPcvuXdBAX0ETTa3GftoPO2xAJJMraC0Jrc
	 BH8/RsJ8xzN6w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Pu Lehui <pulehui@huaweicloud.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15 4/9] arm64: proton-pack: Expose whether the platform is mitigated by firmware
Date: Sun,  8 Jun 2025 22:34:41 -0400
Message-Id: <20250608160027-fc1b7f5e848ab67e@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250607153535.3613861-5-pulehui@huaweicloud.com>
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

The upstream commit SHA1 provided is correct: e7956c92f396a44eeeb6eaf7a5b5e1ad24db6748

WARNING: Author mismatch between patch and upstream commit:
Backport author: Pu Lehui<pulehui@huaweicloud.com>
Commit author: James Morse<james.morse@arm.com>

Status in newer kernel trees:
6.15.y | Present (exact SHA1)
6.14.y | Present (different SHA1: aa32707744d6)
6.12.y | Present (different SHA1: ec5bca57afc6)
6.6.y | Present (different SHA1: 854da0ed0671)
6.1.y | Present (different SHA1: 351a505eb478)

Note: The patch differs from the upstream commit:
---
1:  e7956c92f396a ! 1:  9cc988b44d8ee arm64: proton-pack: Expose whether the platform is mitigated by firmware
    @@ Metadata
      ## Commit message ##
         arm64: proton-pack: Expose whether the platform is mitigated by firmware
     
    +    [ Upstream commit e7956c92f396a44eeeb6eaf7a5b5e1ad24db6748 ]
    +
         is_spectre_bhb_fw_affected() allows the caller to determine if the CPU
         is known to need a firmware mitigation. CPUs are either on the list
         of CPUs we know about, or firmware has been queried and reported that
    @@ Commit message
     
         Signed-off-by: James Morse <james.morse@arm.com>
         Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
    +    Signed-off-by: Pu Lehui <pulehui@huawei.com>
     
      ## arch/arm64/include/asm/spectre.h ##
     @@ arch/arm64/include/asm/spectre.h: enum mitigation_state arm64_get_meltdown_state(void);
    @@ arch/arm64/include/asm/spectre.h: enum mitigation_state arm64_get_meltdown_state
     +bool is_spectre_bhb_fw_mitigated(void);
      void spectre_bhb_enable_mitigation(const struct arm64_cpu_capabilities *__unused);
      bool try_emulate_el1_ssbs(struct pt_regs *regs, u32 instr);
    - 
    + #endif	/* __ASSEMBLY__ */
     
      ## arch/arm64/kernel/proton-pack.c ##
     @@ arch/arm64/kernel/proton-pack.c: void spectre_bhb_enable_mitigation(const struct arm64_cpu_capabilities *entry)
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

