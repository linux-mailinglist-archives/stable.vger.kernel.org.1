Return-Path: <stable+bounces-126776-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E5EFCA71DDA
	for <lists+stable@lfdr.de>; Wed, 26 Mar 2025 18:58:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FD703A2F99
	for <lists+stable@lfdr.de>; Wed, 26 Mar 2025 17:54:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56AC223F434;
	Wed, 26 Mar 2025 17:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U/qLL63O"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1438E2054ED
	for <stable@vger.kernel.org>; Wed, 26 Mar 2025 17:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743011690; cv=none; b=ZcGBIzz6i3iGwsQ6/YlXygIpdnXXuWI9XlPJBAeilk/UFgb6axnKogMheT0btBYdTJ4VHuWQaPgSlFUEfyrF3s3tv2ff7Cl9hBjYnuJPoPJCOH7niiEPopQCkwB29IX4k3tSaZh+3AKHA/Hbx+9fLnGqPt6TOqoSxRbb1Vk6FSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743011690; c=relaxed/simple;
	bh=i/7dGG1vUInVa4S8YX85suliLeOhd/+bp6sPGHjBpJM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dydgyXE84JKYiAZb4XepCpPDjHjE2Ns3qMh7p5o5VmkCMov3AcTqj9+y5lItSuEWH5lPpdbUv+B6tG0nWB/4u/bdN6S5ivHYc0D1v49xr7FuJW6PRo9T1oqWjgs6+5I+e0km+HKwpqnzxMVlCTWhOUs5n7VDe4A0Gm3ZdVXDp9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U/qLL63O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 721A8C4CEE2;
	Wed, 26 Mar 2025 17:54:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743011689;
	bh=i/7dGG1vUInVa4S8YX85suliLeOhd/+bp6sPGHjBpJM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=U/qLL63OgvRzcm6ak974g4cbSkoOR0hAry43w4Abci2Nz9iGr2i/WnuKz3zDixo/h
	 0nn46mH9+ZrITR29HVe4s0Qw7vdBRaXNS1yAub0VxAezAl6R3SogORlz3XNtwMPo6K
	 iaDfA4h16ngUFkZC0JJ7N6T9gMv8H0rDlgbguHBJWjDvQiVOxnwkZThbvc3ekMpQxB
	 G/JQ1tQCmIMOYQPYAyc9139Y4+YlIRFr50+02FcGKk5/rvzVV4Ut83i7EYWSY49C5o
	 DZ39i6ofV7y2flO8eJNEQMWnMDZP/+hvJVpljeianOHtHdmaeHwZ0zb5TPgHtyBVQ3
	 LYN6IStzDlnzg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH stable 5.4 v3 2/2] openvswitch: fix lockup on tx to unregistering netdev with carrier
Date: Wed, 26 Mar 2025 13:54:45 -0400
Message-Id: <20250326134447-694c54839fb6d79b@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250326155800.4133904-3-florian.fainelli@broadcom.com>
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

The upstream commit SHA1 provided is correct: 47e55e4b410f7d552e43011baa5be1aab4093990

WARNING: Author mismatch between patch and upstream commit:
Backport author: Florian Fainelli<florian.fainelli@broadcom.com>
Commit author: Ilya Maximets<i.maximets@ovn.org>

Status in newer kernel trees:
6.13.y | Present (exact SHA1)
6.12.y | Present (different SHA1: 82f433e8dd06)
6.6.y | Present (different SHA1: ea966b669878)
6.1.y | Present (different SHA1: ea9e990356b7)
5.15.y | Not found
5.10.y | Not found

Note: The patch differs from the upstream commit:
---
1:  47e55e4b410f7 ! 1:  6bcba442a60ff openvswitch: fix lockup on tx to unregistering netdev with carrier
    @@ Metadata
      ## Commit message ##
         openvswitch: fix lockup on tx to unregistering netdev with carrier
     
    +    [ Upstream commit 47e55e4b410f7d552e43011baa5be1aab4093990 ]
    +
         Commit in a fixes tag attempted to fix the issue in the following
         sequence of calls:
     
    @@ Commit message
         Reviewed-by: Aaron Conole <aconole@redhat.com>
         Link: https://patch.msgid.link/20250109122225.4034688-1-i.maximets@ovn.org
         Signed-off-by: Jakub Kicinski <kuba@kernel.org>
    +    Signed-off-by: Sasha Levin <sashal@kernel.org>
    +    Signed-off-by: Carlos Soto <carlos.soto@broadcom.com>
    +    Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
     
      ## net/openvswitch/actions.c ##
     @@ net/openvswitch/actions.c: static void do_output(struct datapath *dp, struct sk_buff *skb, int out_port,
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.10.y       |  Success    |  Success   |

