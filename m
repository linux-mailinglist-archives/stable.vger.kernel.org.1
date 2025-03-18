Return-Path: <stable+bounces-124824-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1FCFA6775C
	for <lists+stable@lfdr.de>; Tue, 18 Mar 2025 16:13:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B5F717B3D3
	for <lists+stable@lfdr.de>; Tue, 18 Mar 2025 15:13:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89F8C20CCE7;
	Tue, 18 Mar 2025 15:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t1DRtzr8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C59E1586C8
	for <stable@vger.kernel.org>; Tue, 18 Mar 2025 15:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742310779; cv=none; b=lyxClKsPyerzlIz8UwpjizlfmEhOAOleNZBKRqF2ga9HyGFz8wU7IjJpUxNg7NOY54bmQVwWdl7FwE5JvObMJhhbcRH2HDX2j51R4FeBhz3qZXv3VUBfvC1Yf4QeDyV6YS/jOD/Sjag82w5gj5ZCWtMaVXsF/1BCBMHFfR0ecqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742310779; c=relaxed/simple;
	bh=9r/8zatx/wCNy8TiDYbKvdJ0MaC45JuuiIvSeLBV51s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=omMRTdAKAxmeSo13WapaUvYujXLkUAEGycCQ+OjQ1KYhDV0dI53O7823XPxhEbL0ZCyHO+DCJJHz4HXQqp3hp4VwdNanhxqwbGaiRGgSn6FzdrF9IW51jOH6Fv1Mg1RwIGZIF1htt8P2ooQJK8I8Hgxx5tpjdiEzJraqge0+4oA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t1DRtzr8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 576C7C4CEDD;
	Tue, 18 Mar 2025 15:12:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742310778;
	bh=9r/8zatx/wCNy8TiDYbKvdJ0MaC45JuuiIvSeLBV51s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=t1DRtzr89b0NjB8eW+So52xwIJ+c+t0yQxrTKkRP0lDnd8j0RCUi3r6LwEgsVZYGN
	 39Z/bMLay5EqKVmx9iShLISDXplwqoKZVgrCCSeYDRqgRhkBtRHJPeo2hziBTUzO0e
	 oO18qEhjDLRutrKYGE3EduuZruuiGDwv89rIDt5pklXchIggXS3N7kXHL4zA17gQ8G
	 3silIsHDaChmGJuaFN7Ds1Sq1VboXOIXtfYTdn3CzwqyN02pf/QephE/rNeE+6hrv/
	 vA+yYzlLcgZbOsh3wx7rfXMc1nBrVhxmLIUbxPtHTaXtvhOu4DOBFl2YMdPZRg3ARk
	 D1jW8aE+xAYBA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	henrique.carvalho@suse.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.6.y] smb: client: Fix match_session bug preventing session reuse
Date: Tue, 18 Mar 2025 11:12:57 -0400
Message-Id: <20250317203959-7fb38f90f42a785a@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250317215800.2608506-1-henrique.carvalho@suse.com>
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

Summary of potential issues:
⚠️ Found matching upstream commit but patch is missing proper reference to it

Found matching upstream commit: 605b249ea96770ac4fac4b8510a99e0f8442be5e

Status in newer kernel trees:
6.13.y | Present (different SHA1: 4a133bda03ec)
6.12.y | Present (different SHA1: 3d48d46299be)

Note: The patch differs from the upstream commit:
---
1:  605b249ea9677 ! 1:  4bb32947f2ce5 smb: client: Fix match_session bug preventing session reuse
    @@ Commit message
         Reviewed-by: Enzo Matsumiya <ematsumiya@suse.de>
         Signed-off-by: Henrique Carvalho <henrique.carvalho@suse.com>
         Signed-off-by: Steve French <stfrench@microsoft.com>
    +    (cherry picked from commit 605b249ea96770ac4fac4b8510a99e0f8442be5e)
     
      ## fs/smb/client/connect.c ##
    -@@ fs/smb/client/connect.c: static int match_session(struct cifs_ses *ses,
    - 			 struct smb3_fs_context *ctx,
    - 			 bool match_super)
    +@@ fs/smb/client/connect.c: cifs_get_tcp_session(struct smb3_fs_context *ctx,
    + /* this function must be called with ses_lock and chan_lock held */
    + static int match_session(struct cifs_ses *ses, struct smb3_fs_context *ctx)
      {
     -	if (ctx->sectype != Unspecified &&
     -	    ctx->sectype != ses->sectype)
    @@ fs/smb/client/connect.c: static int match_session(struct cifs_ses *ses,
     +	struct TCP_Server_Info *server = ses->server;
     +	enum securityEnum ctx_sec, ses_sec;
      
    - 	if (!match_super && ctx->dfs_root_ses != ses->dfs_root_ses)
    + 	if (ctx->dfs_root_ses != ses->dfs_root_ses)
      		return 0;
    -@@ fs/smb/client/connect.c: static int match_session(struct cifs_ses *ses,
    +@@ fs/smb/client/connect.c: static int match_session(struct cifs_ses *ses, struct smb3_fs_context *ctx)
      	if (ses->chan_max < ctx->max_channels)
      		return 0;
      
    @@ fs/smb/client/connect.c: static int match_session(struct cifs_ses *ses,
     +		return 0;
     +
     +	switch (ctx_sec) {
    -+	case IAKerb:
      	case Kerberos:
      		if (!uid_eq(ctx->cred_uid, ses->cred_uid))
      			return 0;
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.6.y        |  Success    |  Success   |

