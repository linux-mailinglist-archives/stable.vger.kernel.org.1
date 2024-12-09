Return-Path: <stable+bounces-100209-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA1EB9E990D
	for <lists+stable@lfdr.de>; Mon,  9 Dec 2024 15:35:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACDCB1887FDC
	for <lists+stable@lfdr.de>; Mon,  9 Dec 2024 14:35:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 767871B4230;
	Mon,  9 Dec 2024 14:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CnXodsp4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35A561B4234
	for <stable@vger.kernel.org>; Mon,  9 Dec 2024 14:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733754943; cv=none; b=mbKDiNE6viBnjkA8et5wO0QQDfgsGJXnAaoEeP1PiJjzQrEH4Q0RqDuH+Ib22+NgvC88VHH9C4fXANL0YRUYDKLF72Ys0IEdeJq27EIbhdMyqTG/GZbDtEVhsaXjy2TaUAk88mufki6MbtfwhG85eFnn+agCDs0KjJvmdOCqqBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733754943; c=relaxed/simple;
	bh=1aB3j44UBlMMFLNXb7f3BplJRSLBFjVS2NGcvyDM/Q8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gbIEwGGvmcEE1QqoN8HMp+t1XdBb1rGKrExcZQ+Fu33/7VcNDb2YYzbjtRDraxFrXX7bUUMv84aW86tjXyFzcDE8Hr9VdPuOCXRMjxVcU/+rv2jab1h3PyzYC06OBJJVo+SBtqMihpX4K1p2A6V47bFRk+MtE1jI3/UxCGlYUmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CnXodsp4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93557C4CED1;
	Mon,  9 Dec 2024 14:35:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733754943;
	bh=1aB3j44UBlMMFLNXb7f3BplJRSLBFjVS2NGcvyDM/Q8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CnXodsp4f7hjX3UIOfWN1LcSa5mlOy1KUjgGs1OJ3BeB4a6/7H//5PYbm1RHwKd96
	 yALo7VNtJm188RFFsDGR46JBGdPFWZSqPnpW+Gk2eVpo/NfSZFQ89D37VdoocOIaxj
	 weXlbXrQilHKwEzRJ4oGzYU9rOVw2J14Nc4hmtjwdtgQls8pcSlkhWq7Ar9vpkYgrj
	 p2Fio1f+CgfCNxrcNkZrF7AAnWQBVhnojDM+3IsItxWqIv+LEimPPw8W+RULF7OWrZ
	 chbdTGrk0TNb53mn4BOY+bx7z2N0X7Af3V8iXX48FDL1Y/htQjeC1vB8CMTdSAHPLm
	 qAEng1jj01j2A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: jianqi.ren.cn@windriver.com,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1.y] smb: client: fix potential UAF in cifs_dump_full_key()
Date: Mon,  9 Dec 2024 09:35:41 -0500
Message-ID: <20241209080045-0d421b695507fac2@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241209085813.823573-1-jianqi.ren.cn@windriver.com>
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

The upstream commit SHA1 provided is correct: 58acd1f497162e7d282077f816faa519487be045

WARNING: Author mismatch between patch and upstream commit:
Backport author: <jianqi.ren.cn@windriver.com>
Commit author: Paulo Alcantara <pc@manguebit.com>


Status in newer kernel trees:
6.12.y | Present (exact SHA1)
6.6.y | Present (different SHA1: 10e17ca4000e)
6.1.y | Not found

Note: The patch differs from the upstream commit:
---
1:  58acd1f497162 ! 1:  8fb3f4007b3be smb: client: fix potential UAF in cifs_dump_full_key()
    @@ Metadata
      ## Commit message ##
         smb: client: fix potential UAF in cifs_dump_full_key()
     
    +    [ Upstream commit 58acd1f497162e7d282077f816faa519487be045 ]
    +
         Skip sessions that are being teared down (status == SES_EXITING) to
         avoid UAF.
     
         Cc: stable@vger.kernel.org
         Signed-off-by: Paulo Alcantara (Red Hat) <pc@manguebit.com>
         Signed-off-by: Steve French <stfrench@microsoft.com>
    +    Signed-off-by: Jianqi Ren <jianqi.ren.cn@windriver.com>
     
      ## fs/smb/client/ioctl.c ##
     @@ fs/smb/client/ioctl.c: static int cifs_dump_full_key(struct cifs_tcon *tcon, struct smb3_full_key_debug
    @@ fs/smb/client/ioctl.c: static int cifs_dump_full_key(struct cifs_tcon *tcon, str
     @@ fs/smb/client/ioctl.c: static int cifs_dump_full_key(struct cifs_tcon *tcon, struct smb3_full_key_debug
      					 * so increment its refcount
      					 */
    - 					cifs_smb_ses_inc_refcount(ses);
    + 					ses->ses_count++;
     +					spin_unlock(&ses_it->ses_lock);
      					found = true;
      					goto search_end;
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

