Return-Path: <stable+bounces-119796-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEF64A4750F
	for <lists+stable@lfdr.de>; Thu, 27 Feb 2025 06:09:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A416616AA5F
	for <lists+stable@lfdr.de>; Thu, 27 Feb 2025 05:08:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44ADD1E8341;
	Thu, 27 Feb 2025 05:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U/LAP5QD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 035A01E8336
	for <stable@vger.kernel.org>; Thu, 27 Feb 2025 05:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740632906; cv=none; b=OK11ok1WwivS4IriwfwHlIV/HCfeuwnCCZ7P4KJKVgoz/fmVI44VX9cj5pGc3ICBpldf9AuKEvbhT7B2Z2te1RmmbRb/OdvVKlkNs1bAK65yft1kuQRxETAebQ97Lms5AE8VuK11DmQ5ftL1x3V4BZP5QkkZSNeoTryAqPnBf/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740632906; c=relaxed/simple;
	bh=zyW+3Vh8iKDfKoqjHjZ4AdTJ2MSRyj6IQImcN7tAfPc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LCZc49STn40UPOG/j0rLmQZSVaZsgKNqRsk/D0xMikPSaVEssVVpuJcmQ7XwMxszka6Du1MdsFF6B1rXshb3aIokc6GASrV3CMKmkPla6J1xNcWpcdXDQhyZQWA78vNFeLfaV6G6pein00IwWa9ns9Ue1aZiouEGjsbWN1QHxUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U/LAP5QD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 880CAC4CEE5;
	Thu, 27 Feb 2025 05:08:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740632905;
	bh=zyW+3Vh8iKDfKoqjHjZ4AdTJ2MSRyj6IQImcN7tAfPc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=U/LAP5QDfZqogK6HrfKjMrs8q85FUXObkAYO0MjQrNFn2Uwzjp4G3S7QLqXkvqRTe
	 3lSsAKIRf/8+JbcLaKvlP0hStWMWZhBUG1Gj0kVgc+NunB9OcafWgbP2Yv823sMrpH
	 tD9r7vpj3xBGORfaL5bEblCRRcZZnirbpFBJMoWl/9dALalPS72HgEXQm8ojgxy3U0
	 kd+5Zr3B8vZ0mukCi9FSiR1exVbj8+sxNDPa+h97zsQSjgTXR+WYU2YYRqjvbKfUqu
	 a7LImqCOaAIqChJcOIpU0kQW5Q+byy1WtAR66ZjDf00f39ibFSIeTrnCfo+lvQb2uG
	 1iimdl5aYt0sA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?utf-8?q?Ricardo_Ca=C3=B1uelo_Navarro?= <rcn@igalia.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.6 v3 3/3] tun: Add missing bpf_net_ctx_clear() in do_xdp_generic()
Date: Thu, 27 Feb 2025 00:08:24 -0500
Message-Id: <20250226154300-244b0b8a28dc49ee@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250226-20250204-kasan-slab-use-after-free-read-in-dev_map_enqueue__submit-v3-3-360efec441ba@igalia.com>
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

The upstream commit SHA1 provided is correct: 9da49aa80d686582bc3a027112a30484c9be6b6e

WARNING: Author mismatch between patch and upstream commit:
Backport author: =?utf-8?q?Ricardo_Ca=C3=B1uelo_Navarro?=<rcn@igalia.com>
Commit author: Jeongjun Park<aha310510@gmail.com>

Note: The patch differs from the upstream commit:
---
1:  9da49aa80d686 ! 1:  f295380a77d57 tun: Add missing bpf_net_ctx_clear() in do_xdp_generic()
    @@ Metadata
      ## Commit message ##
         tun: Add missing bpf_net_ctx_clear() in do_xdp_generic()
     
    +    [ Upstream commit 9da49aa80d686582bc3a027112a30484c9be6b6e ]
    +
         There are cases where do_xdp_generic returns bpf_net_context without
         clearing it. This causes various memory corruptions, so the missing
         bpf_net_ctx_clear must be added.
    @@ Commit message
         Reported-by: syzbot+61a1cfc2b6632363d319@syzkaller.appspotmail.com
         Reported-by: syzbot+709e4c85c904bcd62735@syzkaller.appspotmail.com
         Signed-off-by: David S. Miller <davem@davemloft.net>
    +    [rcn: trivial backport edit to adapt the patch context.]
    +    Signed-off-by: Ricardo Cañuelo Navarro <rcn@igalia.com>
     
      ## net/core/dev.c ##
    -@@ net/core/dev.c: int do_xdp_generic(struct bpf_prog *xdp_prog, struct sk_buff **pskb)
    +@@ net/core/dev.c: int do_xdp_generic(struct bpf_prog *xdp_prog, struct sk_buff *skb)
      			bpf_net_ctx_clear(bpf_net_ctx);
      			return XDP_DROP;
      		}
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.6.y        |  Success    |  Success   |

