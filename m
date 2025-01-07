Return-Path: <stable+bounces-107891-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9655BA04A0B
	for <lists+stable@lfdr.de>; Tue,  7 Jan 2025 20:21:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECE113A62F4
	for <lists+stable@lfdr.de>; Tue,  7 Jan 2025 19:21:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BBF91F2C48;
	Tue,  7 Jan 2025 19:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="is/TlKHc"
X-Original-To: stable@vger.kernel.org
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEDEB2C187;
	Tue,  7 Jan 2025 19:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736277710; cv=none; b=Y3jsgiZSlsMGTdxCgNjmjtWoDmws8gYIL0ia5LrN3bb3HCsJrRXzaljIfvIA/ZLnSlsYATjRV6UI2JEZA0CP3AMtP9feClgsQxlt4OozI/LfH/kDzRZPxgbvu05o6+w+bGrcR4r3+osPbTm2NaSjKtblTGzeQJ7Z0391ggUxjdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736277710; c=relaxed/simple;
	bh=GZ+QK4W7m00pfsGrM/XH/gNWBMYeZTIE5O8xFsp0/rs=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=hR60f+bHh0jgiZk04cHbT9qy0iowaMy0fl5YJoPKPqCoQNYu2O+nmI2MKym7QGiWJPiHdTO26W8z9mVUtYtBdy6rffHSXyy8YNsZRwwtzFksHbIWOlWv86YlonQBrYwgjgjjV462eFdlYCn74OF1Iu8T2YzEfXC5PNwPHsApj+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=is/TlKHc; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1736277697;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ruu+MdlbmeQTHnEcd698GTDKPwfbm70xeflDbIRt+SU=;
	b=is/TlKHcoWBGgFdpZjGSrc2/NgTLgQJ7+qFD5yLDlkPCN9eqfTQspu6mofVjlUl0C3yXwJ
	HYt5aCrqZzvkrUvuQ/+xVgJanRsbeQ4t4GTftMQf/UGbF9st6q9FhtEf1G2qK7AmlEdzoO
	4XUIVgmjhq2cS8gxAL5tzYn4G/c3EqYqQkMGg8yBBOYPQOouG4b2z8OYS6rqZQ3oCFTp2K
	IaJVvIWypwWzaZYylG4r8LCKSCThFSuPMRuNLJ8AyL5LjYVUR8DTEeYWGj2NGbnHoaun4d
	mNM+eVmdYO8o6q/F8tthn7a1SSuuT3EC5eoCmKCsQnAsVRg/lHFF6U5joD2xLg==
Date: Tue, 07 Jan 2025 20:21:34 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: trondmy@kernel.org, anna@kernel.org
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Diederik de Haas <didi.debian@cknow.org>
Subject: Re: [PATCH] nfs: Make NFS_FSCACHE select NETFS_SUPPORT instead of
 depending on it
In-Reply-To: <4faf55b5022a9e363e3cad791144064636ed0eba.1735326877.git.dsimic@manjaro.org>
References: <4faf55b5022a9e363e3cad791144064636ed0eba.1735326877.git.dsimic@manjaro.org>
Message-ID: <ba8defca2f731d588a94e5e7013c1c19@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello,

On 2024-12-27 20:17, Dragan Simic wrote:
> Having the NFS_FSCACHE option depend on the NETFS_SUPPORT options makes
> selecting NFS_FSCACHE impossible unless another option that 
> additionally
> selects NETFS_SUPPORT is already selected.
> 
> As a result, for example, being able to reach and select the 
> NFS_FSCACHE
> option requires the CEPH_FS or CIFS option to be selected beforehand, 
> which
> obviously doesn't make much sense.
> 
> Let's correct this by making the NFS_FSCACHE option actually select the
> NETFS_SUPPORT option, instead of depending on it.
> 
> Fixes: 915cd30cdea8 ("netfs, fscache: Combine fscache with netfs")
> Cc: stable@vger.kernel.org
> Reported-by: Diederik de Haas <didi.debian@cknow.org>
> Signed-off-by: Dragan Simic <dsimic@manjaro.org>

Just checking, any thoughts about this patch?

> ---
>  fs/nfs/Kconfig | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/nfs/Kconfig b/fs/nfs/Kconfig
> index 0eb20012792f..d3f76101ad4b 100644
> --- a/fs/nfs/Kconfig
> +++ b/fs/nfs/Kconfig
> @@ -170,7 +170,8 @@ config ROOT_NFS
> 
>  config NFS_FSCACHE
>  	bool "Provide NFS client caching support"
> -	depends on NFS_FS=m && NETFS_SUPPORT || NFS_FS=y && NETFS_SUPPORT=y
> +	depends on NFS_FS
> +	select NETFS_SUPPORT
>  	select FSCACHE
>  	help
>  	  Say Y here if you want NFS data to be cached locally on disc 
> through

