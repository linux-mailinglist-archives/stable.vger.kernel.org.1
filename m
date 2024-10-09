Return-Path: <stable+bounces-83213-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 881A9996C1C
	for <lists+stable@lfdr.de>; Wed,  9 Oct 2024 15:34:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40FE11F21382
	for <lists+stable@lfdr.de>; Wed,  9 Oct 2024 13:34:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A078190462;
	Wed,  9 Oct 2024 13:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2rsUodAv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47A48192583
	for <stable@vger.kernel.org>; Wed,  9 Oct 2024 13:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728480847; cv=none; b=cw3WtCla21AXch/wyj4k41fnMd0h31e606IhwzOvDkJmCGiPJFkPD8VTeezNyDTmTzO78Nie+MzlITLlmE1xuKixduUV67pSZ15SWa0PfiImiqlKa1UiPoijoC6gnuFDBB8IU/aXMXE8Lgm8HArqa3VRIHfq290fpWkZj5Pp/y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728480847; c=relaxed/simple;
	bh=2OTuXDbzN6pAh1JwiRyG7HK/GipO5FJ3LkVJo1rpH+U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s/ujhGJUzHGTD24IhauCLPA9pFIREHARfHgvnMZNOAEJqOoxnVWMWGoVMWpo4mrBl2YLqGSImPUTipqODQvbqj3xBF6N2JJccy9msZvMIMNcM2k3ah09CFre6yKNysMFBTzpm8DyZnxgop/571Vq+PdWDZPaeAA8Nz98ODd8J4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2rsUodAv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FC98C4CEC5;
	Wed,  9 Oct 2024 13:34:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728480846;
	bh=2OTuXDbzN6pAh1JwiRyG7HK/GipO5FJ3LkVJo1rpH+U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=2rsUodAvRO8PQTaxmkxKkHduld8VH8TWVA1/lvOPU6Ei3xR8ws5MLXiHrDdPJ1Gnn
	 DSi60+pJ9312UHKyOiPKI643BywbrMvfxwHphNOzIjbZpOFTj3CaZJULliPUQfu2i7
	 m+ZMiMVXUW5pJKkZ+6pPGLuJ2OK5jOstm74yE1xw=
Date: Wed, 9 Oct 2024 15:34:03 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: libo.chen.cn@windriver.com
Cc: stable@vger.kernel.org
Subject: Re: [PATCH] Drivers: hv: vmbus: Leak pages if set_memory_encrypted()
 fails
Message-ID: <2024100950-pointing-booted-5e77@gregkh>
References: <20241009061950.2802693-1-libo.chen.cn@windriver.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241009061950.2802693-1-libo.chen.cn@windriver.com>

On Wed, Oct 09, 2024 at 02:19:50PM +0800, libo.chen.cn@windriver.com wrote:
> From: Rick Edgecombe <rick.p.edgecombe@intel.com>
> 
> commit 03f5a999adba ("Drivers: hv: vmbus: Leak pages if set_memory_encrypted() fails")
> 
> In CoCo VMs it is possible for the untrusted host to cause
> set_memory_encrypted() or set_memory_decrypted() to fail such that an
> error is returned and the resulting memory is shared. Callers need to
> take care to handle these errors to avoid returning decrypted (shared)
> memory to the page allocator, which could lead to functional or security
> issues.
> 
> VMBus code could free decrypted pages if set_memory_encrypted()/decrypted()
> fails. Leak the pages if this happens.
> 
> Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
> Signed-off-by: Michael Kelley <mhklinux@outlook.com>
> Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Link: https://lore.kernel.org/r/20240311161558.1310-2-mhklinux@outlook.com
> Signed-off-by: Wei Liu <wei.liu@kernel.org>
> Message-ID: <20240311161558.1310-2-mhklinux@outlook.com>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> 
> CVE-2024-36913
> Signed-off-by: Libo Chen <libo.chen.cn@windriver.com>
> ---
> This commit is backporting 03f5a999adba to the branch linux-5.15.y to 
> solve the CVE-2024-36913. Please merge this commit to linux-5.15.y.

As I didn't take the 6.1 patch, I can't take this one yet either :(

