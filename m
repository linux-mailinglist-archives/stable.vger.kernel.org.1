Return-Path: <stable+bounces-124737-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DC208A65E7D
	for <lists+stable@lfdr.de>; Mon, 17 Mar 2025 20:52:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A01D17958F
	for <lists+stable@lfdr.de>; Mon, 17 Mar 2025 19:52:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6A611DE3DE;
	Mon, 17 Mar 2025 19:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DFdOHHti"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 968111A01D4
	for <stable@vger.kernel.org>; Mon, 17 Mar 2025 19:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742241119; cv=none; b=t3so0eCbM6UQiB0TN8jWnmHjH+G4ZWGXkLlMjZO/rajwewvKl1xPwse4+zsyEpqxo2a2J1ID9KgnFXi2VvNl1vXQPt3R7tKYFiO+x8GWt5Cmk5aiM1AURxuLYegNPIFRMFbE4bnoP2Gksb37ZXwXty8LLQ6s7m2pu5ydSKzktV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742241119; c=relaxed/simple;
	bh=FYaGJCV0OYPitwng4iSaKfa/Lb83Fq3OaTk/YVfyj/8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fX6A0mDONi+10Bn/D1gDfBZDAnFYHZm6YjouqISPkgBGz5wLy3YgmhNT1qTKqF1AuHOdncpDVLxzKlC/9ydacLOqXGVxWIwJZ7VoMK/TogSohKMlutixZkdkhdvv6xMk88uUDkNBqOSFWABqN617pg23+27KrEZUiN4UxS+FHpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DFdOHHti; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C514C4CEE3;
	Mon, 17 Mar 2025 19:51:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742241119;
	bh=FYaGJCV0OYPitwng4iSaKfa/Lb83Fq3OaTk/YVfyj/8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DFdOHHtiC4PTr9PS9wgF2fEptPwvBwHL5TqTEXdsC9yWyANDj3Dapt88V17OEcFPo
	 pXacLXOivcX/wRKkBFxsLVnDgjhhCUey5OGKP68dIQF03lrOj16EVcHeU7ToESBtd9
	 QbRzSITHZEs0msJEyZUHqyF6NHxmFGRH7X3DKormxYOCYJomiuNmIsO2pGosaK0Jqb
	 NJzmHJAL8L4A10VbXjLGYJeLKTwYu9hocv+k9gsAAWxOBKF44w0/ORFQk4nq2DmbyZ
	 WeQ48C2bVcE1QddFQJZKtLkDOPQvXgK+DJcvyNDGjBZVRYMkPlJ+FEUpk3xCqnf2Rr
	 LJlknwWPtb7tw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	henrique.carvalho@suse.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.13.y] smb: client: Fix match_session bug preventing session reuse
Date: Mon, 17 Mar 2025 15:51:57 -0400
Message-Id: <20250317154044-1e151d712e310112@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250317181622.2243629-1-henrique.carvalho@suse.com>
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
1:  605b249ea9677 ! 1:  09e6c5e075985 smb: client: Fix match_session bug preventing session reuse
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

