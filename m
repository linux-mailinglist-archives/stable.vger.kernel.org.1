Return-Path: <stable+bounces-67753-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F52B952B32
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 11:31:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F0DC1C2098F
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 09:31:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A0F919E7D3;
	Thu, 15 Aug 2024 08:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RqDajJqx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6B811917EB;
	Thu, 15 Aug 2024 08:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723710777; cv=none; b=of16HnxoelIBv6UePFNcri368dWZD73xB0GNfFtAho2Hf0/bZzzePnjWAcBh8KO9pNl/iex8pohiz3pnvntOOIWeEdBviAMnKCn4QT6iGXic3Hg2dOviEgOP08hFd8aCex7Q9nZRyeve92bIsJYJ++qRKyqevl3V9yXjUHtF6To=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723710777; c=relaxed/simple;
	bh=xmuV7SBrKLod7Gy80/YSA4b+g/dPXWN6wrTUi8MLbYA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BDFAhfUeJ9QXK6jD3j4XuS0PHJigRMTpdrv4gu2oT27L6uEF/74tM4HL7MJnuo8j9weXIrLzFmw9X8mXdLwZstOjFCX9WklIfi6HUGR9LJ5rb31M+7uIL3WPSI7quecXl7+ljcc+YF7+pwuOGjWj1hwtYNc1/4kxGJHtryITHEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RqDajJqx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DFF3C32786;
	Thu, 15 Aug 2024 08:32:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723710777;
	bh=xmuV7SBrKLod7Gy80/YSA4b+g/dPXWN6wrTUi8MLbYA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RqDajJqxkuEbNHKYpluKcidT9jgSov4JHgzIBZBMLkxTzlQafPUc6/L9d6D1j4Fpo
	 L5Gsve2ri5xtko7DTjQnGqR8O5tfKLFA2w8DF07J8g+Iq60C9t20+pZ3ZO67hqyE6k
	 Iwr7cGnZW3BwRVdcm+0s6+SofktLu1sgzbpogSig=
Date: Thu, 15 Aug 2024 10:32:54 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: WangYuli <wangyuli@uniontech.com>
Cc: stable@vger.kernel.org, sashal@kernel.org, keith.busch@intel.com,
	axboe@fb.com, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	xuerpeng@uniontech.com, hmy <huanglin@uniontech.com>,
	Wentao Guan <guanwentao@uniontech.com>,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH 5.15+] nvme/pci: Add APST quirk for Lenovo N60z laptop
Message-ID: <2024081547-unfounded-dumping-9d42@gregkh>
References: <722C75CD96F242C0+20240731071827.112255-1-wangyuli@uniontech.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <722C75CD96F242C0+20240731071827.112255-1-wangyuli@uniontech.com>

On Wed, Jul 31, 2024 at 03:18:27PM +0800, WangYuli wrote:
> commit ab091ec536cb7b271983c0c063b17f62f3591583 upstream
> 
> There is a hardware power-saving problem with the Lenovo N60z
> board. When turn it on and leave it for 10 hours, there is a
> 20% chance that a nvme disk will not wake up until reboot.
> 
> Link: https://lore.kernel.org/all/2B5581C46AC6E335+9c7a81f1-05fb-4fd0-9fbb-108757c21628@uniontech.com
> Signed-off-by: hmy <huanglin@uniontech.com>
> Signed-off-by: Wentao Guan <guanwentao@uniontech.com>
> Signed-off-by: WangYuli <wangyuli@uniontech.com>
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---
>  drivers/nvme/host/pci.c | 7 +++++++
>  1 file changed, 7 insertions(+)

All now queued up, thanks.

greg k-h

