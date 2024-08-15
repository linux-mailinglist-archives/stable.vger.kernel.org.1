Return-Path: <stable+bounces-69231-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C87A5953A2D
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 20:34:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7ECF5281588
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 18:34:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AB5752F70;
	Thu, 15 Aug 2024 18:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mareichelt.com header.i=@mareichelt.com header.b="5ZHdrUVy"
X-Original-To: stable@vger.kernel.org
Received: from mail.antaris-organics.com (mail.antaris-organics.com [91.227.220.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42D09383A3;
	Thu, 15 Aug 2024 18:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.227.220.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723746893; cv=none; b=ijEMGACleMEMLxaIW1u3Prku7gHA+ZqQNMQQ+RO9pItTGUO0yYsF5OoewO7Wdt7cx4m7fj9PczXEP+8NEYgEVO/Qgvl8JBw45/79MXh74dAPhHEHgkU8qxxx0WgXF7JcYqzgL5SoMw0Qyp2la5bMNLnYnSI6dyw6yWzrj6bmoUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723746893; c=relaxed/simple;
	bh=xLnJMUPm2aYBrTTcAEmd/1AjrG7nIACiu9DwvTR9ocA=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rO+hsxeYgQ3vHy++0BYzgdfH1sAh5gC3a3QQUUhNf8MRPHn6WOxqbfh1k4g3XeZPKvhc7S/oBcpo/CRF4Sa2F+lYSggr2/ct6R2RJqXu4Duyq+CWpt0JUyZyQhHJxSq0XGVCmywjau5qRW6h8n7VRnOONSti0Z9SS9opVcKPrvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mareichelt.com; spf=pass smtp.mailfrom=mareichelt.com; dkim=pass (2048-bit key) header.d=mareichelt.com header.i=@mareichelt.com header.b=5ZHdrUVy; arc=none smtp.client-ip=91.227.220.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mareichelt.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mareichelt.com
Date: Thu, 15 Aug 2024 20:34:41 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mareichelt.com;
	s=202107; t=1723746883;
	bh=xLnJMUPm2aYBrTTcAEmd/1AjrG7nIACiu9DwvTR9ocA=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:In-Reply-To:Cc:Cc:content-type:content-type:date:date:
	 From:from:in-reply-to:in-reply-to:message-id:mime-version:
	 references:reply-to:Sender:Subject:Subject:To:To;
	b=5ZHdrUVydthB2a5OjGdMWBqYCQaoBiCmhcAJBUKMV4P7xIUjgQLMQoJAerzDBx2h+
	 jy0RB5uZmCdmmcv497I2lALIUAJvnGOJ5fAmMitFB3DN3h2uh0UvTcIWoruSWBkEs0
	 mvJOimilZZsd085CCKjSDA4jiZOpIlO6UdOaqljCTbEUJLecbCA8Rm0cLxPI/MVo8+
	 Qglvcn4hvBKdCzzqQYAYycX8rEnk42bC2caDDBlmB7hljOcuHa6bFiu95pnqU1XdD3
	 MdVSP+zvR1sHUX48p69RQFlgP5aPtdI8RsQw1XEaL0IxqYZ00lbsw30zCcNCYepncV
	 SJBRRRYrqnimw==
From: Markus Reichelt <lkt+2023@mareichelt.com>
To: stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6.10 00/22] 6.10.6-rc1 review
Message-ID: <20240815183441.GB5407@pc21.mareichelt.com>
Mail-Followup-To: stable@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240815131831.265729493@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240815131831.265729493@linuxfoundation.org>

* Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

> This is the start of the stable review cycle for the 6.10.6 release.
> There are 22 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 17 Aug 2024 13:18:17 +0000.
> Anything received after that time might be too late.

Hi Greg

6.10.6-rc1 compiles, boots and runs here on x86_64
(AMD Ryzen 5 PRO 4650G, Slackware64-15.0)

Tested-by: Markus Reichelt <lkt+2023@mareichelt.com>

