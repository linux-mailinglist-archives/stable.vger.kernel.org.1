Return-Path: <stable+bounces-110183-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4555FA193AC
	for <lists+stable@lfdr.de>; Wed, 22 Jan 2025 15:17:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79E6216B885
	for <lists+stable@lfdr.de>; Wed, 22 Jan 2025 14:17:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45DDA21420C;
	Wed, 22 Jan 2025 14:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TYR0H/yr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05F53322E
	for <stable@vger.kernel.org>; Wed, 22 Jan 2025 14:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737555397; cv=none; b=uy87MO1ElNmUG7wcXDiKr26PhM+vK+MoTiGiTKIjCT7qMHwvqEQ8H+y/E6//HkJugspGDfOCK78nCtL91pF8LIbwIGdk3xsVc/bfP2qz4GNYIaBXYNw4xnYys+eSETTQp1B1egbeS+SMPfXybk3/XnryO4woS9/JuCOuGFNIrXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737555397; c=relaxed/simple;
	bh=ln/cOL8WlgvGNHOVIO1IJvlRutdwsjAbbcam1IrXjf8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GyZSBaKfCwArTIo9iG+so8cCXsp9foDPFJsVVG312YAEKd3KmRR3EbFb+GbiYKdnwXIIqLqOTmGROJgIwIUvqEyqI+/ae43rBesEEC4hHQHXq2fl1CyIenUxJe/vYqnb5ot34UhSCs+KNIHCC9dnU2yQdSszEezYWpaQjbGEnT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TYR0H/yr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09207C4CED3;
	Wed, 22 Jan 2025 14:16:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737555396;
	bh=ln/cOL8WlgvGNHOVIO1IJvlRutdwsjAbbcam1IrXjf8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TYR0H/yr2KFo277N0LMuzIjDn5UzhwZXIHRZU1jryXsfOc1q+IZL4ppZVy/2njE7P
	 FnugfZfGAt30cx/hU2kXUMPGhH7On/BU602g0Uostqul2ZfjWlwTn93wUorEZrFOjm
	 BlBvTQvqkMSapRlUIAWY5/fly6V/gk4DSu8YWCNZaS6x3F5O+pFhQ0Xs2c5ypOKqHa
	 D6MgVf+c2yN9bmSAsnXGax/NHy5oQx3woDIKPqW/aO2xzRRfXnvkMaz3pxifSXOWTA
	 fSmtnneXRrCXEpKmsQAenqFO8VwG4mkKkSVaE+r90mkWZ87RbDKOXGWRPSRWwcGxtX
	 dYeQzodSfijUw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15.y] mptcp: don't always assume copied data in mptcp_cleanup_rbuf()
Date: Wed, 22 Jan 2025 09:16:34 -0500
Message-Id: <20250122091240-b02595b2928788b2@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250122111517.3284651-2-matttbe@kernel.org>
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

The upstream commit SHA1 provided is correct: 551844f26da2a9f76c0a698baaffa631d1178645

WARNING: Author mismatch between patch and upstream commit:
Backport author: "Matthieu Baerts (NGI0)"<matttbe@kernel.org>
Commit author: Paolo Abeni<pabeni@redhat.com>


Status in newer kernel trees:
6.12.y | Present (different SHA1: 10a641cad465)
6.6.y | Present (different SHA1: f61e663d78ff)
6.1.y | Present (different SHA1: 91b493f15d65)
5.15.y | Not found

Note: The patch differs from the upstream commit:
---
1:  551844f26da2a ! 1:  3fe05f72a15ff mptcp: don't always assume copied data in mptcp_cleanup_rbuf()
    @@ Metadata
      ## Commit message ##
         mptcp: don't always assume copied data in mptcp_cleanup_rbuf()
     
    +    commit 551844f26da2a9f76c0a698baaffa631d1178645 upstream.
    +
         Under some corner cases the MPTCP protocol can end-up invoking
         mptcp_cleanup_rbuf() when no data has been copied, but such helper
         assumes the opposite condition.
    @@ Commit message
         Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
         Link: https://patch.msgid.link/20241230-net-mptcp-rbuf-fixes-v1-2-8608af434ceb@kernel.org
         Signed-off-by: Jakub Kicinski <kuba@kernel.org>
    +    [ Conflicts in this version, because commit 581302298524 ("mptcp: error
    +      out earlier on disconnect") has not been backported to this version,
    +      and there was no need to do so. The only conflict was in protocol.c,
    +      and easy to resolve: the context was different, but the same addition
    +      can still be made at the same spot in mptcp_recvmsg(). ]
    +    Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
     
      ## net/mptcp/protocol.c ##
     @@ net/mptcp/protocol.c: static void mptcp_send_ack(struct mptcp_sock *msk)
    @@ net/mptcp/protocol.c: static int mptcp_recvmsg(struct sock *sk, struct msghdr *m
      
      		pr_debug("block timeout %ld\n", timeo);
     +		mptcp_cleanup_rbuf(msk, copied);
    - 		err = sk_wait_data(sk, &timeo, NULL);
    - 		if (err < 0) {
    - 			err = copied ? : err;
    -@@ net/mptcp/protocol.c: static int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
    - 		}
    + 		sk_wait_data(sk, &timeo, NULL);
      	}
      
     +	mptcp_cleanup_rbuf(msk, copied);
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.15.y       |  Success    |  Success   |

