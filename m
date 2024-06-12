Return-Path: <stable+bounces-50282-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 910749055C3
	for <lists+stable@lfdr.de>; Wed, 12 Jun 2024 16:52:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E2BEB21D46
	for <lists+stable@lfdr.de>; Wed, 12 Jun 2024 14:52:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8025717F37B;
	Wed, 12 Jun 2024 14:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tG+ktoUx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40E9217F374
	for <stable@vger.kernel.org>; Wed, 12 Jun 2024 14:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718203953; cv=none; b=Auc+xHJlSgiGUTlrRZSFcLFmPkjI3BJA/WL7Q34NBpdUgQJbCC+KJKxHPm/Ozqlb3Ck3I2vzgZNwLqGdg+6VVvOg216gVcvciT36l41fxKHmf9jzOItvju+5GcawiVdMl4X2qKq3gJB2AKoyXs/GZoP2s6RpEUOHSnYZKAQTuws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718203953; c=relaxed/simple;
	bh=qZZzXTY1EKWJjW4achoyCuY4dZN2xSIK7eCJaWBT+4M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SnBApUPe7OxjXW1oFPX3ie7Q9aS2EFCs6pXvITHz2TghOdSi2CTvJ/K7tmwABVsli8ttC//OnTJQmQ9gNHnS1Hpkkc0HlDTObfdokCF8N73SalHmBW6yRBaxx1RAbkFiL6ixZb4kYRmS+u73DYaX8zjxoP07RmheUZS7MMrxge0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tG+ktoUx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A24DC116B1;
	Wed, 12 Jun 2024 14:52:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718203952;
	bh=qZZzXTY1EKWJjW4achoyCuY4dZN2xSIK7eCJaWBT+4M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tG+ktoUxBVwkc0UQ5JCLvpKbSzEYXtgu5oTpm6Ua3yp+pJdiRWO+Z+IKyb2xfyU9I
	 /UyvoBNs/Picq3qmXGW3p1modjAS08f1AQwhy/gDHs6IWkNvWlmKkLsogVs5uHCim5
	 FhARAmtVwo5hOOBcL97Ga5jnkEfgX+DiYqFt4OMc=
Date: Wed, 12 Jun 2024 16:52:30 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Ronnie Sahlberg <rsahlberg@ciq.com>
Cc: stable@vger.kernel.org
Subject: Re: Candidates for stable v6.9..v6.10-rc1 Out Of Bounds
Message-ID: <2024061212-dicing-unrobed-6585@gregkh>
References: <CAK4epfwH1KvQgEgXt3ifmQtnHDOKG7xJ5G-5H6cvqUH7dWfGtw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK4epfwH1KvQgEgXt3ifmQtnHDOKG7xJ5G-5H6cvqUH7dWfGtw@mail.gmail.com>

On Thu, May 30, 2024 at 09:47:43PM -0400, Ronnie Sahlberg wrote:
> These commits reference out.of.bound between v6.9 and v6.10-rc1
> 
> These commits are not, yet, in stable/linux-rolling-stable.
> Let me know if you would rather me compare to a different repo/branch.
> The list has been manually pruned to only contain commits that look like
> actual issues.
> If they contain a Fixes line it has been verified that at least one of the
> commits that the Fixes tag(s) reference is in stable/linux-rolling-stable
> 
> 
> 2ba24864d2f61b52210b Syz Fuzzers, Out of bounds
> 3ebc46ca8675de6378e3 Syz Fuzzers, Out of bounds
> 9841991a446c87f90f66 Kernel panic, NULL pointer, Out of bounds
> 51fafb3cd7fcf4f46826 Out of bounds
> 45cf976008ddef4a9c9a Out of bounds
> 8b2faf1a4f3b6c748c0d Out of bounds
> faa4364bef2ec0060de3 Buffer overflow, Out of bounds
> 8ee1b439b1540ae54314 Out of bounds
> 7b4c74cf22d7584d1eb4 Out of bounds
> 1008368e1c7e36bdec01 Out of bounds

Thanks, I've applied the ones that we could that were not already in the
trees.

greg k-h

