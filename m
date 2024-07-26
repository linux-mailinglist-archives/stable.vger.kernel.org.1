Return-Path: <stable+bounces-61923-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 17D7A93D85C
	for <lists+stable@lfdr.de>; Fri, 26 Jul 2024 20:30:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C17FA1F231FE
	for <lists+stable@lfdr.de>; Fri, 26 Jul 2024 18:30:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A546E44C6C;
	Fri, 26 Jul 2024 18:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mareichelt.com header.i=@mareichelt.com header.b="ZfQyyCGf"
X-Original-To: stable@vger.kernel.org
Received: from mail.antaris-organics.com (mail.antaris-organics.com [91.227.220.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFE5338DEE;
	Fri, 26 Jul 2024 18:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.227.220.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722018597; cv=none; b=nq5Mbv/GCygkO6BZdbB26gZRL6kmGcvF8fGajWIS1tYZPebpmipHLP90AqvfRob5Id1S5Nwffy5fOpPvt1nxnxhcmg7DyLmp12Ey4kO+pTVwJkMdwHEMFmm0hFek+yUt73YNJ8mzqhlYOrnkJFnD0pU3JTSA9EDWlMYKOfXcX+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722018597; c=relaxed/simple;
	bh=noGuPNfQaGEU13/HvPPCrfRMjaffsxi/zW1JNynpBI4=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V/Rh8enaTj4pFjdGwi4mi26r674oh588p1TKGYpmIr3CrnFsliZQ20C+0qKS3L4hxAblplQSu2/wUQ+ftqouaDlulgaAOYIbaKgExMF7PGQ1j/e/wtVUHFdREO+EjaWIUtKl780aVGvl1wDZymiC1uf6cCMEwOolpCpYhrHHams=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mareichelt.com; spf=pass smtp.mailfrom=mareichelt.com; dkim=pass (2048-bit key) header.d=mareichelt.com header.i=@mareichelt.com header.b=ZfQyyCGf; arc=none smtp.client-ip=91.227.220.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mareichelt.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mareichelt.com
Date: Fri, 26 Jul 2024 20:29:53 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mareichelt.com;
	s=202107; t=1722018594;
	bh=noGuPNfQaGEU13/HvPPCrfRMjaffsxi/zW1JNynpBI4=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:In-Reply-To:Cc:Cc:content-type:content-type:date:date:
	 From:from:in-reply-to:in-reply-to:message-id:mime-version:
	 references:reply-to:Sender:Subject:Subject:To:To;
	b=ZfQyyCGf/eGJvx6FRObDd3nG8+CbjjIA9S+kaGFwybEWF7o/9wE4kuHANpyBGj2u5
	 IcsNQ9TCY9o+q50k9BeVejWP032kOWxBkI3twXZz/HmWLZdHFJwRPltaeJPcBtQXSo
	 JcckYn5Vw0HPuh/CcG36NraSL8/N/Fe1okyWI9IcQe6+T+eklrd2uunY8gV1yOsWAU
	 oifXif/c4ftWjiHCCSroWmERbhmF1EDhfyjodR3jSa7Bo9yc6iMB6FrcYYzmsW8xjY
	 Rx6+4OgYdJoE3mi/F5EwV3LcnYS1TlIbtLmDNUgr0lTvEbzBRNP/a5i40gvuRj0Axn
	 omwuzXm/vlyFA==
From: Markus Reichelt <lkt+2023@mareichelt.com>
To: stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6.10 00/29] 6.10.2-rc1 review
Message-ID: <20240726182953.GB3587@pc21.mareichelt.com>
Mail-Followup-To: stable@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240725142731.814288796@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240725142731.814288796@linuxfoundation.org>

* Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

> This is the start of the stable review cycle for the 6.10.2 release.
> There are 29 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 27 Jul 2024 14:27:16 +0000.
> Anything received after that time might be too late.

Hi Greg

6.10.2-rc1 compiles, boots and runs here on x86_64
(AMD Ryzen 5 PRO 4650G, Slackware64-15.0)

Tested-by: Markus Reichelt <lkt+2023@mareichelt.com>

