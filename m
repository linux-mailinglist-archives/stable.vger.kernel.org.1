Return-Path: <stable+bounces-89809-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A140C9BC97F
	for <lists+stable@lfdr.de>; Tue,  5 Nov 2024 10:45:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59AA61F227B4
	for <lists+stable@lfdr.de>; Tue,  5 Nov 2024 09:45:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27A801D14E3;
	Tue,  5 Nov 2024 09:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pKMoeCJ/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C11E41D0F4D;
	Tue,  5 Nov 2024 09:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730799904; cv=none; b=DgKZPmpGjy4Y12XiKPgrxhrctHRWZi1MbO1NHCV1z9MLC6JFgcXPdWXBNVmkYFtgWrsYz+VD5K7G116Ep108CsQVgeDberrenSYcJgcyfa5ruVgjjmAiAxFgQ9TdR/cJXar8KYF0NZtltNjC5YOkDVllezqzUF0pRa1xIIk7VKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730799904; c=relaxed/simple;
	bh=U0SRmOWr1U4JuEYg0qpGcM0a0ifCuVC2a3ZscCltcMY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ea0bObK5+qy4NvB1NEvFPseOR3+vH94Uc8991Hdzfb2Zth6Q2w97ABAlQfLrBSyl1QmIuTu9iPKDL2qDDPdWenoOw/2iBg0gL8DOQH3QFAtO7HPsrAKUCwUtmRRNStYjHyhPzUQVSfytBYH7SE0AHRWsJqtbDpG0e8HMSZjnjgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pKMoeCJ/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE6C8C4CED0;
	Tue,  5 Nov 2024 09:45:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1730799904;
	bh=U0SRmOWr1U4JuEYg0qpGcM0a0ifCuVC2a3ZscCltcMY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pKMoeCJ/ksCImGa9FGt2LA44fYGzW+q1Wl45GUX0yAOkAH7XWr6mmkJFOtlfpxDdJ
	 HUbGD1mYiGWRnyJQ3wBSC2jrUK3h1hU6mcZOJMNmAvEkLGTYO3RZAenJPL5iUroJr9
	 FVRYGa06AHORntRF7q9TbR/hr41JViy2XhPWMAI4=
Date: Tue, 5 Nov 2024 10:44:46 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Calvin Owens <calvin@wbinvd.org>
Cc: Rodolfo Giometti <giometti@enneenne.com>,
	George Spelvin <linux@horizon.com>, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v3] pps: Fix a use-after-free
Message-ID: <2024110551-fiction-casket-7597@gregkh>
References: <2024101350-jinx-haggler-5aca@gregkh>
 <abc43b18f21379c21a4d2c63372a04b2746be665.1730792731.git.calvin@wbinvd.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <abc43b18f21379c21a4d2c63372a04b2746be665.1730792731.git.calvin@wbinvd.org>

On Mon, Nov 04, 2024 at 11:56:19PM -0800, Calvin Owens wrote:
> -	dev_info(pps->dev, "removed\n");
> +	dev_info(&pps->dev, "removed\n");

Nit, when drivers work properly,  they are quiet, no need for these
dev_info() calls.

>  static int pps_cdev_release(struct inode *inode, struct file *file)
>  {
> -	struct pps_device *pps = container_of(inode->i_cdev,
> -						struct pps_device, cdev);
> -	kobject_put(&pps->dev->kobj);
> +	struct pps_device *pps = file->private_data;
> +
> +	WARN_ON(pps->id != iminor(inode));

If this can happen, handle it and move on.  Don't just reboot the
machine if it's something that could be triggered (remember about
panic-on-warn systems.)

thanks,

greg k-h

