Return-Path: <stable+bounces-132908-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 10DDAA914D0
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 09:13:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8486C3AAEDC
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 07:12:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67D6464A98;
	Thu, 17 Apr 2025 07:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wGmBKRfj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17A342CCC0
	for <stable@vger.kernel.org>; Thu, 17 Apr 2025 07:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744873989; cv=none; b=F5EhZaACaRV2QrvV7Nev2FGqjqWeB7/JOqlJ8xdiu+gppkbvtcdczuCuFEyGD5oN2EtTv6tOVEhxQSpGnjZL26aMbUvMXMxHKFj4NdNXzmlOQvSfgkJ0djsrhVh6YlKrcu6KYfOxhQLlM/vslyE0YbmzBotrUAdBEcKqr/A4688=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744873989; c=relaxed/simple;
	bh=O6DlfjqnP0070ngD/TcPIrplBj7JXPe3liaquP63p/c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lQaoqISB3f8Z0B9rnRwHGmELaMiZW+IVm3gbTVAGR9LWVkuPxf04XAdrQ9IaJAdmOHthDE4hW3Ae5MAvJ6DFOuKvkBnk2/vmV3rf2OZp8o3QuxB03YpNV3gGKyQmIWLJcsSv/TNbJzABrMt5Rlu2hap1csPmncsHk89K3K3/XsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wGmBKRfj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08C98C4CEE4;
	Thu, 17 Apr 2025 07:13:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744873988;
	bh=O6DlfjqnP0070ngD/TcPIrplBj7JXPe3liaquP63p/c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=wGmBKRfjmNrDPmOwVkCTGgA1P7xpYxU2qOw7mhuNAuy9jqjH3vVnES72W3tzwESTQ
	 kb1Z9qF1f1UcN1r7X0r63KsGfmlgXvB59Mac8NfmhHa0XUtsvLkpmcgs7Y40CDagnC
	 CpeNloQgkq67rAiC7003AUJIzGbt8u/XVSHL3csQ=
Date: Thu, 17 Apr 2025 09:13:05 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Cliff Liu <donghua.liu@windriver.com>
Cc: huangchenghai2@huawei.com, herbert@gondor.apana.org.au,
	davem@davemloft.net, stable@vger.kernel.org
Subject: Re: Question about back-porting '8be091338971 crypto:
 hisilicon/debugfs - Fix debugfs uninit process issue'
Message-ID: <2025041727-crushable-unbend-6e6c@gregkh>
References: <767571bc-1a59-4f7c-a9c7-fb23b79303a9@windriver.com>
 <4725f8e8-7f46-48f6-9869-8bf16eca6f1a@windriver.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4725f8e8-7f46-48f6-9869-8bf16eca6f1a@windriver.com>

On Thu, Apr 17, 2025 at 02:51:05PM +0800, Cliff Liu wrote:
> Hi,
> 
> I think this patch is not applicable for 5.15 and 5.10.

Then why are you trying to apply it there?  Do you have the bug that is
being reported here on those kernel versions?  If not, why is this an
issue?  If so, find the files that are affected in those releases and
apply the change there.

> Could you give me any opinions?

It is your responsibility, if you want to backport changes to older
versions, to do the work.  It is NOT the original developer's
responsibility at all.  The first rule of the stable kernels is "this
will cause NO extra work for kernel developers" so if they don't want to
do this, they do not have to at all.

> Any helps from maintainers are very appreciated.

But not required or even expected.  Please work with your management to
understand exactly how the community works here.

thanks,

greg k-h

