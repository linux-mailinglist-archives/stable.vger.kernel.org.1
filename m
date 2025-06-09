Return-Path: <stable+bounces-151972-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D627AD16E5
	for <lists+stable@lfdr.de>; Mon,  9 Jun 2025 04:35:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D347A188ABC9
	for <lists+stable@lfdr.de>; Mon,  9 Jun 2025 02:35:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF9EC2459E1;
	Mon,  9 Jun 2025 02:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bxwburIn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0EE22459DE
	for <stable@vger.kernel.org>; Mon,  9 Jun 2025 02:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749436474; cv=none; b=RhC8lBiaSZv+rUHf53mKx57jIxIJGAdo69sVn4h5pSk0Un/Vt1FicLta+WI55pgPO0lM/nPSt+BIXpx91QCKugJw/5IKhF8oHeedqQ/5qGnBKQIE8i6ZhhP9IbOTt6bSNAWhTQtlnDZXNsg8WKrfsXUvxuW4ui0UnejbHKM9ygA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749436474; c=relaxed/simple;
	bh=8ZvFdGyMIgQ2XL0bgZY+hGdtpaDBhQasE4DwgJRPTQ4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TIq+R3NAsmEdbUFMZbMssr3rv2GUrsY/VbdoRLt0nR9ltDteVN//i1IFeJAekHi0Vu4zkeV0o0o3xyI+jYY4mW6Zry9+RTJq5ogRMrM13wieQAp3mRqlyaqgmZE88G6806t9zc9592FpeD+bmw1M1Cm6l+WrodxdrdwpKtyDlkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bxwburIn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FC08C4CEEE;
	Mon,  9 Jun 2025 02:34:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749436474;
	bh=8ZvFdGyMIgQ2XL0bgZY+hGdtpaDBhQasE4DwgJRPTQ4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bxwburInUhfxFAH3k0YF1Aj3xHfUnNndvmISZ32Tj6wQ5LcrzJynr0a2BG6GSgu86
	 oKd0LkQWNG/6cYtyrSMoyuP7KM6a6X3apAUek6U6BlJOOFAalr3gLI7fZO7/KcG9nE
	 NgGGz5Fsf1sB8YEAoaP/jI3tlvGwJZE4J0EcJMezud9DKEvG47+vXOCz8CQXYYi2Xl
	 5PwQn1f2o88rS4bc6GZs0gYsbeRwNicLtRiEoWQTXa5JxrTVYGUXBRZfIg11X6eK46
	 pvC5kZFesS+sPGXWjJCaPZ0vrBiWqc2ILcf0bcWKBajSSLjtbym4VKNb4egaq4od5W
	 5zJkDViSI89vw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Pu Lehui <pulehui@huaweicloud.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15 2/9] arm64: insn: add encoders for atomic operations
Date: Sun,  8 Jun 2025 22:34:32 -0400
Message-Id: <20250608143739-7821ad7e92c7f961@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250607153535.3613861-3-pulehui@huaweicloud.com>
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

The upstream commit SHA1 provided is correct: fa1114d9eba5087ba5e81aab4c56f546995e6cd3

WARNING: Author mismatch between patch and upstream commit:
Backport author: Pu Lehui<pulehui@huaweicloud.com>
Commit author: Hou Tao<houtao1@huawei.com>

Status in newer kernel trees:
6.15.y | Present (exact SHA1)
6.14.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (exact SHA1)
6.1.y | Present (exact SHA1)

Note: The patch differs from the upstream commit:
---
1:  fa1114d9eba50 ! 1:  4087c33bc97c2 arm64: insn: add encoders for atomic operations
    @@ Metadata
      ## Commit message ##
         arm64: insn: add encoders for atomic operations
     
    +    [ Upstream commit fa1114d9eba5087ba5e81aab4c56f546995e6cd3 ]
    +
         It is a preparation patch for eBPF atomic supports under arm64. eBPF
         needs support atomic[64]_fetch_add, atomic[64]_[fetch_]{and,or,xor} and
         atomic[64]_{xchg|cmpxchg}. The ordering semantics of eBPF atomics are
    @@ Commit message
         Signed-off-by: Hou Tao <houtao1@huawei.com>
         Link: https://lore.kernel.org/r/20220217072232.1186625-3-houtao1@huawei.com
         Signed-off-by: Will Deacon <will@kernel.org>
    +    Signed-off-by: Pu Lehui <pulehui@huawei.com>
     
      ## arch/arm64/include/asm/insn.h ##
     @@ arch/arm64/include/asm/insn.h: enum aarch64_insn_ldst_type {
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

