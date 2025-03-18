Return-Path: <stable+bounces-124819-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1AA1A6775D
	for <lists+stable@lfdr.de>; Tue, 18 Mar 2025 16:13:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A85DA3B8A5B
	for <lists+stable@lfdr.de>; Tue, 18 Mar 2025 15:12:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25BAC20E700;
	Tue, 18 Mar 2025 15:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zw5s3XEJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9BDC20A5E5
	for <stable@vger.kernel.org>; Tue, 18 Mar 2025 15:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742310768; cv=none; b=rizJ+/0b8EL8pbehHTsglC5xub4L9IRYZoB9BlMhKGp1urolRWGM2LJM0cUhDruvDVch3qV1imS9NmkAc7mnha0zBrooysS//MTew282tnjlvsmkq4FMRr9N2DerZ1ntuxnobcmj2jjiZxkMo0Mg5WuQ2etT3t8hhStaLX1mRgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742310768; c=relaxed/simple;
	bh=0KiltTi/H/knPweV5fMxOgH24xO0eIeLVgzzjz9UaHw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TZViyo5TPHzsgefBS4lH2S0gI9Lo7Z7s8OTJ7crlPFY/wl8O9BVUwt6hs/LU8EO1lxbczgUYEWTUygf6wbRyNudV3bmGkHtCaKQBfbZJgrt1Khk8BDzIbVLcbky8w/URehsmjXiAX/PJ1EuxtSSSpYNNb92tJU9kWDbDYthhtR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zw5s3XEJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E402AC4CEDD;
	Tue, 18 Mar 2025 15:12:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742310768;
	bh=0KiltTi/H/knPweV5fMxOgH24xO0eIeLVgzzjz9UaHw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Zw5s3XEJzxWCWgXO5x3L4QXArXahQ7eE2/3oMIOftZ8UH9DMsg8u6t83GszibA+TY
	 zrG0s+vzLeA1tfRPPHzqoVECnH38SOZlxde9F44aHTDsP1flgA7nRGYY7e8H9pMfjy
	 G5I3fcpsRrQbpvNxQifHqCdbfVT24l1urcfvrcinn69dmIETh1w+hgXZAbN9LkkLL3
	 SShngDhvsk+FhkC7NYCBKdULjTxbbTdzY3dl6PnEwV7YLiJrs0DxWeZHLxv0BgPvdY
	 tcPH6QWX0Vmi2FsmZd9LH5YPQk5SvRZhsioHlBX6RZ2cpRxaBafFwDgbiGDcMXFAmR
	 twKDdVLUjbkMg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	henrique.carvalho@suse.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15.y] smb: client: Fix match_session bug preventing session reuse
Date: Tue, 18 Mar 2025 11:12:46 -0400
Message-Id: <20250317205350-054a32c01eb5e099@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250317222108.2656094-1-henrique.carvalho@suse.com>
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
6.6.y | Present (different SHA1: 3fbc1e703fba)
6.1.y | Present (different SHA1: d4942cd6ac83)

Note: The patch differs from the upstream commit:
---
1:  605b249ea9677 ! 1:  b3ee73e91ec7f smb: client: Fix match_session bug preventing session reuse
    @@ Commit message
         Reviewed-by: Enzo Matsumiya <ematsumiya@suse.de>
         Signed-off-by: Henrique Carvalho <henrique.carvalho@suse.com>
         Signed-off-by: Steve French <stfrench@microsoft.com>
    +    (cherry picked from commit 605b249ea96770ac4fac4b8510a99e0f8442be5e)
     
    - ## fs/smb/client/connect.c ##
    -@@ fs/smb/client/connect.c: static int match_session(struct cifs_ses *ses,
    - 			 struct smb3_fs_context *ctx,
    - 			 bool match_super)
    + ## fs/cifs/connect.c ##
    +@@ fs/cifs/connect.c: cifs_get_tcp_session(struct smb3_fs_context *ctx)
    + 
    + static int match_session(struct cifs_ses *ses, struct smb3_fs_context *ctx)
      {
     -	if (ctx->sectype != Unspecified &&
     -	    ctx->sectype != ses->sectype)
    @@ fs/smb/client/connect.c: static int match_session(struct cifs_ses *ses,
     +	struct TCP_Server_Info *server = ses->server;
     +	enum securityEnum ctx_sec, ses_sec;
      
    - 	if (!match_super && ctx->dfs_root_ses != ses->dfs_root_ses)
    - 		return 0;
    -@@ fs/smb/client/connect.c: static int match_session(struct cifs_ses *ses,
    - 	if (ses->chan_max < ctx->max_channels)
    - 		return 0;
    + 	/*
    + 	 * If an existing session is limited to less channels than
    +@@ fs/cifs/connect.c: static int match_session(struct cifs_ses *ses, struct smb3_fs_context *ctx)
    + 	}
    + 	spin_unlock(&ses->chan_lock);
      
     -	switch (ses->sectype) {
     +	ctx_sec = server->ops->select_sectype(server, ctx->sectype);
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
| stable/linux-5.15.y       |  Success    |  Success   |

