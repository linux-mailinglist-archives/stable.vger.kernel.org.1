Return-Path: <stable+bounces-165144-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CBB4FB15484
	for <lists+stable@lfdr.de>; Tue, 29 Jul 2025 23:03:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0A77561C1D
	for <lists+stable@lfdr.de>; Tue, 29 Jul 2025 21:03:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62C012405E7;
	Tue, 29 Jul 2025 21:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JG8Vqmbv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 236CC19F13F
	for <stable@vger.kernel.org>; Tue, 29 Jul 2025 21:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753822990; cv=none; b=slNIlep7kOtzuSkF/S97QSg6U8/ds1ygI6lERW6ktAyKzci1diiZRheXSeVvk9wwxCPC7kEWkZa0X4G84sqJafP9k+vcFtGcNL/W6Nt9egYEZ7/P/yrHFWQ6gBf2sG5cw8Dse0bWEUbmJd98c/mRPBATxJ6AGXt8JX4jRVbjPuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753822990; c=relaxed/simple;
	bh=4K/4f1DZTkQ74ebU/eKzIDEW/PMj+iSRVzGofAVoJ8o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k2m1i6Mx/+ro9OlA/jUeKbcvupx1lWZvVH7FIqS5fwVcXn1cYuP4+F0UAnfmrJAxnXvtuph63BZHoVs3YswGkD8coqrTIN5NYOndcLPavXi3nG7EFWNtG968P4O50wwRcuN3M0yRMUlxPQXVyI4YaUbTRLUqoOelt6d/30pndvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JG8Vqmbv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FEF4C4CEEF;
	Tue, 29 Jul 2025 21:03:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753822989;
	bh=4K/4f1DZTkQ74ebU/eKzIDEW/PMj+iSRVzGofAVoJ8o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JG8Vqmbvf8ac4x55XsOO8JL5aAW/NA52DRc9OE/3ZP6AIgI2y2C4FpMKl+tfZhIpc
	 BT8BWDdnMbQayGXeLP5w9Yb1hXqjAlOXGAZlSFWpQ1RbSZLMpsPrrVUhN8FfPMPQRs
	 pkChFjH2qOVJK8jHUHsY161djxCyg/belukiYV/PmmTSevoMPfVswx93TGVjx0ytVh
	 53oRsVyElEDvNVbseEdPosT2KdANfqLrR7uqSplPTybCWbttrJ/HH6hsSGH46gRADy
	 jDINi/XxfZlXynoNfVoGRtFtiB4se7lAherbAljePcKj/wzDXZHzaJnw5bGo0J65UC
	 6ZyVLSXOGU2Kg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1.y 3/3] mptcp: reset fallback status gracefully at disconnect() time
Date: Tue, 29 Jul 2025 17:03:07 -0400
Message-Id: <1753816740-791ed0de@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250728132919.3904847-8-matttbe@kernel.org>
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

The upstream commit SHA1 provided is correct: da9b2fc7b73d147d88abe1922de5ab72d72d7756

WARNING: Author mismatch between patch and upstream commit:
Backport author: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Commit author: Paolo Abeni <pabeni@redhat.com>

Status in newer kernel trees:
6.15.y | Not found
6.12.y | Not found
6.6.y | Not found

Note: The patch differs from the upstream commit:
---
1:  da9b2fc7b73d ! 1:  96832530025f mptcp: reset fallback status gracefully at disconnect() time
    @@ Metadata
      ## Commit message ##
         mptcp: reset fallback status gracefully at disconnect() time
     
    +    commit da9b2fc7b73d147d88abe1922de5ab72d72d7756 upstream.
    +
         mptcp_disconnect() clears the fallback bit unconditionally, without
         touching the associated flags.
     
    @@ Commit message
         Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
         Link: https://patch.msgid.link/20250714-net-mptcp-fallback-races-v1-3-391aff963322@kernel.org
         Signed-off-by: Jakub Kicinski <kuba@kernel.org>
    +    [ Conflicts in protocol.c, because commit ebc1e08f01eb ("mptcp: drop
    +      last_snd and MPTCP_RESET_SCHEDULER") is not in this version and
    +      changed the context. The same modification can still be applied at the
    +      same place. ]
    +    Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
     
      ## net/mptcp/protocol.c ##
     @@ net/mptcp/protocol.c: static int mptcp_disconnect(struct sock *sk, int flags)
    - 	 * subflow
      	 */
      	mptcp_destroy_common(msk, MPTCP_CF_FASTCLOSE);
    + 	msk->last_snd = NULL;
     +
     +	/* The first subflow is already in TCP_CLOSE status, the following
     +	 * can't overlap with a fallback anymore
    @@ net/mptcp/protocol.c: static int mptcp_disconnect(struct sock *sk, int flags)
     +
      	msk->cb_flags = 0;
      	msk->recovery = false;
    - 	WRITE_ONCE(msk->can_ack, false);
    + 	msk->can_ack = false;

---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| 6.1                       | Success     | Success    |

