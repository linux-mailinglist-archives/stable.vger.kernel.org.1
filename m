Return-Path: <stable+bounces-111925-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9841EA24C39
	for <lists+stable@lfdr.de>; Sun,  2 Feb 2025 00:53:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82D4C3A4917
	for <lists+stable@lfdr.de>; Sat,  1 Feb 2025 23:53:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 596C61CDA09;
	Sat,  1 Feb 2025 23:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hMw95Ns1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18B841534FB
	for <stable@vger.kernel.org>; Sat,  1 Feb 2025 23:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738454030; cv=none; b=DfJvuVeKWyPhuLUZpQ0bPaENiKrNetjUFar91sQx66Nhr3+klQeKGRsZHFy9iQCaqkaqj5VGtAn4QgVLxBiuX+1BMRT7YGEJXw8ejO70ACGmGYtE4WnGMP13x2TtlvqE7GMrL3fxeR3QAD/qQVqo0LREfyATEJSr8jSH6fPQIkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738454030; c=relaxed/simple;
	bh=iqiwXhJNbeNj4TzyDMtd2GTBR3mes5MMeuJPuWiiwLY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uPXe5Hi0Cdx+eQO2L5WHv7qG8ygWXEUpv0LUpGM8D8i+/rSU3L8TGup6N+37WvU55SF7dJBwgemKT9aZZateQO6zLZcCzv0rb9WmDzDzUu6AwSYlXEcxMprYwxFuaIfKxBjMDUxqZUSDPb93tz5E0elM3TwM/I+EI2JEi3nfeBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hMw95Ns1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79B70C4CED3;
	Sat,  1 Feb 2025 23:53:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738454029;
	bh=iqiwXhJNbeNj4TzyDMtd2GTBR3mes5MMeuJPuWiiwLY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hMw95Ns1cTJInGal8JIAktcuY7PMtBzj6fiEVMukmWwzDm5rcrExU1/3546n5IBmZ
	 Sqz+biboLRIoPLIG5/5AxJCWqkcu0Y1U1uwNZRmf4pctevvxPHbmEwxyEOcYyixQV9
	 w4lK7LCIS5oNsUgWY08w/FafLHsFEY+XdG+0kv9fJLapVbVetladESWrDesBtIrC9d
	 A20m2AaBERBCNabVO5yis61KYk0OvQW6LFKhPI/mkEL0oASMV3ybt+HKbUkJDp6SVT
	 ha2ZNZ1ZO+fIWxPpt++6t5irR6d4rNvM5X6mkImfQrWCL2ud/y6dCLXO/TeMvOs1+C
	 UcdTDYf82Fsmw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Leah Rumancik <leah.rumancik@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1 03/19] xfs: prevent rt growfs when quota is enabled
Date: Sat,  1 Feb 2025 18:53:48 -0500
Message-Id: <20250201132136-18723c9df774f647@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250129184717.80816-4-leah.rumancik@gmail.com>
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

The upstream commit SHA1 provided is correct: b73494fa9a304ab95b59f07845e8d7d36e4d23e0

WARNING: Author mismatch between patch and upstream commit:
Backport author: Leah Rumancik<leah.rumancik@gmail.com>
Commit author: Darrick J. Wong<djwong@kernel.org>


Status in newer kernel trees:
6.13.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (different SHA1: 6a6bb41b31df)
6.1.y | Present (different SHA1: a68e3ff6bba2)

Note: The patch differs from the upstream commit:
---
1:  b73494fa9a304 ! 1:  e2ad9605027dd xfs: prevent rt growfs when quota is enabled
    @@ Metadata
      ## Commit message ##
         xfs: prevent rt growfs when quota is enabled
     
    +    [ Upstream commit b73494fa9a304ab95b59f07845e8d7d36e4d23e0 ]
    +
         Quotas aren't (yet) supported with realtime, so we shouldn't allow
         userspace to set up a realtime section when quotas are enabled, even if
         they attached one via mount options.  IOWS, you shouldn't be able to do:
    @@ Commit message
     
         Signed-off-by: Darrick J. Wong <djwong@kernel.org>
         Reviewed-by: Christoph Hellwig <hch@lst.de>
    +    Signed-off-by: Leah Rumancik <leah.rumancik@gmail.com>
     
      ## fs/xfs/xfs_rtalloc.c ##
     @@ fs/xfs/xfs_rtalloc.c: xfs_growfs_rt(
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

