Return-Path: <stable+bounces-169967-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3EA4B29EC5
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 12:04:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1F0A3ACC60
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 10:03:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F226B310622;
	Mon, 18 Aug 2025 10:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zaLwxCtw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B06A83101A7
	for <stable@vger.kernel.org>; Mon, 18 Aug 2025 10:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755511414; cv=none; b=ay/woUsawrwRS5SuNVA31y7P/1uD/IkjlbdujCbwMVOv49Qj52b7gN1/R+sz+ReA5BoLDzTwZc960ukiaaX5nztaRv0VjK2NeQqO+8KJF+wo8SlvjwAIs2m7tLjPCes2r44Q08Uf6zCVNsDIWbQW8DcInXmUbvxewwGiLW2QL6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755511414; c=relaxed/simple;
	bh=CSnKYuUY9TrC+TO0gE7aReqBDA6wfSS6qGWSoAgEyW4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q6Q58ikyiFE7Ht+LRz+vo3vXql3WmxBQsgRB8MLl4NuPLDmD+w/fi6ErrylZli7dT7d1gEp697JjFivEba14dflHVen9pd13rbfoMGhOyB/kQc9ktt4AYeEa6dCdsZ1df44yuNjz70WVMoGjOEUy7hgJTmtnD95WeGlLWfahrb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zaLwxCtw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F326CC4CEED;
	Mon, 18 Aug 2025 10:03:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755511414;
	bh=CSnKYuUY9TrC+TO0gE7aReqBDA6wfSS6qGWSoAgEyW4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=zaLwxCtwdS5IuoA2unl5FRXJCXjuw9DL4B6Vmuq6U/2Gyp85q1g0xvA5po18rERrd
	 MkZwk+tT9QJ2EaMcd10isMrTlaebgUPp7bIe9vVEUFN28OKFYItA/HhHuk4vfpnlfI
	 TamXQNa1oM67oklwxNMGlfgh8xSntfYLbAAXUKPg=
Date: Mon, 18 Aug 2025 12:03:31 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jiucheng Xu <Jiucheng.Xu@amlogic.com>
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>,
	Tuan Zhang <Tuan.Zhang@amlogic.com>,
	Jianxin Pan <Jianxin.Pan@amlogic.com>
Subject: Re: f2fs: fix to avoid UAF in f2fs_sync_inode_meta()
Message-ID: <2025081817-python-habitant-17e3@gregkh>
References: <ae6791c0-8bd0-4388-bb65-53c421b35380@amlogic.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ae6791c0-8bd0-4388-bb65-53c421b35380@amlogic.com>

On Mon, Aug 18, 2025 at 09:46:32AM +0000, Jiucheng Xu wrote:
> Dear 5.15.y maintainers,
> 
> A f2fs patch should be backported from upstream mainline to the stable 
> 5.15.y branch. The patch's information is shown as below:
> 
> [Subject]
> f2fs: fix to avoid UAF in f2fs_sync_inode_meta()
> 
> [Upstream commit ID]
> 7c30d79930132466f5be7d0b57add14d1a016bda
> 
> [Kernel version]
> 5.15.y
> 
> [Why]
> This patch fixes the issue where the f2fs_inode_info.gdirty_list is not 
> deleted when evicting the inode. This would cause the gdirty_list to 
> remain incorrectly linked when the f2fs_inode_info is reallocated, which 
> in turn would be detected by __list_del_entry_valid during list_del_init.
> 
> On the Android 5.15 U arm platform, the issue that could be reproduced 
> within 24 hours has not recurred for a week after applying this patch.

It's already queued up for the next 5.15.y release, thanks!

greg k-h

