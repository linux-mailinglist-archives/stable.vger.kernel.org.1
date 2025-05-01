Return-Path: <stable+bounces-139368-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EC13AA6382
	for <lists+stable@lfdr.de>; Thu,  1 May 2025 21:10:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49DA19C1FA7
	for <lists+stable@lfdr.de>; Thu,  1 May 2025 19:09:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7051215191;
	Thu,  1 May 2025 19:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BpKyVcHE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78504226863
	for <stable@vger.kernel.org>; Thu,  1 May 2025 19:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746126592; cv=none; b=S5V/u0kaXe7e5oGjNeDfOS9rY7Dn8xA56OenRxsCSwiyI98DtopDFtZ4VLCqBAyyEWJ7F2r2NbciwWvr0uc3kEpJGGmpTnGriG2UdNaLgq4OIKvvyXyLsqRbRplpOrUB9AAF/v9FWqLvOXtCbcepHwVHN4NDGHzkyUzPDg4pIiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746126592; c=relaxed/simple;
	bh=HngWd5Z6Ty+9O7auauFcMFt1aiGP/O7kn9dhJj9w6qU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WClDWqwPN6ErmJajfVJ2eBZp8Lm5wXcRWCqDdrBpInxdp3zx4Ry2FLP/eWnFYk0GNFpxdzMzyMdC1VP7i+WED/kbQnOQn8mZac86m/Sv70x7w9YhRwyStOAMl2VfBC5JlMC9d4cbjVysxh6qim4H0x461vNQRhwhd1Jk8p1YlU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BpKyVcHE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CDE5C4CEE9;
	Thu,  1 May 2025 19:09:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746126591;
	bh=HngWd5Z6Ty+9O7auauFcMFt1aiGP/O7kn9dhJj9w6qU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BpKyVcHEZk1E18M4mAnFvvCHfpOUFQxkEOzfb4VAetgDRU61cmkxH+kKEJwcxCgYd
	 0bWaKQDv+9thV1DEpnBen23ceMTbZtJu+rteAkndsXjXcP0e9XxPx8Jf7gdib1Z2RT
	 rP1yFd0V+qZ0BKaOYbomF1sqgsSLGGHPQVTUqy0qj4hADVEAkU5V+e2en5puV1ILfw
	 ZeNistuH7OkabKj7KHV61mXHx8+tSzD/xLHzQo9qgYMWrOQQ58ClZvxMVIKBwrKM7Y
	 YLh55vPJVMwE2HOVx/9JxtAKM6KoaRJaZ2nVzkPfSpDG3mUVzvPehk2frRgmvIPylf
	 E6VvMmkXFPkaQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Carlos Llamas <cmllamas@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.12.y] binder: fix offset calculation in debug log
Date: Thu,  1 May 2025 15:09:47 -0400
Message-Id: <20250501071012-0c992678f5478372@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250429225158.3920681-1-cmllamas@google.com>
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

The upstream commit SHA1 provided is correct: 170d1a3738908eef6a0dbf378ea77fb4ae8e294d

Status in newer kernel trees:
6.14.y | Present (different SHA1: c8f9ccac8a5b)

Note: The patch differs from the upstream commit:
---
1:  170d1a3738908 ! 1:  1eec0d8c91a39 binder: fix offset calculation in debug log
    @@ Metadata
      ## Commit message ##
         binder: fix offset calculation in debug log
     
    +    commit 170d1a3738908eef6a0dbf378ea77fb4ae8e294d upstream.
    +
         The vma start address should be substracted from the buffer's user data
         address and not the other way around.
     
    @@ Commit message
         Reviewed-by: Tiffany Y. Yang <ynaffit@google.com>
         Link: https://lore.kernel.org/r/20250325184902.587138-1-cmllamas@google.com
         Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    +    [cmllamas: fix conflicts due to alloc->buffer renaming]
    +    Signed-off-by: Carlos Llamas <cmllamas@google.com>
     
      ## drivers/android/binder.c ##
     @@ drivers/android/binder.c: static void print_binder_transaction_ilocked(struct seq_file *m,
      		seq_printf(m, " node %d", buffer->target_node->debug_id);
      	seq_printf(m, " size %zd:%zd offset %lx\n",
      		   buffer->data_size, buffer->offsets_size,
    --		   proc->alloc.vm_start - buffer->user_data);
    -+		   buffer->user_data - proc->alloc.vm_start);
    +-		   proc->alloc.buffer - buffer->user_data);
    ++		   buffer->user_data - proc->alloc.buffer);
      }
      
      static void print_binder_work_ilocked(struct seq_file *m,
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.12.y       |  Success    |  Success   |

