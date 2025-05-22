Return-Path: <stable+bounces-145968-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E4B4AC0212
	for <lists+stable@lfdr.de>; Thu, 22 May 2025 04:05:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B2354A74E8
	for <lists+stable@lfdr.de>; Thu, 22 May 2025 02:05:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B45235953;
	Thu, 22 May 2025 02:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OhkxLRTx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEDA41758B
	for <stable@vger.kernel.org>; Thu, 22 May 2025 02:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747879496; cv=none; b=LbL11cyFTj8kZyzJghsJrVCKoVYK8X55vtg3ZnKIpvZmgSEEF8JyA3UXXQEvreQhpD86B8qYMOy7cRLZHFN1rqIElg77drJ01PSuz8FE2H2Gfa+uuhcttLcjKR+oK3CFWYpieP8uNvFbIkiL5ev6+PShD9LuODkQRurayGsh+HM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747879496; c=relaxed/simple;
	bh=PzDVTAfmAG+qbPZBJi6w0HMPOaoUsaHD+uuYOsPUF0Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S0KC/H8C0vcGsihG6IJiluiv1AFgyqpfVxakD2nnTw4uIbeBgQEhWVbx6jIMmTgcL0AW0wWFCqq0paJEbv82NKJaZE22ttIwGXXBgLm7NgZFLVCIzcjex7zWowkEEYFe1ohO/jtsuShjxHUpbBhssR8Q3jtcr3v4ZsubKyWYkGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OhkxLRTx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4296C4CEE4;
	Thu, 22 May 2025 02:04:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747879496;
	bh=PzDVTAfmAG+qbPZBJi6w0HMPOaoUsaHD+uuYOsPUF0Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OhkxLRTxxcFkKeR3IadPi5dzJKvcoIm+esbieA7hIMVIX6PL8Cbq1mEeWJhaLsc+h
	 rYIgpJR5gw8CgbUi2nIGTBD5XrgIMnV8NdxNkIRLIO0WE+RCq7O7u/2QsOgwnJy4pI
	 frro4FINOtnkPU7UG/g9kDwU3aKO53BX+IbZUSiHCwNhg87iJo4OAjv62ORN1yZxzo
	 38o5Ndptq8iN10WHo1JWOaXJtAGccKPsHgWgpcuwueZ3hlcZ6qhj8c9ZlZcdLsrGzc
	 xmr7IZ0A4VZScb5OE38JaBE+M2NH4S1AlGo0aKthkPhEUBYnyNBb4W7JekUykJFgEP
	 DEkeDX4b+gDaA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Lee Jones <lee@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH v6.6 11/26] af_unix: Iterate all vertices by DFS.
Date: Wed, 21 May 2025 22:04:52 -0400
Message-Id: <20250521173459-3d235b3691a4a0bb@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250521144803.2050504-12-lee@kernel.org>
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

The upstream commit SHA1 provided is correct: 6ba76fd2848e107594ea4f03b737230f74bc23ea

WARNING: Author mismatch between patch and upstream commit:
Backport author: Lee Jones<lee@kernel.org>
Commit author: Kuniyuki Iwashima<kuniyu@amazon.com>

Status in newer kernel trees:
6.14.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)

Note: The patch differs from the upstream commit:
---
1:  6ba76fd2848e1 ! 1:  980cc703f03ae af_unix: Iterate all vertices by DFS.
    @@ Metadata
      ## Commit message ##
         af_unix: Iterate all vertices by DFS.
     
    +    [ Upstream commit 6ba76fd2848e107594ea4f03b737230f74bc23ea ]
    +
         The new GC will use a depth first search graph algorithm to find
         cyclic references.  The algorithm visits every vertex exactly once.
     
    @@ Commit message
         Acked-by: Paolo Abeni <pabeni@redhat.com>
         Link: https://lore.kernel.org/r/20240325202425.60930-6-kuniyu@amazon.com
         Signed-off-by: Jakub Kicinski <kuba@kernel.org>
    +    (cherry picked from commit 6ba76fd2848e107594ea4f03b737230f74bc23ea)
    +    Signed-off-by: Lee Jones <lee@kernel.org>
     
      ## include/net/af_unix.h ##
     @@ include/net/af_unix.h: struct unix_vertex {
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.12.y       |  Success    |  Success   |

