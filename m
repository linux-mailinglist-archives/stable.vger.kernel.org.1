Return-Path: <stable+bounces-81561-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F550994582
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 12:32:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 346A32898FB
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 10:32:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B00118C93F;
	Tue,  8 Oct 2024 10:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EGREjzsV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09F8118BC3B
	for <stable@vger.kernel.org>; Tue,  8 Oct 2024 10:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728383566; cv=none; b=QfZEvv86bENiZDqdCJUcqFmXTXm8yzkrjs+tDiU0kMBpfyEj3piTBGrtoPOSnSzAoj11GNAUzktEWsMS5QuZ6U06ev2WzNeKX67f8uazDc2scBwsKxQBb3d6W5dHKoRs2AFgW746UUYCvCfI3eRhMPN4KDcZkart3hkTo5KAIgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728383566; c=relaxed/simple;
	bh=bZpkly3+sK3oxiyt3bCqkDJBUkLW7Pb6RYC20OBrOeI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lIa9uAUCJieWrqCkMTMJY6nuLelIkKwNZxmgK1Rx45SXpLez5ZTPp2Nl52o9QBAO/FQS9GtqFdDhUaMwZMfun9mEzG3geGLljpipZh9weKvobxx8DfWEaC14DAM+svlVyRREAVu6wHasjAVZXuVpFYFg1dwO6jvVesqKmOznw/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=EGREjzsV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 095F1C4CEC7;
	Tue,  8 Oct 2024 10:32:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728383565;
	bh=bZpkly3+sK3oxiyt3bCqkDJBUkLW7Pb6RYC20OBrOeI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EGREjzsVlFsrIT6QesqRnUSbD6Ss8PFiVxleAZq5TaAC3N/FbFp0fnbN7WHb4GLKV
	 T79BjRakJHIV6aXhTM2IlN5P6nPq/B0trJC+DJscJbTjm5bj2AG8h2LLZzt7X8eCjC
	 CvlNNaHFEchepkm5TmvyCn9vHxxCevqnULEfBAh4=
Date: Tue, 8 Oct 2024 12:32:42 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Vegard Nossum <vegard.nossum@oracle.com>
Cc: stable@vger.kernel.org, pavel@denx.de, cengiz.can@canonical.com,
	mheyne@amazon.de, mngyadam@amazon.com, kuntal.nayak@broadcom.com,
	ajay.kaher@broadcom.com, zsm@chromium.org, dan.carpenter@linaro.org,
	shivani.agarwal@broadcom.com, ahalaney@redhat.com,
	alsi@bang-olufsen.dk, ardb@kernel.org, axboe@kernel.dk,
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
Message-ID: <2024100824-wager-graceful-37e1@gregkh>
References: <20241002150606.11385-1-vegard.nossum@oracle.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241002150606.11385-1-vegard.nossum@oracle.com>

On Wed, Oct 02, 2024 at 05:05:51PM +0200, Vegard Nossum wrote:
> Hi,
> 
> We noticed some cases where a mainline commit that fixes a CVE has a
> Fixes: tag pointing to a commit that has been backported to 6.6 but
> where the fix is not present.
> 
> Harshit and I have backported some of these patches.
> 
> We are not subsystem experts and that's why we have marked this
> series as RFC -- any review or feedback is welcome. We've tried to
> document the conflicts and their causes in the changelogs. We haven't
> done targeted testing beyond our usual stable tests, but this
> includes for example the netfilter test suite, which did not show any
> new failures.
> 
> Greg: feel free to take these patches or leave it as you want.
> Conflict resolution always comes with the risk of missing something
> and we want to be up-front about that. On the other hand, these were
> identified as CVE fixes so presumably we're not the only ones who
> want them.

I've taken the ones that were not already in the stable queues, thanks
for the backports!

greg k-h

