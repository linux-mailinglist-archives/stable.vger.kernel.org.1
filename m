Return-Path: <stable+bounces-164367-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BDF2B0E998
	for <lists+stable@lfdr.de>; Wed, 23 Jul 2025 06:33:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 559AD56323A
	for <lists+stable@lfdr.de>; Wed, 23 Jul 2025 04:33:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F50C149C7B;
	Wed, 23 Jul 2025 04:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="etNv9gvY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D53935464E
	for <stable@vger.kernel.org>; Wed, 23 Jul 2025 04:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753245220; cv=none; b=jIGc3W5V4Y1qRIPXzXcCUnPSL//2I3ehP7wK69Et+YGCAZ7NP7tr6fz3sLTB01Jk1GU3f8oxUnhcxk16A0trxC7TGisnMOXtLnZSOD5naPMkhSQA/HQCOf3xCdsPijocVDdl8Fgbk5duOrfjmABueKe7aHSlNk6CnNNcvJ4OakA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753245220; c=relaxed/simple;
	bh=VP3U7tw8U4v5Zm6VCbBAo/v1vrOuwaIevXG+rDK0O8g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DmFzN0orAtPHTtdx0Kr7nD8Bp/DIFBCRXKlC86Wa1ndxNDweehyOP71ip9LAvQ5guVEEJaD+JAA4NDTO8RHXy6/1ztzpbGUEuBwIVV9AEFvHIVqjp4LtQWCDj0v+1bonmcsSSZoyDJaPwkBzeq1Wz6ICnx6r9G26lb3lp60egeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=etNv9gvY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB052C4CEE7;
	Wed, 23 Jul 2025 04:33:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753245220;
	bh=VP3U7tw8U4v5Zm6VCbBAo/v1vrOuwaIevXG+rDK0O8g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=etNv9gvYC5EO/9aOYyNnODAH0htrlNnZVUFLM0RKEJnXniKH/5oPdzo6TEt9F1ZUK
	 E1FemTsj9x6KRg4jhEHJCAzlg87DNgsX9R+gCXutPkme7fFM42SEnPH19oD6By1Dmn
	 EMUGN9OKxFpX7urMdkHwL3ydk8RPYj+1BTXiomcLllIFmODe4jwedxfajaOQNBy8Bt
	 YJThvCdqgxesJWQvODee8v6SJVqcvZYxOEK462mcgRouY8e+2AxOr3EDpkR2L4M/rr
	 61K5a1qftwFMEdAR8fPKKJxgw7G0mQ4uS6xcGLBDx6HqWxZg5M8JzVDxnn11FVjVWW
	 y5UO7qijLD62Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.15.y] net: libwx: fix multicast packets received count
Date: Wed, 23 Jul 2025 00:33:37 -0400
Message-Id: <1753233710-fb85e40d@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <29E146077CD96A7C+20250722060931.8347-1-jiawenwu@trustnetic.com>
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

Note: The patch differs from the upstream commit:
---
1:  2b30a3d1ec25 ! 1:  6e1996610381 net: libwx: fix multicast packets received count
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
| origin/linux-6.15.y       | Success     | Success    |

