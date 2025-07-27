Return-Path: <stable+bounces-164865-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8009FB1318D
	for <lists+stable@lfdr.de>; Sun, 27 Jul 2025 21:36:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECBE83B8A9A
	for <lists+stable@lfdr.de>; Sun, 27 Jul 2025 19:35:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89C29224892;
	Sun, 27 Jul 2025 19:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HkJJMpYm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 495B2223705
	for <stable@vger.kernel.org>; Sun, 27 Jul 2025 19:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753644971; cv=none; b=LSU6223U9XTzgXgeOr3Th/6CruNuDxxwduwIT9ralY3yk8h3Zh/dz9hyKBcQPe32+kqwvC4ZJtX5ALF10/K4jI7z6pCc7jG98VR1OsfDt1vZ0tHCXq/B6k9IsM9hr1uYQEVjlPaTWHTXqcaSKLAjGYiJ3uzbFevPnlQQifkPf3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753644971; c=relaxed/simple;
	bh=WY9qTK1bGmjy+RrUnJ1Ltj45fynmgrYSN1m3umKB4Mc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ToRDdD89bPL/A5FWjnplb90YmcOz+nPzueyglcYSyxq9JxwUQBE2pZ31Wmc4BpR5K/fSPoBCutiEAIy+aAcecv8K49WNioO+sZntpy4+bNz+NRPXU4VP7NOz7vsgmVnO1lvbywwgfL91kWwHSWMsCp7Luctqnz+obFGYoD9zPwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HkJJMpYm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B172C4CEEB;
	Sun, 27 Jul 2025 19:36:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753644970;
	bh=WY9qTK1bGmjy+RrUnJ1Ltj45fynmgrYSN1m3umKB4Mc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HkJJMpYmWmY+O0WDY2RPDVgaY0acN53CJLAEL4pMA4DLGHZHFW0qGdS/bqEG7gahS
	 znUo8WXLBEOYr69lh7nXP3GZPFtp4AxcXPBt66RftaniCx7+eeYF8eEnMY6Wlj7qzK
	 c7wGcM2ssNKzqa1v8LsKZrEDkGz55kzi5haMOv9EveBehfe8okI1Ooaogse8CJuO/i
	 zWbZf7h1I2AT2S4W7qfG94Kkq74dnxSoEsGc2WvQsV15Eiws+i/pbVdDo8fF/LjCMC
	 78REXO9sfMgVZBYieZssZQe4jrfrp/Zwt5SS+N0cyEy74EUQia1IxdHI9kwItr1znl
	 rtVd9fEirl8UQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15.y] jfs: reject on-disk inodes of an unsupported type
Date: Sun, 27 Jul 2025 15:36:08 -0400
Message-Id: <1753631415-e7da4f99@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250727100531.533179-1-duttaditya18@gmail.com>
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

The upstream commit SHA1 provided is correct: 8c3f9a70d2d4dd6c640afe294b05c6a0a45434d9

WARNING: Author mismatch between patch and upstream commit:
Backport author: Aditya Dutt <duttaditya18@gmail.com>
Commit author: Dmitry Antipov <dmantipov@yandex.ru>

Status in newer kernel trees:
6.15.y | Present (exact SHA1)
6.12.y | Not found
6.6.y | Not found
6.1.y | Not found

Note: The patch differs from the upstream commit:
---
1:  8c3f9a70d2d4 ! 1:  2390f42afe00 jfs: reject on-disk inodes of an unsupported type
    @@ Metadata
      ## Commit message ##
         jfs: reject on-disk inodes of an unsupported type
     
    +    [ Upstream commit 8c3f9a70d2d4dd6c640afe294b05c6a0a45434d9 ]
    +
         Syzbot has reported the following BUG:
     
         kernel BUG at fs/inode.c:668!
    @@ Commit message
         Fixes: 79ac5a46c5c1 ("jfs_lookup(): don't bother with . or ..")
         Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
         Signed-off-by: Dave Kleikamp <dave.kleikamp@oracle.com>
    +    Signed-off-by: Aditya Dutt <duttaditya18@gmail.com>
     
      ## fs/jfs/jfs_imap.c ##
     @@ fs/jfs/jfs_imap.c: static void duplicateIXtree(struct super_block *sb, s64 blkno,

---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| origin/linux-5.15.y       | Success     | Success    |

