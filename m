Return-Path: <stable+bounces-150756-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 99ECBACCD27
	for <lists+stable@lfdr.de>; Tue,  3 Jun 2025 20:36:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB7793A6867
	for <lists+stable@lfdr.de>; Tue,  3 Jun 2025 18:35:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8257288C0C;
	Tue,  3 Jun 2025 18:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hSi/CqBA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78AE0BA34
	for <stable@vger.kernel.org>; Tue,  3 Jun 2025 18:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748975769; cv=none; b=PFB8UsoKxPMg63OB5OqQkZ2m178NNjIAtuHy62VSz6uLlJLMPaa9zmX1cVZjr5J64USwqVorLyuJ5aOFGfLOvzxUhqVis/6IlNjDgq/kxyVd5t7S5SJ0ysPZTKdB4WTR0ohkafzW6eJHjqDJdRzKHp4ICGI9cWwAq86HD05Mmak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748975769; c=relaxed/simple;
	bh=iUpMeVLFfJQG3fRSio+u/a6ji3wTaLInl8dlABKwlJo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LXVXG9RlvoDE/Mopaq8uA8ri1NOSgJZjkmn4Ozfrn63XXGULsrYH8wWI+GTQ0mxQU3bunY/ER+d5RdOk/qO7WNKqqxv/qMdSQSe7zv5YeP/NypqlZuquCQDLNNv54v8BkE1uerYzwUeH157qFvzMIAvvGwdiTcFCmQxdwKbelUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hSi/CqBA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D3E1C4CEED;
	Tue,  3 Jun 2025 18:36:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748975769;
	bh=iUpMeVLFfJQG3fRSio+u/a6ji3wTaLInl8dlABKwlJo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hSi/CqBAvDoSK5dTYtPU6+qEIKhmMpF+bUviCZ5UiWnu6owteaY/MHEJaRTiL3JuC
	 fHCkfaJx1Nk8wBSrwDb0BmNKVM+iymBuehoGQ6H+OQr9dLVfVpiQYm1/h+Jdj28kSK
	 WEmSizZqeMmI9IshL/HvGNJrXN9MnmOdNAboY/4XnjvSK5YM2u5V4EXlvGw8g6VjZn
	 iYCYLLtm4fkeBRdcbP9oybNZfsdWDEFCHtrNrMF+FroHB10BMX7WUUyEbIvR80cA3M
	 KKLix7IdVPX4KfA6bgrPi2A77Wkt6mjsNbarhUCSeEFYodLCZq4N2IcZ5kA7NMgl6C
	 Tkn/LbzdF/dHA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: alvalan9@foxmail.com,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.12.y] f2fs: fix to avoid accessing uninitialized curseg
Date: Tue,  3 Jun 2025 14:36:07 -0400
Message-Id: <20250603141552-7a6a230121fa0c39@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <tencent_381A1068DD6A903EBA2513AD817046602209@qq.com>
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

The upstream commit SHA1 provided is correct: 986c50f6bca109c6cf362b4e2babcb85aba958f6

WARNING: Author mismatch between patch and upstream commit:
Backport author: alvalan9@foxmail.com
Commit author: Chao Yu<chao@kernel.org>

Status in newer kernel trees:
6.15.y | Present (exact SHA1)
6.14.y | Present (different SHA1: 7f90e5d423cd)

Note: The patch differs from the upstream commit:
---
1:  986c50f6bca10 ! 1:  7a4b17ea75981 f2fs: fix to avoid accessing uninitialized curseg
    @@ Metadata
      ## Commit message ##
         f2fs: fix to avoid accessing uninitialized curseg
     
    +    [ Upstream commit 986c50f6bca109c6cf362b4e2babcb85aba958f6 ]
    +
         syzbot reports a f2fs bug as below:
     
         F2FS-fs (loop3): Stopped filesystem due to reason: 7
    @@ Commit message
         Closes: https://lore.kernel.org/all/67973c2b.050a0220.11b1bb.0089.GAE@google.com
         Signed-off-by: Chao Yu <chao@kernel.org>
         Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
    +    Signed-off-by: Alva Lan <alvalan9@foxmail.com>
     
      ## fs/f2fs/inode.c ##
     @@ fs/f2fs/inode.c: int f2fs_write_inode(struct inode *inode, struct writeback_control *wbc)
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.12.y       |  Success    |  Success   |

