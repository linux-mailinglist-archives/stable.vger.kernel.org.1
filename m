Return-Path: <stable+bounces-203276-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A3439CD8664
	for <lists+stable@lfdr.de>; Tue, 23 Dec 2025 08:39:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F318E301355F
	for <lists+stable@lfdr.de>; Tue, 23 Dec 2025 07:39:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A50582DCC1F;
	Tue, 23 Dec 2025 07:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hRi9ztVG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30FD22877CB
	for <stable@vger.kernel.org>; Tue, 23 Dec 2025 07:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766475567; cv=none; b=ARV8n5tcP9ECEtPovBpT+6V4LPtpi2tpOOD3FbGA1gCjEaw8NzXp7wU7OE+G3Uo5kKXZb13QfTGHdagI9X/oHRRe4200ONYQU6TIYlgYyFHoUH041X2hp1sTiJ8TgZJ/eShZwDppe9gONf+2ErVkXPh7ITWvEdeT1dfE1DkClmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766475567; c=relaxed/simple;
	bh=P3PxHOGzHx5DV+OjDnJ850AU72MuhHmb5/lsNxgu3a0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cDp7mCvQx5nIK7Ti6JgCxyfHMR7aZotp67Bpv64PaakrGwcvnVrVxigK8hV2vuRHORhlGLitMIXETXLgByJ2XxeFtlQeKeNa0/EJn6ADRwV2uQRogbtqpz6xXXKfxXNcdLDPlHeu2tuLqo043tb9qiieml/Sj87c8rvZX5VxCq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hRi9ztVG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58B3AC113D0;
	Tue, 23 Dec 2025 07:39:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1766475566;
	bh=P3PxHOGzHx5DV+OjDnJ850AU72MuhHmb5/lsNxgu3a0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hRi9ztVGU2ClT8Absmy9WKcBA2zFf+uryNmSBlaE5C9/EoxT3D25ZQ3Wul8QVmBju
	 mnb694C/d7l4wPmlwCDxKMLjd1wJ6qvNYok040eloxmKNx+jMKRSCmSJn5y2mzlIxs
	 10V8OOWaalqVXFkE8BkCULquBZKpRJ5P0QRqAOtw=
Date: Tue, 23 Dec 2025 08:39:22 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: JP Dehollain <jpdehollain@gmail.com>
Cc: stable@vger.kernel.org
Subject: Re: Request to add mainline merged patch to stable kernels
Message-ID: <2025122303-widget-treachery-89d6@gregkh>
References: <CAH1aAjJkf0iDxNPwPqXBUN2Bj7+KaRXCFxUOYx9yrrt2DCeE_g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAH1aAjJkf0iDxNPwPqXBUN2Bj7+KaRXCFxUOYx9yrrt2DCeE_g@mail.gmail.com>

On Tue, Dec 23, 2025 at 04:05:24PM +1100, JP Dehollain wrote:
> Hello,
> I recently used the patch misc: rtsx_pci: Add separate CD/WP pin
> polarity reversal support with commit ID 807221d, to fix a bug causing
> the cardreader driver to always load sd cards in read-only mode.
> On the suggestion of the driver maintainer, I am requesting that this
> patch be applied to all stable kernel versions, as it is currently
> only applied to >=6.18.
> Thanks,
> JP
> 

What is the git id of the commit you are looking to have backported?

thanks,

greg k-h

