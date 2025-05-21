Return-Path: <stable+bounces-145811-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9263ABF26D
	for <lists+stable@lfdr.de>; Wed, 21 May 2025 13:09:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8BAF97A6311
	for <lists+stable@lfdr.de>; Wed, 21 May 2025 11:07:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 529A32609C2;
	Wed, 21 May 2025 11:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CTGTrPSa"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F344025F79C;
	Wed, 21 May 2025 11:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747825733; cv=none; b=XuaMNCeC5w42g1iKx2ClEOn2D5BrzMNTrVaDI1YqKNM0MQYyguHcYI4qbWIpFi+u/0j8Bfubb+kPTlWeNvdcrCSspit4WERJ3rrDYTnI+qi4bpFFnrwBw+gqikFD3hIrDY6dLxwAYgMBnxxsU9XsYgAXkntItwB5Zl9Vftx8fIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747825733; c=relaxed/simple;
	bh=DU9lEj51ny5qY/eu02WgK8o4IIepp1BzWBzJ768LIN8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sLLbPW51dYwTUlqdWuVbYL97PZdX9fu4Yoe2uPUDsLCoAMLloLYWIqHSaLE2wPmXhL1TuFvE7Z0pwP3Sh0PlznVuu0km++M/TX8z8VrihzGUpeZSM0Kfm/aCGgQcoCbrJjiCa8Gx36hhoLLvovaTnF2AxworeLHXsvCB26K4CI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CTGTrPSa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE884C4CEEA;
	Wed, 21 May 2025 11:08:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1747825732;
	bh=DU9lEj51ny5qY/eu02WgK8o4IIepp1BzWBzJ768LIN8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CTGTrPSaZisMA1dmjMamDDZ9jowr+m0+RqDOT7zX2VrH8X9i9dMPdPZGzIHyS/ZKr
	 dfNv8LSxuv6bhuXBldEm/Z1YNLAWhfWHHZ1rMXO9ZzlszycJ+4SkrkElHvkcY0nWl9
	 AHQ42A55/uYJoQNzkPzRGqCOoodHEwmK0sVlCMyA=
Date: Wed, 21 May 2025 13:08:49 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>
Cc: "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	John Youn <John.Youn@synopsys.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH v 3] usb: dwc2: gadget: Fix enter to hibernation for
 UTMI+ PHY
Message-ID: <2025052119-bunch-catsup-2ac0@gregkh>
References: <6242fbe1b81f16adeb96079448f0df92b6b8b664.1746442461.git.Minas.Harutyunyan@synopsys.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6242fbe1b81f16adeb96079448f0df92b6b8b664.1746442461.git.Minas.Harutyunyan@synopsys.com>

On Mon, May 05, 2025 at 11:48:02AM +0000, Minas Harutyunyan wrote:
> For UTMI+ PHY, according to programming guide, first should be set
> PMUACTV bit then STOPPCLK bit. Otherwise, when the device issues
> Remote Wakeup, then host notices disconnect instead.
> For ULPI PHY, above mentioned bits must be set in reversed order:
> STOPPCLK then PMUACTV.
> 
> Fixes: 4483ef3c1685 ("usb: dwc2: Add hibernation updates for ULPI PHY")
> Cc: stable@vger.kernel.org
> Reported-by: Tomasz Mon <tomasz.mon@nordicsemi.no>
> Signed-off-by: Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>
> ---
>  Changes in v3:
>  - Rebased on top of 6.15-rc4
>  Changes in v2:
>  - Added Cc: stable@vger.kernel.org

AS it's too late for 6.15-final, I tried to apply this to the usb-next
branch and it fails there due to other changes to this codepath.  Can
you rebase it and submit it there?

thanks,

greg k-h

