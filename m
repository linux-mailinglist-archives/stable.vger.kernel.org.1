Return-Path: <stable+bounces-132346-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 439A7A872AB
	for <lists+stable@lfdr.de>; Sun, 13 Apr 2025 18:46:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4C6C3B74B9
	for <lists+stable@lfdr.de>; Sun, 13 Apr 2025 16:46:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3C7B1D7E37;
	Sun, 13 Apr 2025 16:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EIzFcsxT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A408314A0A8
	for <stable@vger.kernel.org>; Sun, 13 Apr 2025 16:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744562812; cv=none; b=o92v+tnGRgEqaSLpnLoibsdNunUe3ykf68TzkNH7coEskA49GPPQUUCkGfo/1yqlsK8MPprwK0CeXJzdHMD9OvCLyQchlpp8WedPjrj+AqboM7uouGcl8g4S2RAA7Ji0AF5uM4c9vaNQrucwwsXty14RUybnQCU6IMz5B/1UqAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744562812; c=relaxed/simple;
	bh=FuCg6aWtGVvEYm7zBkw/LmCwlBW1xcYGV6pAiub2pQI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dRIhMoQFUh3qko3H7OBM33QlA61N1oM/+ACoMUvAlJwJX1cPH2h5Vv0W0qX8faWEWRDo6IIIyEsdYX4DzwazmpYJQI9YuYsmZ+2vlwNMIOTOzXnHbb2I4/5fFI0XpgkRqBx8UB2Xnsi3aOWUU7LHrGUQb/12OXZ5vUaJscbu06I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EIzFcsxT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1A0CC4CEDD;
	Sun, 13 Apr 2025 16:46:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744562812;
	bh=FuCg6aWtGVvEYm7zBkw/LmCwlBW1xcYGV6pAiub2pQI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EIzFcsxTuVP0Q2QKrnau/4FLFixOT23j0LEvuM6SohR0X4+5isB02lvDWhtpCppVL
	 xmVsz3WFtyUHENxB1lpAXL/l7YYo944dXRh8pmfj0O3aiQ89q1HHj3I9x04AZSeFbo
	 wJiZ/JuFUeI4dKWtuvpiUrfRRVQFXvKSRSowwYS8bPi9uZ0O+kyiXOjjUz7GFAK8fo
	 LjnUojdaajtrcF7l0sg5gbMZ+DDSNy+UT9VkAqLrsGy0YiDsox33IX9HN2+2K+U3lL
	 IG74+L0urPhvzyxdbazM6FyJviN14NvMzBVxsWeNzWhInS6n+yJzzxcadwL5CR+uyu
	 yRtLuZqT/mO2A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Miguel=20Garc=C3=ADa?= <miguelgarciaroman8@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1.y] block: make bio_check_eod work for zero sized devices
Date: Sun, 13 Apr 2025 12:46:50 -0400
Message-Id: <20250412105909-5300d45443777a29@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250412102424.56383-1-miguelgarciaroman8@gmail.com>
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

The upstream commit SHA1 provided is correct: 3eb96946f0be6bf447cbdf219aba22bc42672f92

WARNING: Author mismatch between patch and upstream commit:
Backport author: <miguelgarciaroman8@gmail.com>
Commit author: Christoph Hellwig<hch@lst.de>

Status in newer kernel trees:
6.14.y | Present (exact SHA1)
6.13.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (exact SHA1)

Note: The patch differs from the upstream commit:
---
1:  3eb96946f0be6 ! 1:  6a6f180aae691 block: make bio_check_eod work for zero sized devices
    @@ Metadata
      ## Commit message ##
         block: make bio_check_eod work for zero sized devices
     
    +    commit 3eb96946f0be6bf447cbdf219aba22bc42672f92 upstream.
    +
    +    This patch is a backport.
    +
         Since the dawn of time bio_check_eod has a check for a non-zero size of
         the device.  This doesn't really make any sense as we never want to send
         I/O to a device that's been set to zero size, or never moved out of that.
    @@ Commit message
         the issue really goes back way before git history.
     
         Fixes: 9fe95babc742 ("zram: remove valid_io_request")
    -    Reported-by: syzbot+b8d61a58b7c7ebd2c8e0@syzkaller.appspotmail.com
    +    Reported-by: syzbot+2aca91e1d3ae43aef10c@syzkaller.appspotmail.com
    +    Bug: https://syzkaller.appspot.com/bug?extid=2aca91e1d3ae43aef10c
         Signed-off-by: Christoph Hellwig <hch@lst.de>
         Link: https://lore.kernel.org/r/20230524060538.1593686-1-hch@lst.de
         Signed-off-by: Jens Axboe <axboe@kernel.dk>
    +    (cherry picked from commit 3eb96946f0be6bf447cbdf219aba22bc42672f92)
    +    Signed-off-by: Miguel García <miguelgarciaroman8@gmail.com>
     
      ## block/blk-core.c ##
     @@ block/blk-core.c: static inline int bio_check_eod(struct bio *bio)
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

