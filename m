Return-Path: <stable+bounces-126779-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9C62A71DDB
	for <lists+stable@lfdr.de>; Wed, 26 Mar 2025 18:58:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3185B3A7267
	for <lists+stable@lfdr.de>; Wed, 26 Mar 2025 17:54:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A58432054ED;
	Wed, 26 Mar 2025 17:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dCS4G+wj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 641611F7069
	for <stable@vger.kernel.org>; Wed, 26 Mar 2025 17:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743011703; cv=none; b=D/4QRYsqx0JSejIIyX25mXrkQ6Ut+f3oD21mJWN/M4rNVCCoBrjoLs6LdqkQgWfHNZ2Y2irY9XvZzKNnLyYgPp6XF5y9mTlpHTMH0YhHN3eVTbGt6sUkiizBTuL038XnYy1+m7Qj1nsyoA4pipt1M3VQyn4zOBCF0qoT2xkGHhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743011703; c=relaxed/simple;
	bh=JaqlFhCJiyoMCGnVIufOw36pd9C17L+dwn/SRGA0FYY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JbhL2SoLyN7VAXsL5Q9GfzgHOBxwwvdGmpjEo3pbcE2B+hH9N9DrbQ99wGivFbNgKY0uCAr3qN9zICCExmQvtdlRlCngdEiF1zSDtVLkNnlkgAwF2M5RsdKlJESX7gubiNHGLB5GDHvBZd+YcY9fWvKwE75h887GOYnl8kW63Ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dCS4G+wj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA805C4CEE2;
	Wed, 26 Mar 2025 17:55:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743011703;
	bh=JaqlFhCJiyoMCGnVIufOw36pd9C17L+dwn/SRGA0FYY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dCS4G+wjcwBtDyhIegNTivITIPam22QYFgF4EJkYCYhjwlLTwlgOU3/1wobg4OUHn
	 Zm0nIxH6CpYrEjslhhOjA+bGHJ2hqBnrwKNqcsnVMH+LEi/f8vuQPHxTbbr/vVi0Wu
	 LZRgAPivBsOnet1mkyMtxHtpaIig44n5tKOoCuJE0TP6CplpafJks3BDUSQMjte+DF
	 CENKf83sxPMYCvLd36EB+UeFNNPNSNWTw89h2jjPWTQEH/EkHXmNtEpQoPzyF30Rp6
	 1yagyVJb1EGuGTMvLviCFybshvnVpAgGyCewhzRpq9jHYkyPw1c6q0102mgSbBAp9u
	 92KPgS8EpSxqA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH stable 5.15 v2 2/2] openvswitch: fix lockup on tx to unregistering netdev with carrier
Date: Wed, 26 Mar 2025 13:54:59 -0400
Message-Id: <20250326132959-cff0daf8fd23880b@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250326155856.4133986-3-florian.fainelli@broadcom.com>
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

Note: The patch differs from the upstream commit:
---
1:  47e55e4b410f7 ! 1:  49f13fedd5bc3 openvswitch: fix lockup on tx to unregistering netdev with carrier
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
| stable/linux-6.1.y        |  Success    |  Success   |

