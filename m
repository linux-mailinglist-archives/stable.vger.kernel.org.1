Return-Path: <stable+bounces-86764-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 901699A3609
	for <lists+stable@lfdr.de>; Fri, 18 Oct 2024 08:50:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 247AEB212BB
	for <lists+stable@lfdr.de>; Fri, 18 Oct 2024 06:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D02C18E74D;
	Fri, 18 Oct 2024 06:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LP+MT9zC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 313C8187339
	for <stable@vger.kernel.org>; Fri, 18 Oct 2024 06:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729234107; cv=none; b=dGua3vduq4RAH2xd8BEXC++AyY0alxK+MVzzt40KyuCKscMJLSrLHeSyrGdgvghqF2wR/UN9KNPAb6mtjziGKVaSWLI/KCHDmH8cMmz1+OCRWYw1AvgmdIh5GAf/v0Gxmjp+eFfUKdKhzTlFIH+0Ir+3QOyf6Zgbs0cm5rb/KHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729234107; c=relaxed/simple;
	bh=W8pFXMmk4xoVAWXNf1BLNUOMcuWTep2YmypRo5aTkQ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b1nKxypj4OtF/KtD0lK3dCABp9/Lh4gXAQ4jfwOTPN5oTrsxr3TyFY3OlEHJr4YfrAHfgTmIVnXFl/HfLMhEDpGzzyNTWWfuf10tl8IRj+pjJUyaWA9s7GpfGyDXCrcDgBDYTi1zN4iLcn/+7jZd8uFDolzPz3noz+5TMJZmgRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LP+MT9zC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58430C4CEC5;
	Fri, 18 Oct 2024 06:48:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1729234106;
	bh=W8pFXMmk4xoVAWXNf1BLNUOMcuWTep2YmypRo5aTkQ8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LP+MT9zCR2Ujg3uyHdrsfFnaQPodYmDUclEByYfaJ9EW0oDi+Pv//GzeICdwLbau0
	 IyZNlXC5uiWxA2ap5cZX+3aOVAQ2gO54u0p380nZ+jQP4uf/R5qzldGtSECrd6P1UW
	 3/fKtAqAa8cle/sV82XbzOe+hHS4OpMLyy3wKpH4=
Date: Fri, 18 Oct 2024 08:48:23 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Zenghui Yu <yuzenghui@huawei.com>
Cc: Sasha Levin <sashal@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	Marc Zyngier <maz@kernel.org>, tangnianyao@huawei.com,
	stable@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: Request to backport "irqchip/gic-v3-its: Fix VSYNC referencing
 an unmapped VPE on GIC v4.1"
Message-ID: <2024101816-paternity-curable-42fc@gregkh>
References: <1057d0bc-f4a5-3ea1-b281-c78e74bc8b85@huawei.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1057d0bc-f4a5-3ea1-b281-c78e74bc8b85@huawei.com>

On Tue, Oct 15, 2024 at 03:16:32PM +0800, Zenghui Yu wrote:
> Hi Greg, Sasha,
> 
> Could you please help to backport the upstream commit
> 80e9963fb3b5509dfcabe9652d56bf4b35542055 ("irqchip/gic-v3-its: Fix VSYNC
> referencing an unmapped VPE on GIC v4.1") to
> 
> * 5.10
> * 5.15
> * 6.1
> * 6.6
> 
> trees? It can be applied and built (with arm64's defconfig) cleanly on
> top of the mentioned stable branches.

Now queued up, thanks.

greg k-h

