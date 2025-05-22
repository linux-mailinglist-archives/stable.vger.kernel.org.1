Return-Path: <stable+bounces-145971-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03CB7AC0215
	for <lists+stable@lfdr.de>; Thu, 22 May 2025 04:05:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA31A4A7573
	for <lists+stable@lfdr.de>; Thu, 22 May 2025 02:05:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF99818E3F;
	Thu, 22 May 2025 02:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CtBvQqIf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F7CD1758B
	for <stable@vger.kernel.org>; Thu, 22 May 2025 02:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747879506; cv=none; b=ujvtJRvc9L6LMfGwxJd3+GFNL0AxdepqF7ejek59R/THIfHmJQzhZ1gsrUwec3+mpSWW3j6LkOd0jiN38SAuZUKZS6xKvs85+pkKYKd5I9fuW079RFRDf95QowAKdg3ulOumbBOZGizIw/ZRYG5yLevbPjFj5DNJLbHpO6KoA6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747879506; c=relaxed/simple;
	bh=SEjdKYqW4ox8eMLrmbson6BaqZEk1/8LQ+qA1qcRUhY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tJw4AB20/d8X1w7kojFmO8t06pZiSfZ9DOSsEoCgfR8u17H2weiIj4xISswckNSf4nkptT5Cf0eKgopYS+KMoPDqrCFbeshRTsHKPZ2AK98AAZKoHsVEFW99UGnvQnomDRqxw1L2+aEGBgeNQQ7JNbkwPpcvnmmKEzKuyPGcvG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CtBvQqIf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 030D0C4CEE4;
	Thu, 22 May 2025 02:05:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747879506;
	bh=SEjdKYqW4ox8eMLrmbson6BaqZEk1/8LQ+qA1qcRUhY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CtBvQqIfPS0GpzZqg0eK4vWAH83oTHI3WZaTRDRORauXs8J14ZrcF2vrrFOK86Hk6
	 zUeLz+dnvxIyj////FX5fypT/yLznb3+KarKgv3FyaEl4Qy+d7o1FEL15arlybN4xQ
	 P/uRnJbrNr/molITPuIs2nJk/cW9PDaGJNWqnkhNCvp1atGVWPIUvfJcVpMMhJXvJA
	 tiXGHk9WnYnibAaU201I27Zay1cJuLnsK0eo+b+Sw+VZM92VLRrCRAXa+3HH1+4VIa
	 li0/szDPB/hGHJhMlptlu+ZShC09FwqCGmvwZmdM+pmnvGr+Kkh61CWzjH04NWGXxU
	 cB9UIN7F05Mxw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Lee Jones <lee@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH v6.6 19/26] af_unix: Detect dead SCC.
Date: Wed, 21 May 2025 22:05:04 -0400
Message-Id: <20250521181253-c582934357441bab@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250521144803.2050504-20-lee@kernel.org>
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

✅ All tests passed successfully. No issues detected.
No action required from the submitter.

The upstream commit SHA1 provided is correct: a15702d8b3aad8ce5268c565bd29f0e02fd2db83

WARNING: Author mismatch between patch and upstream commit:
Backport author: Lee Jones<lee@kernel.org>
Commit author: Kuniyuki Iwashima<kuniyu@amazon.com>

Status in newer kernel trees:
6.14.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)

Note: The patch differs from the upstream commit:
---
1:  a15702d8b3aad ! 1:  496ff0e634226 af_unix: Detect dead SCC.
    @@ Metadata
      ## Commit message ##
         af_unix: Detect dead SCC.
     
    +    [ Upstream commit a15702d8b3aad8ce5268c565bd29f0e02fd2db83 ]
    +
         When iterating SCC, we call unix_vertex_dead() for each vertex
         to check if the vertex is close()d and has no bridge to another
         SCC.
    @@ Commit message
         Acked-by: Paolo Abeni <pabeni@redhat.com>
         Link: https://lore.kernel.org/r/20240325202425.60930-14-kuniyu@amazon.com
         Signed-off-by: Jakub Kicinski <kuba@kernel.org>
    +    (cherry picked from commit a15702d8b3aad8ce5268c565bd29f0e02fd2db83)
    +    Signed-off-by: Lee Jones <lee@kernel.org>
     
      ## net/unix/garbage.c ##
     @@ net/unix/garbage.c: void unix_destroy_fpl(struct scm_fp_list *fpl)
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.12.y       |  Success    |  Success   |

