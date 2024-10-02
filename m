Return-Path: <stable+bounces-79294-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2473598D785
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 15:50:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDC061F21556
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 13:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C97E1D042F;
	Wed,  2 Oct 2024 13:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="iUSYO3SO"
X-Original-To: stable@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A17981CF5C6;
	Wed,  2 Oct 2024 13:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727877023; cv=none; b=iFYvd/6AlkKEc9BzjCkL3rs+Ru0yabmAoj+Fr4lSP33rrdgFifaLuTDLtW+Z/2zg2Fn73KuYVZ+MUlsP9NAevn4uxwFIQNXqEbeoJyeiVXoEwSKJld36Ri3wtyeqQmve9u2/mt7fw+M0v647hmIHp6kqp+EjGx3ud3QJLdjJqJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727877023; c=relaxed/simple;
	bh=I8zHU9ljuu6yT/c0cQjwimn/tPfKUTumboPM9IprxNM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HgNav+LHDvuSHNpIjxeibvfD4FtELHXLMrz2Baq2PRzGwi0q1lb7y67w/ms7ulPgEanVulT4E89JBQCXDZxEJdDfKmgWxCKFpAs6TJWGZHvoZ5fR4akvyMaJbvyNW3+fHlMYFLxVtECVabH3Dfq/MvgUhAfpcDsr3VcY/qcxMu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=iUSYO3SO; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=dn455BDcU15KPJl6HB0JCPOM6QTXx0KuElbVlyaPm2o=; b=iUSYO3SOkBW7MosqoxhdUz8xO5
	FcO1RrPDywvaPJoOVXS/Hglls8bDjghzv2Ie3a6CgRv29Iij+a1fPNFXeaUmNfLGaJhF1aolYTIaE
	/pmSTNjjnUC9cunTS5eKBGsDSka16cI9ySwOzVRtteDKea54HXizedon8qH0FraHOM8Y=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1svzk3-008rbD-OI; Wed, 02 Oct 2024 15:50:11 +0200
Date: Wed, 2 Oct 2024 15:50:11 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Josua Mayer <josua@solid-run.com>
Cc: Gregory Clement <gregory.clement@bootlin.com>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] arm64: dts: marvell: cn9130-sr-som: fix cp0 mdio pin
 numbers
Message-ID: <2d867c1f-2693-40f2-a410-2c83c253bea1@lunn.ch>
References: <20241002-cn9130-som-mdio-v2-1-ec798e4a83ff@solid-run.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241002-cn9130-som-mdio-v2-1-ec798e4a83ff@solid-run.com>

On Wed, Oct 02, 2024 at 03:07:16PM +0200, Josua Mayer wrote:
> SolidRun CN9130 SoM actually uses CP_MPP[0:1] for mdio. CP_MPP[40]
> provides reference clock for dsa switch and ethernet phy on Clearfog
> Pro, wheras MPP[41] controls efuse programming voltage "VHV".
> 
> Update the cp0 mdio pinctrl node to specify mpp0, mpp1.
> 
> Fixes: 1c510c7d82e5 ("arm64: dts: add description for solidrun cn9130 som and clearfog boards")
> Cc: stable@vger.kernel.org # 6.11.x
> Signed-off-by: Josua Mayer <josua@solid-run.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

