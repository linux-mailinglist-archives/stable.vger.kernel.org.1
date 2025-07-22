Return-Path: <stable+bounces-163677-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D2B21B0D5F9
	for <lists+stable@lfdr.de>; Tue, 22 Jul 2025 11:28:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD36F1AA1007
	for <lists+stable@lfdr.de>; Tue, 22 Jul 2025 09:28:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B088A2DCBE2;
	Tue, 22 Jul 2025 09:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Pc7nD6aF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F4DF2BEFE3
	for <stable@vger.kernel.org>; Tue, 22 Jul 2025 09:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753176500; cv=none; b=cIPpd1cUVqx20nAYeI3liyExlawmuNwG0mEigdtnGa8O2vqQP4bHPmcwRbqbIQ2Vl9eHMQEmUw0WZ1sSfJnfT9GTVRP5U5Dq9GefW8u2fxHo4cyvZ5BRFOmbR+naIepNmvXZGeiZBbPXVmyDKzrfVUjF+kcN0ElcbUKcDPrSOGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753176500; c=relaxed/simple;
	bh=ewz3eLT0B+/MvaBAx/S+knoMxZcNCtPDduNlQ8nqtZg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EHg2W0ucTUd70SxF4zkzK2eTCYKT6k0ufpyMY0CXVPeR6Ix0MDqSQAgu0uGlgl2uIDuEQP/pAKpYBlI+FZf2rRDT3Nd/EWp6LsfsEZ2rLrTw5S6fg2K1IgR4OdXlONkM0xekOtuV40KFvVYa7ll7PHK9P4lbIbFxmY5EH9oCC8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Pc7nD6aF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63D28C4CEEB;
	Tue, 22 Jul 2025 09:28:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1753176499;
	bh=ewz3eLT0B+/MvaBAx/S+knoMxZcNCtPDduNlQ8nqtZg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Pc7nD6aFeZd1vGTAVAGJtktdoMy9+WnutonDbgmvPq1kgRzIbov+qc/Un/0TT/VEf
	 fOeEC6vOi0NqtSe+fi5OecIIrC8kdI5hvggXTPe+59aD1+3jP2ZponzeX52RrFv4fM
	 GqWoqyECpn8U3TEDQDjGn1XOSdEoNLk9+Qa00WfY=
Date: Tue, 22 Jul 2025 11:28:16 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Shung-Hsi Yu <shung-hsi.yu@suse.com>
Cc: stable@vger.kernel.org, Yonghong Song <yonghong.song@linux.dev>,
	Andrii Nakryiko <andrii@kernel.org>
Subject: Re: [PATCH stable 6.12 1/1] selftests/bpf: Add tests with stack ptr
 register in conditional jmp
Message-ID: <2025072251-sympathy-fender-c2b8@gregkh>
References: <20250721084531.58557-1-shung-hsi.yu@suse.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250721084531.58557-1-shung-hsi.yu@suse.com>

On Mon, Jul 21, 2025 at 04:45:29PM +0800, Shung-Hsi Yu wrote:
> From: Yonghong Song <yonghong.song@linux.dev>
> 
> Commit 5ffb537e416ee22dbfb3d552102e50da33fec7f6 upstream.
> 
> Add two tests:
>   - one test has 'rX <op> r10' where rX is not r10, and
>   - another test has 'rX <op> rY' where rX and rY are not r10
>     but there is an early insn 'rX = r10'.
> 
> Without previous verifier change, both tests will fail.
> 
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> Link: https://lore.kernel.org/bpf/20250524041340.4046304-1-yonghong.song@linux.dev
> [ shung-hsi.yu: contains additional hunks for kernel/bpf/verifier.c that
>   should be part of the previous patch in the series, commit
>   e2d2115e56c4 "bpf: Do not include stack ptr register in precision
>   backtracking bookkeeping", which was incorporated since v6.12.37. ]
> Link: https://lore.kernel.org/all/9b41f9f5-396f-47e0-9a12-46c52087df6c@linux.dev/
> Signed-off-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
> ---
>  kernel/bpf/verifier.c                         |  7 ++-
>  .../selftests/bpf/progs/verifier_precision.c  | 53 +++++++++++++++++++
>  2 files changed, 58 insertions(+), 2 deletions(-)

We can not take a patch only for older stable kernels and not newer
ones.

Please resubmit this as a backport for all affected kernel trees.

thanks,

greg k-h

