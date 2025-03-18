Return-Path: <stable+bounces-124822-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5398FA6777B
	for <lists+stable@lfdr.de>; Tue, 18 Mar 2025 16:16:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87B5C19A5B0F
	for <lists+stable@lfdr.de>; Tue, 18 Mar 2025 15:13:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75F7020E703;
	Tue, 18 Mar 2025 15:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HqCsOTrk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 375531586C8
	for <stable@vger.kernel.org>; Tue, 18 Mar 2025 15:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742310775; cv=none; b=oZc8gAV5QcaAdTLYJF9+1cgMUSR/Ew2UZdiexm94GiNt3AxbbEtu4XFfSPMecl/ptOQx3a+ZQ8bu/K3wsxikAgT4Gnm0cjsHk+7f8v3yg6ywZDfD42dvRDgacOybbtIrOk45+ZniwZBEcDnprf5c5OlcJl9K5x6TcnNuQB5NwI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742310775; c=relaxed/simple;
	bh=ocGEGyjoJtuJRCvKrGVsQ5i1QwxwhDjsI3N8SjuWmvQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FM9Iod2uHJRjcJR1mNZ6+S/cm6UiXUthrfgNrr65TBy0C4Uyo+j/w6VoUR4YAy/Yt5O5xlx5uzO+sgrE4ZHz7Jm6R4CEHDx2g84yWGB3IyqmAk1OYZtoYgvjeCfL/S6Sqea11cGmDa8yGdxDfqB+203SMDhljXFiuNhMBYQNgOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HqCsOTrk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BC50C4CEDD;
	Tue, 18 Mar 2025 15:12:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742310774;
	bh=ocGEGyjoJtuJRCvKrGVsQ5i1QwxwhDjsI3N8SjuWmvQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HqCsOTrk+yVr1slJSllso8RdAZRI4OkSWXGuRHzdpe+9VcpsUcn3WVc5AtOrpFVeO
	 Pk6f7j5tRmxut/QtA++GlQpyOi95kX8sjdj5ppfuRs25QJPcSzaRwd3UKHojK4ppL0
	 t/nDokOy1Zy0+YI5433znQTkiOn0xr6P1OFw83ZU44KujvYE7rQe+0QQiRgjGZMfyI
	 cJ66uVleF2+J1TuzUHin1g+6DkZf4fMv8MGXH4PburRcZzMuiGXUoow+5ecg6NShPM
	 NGgznjYkR7qhvf+Oktfvyr24huwZ1SytSqnDKW9KsXurnS4CyEtfs2my4ZRA6erd1s
	 XeYZcD8BSYUpA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	henrique.carvalho@suse.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1.y] smb: client: Fix match_session bug preventing session reuse
Date: Tue, 18 Mar 2025 11:12:52 -0400
Message-Id: <20250317204702-eac2b7fc286a666e@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250317223037.2785749-1-henrique.carvalho@suse.com>
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

Note: The patch differs from the upstream commit:
---
1:  605b249ea9677 ! 1:  d923b67f9a61f smb: client: Fix match_session bug preventing session reuse
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
    - 		return 0;
    -@@ fs/smb/client/connect.c: static int match_session(struct cifs_ses *ses,
    + 	/*
    + 	 * If an existing session is limited to less channels than
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
| stable/linux-6.1.y        |  Success    |  Success   |

