Return-Path: <stable+bounces-111935-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 82CA4A24C43
	for <lists+stable@lfdr.de>; Sun,  2 Feb 2025 00:54:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 075DA163AE2
	for <lists+stable@lfdr.de>; Sat,  1 Feb 2025 23:54:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A4A91CC881;
	Sat,  1 Feb 2025 23:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bxWv8LCc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4985C126F1E
	for <stable@vger.kernel.org>; Sat,  1 Feb 2025 23:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738454050; cv=none; b=i3V6fhW3d9UUCdJWRfw2p11f7FKsJ7PHNxCCq8ulIvCn6noLGqt1nLLxdhCZWGGRWlUZphl9CTXVW5kNCFeg4sxIfzhYFJqfskk0sqIutY2RKcmyFrPWihLtrEEIWRzNzElQClEF+eefAQUTPScbycrISqiF7E6YxKrWKKI+SJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738454050; c=relaxed/simple;
	bh=q1yR1cxZguDyp5pQf6aLQC3wR4U/ZOqGD9PnGBgTuZk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lgJ8JH0WMtJtOkIV3Q3NFyNL4Jz9zKl/T0nf5vCs5iZDiP2O/3isoWV5uvBcF5aSL0u+Pi/2k1uBrcq33iyjrLadfvJpR+cdCPJHK4/a3YXve97I6y2a9xMIf2WzEhNIGRs++dc+N/bWYn50T7Rqu8wAJcu5oTT1lPVxMDW1U3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bxWv8LCc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5A7DC4CED3;
	Sat,  1 Feb 2025 23:54:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738454050;
	bh=q1yR1cxZguDyp5pQf6aLQC3wR4U/ZOqGD9PnGBgTuZk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bxWv8LCcm41XnWZEhrhwG+htRsx4EiW8PoDrM+c5Puvh9+6gd4XMCWMlShcom5Ik2
	 hay2rHWKT55bXj/goqgbVj0bOb0fNsEHnwKuR67OcJ2ukQX06EqEhxnO9fVde7x65D
	 siE3nPftW7XkeGDupTsy9guSTNvpdAq2k3gMFw4yakwhIz4DynJpDt3bTg5Mj5MznK
	 CcVbtYmjjvWX7o/x8sw7CeizSi6yOftfTSLQfSJLfb5cGT/7jAz+JrXii5cV7hwb4R
	 7N3eRv9xPZesYnnH2S/FtSlfm0AN8JVQvnYo4OG+J8kuOT5CY1B6o4b/fv+DXQlhJ/
	 baCa5QrL9gF+Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Leah Rumancik <leah.rumancik@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1 13/19] xfs: up(ic_sema) if flushing data device fails
Date: Sat,  1 Feb 2025 18:54:08 -0500
Message-Id: <20250201143638-beeba297671f2964@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250129184717.80816-14-leah.rumancik@gmail.com>
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

The upstream commit SHA1 provided is correct: 471de20303dda0b67981e06d59cc6c4a83fd2a3c


Status in newer kernel trees:
6.13.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (different SHA1: c86562e6918a)
6.1.y | Present (different SHA1: b8a7d6e7d0bb)

Note: The patch differs from the upstream commit:
---
1:  471de20303dda ! 1:  9a80b1e4b9f8a xfs: up(ic_sema) if flushing data device fails
    @@ Metadata
      ## Commit message ##
         xfs: up(ic_sema) if flushing data device fails
     
    +    [ Upstream commit 471de20303dda0b67981e06d59cc6c4a83fd2a3c ]
    +
         We flush the data device cache before we issue external log IO. If
         the flush fails, we shut down the log immediately and return. However,
         the iclog->ic_sema is left in a decremented state so let's add an up().
    @@ Commit message
         Signed-off-by: Leah Rumancik <leah.rumancik@gmail.com>
         Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
         Signed-off-by: Chandan Babu R <chandanbabu@kernel.org>
    +    Signed-off-by: Leah Rumancik <leah.rumancik@gmail.com>
     
      ## fs/xfs/xfs_log.c ##
     @@ fs/xfs/xfs_log.c: xlog_write_iclog(
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

