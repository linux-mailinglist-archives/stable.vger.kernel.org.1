Return-Path: <stable+bounces-126661-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 96DD9A70EEF
	for <lists+stable@lfdr.de>; Wed, 26 Mar 2025 03:23:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 519BD189A5CF
	for <lists+stable@lfdr.de>; Wed, 26 Mar 2025 02:23:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A777213A86C;
	Wed, 26 Mar 2025 02:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GeVP7H5d"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 691E2137775
	for <stable@vger.kernel.org>; Wed, 26 Mar 2025 02:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742955820; cv=none; b=qXIljJ1VhJLICYsq7jS0TpUj7VvGUDl8IevM/QqEp+NVMhfAj55GKyFJHp9xDt8AmCqe3x+rFBpIW3lEYmSLzxQ7ackYSlXycdspus7mmaQRIPFipibi5jeqQ8ZoWlOPWzx1HiC9vkannTZAcGJ4rK5Itn2iZRuIlij4xg2m3EI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742955820; c=relaxed/simple;
	bh=EQKWl4TDcDRH7HpH25DCd6CD8xfbsNVDf6XQFJiR1AE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S8Sinl38OLrkz3UKs0R44g8ldXFIcAHfQKXDn73D8TXwzJvoa0V41FNCTwZiSIwBmxUJLV0Kx1wvDzPZCWgrC73JgzoZ6S0/VMkRBXo5SoVVpm54m0EcVPxmvij5TVm65zUKJcEd1AKB1j1eoBqQCqSklB2dEmRvmUaj5jUM/2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GeVP7H5d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CA6BC4CEE4;
	Wed, 26 Mar 2025 02:23:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742955819;
	bh=EQKWl4TDcDRH7HpH25DCd6CD8xfbsNVDf6XQFJiR1AE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GeVP7H5d6CNXmBfG0xWySAp+9yR5r8Tnpx2+r8MzOP55ukMsKv7Yg3DVJwkHTzZ/U
	 2CZIHfufgV11l/t0ls4r4imiwfqnwrjdzpMtrQiWRTvz3ATV4lfnJO7aKwxmvGyG3M
	 +XURMDZ4yJn0bs355xtYr+9HA7uTtfxJxBQSQOoR+o5af/D553bOEN6d0NQ6GzPDKA
	 K+dPzXmRFtuTQTLfQSTbmpXngpNi2+ySXtGm7OAvVfsCUCJMiCY96FV3O0LD72N3Dr
	 dHU54oxUHyIKJW4hDrGfwKBn8u1tQgGGCGYDcmiVuPNkGfY3mGztX6Urjac+wnlxJd
	 TOfyb20B7Cx7g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	florian.fainelli@broadcom.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH stable 5.10 v2 2/2] openvswitch: fix lockup on tx to unregistering netdev with carrier
Date: Tue, 25 Mar 2025 22:23:37 -0400
Message-Id: <20250325205537-aef538619ff3d934@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250325192236.1849940-3-florian.fainelli@broadcom.com>
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
ℹ️ This is part 2/2 of a series
⚠️ Provided upstream commit SHA1 does not match found commit

The claimed upstream commit SHA1 (82f433e8dd0629e16681edf6039d094b5518d8ed) was not found.
However, I found a matching commit: 47e55e4b410f7d552e43011baa5be1aab4093990

WARNING: Author mismatch between patch and found commit:
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
1:  47e55e4b410f7 ! 1:  8eccde1235b42 openvswitch: fix lockup on tx to unregistering netdev with carrier
    @@ Metadata
      ## Commit message ##
         openvswitch: fix lockup on tx to unregistering netdev with carrier
     
    +    [ Upstream commit 82f433e8dd0629e16681edf6039d094b5518d8ed ]
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

NOTE: These results are for this patch alone. Full series testing will be
performed when all parts are received.

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.15.y       |  Success    |  Success   |

