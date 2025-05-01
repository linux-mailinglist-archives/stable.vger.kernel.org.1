Return-Path: <stable+bounces-139352-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3B92AA632E
	for <lists+stable@lfdr.de>; Thu,  1 May 2025 20:52:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBDE2980135
	for <lists+stable@lfdr.de>; Thu,  1 May 2025 18:51:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F436223DC2;
	Thu,  1 May 2025 18:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mKa9y81r"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FC8521B180
	for <stable@vger.kernel.org>; Thu,  1 May 2025 18:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746125490; cv=none; b=PWLsazckvNX7Z3Jud8pXDYWa/DY3jFU+5pszju2elJg2xaV7tsX1C9I0z9jK2rNL6BwM7ZxBkIKHsRYSoeaKbDaeOMZdRa57DC7LYckATakZWdtIMLrNyVFcRreYSN0JDFapmZZDT2VDG8Rb/UG7xXyqZkgckeL6y0wfEp4MjOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746125490; c=relaxed/simple;
	bh=Cehl9G59L09/vngW/D3/ur/IvzuTc+DxfcMVU+ETrlI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FLOgezltlq4OoATkNfOoOB1N1QFn7gC5BDhWZLLny7cqbK0Q8IOsNbpQ4UyOUUGj8haO1iz1AHvHmMpEuzODhWJxwsm0NTdCuDbMpaMEmrAn802dEJPByoqiWFu/kCBqc9KAKhHpCqF/WsDwUKcvakxftMFc6RQzlE5PQsNOkOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mKa9y81r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F702C4CEE3;
	Thu,  1 May 2025 18:51:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746125490;
	bh=Cehl9G59L09/vngW/D3/ur/IvzuTc+DxfcMVU+ETrlI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mKa9y81rn/0GhHtPyWJg1TYfpH68/kP6KQnaRRc4AHYZsC28+oHtfwapYvRFwg+RX
	 PL5gBRZuzOtO3XOBQHWJHRS8/gV4AyCOgMu6Nq+pRd6o/xKShsM6dbTthabsuHwfwq
	 E344o50d6qtHHk0WmlZ2S0SNZGT5f9bHEVpXSohy70zXsmLYXOiPhOuCcb4O0km2Vv
	 qi5JVM4A+yqsw4jcKd6Xn6yH4s1oML2Mi0AF7D4EQjz+H0SDt136SB9JmO5lz2LD6L
	 vdrJRZH1rhsqQOI2W4NTP7K8jkE24IykUK75qTQaWrxn6OJDWHpWw4/Xkn0yA00kX5
	 QaI4dyMhlxtUA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Shung-Hsi Yu <shung-hsi.yu@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH stable 6.6 06/10] selftests/bpf: freplace tests for tracking of changes_packet_data
Date: Thu,  1 May 2025 14:51:25 -0400
Message-Id: <20250501090508-c6cf857063b54c6d@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250430081955.49927-7-shung-hsi.yu@suse.com>
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

The upstream commit SHA1 provided is correct: 89ff40890d8f12a7d7e93fb602cc27562f3834f0

WARNING: Author mismatch between patch and upstream commit:
Backport author: Shung-Hsi Yu<shung-hsi.yu@suse.com>
Commit author: Eduard Zingerman<eddyz87@gmail.com>

Status in newer kernel trees:
6.14.y | Present (exact SHA1)
6.12.y | Present (different SHA1: d0e94a5bb99d)

Note: The patch differs from the upstream commit:
---
1:  89ff40890d8f1 ! 1:  96b7aa84bcac2 selftests/bpf: freplace tests for tracking of changes_packet_data
    @@ Metadata
      ## Commit message ##
         selftests/bpf: freplace tests for tracking of changes_packet_data
     
    +    commit 89ff40890d8f12a7d7e93fb602cc27562f3834f0 upstream.
    +
         Try different combinations of global functions replacement:
         - replace function that changes packet data with one that doesn't;
         - replace function that changes packet data with one that does;
    @@ Commit message
         Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
         Link: https://lore.kernel.org/r/20241210041100.1898468-7-eddyz87@gmail.com
         Signed-off-by: Alexei Starovoitov <ast@kernel.org>
    +    Signed-off-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
     
      ## tools/testing/selftests/bpf/prog_tests/changes_pkt_data.c (new) ##
     @@
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.12.y       |  Success    |  Success   |

