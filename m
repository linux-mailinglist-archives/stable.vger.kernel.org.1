Return-Path: <stable+bounces-87040-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E02DA9A6078
	for <lists+stable@lfdr.de>; Mon, 21 Oct 2024 11:45:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 49C16B231EB
	for <lists+stable@lfdr.de>; Mon, 21 Oct 2024 09:44:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE14B1E32C2;
	Mon, 21 Oct 2024 09:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rIhTDzss"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83FF9946C
	for <stable@vger.kernel.org>; Mon, 21 Oct 2024 09:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729503874; cv=none; b=RM0G/QIBBlvcLknGHWUY/XB43HJ+Ts8ZgXR4GHg00tE8wXh3uST3mhx2tVh82+5piiTOQYzdtzP1uOtK4cmLEAcq3m72f53VOOborDiTgUSvm0GqCqNCOsH9j0z/AKvrp74c0cKMHmifX76Bglipg2gcxkF+DG+TdC1Hjzv8g0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729503874; c=relaxed/simple;
	bh=hLPRxZ5NzX9akOiJnNOQJC1SLbbW+Lm0Al4XajExV9k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QPq4rMgCPFdL+wU/9YkS7ugiZcsOeDkCCxcuYaL6uSSocFhyemW5gSSfHVUNH222Jvg6cmRgo3Bl5qoeKHWEmgnESO2exRRZI/XVx0tZzsGDrdS2pUCAZqNMTabJ6H9HDSUvFaE15LQb+44HMnn/YiL6h1VrNI5PMtphzFJC1kE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rIhTDzss; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCF21C4CEC3;
	Mon, 21 Oct 2024 09:44:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1729503874;
	bh=hLPRxZ5NzX9akOiJnNOQJC1SLbbW+Lm0Al4XajExV9k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rIhTDzssHnHHrRtc8FDQ13ne7R8oqdiZTojcOPDF8fnh9chd86njiw/PSPNEBCDva
	 NGVbg/T6AoZjn1t/ZPkpgXdf03Dj1V6aDm0umFck3de9GT90e3QKyjUaCQ0aIrO/Ew
	 2EgwMt5OK7p4Jfdz2aUL7AkSxY8HcDT/LC9ayxWo=
Date: Mon, 21 Oct 2024 11:44:31 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Cc: stable@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
	Lizhi Xu <lizhi.xu@windriver.com>
Subject: Re: [PATCH 4.19 5.4 5.10] nilfs2: propagate directory read errors
 from nilfs_find_entry()
Message-ID: <2024102122-epic-possum-ecac@gregkh>
References: <2024101853-recall-payee-2d9d@gregkh>
 <20241019152136.5829-1-konishi.ryusuke@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241019152136.5829-1-konishi.ryusuke@gmail.com>

On Sun, Oct 20, 2024 at 12:21:15AM +0900, Ryusuke Konishi wrote:
> commit 08cfa12adf888db98879dbd735bc741360a34168 upstream.
> 
> Syzbot reported that a task hang occurs in vcs_open() during a fuzzing
> test for nilfs2.
> 
> The root cause of this problem is that in nilfs_find_entry(), which
> searches for directory entries, ignores errors when loading a directory
> page/folio via nilfs_get_folio() fails.
> 
> If the filesystem images is corrupted, and the i_size of the directory
> inode is large, and the directory page/folio is successfully read but
> fails the sanity check, for example when it is zero-filled,
> nilfs_check_folio() may continue to spit out error messages in bursts.
> 
> Fix this issue by propagating the error to the callers when loading a
> page/folio fails in nilfs_find_entry().
> 
> The current interface of nilfs_find_entry() and its callers is outdated
> and cannot propagate error codes such as -EIO and -ENOMEM returned via
> nilfs_find_entry(), so fix it together.
> 
> Link: https://lkml.kernel.org/r/20241004033640.6841-1-konishi.ryusuke@gmail.com
> Fixes: 2ba466d74ed7 ("nilfs2: directory entry operations")
> Signed-off-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
> Reported-by: Lizhi Xu <lizhi.xu@windriver.com>
> Closes: https://lkml.kernel.org/r/20240927013806.3577931-1-lizhi.xu@windriver.com
> Reported-by: syzbot+8a192e8d090fa9a31135@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=8a192e8d090fa9a31135
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
> Please apply this patch to the stable trees indicated by the subject
> prefix instead of the failed patches.
> 
> This patch is tailored to take page/folio conversion into account and
> avoid a few conflicts.  Compiled and tested successfully.

All now queued up, thanks for the backports.

greg k-h

