Return-Path: <stable+bounces-66521-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AA64994ED2B
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 14:39:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C690B1C21DB7
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 12:39:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E69017B4F6;
	Mon, 12 Aug 2024 12:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rmhYH/cc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E13B53B7A8;
	Mon, 12 Aug 2024 12:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723466351; cv=none; b=lziZ7olbporXAn0uamDmfULstxEglkCvqqUakfRFRZettXlY3ZCT1tSQUNN6aI/FtqqsiAnSZg82i5TK39DiBHbRWkDpK/p/WDYjZlSsJ9BYtJJ/jCNHj101CRcvk/lwckhAmZeBxXKCsPOa7tnUyjL03DJUGtDDrDLZoEXVSZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723466351; c=relaxed/simple;
	bh=nWwTFgY69nv8QbIrKoxmXX/Y8Nv2AKIiJH0k7FnV4Lc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EylX0RwlRpP34gsYVaPAAbS2s7kERr8eK8TaUuqPxB9lG1xWAhG9mvwAquWfxZAvvNghfYNkC6MTBcRijnFEehugG93+LJ8QJeH+pSPd5IDjPeI544EeZcdi+zMh4v2Pw1TQ9Vni1qW4DdA3piBoGR2+ttxmZ2W9TjOKuwyZGZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rmhYH/cc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42F97C32782;
	Mon, 12 Aug 2024 12:39:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723466350;
	bh=nWwTFgY69nv8QbIrKoxmXX/Y8Nv2AKIiJH0k7FnV4Lc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rmhYH/ccmJ2fJt2SD8PTjkplP1xcjyyOUtNr093JHyvOOO5CHJQzM3VIUEqncsq+c
	 BVS2iRyuPtGpBIOLNBGqgrRNHHDgrxykI0OwnaNJyiJLS2C1q3d/o8YmmbL5ZqQInV
	 WRz07oI5qOdXdpbSr68tdsqg4BMGTXCXA+3WZz1Y=
Date: Mon, 12 Aug 2024 14:38:45 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Cc: stable@vger.kernel.org, MPTCP Upstream <mptcp@lists.linux.dev>,
	Geliang Tang <geliang.tang@suse.com>,
	Matthieu Baerts <matthieu.baerts@tessares.net>,
	Larysa Zaremba <larysa.zaremba@intel.com>,
	Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH 5.10.y 1/2] mptcp: export local_address
Message-ID: <2024081237-navigate-barterer-246e@gregkh>
References: <2024080729-unclaimed-shopping-6751@gregkh>
 <20240809105538.2903162-3-matttbe@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240809105538.2903162-3-matttbe@kernel.org>

On Fri, Aug 09, 2024 at 12:55:39PM +0200, Matthieu Baerts (NGI0) wrote:
> From: Geliang Tang <geliang.tang@suse.com>
> 
> commit dc886bce753cc2cf3c88ec5c7a6880a4e17d65ba upstream.
> 
> Rename local_address() with "mptcp_" prefix and export it in protocol.h.
> 
> This function will be re-used in the common PM code (pm.c) in the
> following commit.
> 
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> Reviewed-by: Matthieu Baerts <matthieu.baerts@tessares.net>
> Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
> Reviewed-by: Larysa Zaremba <larysa.zaremba@intel.com>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> Stable-dep-of: 6834097fc38c ("mptcp: pm: fix backup support in signal endpoints")
> [ Conflicts in pm_netlink.c and protocol.h, because the context has
>   changed in commit 4638de5aefe5 ("mptcp: handle local addrs announced
>   by userspace PMs") which is not in this version. This commit is
>   unrelated to this modification. Also some parts using 'local_address'
>   are not in this version, that's OK, we don't need to do anything with
>   them. ]
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>

All backports now queued up, thanks!

greg k-h

