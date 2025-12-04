Return-Path: <stable+bounces-200025-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 73188CA3EEE
	for <lists+stable@lfdr.de>; Thu, 04 Dec 2025 15:02:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 25BC531B333C
	for <lists+stable@lfdr.de>; Thu,  4 Dec 2025 13:52:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 239183385A7;
	Thu,  4 Dec 2025 13:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vPbZtY6W"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7CE6224244;
	Thu,  4 Dec 2025 13:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764856346; cv=none; b=b8OtH/r6Q/eThlWWeusfcxtC0M0g/OoqpM8sM4Ccp/BBv9jYx/eDPuwOx9PwBsVHaAVzfbcFDbxxFd7j8vUFkfI+fEQCQct5whSc5risK/8heUL1Hql0lwMlYuMpgfV7MC8Tse9kMphGXK5s/5VWKUUs0+V0fl6v0l/bvUazAiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764856346; c=relaxed/simple;
	bh=rlg97I9Cupo7EMj1+KxzPDekJZu+BcEwn8d6PQfmAnI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T4py5lpqCe4S8Yr5NicpaxDx39e2UoMunVfCGRNACeTS+ubffbk3D8fjnqazoNXWvMVzdrobTyV7nGUyFg51NIicpBOxlfkW0/isx4OQZejyPeOcQaueD2Y9oEO6oF/N+U+Bw8rcbMno5ZlITVL3C4Xzw97+bVV/nABkee0pPRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vPbZtY6W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27B0AC4CEFB;
	Thu,  4 Dec 2025 13:52:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764856346;
	bh=rlg97I9Cupo7EMj1+KxzPDekJZu+BcEwn8d6PQfmAnI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vPbZtY6WMugEKp0RNvmEZCaiArHzwRPdG76VJe5yT04mm+Cau89L2Szbovo7eONXc
	 WresR09KITdg0suXIJOYJ7PyHCxYj3xsmoLrHEPiwORm7NZXQVgME9wlIN8z9oc8et
	 IZ7EGLjnZyt1KhhZFxYHPHSzuiQZt3JG1vNBfkmZjsWYCGE4f2PLa5MVGhzTWfVsBj
	 cxMHkrWAYCub9whR/mL6KkIrwWa343++RwO9Lxr8vppjFq5AszheYl3ajVEs2OCmjw
	 5Szd2glBaq4rns5hhOpGaDeBA/76pPyK3vWzk/VabKoSeNF/XNa3dFB6X7vdJ15+Jf
	 Xm2NhYGvMO3PQ==
Date: Thu, 4 Dec 2025 13:52:21 +0000
From: Simon Horman <horms@kernel.org>
To: caoping <caoping@cmss.chinamobile.com>
Cc: chuck.lever@oracle.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com,
	kernel-tls-handshake@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v3] net/handshake: restore destructor on submit failure
Message-ID: <aTGSFbdNsVRQA4Uc@horms.kernel.org>
References: <20251204091058.1545151-1-caoping@cmss.chinamobile.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251204091058.1545151-1-caoping@cmss.chinamobile.com>

On Thu, Dec 04, 2025 at 01:10:58AM -0800, caoping wrote:
> handshake_req_submit() replaces sk->sk_destruct but never restores it when
> submission fails before the request is hashed. handshake_sk_destruct() then
> returns early and the original destructor never runs, leaking the socket.
> Restore sk_destruct on the error path.
> 
> Fixes: 3b3009ea8abb ("net/handshake: Create a NETLINK service for handling handshake requests")
> Reviewed-by: Chuck Lever <chuck.lever@oracle.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: caoping <caoping@cmss.chinamobile.com>

Please slow down a bit.

When posting patches to netdev ML please allow at least 24h to elapse
between revisions. This is to allow time for review. And ease load
on shared CI infrastructure. Thanks!

Link: https://docs.kernel.org/process/maintainer-netdev.html

