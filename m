Return-Path: <stable+bounces-107878-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D6A11A0484D
	for <lists+stable@lfdr.de>; Tue,  7 Jan 2025 18:30:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CEF61166E69
	for <lists+stable@lfdr.de>; Tue,  7 Jan 2025 17:30:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 214F21F12F7;
	Tue,  7 Jan 2025 17:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="MepFbkWt"
X-Original-To: stable@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DB841F3D4C;
	Tue,  7 Jan 2025 17:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736270987; cv=none; b=rNVWE3tVIU+yOp/NbDpe/beRpjo8mZI2tWZzDTUfCKpGCvXGeMyvh9ivukhOe5qxeSNV8qu7j6VadT9+rNGE7tuNMp/T5umydZNFJ+y5045xnKmBKuz5h38a7MbBXid+3771l7aTLvm3v7S4izm2sB25mHy70cjHirk88y7XT+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736270987; c=relaxed/simple;
	bh=d+qVIXHGzIEV2L4U96lrzLS9JbOH8KM8aPigs1iRU40=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tSAPDMs/r8RlMOuYP+J01ikt2Mh4JEAh0Wnfy5LmLNfpPuG8JoaZJmAb045yke4D/hM8SZXXS8wCH/Nknny5EV45DR6GDLdJLhFJVWoztyEzhd5FviIUGQotCOpdOZ7UeLNm2ogznFzLZHRNH43FRl8eE4IA53MuFOtTwOVV+Vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=MepFbkWt; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=EVYVEipvd5H4q20DXz8KjWI0d541jihGaq7GP8u3Bkc=; b=MepFbkWtfGkzFWwnw8iMfC8KPN
	jN4aHEUkXdwNwBa1HCM4LwbMqfcHPoMdU/TiIbG/kFQ41YJho1cZyrnwXmVd7b8JNa1GjRZBDJd1s
	fEZgkP2BNzTdiOIjZdaA03/y0Owmdy1LD+Ml1OUUPVQ6U8n61nekWpGwcmE/y8jwjX76PR3lV5Yzu
	sklqoWT2Z/wTVkkHC7vhTg+9wqpeMkhJy6WVAat9GtSW/hcq5Kxv8VBWf2P3MFfvx0zwShqT2heyj
	aU24jRDLJk5t2p3GqyjM6epAYk8vzLg3cS4Amywo+b8eZr5Q5UEHNA0D8vOnC0KlPY4OD4NDftTuO
	WH9OBnww==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:57138)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tVDOa-0007w3-05;
	Tue, 07 Jan 2025 17:29:36 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tVDOX-0005TI-2a;
	Tue, 07 Jan 2025 17:29:33 +0000
Date: Tue, 7 Jan 2025 17:29:33 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Ma Ke <make24@iscas.ac.cn>
Cc: elder@kernel.org, sumit.garg@linaro.org, gregkh@linuxfoundation.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v3] [ARM] fix reference leak in locomo_init_one_child()
Message-ID: <Z31kfQiLA6pddH_a@shell.armlinux.org.uk>
References: <20250107020714.662708-1-make24@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250107020714.662708-1-make24@iscas.ac.cn>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Jan 07, 2025 at 10:07:14AM +0800, Ma Ke wrote:
> Once device_register() failed, we should call put_device() to
> decrement reference count for cleanup. Or it could cause memory leak.
> 
> device_register() includes device_add(). As comment of device_add()
> says, 'if device_add() succeeds, you should call device_del() when you
> want to get rid of it. If device_add() has not succeeded, use only
> put_device() to drop the reference count'.
> 
> Found by code review.
> 
> Cc: stable@vger.kernel.org
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Ma Ke <make24@iscas.ac.cn>
> ---
> Changes in v3:
> - modified the patch as suggestions;
> Changes in v2:
> - modified the patch as suggestions.
> ---
>  arch/arm/common/locomo.c | 15 ++++++---------
>  1 file changed, 6 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/arm/common/locomo.c b/arch/arm/common/locomo.c
> index cb6ef449b987..9e275b2105c2 100644
> --- a/arch/arm/common/locomo.c
> +++ b/arch/arm/common/locomo.c
> @@ -220,13 +220,11 @@ static int
>  locomo_init_one_child(struct locomo *lchip, struct locomo_dev_info *info)
>  {
>  	struct locomo_dev *dev;
> -	int ret;
> +	int ret = 0;

The code around "ret" becomes:

	int ret = 0;

...

        ret = device_register(&dev->dev);

Nothing between these two statements references "ret", and the present
goto is eliminated in your patch.

So, why do we need to initialise ret to zero where it is declared?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

