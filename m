Return-Path: <stable+bounces-164790-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F1DBB12765
	for <lists+stable@lfdr.de>; Sat, 26 Jul 2025 01:26:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93FFD5A3285
	for <lists+stable@lfdr.de>; Fri, 25 Jul 2025 23:26:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82F9A26158B;
	Fri, 25 Jul 2025 23:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PiIDnCgi"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 435222609C5
	for <stable@vger.kernel.org>; Fri, 25 Jul 2025 23:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753485979; cv=none; b=XBd/cXvT3JFmsox/5SdbEcnDvIM9J8qNcUTLA27xM3GNrTa7c+zj9SwHhA8pUyH2y7mFNkn2U8MpgE51rVfnbF0yxp9U5A3D4Q8W95pJfsl8bUOZSNql0tWeo8OhSa2xsQikTIkC2XpLd+vqXw4Hyf7ETgGq6pmcsM/zwf5uX8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753485979; c=relaxed/simple;
	bh=Eyae9C76BbCLQgGObDkVZK+ERgo4Mmqa4tP6hPArkt4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eV+X1MlJ/xR/5JXfFTGAveTssVCEfszegC0poudECINAgEdU4K2hGbHufR+Giw63uEERMP2ojjxROPai9R0pJesz+hC1benfQTF3JqYyUXRs/hG6JFLAflyoXzbcELbG5EEd6uQbSGXfXsCP81WFY/E4hOlAg2LGrz5N8MgPV+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PiIDnCgi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44884C4CEE7;
	Fri, 25 Jul 2025 23:26:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753485976;
	bh=Eyae9C76BbCLQgGObDkVZK+ERgo4Mmqa4tP6hPArkt4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PiIDnCgiqggiYFE1yJtH0qQgcYidJE6pFcNl4DVtRvvwWv97WXiIxy+B+pRjE33vN
	 S8PvKIBjANbghe+sPf2GBl7v8mQfgc4PR46v0xVkzSOjck/B4+A7pNM8zxxu3hb+ri
	 dojN58Az2hQQhaP2UZtKGqs/DMDXJr0o28MtKhe9w+4VF4FlcYb8f3n6rTTDtH0anr
	 n5RaG3h1+fmQEuoc1OFQaOljtvhwMXcNxjpvo1qxhUiAUcek/was9Qtyd7Of7kZMsK
	 hREtHET2aSPZ159fLMRspjXA5Bl+np5tKeLNktXHYpEUU0HXtdR1UZ1xQadZk9z6ZM
	 D/EhSUBgMVeWg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.4.y 1/8] net: sched: extract common action counters update code into function
Date: Fri, 25 Jul 2025 19:26:14 -0400
Message-Id: <1753463533-0989ae30@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250724192619.217203-2-skulkarni@mvista.com>
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

The upstream commit SHA1 provided is correct: c8ecebd04cbb6badb46d42fe54282e7883ed63cc

WARNING: Author mismatch between patch and upstream commit:
Backport author: <skulkarni@mvista.com>
Commit author: Vlad Buslov <vladbu@mellanox.com>

Status in newer kernel trees:
6.15.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (exact SHA1)
6.1.y | Present (exact SHA1)
5.15.y | Present (exact SHA1)
5.10.y | Present (exact SHA1)

Note: The patch differs from the upstream commit:
---
1:  c8ecebd04cbb ! 1:  0dd3ddfe6d2c net: sched: extract common action counters update code into function
    @@ Metadata
      ## Commit message ##
         net: sched: extract common action counters update code into function
     
    +    [ Upstream commit c8ecebd04cbb6badb46d42fe54282e7883ed63cc ]
    +
         Currently, all implementations of tc_action_ops->stats_update() callback
         have almost exactly the same implementation of counters update
         code (besides gact which also updates drop counter). In order to simplify
    @@ Commit message
         Signed-off-by: Vlad Buslov <vladbu@mellanox.com>
         Acked-by: Jiri Pirko <jiri@mellanox.com>
         Signed-off-by: David S. Miller <davem@davemloft.net>
    +    Stable-dep-of: ca22da2fbd69 ("act_mirred: use the backlog for nested calls to mirred ingress")
    +    Signed-off-by: Shubham Kulkarni <skulkarni@mvista.com>
     
      ## include/net/act_api.h ##
     @@ include/net/act_api.h: int tcf_action_dump(struct sk_buff *skb, struct tc_action *actions[], int bind,

---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| 5.4                       | Success     | Success    |

