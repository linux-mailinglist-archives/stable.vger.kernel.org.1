Return-Path: <stable+bounces-145955-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8390AC0203
	for <lists+stable@lfdr.de>; Thu, 22 May 2025 04:04:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 883C94A7348
	for <lists+stable@lfdr.de>; Thu, 22 May 2025 02:04:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 359252B9B7;
	Thu, 22 May 2025 02:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="no/PAwre"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4E461758B
	for <stable@vger.kernel.org>; Thu, 22 May 2025 02:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747879443; cv=none; b=DRp5FrwKl5tgttkycsjHD49WLWMxG9XUo+ZJG57TUEmy4ApnuTj0oRfwtPzn85AC1t3PBJ+aTJQurPP4OMNN8UgEreyTYYRDOjzvPZ9zFV/awng3X8XG9YegThvkJ0yfNBHFPvB2Ljbj8kjrKRORT/gZRuJM/h+ZdA4yMZjG0W0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747879443; c=relaxed/simple;
	bh=74nUvxgYM/sQZet6E8dNrbcmhxiQhySX9V50ZmvJVdk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mPN8ofLOJpn3nAfxVYvGPdee8k52ubTCHDsT9Whv/lSI0PtoPAtchd2hKgcIO/RpzUgQwFq9Rv44C10mggdSNovOdtntPkywX8SQKWWLgQ8nM7KqyNoblLn7l51bIzaAsim4T+vTgkQ7ECcH3iuDSj9Vx+1HoI/JrmJjCWKyQsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=no/PAwre; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE9CAC4CEE4;
	Thu, 22 May 2025 02:04:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747879442;
	bh=74nUvxgYM/sQZet6E8dNrbcmhxiQhySX9V50ZmvJVdk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=no/PAwre4CbUHlvz+MYPUzCHJeN0NrZJYYcPJz5EzBiVkZcEJczC5n6y7gvtrfGnB
	 3g/9HOKnKZjV9Yl5CiiceV/pxGw3h63noW8+mG9W/ay5/b7VHGic5mTQOoIzxhpnCz
	 AFxwf4xGqZYS3Q1TrIEelt/FOo7E+6Ap410Z4c8pfmDqYaEGpaIsM3v+w/0D8UR/t8
	 pxtx3zX94i8TvQooDzYv4m2dyizf9T1zEcX9QXe1F/kkOuDjw+iy61R2tMdq6UKAoX
	 zAE+OWGC4zNBAsMiOrbtg/vvFPg1/lOy7pztOCz4T0wuaB1hvf8/oCFz8dfDqVR+TJ
	 m5/rcwIhJF5nw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Lee Jones <lee@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH v6.6 06/26] af_unix: Remove CONFIG_UNIX_SCM.
Date: Wed, 21 May 2025 22:03:59 -0400
Message-Id: <20250521164626-011f5c224366ba1b@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250521144803.2050504-7-lee@kernel.org>
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

Note: The patch differs from the upstream commit:
---
1:  99a7a5b9943ea ! 1:  82c52547bf774 af_unix: Remove CONFIG_UNIX_SCM.
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
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.12.y       |  Success    |  Success   |

