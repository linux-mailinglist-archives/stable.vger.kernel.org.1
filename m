Return-Path: <stable+bounces-206099-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AB665CFC32D
	for <lists+stable@lfdr.de>; Wed, 07 Jan 2026 07:41:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9CDED3015EF6
	for <lists+stable@lfdr.de>; Wed,  7 Jan 2026 06:41:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00928259C84;
	Wed,  7 Jan 2026 06:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XptrqtAR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B26B424A044
	for <stable@vger.kernel.org>; Wed,  7 Jan 2026 06:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767768075; cv=none; b=GtBooxucDxY8+SNn1X2PzJRbaXqguSMMQuHiLfJSvgQQd7lB9D4qzcRs2IdOjKrsP3piW9Nizbb2LvRwUPHBot4LPvfd8vz8ifiS6xrPzLSvbA0vCh16lh/p5pC7JcQoZ1ig2ll4BILmEYQL2MrVGyTBBhMoIu05lqKfCIdUayE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767768075; c=relaxed/simple;
	bh=3owhpC0x4f1U3cnWCMz2J1vOh/VWBFpcgFwqT8gkENs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uVrNY/QOZ6ZSMzrVcVqKIyALUHMjJ7i0dHyZRL3nJ5fZDMKkQhkq5YWg/rF5bBaLJXgzgzpbSr1YcitjOFkxGOvFFRMlpJtcAzOWwP2KvRXOKo6/mKnjLjC822hkYExrP+YsVHmqVNX02ZbRm0hFbC2PQ2+qT7Rgn3d3s8OLs+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XptrqtAR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4D15C4CEF7;
	Wed,  7 Jan 2026 06:41:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767768073;
	bh=3owhpC0x4f1U3cnWCMz2J1vOh/VWBFpcgFwqT8gkENs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XptrqtARqbsA4SWg5d4x0aL0+jmkiDcH2a9L1ShwSCycG5xyAtrazq/tvQaVnbEx+
	 AqMwARquyJHLcGmBdzIqcGyBWoPPIunJL0rvereYk8t5QQW6q9WxmqrU5oIk8fO3HT
	 bLUzRbGdCWS13ss+/5ACvpWmokV1bN9vLi6idmTs=
Date: Wed, 7 Jan 2026 07:41:10 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: JP Dehollain <jpdehollain@gmail.com>
Cc: stable@vger.kernel.org
Subject: Re: Fwd: Request to add mainline merged patch to stable kernels
Message-ID: <2026010748-seventeen-daylight-2568@gregkh>
References: <CAH1aAjJkf0iDxNPwPqXBUN2Bj7+KaRXCFxUOYx9yrrt2DCeE_g@mail.gmail.com>
 <2025122303-widget-treachery-89d6@gregkh>
 <ME6PR01MB1055749AAAC6F2982C0718687AAB5A@ME6PR01MB10557.ausprd01.prod.outlook.com>
 <CAH1aAjJjxq-A2Oc_-7sQm6MzUDmBPcw5yycD1=8ey1gEr7YaxQ@mail.gmail.com>
 <2026010604-craftsman-uniformed-029c@gregkh>
 <CAH1aAj+myyuXniX9JAo5fQzHUyqtrGobhNPizc-Of8=OPgOAjw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAH1aAj+myyuXniX9JAo5fQzHUyqtrGobhNPizc-Of8=OPgOAjw@mail.gmail.com>

On Wed, Jan 07, 2026 at 04:43:42PM +1100, JP Dehollain wrote:
> Apologies greg, I just realised that there is a prior commit
> 587d1c3c2550abd5592e1f0dc0030538c9ed9216 that needs to be merged
> before the 807221d can pass the build.

Great, please submit a patch series of this, that are properly tested,
so we know exactly what to do here.

thanks,

greg k-h

