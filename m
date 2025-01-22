Return-Path: <stable+bounces-110148-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 15499A1906D
	for <lists+stable@lfdr.de>; Wed, 22 Jan 2025 12:14:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 323A316CE3F
	for <lists+stable@lfdr.de>; Wed, 22 Jan 2025 11:13:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55E48211A18;
	Wed, 22 Jan 2025 11:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q8te+jBV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 119FC211719
	for <stable@vger.kernel.org>; Wed, 22 Jan 2025 11:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737544411; cv=none; b=CzLRXGEywwAPQ/oesn0fe7oG8jgYUl3PXjskX7c5P+54n8t0MYD41Fr+kl5AfhphgpMG0EjlJqkCBvhxzVdJSxUqjVYN4w+p8b1lq+qQzQlSvunrV90b+nB/Muty0wTRzDJlPiJKSSvGVaLGZBDTajhTUF8f+prXF5UnNfftJF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737544411; c=relaxed/simple;
	bh=5xSq2J9thkYhOloVPtapma3uWO0iRDgJjeFp695AZN0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tm42wlDeoxO/vG5Ki8iIrhg3oQ7APWtzINWJodlQFvR27Hq8M518H11E8ogaR1gik4x7lV39XupuxCfm9gNNBqnMwJUuYzAz7zGK9WWFtESzn4+oq1+nrR9d45ZzVp/Krtt6eI7R+RQLIckSxFEn6k3sBS1XBzC3fb8mC//IV8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q8te+jBV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D446C4CED6;
	Wed, 22 Jan 2025 11:13:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737544410;
	bh=5xSq2J9thkYhOloVPtapma3uWO0iRDgJjeFp695AZN0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Q8te+jBVWcJn0Fof0ij6iqXdv1eXYgTGUcFC8LRez+eArkgadhqW/0qASiomur4I3
	 7jJN5aYQ+zpNh1+hx2UU8BiOCudJjAJAbXKFHR/cbnRn50el8TvPOsPaEU5hJOSkX6
	 K6Trj1Oe8+xc2Q5PEJEJC48zDPu5T3aXkV2CFxN9S+uvVpzXhkKZpPPaOLIxxpTqua
	 3rTqevun8WfU0KvXBMLDLmheG9wvg5VeJcAJLlw7eg0sUA9p4j+LoHYgXe3jg1DyFg
	 j+4A6lz8/7kgBYdvU1zDo8lZueRPNIPJkQQ09KxqGpFF8NWljsHjQilPw8oJwgWQaE
	 uTn6ZC3Z6FYTQ==
Message-ID: <9b376aa3-a7b1-4791-9013-ac250d9f1393@kernel.org>
Date: Wed, 22 Jan 2025 12:13:26 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: FAILED: patch "[PATCH] mptcp: be sure to send ack when
 mptcp-level window re-opens" failed to apply to 5.15-stable tree
Content-Language: en-GB
To: gregkh@linuxfoundation.org, pabeni@redhat.com, kuba@kernel.org
Cc: stable@vger.kernel.org
References: <2025012037-siesta-sulfite-8b05@gregkh>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <2025012037-siesta-sulfite-8b05@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Greg,

On 20/01/2025 14:38, gregkh@linuxfoundation.org wrote:
> 
> The patch below does not apply to the 5.15-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.

Thank you for the notification!

> ------------------ original commit in Linus's tree ------------------
> 
> From 2ca06a2f65310aeef30bb69b7405437a14766e4d Mon Sep 17 00:00:00 2001
> From: Paolo Abeni <pabeni@redhat.com>
> Date: Mon, 13 Jan 2025 16:44:56 +0100
> Subject: [PATCH] mptcp: be sure to send ack when mptcp-level window re-opens
> 
> mptcp_cleanup_rbuf() is responsible to send acks when the user-space
> reads enough data to update the receive windows significantly.
> 
> It tries hard to avoid acquiring the subflow sockets locks by checking
> conditions similar to the ones implemented at the TCP level.
> 
> To avoid too much code duplication - the MPTCP protocol can't reuse the
> TCP helpers as part of the relevant status is maintained into the msk
> socket - and multiple costly window size computation, mptcp_cleanup_rbuf
> uses a rough estimate for the most recently advertised window size:
> the MPTCP receive free space, as recorded as at last-ack time.
> 
> Unfortunately the above does not allow mptcp_cleanup_rbuf() to detect
> a zero to non-zero win change in some corner cases, skipping the
> tcp_cleanup_rbuf call and leaving the peer stuck.
> 
> After commit ea66758c1795 ("tcp: allow MPTCP to update the announced
> window"), MPTCP has actually cheap access to the announced window value.
> Use it in mptcp_cleanup_rbuf() for a more accurate ack generation.

FYI, we are currently not planning to backport this patch: it depends on
commits ea66758c1795 ("tcp: allow MPTCP to update the announced window")
-- mentioned above -- and f3589be0c420 ("mptcp: never shrink offered
window") which are not in this v5.15 version, and linked to new features.

The issue fixed by the patch here has not been seen on a v5.15 kernel so
far, and probably only visible with other changes that have been done
later on. In other words, it looks OK not to backport this patch.

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.


