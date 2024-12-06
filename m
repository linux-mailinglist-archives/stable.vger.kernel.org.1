Return-Path: <stable+bounces-100004-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4848E9E7C49
	for <lists+stable@lfdr.de>; Sat,  7 Dec 2024 00:11:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F2EC1660D4
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 23:11:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBDC4212FA3;
	Fri,  6 Dec 2024 23:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dfMiQfLt"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 796C21F3D4D
	for <stable@vger.kernel.org>; Fri,  6 Dec 2024 23:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733526716; cv=none; b=ZEnNn404wlyGwz2A1j9qznpIJ5NoohAoZOo9zd1Xtp/iWT03Ob3XckFceX8canIjLSBOIz/kCvCoBXK9smNjGNLLjvzULfHq8Nv2Xa3tXLA81PmSkoKLUVoCkUxRm/kZDKW7fbckNzYENDirv2vw0/45Fwhh3u+F/PzNYD3+y8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733526716; c=relaxed/simple;
	bh=AW0VKSkdQgW7bSbtjFsrs7PknxrMovNb+yfp4OUupeE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fGBn/RVpuXgvdVOm8zNpW3VTUxXMFmxJM8pbyxySVfCPEZeBFy54txEcIL8E3R5O57/q0MzXvZqctFlFvnWFT2vOkP7Bc2nlxCnzjIgnt5mrhO1T/TFYL1QudKQr2wDnzXLzR/tFgepllBKHDoUvPq1QpMnZsfXTGAHJOVXDwo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dfMiQfLt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5D92C4CED1;
	Fri,  6 Dec 2024 23:11:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733526716;
	bh=AW0VKSkdQgW7bSbtjFsrs7PknxrMovNb+yfp4OUupeE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dfMiQfLt5HP49sIIVLZJBTCCIJmuojr6tFCHomaHA3xj9VU5GLSDLRvdp6mzioGDd
	 jntHGkzunWPJ6ppejNoqYJRbkbASMq2kj8kGs/+gcIUz1yPSFLymyRiWzP1xamnYo1
	 ukZwOyiqaWZxwqNMXdDohFqnm9jFfEKTmDQpRHHonqtKo3qfW9yv/6qBmCZ9ZatYey
	 cZNv51EB5xoNy/dtEEHRR15QROmOAd4uduvHVzg1fal9MKr8gigmFWURn+zLICQm+d
	 eMpFmjVOwaFany31sZutBp8WwHU0LfElQ+39l8aLw6qhjRvDDZ2gL9FaS4Dpc+dx1B
	 /TaSldzrtO4tQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.6.x] btrfs: add cancellation points to trim loops
Date: Fri,  6 Dec 2024 18:11:54 -0500
Message-ID: <20241206123447-20afebe2d14f0ae3@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241206160134.17747-1-dsterba@suse.com>
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

The upstream commit SHA1 provided is correct: 69313850dce33ce8c24b38576a279421f4c60996

WARNING: Author mismatch between patch and upstream commit:
Backport author: David Sterba <dsterba@suse.com>
Commit author: Luca Stefani <luca.stefani.ge1@gmail.com>


Status in newer kernel trees:
6.12.y | Present (exact SHA1)
6.6.y | Not found

Note: The patch differs from the upstream commit:
---
1:  69313850dce33 ! 1:  949c2e944f056 btrfs: add cancellation points to trim loops
    @@ Metadata
      ## Commit message ##
         btrfs: add cancellation points to trim loops
     
    +    commit 69313850dce33ce8c24b38576a279421f4c60996 upstream.
    +
         There are reports that system cannot suspend due to running trim because
         the task responsible for trimming the device isn't able to finish in
         time, especially since we have a free extent discarding phase, which can
    @@ fs/btrfs/free-space-cache.c: static int trim_bitmaps(struct btrfs_block_group *b
     
      ## fs/btrfs/free-space-cache.h ##
     @@
    - #include <linux/list.h>
    - #include <linux/spinlock.h>
    - #include <linux/mutex.h>
    -+#include <linux/freezer.h>
    - #include "fs.h"
    + #ifndef BTRFS_FREE_SPACE_CACHE_H
    + #define BTRFS_FREE_SPACE_CACHE_H
      
    - struct inode;
    ++#include <linux/freezer.h>
    ++
    + /*
    +  * This is the trim state of an extent or bitmap.
    +  *
     @@ fs/btrfs/free-space-cache.h: static inline bool btrfs_free_space_trimming_bitmap(
      	return (info->trim_state == BTRFS_TRIM_STATE_TRIMMING);
      }
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.6.y        |  Success    |  Success   |

