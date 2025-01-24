Return-Path: <stable+bounces-110413-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 82432A1BCFB
	for <lists+stable@lfdr.de>; Fri, 24 Jan 2025 20:52:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BB9D3A747B
	for <lists+stable@lfdr.de>; Fri, 24 Jan 2025 19:51:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C6482248AC;
	Fri, 24 Jan 2025 19:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gGKUy17c"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFFAC4A1D
	for <stable@vger.kernel.org>; Fri, 24 Jan 2025 19:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737748319; cv=none; b=Bh505biPa97icBWEPjAB3UTvdzkLcMH/XDcdoAv0MCVneBaifd7ge/Z/+JlgmCLXzkGCiULyxPGq0Sw/2lvb0D/m6ey2asRgZvK7T5RleVmifbzy8ZbuRGA6MgXKElsF7Gj63Wj1BDL1el3uWqPshKpggsu41GOun1Hl8Ae8ORI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737748319; c=relaxed/simple;
	bh=xCMENtct/PYOYFm9zUYSUEddDuZ6VlZ+Lw0PWeZCMaE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mpgj1hxXGMyly2hSfifUGj87ZvWdwbDFT7Vq5mfGno7eTCPr2kqS7fygUpAGCOBVBS/WksSqN3JzkEJ7oLvOB78cPi4xkylRmQudRuhLtjqJkdO/aMLO4i25O31rfFMiAwEG20tVYV6E5tbQhgFQoL41X/o1A3aSNWt2FYnuN6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gGKUy17c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCD56C4CED2;
	Fri, 24 Jan 2025 19:51:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737748319;
	bh=xCMENtct/PYOYFm9zUYSUEddDuZ6VlZ+Lw0PWeZCMaE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gGKUy17c+exqg5mG2NedfTzO3l/CGg6Y8nAiRYkxODoFH4mRvUwv9nST3fvn2b1Fr
	 gAcwMds5yjL1iQ4dX3DmKUW2B+o0lZF6RQcZnv9EiKPY7XM6tuHxhqTg4Knte2NN1U
	 ugUW+7OKJvsltPHDPIrHRdRrv3vU5cjPMJDHivX6sUWfVZL7XQsdafprJoUKVu36HB
	 l2CVdWwIR6RyzAfa4aIOOZ5WOM9IkRT5/Vj0P8EbIHKlDv4yBP3KEhNYBqXoD1O5Vz
	 Yl3GOMxNj59EY3Pabdsn4etAFaLNpyalhtuaFz3lHKCiWHnOHU31sxpYjzIPIqM3Kt
	 Fo+FdTDDrLD9Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: alvalan9@foxmail.com,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1.y] ipv4: ip_tunnel: Fix suspicious RCU usage warning in ip_tunnel_find()
Date: Fri, 24 Jan 2025 14:51:57 -0500
Message-Id: <20250124095217-9cacdf5352ae663a@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <tencent_998136A306E5834F52C53A0B6701A6AFE105@qq.com>
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
6.1.y | Not found

Note: The patch differs from the upstream commit:
---
1:  90e0569dd3d32 ! 1:  2111fb1f7a15e ipv4: ip_tunnel: Fix suspicious RCU usage warning in ip_tunnel_find()
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
| stable/linux-6.1.y        |  Success    |  Success   |

