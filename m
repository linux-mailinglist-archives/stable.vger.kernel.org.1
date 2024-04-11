Return-Path: <stable+bounces-39176-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2820B8A12D4
	for <lists+stable@lfdr.de>; Thu, 11 Apr 2024 13:18:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85A7A282B03
	for <lists+stable@lfdr.de>; Thu, 11 Apr 2024 11:18:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37175147C86;
	Thu, 11 Apr 2024 11:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="L3OXL4T/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C491E13DDD6
	for <stable@vger.kernel.org>; Thu, 11 Apr 2024 11:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712834316; cv=none; b=fFQt5yS4td5IoRxoalejsO4HYHdfNvinMEy9Db8S9pZA2Mw+Cgmsaro9KiI//gF4NJYZQqkqP/PFnNhhG5vchj7SUcywpiNDa5csYYPZnY2VS/vKcrWrqZxjWk82T9LsoPCMyoBxdzsTXp0dv1td3JAlsgiR7XX4aIPLp/a9vlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712834316; c=relaxed/simple;
	bh=bA+dKB8+rce2HNoNLvHLOTn+GYqw0JjJ3qmvf2sxrcA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I08/dLRq0nAEkhQ4MxSBCmE5yhjBq0If4cn16rjEwmbM0iTSWliyOCpyPzaHOu9CwKaXsdFQmESivcytrQ8stnnU1sy7oHVPX7DAOiL4ctN3KW8OtXajCvTWrvRXdDQXdbVPROmeuSqcmSJnbnar/mxc6mrCzqTOADvO08AE5Dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=L3OXL4T/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1F0EC433F1;
	Thu, 11 Apr 2024 11:18:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712834316;
	bh=bA+dKB8+rce2HNoNLvHLOTn+GYqw0JjJ3qmvf2sxrcA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=L3OXL4T/o30Hve3WBGO0nfcKs/k2TUwExiKB+gTm11+2A/TYTxMwS6oKH0Sdr99F/
	 RpxZ7AVVF80NwVWrZ/kQ4XBZCNW5GBYXoGPguJ+L4a95lKDKzMa5bWhplTAmvfq7Im
	 avHYrRQnvW0Z45Fzv1dRpgbjiWHjGotYZZGnD1qM=
Date: Thu, 11 Apr 2024 12:30:30 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: "# 3.4.x" <stable@vger.kernel.org>
Subject: Re: v5.15 backport request
Message-ID: <2024041134-strobe-childhood-cc74@gregkh>
References: <CAMj1kXEGNNZm9RrDxT6RzmE8WGFG-3kZePaZZNKJrT4fj3iveg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXEGNNZm9RrDxT6RzmE8WGFG-3kZePaZZNKJrT4fj3iveg@mail.gmail.com>

On Thu, Apr 11, 2024 at 12:23:37PM +0200, Ard Biesheuvel wrote:
> Please consider the commits below for backporting to v5.15. These
> patches are prerequisites for the backport of the x86 EFI stub
> refactor that is needed for distros to sign v5.15 images for secure
> boot in a way that complies with new MS requirements for memory
> protections while running in the EFI firmware.

What old distros still care about this for a kernel that was released in
2021?  I can almost understand this for 6.1.y and newer, but why for
this one too?

thanks,

greg k-h

