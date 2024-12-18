Return-Path: <stable+bounces-105242-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A2989F6FAB
	for <lists+stable@lfdr.de>; Wed, 18 Dec 2024 22:43:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 820361650F8
	for <lists+stable@lfdr.de>; Wed, 18 Dec 2024 21:43:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5283F1F63EB;
	Wed, 18 Dec 2024 21:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ygq51SAH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 119D935949
	for <stable@vger.kernel.org>; Wed, 18 Dec 2024 21:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734558210; cv=none; b=enAaA3OIAFtYZo5JnnbsggKFmGt7fhuR17kfbJDxgK9RM7e1GsKeeBb8lnrDud+2qr+RD5N+NTVos2VGHuLiMv+iwMKfYIQwycjLSB/FdBZq59vBc3lER/MBJsGG/wH99a2QBaOcn42THI3ug4aqlUgUrCtpL2Ee2ZCJ4Drah2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734558210; c=relaxed/simple;
	bh=nsA1faHDHUlCl2ICkQ1/uqNVOhw1lDxqoqhWAuKXgQY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hHtN5IrPaG+tJ+ODXhPyeHoW3YB1X1JlMSTOU2FFb0A7PygosPvXomu9SdcxietFS8D+Bz7QRDTc9Oeesn5O3numIoc4DH47DW7yZ9CYz7ogYZC+7Wgf9apUe3DLC0Y/ZZ/sDM69Oq7pFAINPfy+O+bVoEaTDX4PRcfqz6n1x7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ygq51SAH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2795BC4CECD;
	Wed, 18 Dec 2024 21:43:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734558209;
	bh=nsA1faHDHUlCl2ICkQ1/uqNVOhw1lDxqoqhWAuKXgQY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ygq51SAHdYEPfBZmf0z1aC6+S+QYT27l1z9xgmt6dcENCRUBRXsAu4N3auHKc6/SM
	 6aEL3hzT+wXiYWFYNsjucE3dZ5I9XQvL91zWHtJGEk7DKz/GWWb2yM7aLQ4rPJ0brY
	 JJtMzTnQCKCHaZCttyriF1NA0nhWC7s4OEvcDU+rRvi3eIu7AVoK8JEQZroEEmbLhM
	 d+f0qld6xyID4mN4cOayMTgb9LroHexLnW2dcPz5mnLNcvYgh0yiz/csN4woY2oWVZ
	 LtS5SJGit+8Bl7VY9x6RE9hFhWpfPmTbp7HlbsytbpMNY93/+eRMAf/kBzahYbelwA
	 hFHgJrbV2KHsQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 1/5] xfs: sb_spino_align is not verified
Date: Wed, 18 Dec 2024 16:43:27 -0500
Message-Id: <20241218163854-e24d7355695cb5bd@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <173455093514.305755.18242328636177192354.stgit@frogsfrogsfrogs>
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

The upstream commit SHA1 provided is correct: 59e43f5479cce106d71c0b91a297c7ad1913176c

WARNING: Author mismatch between patch and upstream commit:
Backport author: "Darrick J. Wong" <djwong@kernel.org>
Commit author: Dave Chinner <dchinner@redhat.com>


Status in newer kernel trees:
6.12.y | Not found

Note: The patch differs from the upstream commit:
---
1:  59e43f5479cc ! 1:  273f71b3b9d4 xfs: sb_spino_align is not verified
    @@ Metadata
      ## Commit message ##
         xfs: sb_spino_align is not verified
     
    +    commit 59e43f5479cce106d71c0b91a297c7ad1913176c upstream.
    +
         It's just read in from the superblock and used without doing any
         validity checks at all on the value.
     
    @@ Commit message
         Signed-off-by: Dave Chinner <dchinner@redhat.com>
         Reviewed-by: Darrick J. Wong <djwong@kernel.org>
         Signed-off-by: Carlos Maiolino <cem@kernel.org>
    +    [djwong: actually tag for 6.12 because upstream maintainer ignored cc-stable tag]
    +    Link: https://lore.kernel.org/linux-xfs/20241024165544.GI21853@frogsfrogsfrogs/
    +    Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
     
      ## fs/xfs/libxfs/xfs_sb.c ##
     @@ fs/xfs/libxfs/xfs_sb.c: xfs_validate_sb_common(
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.12.y       |  Success    |  Success   |
| stable/linux-6.6.y        |  Success    |  Success   |
| stable/linux-6.1.y        |  Success    |  Success   |
| stable/linux-5.15.y       |  Success    |  Success   |
| stable/linux-5.10.y       |  Failed     |  N/A       |
| stable/linux-5.4.y        |  Failed     |  N/A       |

