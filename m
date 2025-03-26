Return-Path: <stable+bounces-126778-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E394AA71DC0
	for <lists+stable@lfdr.de>; Wed, 26 Mar 2025 18:55:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 641811708F7
	for <lists+stable@lfdr.de>; Wed, 26 Mar 2025 17:55:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23FCE2192F5;
	Wed, 26 Mar 2025 17:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T7QCWuK4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7E531A8407
	for <stable@vger.kernel.org>; Wed, 26 Mar 2025 17:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743011698; cv=none; b=M2NiXvayTUftsdChL6LO2NNGiJUI9DudFyNN72nFcnQeoxOnNURFt6ej+psVgbshEfcZYF4cLsiOnhUS6XmEvPn4/k9cMnu0WXEx+yIjUtqqTBq/R0LdK4vT+QiPEe/xBcHvSzQpnQ8Z32MB+hgsZJ/LsitNWkY6VjzJZ4Rdakc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743011698; c=relaxed/simple;
	bh=SBkDopfEK9FkW+huJYFxV4tfSIVC+M7fKuiKcR4HpSA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rLHoUtJj61o3xL+gkzSvW/6xMWM3iaq4W0+rpQV0LRh2hrQQ4IVl4aLVYXctozzkkCmdYo+sqbiZA1M/Xm/IaGir2yK7VPd/SIFL/Z+Is7R/916VFuUtqgdbAVC6rxYVH9vx40pmtxdWmOZcjzmw2GGEbPMgMWrcVQx8meGGnio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T7QCWuK4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46B5CC4CEE2;
	Wed, 26 Mar 2025 17:54:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743011698;
	bh=SBkDopfEK9FkW+huJYFxV4tfSIVC+M7fKuiKcR4HpSA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=T7QCWuK4aYjXuxcmt00nR2AohoKRweUh/CzrHao/CSZS0CUJs/n/b/wy5w/AfbV3C
	 rAQFODdvfylwcUo1aX0NdX58tRJaGtS4wliX5L6vCXQ1zJTMN4Sg1/Tt4Llb7xIDcx
	 J5KbtAPZBxf3EEWNzKqX9TG30SYWFCgmxUOVnPOxX1sEKNeyTSuv11571JSEqjU2pP
	 ZXINcIE4z+Sf/Z/VINlmmtWjGgtiEqCHrEw9RjgU7gZEHofQuPevNDB3LLra6XhDAM
	 Vo0oWOLapnxsz0Qv9DzXDXwqyvAZ9mRHBbW+wrFJmz11b0L7dhM9GEayCHjJJjpSHy
	 Y1EcA0cxG6tLQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH stable 5.10 v3 2/2] openvswitch: fix lockup on tx to unregistering netdev with carrier
Date: Wed, 26 Mar 2025 13:54:54 -0400
Message-Id: <20250326130507-2d65f72c1e96e8f6@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250326155841.4133945-3-florian.fainelli@broadcom.com>
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

Note: The patch differs from the upstream commit:
---
1:  47e55e4b410f7 ! 1:  e26c6c11e9fc7 openvswitch: fix lockup on tx to unregistering netdev with carrier
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
| stable/linux-5.15.y       |  Success    |  Success   |

