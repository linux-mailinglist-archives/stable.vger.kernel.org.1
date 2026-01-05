Return-Path: <stable+bounces-204795-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DBC1CF3DA9
	for <lists+stable@lfdr.de>; Mon, 05 Jan 2026 14:37:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 72A5A30DC31C
	for <lists+stable@lfdr.de>; Mon,  5 Jan 2026 13:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A71D221F39;
	Mon,  5 Jan 2026 13:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="XkoXTaaj"
X-Original-To: stable@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE159225A35;
	Mon,  5 Jan 2026 13:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767619806; cv=none; b=edNA4ogk6IHTtTL8bSiv2PUumuGlyaZlYkguF2MKj0kXsAcMImr9hO5ZwtDT7pT72/9XfKTblUOnjezk9Ql6wo7QePjNeipuj4wehrtCPIwwjYa+dYHSbWipZFUhwXDuA2TXz42VWaO1B26TSThsbtqVC8/I+50ctlgzog0Sis4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767619806; c=relaxed/simple;
	bh=o9jbkrV2OfQZyMx0HC5TQMvXRwI7iv6Z+cNosx+/llA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jrcYlpKyFVDmY37+mSwr5cUjzUv1nbNNZKRpqR1eqIAcSMjagfgubkqxK2mYdSCbNI46ZWbzgMovT5QshLrPC8Qwz+HmQvj28gur/NHaWKtDXX9BtjW4kd4n3O9vz1W1y5N/U7yn7anxTGo22awI59WQu2euBmfA9oqAiJUuoig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=XkoXTaaj; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ENgS81baeUqSqQTbQeVHYozi6bLe6j1KLZFc66IniKM=; b=XkoXTaajLV+WtJIuchJPd1HT+3
	H8i9hrkMDG4sBZowsMW7EYkqzlRW5sOFKoVBQcL1tIySlfSLHwUouFY2YOG9mEqUoDus8dYzrSQNW
	Pgev2zvy5nFp+f0MAxuWynpxgSRU/tZ9Eq3Yz/GWMGdTHWJp1/trZObfsOZWCG1o40btMp+TqeUWm
	gKlffeurT29cKpKDAvZsoaRvJYgsyc7xMUfHN3iFwgXbMOpWs+KwCaZdsSMYtG8UYVXEa0O2mgEpz
	000MCF7rUGdXQ4WAsUusHLdscEya5t+FC5IvcZMiN5tObe/zP0US2X4WxtPTmQqmb98DAGOi4+7li
	xDMNbKNw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:51660)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vckeX-000000007rH-3OTm;
	Mon, 05 Jan 2026 13:29:45 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vckeS-000000007t1-3Z1h;
	Mon, 05 Jan 2026 13:29:40 +0000
Date: Mon, 5 Jan 2026 13:29:40 +0000
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
Message-ID: <aVu8xIfFrIIFqR0P@shell.armlinux.org.uk>
References: <20260105-bnxt-v2-1-9ac69edef726@debian.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260105-bnxt-v2-1-9ac69edef726@debian.org>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, Jan 05, 2026 at 04:00:16AM -0800, Breno Leitao wrote:
> When bnxt_init_one() fails during initialization (e.g.,
> bnxt_init_int_mode returns -ENODEV), the error path calls
> bnxt_free_hwrm_resources() which destroys the DMA pool and sets
> bp->hwrm_dma_pool to NULL. Subsequently, bnxt_ptp_clear() is called,
> which invokes ptp_clock_unregister().
> 
> Since commit a60fc3294a37 ("ptp: rework ptp_clock_unregister() to
> disable events"), ptp_clock_unregister() now calls
> ptp_disable_all_events(), which in turn invokes the driver's .enable()
> callback (bnxt_ptp_enable()) to disable PTP events before completing the
> unregistration.
> 
> bnxt_ptp_enable() attempts to send HWRM commands via bnxt_ptp_cfg_pin()
> and bnxt_ptp_cfg_event(), both of which call hwrm_req_init(). This
> function tries to allocate from bp->hwrm_dma_pool, causing a NULL
> pointer dereference:

This has revealed a latent bug in this driver. All the time that the
PTP clock is registered, userspace can interact with it, and thus
bnxt_ptp_enable() can be called. ptp_clock_unregister() unpublishes
that interface.

ptp_clock_unregister() must always be called _before_ tearing down any
resources that the PTP clock implementation may use.

From what you describe, it sounds like this patch fixes that.

Looking at the driver, however, it looks very suspicious.

__bnxt_hwrm_ptp_qcfg() seems to be the place where PTP is setup and
initialised (and ptp_clock_register() called in bnxt_ptp_init()).

First, it looks like bnxt_ptp_init() will tear down an existing PTP
clock via bnxt_ptp_free() before then re-registering it. That seems
odd.

Second, __bnxt_hwrm_ptp_qcfg() calls bnxt_ptp_clear() if
bp->hwrm_spec_code < 0x10801 || !BNXT_CHIP_P5_PLUS(bp) is true or
hwrm_req_init() fails. Is it really possible that we have the PTP
clock registered when PTP isn't supported?

Third, same concern but with __bnxt_hwrm_func_qcaps().

My guess is that this has something to do with firmware, and maybe
upgrading it at runtime - so if the firmware gets upgraded to a
version that doesn't support PTP, the driver removes PTP. However,
can PTP be used while firmware is being upgraded, and what happens
if, e.g. bnxt_ptp_enable() were called mid-upgrade? Would that be
safe?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

