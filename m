Return-Path: <stable+bounces-81579-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3F649946C3
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 13:25:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20F951C246DD
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 11:25:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BFBC1D2F7E;
	Tue,  8 Oct 2024 11:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KXer0U3n"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF7371D2B3C
	for <stable@vger.kernel.org>; Tue,  8 Oct 2024 11:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728386674; cv=none; b=i7cWTyIcDfugGHYS6Ti14rjE+qaY6oW/vwhWYzIuMY14CoJAgq81FQ8zLvR0x91b+1hfmrHZvsT3NSIWnyG1R3BHmq0kv9+Qiwfzct+t4+aHrrGiUqRdrPl+ljtxXaqm39pYs3Ig51ZtZoSAZbnZPz48DCqV+nh7JUVh9dot+1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728386674; c=relaxed/simple;
	bh=XSXFPh3AhgdMX/aQ2nRzmtyqm+US3yShKHue+ysilXo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dUN6P9NtBMccUJmuHQcHDgyEro0TrZyp/FNfNCFCwYwy8SgxoU1ORmWP/YYihFxuKOLbRe6uQ+Udxpu0ir21QwBu5YqhLXNEhS4hGpcu0Cdbkc8pqkOrmeG6LqhD+Bxt4OEOllUr4igJacwcZ/NF5IV+zAzyElGJ+cfMWBGfH3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KXer0U3n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE05CC4CECC;
	Tue,  8 Oct 2024 11:24:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728386674;
	bh=XSXFPh3AhgdMX/aQ2nRzmtyqm+US3yShKHue+ysilXo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KXer0U3ngcCoYAqa0synU7wQPOyPfPIno6apR/ptZnSMMCi/C6mCzBfFtqtAA4z3D
	 4veaOg+5FHFkzpG/RIclCeEVitNbqnJauPoszNfqktTA9DvLiPviG/r77iP7sS1kb3
	 /ghDhPeuj6x7fCeZ/3OfI3Y5BCxvFeGr10TyhbKI=
Date: Tue, 8 Oct 2024 13:24:31 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Pavel Machek <pavel@denx.de>
Cc: Vegard Nossum <vegard.nossum@oracle.com>, Jens Axboe <axboe@kernel.dk>,
	stable@vger.kernel.org, cengiz.can@canonical.com, mheyne@amazon.de,
	mngyadam@amazon.com, kuntal.nayak@broadcom.com,
	ajay.kaher@broadcom.com, zsm@chromium.org, dan.carpenter@linaro.org,
	shivani.agarwal@broadcom.com, ahalaney@redhat.com,
	alsi@bang-olufsen.dk, ardb@kernel.org,
	benjamin.gaignard@collabora.com, bli@bang-olufsen.dk,
	chengzhihao1@huawei.com, christophe.jaillet@wanadoo.fr,
	ebiggers@kernel.org, edumazet@google.com, fancer.lancer@gmail.com,
	florian.fainelli@broadcom.com, harshit.m.mogalapalli@oracle.com,
	hdegoede@redhat.com, horms@kernel.org, hverkuil-cisco@xs4all.nl,
	ilpo.jarvinen@linux.intel.com, jgg@nvidia.com, kevin.tian@intel.com,
	kirill.shutemov@linux.intel.com, kuba@kernel.org,
	luiz.von.dentz@intel.com, md.iqbal.hossain@intel.com,
	mpearson-lenovo@squebb.ca, nicolinc@nvidia.com, pablo@netfilter.org,
	rfoss@kernel.org, richard@nod.at, tfiga@chromium.org,
	vladimir.oltean@nxp.com, xiaolei.wang@windriver.com,
	yanjun.zhu@linux.dev, yi.zhang@redhat.com, yu.c.chen@intel.com,
	yukuai3@huawei.com
Subject: Re: [PATCH RFC 6.6.y 00/15] Some missing CVE fixes
Message-ID: <2024100823-barbed-flatness-631c@gregkh>
References: <20241002150606.11385-1-vegard.nossum@oracle.com>
 <612f0415-96c2-4d52-bd3d-46ffa8afbeef@kernel.dk>
 <69e265b4-fae2-4a60-9652-c8db07da89a1@oracle.com>
 <ZwUVPCre5BR6uPZj@duo.ucw.cz>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZwUVPCre5BR6uPZj@duo.ucw.cz>

On Tue, Oct 08, 2024 at 01:19:24PM +0200, Pavel Machek wrote:
> Hi!
> 
> > Unfortunately for distributions, there may be various customers or
> > government agencies which expect or require all CVEs to be addressed
> > (regardless of severity), which is why we're backporting these to stable
> > and trying to close those gaps.
> 
> Customers and government will need to understand that with CVEs
> assigned the way they are, addressing all of them will be impossible
> (or will lead to unstable kernel), unfortunately :-(.

Citation needed please.

