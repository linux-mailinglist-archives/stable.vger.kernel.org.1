Return-Path: <stable+bounces-95894-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 407139DF452
	for <lists+stable@lfdr.de>; Sun,  1 Dec 2024 02:10:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7E3B281003
	for <lists+stable@lfdr.de>; Sun,  1 Dec 2024 01:10:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 985852582;
	Sun,  1 Dec 2024 01:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="brSoHv5w"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DDA0EC4
	for <stable@vger.kernel.org>; Sun,  1 Dec 2024 01:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733015435; cv=none; b=H3t8xta4Uy52iRsSx9Sy5YJvELXIjCdgYMd2K0cPUGhcuquMVYqY3D4rQ/a1cpgHUlPl2ATy9jG20WFINe3X632iXlS33rjBv0Aj+9fnMdn0GaN4jzWtZryE4FgIcRyR++Nf2I/1c5/Q0zE71hWQD371yQ/KQLvg22dGnMbbne4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733015435; c=relaxed/simple;
	bh=UpeH9emcfZiamV8s/8cEG1EkyeMLrtnLeq+BlqlI8v4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TgZrX3dyhhTX4ueup00LMILNRLhoJ4yXpYmKCFfcLVWzVu9OmD+l/k3hlTrJnBCsKllTrDLvqQLNBYncih/OB5duS7cz0ztzrHXvYFaFvbp+ibPcps0yN/BjmaFykvK4RrebN0la+LHXMVCbZQcf9Bj+99rzwVnRws+DJizniJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=brSoHv5w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68CE1C4CECC;
	Sun,  1 Dec 2024 01:10:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733015433;
	bh=UpeH9emcfZiamV8s/8cEG1EkyeMLrtnLeq+BlqlI8v4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=brSoHv5wmQHTZKwrSa9bCFiFrc8xJOyL+Yo0eiqnA0qAvk6O15XaJL3VSAYFg9pnS
	 P2bJcncNjEMdH67Or+r8IkHnc7Uh5rNXVy35lpojRQWa+U5BbGt3UpHmNo3+itQZhv
	 Hj9RIDjPlXnO8CXCDyTgY3ArgDQvvHWk2kB7Ag732PPZpZRWm6lYxwmNNFmZT11Kzy
	 t/S60ERi0yDS7GYCl3xubez7H7ADBmpOZQEpNeM4uHYjy+YtfecNqJWEEQflWvX2fg
	 Ak+bMOAXRRucXz8iMdu72OSj+4xk8yQO6xqceUxypixVpEenS4Aujj5SH5uL5/F/T2
	 mdAXV7S9iKKzg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.11/6.12] net_sched: sch_fq: don't follow the fast path if Tx is behind now
Date: Sat, 30 Nov 2024 20:10:31 -0500
Message-ID: <20241130200339-8ab1b38516913b7c@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241130175148.63765-1-kuba@kernel.org>
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

The upstream commit SHA1 provided is correct: 122aba8c80618eca904490b1733af27fb8f07528


Status in newer kernel trees:
6.12.y | Not found

Note: The patch differs from the upstream commit:
---
1:  122aba8c80618 ! 1:  14d9d00a6b68f net_sched: sch_fq: don't follow the fast path if Tx is behind now
    @@ Metadata
      ## Commit message ##
         net_sched: sch_fq: don't follow the fast path if Tx is behind now
     
    +    [ Upstream commit 122aba8c80618eca904490b1733af27fb8f07528 ]
    +
         Recent kernels cause a lot of TCP retransmissions
     
         [ ID] Interval           Transfer     Bitrate         Retr  Cwnd
    @@ Commit message
         Reviewed-by: Eric Dumazet <edumazet@google.com>
         Link: https://patch.msgid.link/20241124022148.3126719-1-kuba@kernel.org
         Signed-off-by: Paolo Abeni <pabeni@redhat.com>
    +    [stable: drop the offload horizon, it's not supported / 0]
    +    Signed-off-by: Jakub Kicinski <kuba@kernel.org>
     
      ## net/sched/sch_fq.c ##
     @@ net/sched/sch_fq.c: static bool fq_fastpath_check(const struct Qdisc *sch, struct sk_buff *skb,
    @@ net/sched/sch_fq.c: static bool fq_fastpath_check(const struct Qdisc *sch, struc
     +		/* Ordering invariants fall apart if some delayed flows
     +		 * are ready but we haven't serviced them, yet.
     +		 */
    -+		if (q->time_next_delayed_flow <= now + q->offload_horizon)
    ++		if (q->time_next_delayed_flow <= now)
     +			return false;
      	}
      
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.12.y       |  Success    |  Success   |
| stable/linux-6.11.y       |  Success    |  Success   |

