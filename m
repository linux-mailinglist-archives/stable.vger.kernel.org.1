Return-Path: <stable+bounces-52381-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 689A990ADF7
	for <lists+stable@lfdr.de>; Mon, 17 Jun 2024 14:31:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA61628512F
	for <lists+stable@lfdr.de>; Mon, 17 Jun 2024 12:31:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5423918FC6F;
	Mon, 17 Jun 2024 12:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="x/Msi+Y5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 139256E61F
	for <stable@vger.kernel.org>; Mon, 17 Jun 2024 12:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718627474; cv=none; b=aPl+JUeE/vGR8wLZQlwUfuqjkr9b/2OI6iA43Iozj1Wj9NR7otSfUP1sivXgP5JhXF9HWMHAc0M/ivW8wUP6uEZVSKoRxcqRMjGl/A3XLBD/8dUbsiqHa0KdnNW7/thtuIArYBPTPI6bOYzXusAfIQqBn4eVnW1O7wZTOe2hVnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718627474; c=relaxed/simple;
	bh=7qCcpemMgLa2Uj+m4grOdXaMoeYPRSQLUIApVaCL88w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aLiXraB7f5S+FZFpmfRBAYxvoFJG6TYi0zkzchnd1vCI6awYgHMyBrcrhTP3VY+i+t6OL3TfPfv40yZmSEQH9Zi5AR5W6sQGKUglpPnmeakxBNV3C1doW9ok6p6xpYCci9DKz3JFWD+KxIl/7+5eBAXDcAeKk3fY8IYKbjPpTxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=x/Msi+Y5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B3ABC2BD10;
	Mon, 17 Jun 2024 12:31:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718627473;
	bh=7qCcpemMgLa2Uj+m4grOdXaMoeYPRSQLUIApVaCL88w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=x/Msi+Y5ETY/BsaULU/DkLNRFxchi7wqsTo7bhLBDuDqLxEawX/JHGnvC0xyioVKZ
	 ROAw4C/qW9SOkC3//78OKXMeZM1K37Dnvhvq9JNSJskc17hDxmm1LC0ezqYtELu2gS
	 d3w4r4VzX0eggVUW3kZk5cnDQsYMJ5QzGpxdXPSI=
Date: Mon, 17 Jun 2024 14:31:10 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jason Andryuk <jandryuk@gmail.com>
Cc: stable@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Peter Hutterer <peter.hutterer@who-t.net>,
	Jason Andryuk <jason.andryuk@amd.com>
Subject: Re: [PATCH v2] Input: try trimming too long modalias strings
Message-ID: <2024061700-barber-prong-643f@gregkh>
References: <20240613015251.88897-1-jandryuk@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240613015251.88897-1-jandryuk@gmail.com>

On Wed, Jun 12, 2024 at 09:52:51PM -0400, Jason Andryuk wrote:
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
> [ Apply to linux-5.15.y ]
> Signed-off-by: Jason Andryuk <jason.andryuk@amd.com>
> ---
> Built with 5.15 and 4.19.  Tested on 5.15.
> 
> Drop const from struct input_dev *id
> Declare i outside loop:
> 
> drivers/input/input.c: In function ‘input_print_modalias_parts’:
> drivers/input/input.c:1393:25: error: ‘for’ loop initial declarations are only allowed in C99 or C11 mode
>  1393 |                         for (int i = size - 1 - remainder - 3; i >= 0; i--) {
>       |                         ^~~
> ---
>  drivers/input/input.c | 105 ++++++++++++++++++++++++++++++++++++------
>  1 file changed, 90 insertions(+), 15 deletions(-)

Both now queued up, thanks.

greg k-h

