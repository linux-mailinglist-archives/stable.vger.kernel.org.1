Return-Path: <stable+bounces-110299-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7929CA1A81E
	for <lists+stable@lfdr.de>; Thu, 23 Jan 2025 17:49:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2F38A7A30B6
	for <lists+stable@lfdr.de>; Thu, 23 Jan 2025 16:49:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43007145A0F;
	Thu, 23 Jan 2025 16:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tpufJ08u"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 011E913FD83
	for <stable@vger.kernel.org>; Thu, 23 Jan 2025 16:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737650976; cv=none; b=SN9XTfW9/Uhtavf4RmKQgL39xOJVhkOOjVozQMST7hUFftfUIBHhD0AoFbyQ/ctleF8JZgkg2xBRYzY0/e15FYxV5Po9QVHpRe+LO/VhJ7nPZtH4KmoU59Le+vnAycEKy3IkczqJxp8KvLvAfcnnMiQgQmbHXao6glwescJaBd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737650976; c=relaxed/simple;
	bh=gleMzwLKhlE/eRdVg9j+Y1FyDHzCaJWkGoSoBmbb+eg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Fzyn3xmvBQlblKcAu3W7YDqb2v/kFBkl1nOZ3tNCnkGcOdwugopAYaLyGdERdc30ljAz//8osvse7Lvj5hPYgLJE6sNZ9TeiQPp8IBlZ/yca3HGoaUlMN/JpHZrSYE3uCjhQUUJ/e1+Apq0vZuOS0ERlF9JSabKbEjrbyBktcrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tpufJ08u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF70AC4CED3;
	Thu, 23 Jan 2025 16:49:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737650975;
	bh=gleMzwLKhlE/eRdVg9j+Y1FyDHzCaJWkGoSoBmbb+eg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tpufJ08u45AO/5XrtkuRJQLgGkaGyxcH5l8FjZl2YouptIfFl+LqmZ90jKTNa6fez
	 F1kUZTjhHRiLp/iCIl99wkClVem2cLaHNL87bztdhh7FxsD9Ct0F0VTps4NfLj+fKC
	 Q2AEX+lesrh/6gybhgdhl9lmfMB4oxy9CkU7IQ5QB1grWUs5k64Fy8m3Yqd2LN9h6f
	 KB7DCnt8wXPoLSZzbV40nRfzO2xR1R3g7yu1CxvRJqdRPxgFrzFxkOT9StjQ3AjvvK
	 cUr3Hmf+GWLhbLxOIGzXS5PpN7NMdWtmoNW1Y70FEJ/b2Del9gz0I4WEDugv6L9s4q
	 IMbM24Gb+PD5A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Imkanmod Khan <imkanmodkhan@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.6.y] net/mlx5e: Don't call cleanup on profile rollback failure
Date: Thu, 23 Jan 2025 11:49:33 -0500
Message-Id: <20250123114527-f0adc37d36ff5b85@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250123032254.34250-1-imkanmodkhan@gmail.com>
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
Backport author: Imkanmod Khan<imkanmodkhan@gmail.com>
Commit author: Cosmin Ratiu<cratiu@nvidia.com>


Status in newer kernel trees:
6.12.y | Present (exact SHA1)
6.6.y | Not found

Note: The patch differs from the upstream commit:
---
1:  4dbc1d1a9f39c ! 1:  cd8b1677de3fe net/mlx5e: Don't call cleanup on profile rollback failure
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
    +    Signed-off-by: Imkanmod Khan <imkanmodkhan@gmail.com>
     
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

