Return-Path: <stable+bounces-124245-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 204CDA5EF22
	for <lists+stable@lfdr.de>; Thu, 13 Mar 2025 10:10:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7FAF17D8F0
	for <lists+stable@lfdr.de>; Thu, 13 Mar 2025 09:10:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91405266199;
	Thu, 13 Mar 2025 09:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Au9Yisi5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4924E26563C
	for <stable@vger.kernel.org>; Thu, 13 Mar 2025 09:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741856924; cv=none; b=ci4XOU5MsSU88ebVMIUReZFAsyzFOlkSuAy4SQ37SEIr0U3AZ6Ch7rf70oSBBkEIsrgBKB0IWnunOGUer+KzKlMWKJW6BdGsQmSJU6WmhUifdi0TpbpWTeiqrH5wYKoFVSg65O/1lRtnfKZzR3w0Nx7RIYy4cQnDKyE1dY7Gg1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741856924; c=relaxed/simple;
	bh=QL23fcfh0shPLspIUbfEnoY40ECyvqfz/JzLhn6NlnI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mZ/k4DnkWtc7wk3LoWe1c0ixiKQGtwbWEcybCNmrXIzQ1asWAN35qmUX7xCiYvg1kBsvfFaoldGQZALEpu7k8HyqrCXFg548MG10SpirkG+7c2/oZLG0Qo6j/V2L/vbU3PjnauVeWLIoGrikQyaRe+NXVj/n09uD88euq2imQjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Au9Yisi5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29166C4CEDD;
	Thu, 13 Mar 2025 09:08:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741856923;
	bh=QL23fcfh0shPLspIUbfEnoY40ECyvqfz/JzLhn6NlnI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Au9Yisi5GsXmHkC7d8OSwVsIPoEQNqD2wj5yEYOQbHGS0xgPXu8VB4QivKFLwvy3W
	 LWA4gx9e15S8BGX9n1y4WNvfoNgTl8NaGouM/SFY3F7Vg/OfkCSYzrWBTpGtZR6gNh
	 i8CYtPM4ZOQVSVcvNKuI/qALzZNVTBN046PBbKSpsMQKXBDm1hbxKbY1Fn2hdYhQlt
	 GOG7emBBdbphV2ZEA1LVTy/a7EC7gMQLu1hXcPnf0zxNnFZAmD5XOcmJw8kzyNzDjN
	 DlNUrWhZYwNebck4GJY9Dw6ByY7Tph9cClu4wl4W5vRnqgpsOedic7TpaVfBbGyDyJ
	 M4lxqiLQM1ENw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Magali Lemes <magali.lemes@canonical.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.4 4/4] sctp: sysctl: auth_enable: avoid using current->nsproxy
Date: Thu, 13 Mar 2025 05:08:41 -0400
Message-Id: <20250312235036-ab62536f582e2005@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250311185427.1070104-5-magali.lemes@canonical.com>
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

The upstream commit SHA1 provided is correct: 15649fd5415eda664ef35780c2013adeb5d9c695

WARNING: Author mismatch between patch and upstream commit:
Backport author: Magali Lemes<magali.lemes@canonical.com>
Commit author: Matthieu Baerts (NGI0)<matttbe@kernel.org>

Status in newer kernel trees:
6.13.y | Present (exact SHA1)
6.12.y | Present (different SHA1: c184bc621e3c)
6.6.y | Present (different SHA1: 7ec30c54f339)
6.1.y | Present (different SHA1: 1b67030d39f2)
5.15.y | Present (different SHA1: bd2a29394235)
5.10.y | Present (different SHA1: dc583e7e5f85)

Note: The patch differs from the upstream commit:
---
1:  15649fd5415ed ! 1:  43321e75147b6 sctp: sysctl: auth_enable: avoid using current->nsproxy
    @@ Metadata
      ## Commit message ##
         sctp: sysctl: auth_enable: avoid using current->nsproxy
     
    +    commit 15649fd5415eda664ef35780c2013adeb5d9c695 upstream.
    +
         As mentioned in a previous commit of this series, using the 'net'
         structure via 'current' is not recommended for different reasons:
     
    @@ Commit message
         Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
         Link: https://patch.msgid.link/20250108-net-sysctl-current-nsproxy-v1-6-5df34b2083e8@kernel.org
         Signed-off-by: Jakub Kicinski <kuba@kernel.org>
    +    Signed-off-by: Magali Lemes <magali.lemes@canonical.com>
     
      ## net/sctp/sysctl.c ##
    -@@ net/sctp/sysctl.c: static int proc_sctp_do_alpha_beta(const struct ctl_table *ctl, int write,
    - static int proc_sctp_do_auth(const struct ctl_table *ctl, int write,
    - 			     void *buffer, size_t *lenp, loff_t *ppos)
    +@@ net/sctp/sysctl.c: static int proc_sctp_do_auth(struct ctl_table *ctl, int write,
    + 			     void __user *buffer, size_t *lenp,
    + 			     loff_t *ppos)
      {
     -	struct net *net = current->nsproxy->net_ns;
     +	struct net *net = container_of(ctl->data, struct net, sctp.auth_enable);
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.4.y        |  Success    |  Success   |

