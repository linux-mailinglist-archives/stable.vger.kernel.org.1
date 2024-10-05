Return-Path: <stable+bounces-81149-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 954E199139D
	for <lists+stable@lfdr.de>; Sat,  5 Oct 2024 02:46:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F38CDB213E6
	for <lists+stable@lfdr.de>; Sat,  5 Oct 2024 00:46:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BCBA1DFCF;
	Sat,  5 Oct 2024 00:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ph2uKXFF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F18151C6B2
	for <stable@vger.kernel.org>; Sat,  5 Oct 2024 00:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728089151; cv=none; b=mkQHaFMAMRlY2tqczMmDwK4aLHTYWERIXDBOe+HGJxyLWfwbx0ZO7deEN/wIV09NTzQvbBc5m1GL+i2E+aI70l5ZB7R+Gdb66ziNwKHVV8kYoAFxZqOKY+MQ1UTztRjRTxvA25/PXKoQPIrmxoY8Jh5rzmRwganj29nC/aeiGhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728089151; c=relaxed/simple;
	bh=yIzjyGOom3Lzfr7rWjD6euAuHQLmqEPb6H1clz4KqAM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dXCZv9bIcybZMF8PkcIVI45sXRx6cPqE52MyUGUXferXLFbECk4Zc/5g37axRCLo/414xeUFkEfkzzusqNIEhkUGoveog6c3VDeisS8PwyGxPEQKifOoeVwXkr5OBvFSIwGEzXLgxIZjFCJB2DMBRXg89u2gEHBMXflSuFkXMGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ph2uKXFF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D38AC4CECF;
	Sat,  5 Oct 2024 00:45:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728089150;
	bh=yIzjyGOom3Lzfr7rWjD6euAuHQLmqEPb6H1clz4KqAM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ph2uKXFF/CPXrL4BWlyCHROZfYp4g02m4ZxKWQHcf6wUMPHcWCqC1R05HE0SdeRMh
	 u7XTLI0eCBAL07z5N65Kz1DUlNrr94rgOMoPPRIikTLSTxJch9Qm73TfoDiUaGGpfg
	 0kwx/SbxsLfjtzqaM8bxKs+llJ5GtN1ZaDn1IKAIemsrHZwYN3PzmotmzvvnU8KATe
	 WFriKRHpt12gcyDsJhgz9TNbGjByNEgMwGtzL1TNwY/JBwJNgzu6uygBf/KSWVW0dT
	 wR7oIl0qRS08BB/nAUBFTxAt72+GqUT1Izm/07dktoRkbaRn/asxPalSEOsDqclxeY
	 4Y9eFCj10edKA==
Date: Fri, 4 Oct 2024 20:45:49 -0400
From: Sasha Levin <sashal@kernel.org>
To: Vegard Nossum <vegard.nossum@oracle.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org,
	pavel@denx.de, cengiz.can@canonical.com, mheyne@amazon.de,
	mngyadam@amazon.com, kuntal.nayak@broadcom.com,
	ajay.kaher@broadcom.com, zsm@chromium.org, dan.carpenter@linaro.org,
	shivani.agarwal@broadcom.com,
	Zhihao Cheng <chengzhihao1@huawei.com>,
	Eric Biggers <ebiggers@kernel.org>,
	Eric Biggers <ebiggers@google.com>,
	Richard Weinberger <richard@nod.at>
Subject: Re: [PATCH RFC 6.6.y 01/15] ubifs: ubifs_symlink: Fix memleak of
 inode->i_link in error path
Message-ID: <ZwCMPZd_P8kNxaIn@sashalap>
References: <20241002150606.11385-1-vegard.nossum@oracle.com>
 <20241002150606.11385-2-vegard.nossum@oracle.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20241002150606.11385-2-vegard.nossum@oracle.com>

On Wed, Oct 02, 2024 at 05:05:52PM +0200, Vegard Nossum wrote:
>From: Zhihao Cheng <chengzhihao1@huawei.com>
>
>[ Upstream commit 6379b44cdcd67f5f5d986b73953e99700591edfa ]

This landed as a duplicate in the upstream tree:

1e022216dcd2 ("ubifs: ubifs_symlink: Fix memleak of inode->i_link in error path")
6379b44cdcd6 ("ubifs: ubifs_symlink: Fix memleak of inode->i_link in error path")

We've backported 1e022216dcd2, and so the issue should be addressed.

-- 
Thanks,
Sasha

