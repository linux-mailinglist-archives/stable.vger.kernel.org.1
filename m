Return-Path: <stable+bounces-111931-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DD2CA24C3F
	for <lists+stable@lfdr.de>; Sun,  2 Feb 2025 00:54:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0201B163B6B
	for <lists+stable@lfdr.de>; Sat,  1 Feb 2025 23:54:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71465155393;
	Sat,  1 Feb 2025 23:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ehgHs2YI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 315C0126F1E
	for <stable@vger.kernel.org>; Sat,  1 Feb 2025 23:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738454042; cv=none; b=VCEZHN1rEclBQmx0UxnXF05JHieRxonY7qUyu/9maqiJM81NNQXiDIhqDZQvLOe29H95s/KCa6Qd/CIgaQ9YAUaW6lStBRtoGBbBv94Hy1HmCzuEgK2Z8mvknUlVJcKM9fcijovwhrb0D+xouIqbXdTTrbvonm+q/5mO760i2go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738454042; c=relaxed/simple;
	bh=HAS728VxwOngJzQWNH6JU6bLd6y5GxmUfyQ+Ae7ZAXA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=T26veGB3CyeiCOQ5ytNAaE+hi00+DFCjsa1HhhcFFrGmOWfBqmwjc58nFeYAQnq19inn5TI+Bm1ZazGCbPVQYJIqVTEmrtf5SWDSRgScR/nMmP0pPUH7uufmEeCRXjY4Aq+tE3QPxvEZS/vcGorP57wLFp64zVKaqOpdsPUNLFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ehgHs2YI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9ECA0C4CED3;
	Sat,  1 Feb 2025 23:54:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738454042;
	bh=HAS728VxwOngJzQWNH6JU6bLd6y5GxmUfyQ+Ae7ZAXA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ehgHs2YIfwhEavfohT/fAbZYVcGlvX5e1MKp61bH2nQLrQUx/ijjizlzyUI3ycaWc
	 CJpiInzFexTfC/pWT7fRRAx67Ogmy9fLOWbPMVRjMKNje33kz1dZgVZXl9sko5h1Re
	 TRQuJluM0lv+nmfi2CYtun8+ZJt1DwnLmWUAtr7Fbkw+oEnyfwe7mO26XuJspN4q/i
	 NGfQdTXMdFZ4NTdQLKIqSHT31Hq/LFn0rSg2l8joJuxKIaGXSJJPt1sBBzuGvz3fbM
	 3Ggd84C9W6agcftw+p5dce4rKtIW2k6VPF8D2V7T2REW1d82XOahRrdJ1Jq6aj+qZA
	 e/C0NQ53yaCww==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Leah Rumancik <leah.rumancik@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1 14/19] xfs: fix internal error from AGFL exhaustion
Date: Sat,  1 Feb 2025 18:54:00 -0500
Message-Id: <20250201144234-098fa2bca7714c9f@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250129184717.80816-15-leah.rumancik@gmail.com>
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

The upstream commit SHA1 provided is correct: f63a5b3769ad7659da4c0420751d78958ab97675

WARNING: Author mismatch between patch and upstream commit:
Backport author: Leah Rumancik<leah.rumancik@gmail.com>
Commit author: Omar Sandoval<osandov@fb.com>


Status in newer kernel trees:
6.13.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (different SHA1: 0838177b012b)
6.1.y | Present (different SHA1: 4b83cf86531e)

Note: The patch differs from the upstream commit:
---
1:  f63a5b3769ad7 ! 1:  c15b0d3490300 xfs: fix internal error from AGFL exhaustion
    @@ Metadata
      ## Commit message ##
         xfs: fix internal error from AGFL exhaustion
     
    +    [ Upstream commit f63a5b3769ad7659da4c0420751d78958ab97675 ]
    +
         We've been seeing XFS errors like the following:
     
         XFS: Internal error i != 1 at line 3526 of file fs/xfs/libxfs/xfs_btree.c.  Caller xfs_btree_insert+0x1ec/0x280
    @@ Commit message
         Reviewed-by: Dave Chinner <dchinner@redhat.com>
         Signed-off-by: Omar Sandoval <osandov@fb.com>
         Signed-off-by: Chandan Babu R <chandanbabu@kernel.org>
    +    Signed-off-by: Leah Rumancik <leah.rumancik@gmail.com>
     
      ## fs/xfs/libxfs/xfs_alloc.c ##
     @@ fs/xfs/libxfs/xfs_alloc.c: xfs_alloc_min_freelist(
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

