Return-Path: <stable+bounces-119998-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E346A4A886
	for <lists+stable@lfdr.de>; Sat,  1 Mar 2025 05:21:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9527D175AEA
	for <lists+stable@lfdr.de>; Sat,  1 Mar 2025 04:21:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28453192B82;
	Sat,  1 Mar 2025 04:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eO56HrqP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD89B2C9A
	for <stable@vger.kernel.org>; Sat,  1 Mar 2025 04:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740802878; cv=none; b=b08b27W2O1l30fiS+sruoQ9SzluY6MAm/VtiyAxuwxARTj2cyIJbBac5IVY/P/3o/1vl47REIQChdYJhY6F67nlr8EHwl+CHDAqjFIv8toEaTRS5lJB4Ym8M71aoHKZPPrf5nOeDTRwKaTimxcEMvjeIxT+SeG0bYLrfoIEvByg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740802878; c=relaxed/simple;
	bh=sq4RJaqXJmlZht25ajhccchd+O4JVCeqtySdaGl9qE4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hScCq+3//Um9VP9Wl8Xgs8LTdH33xJr4L4CKNxs98bxvtnnWmt1rnEv4aw3XYixuCedDACaZhKXBX9wKY6Z71DjqGRS7t2V4jndjDLwpsNHFLYnuyfCsEdUAMStW3opnXq2DDzEQMsKHESa03UnWFPEFerFHFsrNB9uuexaMBig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eO56HrqP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74080C4CEF3;
	Sat,  1 Mar 2025 04:21:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740802878;
	bh=sq4RJaqXJmlZht25ajhccchd+O4JVCeqtySdaGl9qE4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eO56HrqPANLYxjKOhfobpJCsBiZYAYznPvzYIUMCwL+iQ74CY5fkjeCo2yTBVLt9H
	 4jBy5KQ/p1eS2yVnNCGigpND04ufhNCyjg+8qpZArNdz9SSwzqBunY08b9lrBB8+LV
	 VDuBx+h+qshmuL1WBnxSNFrFTDLGeGRKX/Bd5ZJbOUjKhF4FyHIk82UceyBcu1gwOG
	 j+0DB8ZOkdxMgVcyu7FQDgc94X6qdMNfXplK1/U09zPd/o2LL3A2h4H3ocMp1peUbM
	 DXE+rxBrqyWme0FqAqLxK3yCSghsvWrjt+qZN5xcclhqrCWzMj+IULeDVdBMYTRdSG
	 bmeb/L5WebwHA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Tomas Glozar <tglozar@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.6 4/4] rtla/timerlat_top: Set OSNOISE_WORKLOAD for kernel threads
Date: Fri, 28 Feb 2025 23:20:55 -0500
Message-Id: <20250228192209-e957659598313c2c@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250228135708.604410-5-tglozar@redhat.com>
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

The upstream commit SHA1 provided is correct: 217f0b1e990e30a1f06f6d531fdb4530f4788d48

Note: The patch differs from the upstream commit:
---
1:  217f0b1e990e3 ! 1:  c364e187bdf5b rtla/timerlat_top: Set OSNOISE_WORKLOAD for kernel threads
    @@ Metadata
      ## Commit message ##
         rtla/timerlat_top: Set OSNOISE_WORKLOAD for kernel threads
     
    +    commit 217f0b1e990e30a1f06f6d531fdb4530f4788d48 upstream.
    +
         When using rtla timerlat with userspace threads (-u or -U), rtla
         disables the OSNOISE_WORKLOAD option in
         /sys/kernel/tracing/osnoise/options. This option is not re-enabled in a
    @@ Commit message
         Fixes: cdca4f4e5e8e ("rtla/timerlat_top: Add timerlat user-space support")
         Signed-off-by: Tomas Glozar <tglozar@redhat.com>
         Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
    +    [ params->kernel_workload does not exist in 6.6, use
    +    !params->user_top ]
    +    Signed-off-by: Tomas Glozar <tglozar@redhat.com>
     
      ## tools/tracing/rtla/src/timerlat_top.c ##
     @@ tools/tracing/rtla/src/timerlat_top.c: timerlat_top_apply_config(struct osnoise_tool *top, struct timerlat_top_params *
    - 		}
    + 		auto_house_keeping(&params->monitored_cpus);
      	}
      
     -	if (params->user_top) {
    @@ tools/tracing/rtla/src/timerlat_top.c: timerlat_top_apply_config(struct osnoise_
     +	* On kernels without support, user threads will have already failed
     +	* on missing timerlat_fd, and kernel threads do not need it.
     +	*/
    -+	retval = osnoise_set_workload(top->context, params->kernel_workload);
    ++	retval = osnoise_set_workload(top->context, !params->user_top);
     +	if (retval < -1) {
     +		err_msg("Failed to set OSNOISE_WORKLOAD option\n");
     +		goto out_err;
      	}
      
    - 	if (isatty(STDOUT_FILENO) && !params->quiet)
    + 	return 0;
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.6.y        |  Success    |  Success   |

