Return-Path: <stable+bounces-110417-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 24DBCA1BCFF
	for <lists+stable@lfdr.de>; Fri, 24 Jan 2025 20:52:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 772C9167C09
	for <lists+stable@lfdr.de>; Fri, 24 Jan 2025 19:52:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E1A52248B5;
	Fri, 24 Jan 2025 19:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MXLUkkiR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D6764A1D
	for <stable@vger.kernel.org>; Fri, 24 Jan 2025 19:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737748328; cv=none; b=KdpVAMBHffPO5uT1sLCx6JpnomWNS4tEr+LMCG98Ar0xUbOue5fmskAja9vgveSj5/jlImPzkzN0M5eM1BiN4Z2ItkIWmqKGjkfbS5qlMXX+t3i28zE9XfHd7KI81kFpz+CFcUEOSMDmDZZZs/JE9Si/96T+eHihPWL7YJmpUC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737748328; c=relaxed/simple;
	bh=t6A2UrewOadZeczOXQMHrEZX4uQGcwkjxQYBLjehYr4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lBLZ39MSSfff+bMhQiNpam/ZKqdqUwVWBS8+zo6idBMGabkAdNy3uDwL+H5rkaRxcmY1DWSiNf/ghTwSfEB+x32d+0etaLfJ0GL80f7VnUNcvfFGu1RlGwPq/0RDjDW6t3uq3weWPhqFGzT1D1xK05QjcGnSPv6ZcRbfPUu1qVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MXLUkkiR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2045CC4CED2;
	Fri, 24 Jan 2025 19:52:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737748327;
	bh=t6A2UrewOadZeczOXQMHrEZX4uQGcwkjxQYBLjehYr4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MXLUkkiRTWsi8Ph5+iMRnN8MRV4dJhWAf+D3WYiG3FjoIMxG93IuPxZYLFszPv/8a
	 EGy6myp4pgEVSBjDMW8VXBiP1asLhAz3QrEH68uvQbwB+jjxS5Q3Yeeh6fp94seswm
	 ZTDdyt/POjcKbwbzPve64ffBMAfIEDnvCx3BO2HSbmX24HgUr1B1ymt8yCAfOXe772
	 WsY0Jh7EhRd522Uf6KK60oXLpqhsQVR8QcSWlX1JrASkYz6hXZ6JSI8Ofd+OPN5MHO
	 qp3JxOBLORWotGJqjLDd3ZqKyB86ddZfaE8g7VGXvqwn/cfIFq0KLs+9JtE+hQhR6k
	 8oSe0GDr5g2pg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: alvalan9@foxmail.com,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.6.y] ipv4: ip_tunnel: Fix suspicious RCU usage warning in ip_tunnel_find()
Date: Fri, 24 Jan 2025 14:52:05 -0500
Message-Id: <20250124093942-02d16d7d0fa5d688@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <tencent_C84F430BAD560DD787812499B5130E0A4C06@qq.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[ Sasha's backport helper bot ]

Hi,

The upstream commit SHA1 provided is correct: 90e0569dd3d32f4f4d2ca691d3fa5a8a14a13c12

WARNING: Author mismatch between patch and upstream commit:
Backport author: alvalan9@foxmail.com
Commit author: Ido Schimmel<idosch@nvidia.com>


Status in newer kernel trees:
6.12.y | Present (exact SHA1)
6.6.y | Not found

Note: The patch differs from the upstream commit:
---
1:  90e0569dd3d32 ! 1:  265c5628cefe6 ipv4: ip_tunnel: Fix suspicious RCU usage warning in ip_tunnel_find()
    @@ Metadata
      ## Commit message ##
         ipv4: ip_tunnel: Fix suspicious RCU usage warning in ip_tunnel_find()
     
    +    commit 90e0569dd3d32f4f4d2ca691d3fa5a8a14a13c12 upstream.
    +
         The per-netns IP tunnel hash table is protected by the RTNL mutex and
         ip_tunnel_find() is only called from the control path where the mutex is
         taken.
    @@ Commit message
         Reviewed-by: Eric Dumazet <edumazet@google.com>
         Link: https://patch.msgid.link/20241023123009.749764-1-idosch@nvidia.com
         Signed-off-by: Jakub Kicinski <kuba@kernel.org>
    +    Signed-off-by: Alva Lan <alvalan9@foxmail.com>
     
      ## net/ipv4/ip_tunnel.c ##
     @@ net/ipv4/ip_tunnel.c: static struct ip_tunnel *ip_tunnel_find(struct ip_tunnel_net *itn,
    - 
    - 	ip_tunnel_flags_copy(flags, parms->i_flags);
    + 	struct ip_tunnel *t = NULL;
    + 	struct hlist_head *head = ip_bucket(itn, parms);
      
     -	hlist_for_each_entry_rcu(t, head, hash_node) {
     +	hlist_for_each_entry_rcu(t, head, hash_node, lockdep_rtnl_is_held()) {
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.6.y        |  Success    |  Success   |

