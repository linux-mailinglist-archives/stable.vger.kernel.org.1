Return-Path: <stable+bounces-21794-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 52B8385D2D0
	for <lists+stable@lfdr.de>; Wed, 21 Feb 2024 09:48:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4AA6286074
	for <lists+stable@lfdr.de>; Wed, 21 Feb 2024 08:48:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 121403C6B3;
	Wed, 21 Feb 2024 08:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BFs20Mp1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5FAC3C6A6
	for <stable@vger.kernel.org>; Wed, 21 Feb 2024 08:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708505305; cv=none; b=Rc9R+GdkdaU6mtxUpTvuM8LMu52j7+vXshtWRA7rLWOY0SZ1S0oCSNnJw2l3B0G814sc9HBGjputHBqawSu5GnWf+lNLxV1y8gIZfBzpDpqtSunrqjuVux2Y0csD3aV+hkCbEEqMc93YSEYDSiDNSH5fKKqATa5lUx+6ni2tTcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708505305; c=relaxed/simple;
	bh=QrTs/JxEOmRmxtqtv0VNpBDDWkc0q5E+FoxgVemuco4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p12OkFG46SJ/HsoR9ZCUlx5aXkfIBl02XifVBDozWxGlJf2nJufy8tZ0x5oznT93lkJ9yA22Gg2wZtaqYlz9rgprRfnOLgGi3+Q65LYqjMKrVcAi4rk5yJWWRlwyDWBcgHqXo++tJ1GVUjFJYqenxYXZU8RPZa0YvlLQQaboJXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BFs20Mp1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D03E2C433C7;
	Wed, 21 Feb 2024 08:48:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708505305;
	bh=QrTs/JxEOmRmxtqtv0VNpBDDWkc0q5E+FoxgVemuco4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BFs20Mp1VjrVpQZMt7xTgOBa3XdP1WZB54gAk9h48RtgbtkAY810tr7Ja0vwWPySu
	 ul6v50qs6IHrOGGuh+KyvMQDuskfHb+FJpNPglBWRZ68bV4jzWsl5DYM1PG7o4OnvH
	 XxJe5H/QCkBSQ6XXkE2QLSVcgRyxkiZRTUIeSdok=
Date: Wed, 21 Feb 2024 09:48:21 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Cc: stable@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 4.19 5.4 5.10 5.15 6.1 6.6 6.7] nilfs2: fix potential bug
 in end_buffer_async_write
Message-ID: <2024022113-gong-underdone-ac9c@gregkh>
References: <20240220212928.5611-1-konishi.ryusuke@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240220212928.5611-1-konishi.ryusuke@gmail.com>

On Wed, Feb 21, 2024 at 06:29:28AM +0900, Ryusuke Konishi wrote:
> commit 5bc09b397cbf1221f8a8aacb1152650c9195b02b upstream.
> 
> According to a syzbot report, end_buffer_async_write(), which handles the
> completion of block device writes, may detect abnormal condition of the
> buffer async_write flag and cause a BUG_ON failure when using nilfs2.
> 
> Nilfs2 itself does not use end_buffer_async_write().  But, the async_write
> flag is now used as a marker by commit 7f42ec394156 ("nilfs2: fix issue
> with race condition of competition between segments for dirty blocks") as
> a means of resolving double list insertion of dirty blocks in
> nilfs_lookup_dirty_data_buffers() and nilfs_lookup_node_buffers() and the
> resulting crash.
> 
> This modification is safe as long as it is used for file data and b-tree
> node blocks where the page caches are independent.  However, it was
> irrelevant and redundant to also introduce async_write for segment summary
> and super root blocks that share buffers with the backing device.  This
> led to the possibility that the BUG_ON check in end_buffer_async_write
> would fail as described above, if independent writebacks of the backing
> device occurred in parallel.
> 
> The use of async_write for segment summary buffers has already been
> removed in a previous change.
> 
> Fix this issue by removing the manipulation of the async_write flag for
> the remaining super root block buffer.
> 
> Link: https://lkml.kernel.org/r/20240203161645.4992-1-konishi.ryusuke@gmail.com
> Fixes: 7f42ec394156 ("nilfs2: fix issue with race condition of competition between segments for dirty blocks")
> Signed-off-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
> Reported-by: syzbot+5c04210f7c7f897c1e7f@syzkaller.appspotmail.com
> Closes: https://lkml.kernel.org/r/00000000000019a97c05fd42f8c8@google.com
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

Now queued up, thanks.

greg k-h

