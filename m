Return-Path: <stable+bounces-159101-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C81FCAEEBF6
	for <lists+stable@lfdr.de>; Tue,  1 Jul 2025 03:16:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E4F2C7A48B6
	for <lists+stable@lfdr.de>; Tue,  1 Jul 2025 01:15:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DF3F19AD89;
	Tue,  1 Jul 2025 01:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Av1TQZs+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CA1219995E
	for <stable@vger.kernel.org>; Tue,  1 Jul 2025 01:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751332538; cv=none; b=DppMbqoyIs28vfqnxw09mXSsM/FEoLZSLw77Ukng+g1gALUbIMY7yMdwrH+YcylzbDRoLbUayZF5vRwe9pR34oTycJRyzw27zLJXp0BUyGIk9pMu3ksgUNn59/dI2YShtbjmRGjh0xRgKAbcTxmdLql2zPQDVPsIp+2U9Aszq+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751332538; c=relaxed/simple;
	bh=pQ58y4WIRbuGHEBKnAKmi4XORngpYvsa/kz2BdChjhc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eWgnt0sHhJ0q/e1rfaR9P+weJMAzmIoOd8MiP4F6Z5OXtRzPN6COSPiDqulAMFUXJsiEecmeU59bE5BCx30R5Vos4H9IF7+NSf42Oi+5Wa5yGMTWjvYkmu4MGRhwlzjR2ujXeLAbmIWhmf4n55J/T8LvJwlM8xNKnJl+GuEjY2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Av1TQZs+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4702AC4CEF0;
	Tue,  1 Jul 2025 01:15:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751332537;
	bh=pQ58y4WIRbuGHEBKnAKmi4XORngpYvsa/kz2BdChjhc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Av1TQZs+iKjtvPv5ljPiCDecW1yGLBCJX2aAusBsa2gtCy9Xl7jbjRWI3VpFGplJf
	 bYY04HhdpdoFvo+Nm9WhoGjcZPEMyaJO62k3qSbAl1mx8Oig4IwMVQp0+vN37kt1ev
	 TQx7G4tKj72btIUls9V5d5bkZZjc6GDg5obx05BVJHSj1CaUsZHX6EM74htoip1sc2
	 NLYpsSry5y7RrxUx9Du5XoKuSnGuLvp+tlwxbju1o+rllCzo/2AfFoW7gOEXzlsA1d
	 czCC5ljPsmnpKVwx85CBQYKtxoXJR8N/dT2NwGW6VmdR8My2QkpoT7Gv6m2Oe7/wiO
	 x1w0KDAhuNrsQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Pranav Tyagi <pranav.tyagi03@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15.y] ocfs2: fix deadlock in ocfs2_get_system_file_inode
Date: Mon, 30 Jun 2025 21:15:36 -0400
Message-Id: <20250630143337-e1f4376cbeee4e8c@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250630083542.10121-1-pranav.tyagi03@gmail.com>
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

The upstream commit SHA1 provided is correct: 7bf1823e010e8db2fb649c790bd1b449a75f52d8

WARNING: Author mismatch between patch and upstream commit:
Backport author: Pranav Tyagi<pranav.tyagi03@gmail.com>
Commit author: Mohammed Anees<pvmohammedanees2003@gmail.com>

Status in newer kernel trees:
6.15.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (different SHA1: ec3e32de2d8a)
6.1.y | Not found

Note: The patch differs from the upstream commit:
---
1:  7bf1823e010e8 ! 1:  8b2350f85e550 ocfs2: fix deadlock in ocfs2_get_system_file_inode
    @@ Metadata
      ## Commit message ##
         ocfs2: fix deadlock in ocfs2_get_system_file_inode
     
    +    [ Upstream commit 7bf1823e010e8db2fb649c790bd1b449a75f52d8 ]
    +
         syzbot has found a possible deadlock in ocfs2_get_system_file_inode [1].
     
         The scenario is depicted here,
    @@ Commit message
     
         [1] https://syzkaller.appspot.com/bug?extid=e0055ea09f1f5e6fabdd
     
    +    [ Backport to 5.15: context cleanly applied with no semantic changes.
    +    Build-tested. ]
    +
         Link: https://lkml.kernel.org/r/20240924093257.7181-1-pvmohammedanees2003@gmail.com
         Signed-off-by: Mohammed Anees <pvmohammedanees2003@gmail.com>
         Reviewed-by: Joseph Qi <joseph.qi@linux.alibaba.com>
    @@ Commit message
         Cc: Jun Piao <piaojun@huawei.com>
         Cc:  <stable@vger.kernel.org>
         Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
    +    Signed-off-by: Pranav Tyagi <pranav.tyagi03@gmail.com>
     
      ## fs/ocfs2/extent_map.c ##
     @@ fs/ocfs2/extent_map.c: int ocfs2_read_virt_blocks(struct inode *inode, u64 v_block, int nr,
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.15.y       |  Success    |  Success   |

