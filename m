Return-Path: <stable+bounces-124725-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86202A65A7F
	for <lists+stable@lfdr.de>; Mon, 17 Mar 2025 18:21:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F4E67B0BE9
	for <lists+stable@lfdr.de>; Mon, 17 Mar 2025 17:18:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88B401B6D01;
	Mon, 17 Mar 2025 17:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qbidg0QV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48B0B1A2C0B
	for <stable@vger.kernel.org>; Mon, 17 Mar 2025 17:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742231817; cv=none; b=LQ7BfFTNdJSIHYgC6hBxJxa9SSVBTH8ok/FrWI+JsG8tHI4i9EGui41JagTfG8UNRn7zBbTsAedGksaNrd94c60s6QdpG0AFJ2UR0NSb9eyISlNgdsB8020pxOR+pfzjQrGYUae5BikuFItQMgXTXVTFPgSD1gdQSwJRv5RIBCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742231817; c=relaxed/simple;
	bh=Hr1NyeFJtZdVUVv92z5fEzjFSAyS/z8m2dRP0uDzKKI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rEd4Pf+nORVSFqVNFeHu29D+xqBkh9yF+DJdYs+h54zdugKN1uL8SKxaGGmSRZQIssPtev1yREDLMWgrsxvcDUDfUospi/0In5KK8C1u6pJ5aI6a1s+6SqymoR+GHbsAXk0ohFGZGfYYtUi1jBPprQwG56G4qpvYSaIQDvrgD0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qbidg0QV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 609E7C4CEE3;
	Mon, 17 Mar 2025 17:16:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742231816;
	bh=Hr1NyeFJtZdVUVv92z5fEzjFSAyS/z8m2dRP0uDzKKI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qbidg0QVUmTEl+bJAXHBlIAuTJFgqakt7Cn+BnXsWFhvHM7mDyAIeMxmtK+n7J37a
	 ehF+PNCwmrPc4tOx6AipHzrzidyQ6Sjg5aNJHlcQrg+RES8FNAkINQtFBKPKr7Xr66
	 RASiLBf+dRG5pGGue1Tjes4d023yVr0zn2n6vPSBy5mJcmAZ1uxORWe05Ep+LS8zDq
	 HPIV8qprYog4OQgVMOgQqAV+0wDpC8dT6obfZHAlROghCRhnbwT2pb/Cn80XdrWjGE
	 WYblavGfOfUGIU+XQvG6QrrLUYA/o8DCH6d/yJ0M7He+XRXueFzQMociDhdNKNPW6H
	 BaInHyz/e4Kmw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	florian.fainelli@broadcom.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH stable 5.15 1/2] net: openvswitch: fix race on port output
Date: Mon, 17 Mar 2025 13:16:55 -0400
Message-Id: <20250317130804-e5b5adf11ee9bed5@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250317154703.3671421-2-florian.fainelli@broadcom.com>
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

Summary of potential issues:
❌ Build failures detected
⚠️ Found follow-up fixes in mainline

The upstream commit SHA1 provided is correct: 066b86787fa3d97b7aefb5ac0a99a22dad2d15f8

WARNING: Author mismatch between patch and upstream commit:
Backport author: Florian Fainelli<florian.fainelli@broadcom.com>
Commit author: Felix Huettner<felix.huettner@mail.schwarz>

Status in newer kernel trees:
6.13.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (exact SHA1)
6.1.y | Present (different SHA1: 644b3051b06b)

Found fixes commits:
47e55e4b410f openvswitch: fix lockup on tx to unregistering netdev with carrier

Note: The patch differs from the upstream commit:
---
1:  066b86787fa3d ! 1:  4757a4a8c0392 net: openvswitch: fix race on port output
    @@ Metadata
      ## Commit message ##
         net: openvswitch: fix race on port output
     
    +    [ Upstream commit 066b86787fa3d97b7aefb5ac0a99a22dad2d15f8 ]
    +
         assume the following setup on a single machine:
         1. An openvswitch instance with one bridge and default flows
         2. two network namespaces "server" and "client"
    @@ Commit message
         Reviewed-by: Simon Horman <simon.horman@corigine.com>
         Link: https://lore.kernel.org/r/ZC0pBXBAgh7c76CA@kernel-bug-kernel-bug
         Signed-off-by: Jakub Kicinski <kuba@kernel.org>
    +    Signed-off-by: Carlos Soto <carlos.soto@broadcom.com>
    +    Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
     
      ## net/core/dev.c ##
     @@ net/core/dev.c: static u16 skb_tx_hash(const struct net_device *dev,
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.15.y       |  Success    |  Failed    |

Build Errors:
Build error for stable/linux-5.15.y:
    net/core/dev.c: In function 'skb_tx_hash':
    net/core/dev.c:3234:17: error: implicit declaration of function 'DEBUG_NET_WARN_ON_ONCE' [-Werror=implicit-function-declaration]
     3234 |                 DEBUG_NET_WARN_ON_ONCE(qcount == 0);
          |                 ^~~~~~~~~~~~~~~~~~~~~~
    cc1: some warnings being treated as errors
    make[2]: *** [scripts/Makefile.build:289: net/core/dev.o] Error 1
    make[2]: Target '__build' not remade because of errors.
    make[1]: *** [scripts/Makefile.build:552: net/core] Error 2
    make[1]: Target '__build' not remade because of errors.
    make: *** [Makefile:1911: net] Error 2
    make: Target '__all' not remade because of errors.

