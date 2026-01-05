Return-Path: <stable+bounces-204884-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B800BCF52B9
	for <lists+stable@lfdr.de>; Mon, 05 Jan 2026 19:09:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 52A173045F4F
	for <lists+stable@lfdr.de>; Mon,  5 Jan 2026 18:03:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E502322B6B;
	Mon,  5 Jan 2026 18:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="PIxZNzZd"
X-Original-To: stable@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65AD12EE268;
	Mon,  5 Jan 2026 18:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767636229; cv=none; b=lzOLgIB34WxD0Ko2JTzRCm4DvC7bAb7sKX/01v97p9IFVaobzcoklDb+UPhM2VYgRQVIINFi7EIbbp9/owwNGOWK7g90o1Oi8sw2LzPjXvZVdf4tKn8oM7iYIX5l6SA0/WPK0MHgpq9MIM42Lr4VNHqSPRa66GzhBJzk7iybero=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767636229; c=relaxed/simple;
	bh=ZuqaS2J0jVOI/JnKtZE/N5VVqTj2FIgSKz/Mt6BAkBA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EjolfZQHENv2KYdkR1XHrqq1E4LqFcFImXGh97nIAnBtrE6gpXYhz2Z+j2kYndgEakvoOjMaMW1iJP1JUM8P2AxWsYOO+92frS1HkPgyV0T/CLlAxYBWQgExfm7+/8jbk6kDXv/DlVseZTV3AbUtZZQ3ekVq/8cPJJTBlPjc2VA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=PIxZNzZd; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Z3DRnJt/taPDBXbjabnD73W8w7kKOKkOX1shpXCQdTo=; b=PIxZNzZd9T1vvpp/gtRqGTs/eU
	KsUUAgnZHIT55HGCDU3bddRpbaezYw7FN7NE0eyh9qYEVhW/1c9Kt63WWdyl/RLP8xljWyT3UVdTm
	xgFMBc/YVeSB4v/g9mBu1v46VWtX/Yz5oWniCO7QCMRIksTNaE8akDllG8ptfkxYEWdu0/v0H43cE
	fMN6JUh+eLa8v6dFq9jWq4g1bfqXtdr1pY34z30aseIO57/+Kwd8Ge12tOA3W+lNIYSd1bcV9H12K
	OC0K4XAaoifd252YuguZl68xstOQOGHl9NqLVgvFc1cQO4LNSwv8d9YwbR5t09WiMXQYJv86enM/b
	fdGVozDw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:46520)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vcovX-000000008Ee-39SM;
	Mon, 05 Jan 2026 18:03:35 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vcovT-0000000083S-1TJx;
	Mon, 05 Jan 2026 18:03:31 +0000
Date: Mon, 5 Jan 2026 18:03:31 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Michael Chan <michael.chan@broadcom.com>
Cc: Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Breno Leitao <leitao@debian.org>,
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
Message-ID: <aVv885DfEfngQuZJ@shell.armlinux.org.uk>
References: <20260105-bnxt-v2-1-9ac69edef726@debian.org>
 <aVu8xIfFrIIFqR0P@shell.armlinux.org.uk>
 <CALs4sv0s-cJqyK3Gn9X95o82==e8zGcaEeuLHns3VPJCo7v6rw@mail.gmail.com>
 <CACKFLi=WycRNcVu4xcxRE2X3_F=gRsWd+-Rr8k1M4P_k-6VwZg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACKFLi=WycRNcVu4xcxRE2X3_F=gRsWd+-Rr8k1M4P_k-6VwZg@mail.gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, Jan 05, 2026 at 09:40:03AM -0800, Michael Chan wrote:
> On Mon, Jan 5, 2026 at 7:51 AM Pavan Chebbi <pavan.chebbi@broadcom.com> wrote:
> >
> > On Mon, Jan 5, 2026 at 6:59 PM Russell King (Oracle)
> > <linux@armlinux.org.uk> wrote:
> > >
> 
> > > Second, __bnxt_hwrm_ptp_qcfg() calls bnxt_ptp_clear() if
> > > bp->hwrm_spec_code < 0x10801 || !BNXT_CHIP_P5_PLUS(bp) is true or
> > > hwrm_req_init() fails. Is it really possible that we have the PTP
> > > clock registered when PTP isn't supported?
> >
> > Right, this check may not make much sense because we call
> > __bnxt_hwrm_ptp_qcfg() only after we know PTP is supported.
> > Michael may tell better but I think we could improve by removing that check.
> >
> 
> Some older FW may advertise support for PTP using an older scheme that
> the driver does not support.  The FW running on an older class of
> chips may also advertise support for PTP and it's also not supported
> by the driver.  In the former case, if FW is downgraded, the test may
> become true.

I'd like to restate my question, as it is the crux of the issue: as
the PTP clock remains registered during the firmware change,
userspace can interact with that device in every way possible.

If the firmware is in the process of being changed, and e.g.
bnxt_ptp_enable() were to be called by way of userspace interacting
with the PTP clock, we have already established that bnxt_ptp_enable()
will talk to the firmware - but what happens if bnxt_ptp_enable()
attempts to while the firmware is being changed? Is this safe?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

