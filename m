Return-Path: <stable+bounces-15895-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 47FDA83DE24
	for <lists+stable@lfdr.de>; Fri, 26 Jan 2024 16:58:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0556B282CD2
	for <lists+stable@lfdr.de>; Fri, 26 Jan 2024 15:58:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84E8B1D541;
	Fri, 26 Jan 2024 15:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qovOo/t1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A9EE1D53F
	for <stable@vger.kernel.org>; Fri, 26 Jan 2024 15:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706284713; cv=none; b=NDiqpJg1NLWUhSL49mhZgyRJj6rdasIDBN7uAjgHXlud0gy3kHrgtzYikqBT/+PF/33JPoELwR7L6ZPzP+dq52dUc7MMF4WDPnH+jlIwQafGFNfuewSuShC8oE8r3m+jxH+jLUrqJ7OYv/l1jImRqD6TYUpjGHZbD0NI9+cgrEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706284713; c=relaxed/simple;
	bh=fRViHO/P/3ma+yqLDXGOfP+Pfez7pc1qSZUWGf1xBxo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RZoxaAHSjZHsUTldSOL8x1E1evtPDzDO+IV7zCHjmnI5w3UoCPOl/eywiPCU6MOYTs10HnzNf5IqK7SgHcCEQ/VomUoRiesYs5u9PAg5+np5gfiIx7RcBpnDNwMOfKqpw/F68JORjPqL6bj8d0gBn83FDHi6f2lOg8xSaV1H2o8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qovOo/t1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3600C433C7;
	Fri, 26 Jan 2024 15:58:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706284712;
	bh=fRViHO/P/3ma+yqLDXGOfP+Pfez7pc1qSZUWGf1xBxo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qovOo/t1iYui5rKLyqRvQqluQVm+NZbcAgZ9iedcFUOLwYFQJO2PL3m6G976jD//1
	 8NpmN8TWorP74ObseBdZbfnpfhSacslxlpZiL7I5+964Sz2EppDo7QGrY8cc6D8JJK
	 AW90NtKt3j/BtknNWrpKVA6qYXhvYKjz48AmMs/g=
Date: Fri, 26 Jan 2024 07:58:31 -0800
From: Greg KH <gregkh@linuxfoundation.org>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Jonathan Gray <jsg@jsg.id.au>, stable@vger.kernel.org
Subject: Re: duplicate 'drm/amd: Enable PCIe PME from D3' in stable branches
Message-ID: <2024012631-impulse-vegan-adc5@gregkh>
References: <ZbOAj1fC5nfJEgoR@largo.jsg.id.au>
 <af1f3522-6cf6-4a1e-b873-3ee4f9dd19d2@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <af1f3522-6cf6-4a1e-b873-3ee4f9dd19d2@amd.com>

On Fri, Jan 26, 2024 at 09:43:24AM -0600, Mario Limonciello wrote:
> On 1/26/2024 03:51, Jonathan Gray wrote:
> > The latest releases of 6.1.y, 6.6.y and 6.7.y introduce a duplicate
> > commit of 'drm/amd: Enable PCIe PME from D3'.
> 
> Good catch.  I think this happened because the same commit ended up in 6.7
> final as well as 6.8-rc1 with different hashes.  This tends to happen when
> we have fixes right at the end of the cycle.

For some drm drivers, it happens all the time and drives me constantly
crazy.  So much so that I dread dealing with the drm stable patches for
-rc1 releases :(

> In this case it's fortunately harmless, but yes I think one of them should
> be dropped from stable trees.

Can someone send me a revert please?

thanks,

greg k-h

