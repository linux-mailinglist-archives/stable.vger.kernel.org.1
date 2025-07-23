Return-Path: <stable+bounces-164373-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B590EB0E99E
	for <lists+stable@lfdr.de>; Wed, 23 Jul 2025 06:34:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97E471C852FA
	for <lists+stable@lfdr.de>; Wed, 23 Jul 2025 04:34:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 928B9149C7B;
	Wed, 23 Jul 2025 04:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K9eNMA5W"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 521BD2AE72
	for <stable@vger.kernel.org>; Wed, 23 Jul 2025 04:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753245238; cv=none; b=hWCjPsG0/AZTDA+geSe/+74i5IdJeUia7DEqTtrElBDqmcAzEfjHZRRPjVeh5E4QBF69PMcC9OiBBV+aePMM+mW51WRbmo0KILpXS6iuDZ9cd9sE+m8QgIMA/jLKmg0v5ZkJC1VVNwqsTcdVm7FGMQEdWnkiC9dnOHVmOTZD+No=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753245238; c=relaxed/simple;
	bh=dUbrXWb0IALsWZVPsF8h9oqqjnH10wDvO5kHDjP9rDw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZkMHwG5obOUMb1idg0hT48uytIrFeAdy5cWFCTmq+XkRmltjHzf2m52m6AGmkGgKyIqUwLI1XDpbXEBxLkZZMQu+G1hZ0URFeEL20DVBBSrPe5PYROiAw/wOZiqsWjCe4wMJVN5B49xivUsSD2/hlxEyGIDDAeXnpWTZHF4YPdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K9eNMA5W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C5A8C4CEE7;
	Wed, 23 Jul 2025 04:33:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753245237;
	bh=dUbrXWb0IALsWZVPsF8h9oqqjnH10wDvO5kHDjP9rDw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=K9eNMA5W4Ixsj6/w//3SYDM3l5yTsunHhvhu480XXhKLI1Pm17rFRqm08DqtcS92W
	 2IyZXQv56zimxfbFQoOoEnj9NxCUAul29Y3umeGfQaAlQOGmdJymGvAkMpEsmdI8Ai
	 563gfw36unYyeUZ22fnj4SVPxZm333ibiSxU+Mci+Br2GMCN/ExyI24pliUjRwtPnL
	 gFZA0nsX2+ItrzJ3MEGTca8Ui1FOj5bsEYzwmKDoIfuXUpdlkihrHE1Rv74kATjOr+
	 RC0LWUS/GFXC7Z8t85TqCIH4Xhgdt9HWLauEdPijtyy8RVzUA0xfv34W7zTvqF7cin
	 Nv1x6FWRUetpw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.12.y] net: libwx: fix multicast packets received count
Date: Wed, 23 Jul 2025 00:33:55 -0400
Message-Id: <1753233976-6f7d2840@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <1FD2A049AA18CEF9+20250722060854.8327-1-jiawenwu@trustnetic.com>
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

The upstream commit SHA1 provided is correct: 2b30a3d1ec2538a1fd363fde746b9fe1d38abc77

Status in newer kernel trees:
6.15.y | Not found

Note: The patch differs from the upstream commit:
---
1:  2b30a3d1ec25 ! 1:  b062f4861662 net: libwx: fix multicast packets received count
    @@ Metadata
      ## Commit message ##
         net: libwx: fix multicast packets received count
     
    +    commit 2b30a3d1ec2538a1fd363fde746b9fe1d38abc77 upstream.
    +
         Multicast good packets received by PF rings that pass ethternet MAC
         address filtering are counted for rtnl_link_stats64.multicast. The
         counter is not cleared on read. Fix the duplicate counting on updating
    @@ drivers/net/ethernet/wangxun/libwx/wx_hw.c: void wx_update_stats(struct wx *wx)
      
     +	/* qmprc is not cleared on read, manual reset it */
     +	hwstats->qmprc = 0;
    - 	for (i = wx->num_vfs * wx->num_rx_queues_per_pool;
    - 	     i < wx->mac.max_rx_queues; i++)
    + 	for (i = 0; i < wx->mac.max_rx_queues; i++)
      		hwstats->qmprc += rd32(wx, WX_PX_MPRC(i));
    + }

---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| origin/linux-6.12.y       | Success     | Success    |

