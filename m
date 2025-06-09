Return-Path: <stable+bounces-151982-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8853EAD16E6
	for <lists+stable@lfdr.de>; Mon,  9 Jun 2025 04:35:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 369023AAC96
	for <lists+stable@lfdr.de>; Mon,  9 Jun 2025 02:34:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C64E12459C5;
	Mon,  9 Jun 2025 02:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Av8fRegk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8689E157A67
	for <stable@vger.kernel.org>; Mon,  9 Jun 2025 02:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749436495; cv=none; b=AT1WacEWnRCMviUyZW3P+oST8V/RpF120zs02IDXZRul7OE4RHMHbDZF8FCbfYCaG1H1M6mZ028j17caEAC+CVNof00QxELDE7z4TlePqiovs6WV8dANz5RCqeGA834zYJlNY0QCtB19bpomEV6OhDUbNdZjii8E56xLPYCqzIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749436495; c=relaxed/simple;
	bh=aF3ah4mBFihW++rehtO9A6rU43k5LM5b43FCPQjsfjQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z7+Pm9cOHAo1TMLLNk9n6is7ZqylHqtqqZRheR0mXqk0TNWBBDepLBLBXX0rWQRMbJ1Lla0PQSbzAPpZLEX52YDVgGn/CSL6kuy/syxqj+d5ZnZJ4ZH6sI98JcArD42SgRTsoCwJb4Sj22AS+Q6vDarS3YlceUOQENP5ooFoWCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Av8fRegk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C868C4CEEE;
	Mon,  9 Jun 2025 02:34:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749436495;
	bh=aF3ah4mBFihW++rehtO9A6rU43k5LM5b43FCPQjsfjQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Av8fRegk0p0uQJL+aTpNnFLxYhMTzH4NMiJO+nCBBVH+3qpjnLBIjA9pj/AIJhlyi
	 CjrWvIcwluOoGRLh0jYR3FVZ/uQxKfzg42+LnwO4HXlxw1TGdO0FnP5by3iYsvbk+L
	 cGaiX1nE+dqvIdWl6OmERLcLA7ucgw0PNyEa8gjUqgQO0gafYhlggg4adyAgwm67uW
	 U7f790snuersRFF9rFjuNbrZnDvwjAB0WQxJpeCkAC+86RUbdtUQ6GRFartHUTPJNF
	 yRnXE9cHxd2a4192E0STJYwgXsHyiuLqi4TT5o+AWXVogBSYOLt9Yl36wwyNix7ttb
	 gZWvKELswf/Ew==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Pu Lehui <pulehui@huaweicloud.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.10 01/14] arm64: insn: Add barrier encodings
Date: Sun,  8 Jun 2025 22:34:53 -0400
Message-Id: <20250608174318-cc0f1a2fe73c685f@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250607152521.2828291-2-pulehui@huaweicloud.com>
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

The upstream commit SHA1 provided is correct: d4b217330d7e0320084ff04c8491964f1f68980a

WARNING: Author mismatch between patch and upstream commit:
Backport author: Pu Lehui<pulehui@huaweicloud.com>
Commit author: Julien Thierry<jthierry@redhat.com>

Status in newer kernel trees:
6.15.y | Present (exact SHA1)
6.14.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (exact SHA1)
6.1.y | Present (exact SHA1)
5.15.y | Present (exact SHA1)

Note: The patch differs from the upstream commit:
---
1:  d4b217330d7e0 ! 1:  ba32b33ce84dd arm64: insn: Add barrier encodings
    @@ Metadata
      ## Commit message ##
         arm64: insn: Add barrier encodings
     
    +    [ Upstream commit d4b217330d7e0320084ff04c8491964f1f68980a ]
    +
         Create necessary functions to encode/decode aarch64 barrier
         instructions.
     
    @@ Commit message
         Link: https://lore.kernel.org/r/20210303170536.1838032-7-jthierry@redhat.com
         [will: Don't reject DSB #4]
         Signed-off-by: Will Deacon <will@kernel.org>
    +    Signed-off-by: Pu Lehui <pulehui@huawei.com>
     
      ## arch/arm64/include/asm/insn.h ##
     @@ arch/arm64/include/asm/insn.h: __AARCH64_INSN_FUNCS(eret_auth,	0xFFFFFBFF, 0xD69F0BFF)
    @@ arch/arm64/include/asm/insn.h: static inline bool aarch64_insn_is_adr_adrp(u32 i
     +	       aarch64_insn_is_pssbb(insn);
     +}
     +
    + int aarch64_insn_read(void *addr, u32 *insnp);
    + int aarch64_insn_write(void *addr, u32 insn);
      enum aarch64_insn_encoding_class aarch64_get_insn_class(u32 insn);
    - bool aarch64_insn_uses_literal(u32 insn);
    - bool aarch64_insn_is_branch(u32 insn);
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.10.y       |  Success    |  Success   |

