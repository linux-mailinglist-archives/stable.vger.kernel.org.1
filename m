Return-Path: <stable+bounces-62816-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 18B4C9413A2
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 15:51:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2FF81F23C03
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 13:51:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22BE41A08A8;
	Tue, 30 Jul 2024 13:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VkjBHXMI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8DEA1A08A0
	for <stable@vger.kernel.org>; Tue, 30 Jul 2024 13:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722347476; cv=none; b=LVlgLXNGKBZ0Kg0NYy796YAo72MYurX+u4GICVJsYUbTsqTVXGffGwk9G/fz4Gs6OkllB1i/+n2sOFL1vwaLXEGEJbOyXGLApQ94iWdZkfRZQbSaJnlGKJ0+JAPqs9bttpupOEroyVo+0685EA6ENdoyX42jmeUWybQVQm8B2HM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722347476; c=relaxed/simple;
	bh=igkxm/p7beQFebihg34a4gnfp2BeEKp9z+EQ4eBPAOU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X9uHfqkMHiRm1vEbMhoXyuPgal8un+Oj9vQV36PH5OYZLV01dfEvG9RsO6qn+jCqTRFaBk80p+RKgsTxIG4dj7a+HZbmgnSTx49JJiYnUgqNSN890WqQQU0Y6Bvnm3moWyQUkypswTKtKQTviJcwQ+rZBdQPJ9UjvPJqaxlVG0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VkjBHXMI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C44CC32782;
	Tue, 30 Jul 2024 13:51:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722347476;
	bh=igkxm/p7beQFebihg34a4gnfp2BeEKp9z+EQ4eBPAOU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VkjBHXMI2DsqGDXyioWspm6EcGLp84s4E/hIIJAUmpG82lOrR1T1Hmz7xH1tLjwnw
	 EZOeNM/a2CQyWWmw3g41BPR13AHsHtC1Tb8rg8wuNmi1piLFyxmL295HEy0za7cmny
	 FANBd+37UqCrgK4C278GMhaaTD1LFuC3Dp/PayeU=
Date: Tue, 30 Jul 2024 15:51:13 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Cc: stable@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 4.19 5.4 5.10 5.15 6.1 6.6] nilfs2: handle inconsistent
 state in nilfs_btnode_create_block()
Message-ID: <2024073006-strum-gravitate-3505@gregkh>
References: <20240729191704.10301-1-konishi.ryusuke@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240729191704.10301-1-konishi.ryusuke@gmail.com>

On Tue, Jul 30, 2024 at 04:17:04AM +0900, Ryusuke Konishi wrote:
> commit 4811f7af6090e8f5a398fbdd766f903ef6c0d787 upstream.
> 
> Syzbot reported that a buffer state inconsistency was detected in
> nilfs_btnode_create_block(), triggering a kernel bug.
> 
> It is not appropriate to treat this inconsistency as a bug; it can occur
> if the argument block address (the buffer index of the newly created
> block) is a virtual block number and has been reallocated due to
> corruption of the bitmap used to manage its allocation state.
> 
> So, modify nilfs_btnode_create_block() and its callers to treat it as a
> possible filesystem error, rather than triggering a kernel bug.
> 
> Link: https://lkml.kernel.org/r/20240725052007.4562-1-konishi.ryusuke@gmail.com
> Fixes: a60be987d45d ("nilfs2: B-tree node cache")
> Signed-off-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
> Reported-by: syzbot+89cc4f2324ed37988b60@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=89cc4f2324ed37988b60
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
> Please apply this patch to the stable trees indicated by the subject
> prefix instead of the failed patches or the one I asked you to drop.
> 
> This patch is tailored to take page/folio conversion into account and
> can be applied from v4.11 to v6.7.
> 
> Also, all the builds and tests I did on each stable tree passed.

Now queued up, thanks.

greg k-h

