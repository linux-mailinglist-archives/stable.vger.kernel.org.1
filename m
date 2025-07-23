Return-Path: <stable+bounces-164379-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C682B0E9A4
	for <lists+stable@lfdr.de>; Wed, 23 Jul 2025 06:34:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44FBD6C6A0F
	for <lists+stable@lfdr.de>; Wed, 23 Jul 2025 04:33:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F988149C7B;
	Wed, 23 Jul 2025 04:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RysOeUaS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 117992AE72
	for <stable@vger.kernel.org>; Wed, 23 Jul 2025 04:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753245256; cv=none; b=KOiEh/5Th9kYdwymkTtvZeH/tD7CJlN+b7ah3/zZ8ptEj3sJvdk1nEkiFCJuPn83ULE2RZ7W6hRDoFCbu7rh8YIuk4gJ1AUMDu1sAhqO/Y6YUkgCPru2ZsIvAbNuBW5SD0PsjzVhE5+vzigTQgKZSHg6TdQ7W49sL2y+CDbfi0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753245256; c=relaxed/simple;
	bh=TyNierDIewoAlUpS5/vPiiw+wCdv6YWsCCqROqPnYQg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Om2Z2ohlcv7XzxRj1+zx2OwIUMmtTj2SJ0OXWrkDeVOu8Yt/5sE+k1gbhgI9q78UPhdMgvJf8HIdlqgHfoeSx78f00sFnAyLxPoRa+piKapYJ6jXYXW8x1PN+yBAFE4sfNTWDekn0Jqsb1rdkE018lE5nze6P1jaWu6hR3lnzpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RysOeUaS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60ED8C4CEE7;
	Wed, 23 Jul 2025 04:34:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753245255;
	bh=TyNierDIewoAlUpS5/vPiiw+wCdv6YWsCCqROqPnYQg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RysOeUaSCkOJW0ZWOgHRyUqHtjNSV2qGTBlBhOqfKZ+G2tvG8voax59gBoTUBUIpD
	 fb60gIy3+fq8A45A9lwCpmIScr+aW/ZV/K6LRnCU2ZFbFJLGoJpk6sx/YWFxj+Ymuo
	 5BDmek6zM1H/+wqdcY6G7hS2Q0vyasp7qh7kbGWtc4B9u4OPfCf32ZTOizvxhM39qy
	 FPoJjkYKXoLR/QfwMaQFmupAkUr7giruiHIfHws2dt4Jihfn/iS/RuZjRCk8+9Gw8T
	 l5kM9SrUrkuvBgLRkyyMdEPEVJ9CMr/ZWK33HHOlLtxIuCxPG9d5xj5PtN9gnTB7tl
	 ADgAh+4xwpuJA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.15.y] net: libwx: fix multicast packets received count
Date: Wed, 23 Jul 2025 00:34:13 -0400
Message-Id: <1753234261-7c2fdb16@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <528914E284765D4D+20250722020129.3432-1-jiawenwu@trustnetic.com>
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

Found matching upstream commit: 2b30a3d1ec2538a1fd363fde746b9fe1d38abc77

Note: The patch differs from the upstream commit:
---
1:  2b30a3d1ec25 ! 1:  100b7758b764 net: libwx: fix multicast packets received count
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
| origin/linux-6.15.y       | Success     | Success    |

