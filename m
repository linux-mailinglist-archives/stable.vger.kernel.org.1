Return-Path: <stable+bounces-165696-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 56169B1790C
	for <lists+stable@lfdr.de>; Fri,  1 Aug 2025 00:19:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1769D3B3283
	for <lists+stable@lfdr.de>; Thu, 31 Jul 2025 22:19:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 600FE276059;
	Thu, 31 Jul 2025 22:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eP/GHUwI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21D99265284
	for <stable@vger.kernel.org>; Thu, 31 Jul 2025 22:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754000359; cv=none; b=lN18U9yB3+pM0zNAnycZcI2bCtloFE0jizvYGmDetvy3ngu+QCbyl5PohtgQcyJQbtYnMDKrcqzuRkbSwUFwJUZaFaIkMkMD+0XAxDSxqKJq0dfy9UilfI/KtIPmHjn9gA9Oqm6uLe6g1d57nMoOfAaGpKWvLQIMvtIsKSQ4VYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754000359; c=relaxed/simple;
	bh=To8a089G5YWXytrMZFHJtOzJHlouTNp0O6bH3VJcD20=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iKejQ54rzm4rR/2W6SEMX/H6TtZwVz70BdMZVrqYj2aWpBi4nYKRZY79AKXwUO2iyNfSVLn5PBSr3K3qzOFBPwyZ7+wWKQYAl9yYlt9pTdxk7khMlI3JlCQTCjEgfm1z8blq2s2RCt4O33PikoTCRBv+wSCFPKMLLy0yPA7ZPSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eP/GHUwI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27F63C4CEEF;
	Thu, 31 Jul 2025 22:19:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754000357;
	bh=To8a089G5YWXytrMZFHJtOzJHlouTNp0O6bH3VJcD20=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eP/GHUwIBrWqISu9qvCROwDTTj0mI5T6YYb9AQL8bcZAnQjRdjDQrwLPujuBAUOTa
	 y/+XSEfIIE8tQhmGLv3DYhUMIyHOy4YZ0BRR73G5WL19X6hnOY+5fFCwIu/9Yr3Y+M
	 CaTCG3w1S6RvnIc20Z3nT8TXALxy/DsWauUkhEv8Hd/jaWApiPzHA4D/zcrmhdlmHS
	 LqwMM2/481vio4qIu0eu/8d7Vp42Qhp+1te3ciSM/gIHtAt3Py/UzcbVUPawdDVKU2
	 SyGJWjnXV9R0r+CRvm0/YW1cqVqhZuK4I/TVDnJOn+7A6JR6tc+ulJg/pj9e/IbeyS
	 EdJPFLqNgRQ6g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15.y 1/6] selftests: mptcp: add missing join check
Date: Thu, 31 Jul 2025 18:19:15 -0400
Message-Id: <1753975897-9b286fab@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250731112353.2638719-9-matttbe@kernel.org>
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

The upstream commit SHA1 provided is correct: 857898eb4b28daf3faca3ae334c78b2bb141475e

WARNING: Author mismatch between patch and upstream commit:
Backport author: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Commit author: Matthieu Baerts <matthieu.baerts@tessares.net>

Status in newer kernel trees:
6.15.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (exact SHA1)
6.1.y | Present (exact SHA1)

Note: The patch differs from the upstream commit:
---
1:  857898eb4b28 ! 1:  37fd6152bfd5 selftests: mptcp: add missing join check
    @@ Metadata
      ## Commit message ##
         selftests: mptcp: add missing join check
     
    +    commit 857898eb4b28daf3faca3ae334c78b2bb141475e upstream.
    +
         This function also writes the name of the test with its ID, making clear
         a new test has been executed.
     
    @@ Commit message
         Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
         Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
         Signed-off-by: Jakub Kicinski <kuba@kernel.org>
    +    [ Conflict in mptcp_join.sh, because commit 86e39e04482b ("mptcp: keep
    +      track of local endpoint still available for each msk") is not in this
    +      version and changed the context. The same line can still be applied at
    +      the same place. ]
    +    Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
     
      ## tools/testing/selftests/net/mptcp/mptcp_join.sh ##
     @@ tools/testing/selftests/net/mptcp/mptcp_join.sh: signal_address_tests()
    @@ tools/testing/selftests/net/mptcp/mptcp_join.sh: signal_address_tests()
      	ip netns exec $ns2 ./pm_nl_ctl add 10.0.4.2 flags signal
      	run_tests $ns1 $ns2 10.0.1.1
     +	chk_join_nr "signal addresses race test" 3 3 3
    + 	chk_add_nr 4 4
    + }
      
    - 	# the server will not signal the address terminating
    - 	# the MPC subflow

---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| 5.15                      | Success     | Success    |

