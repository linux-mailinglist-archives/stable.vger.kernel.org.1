Return-Path: <stable+bounces-148901-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FA96ACA91C
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 07:50:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8CB8F7AA62D
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 05:49:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17F9618DF8D;
	Mon,  2 Jun 2025 05:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SgjAxFxm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93BB618E20;
	Mon,  2 Jun 2025 05:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748843417; cv=none; b=ASimCCwTSYtu8rfqsgHCeCho7+grL8ph/aOaACCoETTHN99aO0/CVVgbHMo2HQRdVM93umdquE43x+eAaz2DRK+4fRSbCiPZdAKXeanGvgeHKVgvjcl1EmW+F8uYMF1gnuf/3MemuPjq5ylZkHocGky6+ZaWDmWDUtSa/Anb2AA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748843417; c=relaxed/simple;
	bh=wExWTR9doFTPzuPNcFKSPCzLiF9SavNGYWxoU1RBEzk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bOxgpT3tv//rE70CkUjexqMPUf7InxosnO3rS8VjefCXDJol8tFlEVsb4A/7n/2b9aRTpQ6Yn3uPm3HFAcuC+RadHM7ABFLSaFpX0qrPMueaYtDb/Q/2FKxrrrI8KYMTcnbecgWUprtXuRgpMnAzTF644eEA3BEZMrKuUXJi5YU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SgjAxFxm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C31E5C4CEF0;
	Mon,  2 Jun 2025 05:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1748843414;
	bh=wExWTR9doFTPzuPNcFKSPCzLiF9SavNGYWxoU1RBEzk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SgjAxFxmvZTEGPt4fPTbCs4kXUhHUpY6dTEWjKf2S1Rzknc3k/ULdRmmbiqDxkQSl
	 jO9g9Jg5DhEMqWNxsAheb8/E68BlXydZJxRXScVG7sWcMuO1DeWoJ0xWCm+nMHqRDx
	 EMCO/Km25lmf7pNd12nZaZ/12+LkD40Pnzw0S2d0=
Date: Mon, 2 Jun 2025 07:50:11 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Achill Gilgenast <fossdd@pwned.life>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] kallsyms: fix build without execinfo
Message-ID: <2025060248-splendor-riverside-c8fe@gregkh>
References: <20250601183309.225569-1-fossdd@pwned.life>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250601183309.225569-1-fossdd@pwned.life>

On Sun, Jun 01, 2025 at 08:32:50PM +0200, Achill Gilgenast wrote:
> Signed-off-by: Achill Gilgenast <fossdd@pwned.life>
> Cc: stable@vger.kernel.org
> ---
>  tools/include/linux/kallsyms.h | 4 ++++
>  1 file changed, 4 insertions(+)

I know I can't take patches without any changelog text, but maybe other
maintainers are more lax.

good luck!

greg k-h

