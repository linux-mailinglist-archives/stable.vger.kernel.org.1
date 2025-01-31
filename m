Return-Path: <stable+bounces-111833-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D9FF2A23FB6
	for <lists+stable@lfdr.de>; Fri, 31 Jan 2025 16:35:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7315A1887854
	for <lists+stable@lfdr.de>; Fri, 31 Jan 2025 15:35:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCD901DED4F;
	Fri, 31 Jan 2025 15:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mareichelt.com header.i=@mareichelt.com header.b="ldAj8I0+"
X-Original-To: stable@vger.kernel.org
Received: from antaris-organics.com (mail.antaris-organics.com [91.227.220.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 148B01DEFD2;
	Fri, 31 Jan 2025 15:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.227.220.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738337715; cv=none; b=Gkz3oFeOzQ1TSbPccvTTm1Ukqa0bc2SRVOY8JOYpYQs1VxUazPBEv7qHWVDRYe5hNeIaYLkV9yT6Zj4ANfW1zGXuMJ1sPJ+ki4m0EQz6/SCh/A1QQIe+n9czg6TnQxa6wwp++NbJUPdjO22b3Yq1H0ex+fBhzrnuiRVc+MMPl/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738337715; c=relaxed/simple;
	bh=E5WFl6tLt5eIgf9l1SSzcWM1S6noYXz0q3eIMLmoCwk=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NgTDWMgfsbP2WfHzHHUUpI0kvYYyg/XBUJsO0BpmIu8tQKDnuBCgnzmzND4FUXlK2kl9K/ccf8Q795HG53zoKQz+GQH2wM9N+rm7UYWsVqioQT3kje0J0jwXO5f5SaKKZNLzb+gfbp/LAa+Y6neXgZu4drjOno/WAu/p6PMFFLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mareichelt.com; spf=pass smtp.mailfrom=mareichelt.com; dkim=pass (2048-bit key) header.d=mareichelt.com header.i=@mareichelt.com header.b=ldAj8I0+; arc=none smtp.client-ip=91.227.220.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mareichelt.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mareichelt.com
Date: Fri, 31 Jan 2025 16:26:06 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mareichelt.com;
	s=202107; t=1738337167;
	bh=E5WFl6tLt5eIgf9l1SSzcWM1S6noYXz0q3eIMLmoCwk=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:In-Reply-To:Cc:Cc:content-type:content-type:date:date:
	 From:from:in-reply-to:in-reply-to:message-id:mime-version:
	 mime-version:references:reply-to:Sender:Subject:Subject:To:To;
	b=ldAj8I0+g2sxCahwb5SGvqPpjFXHeHcUSF16TH/pqXwTYW/3uC0R8310D/Xad0u3Z
	 VHLHm9mYHcLhNm8SQCgmKSNndhJIJ/16wg5htEoEj19NzIpMcP13kDG2d2SvZDMqao
	 Kc/AoBDjsgI6IfFlLiT28AMSqTS3E2f4swIqhI+funn4Uw6TbN7U9IlbZqv6GYt95w
	 Yy2sqvKLrM9mpmKa8oHtJNVE/mEz7udvuoYWzGCsVmlXEr9sJn7WxrjT5dBhzMAy9F
	 4hwsf7mLTOOp5tBcSUNtiMas1uXbLy9bT02zFWENqn0mEJqwC7m89O8xhF7dOK+YI1
	 GfHq8Z6unSVCA==
From: Markus Reichelt <lkt+2023@mareichelt.com>
To: stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6.12 00/41] 6.12.12-rc2 review
Message-ID: <20250131152606.GA2644@pc21.mareichelt.com>
Mail-Followup-To: stable@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250130144136.126780286@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250130144136.126780286@linuxfoundation.org>

* Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

> This is the start of the stable review cycle for the 6.12.12 release.
> There are 41 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 01 Feb 2025 14:41:19 +0000.
> Anything received after that time might be too late.

Hi Greg

6.12.12-rc2 compiles, boots and runs here for on x86_64 (AMD Ryzen 5 7520U,
Slackware64-current) for 1h, no regressions observed.

Tested-by: Markus Reichelt <lkt+2023@mareichelt.com>

