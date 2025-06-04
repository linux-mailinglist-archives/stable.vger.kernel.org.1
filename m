Return-Path: <stable+bounces-151327-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6543EACDBED
	for <lists+stable@lfdr.de>; Wed,  4 Jun 2025 12:24:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9A9E1896F2A
	for <lists+stable@lfdr.de>; Wed,  4 Jun 2025 10:24:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 431F2247296;
	Wed,  4 Jun 2025 10:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="bLphLywA"
X-Original-To: stable@vger.kernel.org
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC755227574
	for <stable@vger.kernel.org>; Wed,  4 Jun 2025 10:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749032639; cv=none; b=uDnHcy2Q7IO0N8dNnqwT5OJfD3D4YRIfyoVAYdqc7upUC0r4Ics3dMd6+cAs7fuyQR1w05mjHz6ABwDhV1E7KJkwuCHDXn7KWoR9wif5yZS1nb2UNPa5aq+ZD3L1HF46QlAlLNyi1T9gb/cFSOWf/HpWgeUuWfDnIR+7hCQK3S0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749032639; c=relaxed/simple;
	bh=SiphSZlORfIR4dqiQQIm8GWuk89uFo2wCK55QMraYjQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bZGH7d1NJ4Z4UwcL4hdmrqRy3QMx6Nkt4x258lmv+lj4mcvDTd8MX8wDoiXCVWUeWYJXsKpP5fzzytKetHHWBQa74sE9ys0iPunf6GSCaZcOv7APTPjjm6aG6DZ/ltg6+eeJMJOHJL5ZgecWLU0MNAlwBu3lpqTKIO/kKNUJ0W4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=bLphLywA; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id E6ABE2321F;
	Wed,  4 Jun 2025 12:23:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1749032634;
	bh=tB+3BxLKwyiK9NwRxEKR/77hUyD88iZH/NPId60pNEw=; h=From:To:Subject;
	b=bLphLywAtT1zcDkkUG8mNPPRZHOvdDk1R4Z8uylgiWNeR7V7W2mEM8a6wr/8kWBnv
	 Q330rWkyste8xgEOHlSTyFjp+eJsvc0LSv8KHCCgXoghS0rWXciX6WdwKA41aCA14E
	 YRDRoO1HL3p9iiYF8mCTAzgq6T57EhVVOyg7Vq/SCoKYVxWP39KW+NEZ6cUsKRFPSn
	 hOUj7K7IMlWFfkSkQZpf6H9H0R+obwiQ9fMDWiEnApBtyfatf509aDrozFyHEU6sqs
	 aDjqORRFgqWu8A/oGMWnqY6/JlrzV3dScIVNMQWMBk1eODHoGssW10p3tvQNmKfZYf
	 Kce3G0LtMXwKw==
Date: Wed, 4 Jun 2025 12:23:52 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Francesco Dolcini <francesco@dolcini.it>,
	Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org,
	patches@lists.linux.dev, Jeff Chen <jeff.chen_1@nxp.com>,
	Francesco Dolcini <francesco.dolcini@toradex.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Vitor Soares <ivitro@gmail.com>
Subject: Re: [PATCH 6.12 130/626] wifi: mwifiex: Fix HT40 bandwidth issue.
Message-ID: <20250604102352.GB31115@francesco-nb>
References: <20250527162445.028718347@linuxfoundation.org>
 <20250527162450.311998747@linuxfoundation.org>
 <20250603203337.GA109929@francesco-nb>
 <2025060408-concur-bubbly-04ea@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2025060408-concur-bubbly-04ea@gregkh>

On Wed, Jun 04, 2025 at 10:39:09AM +0200, Greg Kroah-Hartman wrote:
> On Tue, Jun 03, 2025 at 10:33:54PM +0200, Francesco Dolcini wrote:
> > Hello Greg, Sasha
> > 
> > On Tue, May 27, 2025 at 06:20:23PM +0200, Greg Kroah-Hartman wrote:
> > > 6.12-stable review patch.  If anyone has any objections, please let me know.
> > > 
> > > ------------------
> > > 
> > > From: Jeff Chen <jeff.chen_1@nxp.com>
> > > 
> > > [ Upstream commit 4fcfcbe457349267fe048524078e8970807c1a5b ]
> > > 
> > > This patch addresses an issue where, despite the AP supporting 40MHz
> > > bandwidth, the connection was limited to 20MHz. Without this fix,
> > > even if the access point supports 40MHz, the bandwidth after
> > > connection remains at 20MHz. This issue is not a regression.
> > > 
> > > Signed-off-by: Jeff Chen <jeff.chen_1@nxp.com>
> > > Reviewed-by: Francesco Dolcini <francesco.dolcini@toradex.com>
> > > Link: https://patch.msgid.link/20250314094238.2097341-1-jeff.chen_1@nxp.com
> > > Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> > > Signed-off-by: Sasha Levin <sashal@kernel.org>
> > 
> > Can you please drop this patch from any additional stable kernel update?
> > It seems that on 6.12.y it introduced a regression, we are currently
> > investigating it and we'll eventually send a revert for 6.12.y.
> 
> This is already in the following released kernels:
> 	6.12.31 6.14.9 6.15
> I'll be glad to queue up the revert when it hits Linus's tree.  Is that
> planned anytime soon?

mainline is not affected, the issues seems specific of the backport on
6.12 (6.14 not tested yet), therefore I do not expect any revert in
Linus tree.

I am looking into the details now, to be sure about my finding, I'll
confirm you in the next few days.

If you prefer to not wait, given that this fix was just improving the
performance of a specific use case, you can just revert from 6.12.y and
6.14.y.

Francesco



