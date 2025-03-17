Return-Path: <stable+bounces-124726-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59BEDA65A75
	for <lists+stable@lfdr.de>; Mon, 17 Mar 2025 18:20:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02713178AD7
	for <lists+stable@lfdr.de>; Mon, 17 Mar 2025 17:19:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56BCE1C3C04;
	Mon, 17 Mar 2025 17:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MsVIpf9R"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 158491A238C
	for <stable@vger.kernel.org>; Mon, 17 Mar 2025 17:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742231819; cv=none; b=Vvi4ch1YYagqX67Kba1/6q8iCkvtXv4HO0nnkzSLy+/PBxdSGL2ev4CQEpoV6JVIa7ZDqGpXS4//Lai5tANEL+WeqC2KtFb7qamqLofFtCEZ9YszAhu5Aavktmzxd8Z/bseDCunWon+oAM+1IgFPpSa07ZuP6X1L+YnZ+ysL3E8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742231819; c=relaxed/simple;
	bh=AzUBR5dz1M7D8zXK3uWmEwHuXFXbFc0p+Vgw4axj+4g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qLQeVbe8++ANFf/mh9eCHB2zdHyIrDWUz25SZeVZN7xg7QcXLdcyvY8SVC0Yby5//EKeYZxRJge1iVukcmdsSrAxRZTwD3DWgqFO2HKzqUkZR7HETrtSI7FIkyiDiVq/UAlfX/C71oQTX+c5aQ9G73cPwlaMMZm1FN3le6SmOiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MsVIpf9R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AC16C4CEE3;
	Mon, 17 Mar 2025 17:16:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742231818;
	bh=AzUBR5dz1M7D8zXK3uWmEwHuXFXbFc0p+Vgw4axj+4g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MsVIpf9R1AIjpq/2aI4fyvpomGeDdqqBQVzGMm/QIgc0zbCPltmHBJ6uq/k8RXYCR
	 GQBCMEu/nwEiNwdICX3fbJCgAwkgTqCAuMn3ai8wR9jnh8YjhAXOPx6V4Be/iI/qc/
	 X1y73pVovnk6CxgMszapcRaovQuSk+Gtbb7OyVzlat1d5mwBqE7Ubp+lk1/69FMaLm
	 ZF6T1eZqA4LgT2VSbn6OIJVaqzIpaNA6G2X1D4BKHDyDHWLmkXNHAAzbD64yRr3Hyy
	 IYogOXhAMVrE3iZnLt8sjBidA7r9rjgXDe9uYBCxepdLZ81jQzAf6x3X42JnkbJRSY
	 baZGsoC6Lp5rg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	henrique.carvalho@suse.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.13.y] smb: client: Fix match_session bug preventing session reuse
Date: Mon, 17 Mar 2025 13:16:57 -0400
Message-Id: <20250317130538-d4beb1a989bc88cf@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250317153224.2195879-1-henrique.carvalho@suse.com>
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
❌ Build failures detected
⚠️ Found matching upstream commit but patch is missing proper reference to it

Found matching upstream commit: 605b249ea96770ac4fac4b8510a99e0f8442be5e

Note: The patch differs from the upstream commit:
---
1:  605b249ea9677 ! 1:  29e0a26570fa5 smb: client: Fix match_session bug preventing session reuse
    @@ Commit message
         Reviewed-by: Enzo Matsumiya <ematsumiya@suse.de>
         Signed-off-by: Henrique Carvalho <henrique.carvalho@suse.com>
         Signed-off-by: Steve French <stfrench@microsoft.com>
    +    (cherry picked from commit 605b249ea96770ac4fac4b8510a99e0f8442be5e)
     
      ## fs/smb/client/connect.c ##
     @@ fs/smb/client/connect.c: static int match_session(struct cifs_ses *ses,
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.13.y       |  Success    |  Failed    |

Build Errors:
Build error for stable/linux-6.13.y:
    fs/smb/client/connect.c: In function 'match_session':
    fs/smb/client/connect.c:1896:14: error: 'IAKerb' undeclared (first use in this function)
     1896 |         case IAKerb:
          |              ^~~~~~
    fs/smb/client/connect.c:1896:14: note: each undeclared identifier is reported only once for each function it appears in
    make[5]: *** [scripts/Makefile.build:196: fs/smb/client/connect.o] Error 1
    make[5]: Target 'fs/smb/client/' not remade because of errors.
    make[4]: *** [scripts/Makefile.build:442: fs/smb/client] Error 2
    make[4]: Target 'fs/smb/' not remade because of errors.
    make[3]: *** [scripts/Makefile.build:442: fs/smb] Error 2
    make[3]: Target 'fs/' not remade because of errors.
    make[2]: *** [scripts/Makefile.build:442: fs] Error 2
    make[2]: Target './' not remade because of errors.
    make[1]: *** [/home/sasha/build/linus-next/Makefile:1989: .] Error 2
    make[1]: Target '__all' not remade because of errors.
    make: *** [Makefile:251: __sub-make] Error 2
    make: Target '__all' not remade because of errors.

