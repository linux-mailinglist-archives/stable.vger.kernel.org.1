Return-Path: <stable+bounces-124855-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BADF6A67DCE
	for <lists+stable@lfdr.de>; Tue, 18 Mar 2025 21:12:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20E35168615
	for <lists+stable@lfdr.de>; Tue, 18 Mar 2025 20:12:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67991212F8F;
	Tue, 18 Mar 2025 20:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DFquKuPH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27167211A1E
	for <stable@vger.kernel.org>; Tue, 18 Mar 2025 20:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742328767; cv=none; b=VtrSJRX+httaJyLv8Pb3VVjMhh8QjJLik0JxMq9LD1PbgLDwCg+b0PY3wcxibUdj6XjPsS3vfmoCgRET0bJz2ojgOXEMnt9BtygiRPt+53FoXA7GD+CdI4sTJsYrDN6wiIv9GlwgoRFlbwMtYAnlZJVct2T6//gg9zUGIOrtY1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742328767; c=relaxed/simple;
	bh=sQbqc8cjY+6YRBUrU83ScAVzp4QVKU13RzBFs9b8SS8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mvQJUKyOwXUBlohMPCjhtO3sGmc/tBnvBzk7pTKx02oTAhceCrlGLNgLABaXDmDYC+kKnAhUtyMAxnZ3vPmnjd4c+YFysmawzKxKy+KX+fX4ASX4wGu6Rd4NoYU7lu9JoAaPARrG0+af5Lpru6HeoYanBMZngdjFPrOwFgPtryk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DFquKuPH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3C12C4CEEE;
	Tue, 18 Mar 2025 20:12:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742328766;
	bh=sQbqc8cjY+6YRBUrU83ScAVzp4QVKU13RzBFs9b8SS8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DFquKuPHfSjPvbVaj/Grg+55DG0O+EGo6fWmfdWVnjufC6BVFVI1nkBGSk5KIjS+V
	 ClewIzYrvppO08Pw0TzT1rPxskDQaxHlLtUiGdvKyyjDTrhmKmRLshCj77Umr2Ck/1
	 NaXh+ApcCB4sgiJ54xdAhjB2I7H6nG0RAotaz7JBZu543+rzYlKWbSGkB+A+gXZjlv
	 /j8NSfOL6iM8Cx6J/Muk3W2ITxtSrPMaumn25YyOjEusXYUTPt4XC4oi4kjLCIpsQJ
	 IsfGboXQnSxf8eX+YkvKfWzwgVccpdWm720zPbG2KMlKlR1A/9KF3hBT5GnZ/d1fO+
	 XV4ukU6C2J8iw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	henrique.carvalho@suse.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.13.y v3] smb: client: Fix match_session bug preventing session reuse
Date: Tue, 18 Mar 2025 16:12:44 -0400
Message-Id: <20250318161057-ae6bf14a4e6f7a26@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250318180821.2986424-1-henrique.carvalho@suse.com>
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

Note: The patch differs from the upstream commit:
---
1:  605b249ea9677 ! 1:  eee0817427b12 smb: client: Fix match_session bug preventing session reuse
    @@ Commit message
         Reviewed-by: Enzo Matsumiya <ematsumiya@suse.de>
         Signed-off-by: Henrique Carvalho <henrique.carvalho@suse.com>
         Signed-off-by: Steve French <stfrench@microsoft.com>
    +    (cherry picked from commit 605b249ea96770ac4fac4b8510a99e0f8442be5e)
     
      ## fs/smb/client/connect.c ##
     @@ fs/smb/client/connect.c: static int match_session(struct cifs_ses *ses,
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
| stable/linux-6.13.y       |  Success    |  Success   |

