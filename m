Return-Path: <stable+bounces-145977-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 60726AC021D
	for <lists+stable@lfdr.de>; Thu, 22 May 2025 04:05:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16D051B65CD6
	for <lists+stable@lfdr.de>; Thu, 22 May 2025 02:05:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C6202D7BF;
	Thu, 22 May 2025 02:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fih1vnsR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BD0018E3F
	for <stable@vger.kernel.org>; Thu, 22 May 2025 02:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747879531; cv=none; b=Fakrn3xOdVvZARXxuOWmgBPQx+oatALywDv5fmNm7oXhqEmjgkhtzI2OcvLnlUDRAFoOI54nnZ99ogFez2QzksAb3IqY3/XKmRx0xAj2dgJnJ5r0XWRKntABbnCUCM97hqTWKt0NkDdZ8xJb+AAQKSPKehqHyhBtSj8fUHKB108=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747879531; c=relaxed/simple;
	bh=ItYANzdzpiI6jV46FO/n4iijMvsc7OmrROFzmGN0sYk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XdnAHk1qyV6rUckp2hYN4vtFrTaFYcr17eV+CMUfzHPm/E4FyWbzwrF1yEwXpBSPLjBtkSrcmQfr6lmpP49mtcB9vqsx5H83CgByBkh/KgYnCbNb/Wjr6GNY2TOugW3RWuP86qsVUCzJVz1JKGbqanATaAVYkg+maLtjujUWjNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fih1vnsR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 931D8C4CEE4;
	Thu, 22 May 2025 02:05:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747879531;
	bh=ItYANzdzpiI6jV46FO/n4iijMvsc7OmrROFzmGN0sYk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fih1vnsRw5M4QFZZI2+4epNkFINcRwTHZCEXAC0hLBApJWEegI7z5UpbsYitQuOmA
	 xL0MScBpnIqk3wS/Fb7Yz1aBbB3IbAGORs9UPdoXVgCdtRf610fMoxVvWPFReMdfH9
	 TvUCR/coBU6xE2ChCUcpO/lpDGJXwTb283gerH8zGSPUYNk3dndjV3MM8ZsIHpg7Rm
	 tQNpszwxMnQSsbZWaZOGgputeHTA2qhMDVrgE5/YVsjyDXZRsnPDV7QshsCEA8453i
	 IXgb4bYKpSxzvZ1ahAkKTevRrP9jpuKdL8VNJ0TwKwg0dFSSLiYdTCIFMKqUyD/wht
	 8ggEDbbT7jeIA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Lee Jones <lee@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH v6.1 15/27] af_unix: Fix up unix_edge.successor for embryo socket.
Date: Wed, 21 May 2025 22:05:26 -0400
Message-Id: <20250521205201-0011baa6d3e8bf20@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250521152920.1116756-16-lee@kernel.org>
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

The upstream commit SHA1 provided is correct: dcf70df2048d27c5d186f013f101a4aefd63aa41

WARNING: Author mismatch between patch and upstream commit:
Backport author: Lee Jones<lee@kernel.org>
Commit author: Kuniyuki Iwashima<kuniyu@amazon.com>

Status in newer kernel trees:
6.14.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Not found

Note: The patch differs from the upstream commit:
---
1:  dcf70df2048d2 ! 1:  c26a81ec8cd5e af_unix: Fix up unix_edge.successor for embryo socket.
    @@ Metadata
      ## Commit message ##
         af_unix: Fix up unix_edge.successor for embryo socket.
     
    +    [ Upstream commit dcf70df2048d27c5d186f013f101a4aefd63aa41 ]
    +
         To garbage collect inflight AF_UNIX sockets, we must define the
         cyclic reference appropriately.  This is a bit tricky if the loop
         consists of embryo sockets.
    @@ Commit message
         Acked-by: Paolo Abeni <pabeni@redhat.com>
         Link: https://lore.kernel.org/r/20240325202425.60930-9-kuniyu@amazon.com
         Signed-off-by: Jakub Kicinski <kuba@kernel.org>
    +    (cherry picked from commit dcf70df2048d27c5d186f013f101a4aefd63aa41)
    +    Signed-off-by: Lee Jones <lee@kernel.org>
     
      ## include/net/af_unix.h ##
     @@ include/net/af_unix.h: void unix_inflight(struct user_struct *user, struct file *fp);
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.6.y        |  Success    |  Success   |

