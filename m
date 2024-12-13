Return-Path: <stable+bounces-104112-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 258439F1098
	for <lists+stable@lfdr.de>; Fri, 13 Dec 2024 16:15:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A4ED1882E17
	for <lists+stable@lfdr.de>; Fri, 13 Dec 2024 15:13:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8C161E1A28;
	Fri, 13 Dec 2024 15:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I7Mqp71J"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 799951E04BF
	for <stable@vger.kernel.org>; Fri, 13 Dec 2024 15:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734102788; cv=none; b=SmWJPcaQNcX216jNAwuZnttQG3oyoIcq2Lnxu7FiDadESi3gyfxoyRqcvfNYjfQHFfV4U5gLXEjw+HUHuekVpkTnsqn/betp9azYhDUQRRyolTcQW/Q/AMgmW+46sc7ms7oC4KTzVOH2D08MC8DCVSN/8+RleVTGB9SYQo/dO34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734102788; c=relaxed/simple;
	bh=RQ+Ow/xsP2KghximpIu2/gGL/mcDpZbvt/ikRAa1YY8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JcR1B7qso3KsoPA+s1VNUZOCdEIW8O7B++39Q0vp5AUuKsFNuC9QIgdYE7AOxFuTxtsYU4inkZEvkVPnymfkuqJJpGVYRaLnOeEH2gD/M31qfQgovVF7/zd9wShzCcz1QJfuyk2WKp8L666cE5infkEzvX34PluL2tG+W1SkoSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I7Mqp71J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63B6AC4CED0;
	Fri, 13 Dec 2024 15:13:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734102787;
	bh=RQ+Ow/xsP2KghximpIu2/gGL/mcDpZbvt/ikRAa1YY8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=I7Mqp71JZ/cbva+mFRn/cB1soPKp5jcf+BEHKpWzAMnYjNHvYXM0eArIXNuHkw+7n
	 kv/QRCQgQg4rdW2bIFMkoh4J6EOO/bvOKtU60bFNyM5gVEC58yaZzuX1fCl7pOdyLM
	 WGYNT3ZUXxp8BeDXOZWVkc9GGPCQI5CopfGsTiMOnnm4ZLqrjsNeQ2oVWcoJ4/N/08
	 y8iQX35RbvPmRiJNUfmWSUPLWUFV85tWPVtTn6yYgkU88Xtua4/NKynFxlfzdTGyRg
	 6Ak+NJ+UMJtIHGhUlbqdpNVyU63AURaE3Lub53di7glyXQm387Mneh3XhiRxg1wPaN
	 WSgUXkSEMxA7w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: tglozar@redhat.com,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.6] rtla/timerlat: Make timerlat_hist_cpu->*_count unsigned long long
Date: Fri, 13 Dec 2024 10:13:05 -0500
Message-ID: <20241213100813-2eb5c1b9f2ddd170@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241213111042.2550939-1-tglozar@redhat.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[ Sasha's backport helper bot ]

Hi,

The upstream commit SHA1 provided is correct: 76b3102148135945b013797fac9b206273f0f777

WARNING: Author mismatch between patch and upstream commit:
Backport author: tglozar@redhat.com
Commit author: Tomas Glozar <tglozar@redhat.com>


Status in newer kernel trees:
6.12.y | Not found
6.6.y | Not found

Note: The patch differs from the upstream commit:
---
1:  76b3102148135 ! 1:  110ebadf9fee5 rtla/timerlat: Make timerlat_hist_cpu->*_count unsigned long long
    @@ Metadata
      ## Commit message ##
         rtla/timerlat: Make timerlat_hist_cpu->*_count unsigned long long
     
    +    commit 76b3102148135945b013797fac9b206273f0f777 upstream.
    +
         Do the same fix as in previous commit also for timerlat-hist.
     
         Link: https://lore.kernel.org/20241011121015.2868751-2-tglozar@redhat.com
         Reported-by: Attila Fazekas <afazekas@redhat.com>
         Signed-off-by: Tomas Glozar <tglozar@redhat.com>
         Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
    +    [ Drop hunk fixing printf in timerlat_print_stats_all since that is not
    +    in 6.6 ]
    +    Signed-off-by: Tomas Glozar <tglozar@redhat.com>
     
      ## tools/tracing/rtla/src/timerlat_hist.c ##
     @@ tools/tracing/rtla/src/timerlat_hist.c: struct timerlat_hist_cpu {
    @@ tools/tracing/rtla/src/timerlat_hist.c: timerlat_print_summary(struct timerlat_h
      					 data->hist[cpu].user_count);
      	}
      	trace_seq_printf(trace->seq, "\n");
    -@@ tools/tracing/rtla/src/timerlat_hist.c: timerlat_print_stats_all(struct timerlat_hist_params *params,
    - 		trace_seq_printf(trace->seq, "count:");
    - 
    - 	if (!params->no_irq)
    --		trace_seq_printf(trace->seq, "%9d ",
    -+		trace_seq_printf(trace->seq, "%9llu ",
    - 				 sum.irq_count);
    - 
    - 	if (!params->no_thread)
    --		trace_seq_printf(trace->seq, "%9d ",
    -+		trace_seq_printf(trace->seq, "%9llu ",
    - 				 sum.thread_count);
    - 
    - 	if (params->user_hist)
    --		trace_seq_printf(trace->seq, "%9d ",
    -+		trace_seq_printf(trace->seq, "%9llu ",
    - 				 sum.user_count);
    - 
    - 	trace_seq_printf(trace->seq, "\n");
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.6.y        |  Success    |  Success   |

