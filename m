Return-Path: <stable+bounces-124480-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91808A62145
	for <lists+stable@lfdr.de>; Sat, 15 Mar 2025 00:10:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 361853BEC63
	for <lists+stable@lfdr.de>; Fri, 14 Mar 2025 23:10:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43B0A1C860B;
	Fri, 14 Mar 2025 23:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZDPa11nt"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04E3115D5C4
	for <stable@vger.kernel.org>; Fri, 14 Mar 2025 23:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741993813; cv=none; b=OF4MGj0xVbrYEH9WNkeJ1FEfD1QoCBdzAdKiVx9FO313u9xM+Dkj+vYx0HkZmu6i/78fF1QyXcaIc2ZI+hXIEfH/ja+nI32IT5kWg2lsKolaka5wDDB0hs9hlYd++HStQ6VEGhpdAzaUQ/ed7IBmuJTAsBNX0tTOOS8BZKUuaE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741993813; c=relaxed/simple;
	bh=BxYKMZ9LX1C0kd/VoNZT6dy5lLdJ6zRp1+JZEyOr884=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Sqag6OLa7qp68B+kCR9f5AFsuigDaoBqgp6e0bujZ0s+V72ZZXfLiW/NVpAudkfRrlwAnQWvzDOrktaMzDvIFIzUib31bxxeN7YYFXldPwwS5pm17ahag+6xgM5lIsNVsSJ30XLztXQI9LTVMEuZJM7N6Giq6l0tExix6TXqxaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZDPa11nt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D15CC4CEE3;
	Fri, 14 Mar 2025 23:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741993812;
	bh=BxYKMZ9LX1C0kd/VoNZT6dy5lLdJ6zRp1+JZEyOr884=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZDPa11ntUGydcULAizXihKrlrVOKvS7G5PjJA8jfNeKnmZVQsmQ8MzOX8OgPseKO1
	 RBCHyjax2X34x3CcwVahuy1eGDJfEsjgLJOMukqbWt6UxWjGU3nC5oE6Nk2E3jvEXp
	 0gw9eUKXvBNkv5DqaDLRbaP2BKeUo3yNwrevu1rD8l5IQ51wZ22DPyaYt4Ao9q+Tsj
	 mAPMvvSB7LsCIzfJhF0TlhOgh1twUfzJm7gFDmwSlUZtTiPbBaXT0MvEbMxkTi7Nzk
	 8OLsRSxPJHbLPaax9jp3aRP3vVZxRwNf3dzfBmNSCr4kKp2xmGx5ZXQ4JY8UN/8kSb
	 nvbsTYQIydNgw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Leah Rumancik <leah.rumancik@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1 02/29] xfs: pass xfs_extent_free_item directly through the log intent code
Date: Fri, 14 Mar 2025 19:10:11 -0400
Message-Id: <20250314110942-dd51aa622667f911@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250313202550.2257219-3-leah.rumancik@gmail.com>
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

The upstream commit SHA1 provided is correct: 72ba455599ad13d08c29dafa22a32360e07b1961

WARNING: Author mismatch between patch and upstream commit:
Backport author: Leah Rumancik<leah.rumancik@gmail.com>
Commit author: Darrick J. Wong<djwong@kernel.org>

Status in newer kernel trees:
6.13.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (exact SHA1)

Note: The patch differs from the upstream commit:
---
1:  72ba455599ad1 ! 1:  a4d4bccfa3b1e xfs: pass xfs_extent_free_item directly through the log intent code
    @@ Metadata
      ## Commit message ##
         xfs: pass xfs_extent_free_item directly through the log intent code
     
    +    [ Upstream commit 72ba455599ad13d08c29dafa22a32360e07b1961 ]
    +
         Pass the incore xfs_extent_free_item through the EFI logging code
         instead of repeatedly boxing and unboxing parameters.
     
         Signed-off-by: Darrick J. Wong <djwong@kernel.org>
    +    Signed-off-by: Leah Rumancik <leah.rumancik@gmail.com>
    +    Acked-by: "Darrick J. Wong" <djwong@kernel.org>
     
      ## fs/xfs/xfs_extfree_item.c ##
     @@ fs/xfs/xfs_extfree_item.c: static int
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

