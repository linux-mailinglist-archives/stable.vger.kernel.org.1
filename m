Return-Path: <stable+bounces-164961-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 321B4B13CFC
	for <lists+stable@lfdr.de>; Mon, 28 Jul 2025 16:23:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 699103A3F11
	for <lists+stable@lfdr.de>; Mon, 28 Jul 2025 14:19:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7BB626B0BC;
	Mon, 28 Jul 2025 14:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dcrSTsJn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ED8928373
	for <stable@vger.kernel.org>; Mon, 28 Jul 2025 14:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753712423; cv=none; b=hdPuDxznC3VgPNwDefsVgVlfq53TvEyTyc3W3BVKJ1QKqvQGyt8/5u5K8d5aPRzTflUWvTqag1k9AYxzBbBQc5RjXYyzbvchWuCoAZNvwjEL1Emi984dGrOLBCd2oKU8nZfSIhst0s9hk64sJBWw9gpAobKCGgRMs/0culv/qgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753712423; c=relaxed/simple;
	bh=N/LWLD6xvjAbny59sqotoBA/yL8J6KnHDMtOnkMmMgQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f+ns7lGORsvoIV67dUYJpwKtTVHcsBwGoW4UwoYoRf99W6DWz1wgXo6EwdkjUTS0YT6+dingNFwg2rQi9ZAaQODSwjopj/nElm5QOnhsQE/BpIU0At9tK1z/BIIbZz3l8r198BGrOJzxKLSERZ64SXZKAr2a2CG2y7Bw6phcVAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dcrSTsJn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A227BC4CEE7;
	Mon, 28 Jul 2025 14:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753712423;
	bh=N/LWLD6xvjAbny59sqotoBA/yL8J6KnHDMtOnkMmMgQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dcrSTsJnBT+g/FoRvEWHLTP6FlFswcDJ1D6EXMZp30EMvIgr7VwOxbGPK4ba1AEpU
	 ty6IG/Yr812j87c01NEX252o83X7hnVIKtFHkkWDqGyHpT6PfNqg27HClb30VGyrsW
	 3BwBCWr92lqPriHhzj6Yfnk3qUB6vNWpFL2BWD0MYZhEy2rmrBMRfHUljRQP+zeh51
	 3wsaDnNcJ5Vwocf8QH+dCoqYWuV29ZxgZ3QajXDTBV7/ABxYKereaH9Ky42osrYnVT
	 ygd4FI36l3P+edp71SCyooPhvYUfXISzt3CHAPQuc5CQltrgGSS09XcsMqBLBGFCsp
	 sL39qSG+ZFDoQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.6.y 3/3] mptcp: reset fallback status gracefully at disconnect() time
Date: Mon, 28 Jul 2025 10:20:20 -0400
Message-Id: <1753710465-a0ada053@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250728091448.3494479-8-matttbe@kernel.org>
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

Note: The patch differs from the upstream commit:
---
1:  da9b2fc7b73d ! 1:  eaa8b9f461e1 mptcp: reset fallback status gracefully at disconnect() time
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
    +    Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
     
      ## net/mptcp/protocol.c ##
     @@ net/mptcp/protocol.c: static int mptcp_disconnect(struct sock *sk, int flags)
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
| 6.6                       | Success     | Success    |

