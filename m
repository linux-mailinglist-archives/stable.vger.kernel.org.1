Return-Path: <stable+bounces-145961-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D9C8AC0208
	for <lists+stable@lfdr.de>; Thu, 22 May 2025 04:04:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE1354A7402
	for <lists+stable@lfdr.de>; Thu, 22 May 2025 02:04:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5553835953;
	Thu, 22 May 2025 02:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TJntGKBv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 112741758B
	for <stable@vger.kernel.org>; Thu, 22 May 2025 02:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747879465; cv=none; b=KxMie/l0JWHErlvRkKuTV3LgCLBOvJjAF7wXqyO992H0vdrNDwu61rMPNpjvDzgKqGWoi6M4Oo9Eim9s6vcNiw876MGNKfnaE3GtWqjCrPRT2ZhG0F64PivQ/Rnh7lWfdBWyjl1NWXPUbkN3IzEwiBGECv2uNe32exxLND438Nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747879465; c=relaxed/simple;
	bh=5XD4lHatBriQhAV7u8rBNzUSgIhBBzFoDwsQOvvlmyA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uctEYVWRXSn3GUbfQtnrxtlfsg6CG49o7LB9nsD8JYhoCawzoDIAetIrv+JlMsXgZeIx9WIDEhzyX6jlIfvdXGuHMw601FLxuKbr06kGX9ClswJoRemxur7ijHJ4aakKE8D5soQ3XiG+XPGepvg06ycHVmFsm7HPYxdgVZvvcLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TJntGKBv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B4E8C4CEE4;
	Thu, 22 May 2025 02:04:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747879464;
	bh=5XD4lHatBriQhAV7u8rBNzUSgIhBBzFoDwsQOvvlmyA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TJntGKBv2sA54LqxmwiJ9Lpzaw/HFqALJarVEUsGwUb9l78FrDemIHlwTlp/xlSWO
	 ISMH+jbYMS6f5GZuUPqwco7+fNUndJ83BnxSMiQQpDbhO2oyujtTS9MwrA7dE1JK8I
	 yJNj7B6wroaptqw99e9QHNnrmNy5KNJQx31o5JfNeS4Fsp1GF3UDGLYoZgUOYk6tb+
	 DRg1nXRVjB2Rg66dbPeR3ZldYXkT78gX0GhaT1zAeqOiUkGuckr2X9BZuh8bnSjJzq
	 VhrDaQzTFGfGL4td6U0aHAOgBBydu56ykhndbKeFPpX+lqaiI6ZdWRHH42rsueCMiX
	 dyHV8yPyoHqyw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Lee Jones <lee@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH v6.1 04/27] af_unix: Try to run GC async.
Date: Wed, 21 May 2025 22:04:22 -0400
Message-Id: <20250521192637-b38a15a6b113116a@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250521152920.1116756-5-lee@kernel.org>
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

The upstream commit SHA1 provided is correct: d9f21b3613337b55cc9d4a6ead484dca68475143

WARNING: Author mismatch between patch and upstream commit:
Backport author: Lee Jones<lee@kernel.org>
Commit author: Kuniyuki Iwashima<kuniyu@amazon.com>

Status in newer kernel trees:
6.14.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Not found

Note: The patch differs from the upstream commit:
---
1:  d9f21b3613337 ! 1:  61310f376dac5 af_unix: Try to run GC async.
    @@ Metadata
      ## Commit message ##
         af_unix: Try to run GC async.
     
    +    [ Upstream commit d9f21b3613337b55cc9d4a6ead484dca68475143 ]
    +
         If more than 16000 inflight AF_UNIX sockets exist and the garbage
         collector is not running, unix_(dgram|stream)_sendmsg() call unix_gc().
         Also, they wait for unix_gc() to complete.
    @@ Commit message
         Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
         Link: https://lore.kernel.org/r/20240123170856.41348-6-kuniyu@amazon.com
         Signed-off-by: Jakub Kicinski <kuba@kernel.org>
    +    (cherry picked from commit d9f21b3613337b55cc9d4a6ead484dca68475143)
    +    Signed-off-by: Lee Jones <lee@kernel.org>
     
      ## include/net/af_unix.h ##
     @@
    @@ include/net/af_unix.h
      void unix_inflight(struct user_struct *user, struct file *fp);
      void unix_notinflight(struct user_struct *user, struct file *fp);
      void unix_destruct_scm(struct sk_buff *skb);
    - void io_uring_destruct_scm(struct sk_buff *skb);
      void unix_gc(void);
     -void wait_for_unix_gc(void);
     -struct unix_sock *unix_get_socket(struct file *filp);
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.6.y        |  Success    |  Success   |

