Return-Path: <stable+bounces-191379-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id AA945C12B1C
	for <lists+stable@lfdr.de>; Tue, 28 Oct 2025 03:51:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 57CC53545F0
	for <lists+stable@lfdr.de>; Tue, 28 Oct 2025 02:51:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC1252777FC;
	Tue, 28 Oct 2025 02:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Fvovu8Il"
X-Original-To: stable@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD5B323ABA7;
	Tue, 28 Oct 2025 02:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761619902; cv=none; b=lcEjNuOuzxa1RK8+LkwNWJ326tq+tMV88Z+PsGj6KmAcqTijW4RFLN/cXm7V9BNw3yf/L1867m7mEJB113v41JyfWhfn4R/mFE5yPlfr3vxihHybqvzC51MG0HU4aatLi8Zh4W/1GHCPWe7Uu7lQNQuesp3XzKNeOl5krEIDOns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761619902; c=relaxed/simple;
	bh=CmEsD28Zxe5c54QqDeWV+aL5F3nBQNXbasrT3dJ7bOE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oWzfSfNnbAFJ4tOddkRXelSzsecaVGzMV98Nso+a35FsNd0rYJmXueCzdcaMQkWuC0W/G19LDfzKwaetj8DU2PY30e+xWPvxV0qS7K5cMxcRySWT1Z69Ps49MJxg+ypJ7Ndb/K6veesmQWL2KdMfN/9+7b2G3qiYB2EbKreuHLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Fvovu8Il; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=zPR99w+9Fi2WOCvCk4cfqcHQkI1zN/4r/LSkpLkWWDQ=; b=Fvovu8IlJen68sp5p/Dwn8t5c5
	Ami1eHp89SNtzONq7z0G998GlXShePDUwRbXfyKW3KN0Sot6hiII1g8lPEvv3sr85OnPqOAdSZI1q
	bL59Ze1iVLF6+SEce6QnKSr09r1tFFxX49+dS8wSS/ofbTAMGnwePQQDCg9RC2tPg2/Y=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vDZnc-00CFxP-He; Tue, 28 Oct 2025 03:51:04 +0100
Date: Tue, 28 Oct 2025 03:51:04 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Yi Cong <cong.yi@linux.dev>
Cc: Frank.Sae@motor-comm.com, andrew+netdev@lunn.ch, hkallweit1@gmail.com,
	linux@armlinux.org.uk, davem@davemloft.net, kuba@kernel.org,
	netdev@vger.kernel.org, Yi Cong <yicong@kylinos.cn>,
	stable@vger.kernel.org
Subject: Re: [PATCH] net: phy: motorcomm: Fix the issue in the code regarding
 the incorrect use of time units
Message-ID: <e1311746-9882-4063-84af-3939466096e9@lunn.ch>
References: <20251028015923.252909-1-cong.yi@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251028015923.252909-1-cong.yi@linux.dev>

On Tue, Oct 28, 2025 at 09:59:23AM +0800, Yi Cong wrote:
> From: Yi Cong <yicong@kylinos.cn>
> 
> Currently, NS (nanoseconds) is being used, but according to the datasheet,
> the correct unit should be PS (picoseconds).
> 
> Fixes: 4869a146cd60 ("net: phy: Add BIT macro for Motorcomm yt8521/yt8531 gigabit ethernet phy")
> Cc: stable@vger.kernel.org
> Signed-off-by: Yi Cong <yicong@kylinos.cn>
> ---
>  drivers/net/phy/motorcomm.c | 102 ++++++++++++++++++------------------
>  1 file changed, 51 insertions(+), 51 deletions(-)
> 
> diff --git a/drivers/net/phy/motorcomm.c b/drivers/net/phy/motorcomm.c
> index a3593e663059..81491c71e75b 100644
> --- a/drivers/net/phy/motorcomm.c
> +++ b/drivers/net/phy/motorcomm.c
> @@ -171,7 +171,7 @@
>   * 1b1 enable 1.9ns rxc clock delay
>   */
>  #define YT8521_CCR_RXC_DLY_EN			BIT(8)
> -#define YT8521_CCR_RXC_DLY_1_900_NS		1900
> +#define YT8521_CCR_RXC_DLY_1_900_PS		1900

This could be down to interpretation.

#define YT8521_CCR_RXC_DLY_1.900_NS		1900

would be technically correct, but not valid for cpp(1). So the . is
replaced with a _ .

#define YT8521_CCR_RXC_DLY_1900_PS		1900

would also be correct, but that is not what you have in your patch,
you leave the _ in place.

    Andrew

---
pw-bot: cr

