Return-Path: <stable+bounces-111065-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D960A2154C
	for <lists+stable@lfdr.de>; Wed, 29 Jan 2025 00:49:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 94FC67A2829
	for <lists+stable@lfdr.de>; Tue, 28 Jan 2025 23:48:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9FE91946B8;
	Tue, 28 Jan 2025 23:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MqT2hWDQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85B6C5672
	for <stable@vger.kernel.org>; Tue, 28 Jan 2025 23:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738108169; cv=none; b=CLCx4IH+S7PB+7tTmWLEqVrR3/lsdQFmPddcCV6ha9ZJe5/h69kx8pzIbvf1oMLjWuevZLGKInlCJn8t3y0dMXUz81DtkbZ/4ae1RYwI8dryX9bj8s35elgbwHgpDIP40E8jM4f6zFy7yk67eYL8Xelkz3/fsb+ZTKh6evI26UM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738108169; c=relaxed/simple;
	bh=5WalIdleZbPkh2n6bLHezxokWJeXW2FtnHEK714VFuk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=slgkCkwHivtd/nA0hKQp1qe9iXQA3V5PUDduHWpg1GL8K2zoYeoJhakD8Kl+3VFzf3VDwVal5cLyConMV3mXu1ba4vCc8Hs4j0D0pR5mYAyaPnWRH5rAgWUfzidwDnmQAK//a69Xmqow6eTatH7dKE4ReJ6xnxqirOznanQqMZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MqT2hWDQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61F6BC4CED3;
	Tue, 28 Jan 2025 23:49:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738108168;
	bh=5WalIdleZbPkh2n6bLHezxokWJeXW2FtnHEK714VFuk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MqT2hWDQBFN1cBkrCNN+mTtMPe5uMS2Wanv6VGnHl7Pd1BqdOUcFZ3hYw9KPhJoGl
	 9R0aN7+KBUDmsaJKu7PTDt8Y0bXLpZB5JdZZ4TcTdSXHVxgGLVXKttP9lhGzalE5mk
	 bsXwiqDF18ia4GSoRiyJUH8XlQmfF3EtNBUtKwh7fm4pjKEllyS0F5olSyB0sSvK6a
	 V7tffBJRVgFo6d4SZNJB+gqcw8583vOCLvtGKpUJzo/bPlCGWJs7IdepTrBAVSxWfI
	 bl8kYhbthO7L6bS3iSWSf916A4u8H87NQTq5PM+pcwDWnFQ/JBNVZA1eq8XTIkblrR
	 feJ2/zZ45Wuyw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Vasiliy Kovalev <kovalev@altlinux.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH v3 5.10 1/2] net: net_namespace: Optimize the code
Date: Tue, 28 Jan 2025 18:49:26 -0500
Message-Id: <20250128182443-f6b32bfb379bff7b@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250128221522.21706-2-kovalev@altlinux.org>
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

The upstream commit SHA1 provided is correct: 41467d2ff4dfe1837cbb0f45e2088e6e787580c6

WARNING: Author mismatch between patch and upstream commit:
Backport author: Vasiliy Kovalev<kovalev@altlinux.org>
Commit author: Yajun Deng<yajun.deng@linux.dev>


Status in newer kernel trees:
6.13.y | Branch not found
6.12.y | Present (exact SHA1)
6.6.y | Present (exact SHA1)
6.1.y | Present (exact SHA1)
5.15.y | Present (exact SHA1)
5.10.y | Present (different SHA1: d33542e7aebc)

Note: The patch differs from the upstream commit:
---
1:  41467d2ff4dfe ! 1:  1bdbc1a4c6a3a net: net_namespace: Optimize the code
    @@ Metadata
      ## Commit message ##
         net: net_namespace: Optimize the code
     
    +    commit 41467d2ff4dfe1837cbb0f45e2088e6e787580c6 upstream.
    +
         There is only one caller for ops_free(), so inline it.
         Separate net_drop_ns() and net_free(), so the net_free()
         can be called directly.
    @@ Commit message
     
         Signed-off-by: Yajun Deng <yajun.deng@linux.dev>
         Signed-off-by: David S. Miller <davem@davemloft.net>
    +    Signed-off-by: Vasiliy Kovalev <kovalev@altlinux.org>
     
      ## net/core/net_namespace.c ##
     @@ net/core/net_namespace.c: static int net_assign_generic(struct net *net, unsigned int id, void *data)
    @@ net/core/net_namespace.c: static struct net *net_alloc(void)
      
      struct net *copy_net_ns(unsigned long flags,
     @@ net/core/net_namespace.c: struct net *copy_net_ns(unsigned long flags,
    - put_userns:
      		key_remove_domain(net->key_domain);
    + #endif
      		put_user_ns(user_ns);
     -		net_drop_ns(net);
     +		net_free(net);
    @@ net/core/net_namespace.c: struct net *copy_net_ns(unsigned long flags,
      		dec_net_namespaces(ucounts);
      		return ERR_PTR(rv);
     @@ net/core/net_namespace.c: static void cleanup_net(struct work_struct *work)
    - 		dec_net_namespaces(net->ucounts);
      		key_remove_domain(net->key_domain);
    + #endif
      		put_user_ns(net->user_ns);
     -		net_drop_ns(net);
     +		net_free(net);
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.10.y       |  Success    |  Success   |

