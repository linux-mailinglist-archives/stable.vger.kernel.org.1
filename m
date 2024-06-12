Return-Path: <stable+bounces-50234-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D2AA9905237
	for <lists+stable@lfdr.de>; Wed, 12 Jun 2024 14:17:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBDCF1C23573
	for <lists+stable@lfdr.de>; Wed, 12 Jun 2024 12:17:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C8AD16D32E;
	Wed, 12 Jun 2024 12:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="daHXnVzA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48C7115622F
	for <stable@vger.kernel.org>; Wed, 12 Jun 2024 12:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718194631; cv=none; b=lnNEsuRKdfRv0KCly9ZyD+gLYekzN6CUeSYvMggFtJ2MJf2FLdnx7SIIvWXDgTUiTOew4H737cfMBirSuXo0ItamCLYKMXPDu+7KSE/dqPHUg2NhjYdN0wBOveGYmnOWCL6VtUpXm4S/SVj0oKeHzIMgSeUTcgNrRnUiIC7i9zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718194631; c=relaxed/simple;
	bh=5xgA4F9e/ks0jHXuR6XPVusfGTBNtT/6UekZ/RRmxqc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F4zvgxDAbvGyXzlMY5C2puGv4fM1OpkRt8+6+BbGYFw7K/uXPbwL8gTsD+VbkOT0/LSc3OZKv2UxcraN8iEeBPYNMzoktJmoK3lPTllodQsk2ajifbFhE0bl3UZIvWntB+UrzZELDQ1Ej3VUuekUXq4QxxOjVJ9ccllHIBrGTXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=daHXnVzA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 578C2C3277B;
	Wed, 12 Jun 2024 12:17:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718194630;
	bh=5xgA4F9e/ks0jHXuR6XPVusfGTBNtT/6UekZ/RRmxqc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=daHXnVzAkGQQQXdo8XNBQi9BmNwC/GYjXNoJY5QLPDWJ5PaHREcO5g2ZFBIEq3xSV
	 JMCGrE73elyNKoo9FR6HWusactelNjtvl7YTQbkW4AYuz3S3fWg69P2ATIlHgycDf2
	 wJLBthzCbC/ivofz6IzkoadTf5h83XYeSeKhM0Mk=
Date: Wed, 12 Jun 2024 14:17:08 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jason Andryuk <jandryuk@gmail.com>
Cc: stable@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Peter Hutterer <peter.hutterer@who-t.net>,
	Jason Andryuk <jason.andryuk@amd.com>
Subject: Re: [PATCH] Input: try trimming too long modalias strings
Message-ID: <2024061236-amnesty-eloquence-16bb@gregkh>
References: <20240527195557.15351-1-jandryuk@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240527195557.15351-1-jandryuk@gmail.com>

On Mon, May 27, 2024 at 03:55:57PM -0400, Jason Andryuk wrote:
> From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> 
> commit 0774d19038c496f0c3602fb505c43e1b2d8eed85 upstream.
> 
> If an input device declares too many capability bits then modalias
> string for such device may become too long and not fit into uevent
> buffer, resulting in failure of sending said uevent. This, in turn,
> may prevent userspace from recognizing existence of such devices.
> 
> This is typically not a concern for real hardware devices as they have
> limited number of keys, but happen with synthetic devices such as
> ones created by xen-kbdfront driver, which creates devices as being
> capable of delivering all possible keys, since it doesn't know what
> keys the backend may produce.
> 
> To deal with such devices input core will attempt to trim key data,
> in the hope that the rest of modalias string will fit in the given
> buffer. When trimming key data it will indicate that it is not
> complete by placing "+," sign, resulting in conversions like this:
> 
> old: k71,72,73,74,78,7A,7B,7C,7D,8E,9E,A4,AD,E0,E1,E4,F8,174,
> new: k71,72,73,74,78,7A,7B,7C,+,
> 
> This should allow existing udev rules continue to work with existing
> devices, and will also allow writing more complex rules that would
> recognize trimmed modalias and check input device characteristics by
> other means (for example by parsing KEY= data in uevent or parsing
> input device sysfs attributes).
> 
> Note that the driver core may try adding more uevent environment
> variables once input core is done adding its own, so when forming
> modalias we can not use the entire available buffer, so we reduce
> it by somewhat an arbitrary amount (96 bytes).
> 
> Reported-by: Jason Andryuk <jandryuk@gmail.com>
> Reviewed-by: Peter Hutterer <peter.hutterer@who-t.net>
> Tested-by: Jason Andryuk <jandryuk@gmail.com>
> Link: https://lore.kernel.org/r/ZjAWMQCJdrxZkvkB@google.com
> Cc: stable@vger.kernel.org
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> [ Apply to linux-6.1.y ]
> Signed-off-by: Jason Andryuk <jason.andryuk@amd.com>
> ---
> Patch did not automatically apply to 6.1.y because
> input_print_modalias_parts() does not have const on *id.
> 
> Tested on 6.1.  Seems to also apply and build on 5.4 and 4.19.

How was this tested?

It blows up the build on all branches, 6.1 and older kernels with a ton
of errors like:
drivers/input/input.c: In function ‘input_print_modalias_parts’:
drivers/input/input.c:1397:40: error: passing argument 4 of ‘input_print_modalias_bits’ discards ‘const’ qualifier from pointer target type [-Werror=discarded-qualifiers]
 1397 |                                 'e', id->evbit, 0, EV_MAX);
      |                                      ~~^~~~~~~


And so on.

Are you sure you sent the right patch?

thanks,

greg k-h

