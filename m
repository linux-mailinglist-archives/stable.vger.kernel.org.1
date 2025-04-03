Return-Path: <stable+bounces-127714-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B4B8AA7A9A5
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 20:41:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D59B1689B6
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 18:40:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7D66252906;
	Thu,  3 Apr 2025 18:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mareichelt.com header.i=@mareichelt.com header.b="Sdn2T283"
X-Original-To: stable@vger.kernel.org
Received: from antaris-organics.com (mail.antaris-organics.com [91.227.220.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D41D5250C06;
	Thu,  3 Apr 2025 18:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.227.220.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743705613; cv=none; b=V55IrD9tEd49ph7crFG8Uai6ubGsTf78GnDHPJnG7ihhDveNCqvEhMzZvd5jjoM4jqziWcroj3/3zz6nqAaj88ZFd2fPe4RU9NIdDjrkTvi+O5nUVlw6JUrivBmZV0XzvTuEUMmdtUyBoAEcxiPYC1otajnybrF68bBoG+lreyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743705613; c=relaxed/simple;
	bh=+c0lpL2GrWHDQBfqc/VRwWnEKjdbCVX9Kn9CXF/WVGU=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tB1EkPOm9cI8X0dtKmP2hen23KdJzQE48Ci+06MZuGsOpkup1DF11i2jNsnGgpADhzJ6XkawdKZ86CAhNUFb7gEQ2H4rZAH0wUVfIYssu79xIYeDYYdwm3TnGMni08JIkLqJJ5QBl1skU36jjojCEnN3ITxAwB3WCaHiliW1IxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mareichelt.com; spf=pass smtp.mailfrom=mareichelt.com; dkim=pass (2048-bit key) header.d=mareichelt.com header.i=@mareichelt.com header.b=Sdn2T283; arc=none smtp.client-ip=91.227.220.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mareichelt.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mareichelt.com
Date: Thu, 3 Apr 2025 20:32:06 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mareichelt.com;
	s=202107; t=1743705128;
	bh=+c0lpL2GrWHDQBfqc/VRwWnEKjdbCVX9Kn9CXF/WVGU=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:In-Reply-To:Cc:content-type:date:From:from:
	 in-reply-to:message-id:mime-version:references:reply-to:Sender:
	 Subject:To;
	b=Sdn2T283kHVUaY1Yy7sxXznBvMhyy48T8Dp2f0SpMDnsuZuT2DyDQb0dA4bFycH41
	 TWIDKVInsPMjj9C5zZZGucLM4eTQ+FdyeVCAYh0xSnzEokDF3kqVoQ6O7bnPplxN8z
	 T/bDe5dZATcELGtECSRtEh2SuMHq8AGDjj1pdJiu4nZN13cKsnMCTwtIE27XIqSc2B
	 4Ryo2TKKl9dOAS6ubc64xIuZX7MJews2Myi78neIVCnqH1czBaF9O7dSe4UiXFIu5j
	 jvAlnY2Tz6ob5aUAmMPb4aIazsPq4f4wuGoWIm21de32vFrvDWvxyq0QV1eVmTPExc
	 DY4yNesC59pnA==
From: Markus Reichelt <lkt+2023@mareichelt.com>
To: stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6.12 00/22] 6.12.22-rc1 review
Message-ID: <20250403183206.GA30960@pc21.mareichelt.com>
Mail-Followup-To: stable@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250403151622.055059925@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250403151622.055059925@linuxfoundation.org>

* Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

> This is the start of the stable review cycle for the 6.12.22 release.
> There are 22 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 05 Apr 2025 15:16:11 +0000.
> Anything received after that time might be too late.

Hi Greg

6.12.22-rc1 compiles, boots and runs here on x86_64 (AMD Ryzen 5 7520U,
Slackware64-current), no regressions observed.

Tested-by: Markus Reichelt <lkt+2023@mareichelt.com>

