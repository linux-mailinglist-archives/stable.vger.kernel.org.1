Return-Path: <stable+bounces-106241-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EB209FDFD1
	for <lists+stable@lfdr.de>; Sun, 29 Dec 2024 17:10:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD9E21619C2
	for <lists+stable@lfdr.de>; Sun, 29 Dec 2024 16:10:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B32B318628F;
	Sun, 29 Dec 2024 16:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M2GIvg3h"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D4A827713
	for <stable@vger.kernel.org>; Sun, 29 Dec 2024 16:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735488601; cv=none; b=LQQtErn/a33A8PibUqAuxiP6/a6RGnKs5C+eAnttpsAhBBbnWc0OaEMXNXNtwTdICX9RD8ya1FycnFkVXnG43U6eihR06AG8E/miAd8mZl6zoktPMv75f4gD1aLglypjdAehr5BLkIZjhIvu08ayGEyleejHLsOVdkU524SVSGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735488601; c=relaxed/simple;
	bh=6kEiZ5V9dnZGJirut7wSVOBzpOwrzgncL2BJcHqe/2E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NwVzGbQCI7HyVuilRQ0J9AQEW+/iUxmCGTf2jGZbT/EVJIf2bj7o2eFJdoYH3PMw2MqaEX1nYAjD4akEgCYwsfW/Kt463GmQ4YXU06CttfN8WzaA8LMpxRt+RLK5wVUJDj6b6dVfjdY1hPX1t8Z8c5UWuEVE+C/XaUPbXer9e8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M2GIvg3h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AC9CC4CED1;
	Sun, 29 Dec 2024 16:10:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735488600;
	bh=6kEiZ5V9dnZGJirut7wSVOBzpOwrzgncL2BJcHqe/2E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=M2GIvg3hWvcESSYVuYnJnO+UvWfrNCKALuqx6lI1DFWqVZ/PKQhedoGKp7RXl/i7i
	 T8CaVnDlHl9Eg9Vht4EZKptmtEzpmZrt3OIuJmceQNZ+cx0+nH6lsoDsEEDyID1nye
	 NenWEN3gx0oYTdcXbZxYVrupwS0WFLwMdOzgIl2cLzFBZovTTOHz77uqWGm61WM15n
	 KL7Hv5lyCyfdmdUESo0MokQziJ9q2aXK5eY54aIKWVI4Y9YpYNPRDWFPO13jwUbpYY
	 B6Em3a/axlbjHkyL0Smg5grAUKiX3gDEQKOAkWji/LvJ1fnNYJAoOfBXW1qdWWDlRy
	 MKqmvktriiCgw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Srish Srinivasan <srishwap4@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH v5.10] bpf: fix recursive lock when verdict program return SK_PASS
Date: Sun, 29 Dec 2024 11:09:58 -0500
Message-Id: <20241229105403-9a5e93ba8876b6bd@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20241228191415.41473-1-srishwap4@gmail.com>
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

The upstream commit SHA1 provided is correct: 8ca2a1eeadf09862190b2810697702d803ceef2d

WARNING: Author mismatch between patch and upstream commit:
Backport author: Srish Srinivasan<srishwap4@gmail.com>
Commit author: Jiayuan Chen<mrpre@163.com>


Status in newer kernel trees:
6.12.y | Present (different SHA1: f84c5ef6ca23)
6.6.y | Present (different SHA1: da2bc8a0c8f3)
6.1.y | Present (different SHA1: 386efa339e08)
5.15.y | Present (different SHA1: 6694f7acd625)
5.10.y | Not found

Note: The patch differs from the upstream commit:
---
1:  8ca2a1eeadf0 ! 1:  3487de836032 bpf: fix recursive lock when verdict program return SK_PASS
    @@ Metadata
      ## Commit message ##
         bpf: fix recursive lock when verdict program return SK_PASS
     
    +    commit 8ca2a1eeadf09862190b2810697702d803ceef2d upstream.
    +
         When the stream_verdict program returns SK_PASS, it places the received skb
         into its own receive queue, but a recursive lock eventually occurs, leading
         to an operating system deadlock. This issue has been present since v6.9.
    @@ Commit message
         Acked-by: Martin KaFai Lau <martin.lau@kernel.org>
         Link: https://patch.msgid.link/20241118030910.36230-2-mrpre@163.com
         Signed-off-by: Jakub Kicinski <kuba@kernel.org>
    +    Signed-off-by: Sasha Levin <sashal@kernel.org>
    +    [srish: Apply to stable branch linux-5.10.y]
    +    Signed-off-by: Srish Srinivasan <srishwap4@gmail.com>
     
      ## net/core/skmsg.c ##
     @@ net/core/skmsg.c: static void sk_psock_strp_data_ready(struct sock *sk)
      		if (tls_sw_has_ctx_rx(sk)) {
    - 			psock->saved_data_ready(sk);
    + 			psock->parser.saved_data_ready(sk);
      		} else {
     -			write_lock_bh(&sk->sk_callback_lock);
     +			read_lock_bh(&sk->sk_callback_lock);
    - 			strp_data_ready(&psock->strp);
    + 			strp_data_ready(&psock->parser.strp);
     -			write_unlock_bh(&sk->sk_callback_lock);
     +			read_unlock_bh(&sk->sk_callback_lock);
      		}
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.10.y       |  Success    |  Success   |

