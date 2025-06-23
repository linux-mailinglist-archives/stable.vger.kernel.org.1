Return-Path: <stable+bounces-155297-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96452AE35BF
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 08:33:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FC04163AA5
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 06:33:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 094D817A2E6;
	Mon, 23 Jun 2025 06:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="M8z+urUp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDF84BA33
	for <stable@vger.kernel.org>; Mon, 23 Jun 2025 06:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750660431; cv=none; b=J3wDJ5TBNEuTnB/LRY1XR1PL6snp9ptepFO8mhGtMIvnV4bFLRTUQZqzk+hiXyRz2/mXtu+G1m+FKJU6ta1QFFDPEptmcjhLmE6Y4MoBoHN303HN78uB0ZDKv+AillDZSfQlw3p4MK0YpxjlOXEx89zzdWK6UAXJUf56XZ/slG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750660431; c=relaxed/simple;
	bh=AA1+rRINZV2C2Aa/kBgp1Q8OQxImCWunhmdihTfvEY0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PN+hrx3f6Lr3zc9u6b/QfTt621uwb7WW+HJ05ckbbEtCac3SvD2J4UGsGKhX1ICvlMslciIHe9PTxuMq+227P/tsTMgoJzMijwUgac2XSEbdhIc3FtL5wLlzaWV4XOiCtQNavjDMtkEnH/lOahEcBq5l32x+AIzCEq8+mBLXc5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=M8z+urUp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C51AFC4CEED;
	Mon, 23 Jun 2025 06:33:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750660431;
	bh=AA1+rRINZV2C2Aa/kBgp1Q8OQxImCWunhmdihTfvEY0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=M8z+urUpEJeUHNsTkBDGBd3/zbrQPW6Us3ehIXrOfMkNP3zmM1dbcnae8ZEmhtcos
	 gBJ/QVkZxClEs75leqWoLGwx8M7u37fmX4xj4zTkkasdosFXqAR9ON+qJErPPUVQ4G
	 Pr5G8hoCcpLameBqMETKzUSN1crzSI2KYimJvIdY=
Date: Mon, 23 Jun 2025 08:33:48 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Chuck Lever <cel@kernel.org>
Cc: stable@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [PATCH 6.6.y 0/2] Apply commit 358de8b4f201 to 6.6.y
Message-ID: <2025062314-modular-robust-7b94@gregkh>
References: <2024021932-lavish-expel-58e5@gregkh>
 <20250617193853.388270-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250617193853.388270-1-cel@kernel.org>

On Tue, Jun 17, 2025 at 03:38:51PM -0400, Chuck Lever wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
> 
> Tested: "make binrpm-pkg" on Fedora 39 then installed with "rpm
> -ivh ...". Newly installed kernel reboots as expected.
> 
> I will have a look at origin/linux-6.1.y next.
> 
> Jose Ignacio Tornos Martinez (1):
>   kbuild: rpm-pkg: simplify installkernel %post
> 
> Masahiro Yamada (1):
>   scripts: clean up IA-64 code
> 
>  scripts/checkstack.pl        |  3 ---
>  scripts/gdb/linux/tasks.py   | 15 +++------------
>  scripts/head-object-list.txt |  1 -
>  scripts/kconfig/mconf.c      |  2 +-
>  scripts/kconfig/nconf.c      |  2 +-
>  scripts/package/kernel.spec  | 28 +++++++++++-----------------
>  scripts/package/mkdebian     |  2 +-
>  scripts/recordmcount.c       |  1 -
>  scripts/recordmcount.pl      |  7 -------
>  scripts/xz_wrap.sh           |  1 -
>  10 files changed, 17 insertions(+), 45 deletions(-)

Why is this needed in 6.6.y?  Is this just a new feature or fixing
something that has always been broken?  It looks to me like a new
feature...

thanks,

greg k-h

