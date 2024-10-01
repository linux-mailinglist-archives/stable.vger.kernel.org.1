Return-Path: <stable+bounces-78334-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 43DD898B63B
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 09:56:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 761FF1C21E76
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 07:56:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A48B1BDA99;
	Tue,  1 Oct 2024 07:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Qog9oh6p"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6D8D1E4AF;
	Tue,  1 Oct 2024 07:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727769364; cv=none; b=HmHc0XBNelNpA56bcIGIEi2SvLQHmQA4q8ZK4205Els6x3xabrIDReQXU6Bux5Pjsi7kqHWBSESUT7RNktL1+9rbW7PIrrTuijN4CbTFRh5HgG05QdZq34Uf7AQi8dQzccAUuoUowRxawWt1RM2BpMyPTCq00TbB8OrSYOpEiew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727769364; c=relaxed/simple;
	bh=DUSla1FAPzb+LNDyXiPJO2AqdEAllX4YCcHfZCCWlRg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XIs+IOx8mH1LJWRaEH1bFwGsHhd6CkRYVcQZlaVpHnkjRzXAa5vBnboFlEFpRzYFTGQRKi7w5u+crSk4ga5BbnKuko8oVPsKFEtDC91/V9mN5l1rbELzsbA8kf5/dItRMCg86fuFRljavAxoYgqEiVg5zcHgJjJGqZHXLXn9o00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Qog9oh6p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E604CC4CEC6;
	Tue,  1 Oct 2024 07:56:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727769364;
	bh=DUSla1FAPzb+LNDyXiPJO2AqdEAllX4YCcHfZCCWlRg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Qog9oh6pMmi/iiUp/eg9Hl5FLD8BkWdz7FS4DfcEFy6oLaV6FBPBTYFjW9hP4G/93
	 c8tM1DpRFoRdYj678AP9PsmMoupzFgIkn3AtG52xqjFquZUni1ulEsqcU3Z09c/cbx
	 6DxW3R4detlf5A3PsrZmRK+bCFmqNUuZFprCyP64=
Date: Tue, 1 Oct 2024 09:56:01 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Huacai Chen <chenhuacai@loongson.cn>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Huacai Chen <chenhuacai@kernel.org>,
	Sasha Levin <sashal@kernel.org>, Bibo Mao <maobibo@loongson.cn>,
	loongarch@lists.linux.dev, linux-kernel@vger.kernel.org,
	Xuerui Wang <kernel@xen0n.name>, stable@vger.kernel.org
Subject: Re: [PATCH 6.10.y] Revert "LoongArch: KVM: Invalidate guest steal
 time address on vCPU reset"
Message-ID: <2024100152-ruse-congested-d132@gregkh>
References: <CAAhV-H4WLByJ53oqQgEnVjy4bT0pS77fT5BA4NaCp8AOn+cyJw@mail.gmail.com>
 <20241001072511.17953-1-chenhuacai@loongson.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241001072511.17953-1-chenhuacai@loongson.cn>

On Tue, Oct 01, 2024 at 03:25:11PM +0800, Huacai Chen wrote:
> This reverts commit 05969a6944713f159e8f28be2388500174521818.
> 
> LoongArch's PV steal time support is add after 6.10, so 6.10.y doesn't
> need this fix.
> ---

No signed-off-by line :(


