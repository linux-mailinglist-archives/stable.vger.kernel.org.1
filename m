Return-Path: <stable+bounces-80599-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69CE798E3A8
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 21:43:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E7F02834AE
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 19:43:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2136A215F74;
	Wed,  2 Oct 2024 19:43:50 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [213.95.27.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BCC92141B4
	for <stable@vger.kernel.org>; Wed,  2 Oct 2024 19:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.27.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727898230; cv=none; b=JYhnbV/m82kB70GRBkO9IB5NJhkLgDwZYXIBOa1UNPg4m/AOQ998li24LyA0JhAHrEKgetRuEuENHwPLvf/kraid/pZJEFLwxlqx3GJVk1xb5zqDr3nwxAFg7XSKLaiy0nOMRmLoQe7lPCmr9veNAIIiVWgN//GZbLzmobK+sVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727898230; c=relaxed/simple;
	bh=sWb4NywYw5RT1MLI7VsdAyIb2WjXamz9RIbyejq5fdk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vw4nf+7AeHxN5qeWtfgu7G+XXr/ijtO8Fz761ir2DyhSyigEq1LtGlR8ewZLv4oMTlL0n+LeXBKN88I3nTYNEK0fDLEI5aCwvACv76W0U4qgPmLEdaX6EGAWZCZT3j0gu5lNdeQgiX3+C/NYo9WtcFfdsj4poJ6JKxH+NHBoEyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=gnumonks.org; arc=none smtp.client-ip=213.95.27.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gnumonks.org
Received: from [78.30.37.63] (port=36012 helo=gnumonks.org)
	by ganesha.gnumonks.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <pablo@gnumonks.org>)
	id 1sw5Fj-00CG1K-PK; Wed, 02 Oct 2024 21:43:17 +0200
Date: Wed, 2 Oct 2024 21:43:14 +0200
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: Vegard Nossum <vegard.nossum@oracle.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org,
	pavel@denx.de, cengiz.can@canonical.com, mheyne@amazon.de,
	mngyadam@amazon.com, kuntal.nayak@broadcom.com,
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
	mpearson-lenovo@squebb.ca, nicolinc@nvidia.com, rfoss@kernel.org,
	richard@nod.at, tfiga@chromium.org, vladimir.oltean@nxp.com,
	xiaolei.wang@windriver.com, yanjun.zhu@linux.dev,
	yi.zhang@redhat.com, yu.c.chen@intel.com, yukuai3@huawei.com
Subject: Re: [PATCH RFC 6.6.y 00/15] Some missing CVE fixes
Message-ID: <Zv2iUs9dI1zI8LyI@calendula>
References: <20241002150606.11385-1-vegard.nossum@oracle.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241002150606.11385-1-vegard.nossum@oracle.com>
X-Spam-Score: -1.9 (-)

Hi Vegard,

On Wed, Oct 02, 2024 at 05:05:51PM +0200, Vegard Nossum wrote:
[...]
> We are not subsystem experts and that's why we have marked this
> series as RFC -- any review or feedback is welcome. We've tried to
> document the conflicts and their causes in the changelogs. We haven't
> done targeted testing beyond our usual stable tests, but this
> includes for example the netfilter test suite, which did not show any
> new failures.

Thanks for your backport, I have a similar series locally here for
6.6.x. I made a reproducer for this issue and I failed to trigger the
issue that is described in this patch series. So either I did not do
the right reproducer or the 6.6.x is not affected. I would like to
have a second look at this issue.

Thanks.

