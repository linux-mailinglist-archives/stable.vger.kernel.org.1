Return-Path: <stable+bounces-111921-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CBB8A24C35
	for <lists+stable@lfdr.de>; Sun,  2 Feb 2025 00:53:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3607163B1D
	for <lists+stable@lfdr.de>; Sat,  1 Feb 2025 23:53:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8918A1CD1EA;
	Sat,  1 Feb 2025 23:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q75MyHKh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AA3C126F1E
	for <stable@vger.kernel.org>; Sat,  1 Feb 2025 23:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738454022; cv=none; b=AA1dzohvR+l10zCcp/Ij4v5Gys9IUgAWnGbWjps1sWXF9J//OmikPF7+BXpEiGUE2KBAmvWKsl6YpZIPJYhCexiuHRE78q6a/rmCtPPwZAQyq90AKcy7FTxXLyqOdPSGSUsw365N8bTvVnxE2A9T3MwHpJ2cus3SiMJo1dvt0/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738454022; c=relaxed/simple;
	bh=F02DZ3TZ9hh4U4EvYsnfAUANLyo0UxK4nrhJuJo17VA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DWzkDuqlLOqW2+7iu9tgfrtVPqvUeLM565LIOPIzLXI7Ow/aUPxW/ICGy0lVPQQM9awKj1qu60zcTCZ/op4kl3BKuKEGuUTSlqfS7bM6vy1Urz6hNNjpaWIUrzXlhkTQWbXSCGeocK75eQyu3mOgX3t09XzgII6STM+lSnj5g7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q75MyHKh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3967AC4CEE1;
	Sat,  1 Feb 2025 23:53:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738454021;
	bh=F02DZ3TZ9hh4U4EvYsnfAUANLyo0UxK4nrhJuJo17VA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Q75MyHKhYTmp7jC18L0/itayC7z2TVuWOWLnjOkGuqYxqxnScEivFIM6MyOf/NFCV
	 e591hiV6Pzpn5nkwvoncjcSpqqNwHY6T4PuoNuMwqD8LBdSFdD6yfF8tHXQ7kS/Rvu
	 jhYA2gW0eBYg4xu+yDBj+cpc+UWO3fsEcbOowyxE1jfNo587w+XB4AX6snSofx4/aU
	 L49rTQYu+e9cj0yAU7O6LFC+4fIoVdz4PZD257LJeLhVGu2WtKTfXEGCabrGDWUYXc
	 vdn576w7th+EkYTCj8bZgoQB5r9yeWRi2Ep5lXMC+AVNMU2gFTMRnkvb+uX1rEHsUh
	 DnmeuPvhdmWkg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Leah Rumancik <leah.rumancik@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1 02/19] xfs: hoist freeing of rt data fork extent mappings
Date: Sat,  1 Feb 2025 18:53:39 -0500
Message-Id: <20250201131412-8d2891e5abdc0d22@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250129184717.80816-3-leah.rumancik@gmail.com>
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

The upstream commit SHA1 provided is correct: 6c664484337b37fa0cf6e958f4019623e30d40f7

WARNING: Author mismatch between patch and upstream commit:
Backport author: Leah Rumancik<leah.rumancik@gmail.com>
Commit author: Darrick J. Wong<djwong@kernel.org>


Status in newer kernel trees:
6.13.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (different SHA1: e820b13ba866)
6.1.y | Present (different SHA1: 24a3929ec784)

Note: The patch differs from the upstream commit:
---
1:  6c664484337b3 ! 1:  1b742f230fc2e xfs: hoist freeing of rt data fork extent mappings
    @@ Metadata
      ## Commit message ##
         xfs: hoist freeing of rt data fork extent mappings
     
    +    [ Upstream commit 6c664484337b37fa0cf6e958f4019623e30d40f7 ]
    +
         Currently, xfs_bmap_del_extent_real contains a bunch of code to convert
         the physical extent of a data fork mapping for a realtime file into rt
         extents and pass that to the rt extent freeing function.  Since the
    @@ Commit message
     
         Signed-off-by: Darrick J. Wong <djwong@kernel.org>
         Reviewed-by: Christoph Hellwig <hch@lst.de>
    +    Signed-off-by: Leah Rumancik <leah.rumancik@gmail.com>
     
      ## fs/xfs/libxfs/xfs_bmap.c ##
     @@ fs/xfs/libxfs/xfs_bmap.c: xfs_bmap_del_extent_real(
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

