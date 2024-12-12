Return-Path: <stable+bounces-100835-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 727179EDFA5
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 07:57:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F207C168C9C
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 06:57:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC7402054ED;
	Thu, 12 Dec 2024 06:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dHw1ilMs"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BA2F204C2B;
	Thu, 12 Dec 2024 06:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733986650; cv=none; b=or1U9f2iCXfIzIxN+Npvlt1Fgvsxv/J3gj7bl7te6NNgDPTXFFLSskXohXI16+VYFOrFkUlrWV8anBA/fJnKTZjMG0MOWiy2LK0oA7qKLRLNh2/E6OsDidtvpS8U3yX8w3HsOwQ4uA38k55U+1w1CCo2Y+uxbHza3q5mR/2CggE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733986650; c=relaxed/simple;
	bh=5TZYJdh90qFXeWIuUDdOzbLk64HJamGNaYMfSu5ZnE4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DD6KswcTRrEBA44c3MAVkFkf1/xbCoeKjiYrppii39h9EmUSevv94pYspXgFF5eQizaLU5bJkg7+ROqChZMQl5fRBsnHEUEBT/AXkEbcwpRicnOwMyDphN+pUllMqCz9o5qDGNSxQXqJFT0mUR1TyviFkWqAvuJarwhAcJGufk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dHw1ilMs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7ACD8C4CED1;
	Thu, 12 Dec 2024 06:57:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733986650;
	bh=5TZYJdh90qFXeWIuUDdOzbLk64HJamGNaYMfSu5ZnE4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dHw1ilMs/8ONWHSUB0FFS+1F6DMfvf4aG2EmTElokxWPKIv+oNCeDzVW+yDjaLyQ2
	 BcEZfUIh5YgLvXZzadfNroYmjnlZJYSu9X/jPYUsHHdM6599tJU/AKpPbJWHLmy/pM
	 xM7IrMCq9Cc0F6xNoRuNLclYwbaBIm2aI+mcSbDo=
Date: Thu, 12 Dec 2024 07:57:26 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: stable@vger.kernel.org, stable-commits@vger.kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>
Subject: Re: [PATCH 6.6.y] scsi: ufs: qcom: Only free platform MSIs when ESI
 is enabled
Message-ID: <2024121210-preplan-multiply-03ef@gregkh>
References: <20241211183908.3808070-1-sashal@kernel.org>
 <8734iuaveo.ffs@tglx>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8734iuaveo.ffs@tglx>

On Wed, Dec 11, 2024 at 08:09:51PM +0100, Thomas Gleixner wrote:
> 
> From: Manivannan Sadhasivam <mani@kernel.org>
> 
> commit 64506b3d23a337e98a74b18dcb10c8619365f2bd upstream.
> 
> Otherwise, it will result in a NULL pointer dereference as below:
> 
> Unable to handle kernel NULL pointer dereference at virtual address 0000000000000008
> Call trace:
>  mutex_lock+0xc/0x54
>  platform_device_msi_free_irqs_all+0x14/0x20
>  ufs_qcom_remove+0x34/0x48 [ufs_qcom]
>  platform_remove+0x28/0x44
>  device_remove+0x4c/0x80
>  device_release_driver_internal+0xd8/0x178
>  driver_detach+0x50/0x9c
>  bus_remove_driver+0x6c/0xbc
>  driver_unregister+0x30/0x60
>  platform_driver_unregister+0x14/0x20
>  ufs_qcom_pltform_exit+0x18/0xb94 [ufs_qcom]
>  __arm64_sys_delete_module+0x180/0x260
>  invoke_syscall+0x44/0x100
>  el0_svc_common.constprop.0+0xc0/0xe0
>  do_el0_svc+0x1c/0x28
>  el0_svc+0x34/0xdc
>  el0t_64_sync_handler+0xc0/0xc4
>  el0t_64_sync+0x190/0x194
> 
> Cc: stable@vger.kernel.org # 6.3
> Fixes: 519b6274a777 ("scsi: ufs: qcom: Add MCQ ESI config vendor specific ops")
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Link: https://lore.kernel.org/r/20241111-ufs_bug_fix-v1-2-45ad8b62f02e@linaro.org
> Reviewed-by: Bean Huo <beanhuo@micron.com>
> Reviewed-by: Bart Van Assche <bvanassche@acm.org>
> Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  drivers/ufs/host/ufs-qcom.c |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Thanks for this, I've dropped the other backports and just taken this
one instead.

greg k-h

