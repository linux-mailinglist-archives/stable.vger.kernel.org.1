Return-Path: <stable+bounces-126781-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 86CD2A71DDC
	for <lists+stable@lfdr.de>; Wed, 26 Mar 2025 18:58:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8115E3A8018
	for <lists+stable@lfdr.de>; Wed, 26 Mar 2025 17:54:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92CDD219305;
	Wed, 26 Mar 2025 17:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ppubn3R+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52D601F5827
	for <stable@vger.kernel.org>; Wed, 26 Mar 2025 17:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743011711; cv=none; b=tnAiR2siRkBZ4Nmhgzsg2P8j8bVlVcJmmxynG3i1V1EVxfxyPhMp2/hOLBwUfzK6406Niyp6f98fefSHAmM6yno9KT/bmloLW1GVUly0aJ3GX2OBHcDDdfPFoioC40iT6nmMOUP7u0OQRD1ivTVt/+tgqg8IEDNLsM3Q6h8JJPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743011711; c=relaxed/simple;
	bh=AVHEHKATUT/KwKmaqVB/Mu34DlOdeMnULQDhnZrAImE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XPyWy5bad8JrvJHpMTdDD0hnsRn+6P8fAGH8dwbS8pEWz0cbtq6ZQVfe95rpImwZZmmEGP7xS7sIE657Qszr0snmEMI4Y+2C3TAQCj/jJYS35JRjMnVcZbN/ZBe0c5g9SzVZNadU5tD1om9sivbCZ4HVifL+H/0PPDjCjMTpEL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ppubn3R+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4C1AC4CEE2;
	Wed, 26 Mar 2025 17:55:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743011711;
	bh=AVHEHKATUT/KwKmaqVB/Mu34DlOdeMnULQDhnZrAImE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ppubn3R+DdOUtCE2r3tcb4A/5aBJUj/Z59B5RJxnP8MNrg8cTyyPGPn3q/7QiXkiO
	 64rs5GUEaYaeQWA0/t9Oa6g4vzmQG17iKGsDFhOxTv2u0XLG+MayPpEuL4jIMWc87n
	 eMfCYhZVIgZxHQ7cyDG14rI5fyOh3ESXAp5xfRzhGW8JrrIgnjuhyJ3ucMuw7WiNFD
	 2CkPWr3gQpVvkdoAc3KZaFMZqegnvYPjXCv/ANTabYAWzx3v2BzLAxnr8PM+uUAXbm
	 nzTlaJUTSYhhAQJz7PZtS9kI98j4yNtu9JHCFO7YUPvucmfyAZntQxir4DnMnPXwaN
	 3CsIvbb05x7UQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	florian.fainelli@broadcom.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH stable 5.15 v2 1/2] net: openvswitch: fix race on port output
Date: Wed, 26 Mar 2025 13:55:07 -0400
Message-Id: <20250326132132-157910064b9f9bd2@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250326155856.4133986-2-florian.fainelli@broadcom.com>
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

Found fixes commits:
47e55e4b410f openvswitch: fix lockup on tx to unregistering netdev with carrier

Note: The patch differs from the upstream commit:
---
1:  066b86787fa3d ! 1:  3e36758ea4208 net: openvswitch: fix race on port output
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
| stable/linux-5.15.y       |  Success    |  Success   |

