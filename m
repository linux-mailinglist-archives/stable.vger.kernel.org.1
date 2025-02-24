Return-Path: <stable+bounces-119414-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AD44A42D23
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 20:56:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24D8C178C8B
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 19:56:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F9502066F2;
	Mon, 24 Feb 2025 19:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="gEjurNuA"
X-Original-To: stable@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8F2A24169B;
	Mon, 24 Feb 2025 19:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740426949; cv=none; b=O5BSlh6DZNwJuhS2FkhjwDDpeaAH3KHlvCKH5aDsGhf+LPKgF4RPEefWLHLZJ6cZPNqvveodKVZT6jM7tKqBhguiKhmyhjxDxwXHKCVmc5PipXIQD59DoWZ9rXyYGACEYrjUBVME+TZigkAHeunKkG+HGU0OhxIdywCkmrY6QGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740426949; c=relaxed/simple;
	bh=WkcuG5/FyCqakr+wzuOY41RSEvWhQkpSa7YEDvuMlzU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KLca9ZMJCJnPiaQ9pqpOon+mbxImY7ibm3x0iE3ChotEvPJdZpl1uTy8T2kit02Cu5gvoUrwmTMoHrSC2OXLKRtslohEhG7jnS1Hip4++D/UxzdMVSU2T2vrwxarp+/9vzQBIZEg0Pc2v/IzH3m9Oe76r0k5tBUcWuJrrfilRF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=gEjurNuA; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=4Mwr7TfmtvtGkeIg/OdtZgFGQqTQ12adcCYV8UQPq8g=; b=gEjurNuAgfuQye+FsI4vU6rM2N
	9AdM3VBog3sTJEHcgG5CWFpg+zpj/6SwMt8gJunu66xNDXiiFWXHatKYf0UBgBxgXCeQyW00wvfwj
	2XvP0FWjv6v3dU7JU2bOk/plj+gYwwbpw3sa4NjKGMOHzbVVrKS08DSdmCSgymDFjxiw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tmeXv-00HH6h-TM; Mon, 24 Feb 2025 20:55:19 +0100
Date: Mon, 24 Feb 2025 20:55:19 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Philipp Stanner <phasta@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Huacai Chen <chenhuacai@kernel.org>,
	Yanteng Si <si.yanteng@linux.dev>,
	Yinggang Gu <guyinggang@loongson.cn>,
	Feiyang Chen <chenfeiyang@loongson.cn>,
	Philipp Stanner <pstanner@redhat.com>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Qing Zhang <zhangqing@loongson.cn>, netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH net-next v3 1/4] stmmac: loongson: Pass correct arg to
 PCI function
Message-ID: <46a6a816-eed2-48ce-a483-fc6b31ad7b32@lunn.ch>
References: <20250224135321.36603-2-phasta@kernel.org>
 <20250224135321.36603-3-phasta@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250224135321.36603-3-phasta@kernel.org>

On Mon, Feb 24, 2025 at 02:53:19PM +0100, Philipp Stanner wrote:
> pcim_iomap_regions() should receive the driver's name as its third
> parameter, not the PCI device's name.
> 
> Define the driver name with a macro and use it at the appropriate
> places, including pcim_iomap_regions().
> 
> Cc: stable@vger.kernel.org # v5.14+
> Fixes: 30bba69d7db4 ("stmmac: pci: Add dwmac support for Loongson")
> Signed-off-by: Philipp Stanner <phasta@kernel.org>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

