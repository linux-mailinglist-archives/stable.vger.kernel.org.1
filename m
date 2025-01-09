Return-Path: <stable+bounces-108088-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E5D8A07505
	for <lists+stable@lfdr.de>; Thu,  9 Jan 2025 12:46:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27264188A9BA
	for <lists+stable@lfdr.de>; Thu,  9 Jan 2025 11:46:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A529216397;
	Thu,  9 Jan 2025 11:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Xbgg10Or"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CE682010EF;
	Thu,  9 Jan 2025 11:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736423194; cv=none; b=tBxUxpyR4w+v9z6uskforWA2Z2hMgS+oI4SiJrwn47LqsbWQsF5b1Daqb5Z92U2GjhQH6pO4WbwZAWkWMDoePU+iEUl0YSk4gIt5ao/FUXrs7rxMgvUrr/LR9uFwaI2Yo1M5Rh3xMf+cOs7GTjt61FdvUwQFHOO9rTYCJW+RUXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736423194; c=relaxed/simple;
	bh=H9eA+ejVhVauhCwjmVMYIRD2dwBKM9fp8Rs1XAnOzmQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kU/HHHY8v1gY/CLtdRoVA2tYxFtm7pkfR1bqXZvJ4C06L1jCAfDcm2fZcO8/yPArCewqPbd3X0w07ZkZBdbKkXDbPDmWZPzyoCg14wfesap1geDx80Utvl3iF3CZiv7hs9+w5eEuWXtvu819O6+rGx0TBoTieAUsG/1y1s1/y2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Xbgg10Or; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BDBAC4CED2;
	Thu,  9 Jan 2025 11:46:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1736423193;
	bh=H9eA+ejVhVauhCwjmVMYIRD2dwBKM9fp8Rs1XAnOzmQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Xbgg10OrH4pVeN3JEgauUXLIuDmGpt3VoNvaa3Xg73D1VgpP1YVh2p/5K4ESnvcOH
	 ujqBu3R8ERofX+KcVySR0DiifqxKx10G31XukoR32+N6dVYkHuAOlLjCS/4ndvVt+t
	 7Ez6iOjMRPJGkvoGUCAKcITQ5vuFtepGRVvVNWOk=
Date: Thu, 9 Jan 2025 12:46:30 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Ilya Dryomov <idryomov@gmail.com>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	Xiubo Li <xiubli@redhat.com>,
	Patrick Donnelly <pdonnell@redhat.com>,
	Milind Changire <mchangir@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.6] ceph: give up on paths longer than PATH_MAX
Message-ID: <2025010912-deputize-frolic-7381@gregkh>
References: <20250107155010.2658845-1-idryomov@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250107155010.2658845-1-idryomov@gmail.com>

On Tue, Jan 07, 2025 at 04:50:08PM +0100, Ilya Dryomov wrote:
> From: Max Kellermann <max.kellermann@ionos.com>
> 
> commit 550f7ca98ee028a606aa75705a7e77b1bd11720f upstream.
> 
> If the full path to be built by ceph_mdsc_build_path() happens to be
> longer than PATH_MAX, then this function will enter an endless (retry)
> loop, effectively blocking the whole task.  Most of the machine
> becomes unusable, making this a very simple and effective DoS
> vulnerability.
> 
> I cannot imagine why this retry was ever implemented, but it seems
> rather useless and harmful to me.  Let's remove it and fail with
> ENAMETOOLONG instead.
> 
> Cc: stable@vger.kernel.org
> Reported-by: Dario Weiﬂer <dario@cure53.de>
> Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
> Reviewed-by: Alex Markuze <amarkuze@redhat.com>
> Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
> [idryomov@gmail.com: backport to 6.6: pr_warn() is still in use]
> ---
>  fs/ceph/mds_client.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)

Thank you, I've dropped the "large" ceph patches from 6.6.y now and
added this one instead.

greg k-h

