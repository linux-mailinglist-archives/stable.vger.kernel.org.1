Return-Path: <stable+bounces-160230-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 034FFAF9C40
	for <lists+stable@lfdr.de>; Sat,  5 Jul 2025 00:08:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8EE7A1C87046
	for <lists+stable@lfdr.de>; Fri,  4 Jul 2025 22:08:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC28628937F;
	Fri,  4 Jul 2025 22:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mareichelt.com header.i=@mareichelt.com header.b="HZZAfPWx"
X-Original-To: stable@vger.kernel.org
Received: from antaris-organics.com (mail.antaris-organics.com [91.227.220.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4117289379;
	Fri,  4 Jul 2025 22:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.227.220.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751666902; cv=none; b=vAf8RRzbDUjZO9x1JuLqc3Mp85pFpKJHnMIDdcATOMz3Ij9y9xjWfguP0xkxi756m7o6S++Cl3Vnb74oBt9Nt2F8e3sguW+f4DbnvsHR8Ki4L0kYRDf769K3/4N10OhN7iHK5yXaYywHTdXIjaunOJ5nZ1QgSEP3ahVlmo49xnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751666902; c=relaxed/simple;
	bh=jgufuOdJL8p5gukIbwKyLhiiTnvh4r3xS+pRM81NgX0=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bCZJjMyBSwva1XvOiNo4ilzfVlAnMkU3qWsReLi/w7Wr8MvuvqP3ShOWWYsAnTmUtX+7NJVxenKSeTd0TLycFm9/Vd4Yry1MHw1SRM9HQOOqSas/3MFucsGIrJVt9g9mzzulw44gdHDagecDl6shHC/u/d6BTNoM6cHX8fymajs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mareichelt.com; spf=pass smtp.mailfrom=mareichelt.com; dkim=pass (2048-bit key) header.d=mareichelt.com header.i=@mareichelt.com header.b=HZZAfPWx; arc=none smtp.client-ip=91.227.220.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mareichelt.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mareichelt.com
Date: Sat, 5 Jul 2025 00:08:18 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mareichelt.com;
	s=202107; t=1751666899;
	bh=jgufuOdJL8p5gukIbwKyLhiiTnvh4r3xS+pRM81NgX0=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:In-Reply-To:Cc:Cc:content-type:content-type:date:date:
	 From:from:in-reply-to:in-reply-to:message-id:mime-version:
	 mime-version:references:reply-to:Sender:Subject:Subject:To:To;
	b=HZZAfPWxqH5Y1MxmwYizFgeKLyx39oseJorzdUt/XhkeC+u/rWU93HLttLJADHmhN
	 LVzECSPy3nRkxDbJQSjWT22ZbrEpGgAcugxSVopFg/Ywiapvfz88vIpml8j03phIN2
	 ihYUN1nK+spAGaodgWOM5unZN3KZjFKOntW1E/3jMo6T8kbiFm691AWKED6pnnws4t
	 merE359CRDfewhoOqIw0rDl9cqo2RDt0IhI0aG48CEc3Ue5muUwRrqeOuiiCYqZg1s
	 QkzBC/0cvSyW0Zwce+kQmvK6Oiao9LaLPLaCoJ/RZ7QKwka15J9VTdOp93a3fBoWZH
	 LkAlIq6OrWOlQ==
From: Markus Reichelt <lkt+2023@mareichelt.com>
To: stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6.15 000/263] 6.15.5-rc2 review
Message-ID: <20250704220818.GB3473@pc21.mareichelt.com>
Mail-Followup-To: stable@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250704125604.759558342@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250704125604.759558342@linuxfoundation.org>

* Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

> This is the start of the stable review cycle for the 6.15.5 release.
> There are 263 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Hi Greg

6.15.5-rc2 compiles on x86_64 (Xeon E5-1620 v2, Slackware64-15.0),
and boots on x86_64 (AMD Ryzen 5 7520U, Slackware64-current),
no dmesg regressions observed.

The difference in /sys/class/backlight/amdgpu_bl0/brightness value
compaired to kernel 6.15.4 and reported for -rc1 is still present.
Changing brightness with function keys in X works as before.

Not a problem, just a heads up for those of us who like to keep their
scripts simple.

Tested-by: Markus Reichelt <lkt+2023@mareichelt.com>

