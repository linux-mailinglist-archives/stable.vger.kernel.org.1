Return-Path: <stable+bounces-191396-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6171AC131DA
	for <lists+stable@lfdr.de>; Tue, 28 Oct 2025 07:22:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CCD0E4F0015
	for <lists+stable@lfdr.de>; Tue, 28 Oct 2025 06:22:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52E5C285CBC;
	Tue, 28 Oct 2025 06:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="gAYDqUsv"
X-Original-To: stable@vger.kernel.org
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E35B627F016;
	Tue, 28 Oct 2025 06:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761632527; cv=none; b=pRI/MhZ+YdJHlmnMipOeIGj3YhbPZLFrzD6L0weXR+WTJ/lYHL8XOHerK6oeHg0vXUQKMPG6HdFXZu3uLGA0R6/+193OyJrGVQFHdaX/xf4TDy1uHbgJGocEhbAjoVjUvjcqgGNeEtI5yvdgwAQA8Jj5NweKDD6E9Ty7UQF54aY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761632527; c=relaxed/simple;
	bh=vtdDRi5KeXYsqEs617XnxsDkZDywMOtj1CNsXXdasl0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=J+JKewoW+ZgxEXnLfdhNU9GXPCghheVB4krMDSd7THWctB7xmvfH4gyjkhVqbqQkxas5IT75lTXjlrAGfhkzYXHJNRxYH/VBPEhCe6kqeie5jPGO3WIbc+kzYu/QGtMP1BOwN18IDgXvult0+Ftbaiupehf94NdhzvieqM3zIX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=gAYDqUsv; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761632521;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yVf3+YUx3Y9YJFw6Jg727jYx7bInMoRwQNEK7WIv3L0=;
	b=gAYDqUsv5uq3ZblgyQ5Mjmc45vz0mrA4mQEwCKH5rzxSvPNvqyX6XHjiVDXIS0eh20zFzV
	fq9A+Ax5DAJ2unHkXy3p33AQKTOHcvxp7wE4qshGYuAxdG/j+A0f2+tCyQWsGHvqmDhs1y
	YAFPQP8Ct1rjAshnB7JnaOBOvMhp3mQ=
From: Yi Cong <cong.yi@linux.dev>
To: andrew@lunn.ch
Cc: Frank.Sae@motor-comm.com,
	andrew+netdev@lunn.ch,
	cong.yi@linux.dev,
	davem@davemloft.net,
	hkallweit1@gmail.com,
	kuba@kernel.org,
	linux@armlinux.org.uk,
	netdev@vger.kernel.org,
	stable@vger.kernel.org,
	yicong@kylinos.cn
Subject: Re: [PATCH] net: phy: motorcomm: Fix the issue in the code regarding the incorrect use of time units
Date: Tue, 28 Oct 2025 14:21:10 +0800
Message-Id: <20251028062110.296530-1-cong.yi@linux.dev>
In-Reply-To: <e1311746-9882-4063-84af-3939466096e9@lunn.ch>
References: <e1311746-9882-4063-84af-3939466096e9@lunn.ch>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On Tue, 28 Oct 2025 03:51:04 +0100, Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Tue, Oct 28, 2025 at 09:59:23AM +0800, Yi Cong wrote:
> > From: Yi Cong <yicong@kylinos.cn>
> >
> > Currently, NS (nanoseconds) is being used, but according to the datasheet,
> > the correct unit should be PS (picoseconds).
> >
> > Fixes: 4869a146cd60 ("net: phy: Add BIT macro for Motorcomm yt8521/yt8531 gigabit ethernet phy")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Yi Cong <yicong@kylinos.cn>
> > ---
> >  drivers/net/phy/motorcomm.c | 102 ++++++++++++++++++------------------
> >  1 file changed, 51 insertions(+), 51 deletions(-)
> >
> > diff --git a/drivers/net/phy/motorcomm.c b/drivers/net/phy/motorcomm.c
> > index a3593e663059..81491c71e75b 100644
> > --- a/drivers/net/phy/motorcomm.c
> > +++ b/drivers/net/phy/motorcomm.c
> > @@ -171,7 +171,7 @@
> >   * 1b1 enable 1.9ns rxc clock delay
> >   */
> >  #define YT8521_CCR_RXC_DLY_EN			BIT(8)
> > -#define YT8521_CCR_RXC_DLY_1_900_NS		1900
> > +#define YT8521_CCR_RXC_DLY_1_900_PS		1900
>
> This could be down to interpretation.
>
> #define YT8521_CCR_RXC_DLY_1.900_NS		1900
>
> would be technically correct, but not valid for cpp(1). So the . is
> replaced with a _ .
>
> #define YT8521_CCR_RXC_DLY_1900_PS		1900
>
> would also be correct, but that is not what you have in your patch,
> you leave the _ in place.

Alright, I didn't realize that 1_950 represents 1.950;
I thought the underscores were used for code neatness,
making numbers like 900 and 1050 the same length, for example:
#define YT8521_RC1R_RGMII_0_900_PS
#define YT8521_RC1R_RGMII_1_050_PS

In that case, is my patch still necessary?
Or should I instead follow your suggestion above and change them to something like:
#define YT8521_RC1R_RGMII_900_PS
#define YT8521_RC1R_RGMII_1050_PS

Regards,
    Yi Cong

