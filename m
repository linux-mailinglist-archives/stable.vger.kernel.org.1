Return-Path: <stable+bounces-171790-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D6954B2C3DA
	for <lists+stable@lfdr.de>; Tue, 19 Aug 2025 14:39:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0D7C189BBB8
	for <lists+stable@lfdr.de>; Tue, 19 Aug 2025 12:35:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81AC23043B8;
	Tue, 19 Aug 2025 12:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="oGkkcDdr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E2302DE1FC
	for <stable@vger.kernel.org>; Tue, 19 Aug 2025 12:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755606836; cv=none; b=tjcvv9AJ/poL6LUeySwo03Tzn0YOGo9i6zvkf4OLh/ZsMlbJ9C8AQOyIFyxT7aRgZXlJenlRSYIqZi0iNaojS+M1BpK5IzXRhtDdiomt5dFJZo069Uoe4Zkgv2MA8oEdizG7S9QcpUR+7/EfQ7djXVObU2kne1ndH4rB9JIq+1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755606836; c=relaxed/simple;
	bh=h3xe9ea4JxHyqGBnjW9AZQ8mw8AR3FV8kJGSslo43F4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hHDPw+ph77gSgZVSKNpbBSejRYtBp1KDvL+3igx1JC4AKB4pQv9lpRtz0xL8t0N/qs1dplwJyK45EQh81FF6sx4/2fV7ABh43X0i9jgYizBzQLEUo32bGPgR8lKa++c4DaagC6DzJPU7pb4e9TxyVo0a3qDSCRkOwUxriGHTJHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=oGkkcDdr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76EB3C4CEF1;
	Tue, 19 Aug 2025 12:33:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755606836;
	bh=h3xe9ea4JxHyqGBnjW9AZQ8mw8AR3FV8kJGSslo43F4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oGkkcDdr8uIk0Ouu7EaB/2NZI0xYCbmGR2Eq+Ex+px/eHHuw11SYhEo4rEW0hmZbm
	 mwn0S9fKHE87CSBRs3WtNhnoHdaQJmd91kk6Eahcyul4sXZXj+IXrkjMJq1JsKB8k7
	 N7i7c/mUMq2oAWT3Z+JV/UddxLeLEfOqbPq2XIKA=
Date: Tue, 19 Aug 2025 14:33:52 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Yann Sionneau <yann.sionneau@vates.tech>
Cc: stable@vger.kernel.org, Li Zhong <floridsleeves@gmail.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Teddy Astie <teddy.astie@vates.tech>, Dillon C <dchan@dchan.tech>
Subject: Re: [PATCH] ACPI: processor: idle: Check acpi_bus_get_device return
 value
Message-ID: <2025081933-profound-wobbly-0205@gregkh>
References: <20250819115301.83377-1-yann.sionneau@vates.tech>
 <032a8ac9-0554-49b6-a8e4-fdeb467f8327@vates.tech>
 <2025081900-compost-bounce-f915@gregkh>
 <6f616f3a-a826-489f-860c-9f25fc42736f@vates.tech>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6f616f3a-a826-489f-860c-9f25fc42736f@vates.tech>

On Tue, Aug 19, 2025 at 12:17:40PM +0000, Yann Sionneau wrote:
> On 8/19/25 14:12, Greg KH wrote:
> > On Tue, Aug 19, 2025 at 12:03:05PM +0000, Yann Sionneau wrote:
> >> On 8/19/25 14:00, Yann Sionneau wrote:
> >>> From: Teddy Astie <teddy.astie@vates.tech>
> >>>
> >>> Fix a potential NULL pointer dereferences if acpi_bus_get_device happens to fail.
> >>> This is backported from commit 2437513a814b3 ("ACPI: processor: idle: Check acpi_fetch_acpi_dev() return value")
> >>> This has been tested successfully by the reporter,
> >>> see https://xcp-ng.org/forum/topic/10972/xcp-ng-8.3-lts-install-on-minisforum-ms-a2-7945hx
> >>>
> >>> Signed-off-by: Li Zhong <floridsleeves@gmail.com>
> >>> Signed-off-by: Teddy Astie <teddy.astie@vates.tech>
> >>> Signed-off-by: Yann Sionneau <yann.sionneau@vates.tech>
> >>> Reported-by: Dillon C <dchan@dchan.tech>
> >>> Tested-by: Dillon C <dchan@dchan.tech>
> >>> ---
> >>
> >> Hello Greg, all,
> >>
> >> This should be picked for v5.4, v5.10 and v5.15 branches as it's already
> >> been backported in v6.0 and v6.1.
> >>
> >> I already reached out about this a few weeks ago, I just waited for the
> >> patch the be tested before sending it.
> > 
> > What is the upstream git commit id?
> 
> Hi Greg,
> 
> commit 2437513a814b ("ACPI: processor: idle: Check acpi_fetch_acpi_dev() 
> return value"): 
> https://github.com/torvalds/linux/commit/2437513a814b3e93bd02879740a8a06e52e2cf7d
> 
> Sorry I should have put "[ Upstream commit XXXX ]" I guess... Will do 
> next time. Do I re-send?

Yes, please resend a new version so our tools can handle it.

thanks,

greg k-h

