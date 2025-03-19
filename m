Return-Path: <stable+bounces-124907-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C63FA68A10
	for <lists+stable@lfdr.de>; Wed, 19 Mar 2025 11:54:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5056219C2AE2
	for <lists+stable@lfdr.de>; Wed, 19 Mar 2025 10:54:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E78F0253F24;
	Wed, 19 Mar 2025 10:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="et5IfzjQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A87F525485B
	for <stable@vger.kernel.org>; Wed, 19 Mar 2025 10:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742381667; cv=none; b=s1aBzSN61TGA/rtWSvdOXDQ7bh8+0pi/ewRzBhXcs72rgNYIGy1EbejunM2DodIjv9RnpOyTvmhHra/QTNVeeNAKsmp3/mP9UPrLtN10H34qmqTTt0V5yBGv4CjOtT4Z/B7IDkDJ7ZSj7yjppspMxdKAwVd0F/rzRx04KTSvZQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742381667; c=relaxed/simple;
	bh=+Q+kztAe8X+wrCaR9UjZATBxp5Msb3rn/aB+g2c/84Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=maWVh5s2dh0448UnBqM9Gk5g3Na5DHq+uzntgy6JLbeHG/h2mEEPvWhHNH3bKffo5/tGJH/QG8bEmBwNPIQpBKDWwsHe42Sm5kGrBewbAALLMrXNZ8BQzu34d1pRy0MW8ydKvWFfzUsgjTAuf65wRb6yjWJRIf6WC3YSDPgQgQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=et5IfzjQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A212DC4CEE9;
	Wed, 19 Mar 2025 10:54:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742381667;
	bh=+Q+kztAe8X+wrCaR9UjZATBxp5Msb3rn/aB+g2c/84Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=et5IfzjQ6Zi7tfh4t1c1bwOpWy8Hnag8/vmd1txWweRwoTlv+hdaQdNMHdW0PEhOO
	 YHa3jD+P3kpyimVX7maMTlP1Eq4edK0Hqr2tp0O2SpKM2isIGC2xtV/nF63fSnDbGu
	 8tfFMQHdeb3SK3ahdaotgublQoulrHfsQha4Ra0sqYIa0YPtygliwCK7LH4Xv0HoJk
	 vt5uGyLHwxP6UMMOQ4Bm46AfK1vQx1F4NNiOpzIyGaAxWwANCGjW9A6vc0tDOLd0s4
	 DnKA8IWgTRKyV0EJNous5XmhyikVwZ+fbRJtpiVefXlz5BftOdh8NDG2QPj8nyWE8O
	 Hb921FeUdfZ5Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: jianqi.ren.cn@windriver.com,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1.y] smb: client: fix potential UAF in cifs_dump_full_key()
Date: Wed, 19 Mar 2025 06:54:25 -0400
Message-Id: <20250319053650-e0c9a360f7a70dfb@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250319023741.922528-1-jianqi.ren.cn@windriver.com>
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
Commit author: Paulo Alcantara<pc@manguebit.com>

Status in newer kernel trees:
6.13.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (different SHA1: 10e17ca4000e)

Note: The patch differs from the upstream commit:
---
1:  58acd1f497162 ! 1:  6e0245f6a95d2 smb: client: fix potential UAF in cifs_dump_full_key()
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
    +    Signed-off-by: He Zhe <zhe.he@windriver.com>
     
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

