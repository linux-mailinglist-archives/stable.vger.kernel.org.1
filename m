Return-Path: <stable+bounces-152431-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75DCDAD56DE
	for <lists+stable@lfdr.de>; Wed, 11 Jun 2025 15:24:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 365F017DA70
	for <lists+stable@lfdr.de>; Wed, 11 Jun 2025 13:24:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADF322882A5;
	Wed, 11 Jun 2025 13:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GFSQT3mk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DDD0283CBF
	for <stable@vger.kernel.org>; Wed, 11 Jun 2025 13:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749648276; cv=none; b=hv8FiSkLxUGibNuEzZVfYpIHxa8OjGGEu2Cyny+XSPClwuF/hNFonxsioB0J1Fb5KQ6FqIwxl28RY38U7SjS7ne+3/QElBalza87aNJTlTUXzgw3z6z1otYIEuRP+4X+TRPyuwEkZF/p0XHtwcFwfLCPQ//QNNBou5xKuKljHHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749648276; c=relaxed/simple;
	bh=8FiPvX05igtm22WPLOij5dz310sapdP+enat0A2LX8Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OSFifyixTJC3fuCQPfMJ7e55cBFD35r8rR7xLWzugRA5HpZWiwaFrWMcqqOstpCgmsGipsmb3ypfb52VJPQyISwCiPrTWKQnccPnnD6RWZlbXzqvyT0g3GSmv2TzgDmLdsCR6sSs2mGV4OajeG6CVC5xbs9zqNDZh1B2VqrKP7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GFSQT3mk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F32AC4CEEE;
	Wed, 11 Jun 2025 13:24:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749648275;
	bh=8FiPvX05igtm22WPLOij5dz310sapdP+enat0A2LX8Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GFSQT3mkFOnJJOKZRliz6uSAjDV6hwKXNJO3XALvqm3TgFpSDGfhFOrtCdp39o+kC
	 CQ7BDxTgAdsv0jtVBzyKGNQ6q425sdQ5ck8YahMKRuejrXZUqBxdKHlgc75ilCl+Il
	 OgFFuTfosXYSJqzqIWAsWX00wY3CsnFQ7+sW9wrBSVo5YeKa5b5K+k16Ba1igZRr42
	 LBTUpSf7cKjFceUdTjW1GmO+Gc/z5v3TmozvPfty4c97fxtIYuoQgvL+YvMgtC/yzW
	 sUmg6KGCaZNbg7qyOI0mleCpdOn9myfSGeg2Wy61AGzk//Fwkj3unOauBZvnlYw7H5
	 GyRqhkT0qNPPA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jeremy Kerr <jk@codeconstruct.com.au>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.6.y] net: make for_each_netdev_dump() a little more bug-proof
Date: Wed, 11 Jun 2025 09:24:34 -0400
Message-Id: <20250610135724-77a7a6a3ffb7350e@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250610-nl-dump-v1-1-2f05a5fa8358@codeconstruct.com.au>
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

The upstream commit SHA1 provided is correct: f22b4b55edb507a2b30981e133b66b642be4d13f

WARNING: Author mismatch between patch and upstream commit:
Backport author: Jeremy Kerr<jk@codeconstruct.com.au>
Commit author: Jakub Kicinski<kuba@kernel.org>

Status in newer kernel trees:
6.15.y | Present (exact SHA1)
6.14.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)

Note: The patch differs from the upstream commit:
---
1:  f22b4b55edb50 ! 1:  9d419b60cbfdf net: make for_each_netdev_dump() a little more bug-proof
    @@ Metadata
      ## Commit message ##
         net: make for_each_netdev_dump() a little more bug-proof
     
    +    commit f22b4b55edb507a2b30981e133b66b642be4d13f upstream.
    +
         I find the behavior of xa_for_each_start() slightly counter-intuitive.
         It doesn't end the iteration by making the index point after the last
         element. IOW calling xa_for_each_start() again after it "finished"
    @@ Commit message
         Signed-off-by: Jakub Kicinski <kuba@kernel.org>
         Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
         Signed-off-by: David S. Miller <davem@davemloft.net>
    +    Signed-off-by: Jeremy Kerr <jk@codeconstruct.com.au>
     
      ## include/linux/netdevice.h ##
    -@@ include/linux/netdevice.h: int call_netdevice_notifiers_info(unsigned long val,
    +@@ include/linux/netdevice.h: extern rwlock_t				dev_base_lock;		/* Device list lock */
      #define net_device_entry(lh)	list_entry(lh, struct net_device, dev_list)
      
      #define for_each_netdev_dump(net, d, ifindex)				\
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.6.y        |  Success    |  Success   |

