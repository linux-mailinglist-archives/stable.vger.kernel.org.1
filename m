Return-Path: <stable+bounces-146011-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BA41AC0244
	for <lists+stable@lfdr.de>; Thu, 22 May 2025 04:08:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6111C3B5789
	for <lists+stable@lfdr.de>; Thu, 22 May 2025 02:08:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCDC0539A;
	Thu, 22 May 2025 02:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p5YXAsPN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B7B4610D
	for <stable@vger.kernel.org>; Thu, 22 May 2025 02:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747879710; cv=none; b=HWvvsYtAmJ9li4exR/ycPdy9rk2Owsl6maeQOttuLiOOh+CoNXADQUcan8Bv96qjU51Wd5mEU7EYryfIjd7wA5To1IWOVkldhZusxWNU/MUMM2nDElGG5b4JAWq7TwlCW5uo57eDEubEcz7SjaSC2lUIi9WEYUQ+XjfZ0ijqTkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747879710; c=relaxed/simple;
	bh=UR/N7B9XUhOJpXuZGQuKNSiU6wnLBf/8mfZgz9WRQ7I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UTxM0hZFVp7IuGFS+G0iWGHtnuniLuCoos9puHhE8hQ6oZxnweecXe5N6PEWHbZltHPw0zSQ5SNHNJLBlIW8qjX6i6iS2H0ZMYfYhgQyaZi9cu5c0s5Bw29PrhIe5/tkwYJXsIl7ysONI2pxkk1A6ESa7aev4puixV4EbtV5/Mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p5YXAsPN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C79AC4CEE4;
	Thu, 22 May 2025 02:08:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747879710;
	bh=UR/N7B9XUhOJpXuZGQuKNSiU6wnLBf/8mfZgz9WRQ7I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=p5YXAsPNIFUcEgW3TBUvFujj2KtihluF2h43GL3XuPDMi6tppOQyFApNv/AYZyc01
	 FlAMe6QVhCbaQOo+DLzr5m3+w697oYx+rfa1gWjSH3hHDFP5Nm5FnRTNHmAjtySIZn
	 foZ7l9tc2mb8VwYlE5XUI8TZ0hPPl4mJ/ywYXQ5gYFRJdonaff6/h9JKuXOezGVGXU
	 d7wY7JouL5VMbf0cUll4Gxs1sO5EfYrlJ0K6Iu7XWMoCfzfRgOOADwf0ep6IU0KLwU
	 90yoQ/TbrPUiw8fcvARVsTJ8gcaVwJenLyRDG/0DmEnIjYghcGhzU6R7+7R4zQcPS1
	 qsJ2KBGOpRSmw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Lee Jones <lee@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH v6.1 14/27] af_unix: Save listener for embryo socket.
Date: Wed, 21 May 2025 22:08:26 -0400
Message-Id: <20250521204727-6e489e180fbf3616@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250521152920.1116756-15-lee@kernel.org>
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
6.6.y | Not found

Note: The patch differs from the upstream commit:
---
1:  aed6ecef55d70 ! 1:  bb250adb0457d af_unix: Save listener for embryo socket.
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
| stable/linux-6.6.y        |  Success    |  Success   |

