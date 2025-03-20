Return-Path: <stable+bounces-125625-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B31ACA6A26E
	for <lists+stable@lfdr.de>; Thu, 20 Mar 2025 10:20:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F5261895300
	for <lists+stable@lfdr.de>; Thu, 20 Mar 2025 09:20:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46D33221DA1;
	Thu, 20 Mar 2025 09:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mareichelt.com header.i=@mareichelt.com header.b="acehEYrY"
X-Original-To: stable@vger.kernel.org
Received: from antaris-organics.com (mail.antaris-organics.com [91.227.220.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79C83220696;
	Thu, 20 Mar 2025 09:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.227.220.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742462423; cv=none; b=OaX/cpNFUvPT3RGjKygfln07Ep2uhTEdGIt/WR1n6O0JRnj1VIRlpsjOcVPBRUjvacGKuvzCG7qp8AeYPsnebglHNr5zl6wv1H0cbaIXTzlg/km4cjyBtdSBeXZo8WwogC6CW3WZznvP9X1wbVGxc7YMdK0ZBOwN7j7qKTg02zI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742462423; c=relaxed/simple;
	bh=Jir+luu2u55Zi8w8wemIUjhxzD3MGIX09cdiZehg0o8=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Uh3VJFDtcOpTiGADlQIDsZmVK6CNQfzSPG7x+wg2caadGT9hsHdvQ9XaE1xi84gK/bNCsSL7p02F/POWcp3u7tYYYtb8OGUrW0gVAghpYAWP8Z5lnB9GoQEYNMSR+iGf67bO/LQEOXB97nJpEw6WRgTmlOSMRR+M/IlRf0zrzk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mareichelt.com; spf=pass smtp.mailfrom=mareichelt.com; dkim=pass (2048-bit key) header.d=mareichelt.com header.i=@mareichelt.com header.b=acehEYrY; arc=none smtp.client-ip=91.227.220.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mareichelt.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mareichelt.com
Date: Thu, 20 Mar 2025 10:12:51 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mareichelt.com;
	s=202107; t=1742461972;
	bh=Jir+luu2u55Zi8w8wemIUjhxzD3MGIX09cdiZehg0o8=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:In-Reply-To:Cc:content-type:date:From:from:
	 in-reply-to:message-id:mime-version:references:reply-to:Sender:
	 Subject:To;
	b=acehEYrYZiFmtrP9vvFwvaOuhGgYpDutOJ0L0TSJVgz0EkRMGwk3A3K1B9eLIfwEA
	 PboDMCmUVYdOQrpK0eQ06hDVHP9TNVkPkqM5Tyj/HUJCaituh4VTtjuSJiQ8eG/2Kj
	 iLiBboNPbQ6z2rKbcCrSeNxoASEJnmxiKiec7gCwU9WH2Wba4DPfeQ7XtcWsyKw9d3
	 xQ2oSZ6hvRNpSKv9jxRgDvae2IidFvu8JyOYi5WMw8uRj9mF8sxIyzmz+ZX6bus5Cn
	 5pdhu+fj5c+RghyCaEogaH94NytoFF428m7AyVMx4QWaIEYxnalw0Oya+p+muXM/1R
	 pVIyjNr4FVxYQ==
From: Markus Reichelt <lkt+2023@mareichelt.com>
To: stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6.12 000/231] 6.12.20-rc1 review
Message-ID: <20250320091251.GA5566@pc21.mareichelt.com>
Mail-Followup-To: stable@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250319143026.865956961@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250319143026.865956961@linuxfoundation.org>

* Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

> This is the start of the stable review cycle for the 6.12.20 release.
> There are 231 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 21 Mar 2025 14:29:55 +0000.
> Anything received after that time might be too late.

Hi Greg

6.12.20-rc1 compiles, boots and runs here on x86_64 (AMD Ryzen 5 7520U,
Slackware64-current), no regressions observed.

Tested-by: Markus Reichelt <lkt+2023@mareichelt.com>

