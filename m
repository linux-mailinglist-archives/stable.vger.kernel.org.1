Return-Path: <stable+bounces-192361-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A5DEC30B77
	for <lists+stable@lfdr.de>; Tue, 04 Nov 2025 12:25:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D39891885018
	for <lists+stable@lfdr.de>; Tue,  4 Nov 2025 11:25:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E5422E6CAE;
	Tue,  4 Nov 2025 11:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d2ZDLvH2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C9322C0F7E;
	Tue,  4 Nov 2025 11:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762255530; cv=none; b=uGd3PDhIoUfDqTOWIRX9AU086ITXLEBlaqpvZv+GgWbEC8jWua8IiTuV4wdTxRQvryObPRJUPzp6qJDWiAV1KavFtxhhcqqbNSd3x4s6GfQv2mz7s5R/qiAXniokRY2Sv1io0dgPI6y8zZ60fobEpFQGXQ+t33/f5+0HK/pdwbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762255530; c=relaxed/simple;
	bh=R5SXDE2SgNS7wmaD1Gcfg6YItf0qkGUKKDfGIAl5yu4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fss6K+4QJFo2MPuswzrEi5ZLNWoWoeQy7pwNO5/1TeVYRTEYpGpvQXno+3U5s35UgW1FEgQ5vDg1a7EI6G4AkoX/lJy8484NOsxIgGUmyWyGnIg3+Q8YJlCJmLIoTDB6iKdJ/FSFhF4BqmXa8h5DihG/JaH4OtACeeOxJUsYD/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d2ZDLvH2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 021D7C4CEF7;
	Tue,  4 Nov 2025 11:25:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762255530;
	bh=R5SXDE2SgNS7wmaD1Gcfg6YItf0qkGUKKDfGIAl5yu4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=d2ZDLvH2nhfeYRcrIHG1iKJN0Dgsp76MX3JwZ74S/qhTdg9897Rm+V45EOl1iKsRO
	 midAmw7aVCsb0J3sJGikadCeaHVFTbTyVPCPtbbZty0srQbXRaSk0f3amDAqfgNf/w
	 PiSSIc0EgE4UqoO6mbzcSZiaO63dsjaYe5E3M6rOFA5VQYBqGRrNwXkgSmPq1qxOvk
	 nJdUjx/+4C+js17IaM1TEnoaHtPetVDo71du2hJ/hdC4Ya76C2HHSwg/98NJ0FkyHC
	 J8dWButunS9s8pyeEL0Xj1odIhAIvFFJthtq035dTE57vcx5RyYxfTKDgvumwzKZ4s
	 GsZyqbqHZSmVg==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1vGFAL-000000007TH-0lve;
	Tue, 04 Nov 2025 12:25:33 +0100
Date: Tue, 4 Nov 2025 12:25:33 +0100
From: Johan Hovold <johan@kernel.org>
To: =?utf-8?Q?Rapha=C3=ABl?= Gallais-Pou <rgallaispou@gmail.com>
Cc: Markus Elfring <Markus.Elfring@web.de>, dri-devel@lists.freedesktop.org,
	stable@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
	Alain Volmat <alain.volmat@foss.st.com>,
	Benjamin Gaignard <benjamin.gaignard@collabora.com>,
	David Airlie <airlied@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>, Simona Vetter <simona@ffwll.ch>,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH] drm: sti: fix device leaks at component probe
Message-ID: <aQnirQ2d9qLqJ68i@hovoldconsulting.com>
References: <20250922122012.27407-1-johan@kernel.org>
 <d1c2e56b-2ef9-4ab1-a4f8-3834d1857386@web.de>
 <aQj69wzTceDklx2Y@thinkstation>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aQj69wzTceDklx2Y@thinkstation>

On Mon, Nov 03, 2025 at 07:56:55PM +0100, Raphaël Gallais-Pou wrote:

> diff --git i/drivers/gpu/drm/sti/sti_vtg.c w/drivers/gpu/drm/sti/sti_vtg.c
> index ee81691b3203..5193196d9291 100644
> --- i/drivers/gpu/drm/sti/sti_vtg.c
> +++ w/drivers/gpu/drm/sti/sti_vtg.c
> @@ -142,7 +142,7 @@ struct sti_vtg {
> 
>  struct sti_vtg *of_vtg_find(struct device_node *np)
>  {
> -       struct platform_device *pdev;
> +       struct platform_device *pdev __free(put_device) = NULL;

You'd need to declare the variable when looking up pdev, which is one of
the reasons I don't like the cleanup helpers. It also often makes the
code harder to reason about for no good reason (especially with some of
the more esoteric cleanup helpers).

Keep it simple.

Johan

