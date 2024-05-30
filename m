Return-Path: <stable+bounces-47705-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 355C48D4BFF
	for <lists+stable@lfdr.de>; Thu, 30 May 2024 14:49:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65E051C22933
	for <lists+stable@lfdr.de>; Thu, 30 May 2024 12:49:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 268FB132123;
	Thu, 30 May 2024 12:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dfoUomfY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8C4C13211A
	for <stable@vger.kernel.org>; Thu, 30 May 2024 12:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717073361; cv=none; b=WUVLv+YzDr53KrqCUOtt7P0lqPIbtKiPeqRGCezqhoJUSEf74gqSTfB/2o1AXzPLiH30rYkqZqi4WfayAtudeDGhsAWKUzAE7yf4FlfzzCLwBBZoFBt50fXSsvNeJxA1Pd9krFYuEVL2boiGi1G4M4wWqdJrXApy8Nva27R7ciY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717073361; c=relaxed/simple;
	bh=5yE7trWS8reGdfxOu8pyMz5ttB1ullpyn+oJDrP7y3s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EpIIU5Mqg9SCs39zuQPBWlOS6NCKBBs5ODzZUYCrz49vbv4RovQ7ZL4c7jMyu+4LhFkLQKGcasOE0JZkN1jQXxzcl2C/C6oIoarjk/JJvUJzU/ceGApxVvhLG06sBh4znZdYkQWYAFYNtICSeuaFXM1KOmQt/7cW803Zb5U1yYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dfoUomfY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 133CFC2BBFC;
	Thu, 30 May 2024 12:49:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1717073361;
	bh=5yE7trWS8reGdfxOu8pyMz5ttB1ullpyn+oJDrP7y3s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dfoUomfY8YaI7bRBL/INqT7HZtEkbXxpxJ4MLb13tXcI6hhKa/XU6JGCs4ja0d+ni
	 lWgZKcebZCZgv1HeRE5J/PVClysymjvvIGbYDyfdB6V5AHbJ7x41T1UBwDugRKgZRT
	 lPaM37U3nollAnqzxXHOPx8wFIByXqSrdlNDJ9uA=
Date: Thu, 30 May 2024 14:49:26 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Mohammad Hosain <mh3marefat@yahoo.com>
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: AM5 big performance reduction with CSM boot mode and Wi-Fi
 disabled.
Message-ID: <2024053032-squeeze-such-dd29@gregkh>
References: <321337111.6017022.1717061838476.ref@mail.yahoo.com>
 <321337111.6017022.1717061838476@mail.yahoo.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <321337111.6017022.1717061838476@mail.yahoo.com>

On Thu, May 30, 2024 at 09:37:18AM +0000, Mohammad Hosain wrote:
> Hello
> There is a big performance bug (only affecting games performance) on Linux (not reproducible on Windows) with AM5 boards (at least for my MSI MAG b650 Tomahawk) if these BIOS settings are used:
> CSM -> Enabled
> Wi-Fi -> Disabled (or set to Bluetooth only)
> This does not happen even on Win 7... (I've only tested DX12 games) and does not happen if UEFI mode is chosen. I've tested with many different BIOS versions all showing the same result.
> I have tried troubleshooting with MSI with some benchmarks posted (https://forum-en.msi.com/index.php?threads/b650-tomahawk-bios-bug-disabling-wi-fi-massively-reduces-system-performance.396910/) and after a week we realized this only happens on Linux (tested on Arch/Fedora/Ubuntu with 6.8 and 6.9 kernels for the first two).

Is this a regression?  If so, what kernel version worked?  What did not
work?  Can you use 'git bisect' to find the problem?

And if it a regression, please report it to the regression list AND the
developers for the subsystem involved.

If it isn't a regression, perhaps it never has worked?

thanks,

greg k-h

