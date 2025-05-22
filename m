Return-Path: <stable+bounces-146003-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1B8FAC023C
	for <lists+stable@lfdr.de>; Thu, 22 May 2025 04:08:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E213A24198
	for <lists+stable@lfdr.de>; Thu, 22 May 2025 02:07:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27A143F9FB;
	Thu, 22 May 2025 02:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L9oEnBaB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAC366FBF
	for <stable@vger.kernel.org>; Thu, 22 May 2025 02:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747879674; cv=none; b=TLE3REUtlyqcKJ+jFkc9KXpOzQgGD9hJRW1kaNzrVj6it9uQXpmHXXQNnKydkfKc5LD8W5MQDjAavPtJ65bqxiawzmaTzruSabPKN3IaK6cA+3RqIt60IFxE/AJRMK6DsLzSPnT9qW5C6/cCAsPrAPWqa/gdjtIoabXefBH+9Ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747879674; c=relaxed/simple;
	bh=cNaVAbD1BotLlyK64SVCAkeuBXG1t1Ypv9SXe5H8nQE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VMlhPOSYTLssG6TCOs85cffo2+PsJytMGxs8rPke+kZxiAZB8tZ+p6JnAEBVJaQcEnGaYxnFlQEDM6EWuJZ5HP9J25SrXW1vQ0TcupPDq9RlfW4NdEDTe/qK7b59kkEkUpeAX4sam5dPMdxUKgkxDJMv1VWcBxMGDvDEr6SzHLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L9oEnBaB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4ED9FC4CEE4;
	Thu, 22 May 2025 02:07:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747879674;
	bh=cNaVAbD1BotLlyK64SVCAkeuBXG1t1Ypv9SXe5H8nQE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=L9oEnBaBSS15WcPKes5k9ek1giJsDJAvH/9UYV2BPAK/vnbn2c3BRU8CPKvOcJO/A
	 /26Dky2J8YoN2fnoxrn3hquo1iRWlg5kgRvyVITjAp6bMxaDWNn9mhkX3WqZmKNhE5
	 9/rQ/WjRrrSy/lGHm6pPzOf+KkmTSnnJ2cg4GzqEEWb7WXyLwTa3CINeoSNUn/04Bb
	 PuUkNcu5LC6vYZVeHYrRIiMmBKaXGBkXJt9Dkjv+/gsXjbOAr018MXonJ76EpwoxcG
	 GrFXL02p1dhzjBRsx3vYEiF13rYyCz3ICI4ZTMzwfSZtWFVaptLEqt01otkW6hsiDz
	 I6NOlseHhw1AA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Lee Jones <lee@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH v6.1 07/27] af_unix: Remove CONFIG_UNIX_SCM.
Date: Wed, 21 May 2025 22:07:50 -0400
Message-Id: <20250521195018-73f0ea828c8ff363@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250521152920.1116756-8-lee@kernel.org>
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

The upstream commit SHA1 provided is correct: 99a7a5b9943ea2d05fb0dee38e4ae2290477ed83

WARNING: Author mismatch between patch and upstream commit:
Backport author: Lee Jones<lee@kernel.org>
Commit author: Kuniyuki Iwashima<kuniyu@amazon.com>

Status in newer kernel trees:
6.14.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Not found

Note: The patch differs from the upstream commit:
---
1:  99a7a5b9943ea ! 1:  ec2aeb54a3930 af_unix: Remove CONFIG_UNIX_SCM.
    @@ Metadata
      ## Commit message ##
         af_unix: Remove CONFIG_UNIX_SCM.
     
    +    [ Upstream commit 99a7a5b9943ea2d05fb0dee38e4ae2290477ed83 ]
    +
         Originally, the code related to garbage collection was all in garbage.c.
     
         Commit f4e65870e5ce ("net: split out functions related to registering
    @@ Commit message
         Acked-by: Jens Axboe <axboe@kernel.dk>
         Link: https://lore.kernel.org/r/20240129190435.57228-4-kuniyu@amazon.com
         Signed-off-by: Jakub Kicinski <kuba@kernel.org>
    +    (cherry picked from commit 99a7a5b9943ea2d05fb0dee38e4ae2290477ed83)
    +    Signed-off-by: Lee Jones <lee@kernel.org>
     
      ## include/net/af_unix.h ##
     @@ include/net/af_unix.h: static inline struct unix_sock *unix_get_socket(struct file *filp)
    @@ net/Makefile: obj-$(CONFIG_NETFILTER)		+= netfilter/
     -obj-$(CONFIG_UNIX_SCM)		+= unix/
     +obj-$(CONFIG_UNIX)		+= unix/
      obj-y				+= ipv6/
    + obj-$(CONFIG_BPFILTER)		+= bpfilter/
      obj-$(CONFIG_PACKET)		+= packet/
    - obj-$(CONFIG_NET_KEY)		+= key/
     
      ## net/unix/Kconfig ##
     @@ net/unix/Kconfig: config UNIX
    @@ net/unix/Makefile: unix-$(CONFIG_BPF_SYSCALL) += unix_bpf.o
     
      ## net/unix/af_unix.c ##
     @@
    + #include <linux/file.h>
      #include <linux/btf_ids.h>
    - #include <linux/bpf-cgroup.h>
      
     -#include "scm.h"
     -
    @@ net/unix/scm.c (deleted)
     -	/* Socket ? */
     -	if (S_ISSOCK(inode->i_mode) && !(filp->f_mode & FMODE_PATH)) {
     -		struct socket *sock = SOCKET_I(inode);
    --		const struct proto_ops *ops = READ_ONCE(sock->ops);
     -		struct sock *s = sock->sk;
     -
     -		/* PF_UNIX ? */
    --		if (s && ops && ops->family == PF_UNIX)
    +-		if (s && sock->ops && sock->ops->family == PF_UNIX)
     -			return unix_sk(s);
     -	}
     -
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.6.y        |  Success    |  Success   |

