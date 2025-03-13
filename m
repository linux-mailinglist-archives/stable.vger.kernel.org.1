Return-Path: <stable+bounces-124249-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E48BA5EF21
	for <lists+stable@lfdr.de>; Thu, 13 Mar 2025 10:10:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CCBF1893123
	for <lists+stable@lfdr.de>; Thu, 13 Mar 2025 09:10:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F4141264F90;
	Thu, 13 Mar 2025 09:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GQTLahZe"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC3F0264A7B
	for <stable@vger.kernel.org>; Thu, 13 Mar 2025 09:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741856932; cv=none; b=qslqez8fkpSbYU1sX8pnQS/g4D7cqaO1N0GtGVEy38Yqf0SIWGSQ4qa/Y/hZHfUNSj1AWv9BNApp2S5MNQCvhRv8D8LFBANnk9KS5S8vPfpN7qzw1PqaioJRKdWVwPjno4Juhz7ITNlvrSaEz5zaduAlHsD9MVEWghJogmAkdLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741856932; c=relaxed/simple;
	bh=5QXSbh2PG+e4QEAYsTg5/4SDDGo4siYdQXJoRxrFCyE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Iwya7fyChYaAoOCtD1ujrbzcPLVx/6Fa4USNmLesR6q1aqZLWybMtBRsd81Uu9YLG92iiU44LE10TL3H0TyUQlq/Q6Qx/53HOnpU2Muo89NvapeKbh9ttj5cjfz0rJ0D3LSgYW/InLUB+NYRhfLAci8ytKhd3IGofIdR9yTEwpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GQTLahZe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91F69C4CEDD;
	Thu, 13 Mar 2025 09:08:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741856932;
	bh=5QXSbh2PG+e4QEAYsTg5/4SDDGo4siYdQXJoRxrFCyE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GQTLahZeEQw0gAEhQngzc8zHzxYzrN0kCKt5fKEI9tO2iKlxQxyKfM+2smZdIxBsP
	 vyfSlEIRIu4kvqiNMeJCvM3tEm5v9HYKKUdNuJ1p4bVrXgSFXSQ3mN7q3QP3v89eOa
	 nsqTZ9Ut6y12cp0e6vjTrra2/8gbF97AVpDT9C6BWQXXJkOBiv0YaG3/ZqmOHtsmt1
	 vhVfq2Pi0zBYhI5PuHRuIW5gIHwuUAW+6XzcVQPTNWzwYKgrAiXhRNJh3otqMsx4o4
	 pMHjnH9FRHix6gxTfaXUiCYonxPcCTLtVVpIKcgJ3syvFinap+Lp6sBQ2dJ6dqpkrs
	 plo9WXLmZdQ+A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Magali Lemes <magali.lemes@canonical.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.4 3/4] sctp: sysctl: cookie_hmac_alg: avoid using current->nsproxy
Date: Thu, 13 Mar 2025 05:08:50 -0400
Message-Id: <20250312234712-52e1f50c3b0ba0c9@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250311185427.1070104-4-magali.lemes@canonical.com>
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

The upstream commit SHA1 provided is correct: ea62dd1383913b5999f3d16ae99d411f41b528d4

WARNING: Author mismatch between patch and upstream commit:
Backport author: Magali Lemes<magali.lemes@canonical.com>
Commit author: Matthieu Baerts (NGI0)<matttbe@kernel.org>

Status in newer kernel trees:
6.13.y | Present (exact SHA1)
6.12.y | Present (different SHA1: f0bb39354706)
6.6.y | Present (different SHA1: ad673e514b27)
6.1.y | Present (different SHA1: 3cd0659deb9c)
5.15.y | Present (different SHA1: 86ddf8118123)
5.10.y | Present (different SHA1: 03ca51faba2b)

Note: The patch differs from the upstream commit:
---
1:  ea62dd1383913 ! 1:  0deb81ab0a4a2 sctp: sysctl: cookie_hmac_alg: avoid using current->nsproxy
    @@ Metadata
      ## Commit message ##
         sctp: sysctl: cookie_hmac_alg: avoid using current->nsproxy
     
    +    commit ea62dd1383913b5999f3d16ae99d411f41b528d4 upstream.
    +
         As mentioned in a previous commit of this series, using the 'net'
         structure via 'current' is not recommended for different reasons:
     
    @@ Commit message
         Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
         Link: https://patch.msgid.link/20250108-net-sysctl-current-nsproxy-v1-4-5df34b2083e8@kernel.org
         Signed-off-by: Jakub Kicinski <kuba@kernel.org>
    +    Signed-off-by: Magali Lemes <magali.lemes@canonical.com>
     
      ## net/sctp/sysctl.c ##
    -@@ net/sctp/sysctl.c: static struct ctl_table sctp_net_table[] = {
    - static int proc_sctp_do_hmac_alg(const struct ctl_table *ctl, int write,
    - 				 void *buffer, size_t *lenp, loff_t *ppos)
    +@@ net/sctp/sysctl.c: static int proc_sctp_do_hmac_alg(struct ctl_table *ctl, int write,
    + 				void __user *buffer, size_t *lenp,
    + 				loff_t *ppos)
      {
     -	struct net *net = current->nsproxy->net_ns;
     +	struct net *net = container_of(ctl->data, struct net,
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.4.y        |  Success    |  Success   |

