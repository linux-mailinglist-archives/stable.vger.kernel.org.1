Return-Path: <stable+bounces-100206-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B3D779E9907
	for <lists+stable@lfdr.de>; Mon,  9 Dec 2024 15:35:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2611D282FE4
	for <lists+stable@lfdr.de>; Mon,  9 Dec 2024 14:35:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 424991B422F;
	Mon,  9 Dec 2024 14:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BRDkz1AN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 016A723313D
	for <stable@vger.kernel.org>; Mon,  9 Dec 2024 14:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733754937; cv=none; b=owxl8RefAlAHZxptt7ziG/GYm780ub0FFb1znu6O+qDHEx9PdHlJJMTDRqmBFOWelbPQK1acv2wlC0mSjo8C1E4m9F7RQWVePZrwRjaf1X7KhdNi1YIVFm1f1ESd1juEFXEH4qdlakhvvtAHCQ0SCLYw+uLXdtpolj2ifZcyWsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733754937; c=relaxed/simple;
	bh=TR3c8PWnwHfiPoI6Akfn5ziQ+T/XG+Q0PoggyiiEMbU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mWFAKRduCRa7SewfEgHzAQW4szOn7EMXE6B/nYdv6uy7zkCKvi13e8rya77ekONYuvN16DgXxYGQvMqgiY9VqAvsmHghRrO59YhprW6AnlEB0RSboY6a9uRb6A4cQnEQh5SKr/vwzRr8evMBHpPMdYU70ZsLPjNEmrex8Co6PtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BRDkz1AN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65FC2C4CED1;
	Mon,  9 Dec 2024 14:35:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733754936;
	bh=TR3c8PWnwHfiPoI6Akfn5ziQ+T/XG+Q0PoggyiiEMbU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BRDkz1ANymWpAaM9A46aK509+SdZdvbrXJv3LuWHnVUsl+ALukhgBtu/C8m7QwNGo
	 q5rs3V0mm5Zi2+wHBNdc4Ig8hboRE21ak8s4pJEfq62mmDmDoRnASLwFfpz3zab24L
	 IrgQ6kNxrNB5xsEYUxBU36PvF8nI2UQuUj+HxXpJmNN3lRqJLfxO/O/QnD5IPvrLra
	 Yd6CE0m9Xkf8WPUQMMcPU1mLa7zDKqFNBRsQVkZJSBjh089ycpDB+jouel2bi77/At
	 JM16912LCYlLYZlcFQRmGPOImCcvgCeJrF+lOWv9Df3sGNzLytD3QCHUyykuGVxFJD
	 pu5qUKYuQiyjQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: jianqi.ren.cn@windriver.com,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1.y] smb: client: fix potential UAF in cifs_dump_full_key()
Date: Mon,  9 Dec 2024 09:35:34 -0500
Message-ID: <20241209073004-369e2ddeed4bb454@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241209042244.3426179-1-jianqi.ren.cn@windriver.com>
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
1:  58acd1f497162 ! 1:  805e5ef97956b smb: client: fix potential UAF in cifs_dump_full_key()
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
      					ses = ses_it;
      					/*
      					 * since we are using the session outside the crit
    -@@ fs/smb/client/ioctl.c: static int cifs_dump_full_key(struct cifs_tcon *tcon, struct smb3_full_key_debug
    + 					 * section, we need to make sure it won't be released
      					 * so increment its refcount
      					 */
    - 					cifs_smb_ses_inc_refcount(ses);
    ++
    ++					lockdep_assert_held(&cifs_tcp_ses_lock);
    + 					ses->ses_count++;
     +					spin_unlock(&ses_it->ses_lock);
      					found = true;
      					goto search_end;
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

