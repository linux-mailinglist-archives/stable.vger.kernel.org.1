Return-Path: <stable+bounces-142946-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA833AB079B
	for <lists+stable@lfdr.de>; Fri,  9 May 2025 03:52:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F15161BC0467
	for <lists+stable@lfdr.de>; Fri,  9 May 2025 01:52:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 768B513B58B;
	Fri,  9 May 2025 01:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="puA5yQ1O"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3234313632B
	for <stable@vger.kernel.org>; Fri,  9 May 2025 01:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746755542; cv=none; b=E7E/YTXpXrJbEndGImaGzyR41Rd9M6nBfOW+4FOgVjcEDQ9cDpLfzSzD9DPryTxY31aAGo+UpsHKydg54F1D7tNxyp/jyt/+sLdkgY7j8c4MOhXPUGwvQ5Ju77uPAH9mPOcmS9/3Id204aZUn4nHODVoSX0I+XcsV3v9C2tSiQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746755542; c=relaxed/simple;
	bh=vXbCNWy/UwUE6Xz/IHjYFbR1HUuVq71LUPE3Gns0Yyc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oe7ewBwTPe8V3AhLDkNaTZK7O53Ohid8JwcPVrC8PUmirllQCTZooUZ0Vk/9vI72d3rL3AwLvC7c1ETM+F/4RJlah+dP7knUxv7es6gng1T/wDc+LzOdhS4aADBIy42bO/Mdn4ZOvonWzTTjZgawW873doToxFdAPKF1t06fXvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=puA5yQ1O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 993E2C4CEED;
	Fri,  9 May 2025 01:52:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746755542;
	bh=vXbCNWy/UwUE6Xz/IHjYFbR1HUuVq71LUPE3Gns0Yyc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=puA5yQ1OGNVSsxHII9gCBss44Je5ipjxIaefAl9keqzcpo7k0ukvSCbQmyTONPttF
	 AqGL7nCTgZUlla5XIFU35Y95mIdDM3WwF69otpH/eqjJtpnhLPCnmcxuHPDy7JDTqs
	 JhCqTBC5UvcAGZNs9XYhSez242ssMNFQGNBNKmt0ovf2PhkIxTUy4opcZULq9dZgIw
	 e0kr90uXGX5Poqi/+qgsin6YCcULrIQBjb+2wixBgn2KBSJGwdp3tYUe1ZlZRZPMTj
	 HK7WwHjXMrGFCD8r83q7opFSE9ZU4IzVKkvqUt1JfzPAUDilMnc8V9uk8GL50bSWyD
	 0JFp2xGCM0vNg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	wqu@suse.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH] btrfs: always fallback to buffered write if the inode requires checksum
Date: Thu,  8 May 2025 21:52:17 -0400
Message-Id: <20250508141536-9e8c55fefb992cad@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <dcffa5400745663641e58a261e8dbccbb194b468.1746666392.git.wqu@suse.com>
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

Summary of potential issues:
❌ Build failures detected

The upstream commit SHA1 provided is correct: 968f19c5b1b7d5595423b0ac0020cc18dfed8cb5

Note: The patch differs from the upstream commit:
---
1:  968f19c5b1b7d < -:  ------------- btrfs: always fallback to buffered write if the inode requires checksum
-:  ------------- > 1:  aeaee199900ee Linux 6.14.5
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.14.y       |  Success    |  Success   |
| stable/linux-6.12.y       |  Success    |  Success   |
| stable/linux-6.6.y        |  Success    |  Success   |
| stable/linux-6.1.y        |  Success    |  Failed    |
| stable/linux-5.15.y       |  Success    |  Failed    |
| stable/linux-5.10.y       |  Success    |  Success   |
| stable/linux-5.4.y        |  Success    |  Success   |

Build Errors:
Build error for stable/linux-6.1.y:
    fs/btrfs/file.c: In function 'btrfs_direct_write':
    fs/btrfs/file.c:1522:36: error: passing argument 1 of 'btrfs_inode_unlock' from incompatible pointer type [-Wincompatible-pointer-types]
     1522 |                 btrfs_inode_unlock(BTRFS_I(inode), ilock_flags);
          |                                    ^~~~~~~~~~~~~~
          |                                    |
          |                                    struct btrfs_inode *
    In file included from fs/btrfs/file.c:20:
    fs/btrfs/ctree.h:3487:39: note: expected 'struct inode *' but argument is of type 'struct btrfs_inode *'
     3487 | void btrfs_inode_unlock(struct inode *inode, unsigned int ilock_flags);
          |                         ~~~~~~~~~~~~~~^~~~~
    make[3]: *** [scripts/Makefile.build:250: fs/btrfs/file.o] Error 1
    make[3]: Target 'fs/btrfs/' not remade because of errors.
    make[2]: *** [scripts/Makefile.build:503: fs/btrfs] Error 2
    make[2]: Target 'fs/' not remade because of errors.
    make[1]: *** [scripts/Makefile.build:503: fs] Error 2
    make[1]: Target './' not remade because of errors.
    make: *** [Makefile:2013: .] Error 2
    make: Target '__all' not remade because of errors.

Build error for stable/linux-5.15.y:
    fs/btrfs/file.c: In function 'btrfs_direct_write':
    fs/btrfs/file.c:1979:36: error: passing argument 1 of 'btrfs_inode_unlock' from incompatible pointer type [-Werror=incompatible-pointer-types]
     1979 |                 btrfs_inode_unlock(BTRFS_I(inode), ilock_flags);
          |                                    ^~~~~~~~~~~~~~
          |                                    |
          |                                    struct btrfs_inode *
    In file included from fs/btrfs/file.c:20:
    fs/btrfs/ctree.h:3282:39: note: expected 'struct inode *' but argument is of type 'struct btrfs_inode *'
     3282 | void btrfs_inode_unlock(struct inode *inode, unsigned int ilock_flags);
          |                         ~~~~~~~~~~~~~~^~~~~
    cc1: some warnings being treated as errors
    make[2]: *** [scripts/Makefile.build:289: fs/btrfs/file.o] Error 1
    make[2]: Target '__build' not remade because of errors.
    make[1]: *** [scripts/Makefile.build:552: fs/btrfs] Error 2
    make[1]: Target '__build' not remade because of errors.
    make: *** [Makefile:1914: fs] Error 2
    make: Target '__all' not remade because of errors.

