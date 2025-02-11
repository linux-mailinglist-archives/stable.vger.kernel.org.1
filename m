Return-Path: <stable+bounces-114923-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EB85FA30EF3
	for <lists+stable@lfdr.de>; Tue, 11 Feb 2025 16:00:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 225FC18808AA
	for <lists+stable@lfdr.de>; Tue, 11 Feb 2025 15:00:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 669B42512F4;
	Tue, 11 Feb 2025 15:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l0tjqBCM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18F482512E6;
	Tue, 11 Feb 2025 15:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739286018; cv=none; b=P/ZSdd/dEQFhdb5hRfXh2rA+vK8uAPiApK8IlPdpHfmJ8bOuhVuWgCE2utr1vcfMKYWwAd43vHamSkAhwbBPn3egYwOEVk28ZToNBKozHbMvDuz5fj4VEn0Mq7zRz/O1IxMWgkXlqqnwLQ9QFH+LyzcX5qBDsNXcUxMrqfgubDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739286018; c=relaxed/simple;
	bh=rPx6e3rjAxYC/HroN2shrjx4e10EBihJTuDSf4dHVvI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qI6zlDXJIZLldWYoAe8en2mtM0I2/AGKddG9luG7LZeFtKtAex7kMJvle0cBOegUJiXcQmoa9FDjLolp3gX5ZPNrogCOlwmFjF+wR6+GMsQymqSzi2XrkvX+cvT5izegDuioMCGf5ovRaB1M3AC/yYksj/uRTglS5baaaS9OwIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l0tjqBCM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F057C4CEE7;
	Tue, 11 Feb 2025 15:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739286016;
	bh=rPx6e3rjAxYC/HroN2shrjx4e10EBihJTuDSf4dHVvI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=l0tjqBCMxl1NSd10HHnWeAWbJ2zbbymTdIidenqqyQdSXESD7/Nm/yJG3rYwQfe4J
	 ciF9n+jvVm3nbE9Pg4y3gOFFKSR3Sn2OiJRFp1TtDJ0VXrWOfO1e5NoRI1qel0ze6I
	 gpkue7ofmVI/R9WRqO78TBtojUbzogEqobOwQlxq+S5gEKlBJddtxx1dtSTs5fjmXq
	 qAuhj+vb2ACed2r+Hte4CKyVby06Pp41j85C1pSocFiuUTENoqC3oqEXDW0bcJqBz6
	 JMNliCKJWsYeYFj04mEl/ACC6hpv1H5Ts1eVOvVo3AK1kaWRTn6JI5JKAftXPiXAox
	 cI2Jf871ZVNxw==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1thrkO-000000000WE-02qQ;
	Tue, 11 Feb 2025 16:00:24 +0100
Date: Tue, 11 Feb 2025 16:00:24 +0100
From: Johan Hovold <johan@kernel.org>
To: Daniele Palmas <dnlplm@gmail.com>,
	Fabio Porcedda <fabio.porcedda@gmail.com>
Cc: Oliver Neukum <oliver@neukum.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	=?utf-8?B?QmrDuHJu?= Mork <bjorn@mork.no>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org, netdev@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 1/5] USB: serial: option: add Telit Cinterion FN990B
 compositions
Message-ID: <Z6tmCDCsJVtF_C78@hovoldconsulting.com>
References: <20250205171649.618162-1-fabio.porcedda@gmail.com>
 <20250205171649.618162-2-fabio.porcedda@gmail.com>
 <CAGRyCJFE3Gzs+tBrKA+PjXgmFfmZ9=6eOrr4VS6JMCsAPi8F-w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGRyCJFE3Gzs+tBrKA+PjXgmFfmZ9=6eOrr4VS6JMCsAPi8F-w@mail.gmail.com>

On Sat, Feb 08, 2025 at 09:29:11PM +0100, Daniele Palmas wrote:
> Il giorno mer 5 feb 2025 alle ore 18:16 Fabio Porcedda
> <fabio.porcedda@gmail.com> ha scritto:
> >
> Add the following Telit Cinterion FN990B40 compositions:

> > Cc: stable@vger.kernel.org
> > Signed-off-by: Fabio Porcedda <fabio.porcedda@gmail.com>
> 
> Reviewed-by: Daniele Palmas <dnlplm@gmail.com>

Thanks for the patches and for reviewing. Both USB serial patches now
applied.

Johan

