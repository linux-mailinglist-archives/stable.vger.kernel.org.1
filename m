Return-Path: <stable+bounces-99969-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5D829E76C6
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 18:11:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81212161E1A
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 17:11:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 350BE1F3D49;
	Fri,  6 Dec 2024 17:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vATWLiWZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9E04206274
	for <stable@vger.kernel.org>; Fri,  6 Dec 2024 17:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733505103; cv=none; b=DMYXA1kqC39Xivj+dPUqx0JCy/bblpLcD3ZdeQvxEFwDY9NU5GjN9VwdZvisT7qjdyGlIpouvpbmZomiIwGuOvy7j0PY3qbaWfAxW7cVC/Y5Q8pHcJcwlzKNQ4Q7Uf1FjS5XqwOgMG6SftzJdEAUuzQyK2nslXAK2i5X1QzCVkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733505103; c=relaxed/simple;
	bh=Pemp6MioKF7pZs+1Z+XzVqGBbwIXT0SPYWcFjLXWNPk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qqDdddyE9ABiFBUoOPL+ILTtZCFBKH6eRNKMc12jxIBIhM2XIuj+4ID3tcnXCp8GGsu9qWYf7Malvg7ui5MA+U5rjnx+FDR/2Qto4SaaF8FdjhO1SKYeIgoKloiiX8tkonHBrSc+gsmjEQrhKLLminPNFGhZi6V0d40vwN2a6zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vATWLiWZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DF82C4CED1;
	Fri,  6 Dec 2024 17:11:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733505102;
	bh=Pemp6MioKF7pZs+1Z+XzVqGBbwIXT0SPYWcFjLXWNPk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vATWLiWZYrCCrGeCpnaw5SNZ3vEAT0MA/mBr6NTZw/MoFWOnaCymO8+LqQf49cXfl
	 KadUh4TwrANslKO8hK/4ryqjLW2CDJzH+0C+CNO9foq3baGL+Uc2oWCp7vHvNpldaj
	 2+4Z1lka0g2fqMjAKrl1/8vxMubydbLBp67RC1csTLBAkmRzbr1B99eLxLep470Iji
	 U7ab0vNHAD81Lfqb3SuV/uu/c8FpNmksoGYeWcomWhLZyvSlq/AKXNaL3Ek3sila4W
	 pj1oUeJlLytzR0FtacmgxAGVA501MbEfF4Q9+qS8LlXGc/ksl08b/BRiMxaKXPGKMT
	 Ohkn6zbR6odCA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: jianqi.ren.cn@windriver.com,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1.y] smb: client: fix potential UAF in cifs_dump_full_key()
Date: Fri,  6 Dec 2024 12:11:41 -0500
Message-ID: <20241206111256-319b6f6758b258e9@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241206081436.110958-1-jianqi.ren.cn@windriver.com>
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
1:  58acd1f497162 ! 1:  f6a073ae8cb4f smb: client: fix potential UAF in cifs_dump_full_key()
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

