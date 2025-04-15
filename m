Return-Path: <stable+bounces-132799-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D972A8AA4C
	for <lists+stable@lfdr.de>; Tue, 15 Apr 2025 23:44:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 623571756DE
	for <lists+stable@lfdr.de>; Tue, 15 Apr 2025 21:44:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5B762580C6;
	Tue, 15 Apr 2025 21:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="etjkRLYR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64AEE2580FB
	for <stable@vger.kernel.org>; Tue, 15 Apr 2025 21:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744753439; cv=none; b=XlW5t+SNtRVCiwfOLq/sOMfgtNo/A5WUjy9f4CV6oNg/HDIvRUvmAacpjvvvUNq9meATrq2WnOW+Vicspt/nK4gsbTCy7bIrf8IBo5jiJro9KSlmMEpj0lHqgyI9DjRf+JzczXHB5lCQrianxTI/NdKOMy4exSdYUeNsB7ClAdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744753439; c=relaxed/simple;
	bh=0yUCnHJMr5OzTfaLLf2HRhWSPGvUOTrjXXXmrMN7zVE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OvRXqjP/JSK+VuehLa2ECWQvzv6B6vjQc8vdlgkj4pMdz/T0OfcN2AxJXlImmwoi3YyStbJM7epSkBiOzml/W+d3hNAem1/xMh5nf3ZFKO8IGj/MKpMiY6a3JCIzoRwFWbmmzsmDukn6i5GYsV/VyYOsEQMJOUdcX7viE29taXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=etjkRLYR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76235C4CEE9;
	Tue, 15 Apr 2025 21:43:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744753438;
	bh=0yUCnHJMr5OzTfaLLf2HRhWSPGvUOTrjXXXmrMN7zVE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=etjkRLYR7kpWrUszv3hwNHarmZSoeUf4sT64JIAkpsCf1zVuY/wy3gftrPixgQ/nB
	 Xg0QCfycHAH7TpjVZ3mVjDAMlwQ5xLPHvUBSKGZsHXb9rGEng9zNozPAH5OTY5iM+0
	 CWg3SSMfJvyVn/UEdqNCeNwuRgK8XGn0RUnNog4Ry4fQtG9lr3tQudj1CXnr4NIIEe
	 3JcMMuLIH3Ok5rF2naeeLr27ksz6eHs31AZKIZHABFLLgmdoi+lueZMUHmOkZ18QIg
	 kGVuqIaAU+29DuNy4W/ag+KHZzoKqMn7lfGtmeIEOXMUr+vocmIUzZS+/eDd60W39h
	 RmeiTAhEh3bGg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15.y 3/6] phonet/pep: fix racy skb_queue_empty() use
Date: Tue, 15 Apr 2025 17:43:57 -0400
Message-Id: <20250415123629-b75e987cf5b3b7d2@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250414185023.2165422-4-harshit.m.mogalapalli@oracle.com>
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

The upstream commit SHA1 provided is correct: 7d2a894d7f487dcb894df023e9d3014cf5b93fe5

WARNING: Author mismatch between patch and upstream commit:
Backport author: Harshit Mogalapalli<harshit.m.mogalapalli@oracle.com>
Commit author: Rémi Denis-Courmont<courmisch@gmail.com>

Status in newer kernel trees:
6.14.y | Present (exact SHA1)
6.13.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (different SHA1: 0a9f558c72c4)
6.1.y | Present (different SHA1: 9d5523e065b5)

Note: The patch differs from the upstream commit:
---
1:  7d2a894d7f487 ! 1:  cf507fe643590 phonet/pep: fix racy skb_queue_empty() use
    @@ Metadata
      ## Commit message ##
         phonet/pep: fix racy skb_queue_empty() use
     
    +    [ Upstream commit 7d2a894d7f487dcb894df023e9d3014cf5b93fe5 ]
    +
         The receive queues are protected by their respective spin-lock, not
         the socket lock. This could lead to skb_peek() unexpectedly
         returning NULL or a pointer to an already dequeued socket buffer.
    @@ Commit message
         Signed-off-by: Rémi Denis-Courmont <courmisch@gmail.com>
         Link: https://lore.kernel.org/r/20240218081214.4806-2-remi@remlab.net
         Signed-off-by: Paolo Abeni <pabeni@redhat.com>
    +    Signed-off-by: Sasha Levin <sashal@kernel.org>
    +    [Harshit: backport to 5.15.y, clean cherrypick from 6.1.y commit]
    +    Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
     
      ## net/phonet/pep.c ##
     @@ net/phonet/pep.c: static int pep_sock_enable(struct sock *sk, struct sockaddr *addr, int len)
    @@ net/phonet/pep.c: static int pep_sock_enable(struct sock *sk, struct sockaddr *a
     +	return len;
     +}
     +
    - static int pep_ioctl(struct sock *sk, int cmd, int *karg)
    + static int pep_ioctl(struct sock *sk, int cmd, unsigned long arg)
      {
      	struct pep_sock *pn = pep_sk(sk);
    -@@ net/phonet/pep.c: static int pep_ioctl(struct sock *sk, int cmd, int *karg)
    +@@ net/phonet/pep.c: static int pep_ioctl(struct sock *sk, int cmd, unsigned long arg)
      			break;
      		}
      
     -		lock_sock(sk);
     -		if (sock_flag(sk, SOCK_URGINLINE) &&
     -		    !skb_queue_empty(&pn->ctrlreq_queue))
    --			*karg = skb_peek(&pn->ctrlreq_queue)->len;
    +-			answ = skb_peek(&pn->ctrlreq_queue)->len;
     -		else if (!skb_queue_empty(&sk->sk_receive_queue))
    --			*karg = skb_peek(&sk->sk_receive_queue)->len;
    +-			answ = skb_peek(&sk->sk_receive_queue)->len;
     -		else
    --			*karg = 0;
    +-			answ = 0;
     -		release_sock(sk);
    -+		*karg = pep_first_packet_length(sk);
    - 		ret = 0;
    ++		answ = pep_first_packet_length(sk);
    + 		ret = put_user(answ, (int __user *)arg);
      		break;
      
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

