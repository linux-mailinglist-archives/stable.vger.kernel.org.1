Return-Path: <stable+bounces-126660-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 68DC5A70EEE
	for <lists+stable@lfdr.de>; Wed, 26 Mar 2025 03:23:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 495F6189A5CF
	for <lists+stable@lfdr.de>; Wed, 26 Mar 2025 02:23:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AA0E13633F;
	Wed, 26 Mar 2025 02:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QAcsrK7B"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE5D5137775
	for <stable@vger.kernel.org>; Wed, 26 Mar 2025 02:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742955818; cv=none; b=UYCzlY8lgF1dGBkQWbWYeSYMILBD0WVPr418OmHGbx/HlY/VH7IaUhF+5Tw1fpz6TvFovpYlvkBojOnSSy1z7DgGMeXYeFwFmiDZhIcCyF0mGaHZHwR4YMGIBr4A3pae+sPLdpquVeJIeUCH518Pm/7gK9y0x8egFbhTENVI60w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742955818; c=relaxed/simple;
	bh=dRJbsN7v2/2w2TbXwftpLqgMZW5kp0WNah0NFEbeOeA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VUB3HSvJDYP7/t/rFKdcpYmHmLAi4EZeZqV/B8aWLc9/MyMSJXs3+wIC+9Plo14lP4X05tl919+Qw+c1pjen5Nz1TCeqfGz5KUlmGmmOlh+aI7jLuk364PK5OYEkV7/H3Mz5HSCKwE+yi1MgL70EhK5CSv4CMWLxAtVMR2y/OlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QAcsrK7B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED9D2C4CEE4;
	Wed, 26 Mar 2025 02:23:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742955817;
	bh=dRJbsN7v2/2w2TbXwftpLqgMZW5kp0WNah0NFEbeOeA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QAcsrK7B+Wdue6RBzfUkPW9NHkt5CUQDTLXXt8ZJTgp/q5DKrrmYGEX5Uzv1idVvl
	 FHc+QjJfdHnSahx/2Mn4vezt7CTjnLRcP8F506acpsYnlXUZ3wKOAhOJrInBiGq/8r
	 uxoRFAunvhvd5QWbvneCIvQuYSnxu7LCk2/XJElTLmKvaDo8G+SZp9+2CJzrLvI0M/
	 Lo/8JCTYsqKotkvMHEF9lGvgK2w8l5yDHZuWfyGBf8bO8zjkrVpFJUTo3Yqj3bjHru
	 fB50eIvx3gpOmh8PPgf/v7itas4LXLQJEIRAyeGylySfkH8M1BltbasH2ITN2P48N9
	 zxgRrghlVBGpQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	florian.fainelli@broadcom.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH stable 5.4 v2 2/2] openvswitch: fix lockup on tx to unregistering netdev with carrier
Date: Tue, 25 Mar 2025 22:23:35 -0400
Message-Id: <20250325214412-788099d451e95300@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250325192220.1849902-3-florian.fainelli@broadcom.com>
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
5.10.y | Not found

Note: The patch differs from the upstream commit:
---
1:  47e55e4b410f7 ! 1:  9a82976cb1dc6 openvswitch: fix lockup on tx to unregistering netdev with carrier
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
| stable/linux-5.10.y       |  Success    |  Success   |

