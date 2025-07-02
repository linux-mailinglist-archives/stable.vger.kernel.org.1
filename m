Return-Path: <stable+bounces-159219-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 26D32AF1115
	for <lists+stable@lfdr.de>; Wed,  2 Jul 2025 12:04:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4D00188DA72
	for <lists+stable@lfdr.de>; Wed,  2 Jul 2025 10:05:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40BDC2417E6;
	Wed,  2 Jul 2025 10:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RqI7C/QC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6CC82A1AA
	for <stable@vger.kernel.org>; Wed,  2 Jul 2025 10:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751450683; cv=none; b=YAPW3Zr4eds9HbwoxBb8EGDSZ20TqF3/nVNl0bsBcErULnJG2KDsjK8uykIVvzw8yUSe7DApVBp7RYGgJkeS3IurDjn6IS1uJaiNYwSxc1ETvSK796zj5a6ZU+eHNXBO9Bg4849Q4d2aL43HV7LTmbqKNnfuMuZ1/gORrpojiho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751450683; c=relaxed/simple;
	bh=jIq6ZIjLEM9VELXnD/fgwoJ/Bpbz1Vqype3GyE2W284=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h1owQT/X+Wq/+2i2hECfSsaUvIuvPgjtOMeZJJq5/bvM1OVkTeXJTTNs5hM1yjm5rE611xZugOkZXarIhO7p9aEmTBgOi42/ULl5GLC+fasIdW4b7ztvw+4Idl3fbpi6XWu0SyIKraqagRtTa8NI1Zqx0biITM6shIsZtcxmdfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RqI7C/QC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E0D0C4CEED;
	Wed,  2 Jul 2025 10:04:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751450682;
	bh=jIq6ZIjLEM9VELXnD/fgwoJ/Bpbz1Vqype3GyE2W284=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RqI7C/QCQ9O2xcmQSILnwuM1RDigzzjAjUtTvy6EZ53y/oJw910RJuA3JXEL7wFvR
	 aede3m+7kc7b3gv50IEdeDcxU6u9KiPLju0B3FLSwMbknme4FOv4q1unlG8Nk+n4xv
	 SuNhWXSJpEoEdpAhKN0RVBoQR6JOykldtLBeuJEY=
Date: Wed, 2 Jul 2025 12:04:39 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: mathieu.tortuyaux@gmail.com
Cc: stable@vger.kernel.org, Mathieu Tortuyaux <mtortuyaux@microsoft.com>
Subject: Re: [PATCH 6.12.y 0/3] r8169: add support for RTL8125D
Message-ID: <2025070224-plethora-thread-8ef2@gregkh>
References: <20250630142717.70619-1-mathieu.tortuyaux@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250630142717.70619-1-mathieu.tortuyaux@gmail.com>

On Mon, Jun 30, 2025 at 04:27:13PM +0200, mathieu.tortuyaux@gmail.com wrote:
> From: Mathieu Tortuyaux <mtortuyaux@microsoft.com>
> 
> Hi,
> 
> This backports support for Realtek device 0x688 on Kernel 6.12.y:
> * Tested in Flatcar CI w/ Kernel 6.12.35 on qemu (for regression): https://github.com/flatcar/scripts/pull/3006
> * The user requesting this support has confirmed correct behavior: https://github.com/flatcar/Flatcar/issues/1749#issuecomment-3005483988 
> 
> The two other commits ("net: phy: realtek: merge the drivers for
> internal NBase-T PHY's" and "net: phy: realtek: add RTL8125D-internal PHY")
> are required to add support here as well, otherwise it fails with:
> ```
> $ dmesg
> ...
> r8169 ... : no dedicated PHY driver found for PHY ID 0x001cc841
> ...
> ```
> 
> Thanks and have a great day,
> 
> Mathieu (@tormath1)
> 
> Heiner Kallweit (3):
>   r8169: add support for RTL8125D
>   net: phy: realtek: merge the drivers for internal NBase-T PHY's
>   net: phy: realtek: add RTL8125D-internal PHY
> 
>  drivers/net/ethernet/realtek/r8169.h          |  1 +
>  drivers/net/ethernet/realtek/r8169_main.c     | 23 +++++---
>  .../net/ethernet/realtek/r8169_phy_config.c   | 10 ++++
>  drivers/net/phy/realtek.c                     | 54 +++++++++++++++----
>  4 files changed, 71 insertions(+), 17 deletions(-)

You did not sign off on any of these patches that you forwarded on :(

