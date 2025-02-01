Return-Path: <stable+bounces-111924-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 04B81A24C38
	for <lists+stable@lfdr.de>; Sun,  2 Feb 2025 00:53:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E8E03A484E
	for <lists+stable@lfdr.de>; Sat,  1 Feb 2025 23:53:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56F0F1CC881;
	Sat,  1 Feb 2025 23:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y3UJBfZD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 167CB1534FB
	for <stable@vger.kernel.org>; Sat,  1 Feb 2025 23:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738454028; cv=none; b=IAuiKEMWh1JvVeSXtvHCmQO06T6h6o8m4bt+heG2S9DrwmLD3V+YQzlG+M5lmyXu0jWgVCmk8CKAdzhAREptdnDiTgUnIYfEtr78UyUuMu125YfWjeMGFx6Ht0pDnC9Qnve1aIoIa2sNrOQAWx3LF3uF7dwatwxaOV1ugF9W+IE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738454028; c=relaxed/simple;
	bh=U5obOsYwkqZq+5+zBRyTalWaPl1zo7XH4CXgqDXgcfQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=k3+3zkLcN03Vo2tba8vHs+7+KCsfAA4FhWaNpelPEpZXYA8UHtrPQBdXNeveEJoI+GcSYE3AywJSRuF2N+A3D/3hx6t4gtqSWEYg1nlzAb0jPUR2Na+WTNYBq8uf3FZkAefSZvbVY4aqxsb4LipXFAlxgyW5v8xwaE9ZAR2l2ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y3UJBfZD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CF0CC4CED3;
	Sat,  1 Feb 2025 23:53:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738454028;
	bh=U5obOsYwkqZq+5+zBRyTalWaPl1zo7XH4CXgqDXgcfQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Y3UJBfZDaqeNSc0smRCGjCkjgDPDTxbDO6082MM2wa7EjA8rk96SA85QWDIo6BJqr
	 7Y0oV3dMQvGFFZyCAartgRBJJ9b/9lYmO1nlkcGX/5TZZDfP9nlW0Lu7pFkCllzYX6
	 PZrs5VqAW5X47PxpV4UsOum1MtE20V+0ESoR9kplcxdq9a1zPPPeIscjh5jfVxD5hE
	 ztJ/bGcv7Cza5K7Qv02ID1V8445dSGMulVC36olFWF0qjL7UkWLvntVxLPdsHgr3WX
	 poBE4zcMFFnsBODv4XKNgrFnwhpu22qQsAzr+5IMxEQ87LBk1h9pLZao/JieUYGuSA
	 UZzzUzZcTUxPw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Leah Rumancik <leah.rumancik@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1 19/19] xfs: respect the stable writes flag on the RT device
Date: Sat,  1 Feb 2025 18:53:46 -0500
Message-Id: <20250201152024-0d1a7b33e3004eb8@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250129184717.80816-20-leah.rumancik@gmail.com>
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

The upstream commit SHA1 provided is correct: 9c04138414c00ae61421f36ada002712c4bac94a

WARNING: Author mismatch between patch and upstream commit:
Backport author: Leah Rumancik<leah.rumancik@gmail.com>
Commit author: Christoph Hellwig<hch@lst.de>


Status in newer kernel trees:
6.13.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (different SHA1: 05955a703b75)
6.1.y | Present (different SHA1: a1118a7188ac)

Note: The patch differs from the upstream commit:
---
1:  9c04138414c00 ! 1:  89b6a2ad5ec85 xfs: respect the stable writes flag on the RT device
    @@ Metadata
      ## Commit message ##
         xfs: respect the stable writes flag on the RT device
     
    +    [ Upstream commit 9c04138414c00ae61421f36ada002712c4bac94a ]
    +
         Update the per-folio stable writes flag dependening on which device an
         inode resides on.
     
    @@ Commit message
         Link: https://lore.kernel.org/r/20231025141020.192413-5-hch@lst.de
         Reviewed-by: Darrick J. Wong <djwong@kernel.org>
         Signed-off-by: Christian Brauner <brauner@kernel.org>
    +    Signed-off-by: Leah Rumancik <leah.rumancik@gmail.com>
     
      ## fs/xfs/xfs_inode.h ##
     @@ fs/xfs/xfs_inode.h: extern void xfs_setup_inode(struct xfs_inode *ip);
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

