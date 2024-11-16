Return-Path: <stable+bounces-93661-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CD2C9D00DA
	for <lists+stable@lfdr.de>; Sat, 16 Nov 2024 22:00:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 208B41F2200E
	for <lists+stable@lfdr.de>; Sat, 16 Nov 2024 21:00:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2759194C78;
	Sat, 16 Nov 2024 21:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mareichelt.com header.i=@mareichelt.com header.b="vb2UMbQ5"
X-Original-To: stable@vger.kernel.org
Received: from antaris-organics.com (mail.antaris-organics.com [91.227.220.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A65CF9D6;
	Sat, 16 Nov 2024 21:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.227.220.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731790853; cv=none; b=VPZ+GZpXSrkuEe9SPI1jXyI9p8NF+VPadGzJAEkTwisoim9KKL1UUgJ6T08poi/+vuzKnIhJ0xDonjuJLplPIi2PUo9QdyGzTfjvT0VVRWslSvjmpy7S8CrXJQoXGstqliYvfFr7gekcacCgFxBlHR5cYx8P2IHS0w9seeKB0So=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731790853; c=relaxed/simple;
	bh=WzakFJXs+NS+x+hjvrnbDOQhH61BsA++JfbpchfcMUM=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IkHDj0fc5zHLIM3XTuhA/Ebop9Ij0oIao/fZXlwjwwY08O/1t7unXeQTiwStKTUpR6U26nYsGsTCLnuL02eSh+7YebIiGCce9WrCnLDGAmnYNaNzxyPJGsHc2NGP2lFQRwC1/01dciUlOgTwl9o44ucSgSA6tpU62ZHVfH8YBrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mareichelt.com; spf=pass smtp.mailfrom=mareichelt.com; dkim=pass (2048-bit key) header.d=mareichelt.com header.i=@mareichelt.com header.b=vb2UMbQ5; arc=none smtp.client-ip=91.227.220.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mareichelt.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mareichelt.com
Date: Sat, 16 Nov 2024 21:52:03 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mareichelt.com;
	s=202107; t=1731790324;
	bh=WzakFJXs+NS+x+hjvrnbDOQhH61BsA++JfbpchfcMUM=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:In-Reply-To:Cc:Cc:content-type:content-type:date:date:
	 From:from:in-reply-to:in-reply-to:message-id:mime-version:
	 references:reply-to:Sender:Subject:Subject:To:To;
	b=vb2UMbQ5LdkmDxd6eRJxvjqfB74M9GNR5k6MJdFH8HwGuW8AZfGjSlit6a4zZREsO
	 AqV7eIBv/eXtRwo7wFQMsnuPbYUMWQEQV6CX0DbbhFCJ34cfkZsZML5I162ThlEj3t
	 QRE4W+zPd7O754+j24kFQqh6UbNoyjHUbjA211lSt+tlHJ4QBxmIzvSRJ+S6Gw97z5
	 zlTHiAWozbqbBTh3IWVoPjsI+RgrNizOu5GFPhnV/f9ZoJPdSavc7K3IxM2IcdFa0h
	 sH++vLAn7EJxsqbYqPGNwLwLyz8QIjuqZYEnTMU30M5uMEZL1Fi8QSy029UbPhCyxi
	 5zqQtmakOL/eQ==
From: Markus Reichelt <lkt+2023@mareichelt.com>
To: stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6.11 00/63] 6.11.9-rc1 review
Message-ID: <20241116205203.GB20613@pc21.mareichelt.com>
Mail-Followup-To: stable@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241115063725.892410236@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241115063725.892410236@linuxfoundation.org>

* Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

> This is the start of the stable review cycle for the 6.11.9 release.
> There are 63 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 17 Nov 2024 06:37:07 +0000.
> Anything received after that time might be too late.

Hi Greg

6.11.9-rc1 compiles, boots and runs here on x86_64
(AMD Ryzen 5 PRO 4650G, Slackware64-15.0)

Tested-by: Markus Reichelt <lkt+2023@mareichelt.com>

