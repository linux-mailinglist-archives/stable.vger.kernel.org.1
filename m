Return-Path: <stable+bounces-111926-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E003EA24C3A
	for <lists+stable@lfdr.de>; Sun,  2 Feb 2025 00:53:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8193F1884D59
	for <lists+stable@lfdr.de>; Sat,  1 Feb 2025 23:53:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59EBD155393;
	Sat,  1 Feb 2025 23:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RmB74imE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19126126F1E
	for <stable@vger.kernel.org>; Sat,  1 Feb 2025 23:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738454032; cv=none; b=HbkmMp+UAAkJkp1lrVxC4feMSqet99wfFjYtLxuzcQzIk6C2pcgC9JDtyhBQdUn5p4WZujRorg1nMfwv1Sj1GT9BqbRpHOaSjqBVyqGwERwxzWYsiitUqwnFETrPal6NOiFFAjtAgixTaqPIqC+b0eTs3TiveHoOJ5wnv3VTuII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738454032; c=relaxed/simple;
	bh=tQwl2kO8Hb0rOUBl+s6zhMADbzYUe2kCdc2oFSqQlAo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tFj4BpduneGLE5NuFyaTWL9h01kHX9UEAsjV533i990PnnwoeCHO/XoV5CAAWs033uHgOy4Nkh4QK/6vQlYMTUKI40bEMSD8ZWmGN11k/MrRq3IBhUt5VJW3To/2hgN/qT/CDnsCZsCKKueVtptOuEhY20p2jARJGnXdovw5tOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RmB74imE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83A5FC4CED3;
	Sat,  1 Feb 2025 23:53:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738454032;
	bh=tQwl2kO8Hb0rOUBl+s6zhMADbzYUe2kCdc2oFSqQlAo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RmB74imEDdZOGb5AhZ/7Irh/lGeP4RsDeLeUbh7KO5lpTVyclDIIPZWN52upCArpT
	 t2LToCw5WjDrfyiyJE/UlmAhxe0ZzKKZaCGH8WxLaAY4T0vdVEgrDKmgJj4ud82BMp
	 CWji5lhoKlcTYTi8FBkWsDc4vQRHEavgRHv5W27T1TqJauKyFY9Bw9kedolfeynr6v
	 Xh0c8Da3oFhf4TtarBwHNRHrzMbfxO74nQtgyOaJrmMNIEFWXo6P4QUlvEi9kX4+Wx
	 Ues685QiHyuKMQkq3+HwJjjZJePrYVVYoKCAZ7W7vUHkAB50cZeoHTIgBlfucSd0X8
	 Hmh/0bPni+bFA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Leah Rumancik <leah.rumancik@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1 11/19] xfs: abort intent items when recovery intents fail
Date: Sat,  1 Feb 2025 18:53:50 -0500
Message-Id: <20250201142300-0efffe3154bfd67e@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250129184717.80816-12-leah.rumancik@gmail.com>
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

The upstream commit SHA1 provided is correct: f8f9d952e42dd49ae534f61f2fa7ca0876cb9848

WARNING: Author mismatch between patch and upstream commit:
Backport author: Leah Rumancik<leah.rumancik@gmail.com>
Commit author: Long Li<leo.lilong@huawei.com>


Status in newer kernel trees:
6.13.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (different SHA1: 005be6684225)
6.1.y | Present (different SHA1: 6beaebf68934)

Note: The patch differs from the upstream commit:
---
1:  f8f9d952e42dd ! 1:  7e1e53b9da92c xfs: abort intent items when recovery intents fail
    @@ Metadata
      ## Commit message ##
         xfs: abort intent items when recovery intents fail
     
    +    [ Upstream commit f8f9d952e42dd49ae534f61f2fa7ca0876cb9848 ]
    +
         When recovering intents, we capture newly created intent items as part of
         committing recovered intent items.  If intent recovery fails at a later
         point, we forget to remove those newly created intent items from the AIL
    @@ Commit message
         Signed-off-by: Long Li <leo.lilong@huawei.com>
         Reviewed-by: Darrick J. Wong <djwong@kernel.org>
         Signed-off-by: Chandan Babu R <chandanbabu@kernel.org>
    +    Signed-off-by: Leah Rumancik <leah.rumancik@gmail.com>
     
      ## fs/xfs/libxfs/xfs_defer.c ##
     @@ fs/xfs/libxfs/xfs_defer.c: xfs_defer_ops_capture(
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

