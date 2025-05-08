Return-Path: <stable+bounces-142881-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 462B9AB000F
	for <lists+stable@lfdr.de>; Thu,  8 May 2025 18:17:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCAFB5047E2
	for <lists+stable@lfdr.de>; Thu,  8 May 2025 16:17:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 266B527CCF2;
	Thu,  8 May 2025 16:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R4RN0lKg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9E8D22422D
	for <stable@vger.kernel.org>; Thu,  8 May 2025 16:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746721060; cv=none; b=oBgSMVME7RIGPJkJ2HipBWNmTVz9DAHLFdHbx4DVl4HLKZojiOw/Xqtc+Tn6LDzzazvSjy5jLWeBy4pXI6KuNdL1QunQGWKQ305H9gKbgfuF6Zx6/z3MmL6q8EZEpDCGScRGbqvVaoTjkMB4nk/hAdlWWxEoh7HmSF9j8IhuNJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746721060; c=relaxed/simple;
	bh=YOUwGxgQ1RQ6m1ukwFIsnOL/XU6m8EpEIsLs7lqXas8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k+SyMwtLVEYfloTJmtfNlcC5hygVaq2gLxhXX+JSVZL3ly1MUfAaSrWECLlrb3GzpR4AS+OpRNr7c7Zj3c1+6u2OOsTkzf95Mum9cC2nmumnK/MhQscBC/NkEjJk08rJ44KMOLi3B7rmT/COZ6xkoKZOcgJwhTQqbP0xYVRZi9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R4RN0lKg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D582CC4CEE7;
	Thu,  8 May 2025 16:17:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746721060;
	bh=YOUwGxgQ1RQ6m1ukwFIsnOL/XU6m8EpEIsLs7lqXas8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=R4RN0lKgt94p7wNhLVcpWnUn/2Dm4kbpfkFm/AofVrtST2X9cCPr5mgEz2iY23KIo
	 yDA1J6F380PcAwKDNJuGONXk+fGWn1rFg+VGjX640IvZuykdOpJVElJwmmcqfuCKOs
	 J3Vg9G7y8C6mFG5qOvO0qMGf1vUmYmfQJhQdpHqPYzis5yIP1mW57LGJc+fNHp3QNC
	 SMJ2BUNDMHhwAsjui3IuAfnfs8dXeYABEPifEnkFIVCBxPvUEo0hWZKertn4lKCQK3
	 P3gxeFZinX+TMgmfLDGmsGL6P/ztNXXFaKqs/TzR8lOnJmg0psxUYzeLHHLs1Awn9G
	 G6sDTmhVZuiXg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jared Holzman <jholzman@nvidia.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.14.y v2 1/7] ublk: add helper of ublk_need_map_io()
Date: Thu,  8 May 2025 12:17:35 -0400
Message-Id: <20250507083616-34c4792d26460f57@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250507094702.73459-2-jholzman@nvidia.com>
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

The upstream commit SHA1 provided is correct: 1d781c0de08c0b35948ad4aaf609a4cc9995d9f6

WARNING: Author mismatch between patch and upstream commit:
Backport author: Jared Holzman<jholzman@nvidia.com>
Commit author: Ming Lei<ming.lei@redhat.com>

Note: The patch differs from the upstream commit:
---
1:  1d781c0de08c0 ! 1:  d1a8c330d5052 ublk: add helper of ublk_need_map_io()
    @@ Metadata
      ## Commit message ##
         ublk: add helper of ublk_need_map_io()
     
    +    [ Upstream commit 1d781c0de08c0b35948ad4aaf609a4cc9995d9f6 ]
    +
         ublk_need_map_io() is more readable.
     
         Reviewed-by: Caleb Sander Mateos <csander@purestorage.com>
    @@ Commit message
     
      ## drivers/block/ublk_drv.c ##
     @@ drivers/block/ublk_drv.c: static inline bool ublk_support_user_copy(const struct ublk_queue *ubq)
    - 	return ubq->flags & (UBLK_F_USER_COPY | UBLK_F_SUPPORT_ZERO_COPY);
    + 	return ubq->flags & UBLK_F_USER_COPY;
      }
      
     +static inline bool ublk_need_map_io(const struct ublk_queue *ubq)
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.14.y       |  Success    |  Success   |

