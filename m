Return-Path: <stable+bounces-198131-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9786EC9CA82
	for <lists+stable@lfdr.de>; Tue, 02 Dec 2025 19:35:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21E113A4895
	for <lists+stable@lfdr.de>; Tue,  2 Dec 2025 18:35:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06BA228C84D;
	Tue,  2 Dec 2025 18:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="GcwsvPGv"
X-Original-To: stable@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 069A1125D0;
	Tue,  2 Dec 2025 18:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764700541; cv=none; b=VYWoE2qcjGDRp40gwYBlqt5ufR2A03cmtuj1/We981Hngyq0f4kuk6Z2yjko+s3JJpXJRslMcsNPjXe/xagWazYJ6HKXaVDxUn2JbEOH1Ff+KgPNshlNCV7WAwYjBiRrKZ3S7YnZE6COuoUM35Fv6qcfV74yn6d0d/MGguzcMtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764700541; c=relaxed/simple;
	bh=aPc/ZoofQvuYgqSIpXHBG+acWQi/JLSpX5bw5fEmdV4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ODs6dnrqW4SI0Uz1H3si/1pEjao4IXl9HF3lzNcAkF/IKNlCjnRveFDsaJZ9G5btxzWflytsyxd0W14Vj4N/wpTC9g7ft5G+i8XtiPMhRkvqgt8QSsvq6mK1Shw9bg1oYfy9GZPduO7sDRyVwkX1kzImMnkUMg+aUkAcxZ0VTyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=GcwsvPGv; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Un+nGjWShWaSygwAYN5k2vwmsItzcO4zzrq1NudXsbg=; b=GcwsvPGvVEqp5fwUVrgdsmiAU9
	PBgT6ZUaBqAA2WWDq7wRkLJgGL3nh67FOcVhzEV9/hURDCz70P3/IuqzMyzizPH+v3/Yg44+l0PGb
	jTPDNHACm8SiEw5DZphTXAKo2c4pG9ogbaa+Op+vETeUn9sr5eH/SPZLoI4AQdmSwZc8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vQVDe-00Fj9V-JH; Tue, 02 Dec 2025 19:35:22 +0100
Date: Tue, 2 Dec 2025 19:35:22 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Dimitri Fedrau <dima.fedrau@gmail.com>, stable@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: phy: marvell-88q2xxx: Fix clamped value in
 mv88q2xxx_hwmon_write
Message-ID: <03da7783-ec16-4a3d-aa48-f5f73bc8b6f3@lunn.ch>
References: <20251202172743.453055-3-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251202172743.453055-3-thorsten.blum@linux.dev>

On Tue, Dec 02, 2025 at 06:27:44PM +0100, Thorsten Blum wrote:
> The local variable 'val' was never clamped to -75000 or 180000 because
> the return value of clamp_val() was not used. Fix this by assigning the
> clamped value back to 'val', and use clamp() instead of clamp_val().
> 
> Cc: stable@vger.kernel.org
> Fixes: a557a92e6881 ("net: phy: marvell-88q2xxx: add support for temperature sensor")
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

