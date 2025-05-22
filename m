Return-Path: <stable+bounces-146001-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BA248AC023A
	for <lists+stable@lfdr.de>; Thu, 22 May 2025 04:07:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7561B7B3476
	for <lists+stable@lfdr.de>; Thu, 22 May 2025 02:06:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAB5E8BEC;
	Thu, 22 May 2025 02:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aB7NblXn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABC00539A
	for <stable@vger.kernel.org>; Thu, 22 May 2025 02:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747879667; cv=none; b=tuSbcX1ykK2aMygvhBSA6M+hw+y1eyD3Qd96KVfRahMctExHz4HRjh0VvR5qWg826Nujfc8/0Ay20A3S5ZVcLQIGh20XFV5G7ohK+i8GtgdlxFjoYLZBAAYLIlTmS/Sc2X2cXRsFetC+abGvQJL+21/YwW36Yqyhh8oVkX77kl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747879667; c=relaxed/simple;
	bh=mwUCftyrfkuZsoeC4630Sn1HwbpLeuAOzYUyRFeqX44=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rLQ5ZCHq5TQGsN75nKVaqSyyGlKe33Xo6lG7vioiCAn3xQZxEIn9qu0KATcpx9wcBNfDme/H3R7Mg1bZKoGJsrUiKnR79zdXWYUJwFSYyIX4ki0ymMAygMevQJ/E7lvSgCaWOV5OdTEEW2y1blj+7B/3Wxcjpbak1tPB/W5AX+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aB7NblXn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1D70C4CEE4;
	Thu, 22 May 2025 02:07:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747879667;
	bh=mwUCftyrfkuZsoeC4630Sn1HwbpLeuAOzYUyRFeqX44=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aB7NblXneiqh+tyI4WduiUHxPyR8O2ZY6Kxfy4bmfqes7LXxxEMl3u04neONvP4nH
	 ha131QEupDjt3EVEVcMmhU3/JdlN8zZAe7SVAsDrdMl9tGh/PXyoseejGNJhe+ajEm
	 bjIBC74quB6dgx941t7jU/DPFnvFz0tHTP6SroEE+ZtW+aPpkhhteqvdCioVRt2i86
	 HgmE9nQhYnleY5vDR2panCq8oZNneTcwIuKtlsn+SqR8TtVig0dT+Phi07M+36Yn5p
	 F6UeiUzMQ9VHTVMxD6ag4klpW7faOh+AOMC6GqnWjQluS0xld0U+HQ4pfl028ZZkhO
	 LKcTiRH3t7mbw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Lee Jones <lee@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH v6.6 21/26] af_unix: Remove lock dance in unix_peek_fds().
Date: Wed, 21 May 2025 22:07:42 -0400
Message-Id: <20250521182141-10936d0f27efc3bb@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250521144803.2050504-22-lee@kernel.org>
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

The upstream commit SHA1 provided is correct: 118f457da9ed58a79e24b73c2ef0aa1987241f0e

WARNING: Author mismatch between patch and upstream commit:
Backport author: Lee Jones<lee@kernel.org>
Commit author: Kuniyuki Iwashima<kuniyu@amazon.com>

Status in newer kernel trees:
6.14.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)

Note: The patch differs from the upstream commit:
---
1:  118f457da9ed5 ! 1:  c078e92698845 af_unix: Remove lock dance in unix_peek_fds().
    @@ Metadata
      ## Commit message ##
         af_unix: Remove lock dance in unix_peek_fds().
     
    +    [ Upstream commit 118f457da9ed58a79e24b73c2ef0aa1987241f0e ]
    +
         In the previous GC implementation, the shape of the inflight socket
         graph was not expected to change while GC was in progress.
     
    @@ Commit message
         Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
         Link: https://lore.kernel.org/r/20240401173125.92184-3-kuniyu@amazon.com
         Signed-off-by: Jakub Kicinski <kuba@kernel.org>
    +    (cherry picked from commit 118f457da9ed58a79e24b73c2ef0aa1987241f0e)
    +    Signed-off-by: Lee Jones <lee@kernel.org>
     
      ## include/net/af_unix.h ##
     @@ include/net/af_unix.h: static inline struct unix_sock *unix_get_socket(struct file *filp)
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.12.y       |  Success    |  Success   |

