Return-Path: <stable+bounces-146012-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE8C1AC0245
	for <lists+stable@lfdr.de>; Thu, 22 May 2025 04:08:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A09F1BC3337
	for <lists+stable@lfdr.de>; Thu, 22 May 2025 02:08:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB8758BEC;
	Thu, 22 May 2025 02:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z3BgQWVx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 984E8610D
	for <stable@vger.kernel.org>; Thu, 22 May 2025 02:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747879714; cv=none; b=iTRhvROpgb386SPlgreIZr8GOitbPsg1o57ryAatHpVxvnVaWOy1B+D8EQicHfedKxGc4rouuJINGj8br9gpv2SPELtDedcwaaQ0Q6bknOqEMZzVvAsoT1lsIjIsBdcPLP21JyMfw96qUD6BjgtCpcLBKGmwgwH9bDoGDouE8K4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747879714; c=relaxed/simple;
	bh=lPZEvqGBjNs+R5d4ftDgdBa3nXor+vJvqMw3Hn3Ui1w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hkwgTMWCh7cFANP9HXDHFYQ92QxMZEBmlhMoy5XmNzsNp/B9VkW/lIhkNLj1Z8r3kawq1t1qpTRi5umQqcg2C/eRkwwsdy0tmy/byJ/l2qy9kFhqN/guxovgHFwl2Y+KzOM4JJEMFbL3E+O96W9SWlFCxTRg1uqrMKMNzfFCkDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z3BgQWVx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83DB2C4CEE4;
	Thu, 22 May 2025 02:08:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747879714;
	bh=lPZEvqGBjNs+R5d4ftDgdBa3nXor+vJvqMw3Hn3Ui1w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Z3BgQWVxGkYmtpx2FFzTqesTZ6Fg2HagOIZBKbK9/F/uev/qdWCDqyS8KpnveCEvV
	 hjLbwKAuptdykv6EUZppEbRUtt012lhY6SVw0+w0B+u+PNU786P3JBwXoOIWSl1mzW
	 R+BqCk9M4Vk2VK2AkEIahEm3x8uCi39nO0RDxvRzWRM3L02GmC4e0piUtokKukDVjr
	 s9ciKW4uvZtig4xQmpnLiTOQnnbIdD7fSgwQdnqCvCGeIPQpsMa4KOFgI1f0eL9I/0
	 Ox5YAS0je8PHJpSch9vsCQut8WLz3v30EywYq8ZKimhKY29q+9hBU63CS3WAfLELPO
	 ymrwJD1+82nMw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Lee Jones <lee@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH v6.6 13/26] af_unix: Save listener for embryo socket.
Date: Wed, 21 May 2025 22:08:30 -0400
Message-Id: <20250521174346-cefd3e94c3cc5ebd@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250521144803.2050504-14-lee@kernel.org>
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

The upstream commit SHA1 provided is correct: aed6ecef55d70de3762ce41c561b7f547dbaf107

WARNING: Author mismatch between patch and upstream commit:
Backport author: Lee Jones<lee@kernel.org>
Commit author: Kuniyuki Iwashima<kuniyu@amazon.com>

Status in newer kernel trees:
6.14.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)

Note: The patch differs from the upstream commit:
---
1:  aed6ecef55d70 ! 1:  ef147e48ace39 af_unix: Save listener for embryo socket.
    @@ Metadata
      ## Commit message ##
         af_unix: Save listener for embryo socket.
     
    +    [ Upstream commit aed6ecef55d70de3762ce41c561b7f547dbaf107 ]
    +
         This is a prep patch for the following change, where we need to
         fetch the listening socket from the successor embryo socket
         during GC.
    @@ Commit message
         Acked-by: Paolo Abeni <pabeni@redhat.com>
         Link: https://lore.kernel.org/r/20240325202425.60930-8-kuniyu@amazon.com
         Signed-off-by: Jakub Kicinski <kuba@kernel.org>
    +    (cherry picked from commit aed6ecef55d70de3762ce41c561b7f547dbaf107)
    +    Signed-off-by: Lee Jones <lee@kernel.org>
     
      ## include/net/af_unix.h ##
     @@ include/net/af_unix.h: struct unix_sock {
    @@ include/net/af_unix.h: struct unix_sock {
     
      ## net/unix/af_unix.c ##
     @@ net/unix/af_unix.c: static struct sock *unix_create1(struct net *net, struct socket *sock, int kern,
    - 	sk->sk_max_ack_backlog	= net->unx.sysctl_max_dgram_qlen;
    + 	sk->sk_max_ack_backlog	= READ_ONCE(net->unx.sysctl_max_dgram_qlen);
      	sk->sk_destruct		= unix_sock_destructor;
      	u = unix_sk(sk);
     +	u->listener = NULL;
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.12.y       |  Success    |  Success   |

