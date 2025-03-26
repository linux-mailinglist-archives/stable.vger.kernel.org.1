Return-Path: <stable+bounces-126775-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3323CA71DD9
	for <lists+stable@lfdr.de>; Wed, 26 Mar 2025 18:58:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D07343B9852
	for <lists+stable@lfdr.de>; Wed, 26 Mar 2025 17:54:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ED7F23E332;
	Wed, 26 Mar 2025 17:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rYTKbRrp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0A241F95C
	for <stable@vger.kernel.org>; Wed, 26 Mar 2025 17:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743011685; cv=none; b=ZPGPDIo4PtXsJWXGxPNaXMWRfurDMCzbIoyfQ/ciefqmaSfzjqNsaZUbwlq7duzS0jb2ei97XN0KFdOebvbE9uqVHO4boDQdawjST9LkhPqCa8Pg4vAzIArTAyTkZerLmWsBA6jvhDkdeROvGjCnmQUIdUYPOs5R7kSjfcZmyuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743011685; c=relaxed/simple;
	bh=XSd7GbeMSdGZdnHCdg0MyA0FtQz/SGJd7vV8sYzPK/Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nOf93ByD4QfVDQ34hpY/hCqBMKzbdFmAMPLeVqnuU6HTBZz3E0M/eE1WU/eCljpHDFObHPzWCKLW9MFJk2Ye+bnvpyVYoBGJg96y7Wa1fN4Qwdy/kRGQYAsvFkOT7IDaMQKRbbl0C2wXxtzyiP9znQXq/5g6IBnthbEAs1b1TrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rYTKbRrp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 657B3C4CEE2;
	Wed, 26 Mar 2025 17:54:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743011684;
	bh=XSd7GbeMSdGZdnHCdg0MyA0FtQz/SGJd7vV8sYzPK/Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rYTKbRrpHoEJ7nTAke/LomBt/nplXMI47sZDq8E705FxULPkZU92IvczQYTUwehe4
	 ieGOoD51M+3L4RLjE9bmuIVnDNzITxb3N9DM/DbvoDHwFyghUx8OBXIQpCzFrk2NhL
	 5At2HyTW3qnPoMna7tv/to9YbASD/+pN3w9F4Zr3xMMqaYNG8HZiMsDb569VMgGzxy
	 U2678JWdGfnfWhAxVeIeyM8tBF/8DhISXQm8QWcmCss1+aySzrE2yoG6EvtufkNH/x
	 W36HATSRwX4e5qbDj4SIsjKHeF6Ux8sUG2QxhOCuSbB75FN9VWEYHfsq5S5DoByI/W
	 T1pUg+sXQo9Zg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	florian.fainelli@broadcom.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH stable 5.10 v3 1/2] net: openvswitch: fix race on port output
Date: Wed, 26 Mar 2025 13:54:41 -0400
Message-Id: <20250326125757-b04300e56bc9ada8@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250326155841.4133945-2-florian.fainelli@broadcom.com>
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

Summary of potential issues:
⚠️ Found follow-up fixes in mainline

The upstream commit SHA1 provided is correct: 066b86787fa3d97b7aefb5ac0a99a22dad2d15f8

WARNING: Author mismatch between patch and upstream commit:
Backport author: Florian Fainelli<florian.fainelli@broadcom.com>
Commit author: Felix Huettner<felix.huettner@mail.schwarz>

Status in newer kernel trees:
6.13.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (exact SHA1)
6.1.y | Present (different SHA1: 644b3051b06b)
5.15.y | Not found

Found fixes commits:
47e55e4b410f openvswitch: fix lockup on tx to unregistering netdev with carrier

Note: The patch differs from the upstream commit:
---
1:  066b86787fa3d ! 1:  f4db6d778ee4f net: openvswitch: fix race on port output
    @@ Metadata
      ## Commit message ##
         net: openvswitch: fix race on port output
     
    +    [ Upstream commit 066b86787fa3d97b7aefb5ac0a99a22dad2d15f8 ]
    +
         assume the following setup on a single machine:
         1. An openvswitch instance with one bridge and default flows
         2. two network namespaces "server" and "client"
    @@ Commit message
         Reviewed-by: Simon Horman <simon.horman@corigine.com>
         Link: https://lore.kernel.org/r/ZC0pBXBAgh7c76CA@kernel-bug-kernel-bug
         Signed-off-by: Jakub Kicinski <kuba@kernel.org>
    +    Signed-off-by: Carlos Soto <carlos.soto@broadcom.com>
    +    Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
     
      ## net/core/dev.c ##
     @@ net/core/dev.c: static u16 skb_tx_hash(const struct net_device *dev,
      	}
      
      	if (skb_rx_queue_recorded(skb)) {
    -+		DEBUG_NET_WARN_ON_ONCE(qcount == 0);
    ++		BUILD_BUG_ON_INVALID(qcount == 0);
      		hash = skb_get_rx_queue(skb);
      		if (hash >= qoffset)
      			hash -= qoffset;
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.10.y       |  Success    |  Success   |

