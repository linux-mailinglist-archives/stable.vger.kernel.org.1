Return-Path: <stable+bounces-160106-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D6950AF8038
	for <lists+stable@lfdr.de>; Thu,  3 Jul 2025 20:36:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 493347BA42B
	for <lists+stable@lfdr.de>; Thu,  3 Jul 2025 18:35:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68B2E2F5461;
	Thu,  3 Jul 2025 18:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CR16Ffwa"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A1D32F533D
	for <stable@vger.kernel.org>; Thu,  3 Jul 2025 18:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751567691; cv=none; b=I7PVwdcki6Q1+uh5KAHot4huVDfjOysrQjGAj2rHGq4oNdn37yZAxtb9P1BwKTWC8MraVt0++byHrD5CsZVMBd+89srEVd9K131cBC866GHoMhIPsthrIJHNevoRuI6x7JrFi9rNDNHiQXP5N18mmxi8mASdVpZyTimQsXEAruQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751567691; c=relaxed/simple;
	bh=lw2dIOkzi03NSmX7FioAOiP4HXyKOkgvvPmvw8+cgAg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oAxRT7z/MRXDJFF6A/P2J58a4Kv5uI91E9kacdzSwMsgmM17RFHhow6ER2OSQpHdquyai7F0f9E30oBx+6z/jaatZQRZAXoDYeuILwAsd40gFofu48B94gj3A6oZFX4laz9xMmtI384JXWiNjLdLZynqNosY5OVZ/usma/7/OOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CR16Ffwa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FE49C4CEED;
	Thu,  3 Jul 2025 18:34:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751567690;
	bh=lw2dIOkzi03NSmX7FioAOiP4HXyKOkgvvPmvw8+cgAg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CR16FfwaKRf/2XH9ctPAsgb2iUq0+ecfpK5TxPrWtvPKDACx2D2ujwMU9bXiMqtcx
	 Jm03cXv2K4MntxXG5OlTM6R7D8uiEFsTCep+SY8+ogTxH1zkCRgZw7af4xSBSAoB+X
	 iVz7V1Zc+Quq7wNAXsgn5+3dhj+oY58ovj6Y4eV0Mavw0yC1MdigT5uGPRJHSJN5Pc
	 eyMoERoPklq+2N4dYUDuQKLdeuC6I0KHwWUV/0cbxWnp2vGyWsfr6/cEUz4iw9e/OH
	 gnI+OAPKrwRkU1uGUOeCAgOChDom8rmV3a0E1JdWPtBzk0599NqHDTDKxN5LxsaQJN
	 wDR5/8dwU0H1w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Aditya Dutt <duttaditya18@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15.y] jfs: fix null ptr deref in dtInsertEntry
Date: Thu,  3 Jul 2025 14:34:49 -0400
Message-Id: <20250703105304-2df1b0f7c178da90@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250702185936.68245-1-duttaditya18@gmail.com>
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

The upstream commit SHA1 provided is correct: ce6dede912f064a855acf6f04a04cbb2c25b8c8c

WARNING: Author mismatch between patch and upstream commit:
Backport author: Aditya Dutt<duttaditya18@gmail.com>
Commit author: Edward Adam Davis<eadavis@qq.com>

Status in newer kernel trees:
6.15.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (different SHA1: 6ea10dbb1e6c)
6.1.y | Present (different SHA1: 53023ab11836)

Note: The patch differs from the upstream commit:
---
1:  ce6dede912f06 ! 1:  13f964bdcd97f jfs: fix null ptr deref in dtInsertEntry
    @@ Metadata
      ## Commit message ##
         jfs: fix null ptr deref in dtInsertEntry
     
    +    [ Upstream commit ce6dede912f064a855acf6f04a04cbb2c25b8c8c ]
    +
         [syzbot reported]
         general protection fault, probably for non-canonical address 0xdffffc0000000001: 0000 [#1] PREEMPT SMP KASAN PTI
         KASAN: null-ptr-deref in range [0x0000000000000008-0x000000000000000f]
    @@ Commit message
         After got the page, check freelist first, if freelist == 0 then exit dtInsert()
         and return -EINVAL.
     
    +    Closes: https://syzkaller.appspot.com/bug?extid=30b3e48dc48dd2ad45b6
    +    Reported-by: syzbot+30b3e48dc48dd2ad45b6@syzkaller.appspotmail.com
         Reported-by: syzbot+bba84aef3a26fb93deb9@syzkaller.appspotmail.com
         Signed-off-by: Edward Adam Davis <eadavis@qq.com>
         Signed-off-by: Dave Kleikamp <dave.kleikamp@oracle.com>
    +    Signed-off-by: Aditya Dutt <duttaditya18@gmail.com>
     
      ## fs/jfs/jfs_dtree.c ##
     @@ fs/jfs/jfs_dtree.c: int dtInsert(tid_t tid, struct inode *ip,
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.15.y       |  Success    |  Success   |

