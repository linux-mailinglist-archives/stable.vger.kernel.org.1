Return-Path: <stable+bounces-151970-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6696AD16DB
	for <lists+stable@lfdr.de>; Mon,  9 Jun 2025 04:34:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B07103AA8C8
	for <lists+stable@lfdr.de>; Mon,  9 Jun 2025 02:34:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 317E22459D6;
	Mon,  9 Jun 2025 02:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bT2JrcmL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E72B4157A67
	for <stable@vger.kernel.org>; Mon,  9 Jun 2025 02:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749436471; cv=none; b=dY8dXZxuH3Utu3OnQqDvxr6vfBM6rbIEY89agyXEbM1RYIpw2ZswLRy80n2oS33A73vbdTpQe/leT/FnwvHW8vyEtiFG4GdvCtkfhEDKihkzyAXVSSe4Ag2CkHPu5KPOZLM8I66Myq6M3vsmmZBPAoIVu9iZqUBgPG+cbafgbZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749436471; c=relaxed/simple;
	bh=hW0O3mrk8J54FKgVTtzb3jqyKCL5iy++8Xt5e0lC8zY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rghE9uBUsZtUQyH8M8H0vLm2bTjNU6rnB2c66sg0wkPjG64NhAjtTM/muO+ytArrJlDvCVwGUUx97sPYN+JwdR0iBGqkJLc0saJyHWID3+ArwfLvzmhrg35DO7lHsPYLiDLsCPv2+WiKq6kpLjSOWBfWv2NYMcyH1rGMm7rsmZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bT2JrcmL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E53B0C4CEEE;
	Mon,  9 Jun 2025 02:34:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749436470;
	bh=hW0O3mrk8J54FKgVTtzb3jqyKCL5iy++8Xt5e0lC8zY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bT2JrcmLRiIi3/Nl6UFnikpMIds79Biee/gdRaQBO5r0cx8yXL6yS8S1X66JGLq0C
	 4rLLxJPPyY7rvqvdDHpDCZk3e1k3c2k4z9/I/3LeTiBdVbxEjLs4eaH3QNIoBTMT7s
	 xEKelUqnRFVRht9osKPb/U9ofYjI4zVbA6wgN7fvbqqAU72oi6x0Piztn3FLqsrAxI
	 pH/gKfQH5AZbXWj4EZiN9yRJPzcfWkXDdN1Qav3B0bpf8tY4aQjPm+Pg6CR/2rLUXF
	 TpnYxKEY0tQUtqyuyjTJIHadU/K+AQ/zTqCcxzn7CNNa90GSEyPbOV7b06tHdYBoTx
	 fizyzUKYCNLcQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Pu Lehui <pulehui@huaweicloud.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.10 10/14] arm64: proton-pack: Expose whether the branchy loop k value
Date: Sun,  8 Jun 2025 22:34:28 -0400
Message-Id: <20250608195140-a259bc9ae03cb0d1@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250607152521.2828291-11-pulehui@huaweicloud.com>
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

The upstream commit SHA1 provided is correct: a1152be30a043d2d4dcb1683415f328bf3c51978

WARNING: Author mismatch between patch and upstream commit:
Backport author: Pu Lehui<pulehui@huaweicloud.com>
Commit author: James Morse<james.morse@arm.com>

Status in newer kernel trees:
6.15.y | Present (exact SHA1)
6.14.y | Present (different SHA1: 00565e8c0860)
6.12.y | Present (different SHA1: f2aebb8ec64d)
6.6.y | Present (different SHA1: 73591041a551)
6.1.y | Present (different SHA1: 497771234133)
5.15.y | Not found

Note: The patch differs from the upstream commit:
---
1:  a1152be30a043 ! 1:  dbc31c5fa6e85 arm64: proton-pack: Expose whether the branchy loop k value
    @@ Metadata
      ## Commit message ##
         arm64: proton-pack: Expose whether the branchy loop k value
     
    +    [ Upstream commit a1152be30a043d2d4dcb1683415f328bf3c51978 ]
    +
         Add a helper to expose the k value of the branchy loop. This is needed
         by the BPF JIT to generate the mitigation sequence in BPF programs.
     
         Signed-off-by: James Morse <james.morse@arm.com>
         Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
    +    Signed-off-by: Pu Lehui <pulehui@huawei.com>
     
      ## arch/arm64/include/asm/spectre.h ##
    -@@ arch/arm64/include/asm/spectre.h: enum mitigation_state arm64_get_meltdown_state(void);
    +@@ arch/arm64/include/asm/spectre.h: void spectre_v4_enable_task_mitigation(struct task_struct *tsk);
      
      enum mitigation_state arm64_get_spectre_bhb_state(void);
      bool is_spectre_bhb_affected(const struct arm64_cpu_capabilities *entry, int scope);
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.15.y       |  Success    |  Success   |

