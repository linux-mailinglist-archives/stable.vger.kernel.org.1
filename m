Return-Path: <stable+bounces-124337-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC265A5FB21
	for <lists+stable@lfdr.de>; Thu, 13 Mar 2025 17:18:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FE443BAA33
	for <lists+stable@lfdr.de>; Thu, 13 Mar 2025 16:12:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E98FA269813;
	Thu, 13 Mar 2025 16:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YtLA/+g5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A59532690FE
	for <stable@vger.kernel.org>; Thu, 13 Mar 2025 16:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741882086; cv=none; b=sL3lQ4Co+jIzHiWks5z/Lbzerq3MgvKEuTdRUFFrzqL2nlw/btVKj4o5v1ndUUMnQCPZC6/TrGmc/2ejGlxt70VYRL7UHCx17cbPnvD7u1mquzxurNPe2YvuV+WvlbLtD1ohKZ4Pk8RY5nI5XC5QxzpH0AdV66bUUOz4nRRm8VU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741882086; c=relaxed/simple;
	bh=kGQDnVMTJDETdiMwsqf0V8Rx/7fqhbJoS6iDbugvY1I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EHe+mfnanIF3p4NpI5r6rboo9W5dB3jVryO5xsgfWVEfOQo+AZhH5/7TRnOULc8M8KmVc5SmuiB9VpZg+FcsHJR6hlRTJrmbIdoEQMhOq9MLhh+LZkDtY5WmP15MPJTuyIZ0kiM+XHNYjrjg9EQX6g9mnY+PVTy1BQem5+yuCsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YtLA/+g5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C32AFC4CEDD;
	Thu, 13 Mar 2025 16:08:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741882086;
	bh=kGQDnVMTJDETdiMwsqf0V8Rx/7fqhbJoS6iDbugvY1I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YtLA/+g50ySd7BatSnZ7SX0uTtIM6O0rFLVGIx4NaG5vX8L85udKMGiAGY0RUqffP
	 fJkWuK83nu6w6SjFym7h4OnwCiUxK1/mHZrgEeT37dxEBaHK0SBdvX13C1TuwHGxsh
	 xUjzfUx2ytT5vq0F08qyk8iwOuYA8x3CQJof+OAM=
Date: Thu, 13 Mar 2025 17:08:03 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Zenm Chen <zenmchen@gmail.com>
Cc: stable@vger.kernel.org, pkshih@realtek.com
Subject: Re: [PATCH 6.6.y 1/2] wifi: rtw89: pci: add pre_deinit to be called
 after probe complete
Message-ID: <2025031300-ablaze-snazzy-8996@gregkh>
References: <20250311081001.1394-1-zenmchen@gmail.com>
 <20250311081001.1394-2-zenmchen@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250311081001.1394-2-zenmchen@gmail.com>

On Tue, Mar 11, 2025 at 04:10:00PM +0800, Zenm Chen wrote:
> From: Ping-Ke Shih <pkshih@realtek.com>
> 
> [ Upstream commit 9e1aff437a560cd72cb6a60ee33fe162b0afdaf1 ]
> 
> At probe stage, we only do partial initialization to enable ability to
> download firmware and read capabilities. After that, we use this pre_deinit
> to disable HCI to save power.
> 
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
> Signed-off-by: Kalle Valo <kvalo@kernel.org>
> Link: https://lore.kernel.org/r/20231110012319.12727-4-pkshih@realtek.com
> [ Zenm: minor fix to make it apply on 6.6.y ]

That was not "minor" changes, as your diff looks like:

> Signed-off-by: Zenm Chen <zenmchen@gmail.com>
> ---
>  drivers/net/wireless/realtek/rtw89/core.c | 2 ++
>  drivers/net/wireless/realtek/rtw89/core.h | 6 ++++++
>  drivers/net/wireless/realtek/rtw89/pci.c  | 8 ++++++++
>  3 files changed, 16 insertions(+)

But the original was:
 drivers/net/wireless/realtek/rtw89/core.c   |    2 ++
 drivers/net/wireless/realtek/rtw89/core.h   |    6 ++++++
 drivers/net/wireless/realtek/rtw89/pci.c    |    2 ++
 drivers/net/wireless/realtek/rtw89/pci.h    |   12 ++++++++++++
 drivers/net/wireless/realtek/rtw89/pci_be.c |   18 ++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/reg.h    |    9 +++++++++
 6 files changed, 49 insertions(+)

That is a big difference.

Please either backport the whole thing, or document exactly what you
changed here.  Otherwise this looks like a totally new patch and we
can't take that for obvious reasons.

thanks,

greg k-h

