Return-Path: <stable+bounces-137079-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C2ACAA0C1B
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 14:50:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACCE5843E07
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 12:50:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FC062253F6;
	Tue, 29 Apr 2025 12:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jssFisAc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D491F2701C4
	for <stable@vger.kernel.org>; Tue, 29 Apr 2025 12:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745931032; cv=none; b=IaMXEcyK/AAy5Kgg6a3h3laTH4FyW6LzeOKGIQKdRLOeYjcQ93mbbO2MEsrdTkgxGvI9anGUXc014/K5CKip5vIPif9dTlygdAcPyNr7ci1y3sYXRMKRn5B6Dcv8U1ovL7nmxhfhq0tdMZCmF/021YMDzyxPhKGIWcfAjgMJWOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745931032; c=relaxed/simple;
	bh=Q7lxSs0xbK6Zfcs/pmEz3GXCjSdAJVmctGOsdHNeSEE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YrYbgfDpN+t8sCl70qx1WCmV31r5Lze0NW9pYM2AalvsUAYSXwKqKFgBmMwKieepwpnc8+NiWLIPOCUIk2WvNR0K54MTYt+8qKpNRFOWWwjAHqK4x0VQ7FbOvV3ThADWrMUcUO53E2a+ysmXqbA01OisyqouRW3CRCfmHTGkRac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jssFisAc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D610FC4CEE3;
	Tue, 29 Apr 2025 12:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745931031;
	bh=Q7lxSs0xbK6Zfcs/pmEz3GXCjSdAJVmctGOsdHNeSEE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jssFisAcyiJEExyJo4jTa9i0S1fIiz9Y1b2DfD1zovU09Y1qdDhrFszBbFxfqOoxN
	 vNoVyslsa88OweYqnf2x18kWa3u/YKMdC5+d1ZlSvIPbHCp222MuWXVM11u8J7lvmY
	 4nOtf9FgzXlNK+W+GHYl7ynCZkAyilHvJKYq3d6KQCgktdVoP5BjkVMUtTmd45BKo/
	 rVimVqdO/qWybOPSPcL82d6R39rclYkrUvJ92n4pArq19zhCRHnMOHLfu7MZVYm6Uk
	 UywN8h2ErA2JutwSH/NoPcMs9Q03yD+eeqnJypLT42/w1P7MVdtiORey3ickinBusB
	 aYCQsI6JBdo0A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Aditya Dutt <duttaditya18@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15.y] jfs: define xtree root and page independently
Date: Tue, 29 Apr 2025 08:50:28 -0400
Message-Id: <20250429010144-cc4c7c112c3ef809@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250427154539.96678-1-duttaditya18@gmail.com>
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
6.12.y | Present (exact SHA1)
6.6.y | Present (different SHA1: 2ff51719ec61)
6.1.y | Not found

Note: The patch differs from the upstream commit:
---
1:  a779ed754e52d ! 1:  cac2f05e71c44 jfs: define xtree root and page independently
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
    +    Reported-by: syzbot+ccb458b6679845ee0bae@syzkaller.appspotmail.com
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

