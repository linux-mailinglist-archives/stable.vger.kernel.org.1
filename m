Return-Path: <stable+bounces-106705-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 536C0A00AE7
	for <lists+stable@lfdr.de>; Fri,  3 Jan 2025 15:55:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 49CAF7A1B70
	for <lists+stable@lfdr.de>; Fri,  3 Jan 2025 14:55:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66C2E1FA8EF;
	Fri,  3 Jan 2025 14:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bQoGY1Ke"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 283A11FA8E2
	for <stable@vger.kernel.org>; Fri,  3 Jan 2025 14:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735916118; cv=none; b=Sqf8KryBMEBQOqAE2xkRnVWI5evtMdWcBJnUAG9bUYm06Gb4jxV/pFzPQ+iUHIfJRJZhQ6faw7AYLjO2ze7hB2r5P/C4SJqdWomBHvgdhXF+SSYPH7sKJfU9yLvd71cWHUywjtW2xME7GrGtNN3Nk6FK9DdHsl80O6gHqdle04M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735916118; c=relaxed/simple;
	bh=wFmEuoGueRr0MMMYsDFTVZcxjgr2c04tOLdwMdWdk/k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=o6Y0+CoW2a9Y5hWwDgBpMzcbfPA4p2lwMNp/TIRwG2+yHrjD+kSGTU72GQ+DOTDtEIQCxk5E9W58sNFNb20NKtC3EXrs2vCvCOsPzDtSIH2hZZqT4LdwdbwZY21W+dFYLP/w2JqW+l3FyVgPrLRsRYNCByRVYTUNhoXGgWbSLlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bQoGY1Ke; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78603C4CECE;
	Fri,  3 Jan 2025 14:55:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735916117;
	bh=wFmEuoGueRr0MMMYsDFTVZcxjgr2c04tOLdwMdWdk/k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bQoGY1KeWxkfBLuCetcWXd9PYtaZCPD2hVMq4QVUtKSV70XOpgKq8ky3qJGjeORTQ
	 lhd1jWeVe3sY66FxVd6H25b925HtfmE7ZJ6L7yJJSTW2pSO9itofOr7yLu5yiWfMaJ
	 qX0A2hVZnlqwIAvCgXiSJ3NhYFMaXi+wjAGejXcGvAhRbhDntv2mfEo8QXqA6hMcHR
	 kWM4KNcRAnpdkUK32wvrM9kn3/Z2T2+C++TO5u5YIdbTxbgH10jsBAF3bosNC1ngam
	 oAR3IatTb6p4XfH60CMdPeIpcqPdqwfThJZ8xGFIxDlLs7tZIGJ1c5DLqe5yhimBBQ
	 4/nU4YvlTRczA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: jianqi.ren.cn@windriver.com,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.6.y] net/mlx5e: Don't call cleanup on profile rollback failure
Date: Fri,  3 Jan 2025 09:55:16 -0500
Message-Id: <20250103090432-ef06941661fb59a6@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250103070838.355022-1-jianqi.ren.cn@windriver.com>
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

The upstream commit SHA1 provided is correct: 4dbc1d1a9f39c3711ad2a40addca04d07d9ab5d0

WARNING: Author mismatch between patch and upstream commit:
Backport author: <jianqi.ren.cn@windriver.com>
Commit author: Cosmin Ratiu<cratiu@nvidia.com>


Status in newer kernel trees:
6.12.y | Present (exact SHA1)
6.6.y | Not found

Note: The patch differs from the upstream commit:
---
1:  4dbc1d1a9f39 ! 1:  64962bd541d3 net/mlx5e: Don't call cleanup on profile rollback failure
    @@ Metadata
      ## Commit message ##
         net/mlx5e: Don't call cleanup on profile rollback failure
     
    +    [ Upstream commit 4dbc1d1a9f39c3711ad2a40addca04d07d9ab5d0 ]
    +
         When profile rollback fails in mlx5e_netdev_change_profile, the netdev
         profile var is left set to NULL. Avoid a crash when unloading the driver
         by not calling profile->cleanup in such a case.
    @@ Commit message
         Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
         Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
         Signed-off-by: Paolo Abeni <pabeni@redhat.com>
    +    Signed-off-by: Jianqi Ren <jianqi.ren.cn@windriver.com>
     
      ## drivers/net/ethernet/mellanox/mlx5/core/en_main.c ##
    -@@ drivers/net/ethernet/mellanox/mlx5/core/en_main.c: static void _mlx5e_remove(struct auxiliary_device *adev)
    +@@ drivers/net/ethernet/mellanox/mlx5/core/en_main.c: static void mlx5e_remove(struct auxiliary_device *adev)
      	mlx5e_dcbnl_delete_app(priv);
      	unregister_netdev(priv->netdev);
    - 	_mlx5e_suspend(adev, false);
    + 	mlx5e_suspend(adev, state);
     -	priv->profile->cleanup(priv);
     +	/* Avoid cleanup if profile rollback failed. */
     +	if (priv->profile)
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.6.y        |  Success    |  Success   |

