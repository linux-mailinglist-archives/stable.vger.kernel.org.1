Return-Path: <stable+bounces-50306-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 09814905993
	for <lists+stable@lfdr.de>; Wed, 12 Jun 2024 19:09:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C32C1F2367C
	for <lists+stable@lfdr.de>; Wed, 12 Jun 2024 17:08:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A934181D1D;
	Wed, 12 Jun 2024 17:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Ojw/f4YF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D16EF3209;
	Wed, 12 Jun 2024 17:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718211873; cv=none; b=jelJr2Uh/z28vv0FrwmhQ/meSNCsghjfxhRM6GxE0AvAGl/pDl1KS/VfORIL037pJnOT38Halxu+sNJBnSyhItKowuZgHz8vxjN+cwyHgMB3bTqe73KukaJyxBKHA+h/xTEe+5tqTbjxWi0ok0nWBO1yzosxqX7w0OBK0Yf+clg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718211873; c=relaxed/simple;
	bh=eEu/LTyHBMSJnYyryiF1HaWA39LlejyWxovQ41ErphI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r5IdG6E3SMnsLafOHbZDLTbCOkphiePLnLN7H6UXgqIF9KsIcHiYKP2iP7rqS7OF0uvKINfYCbCqmSFPGaYfBDqDxGDaxx+tLyDEp8ALo5ra490xpEBJMbH6d00UO20fXcZ6ctM86KKWCuuvQX5gKhTKP0ep7zFucJ3AB/+bupI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Ojw/f4YF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7620C116B1;
	Wed, 12 Jun 2024 17:04:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718211871;
	bh=eEu/LTyHBMSJnYyryiF1HaWA39LlejyWxovQ41ErphI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ojw/f4YFFfn8ti2URmerLmHvdi+FsAGtnkbE/lQrqZXJm/SbIsD7WopUV6eReBtD9
	 JlEtgMLAAZuNd5e3w68x+N3Q/selcIn5kqmyt+xycM7McXFg8CGEZFC87awfhYEV9b
	 NZEsEAOg7x8Ob+D4pZEEmUoLgfp8fV5xtquElgWY=
Date: Wed, 12 Jun 2024 19:04:28 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: joswang <joswang1221@gmail.com>
Cc: Thinh.Nguyen@synopsys.com, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Jos Wang <joswang@lenovo.com>
Subject: Re: [PATCH v4, 3/3] usb: dwc3: core: Workaround for CSR read timeout
Message-ID: <2024061203-good-sneeze-f118@gregkh>
References: <20240601092646.52139-1-joswang1221@gmail.com>
 <20240612153922.2531-1-joswang1221@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240612153922.2531-1-joswang1221@gmail.com>

On Wed, Jun 12, 2024 at 11:39:22PM +0800, joswang wrote:
> From: Jos Wang <joswang@lenovo.com>
> 
> This is a workaround for STAR 4846132, which only affects
> DWC_usb31 version2.00a operating in host mode.
> 
> There is a problem in DWC_usb31 version 2.00a operating
> in host mode that would cause a CSR read timeout When CSR
> read coincides with RAM Clock Gating Entry. By disable
> Clock Gating, sacrificing power consumption for normal
> operation.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Jos Wang <joswang@lenovo.com>
> ---
> v1 -> v2:
> - add "dt-bindings: usb: dwc3: Add snps,p2p3tranok quirk" patch,
>   this patch does not make any changes
> v2 -> v3:
> - code refactor
> - modify comment, add STAR number, workaround applied in host mode
> - modify commit message, add STAR number, workaround applied in host mode
> - modify Author Jos Wang
> v3 -> v4:
> - modify commit message, add Cc: stable@vger.kernel.org

This thread is crazy, look at:
	https://lore.kernel.org/all/20240612153922.2531-1-joswang1221@gmail.com/
for how it looks.  How do I pick out the proper patches to review/apply
there at all?  What would you do if you were in my position except just
delete the whole thing?

Just properly submit new versions of patches (hint, without the ','), as
the documentation file says to, as new threads each time, with all
commits, and all should be fine.

We even have tools that can do this for you semi-automatically, why not
use them?

thanks,

greg k-h

