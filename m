Return-Path: <stable+bounces-147972-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AEE5DAC6CB2
	for <lists+stable@lfdr.de>; Wed, 28 May 2025 17:16:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CC2B3A5F4E
	for <lists+stable@lfdr.de>; Wed, 28 May 2025 15:16:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ED84288C1C;
	Wed, 28 May 2025 15:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mareichelt.com header.i=@mareichelt.com header.b="Jkkyigci"
X-Original-To: stable@vger.kernel.org
Received: from antaris-organics.com (mail.antaris-organics.com [91.227.220.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 704E11C683;
	Wed, 28 May 2025 15:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.227.220.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748445397; cv=none; b=IVteamdhrkVlXMeGt+AZ/fhC9/HBoaEKTFnmH3IWHZBaKTVuzzWB+MBRL/q3rX0xxlCUC7v8iTsoNajqmi3FZYI8ijXjDKTLL4kyAanerYkChZOk9PuwQBVk51Xlx9nnChAJmrt5RU+5PgVkADRFL7cY5pErqBhYIKwKROfQbYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748445397; c=relaxed/simple;
	bh=1mY5bie4lL53OVDgv/QLhzcmOYpW6GrMqMwi0NRuBB0=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MXdnQc2wV++N6bVe874IAtGZ6vFwCY9tXScrzqMdCa6kScVqn2IWPiTvkLRaxILxn3FzF2qO9YSOO4nz7vsZkTXB3pbaZmelTDGVj6Zzz6dvTi0pNHiSIy3mrOiHLlSmEQDuQo8M39iRhxTbJvKUyIqvnvN51Ch+rohBRq/iR4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mareichelt.com; spf=pass smtp.mailfrom=mareichelt.com; dkim=pass (2048-bit key) header.d=mareichelt.com header.i=@mareichelt.com header.b=Jkkyigci; arc=none smtp.client-ip=91.227.220.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mareichelt.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mareichelt.com
Date: Wed, 28 May 2025 17:16:32 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mareichelt.com;
	s=202107; t=1748445393;
	bh=1mY5bie4lL53OVDgv/QLhzcmOYpW6GrMqMwi0NRuBB0=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:In-Reply-To:Cc:Cc:content-type:content-type:date:date:
	 From:from:in-reply-to:in-reply-to:message-id:mime-version:
	 mime-version:references:reply-to:Sender:Subject:Subject:To:To;
	b=JkkyigcidDNAJayF/KIqoKPYlvdnwyPTq38fZi6mMmPfEfTITDboDWTKJtmsQjuTG
	 4rcTCgfHHptP0MXk4+nzZgAqEKo0XEdIcdCrV9DPtp5Yq6fW0fMSzB+9b0xtjOX6Q/
	 b1hugMM5dVIemHh36wnvdp3kXxcTJkY3VRvKFd4ix+HjfVRk4L+O55mhQav6UuCWmc
	 qOcc5JasTu9SFcFC+aK8mP7yrJysgmMJ3d73+OrcU7NLnCv93D5N8g+WO+BcRpByqJ
	 WTWWbOPRBgS090tkHDkLk5uerFEgtlrHa7Ia8C1bLazndFGLAHv7VprrhjZZMKbfYg
	 6dCfRD/BPl4Pg==
From: Markus Reichelt <lkt+2023@mareichelt.com>
To: stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6.12 000/626] 6.12.31-rc1 review
Message-ID: <20250528151632.GB24108@pc21.mareichelt.com>
Mail-Followup-To: stable@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250527162445.028718347@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250527162445.028718347@linuxfoundation.org>

* Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

> This is the start of the stable review cycle for the 6.12.31 release.
> There are 626 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 29 May 2025 16:22:51 +0000.
> Anything received after that time might be too late.

Hi Greg

6.12.31-rc1 compiles on x86_64 (Xeon E5-1620 v2, Slackware64-15.0),
and boots & runs on x86_64 (AMD Ryzen 5 7520U, Slackware64-current),
no regressions observed.

Tested-by: Markus Reichelt <lkt+2023@mareichelt.com>

