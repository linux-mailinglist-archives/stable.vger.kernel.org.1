Return-Path: <stable+bounces-100659-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8830B9ED1E8
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 17:32:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D16F11882794
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 16:32:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C3A71DD873;
	Wed, 11 Dec 2024 16:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L5BT8DFQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CC3F38DE9
	for <stable@vger.kernel.org>; Wed, 11 Dec 2024 16:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733934761; cv=none; b=einPiGlsWfXMiZljVZFStQkdqE+00n1ZUH1VcTxz5VggkM9/8nQ3Fqb5h3JFw1fcZ/iCRm+rPh0rHbpS8xm7VkWCtRDurlCZzFE8WjU1ZiPMdSqLmn5tZPZMjwvDtiJKNozGnw8gZ3z5ORDyjTKFw8Fe8i7IR4CrvcZfwF+a4XY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733934761; c=relaxed/simple;
	bh=AszIHfDRFKjiV0r4VZLGt90kiu8+uMPZgggz5GgmcFU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cA6DRN3v7LAPpf1tay6d2w/AqxJF37J2xU3VQep36wAglEKeTQYLZ0CxEgp8mFXeRFffN3r41y8Y3UqU3GXJusfvwv/4JMCl0JhIsh8OxxVeDMtcP3459fF5jLLgzQHx8QjAJzx1q3iQaevQqPxJMcQ5OkL80bo/oRcI1Z/yo5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L5BT8DFQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DFF0C4CED2;
	Wed, 11 Dec 2024 16:32:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733934761;
	bh=AszIHfDRFKjiV0r4VZLGt90kiu8+uMPZgggz5GgmcFU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=L5BT8DFQKV0D+/wQW0mzjwx0M3BBgoGj7q6E9K6yk/8WOEcbM+bT6wEqvMkWuz0yq
	 GqDI51TIkT09pF5P7ELWj8YlRq5v8VLEjCt+zHC1k0vOPjBysGcUsPAfeNvb1qK/X8
	 T1Rd/SYKCKBZwQrcZC+D5D5M1f9Z6R8aC3fVR+k4VrnkcDX8j5nS/HaXlXvpPRLwg8
	 miGxGj2PFEjcM4AEo6jAXOAW5CIGqZh1e5nNap7Drl3NDdlcheR1e1ikZgEkOQ4mVn
	 Bx1sgqn25R8W7NHbGhM1HGdy/eeVRM4K6MlcDeSPEGJAPPgYGxRZkJT2uPOJiveQaL
	 C+gshuYQRQc4Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: jianqi.ren.cn@windriver.com,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1.y] smb: client: fix potential UAF in cifs_dump_full_key()
Date: Wed, 11 Dec 2024 11:32:39 -0500
Message-ID: <20241211100810-0892add7b0dda557@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241211095950.2069548-1-jianqi.ren.cn@windriver.com>
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
1:  58acd1f497162 ! 1:  8f31ad3d67064 smb: client: fix potential UAF in cifs_dump_full_key()
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

