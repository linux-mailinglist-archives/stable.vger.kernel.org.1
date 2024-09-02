Return-Path: <stable+bounces-72718-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E5A8C968753
	for <lists+stable@lfdr.de>; Mon,  2 Sep 2024 14:15:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B84B1F2302F
	for <lists+stable@lfdr.de>; Mon,  2 Sep 2024 12:15:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA2D319E99A;
	Mon,  2 Sep 2024 12:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Vd+AhrAw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71EDF19E972;
	Mon,  2 Sep 2024 12:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725279248; cv=none; b=plp4w7bWarzBgsdlCC7k6qVI4zDDXw/+Rs9sKK1AKisPFlkAgGA0qLeir8//3Dm/m4XhTyFYJY8d0mV4JqssWGXm6I7mM3dL607CmgFUb0JPU8au/A41wBLBp+fWeVvl6Yj032qf4OcV911uV4eBQ/XSJTFCbIsp7brlwfETVU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725279248; c=relaxed/simple;
	bh=K66iJh7dpgXeq4PtEcjBBrkbXy8aMHOLByY67yAhdRQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c6arFzhvtXUMM0aG9QOVrlSZ8ZM7tdGL1OafDU0w3ZRZarTDrAFCPHoXbWNf84z+4qkwIxIlfihlsvQpfo/Qcgr0+Qc8LfkkQrJWEamF0zUE4TJHJ/V0YTiCrL6DVNrU51/7lcvpkLrH96fTr95xWKwXgvjPtsAaymF4ZvKfV4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Vd+AhrAw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56AEEC4CEC6;
	Mon,  2 Sep 2024 12:14:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725279247;
	bh=K66iJh7dpgXeq4PtEcjBBrkbXy8aMHOLByY67yAhdRQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Vd+AhrAwh7fywsxqPXQVLWolUsR7/myjfc8W4fIyOkps8GlA7Uxu7AoaUO11XAOf/
	 55PLK+tc+WQMIjUAhLWH4tSgPSV4eM90LjVHlVMdY8hqPAfhxsII7YVxOKA1HdPy97
	 Ffs7xWfNMByvuWK1kNuplUvSjKsoURt1ZKphBJ9Q=
Date: Mon, 2 Sep 2024 14:14:04 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Xu Yang <xu.yang_2@nxp.com>
Cc: linux-usb@vger.kernel.org, peter.chen@kernel.org, sashal@kernel.org,
	stable@vger.kernel.org, hui.pu@gehealthcare.com
Subject: Re: [GIT PULL] USB chipidea patches for linux-5.15.y and linux-6.1.y
Message-ID: <2024090235-baggage-iciness-b469@gregkh>
References: <20240902092711.jwuf4kxbbmqsn7xk@hippo>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240902092711.jwuf4kxbbmqsn7xk@hippo>

On Mon, Sep 02, 2024 at 05:27:11PM +0800, Xu Yang wrote:
> Hi Greg,
> 
> The below two patches are needed on linux-5.15.y and linux-6.1.y, please
> help to add them to the stable tree. 
> 
> b7a62611fab7 usb: chipidea: add USB PHY event
> 87ed257acb09 usb: phy: mxs: disconnect line when USB charger is attached
> 
> They are available in the Git repository at:
>   git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git branch usb-testing

We don't do 'git pull' for stable patches, please read the file:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

Just send them through email please.

thanks,

greg k-h

