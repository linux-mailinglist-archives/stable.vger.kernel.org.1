Return-Path: <stable+bounces-135266-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 85B73A98974
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 14:16:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C68DA167CA3
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 12:16:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 353811E7C06;
	Wed, 23 Apr 2025 12:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Juoa7JON"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8F961119A
	for <stable@vger.kernel.org>; Wed, 23 Apr 2025 12:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745410608; cv=none; b=RxdlvQ0wcYusa62ogevB+OGBnUBEBZM2JxU1JZuZYcLHJE1RyIJFtfTMxKTMMarE+/CzB+fShxGuM3rv0WzthnmKErqY31MgSvSBRd6vjYvbztb6i+hNJOnBg5fDSPYQuB8+OoDLDZokOJe316KDZc50MPnDdPOVi8bQncniabY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745410608; c=relaxed/simple;
	bh=5KzNyiqAOu4Q+nMvAaRmdof5cvZ9nkbDI505ytuZJcU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KLuIk7HdZthzsPLGg/SPqfbBUsvE8VOD9HNM2EymerxGw+pAnrQ85MsP7brwAjntiCFc8U8jN6PaWiccmvLZ9RMWYUlBKDwtiqdsNV8fT5ibp4Qb1gqxSBU1rF/EIoJ1OyjAQnBF7Oay61XMvRW7tmW5qEaCcdU5Mo7DqXm0JE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Juoa7JON; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F203CC4CEE2;
	Wed, 23 Apr 2025 12:16:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745410607;
	bh=5KzNyiqAOu4Q+nMvAaRmdof5cvZ9nkbDI505ytuZJcU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Juoa7JONboi5CXe19GP/zg5AyvJQm5afsgN5GGVRM7dBU+CeAX2rxYtrEw6MOMIrw
	 RHGyRO/9ieXlZSugOJFFP9dyleLQ9QP89Vjft6LIzAmeTkn9/kyE3x/vbxOoU+T8H4
	 Ps4VmgdjK9/2aLb72cPsgIsbSEKXL7Gm9rP0ZWpnxHht8hmKpALH4kq2IsOPxMrpJ0
	 hlvhNeVZuqWediV8hcWnYltTcZOmRP6Q0kwDVt0jQPrW/xLGxtiLAL0BdIQJe4q+XV
	 VNWV3Y76jP6dGoNEcSnSr/uMNRTF/kD07GLDDKs7lARSOZKFtW6Hr7MH2wWi6q5irs
	 vwnlxWZ+uzVLw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Shung-Hsi Yu <shung-hsi.yu@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH stable 6.12 5/8] selftests/bpf: freplace tests for tracking of changes_packet_data
Date: Wed, 23 Apr 2025 08:16:45 -0400
Message-Id: <20250423080516-b5b3c9350a55e118@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250423055334.52791-6-shung-hsi.yu@suse.com>
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

The upstream commit SHA1 provided is correct: 89ff40890d8f12a7d7e93fb602cc27562f3834f0

WARNING: Author mismatch between patch and upstream commit:
Backport author: Shung-Hsi Yu<shung-hsi.yu@suse.com>
Commit author: Eduard Zingerman<eddyz87@gmail.com>

Status in newer kernel trees:
6.14.y | Present (exact SHA1)

Note: The patch differs from the upstream commit:
---
1:  89ff40890d8f1 ! 1:  d360bdf6bf2cc selftests/bpf: freplace tests for tracking of changes_packet_data
    @@ Metadata
      ## Commit message ##
         selftests/bpf: freplace tests for tracking of changes_packet_data
     
    +    commit 89ff40890d8f12a7d7e93fb602cc27562f3834f0 upstream.
    +
         Try different combinations of global functions replacement:
         - replace function that changes packet data with one that doesn't;
         - replace function that changes packet data with one that does;
    @@ Commit message
         Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
         Link: https://lore.kernel.org/r/20241210041100.1898468-7-eddyz87@gmail.com
         Signed-off-by: Alexei Starovoitov <ast@kernel.org>
    +    Signed-off-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
     
      ## tools/testing/selftests/bpf/prog_tests/changes_pkt_data.c (new) ##
     @@
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.14.y       |  Success    |  Success   |

