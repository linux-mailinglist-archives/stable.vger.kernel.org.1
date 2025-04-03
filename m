Return-Path: <stable+bounces-127690-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E387A7A71C
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 17:41:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBABF3AB14A
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 15:39:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5CBC24CEE5;
	Thu,  3 Apr 2025 15:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dplKV3cU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92BFB273FD
	for <stable@vger.kernel.org>; Thu,  3 Apr 2025 15:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743694749; cv=none; b=IJUblc9qpISoEvqq8Nt2w50bv9IPJvA3KjyPQrDImUQ1dR9e0BWqnpELdt/JOHkT4Tu5RTRNBQ8k2tJ37XlWsdf+DyFj+Dxc3/FwpIVWp5vsWHSRVsNB14pmDtDc952czwyKfR/OGMuPRA97MT8FuyDHGtQeAkBI2wmbTrPOb6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743694749; c=relaxed/simple;
	bh=hLqjjd7OAh/lwnd4FrhYLn343emy3dyEiYn6t3RPDbg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bivmdYR/nl7c0+92QmEQMniA6UAXh1AjJq/lJJIHDc8zRCcAoNJxbNfnq7ozj/UrnftaHcwfp30DNOWfSRACD0Kz8uNu6GEXYU+h+3ApnKpRqeDzp0Qu/M59593rEqtydKJKyIyuj6hegKfYM+LB2PttdT0VrEvuLU0dcRBzHA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dplKV3cU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91B70C4CEE5;
	Thu,  3 Apr 2025 15:39:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743694749;
	bh=hLqjjd7OAh/lwnd4FrhYLn343emy3dyEiYn6t3RPDbg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dplKV3cUVOhHU/3JbjjnREvp8m66gnQjeAFlG1hsndX0MOgLxxQ0oL2OwBGBl0GR1
	 y+BmEPJNxEIuhm20i/4BiBKT7oCrnHOuxhhC2wmll2oqR5PEeCu45KN/bwqXTTmlI4
	 uQQz4Bpio+/Vv5qpPvyhtRnyS7y3o1PtCFeMUZd9v56CDQubfbEHfbOzZ5XUlTJDHT
	 jXrhpCCC4Yy1txjhsxEjVDCdSfKA+Lsxqx4q5+x1CUG8d2vqINKiGr9wBdBWe+WBiQ
	 /YZZGKRGAkW376Zr8yEmn37ILRuWpCp8al/TMsGpj/oOxNyriutdQMczlT9q9+bXGX
	 NaoRocpFpsLNQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Cliff Liu <donghua.liu@windriver.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15.y] bpf: Check rcu_read_lock_trace_held() before calling bpf map helpers
Date: Thu,  3 Apr 2025 11:39:04 -0400
Message-Id: <20250403075938-25c20e5f18aed6a5@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250403065209.1181276-1-donghua.liu@windriver.com>
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

The upstream commit SHA1 provided is correct: 169410eba271afc9f0fb476d996795aa26770c6d

WARNING: Author mismatch between patch and upstream commit:
Backport author: Cliff Liu<donghua.liu@windriver.com>
Commit author: Hou Tao<houtao1@huawei.com>

Status in newer kernel trees:
6.13.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (different SHA1: 483cb92334cd)
6.1.y | Present (different SHA1: d6d6fe4bb105)

Note: The patch differs from the upstream commit:
---
1:  169410eba271a ! 1:  27f6e15ee1170 bpf: Check rcu_read_lock_trace_held() before calling bpf map helpers
    @@ Metadata
      ## Commit message ##
         bpf: Check rcu_read_lock_trace_held() before calling bpf map helpers
     
    +    [ Upstream commit 169410eba271afc9f0fb476d996795aa26770c6d ]
    +
         These three bpf_map_{lookup,update,delete}_elem() helpers are also
         available for sleepable bpf program, so add the corresponding lock
         assertion for sleepable bpf program, otherwise the following warning
    @@ Commit message
         Signed-off-by: Hou Tao <houtao1@huawei.com>
         Link: https://lore.kernel.org/r/20231204140425.1480317-2-houtao@huaweicloud.com
         Signed-off-by: Alexei Starovoitov <ast@kernel.org>
    +    Signed-off-by: Cliff Liu <donghua.liu@windriver.com>
    +    Signed-off-by: He Zhe <Zhe.He@windriver.com>
     
      ## kernel/bpf/helpers.c ##
    +@@
    +  */
    + #include <linux/bpf.h>
    + #include <linux/rcupdate.h>
    ++#include <linux/rcupdate_trace.h>
    + #include <linux/random.h>
    + #include <linux/smp.h>
    + #include <linux/topology.h>
     @@
       *
       * Different map implementations will rely on rcu in map methods
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.15.y       |  Success    |  Success   |

