Return-Path: <stable+bounces-204808-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D44ECF419D
	for <lists+stable@lfdr.de>; Mon, 05 Jan 2026 15:27:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4F121300D324
	for <lists+stable@lfdr.de>; Mon,  5 Jan 2026 14:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD9E51F12E9;
	Mon,  5 Jan 2026 14:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="MiOqiS63"
X-Original-To: stable@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D02419CCFC;
	Mon,  5 Jan 2026 14:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767623250; cv=none; b=TOVIpCIz8Zugd/vcW906XKC+IbTZ7AZNUT4LY2XzSz4N0hfpcgcJwFMIUAZU8kF1Kpl2mL2ET6WLSwxMx9zs8HEr/hDVnuEFJ4VEBFn7jVjVN5HAuH9i5epjFMKYulvV6nJft0oCWoEJLIQH2pbRWYl9UK8FewKsCCAbnKbw4iU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767623250; c=relaxed/simple;
	bh=DdYhTjNfP7e1khLO0LP+NDeTBRyadztgwywclnHYJSs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QzjvUu3Ycy0Ua9l3UkxfdvEZ9zvowcsGexD+p35UZdKMVfbjtnI+46b4z0e/K62zBgcF8WWERMbAvxtMgxU4TBP0QfIrSbI3mNvDw72QdSRnKsUd5dShWGb5ulrr+TACQJg8VXR2S/aiuxVkziczH4lXJSgXYHCLjGiKyXN9Y6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=MiOqiS63; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=r/xnRq6aPfliQavgZCSwZnJjF/QATt/NHvsM2dpp6t4=; b=MiOqiS63aY1JBxBuaXgV/E9PeG
	bZ98oa2Rbel/LNh8KsP8+5PemWupQP1pija3Bymo6FHYWjb8TkUCD9YEl9ndLUndxM3huRUzsYDvL
	NBUPNEomxgT4Lz/xMiACoeHMK7iBZAo1zVAmc/yn+1LoYAohw4SMztq/XAxAhhJplCusr897/itIB
	SpG5AdXz5aEluw7rNXsMWtZB6C/D0szI0OvpkOnnL+qJtbyvk9e0LwlHf/X0V3IwdiMGIEJRIVDYw
	CUB2YqNSYmZwN6R5ZCv831t5t8OFbYKAfov7BRppB2aFHl/3IwLO92BPPgPA+tDROQla5/2HnLY0a
	HLWS23MQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:45724)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vclYF-000000007vq-0TS5;
	Mon, 05 Jan 2026 14:27:19 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vclYC-000000007v5-1gLe;
	Mon, 05 Jan 2026 14:27:16 +0000
Date: Mon, 5 Jan 2026 14:27:16 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Breno Leitao <leitao@debian.org>
Cc: Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Vladimir Oltean <vladimir.oltean@nxp.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-team@meta.com,
	stable@vger.kernel.org
Subject: Re: [PATCH net v2] bnxt_en: Fix NULL pointer crash in
 bnxt_ptp_enable during error cleanup
Message-ID: <aVvKRGcSWb1muZ-k@shell.armlinux.org.uk>
References: <20260105-bnxt-v2-1-9ac69edef726@debian.org>
 <aVu8xIfFrIIFqR0P@shell.armlinux.org.uk>
 <ft63jjhpr2w5s6cdpriixbmmxft5phkvui25pdy46vexpawzz6@mu6gblhm7ofv>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ft63jjhpr2w5s6cdpriixbmmxft5phkvui25pdy46vexpawzz6@mu6gblhm7ofv>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, Jan 05, 2026 at 06:11:26AM -0800, Breno Leitao wrote:
> Hello Russell,
> 
> On Mon, Jan 05, 2026 at 01:29:40PM +0000, Russell King (Oracle) wrote:
> > On Mon, Jan 05, 2026 at 04:00:16AM -0800, Breno Leitao wrote:
> > My guess is that this has something to do with firmware, and maybe
> > upgrading it at runtime - so if the firmware gets upgraded to a
> > version that doesn't support PTP, the driver removes PTP. However,
> > can PTP be used while firmware is being upgraded, and what happens
> > if, e.g. bnxt_ptp_enable() were called mid-upgrade? Would that be
> > safe?
> 
> This crash happened at boot time, when the kernel was having another
> at DMA path, which was triggering this bug. There was no firmare upgrade
> at all. Just rebooting the machine with 6.19 was crashing everytime due
> to the early failure to initialize the driver.

Please read my email again. I wasn't questioning _when_ the problem you
were seeing was occuring. I was questioning the overall structural
quality of the driver, suggesting that there are further issues with it
around PTP.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

