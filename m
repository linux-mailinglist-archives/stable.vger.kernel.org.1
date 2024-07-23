Return-Path: <stable+bounces-60751-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 178E193A008
	for <lists+stable@lfdr.de>; Tue, 23 Jul 2024 13:38:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B13271F2319F
	for <lists+stable@lfdr.de>; Tue, 23 Jul 2024 11:38:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 649A11509BC;
	Tue, 23 Jul 2024 11:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1H/C62pm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F27A13D8B3;
	Tue, 23 Jul 2024 11:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721734678; cv=none; b=i7NtCH0SlXFLVRtmrWQDcm8KyMaMgp5fB556Q27kaq01kVY7lWVPL/D5a+d4rrqucqh2mXBywGUsdVDsiVGh/C9qoXPJaAf2LeoYBvwx7hWx1g770PfHTl0CTsVUequgx+Hta3Kd0PnFk3zKsiseW2M7ogZ+GncxDJA6Tbsmujk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721734678; c=relaxed/simple;
	bh=9fp/JUizxS5IqkIRscjC1V5D08luobHz0+npLcTNzR8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ljB/V02OLXP9gCZqhgVCkOMqtPhUSq7Ml9/aRllvnnOPH5rieHkPRZLsbS1dXAol2vh2R6NVh3HivWM4XOyEvvmBvFmnSfYtWyQU1vGo0JDQPSKf6RLTQZN0k8ktdkRgVzmrYZ4SDGCh6AwHbQzhZa5PsN30IvGXPtZWiQxXQG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1H/C62pm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A1A4C4AF0A;
	Tue, 23 Jul 2024 11:37:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1721734677;
	bh=9fp/JUizxS5IqkIRscjC1V5D08luobHz0+npLcTNzR8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=1H/C62pmK7q/CUr62Ib5rGt192NvwRBGHg1EgQf/EmZsCW9vFZWGRCFvMUH6i3mt5
	 9kesfOyx8TYh2pr1zhlqGEccxFaSVP/kDy3qd33eG1hh5DtAsKLK8QtDpl6P+4yPrg
	 LlETAt6y6A0eC3dUCmME3TIm8ouFrlCLvmi141u8=
Date: Tue, 23 Jul 2024 13:37:53 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Richard Fitzgerald <rf@opensource.cirrus.com>
Cc: stable@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org, alsa-devel@alsa-project.org,
	patches@opensource.cirrus.com
Subject: Re: [PATCH for-6.10 0/2] ASoC: cs35l56: Set correct upper volume
 limit
Message-ID: <2024072342-recall-dedicator-98d5@gregkh>
References: <20240722102600.37931-1-rf@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240722102600.37931-1-rf@opensource.cirrus.com>

On Mon, Jul 22, 2024 at 11:25:58AM +0100, Richard Fitzgerald wrote:
> Patch series to limit the upper range of the CS35L56 volume control to
> +12 dB.
> 
> These commits were not marked 'Fixes' because they were thought to be only
> a cosmetic issue. The user could reduce the volume to a usable value.
> 
> But for some complex audio topologies with SOF Audio DSP + CS42L43 +
> multiple CS35L56 it has turned out to be not obvious to the user what the
> problem actually is and what to do to fix it. As support for these
> topologies went into 6.10 we would like this series to be applied to 6.10.

Now queued up, thanks.

greg k-h

