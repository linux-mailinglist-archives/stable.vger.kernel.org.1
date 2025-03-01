Return-Path: <stable+bounces-119990-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FE8DA4A87D
	for <lists+stable@lfdr.de>; Sat,  1 Mar 2025 05:21:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18D523BA1A2
	for <lists+stable@lfdr.de>; Sat,  1 Mar 2025 04:20:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7770416F858;
	Sat,  1 Mar 2025 04:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HuL00iY5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38A002C9A
	for <stable@vger.kernel.org>; Sat,  1 Mar 2025 04:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740802866; cv=none; b=sjEwmsu+hWwuU0JSwckhInVF+rMg6+W5wzaT1FspotmwbOYscr9vob4vj5fQo+13MUJPOUtaEX1GanNPFIubpwg/xVgCmZM9rAQXXSepwhDYKRpYZN1y2zaANb5GZlnItKtxH9iNAN8eB9jA8NT49nj3K5ZgmcP/56X0d377EXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740802866; c=relaxed/simple;
	bh=BO0E0jnqVyvSaO/T/w2fxpwc42Jbx+vPBRLPWWJjZt8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kvOQFrRx+ifJKLRdq1AjwTlNuafqYT4b3DFyMANRoj4QDBLb5Gc41Npu5i+348OBVLUQmRtXcaNOYFdmhVjIqy92v/Ggh+ppTekXQH1/qz3PVn7eoLnfrN3UpvfXUtWxl8MEFq07cn0G78PHga4LQBcBa7mDRiSMKbXg1tRH12Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HuL00iY5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C66CBC4CEF3;
	Sat,  1 Mar 2025 04:21:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740802866;
	bh=BO0E0jnqVyvSaO/T/w2fxpwc42Jbx+vPBRLPWWJjZt8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HuL00iY5uah6vYGkGYhj6/d0aTx20D6hR5/WS+6SBFuCg5bhlRNRWg/jvuLwk1nrA
	 z7En+SonkMCzhBTC/oMCP0n+UhldZDjenogAMM0DCkmTka/7zkmfDgNX26c2BFYImC
	 pe/m2lL1MXec2or06jL7dpE9k7ElS3hbqJQqRsqbmLf8+dyelFh7AB7nPzTxdW5J4e
	 qEbi7EoBS9yK9iyawWgVWwmiAS5fzIFuUb2SECyL3LTY+IZ5h4lk9x0TxvnVx0RcMR
	 5xHKmpi4g+DWHd5sD9plZ4kCD8ErcbxZstkQEimvnxGUqOXooAbWtMBiVM/Z8ePs3b
	 vwv2czJhqcxBQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Tomas Glozar <tglozar@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.6 3/4] rtla/timerlat_hist: Set OSNOISE_WORKLOAD for kernel threads
Date: Fri, 28 Feb 2025 23:20:42 -0500
Message-Id: <20250228191628-f24381210ba2f0fa@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250228135708.604410-4-tglozar@redhat.com>
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

The upstream commit SHA1 provided is correct: d8d866171a414ed88bd0d720864095fd75461134

Note: The patch differs from the upstream commit:
---
1:  d8d866171a414 ! 1:  2b6c95fecd276 rtla/timerlat_hist: Set OSNOISE_WORKLOAD for kernel threads
    @@ Metadata
      ## Commit message ##
         rtla/timerlat_hist: Set OSNOISE_WORKLOAD for kernel threads
     
    +    commit d8d866171a414ed88bd0d720864095fd75461134 upstream.
    +
         When using rtla timerlat with userspace threads (-u or -U), rtla
         disables the OSNOISE_WORKLOAD option in
         /sys/kernel/tracing/osnoise/options. This option is not re-enabled in a
    @@ Commit message
         Fixes: ed774f7481fa ("rtla/timerlat_hist: Add timerlat user-space support")
         Signed-off-by: Tomas Glozar <tglozar@redhat.com>
         Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
    +    [ params->kernel_workload does not exist in 6.6, use
    +    !params->user_hist ]
    +    Signed-off-by: Tomas Glozar <tglozar@redhat.com>
     
      ## tools/tracing/rtla/src/timerlat_hist.c ##
     @@ tools/tracing/rtla/src/timerlat_hist.c: timerlat_hist_apply_config(struct osnoise_tool *tool, struct timerlat_hist_param
    - 		}
    + 		auto_house_keeping(&params->monitored_cpus);
      	}
      
     -	if (params->user_hist) {
    @@ tools/tracing/rtla/src/timerlat_hist.c: timerlat_hist_apply_config(struct osnois
     +	* On kernels without support, user threads will have already failed
     +	* on missing timerlat_fd, and kernel threads do not need it.
     +	*/
    -+	retval = osnoise_set_workload(tool->context, params->kernel_workload);
    ++	retval = osnoise_set_workload(tool->context, !params->user_hist);
     +	if (retval < -1) {
     +		err_msg("Failed to set OSNOISE_WORKLOAD option\n");
     +		goto out_err;
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.6.y        |  Success    |  Success   |

