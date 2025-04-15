Return-Path: <stable+bounces-132804-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BD988A8ABD3
	for <lists+stable@lfdr.de>; Wed, 16 Apr 2025 01:07:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 023BE1902D50
	for <lists+stable@lfdr.de>; Tue, 15 Apr 2025 23:07:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4250E29DB7F;
	Tue, 15 Apr 2025 23:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oxxgB3DJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 012D22528E1
	for <stable@vger.kernel.org>; Tue, 15 Apr 2025 23:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744758429; cv=none; b=VVMmUxKQP2z79jpW2BfPuSmXiedMCk+hebhlpNqZ2Yi6uyuClsbiMH9Kq7HSaVOJIyZDClSyHq9Oki+GLhph5mPXEJXOoItBU1wBdplORFS0a4slB0Uyp+HmTJuTjiVh3X1wlvdfwtEFLMRjs9rcFxsivEU11CFhM6DnBltnZAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744758429; c=relaxed/simple;
	bh=s4DeAjlLm+2QvYKSFx+wnoP5diwyUyGqnkwKWlYSVaA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X1w3YE0am4+SPmwh+mX7Cq6NPGSSmO+K6BJsvPSUGfn9MBIhNXSGw8/3y8WwpN9TiEs20SZtJpdLbVaWbEj5ER2/M5qb0piBhunzeyfmE4wpky4Ryb4go162dKfXvikMUQsypVMhjVuNNtAzovrWzfWDaGFBGny76RFdpUBr/fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oxxgB3DJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 029E8C4CEE9;
	Tue, 15 Apr 2025 23:07:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744758428;
	bh=s4DeAjlLm+2QvYKSFx+wnoP5diwyUyGqnkwKWlYSVaA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oxxgB3DJnhBGNcmQ9rnkC7VlKxOWWV+7yR9w3SCkYf7v1IKC/7c2W+Q3UzaihGd5k
	 41uZLmDFkbmkJPmqobWKcqf3GdFWs+LNBRxYwOE+xpiGXERLP26K2Ptnmz/xpu9yqQ
	 lm6IYZ5XnIIEFvQbzHbFqn3iUzAeDai5hF3fCmyAFKOO1i4bJVJgKsKVaK+vM7Wlw2
	 1XUtw3dLMQNB69TXMKbawQck/X4f1J2Ab5jmap4dQDvko/36pBVUMgo7X/S8ZDRH5A
	 6seNAYtf+sgRuLZodoAOHixKOMGNryHmJubLMsdAswGQyMJEAqr8uK6cH7x4OywoSs
	 QysanQEMFa+Yg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Aditya Dutt <duttaditya18@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15.y] jfs: define xtree root and page independently
Date: Tue, 15 Apr 2025 19:07:06 -0400
Message-Id: <20250415180343-32dfa5d857ccbd65@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250415180939.397586-1-duttaditya18@gmail.com>
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

The upstream commit SHA1 provided is correct: a779ed754e52d582b8c0e17959df063108bd0656

WARNING: Author mismatch between patch and upstream commit:
Backport author: Aditya Dutt<duttaditya18@gmail.com>
Commit author: Dave Kleikamp<dave.kleikamp@oracle.com>

Status in newer kernel trees:
6.14.y | Present (exact SHA1)
6.13.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (different SHA1: 2ff51719ec61)
6.1.y | Not found

Note: The patch differs from the upstream commit:
---
1:  a779ed754e52d ! 1:  aaa01b34169c0 jfs: define xtree root and page independently
    @@ Metadata
      ## Commit message ##
         jfs: define xtree root and page independently
     
    +    [ Upstream commit a779ed754e52d582b8c0e17959df063108bd0656 ]
    +
         In order to make array bounds checking sane, provide a separate
         definition of the in-inode xtree root and the external xtree page.
     
         Signed-off-by: Dave Kleikamp <dave.kleikamp@oracle.com>
         Tested-by: Manas Ghandat <ghandatmanas@gmail.com>
    +    (cherry picked from commit a779ed754e52d582b8c0e17959df063108bd0656)
    +    Closes: https://syzkaller.appspot.com/bug?extid=ccb458b6679845ee0bae
    +    Signed-off-by: Aditya Dutt <duttaditya18@gmail.com>
     
      ## fs/jfs/jfs_dinode.h ##
     @@ fs/jfs/jfs_dinode.h: struct dinode {
    @@ fs/jfs/jfs_xtree.c: xtSplitRoot(tid_t tid,
      
      	INCREMENT(xtStat.split);
      
    -@@ fs/jfs/jfs_xtree.c: int xtAppend(tid_t tid,		/* transaction id */
    +@@ fs/jfs/jfs_xtree.c: static int xtRelink(tid_t tid, struct inode *ip, xtpage_t * p)
       */
      void xtInitRoot(tid_t tid, struct inode *ip)
      {
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.15.y       |  Success    |  Success   |

