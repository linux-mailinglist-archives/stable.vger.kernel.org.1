Return-Path: <stable+bounces-136659-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 36289A9BF9B
	for <lists+stable@lfdr.de>; Fri, 25 Apr 2025 09:19:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8BC84188FAFB
	for <lists+stable@lfdr.de>; Fri, 25 Apr 2025 07:17:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A7511FCCEB;
	Fri, 25 Apr 2025 07:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cvxaPjjd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B028122ACF3
	for <stable@vger.kernel.org>; Fri, 25 Apr 2025 07:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745565436; cv=none; b=JOf0pXwAtKuCFBfl8GXzqTY7bNjoVgQH2xoJnvkEjLvoLdmSlIMBNNJEZonN4z6QBkOsjGnTd8Gu7AAki7Ss/V5CD1CaR2nYgJe2QsAXnYWO8L0ZHkH3fevrLHdPytUE0xy/ECgP4tDFAt+hS44RTY6+BuokvPit9BKUzXdcmzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745565436; c=relaxed/simple;
	bh=ypREIy+0YuUA4AkexHw2yLYzX2D5W9yBuldaVskR+DI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uJHteSQTYUyidvwjjksi2KtSxrwXOHif0clL6JYCmaZ6hT3YAoY1S/aRpCdxmdC7Znlgu6o+2il1RJTwX6fTdClbJd1rk3TJWC+E3UBJQJSgeWvumS+b80/qf8xQQ1JTh5pWc88g4hwZxCy0NAw2rwNA8sLMl+souk3LcjruMsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cvxaPjjd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92BC0C4CEEA;
	Fri, 25 Apr 2025 07:17:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745565435;
	bh=ypREIy+0YuUA4AkexHw2yLYzX2D5W9yBuldaVskR+DI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cvxaPjjduJ8ztQrE8ab0LHzTDqo+eizfB6Ew54GXlIT+Bhs0mqYTgZag1TW3szG32
	 igp6xOnFlpzLZKfg2rzfwsFFDh5fPwXLvUBZlJZ11T2UL3u8/0ehSO2zi3gYoDi1ep
	 vQrTVwPUdQvQsQLFzO0Xx4jsiUJCEA6s11vk4UMo=
Date: Fri, 25 Apr 2025 09:17:13 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Shung-Hsi Yu <shung-hsi.yu@suse.com>
Cc: stable@vger.kernel.org, Ihor Solodrai <ihor.solodrai@linux.dev>,
	Andrii Nakryiko <andrii@kernel.org>,
	Jiayuan Chen <jiayuan.chen@linux.dev>
Subject: Re: [PATCH stable 6.12 6.14 1/1] selftests/bpf: Mitigate
 sockmap_ktls disconnect_after_delete failure
Message-ID: <2025042523-uncheck-hazy-17a9@gregkh>
References: <20250425055702.48973-1-shung-hsi.yu@suse.com>
 <aok6og6gyokth2rap7qdhtmc4saljzg43qbrvtbeopjuuq6275@hptib2h2wpac>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aok6og6gyokth2rap7qdhtmc4saljzg43qbrvtbeopjuuq6275@hptib2h2wpac>

On Fri, Apr 25, 2025 at 02:35:59PM +0800, Shung-Hsi Yu wrote:
> On Fri, Apr 25, 2025 at 01:57:01PM +0800, Shung-Hsi Yu wrote:
> > From: Ihor Solodrai <ihor.solodrai@linux.dev>
> > 
> > commit 5071a1e606b30c0c11278d3c6620cd6a24724cf6 upstream.
> > 
> > "sockmap_ktls disconnect_after_delete" test has been failing on BPF CI
> > after recent merges from netdev:
> > * https://github.com/kernel-patches/bpf/actions/runs/14458537639
> > * https://github.com/kernel-patches/bpf/actions/runs/14457178732
> > 
> > It happens because disconnect has been disabled for TLS [1], and it
> > renders the test case invalid.
> > 
> > Removing all the test code creates a conflict between bpf and
> > bpf-next, so for now only remove the offending assert [2].
> > 
> > The test will be removed later on bpf-next.
> > 
> > [1] https://lore.kernel.org/netdev/20250404180334.3224206-1-kuba@kernel.org/
> > [2] https://lore.kernel.org/bpf/cfc371285323e1a3f3b006bfcf74e6cf7ad65258@linux.dev/
> > 
> > Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > Reviewed-by: Jiayuan Chen <jiayuan.chen@linux.dev>
> > Link: https://lore.kernel.org/bpf/20250416170246.2438524-1-ihor.solodrai@linux.dev
> > [ shung-hsi.yu: needed because upstream commit 5071a1e606b3 ("net: tls:
> > explicitly disallow disconnect") is backported ]
> > Signed-off-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
> 
> I missed that 5071a1e606b3 was added to 6.1 and 6.6, too. Please apply
> this one for 6.14, 6.12, 6.6, and 6.1.

It's already queued up for the next 6.6.y, 6.1.y, 5.15.y and 5.10.y
releases, and is already in the 6.14.3 and 6.12.24 releases.

Did I miss anywhere else that it needs to go?

thanks,

greg k-h

