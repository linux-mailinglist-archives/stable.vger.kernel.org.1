Return-Path: <stable+bounces-134680-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87DC2A9432F
	for <lists+stable@lfdr.de>; Sat, 19 Apr 2025 13:47:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3D333BB4E2
	for <lists+stable@lfdr.de>; Sat, 19 Apr 2025 11:46:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5F601B4244;
	Sat, 19 Apr 2025 11:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E4hxfzwh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6CFB18DB29
	for <stable@vger.kernel.org>; Sat, 19 Apr 2025 11:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745063224; cv=none; b=dbVsq7HlsUG9PQ8Jt84Gja+2D5YQSM9dA3xMRJ5wEg/q/CzB7M+zrnvWuVdiObSzLKeXTAAS0g00oLYfolxFtLDHkUn/6qDgNqXe9WLlQh7qJRdfwfMYlD7U9rMBouqyT+Q9Y0NpWJJl2XUnSe+t9X+BfncrUAKowim3B0LdoQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745063224; c=relaxed/simple;
	bh=DhTExp8dbCWuQqfnhlQCw6K1xmHyb8kzDuLHH9Ocggk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Aa7FUHfhpLz/hU6WrrbiH8dRCk963uSftCwI15PvZHzZp5gHoCOGpEmSR9AbRT2xrHHMgCfU6+HL6+PDv+8N4f5sfPVQTMsGss/g9v08axc9aBJSoQfDSTezb4UdcwnG6QXEJFRQGGfEf84R3+Gm7nNptHcSOhe44SbViFBHWPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E4hxfzwh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 105E5C4CEE7;
	Sat, 19 Apr 2025 11:47:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745063224;
	bh=DhTExp8dbCWuQqfnhlQCw6K1xmHyb8kzDuLHH9Ocggk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=E4hxfzwh8PE3Iv2syyFJFlolzvGkz0ADRAjP51TMyb56382bb1K23rlOTkVoY2Zl+
	 tv30Uk28heCX/++nN0ZB+xWU5ZN9tNypE1Dyu5unw8VqS+drF+WWCjEF5RwuZ3I/7p
	 ew4nePh1hIi/Qt/GYKqn3jeFJCsL1hpyYboPnTpWbhIJu/YF4k/zbhuD6qQaz6ENeA
	 D0kppTg/wz23A24wjlIPnajCzkEEdk2fvux6ASCYcyaJDMTaM+H7MYBJWr2D2qqyf9
	 OJSRhquTlMAxtKhGPdFKL4BnGlbhfODIZ3ck2vRz4l1OTdXJm+lgrmoHJtIobZx9Nh
	 KDetlsvf6o7Cg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15.y] mptcp: sockopt: fix getting IPV6_V6ONLY
Date: Sat, 19 Apr 2025 07:47:02 -0400
Message-Id: <20250418194801-fdb746f13d97591f@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250418102319.3212564-2-matttbe@kernel.org>
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

The upstream commit SHA1 provided is correct: 8c39633759885b6ff85f6d96cf445560e74df5e8

Status in newer kernel trees:
6.14.y | Present (different SHA1: 233afced24eb)
6.13.y | Present (different SHA1: 41e890efe9aa)
6.12.y | Present (different SHA1: acc1f6a05ab2)
6.6.y | Present (different SHA1: 51893ff3b0f8)
6.1.y | Present (different SHA1: 0fb46064c253)

Note: The patch differs from the upstream commit:
---
1:  8c39633759885 ! 1:  21b4c2929499d mptcp: sockopt: fix getting IPV6_V6ONLY
    @@ Metadata
      ## Commit message ##
         mptcp: sockopt: fix getting IPV6_V6ONLY
     
    +    commit 8c39633759885b6ff85f6d96cf445560e74df5e8 upstream.
    +
         When adding a socket option support in MPTCP, both the get and set parts
         are supposed to be implemented.
     
    @@ Commit message
         Reviewed-by: Simon Horman <horms@kernel.org>
         Link: https://patch.msgid.link/20250314-net-mptcp-fix-data-stream-corr-sockopt-v1-2-122dbb249db3@kernel.org
         Signed-off-by: Paolo Abeni <pabeni@redhat.com>
    +    [ Conflicts in sockopt.c in the context, because commit 3b1e21eb60e8
    +      ("mptcp: getsockopt: add support for IP_TOS") is not in this release.
    +      The conflicts are in the context, the new helper can be added without
    +      issue. It depends on mptcp_put_int_option() which has been added via
    +      another backport, see commit 874aae15fbef ("mptcp: fix full TCP
    +      keep-alive support"). ]
    +    Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
     
      ## net/mptcp/sockopt.c ##
    -@@ net/mptcp/sockopt.c: static int mptcp_getsockopt_v4(struct mptcp_sock *msk, int optname,
    +@@ net/mptcp/sockopt.c: static int mptcp_getsockopt_sol_tcp(struct mptcp_sock *msk, int optname,
      	return -EOPNOTSUPP;
      }
      
    @@ net/mptcp/sockopt.c: static int mptcp_getsockopt_v4(struct mptcp_sock *msk, int
     +	return -EOPNOTSUPP;
     +}
     +
    - static int mptcp_getsockopt_sol_mptcp(struct mptcp_sock *msk, int optname,
    - 				      char __user *optval, int __user *optlen)
    + int mptcp_getsockopt(struct sock *sk, int level, int optname,
    + 		     char __user *optval, int __user *option)
      {
     @@ net/mptcp/sockopt.c: int mptcp_getsockopt(struct sock *sk, int level, int optname,
    + 	if (ssk)
    + 		return tcp_getsockopt(ssk, level, optname, optval, option);
      
    - 	if (level == SOL_IP)
    - 		return mptcp_getsockopt_v4(msk, optname, optval, option);
     +	if (level == SOL_IPV6)
     +		return mptcp_getsockopt_v6(msk, optname, optval, option);
      	if (level == SOL_TCP)
      		return mptcp_getsockopt_sol_tcp(msk, optname, optval, option);
    - 	if (level == SOL_MPTCP)
    + 	return -EOPNOTSUPP;
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.15.y       |  Success    |  Success   |

