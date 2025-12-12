Return-Path: <stable+bounces-200926-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ACA3CB941D
	for <lists+stable@lfdr.de>; Fri, 12 Dec 2025 17:28:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0CE2D3008D77
	for <lists+stable@lfdr.de>; Fri, 12 Dec 2025 16:28:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B79E62566F5;
	Fri, 12 Dec 2025 16:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eI6bMfiP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CC28126BF7;
	Fri, 12 Dec 2025 16:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765556926; cv=none; b=j+HIeY0b79uHlIMDyN2aUtrFMcWLYlWxcI+EwvJ+8POC9H8Fgcmta60gBS9WgMOmznNG9l5yOeCT8aHNRB8RPAw8+tlzTr+lw+WBtqN1isRXq3r/aWmm9tC8phYOuf3cADOnBmE1iybZ2+YXnfjKYx/9zyQEeyZanFtHd6xgqJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765556926; c=relaxed/simple;
	bh=fEmhw1h7YJFGHFA68zvlM24xSYIvIkahajauXo3ypsg=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=dAG/KNDgOHOL5j55XwnlMJTv9v2uQZ7jEeTLiWn072iBzdEX/mz7cNwdbc9gk8z1syVbmQY6dvYODyjZSxnBxuyZGVoI9ciyT+bmBxodUOjgh+drsiiMH0hlqiy97lvaMi/i5ooFrtNyoofyE54yMK0Mq1QdNa4/uAvI0MUiC1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eI6bMfiP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE323C4CEF1;
	Fri, 12 Dec 2025 16:28:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765556926;
	bh=fEmhw1h7YJFGHFA68zvlM24xSYIvIkahajauXo3ypsg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=eI6bMfiPP4BBLYNT9uDTUDZcBmSW118IG4G+hOhNqpFa2zhUudYnBCczziZSlVXat
	 co8A+M3W/aZxQK0aHkvWISLS/0VE1o7qpElrqZ+etki2QDxkZDmPgGgpFgTqg+RXYE
	 dvFaI44cUPvcD8RWf9ecbeXFbZjuLE++e8ipTPSybuUYQocq2BRdnTrL3QL8/bJ2wn
	 ew4FY9HusH3HVFS9Jri0tug4Tvi92nvp4bL5U2iNAyRfGEBKapXvg/5Np4TeSBqgyp
	 hewBBLRU9UYinePg8Be+PzEfLJTuo7601gT5YRxLJVLYBsm7DEbLA8VVIHAYIS3jA2
	 s/veKdUWFR3sA==
Date: Fri, 12 Dec 2025 06:28:44 -1000
Message-ID: <7d0d2b42a1e1d1f2afdc67f9bce6a9f1@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Tejun Heo <tj@kernel.org>
Cc: Andrea Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>,
 David Vernet <void@manifault.com>, Emil Tsalapatis <emil@etsalapatis.com>,
 linux-kernel@vger.kernel.org, sched-ext@lists.linux.dev,
 stable@vger.kernel.org
Subject: Re: [PATCHSET v2 sched_ext/for-6.19-fixes] sched_ext: Fix missing
 post-enqueue handling in move_local_task_to_local_dsq()
In-Reply-To: <20251212014504.3431169-1-tj@kernel.org>
References: <20251212014504.3431169-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

> Tejun Heo (2):
>   sched_ext: Factor out local_dsq_post_enq() from dispatch_enqueue()
>   sched_ext: Fix missing post-enqueue handling in move_local_task_to_local_dsq()

Applied to sched_ext/for-6.19-fixes.

Thanks.
--
tejun

