Return-Path: <stable+bounces-100656-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BEF89ED1E1
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 17:32:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D377283C87
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 16:32:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D29A71A707A;
	Wed, 11 Dec 2024 16:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WIKaXmoW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 911A038DE9
	for <stable@vger.kernel.org>; Wed, 11 Dec 2024 16:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733934754; cv=none; b=Hymqzw8yAwS83gjtulKQXT4iYLsJuZ7C4y5mPNq7zdkqkTXARdTD79iYgNFHlJrVqtXkwf+d/mXmAbWKCe2Tzu8018ZewdX57bmEb4ps1n1YlQIb/UlEBuZvrmBlqbD7MH7TbePruidC93sQG79ofPLLy3+GaE3YTau6yonNldc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733934754; c=relaxed/simple;
	bh=8iOwlllgDhxnHm7Pha+Y+8S4QSwhs2UB3Z1NX464XqU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Prb0Qda1YB0epxHMl1SNhBKR7nxF4fsZUDT4J4PjBF9u5dcfjkf44VZZeH0FyvMYC41w/V2QNsKQ1oC6PMQrO+wytEyPjW+lbDGgXeHFPE0mV53MtEwyQ/VkEPqUqNbmyGoPRVRcQRyF087z2yfqR6GzW/2Odbrwk/6wG7PzeaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WIKaXmoW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF84CC4CED2;
	Wed, 11 Dec 2024 16:32:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733934754;
	bh=8iOwlllgDhxnHm7Pha+Y+8S4QSwhs2UB3Z1NX464XqU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WIKaXmoWa3lwTckZYHeFtNurXnNdtuP5gENfZ12Zu6Oir2FvU5LQz7GLM6KnZtmsW
	 plc+TeBQ6qMS7p/2Zhg60g+QFQF+L6h5UwmhXLAKt36HPtZz2z6VbZ4tJWg6d9t1bx
	 c413BadzbyZJLpErUL3WKOytNl43dE3a0EvlAYpTHKmqy3565WCW3hAuEhrfCbj3Ty
	 OZFKrIgc3ibQyzpuqnJOD5/u9JaYgbHhHv4cC6bRV3Gtig57kbeGJ6jHCJCvjRdhDx
	 YkvYPtFxdWrBXo9JhCbgMCx3ze24KDjCQoQa6mhAsG6Iii0vytxkBBHm8BxfNJ3pm4
	 WoAGrHm5msVkA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: jianqi.ren.cn@windriver.com,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1.y] smb: client: fix potential UAF in cifs_dump_full_key()
Date: Wed, 11 Dec 2024 11:32:32 -0500
Message-ID: <20241211083257-e46655d92f395bfa@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241211101539.2114503-1-jianqi.ren.cn@windriver.com>
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
Commit author: Paulo Alcantara <pc@manguebit.com>


Status in newer kernel trees:
6.12.y | Present (exact SHA1)
6.6.y | Present (different SHA1: 10e17ca4000e)
6.1.y | Not found

Note: The patch differs from the upstream commit:
---
1:  58acd1f497162 ! 1:  9ecdabdf26e97 smb: client: fix potential UAF in cifs_dump_full_key()
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

