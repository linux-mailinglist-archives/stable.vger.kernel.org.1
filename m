Return-Path: <stable+bounces-118921-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8CFBA41F78
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 13:47:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0C363ACD1B
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 12:38:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 023B2233705;
	Mon, 24 Feb 2025 12:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RtDrBS7Z"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B72DA1DDE9
	for <stable@vger.kernel.org>; Mon, 24 Feb 2025 12:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740400714; cv=none; b=Sd9/XRTEoMY+HaNJTINxRbDo+A339tk+jFkkZYrb6rCFJTIlMrr+Of6yFQEqHdKcFrt8KZT+qtnKyzDmJ6IKJGA+prwtbumdoti9Ox2Dx/ly1yRrIIJ0dMAfMtZQvTN91V8mWIe0rr9/ltATuBw9qYUxNCMvRT9dhcSdWWKEMH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740400714; c=relaxed/simple;
	bh=y6C6LOPzN4dqopt63C2gXvnPZq+GtBxrLDOnuvIbnG8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gKeeTOr5O6+a8+Sd3aZ4yWweF9/HbrbgCgxRz6Mioat5oUXVNcHZqZI6uwQXEhfRPPuE09RcctjlcfslQYW9utQ4hoUQVzW2eUTcfmM1ev5XoraaI4u/+AgMPKjC7YhDc7mDA/JuqUToWRAImkAou/Bvq3IoNcEyPCvOWLF27sU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RtDrBS7Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBE81C4CED6;
	Mon, 24 Feb 2025 12:38:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740400714;
	bh=y6C6LOPzN4dqopt63C2gXvnPZq+GtBxrLDOnuvIbnG8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RtDrBS7ZlrxiqJUc2yngHptOZj96s2xg8AOCLC9pHWhCkSMry9G8otlOekY54CDTZ
	 vhIbmS1ZwIxRX6bKwTfaHeSvvaXScmqFADfPq2TtpTPfPla0IbJj2kj5C5FebSrBSe
	 70OOxtXZrNnRXmQgHrQVNz4s/If9EExYNRyH1XAJb8J6+Km66P7DQp0RVHQe+Zti+9
	 XF/YkHMJUrpNifHhZUJZ8uYlJXtB4i0f+Em+v1QAYxreWzhYzJgYWnJSlwlE9C5ARJ
	 2CDOKFrrgYJBU+4qfISKiyVp6Tj+NNS4TSJXtWSP4X0ibitds/0/QxrS30+atd/nV/
	 SopH+efqgs/ng==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: jianqi.ren.cn@windriver.com,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.6.y] net/mlx5e: Don't call cleanup on profile rollback failure
Date: Mon, 24 Feb 2025 07:38:32 -0500
Message-Id: <20250224070828-8c6d7a74bd8c9826@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250224063650.2397912-1-jianqi.ren.cn@windriver.com>
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

The upstream commit SHA1 provided is correct: 4dbc1d1a9f39c3711ad2a40addca04d07d9ab5d0

WARNING: Author mismatch between patch and upstream commit:
Backport author: <jianqi.ren.cn@windriver.com>
Commit author: Cosmin Ratiu<cratiu@nvidia.com>

Note: The patch differs from the upstream commit:
---
1:  4dbc1d1a9f39c ! 1:  4e75a6d11f1ae net/mlx5e: Don't call cleanup on profile rollback failure
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
    +    Signed-off-by: He Zhe <zhe.he@windriver.com>
     
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

