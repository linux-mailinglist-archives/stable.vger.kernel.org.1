Return-Path: <stable+bounces-164863-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 90156B1318B
	for <lists+stable@lfdr.de>; Sun, 27 Jul 2025 21:36:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B45CD18976C5
	for <lists+stable@lfdr.de>; Sun, 27 Jul 2025 19:36:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60F7E224892;
	Sun, 27 Jul 2025 19:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KAnsS2fy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 226FF1A314E
	for <stable@vger.kernel.org>; Sun, 27 Jul 2025 19:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753644964; cv=none; b=VQd8wLzI6WmSRdnNMwc0vHcfY5PKV1DARvpUWYihFVKwub8jyWZ+HaqXa4eAvQaxyYIVP4l5KsLIfmFi5DVwHdM2y7yjh30n0C5OAzQT7M/NUFcbpHn0Rhzvwsxbjl1YhgWOo/W6Wms/aeqHimh1x6pJpeClgClYyPDcVs81vZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753644964; c=relaxed/simple;
	bh=tZK2dcpvnayzpitek+Je15qrDi0uIF91/bbqGkoptCU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=agxk2pA8d6Pr1ct21yG21kgf+O2l1TtQtK7zWJ7jE7/0PpXAKYgtu8bp5lDNt1oGLmrAHNTyJ/eo90NqVZwPYLKkMUM2xbcUvH9DpExWbR38owxjlLmT37AmsI7/bwEvxG2IVjKCCNY05cs1/R+NrSCb8q+Gi5YkQCDYy2KCT+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KAnsS2fy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F377EC4CEEB;
	Sun, 27 Jul 2025 19:36:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753644963;
	bh=tZK2dcpvnayzpitek+Je15qrDi0uIF91/bbqGkoptCU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KAnsS2fyNH5MqLcuHYhUsTRISAuN+N5SRvr2+V0MzeX7QVybFUX8XWgjBa0EfGDwU
	 HiYKKkhDyAlygpFAZKrgMMoFMKB1TZ7dDHhBJC4UbvxiZWmMUviS2AJ7ErO04lTSkt
	 UNlcGrJnMHp85op5bjHC9uucDcdpiCGIQXdQMZ9POSDgDozIu1GRLzXaUHZkUbbH2l
	 Ljs+6i21ieY5fqDxIUKPKyzWY/YhRR6LYvMlyCgWeSdnqFwUZTgcv1BzlitaPwVFgQ
	 VzuzOq6z5eu+f1KBgU+gs4T4Z6hnOEeldETuac69Znh63bVswV/wCfmAuoNoihUizP
	 9f9jqS26Csabg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1.y] jfs: reject on-disk inodes of an unsupported type
Date: Sun, 27 Jul 2025 15:36:00 -0400
Message-Id: <1753631799-cfd466f9@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250727100255.532093-1-duttaditya18@gmail.com>
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

Note: The patch differs from the upstream commit:
---
1:  8c3f9a70d2d4 ! 1:  142f85a8ab72 jfs: reject on-disk inodes of an unsupported type
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
| origin/linux-6.1.y        | Success     | Success    |

