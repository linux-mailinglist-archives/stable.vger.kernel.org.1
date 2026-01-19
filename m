Return-Path: <stable+bounces-210375-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id DEB16D3B120
	for <lists+stable@lfdr.de>; Mon, 19 Jan 2026 17:33:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1871E3062BB2
	for <lists+stable@lfdr.de>; Mon, 19 Jan 2026 16:27:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7E22328B64;
	Mon, 19 Jan 2026 16:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uj2702ob"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A887328254;
	Mon, 19 Jan 2026 16:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768839935; cv=none; b=X43j3AB/II6l/duwqt0yBqXzwpf6ugyPgxs5ZCaEh539cNrHKL0cVwoW3fqO5J+zLGR0Erps+4WxyAKcSlm12kdtTchL/h9HK5zmxX/fxRsFFBKqAw0BW+mu1oCyCXU9H6wtFjzPPCssKIW/d5463YkOYsx02QL6bIQMUDW6D4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768839935; c=relaxed/simple;
	bh=1dTziV6XBTDbBJeJAbQpQgD9rV3PzbLCx9mnIVyu9rk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nY1kRxb3ee8fEMz+s7qlpPAVu8MjJDfkgPlV3+RiGJ6/IBXAtdjSVPuDNc8xhAMYVdfUpzZb8P4pj+/7I9/AJ6FdZCTzWfifYE7dFf5oIXrFqpCA7BQbtc/nnbDHsp83ExIfJGmUz6O3vIj24oAUd6M4X1W0sZ0T/AlqizJXgS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uj2702ob; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE03FC116C6;
	Mon, 19 Jan 2026 16:25:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768839935;
	bh=1dTziV6XBTDbBJeJAbQpQgD9rV3PzbLCx9mnIVyu9rk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Uj2702obbM/1g8ciReIwrYsD83BmXiGbZZcfSGCNaMhKbt6rmQzkdCTZN8Ju3/Wbg
	 BCfiU3u78VWDXavfhIYdqcAOmgIfehL4VEwzutI2VhBUqXE6w+1iw8YXrxQ6rEEf5i
	 q8ApH/td1UIulvh5Xk1iEwkl01NhncaL9nixOp/nn/Cqc7D0MmVxT7QZRbMope3mqR
	 uBuU2NJt3UC69wP0rum/Ppvc2PQIHxUEqzxjReipPmxDhS/nLQ2+Z8TWdQE7MXBEHZ
	 upq2vTKeEaYuG3HsYS+seTxSo3mf+mUU+9koBD5nIY74ayuPgkvohboH7Jnl3ux/xa
	 beU2LEXWPi4iw==
Date: Mon, 19 Jan 2026 08:25:34 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: wen.yang@linux.dev
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org,
 linux-kernel@vger.kernel.org, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH 6.6 3/3] net: Allow to use SMP threads for backlog NAPI.
Message-ID: <20260119082534.1f705011@kernel.org>
In-Reply-To: <997bc0de4746100bb69e1bd2ccfb25315d8f62e4.1768751557.git.wen.yang@linux.dev>
References: <cover.1768751557.git.wen.yang@linux.dev>
	<997bc0de4746100bb69e1bd2ccfb25315d8f62e4.1768751557.git.wen.yang@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 19 Jan 2026 00:15:46 +0800 wen.yang@linux.dev wrote:
> From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> 
> commit dad6b97702639fba27a2bd3e986982ad6f0db3a7 upstream.
> 
> Backlog NAPI is a per-CPU NAPI struct only (with no device behind it)
> used by drivers which don't do NAPI them self, RPS and parts of the
> stack which need to avoid recursive deadlocks while processing a packet.

This is a rather large change to backport into LTS.

