Return-Path: <stable+bounces-146009-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00660AC0242
	for <lists+stable@lfdr.de>; Thu, 22 May 2025 04:08:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 378473AFAC6
	for <lists+stable@lfdr.de>; Thu, 22 May 2025 02:08:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5116F2B9B7;
	Thu, 22 May 2025 02:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RKhyrKpb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F86A539A
	for <stable@vger.kernel.org>; Thu, 22 May 2025 02:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747879702; cv=none; b=ZPVbo17et4X+ksyupJ4Gw+2rw4CGF0KVYkHpF8Sj3FHpz+Yr8DtHJHrHn9Xi7tfFNaY/+glsFhL6vk7v+/b3rZZk4Aezb5jn/oQfNQe69Cim4mbGkF5FKK4qCvzUKITrxGGLPUeDtiMxWOehKQuNFkf52ot5d3PfXKcGiKVOlHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747879702; c=relaxed/simple;
	bh=N/WepeN+mUR1WCkYzgFzk4+AoV9gXSSc/6bIeJcZXZA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AETLw1+cudKzuXDegmVuTj0eQ12/RHVgHoosFIizBOLpEeFT5qzQ9ieA/mQ19nCNgovE17rN9A6M9q9lZIf+fAiFLj525RIkZFkwdA41g6AM6rcYM2PCpbgFlPdgxBtQdN3Q6FCdJ7Qm8jlYMgR/aDX+wKKBUV3IB/AFVRVdyFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RKhyrKpb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EC2BC4CEE4;
	Thu, 22 May 2025 02:08:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747879701;
	bh=N/WepeN+mUR1WCkYzgFzk4+AoV9gXSSc/6bIeJcZXZA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RKhyrKpb5nOZ/wVUaIifGSarhUG1yoqX0roWt6MfYUZjrrJRslZndSiCNdoIpRree
	 YhXR6Q925qNh48OJ3DjrGetTSTSQFyu04Myf9dLNIkeBCOCjVxXN9kMF43Y+kuw0Pe
	 Et07GEQnyUpj8Ccl9CtNrKh2w3g58k15jxQRNgIcEb3sx/e8S4vtSCijgecWgz4pCx
	 Iu+IJEtvjnI1bECzMrBnFFfxpEh5vQkfz4QOqCq8CRJvSvrNKAzt5K9aBBk5lEfMwy
	 xz21dkH3+Ip9AriV8A8RJKhp29UQdBBdmAI2eL3jzKg2t5eEZwa0S8N/8K5+Nq7Dfx
	 X7hnp4O8vfFRA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Lee Jones <lee@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH v6.6 04/26] af_unix: Replace BUG_ON() with WARN_ON_ONCE().
Date: Wed, 21 May 2025 22:08:17 -0400
Message-Id: <20250521162920-55ceaadd5383f221@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250521144803.2050504-5-lee@kernel.org>
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

The upstream commit SHA1 provided is correct: d0f6dc26346863e1f4a23117f5468614e54df064

WARNING: Author mismatch between patch and upstream commit:
Backport author: Lee Jones<lee@kernel.org>
Commit author: Kuniyuki Iwashima<kuniyu@amazon.com>

Status in newer kernel trees:
6.14.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)

Note: The patch differs from the upstream commit:
---
1:  d0f6dc2634686 ! 1:  0ef391f5b8d02 af_unix: Replace BUG_ON() with WARN_ON_ONCE().
    @@ Metadata
      ## Commit message ##
         af_unix: Replace BUG_ON() with WARN_ON_ONCE().
     
    +    [ Upstream commit d0f6dc26346863e1f4a23117f5468614e54df064 ]
    +
         This is a prep patch for the last patch in this series so that
         checkpatch will not warn about BUG_ON().
     
    @@ Commit message
         Acked-by: Jens Axboe <axboe@kernel.dk>
         Link: https://lore.kernel.org/r/20240129190435.57228-2-kuniyu@amazon.com
         Signed-off-by: Jakub Kicinski <kuba@kernel.org>
    +    (cherry picked from commit d0f6dc26346863e1f4a23117f5468614e54df064)
    +    Signed-off-by: Lee Jones <lee@kernel.org>
     
      ## net/unix/garbage.c ##
     @@ net/unix/garbage.c: static void scan_children(struct sock *x, void (*func)(struct unix_sock *),
    @@ net/unix/garbage.c: static void scan_children(struct sock *x, void (*func)(struc
      		spin_unlock(&x->sk_receive_queue.lock);
     @@ net/unix/garbage.c: static void __unix_gc(struct work_struct *work)
      
    - 		total_refs = file_count(u->sk.sk_socket->file);
    + 		total_refs = file_count(sk->sk_socket->file);
      
     -		BUG_ON(!u->inflight);
     -		BUG_ON(total_refs < u->inflight);
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.12.y       |  Success    |  Success   |

