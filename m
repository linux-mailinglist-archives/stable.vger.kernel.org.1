Return-Path: <stable+bounces-62580-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AF5C293F932
	for <lists+stable@lfdr.de>; Mon, 29 Jul 2024 17:14:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 39B5CB21D4A
	for <lists+stable@lfdr.de>; Mon, 29 Jul 2024 15:14:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A062C15624C;
	Mon, 29 Jul 2024 15:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ankzdU3c"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E1F61487D6
	for <stable@vger.kernel.org>; Mon, 29 Jul 2024 15:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722266092; cv=none; b=M3H7G9MGbsy7WMrx8VrqYCltxjYvPTZqP9m5/nEbQLQ18YR7d7lDe3BnwFX9CDe4vWjxk+4zGUc4xlJck0bc0PozQNURlfLFJzzHAngcAsHbCvg5i5QETrDv9jBuIbTOCoozZsg2ITVqLtHHt0Z63+l/o/ENxV9EEwDr3lgOCXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722266092; c=relaxed/simple;
	bh=KUp2Vvf/BvDZG8+AN+5AJXXvPqZYop8+ZT5mfdtJoUQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O6N6a2Yxhf0p0rOiMdQ73owg7wxirrKQkuCWHIZ08MdW/ydTYUGFDTP3wRND42HGEZ74X+zPyFSSq7N+53690AczO64DAGxS6eYnuU+w/NPAL1NT3h+SrqRpfHmed6bVYkag+1KAlCDO+orrooFHciUKmadi8ennYK/0aNepbIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ankzdU3c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C14BC32786;
	Mon, 29 Jul 2024 15:14:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722266091;
	bh=KUp2Vvf/BvDZG8+AN+5AJXXvPqZYop8+ZT5mfdtJoUQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ankzdU3c9SyGRqeW8gS2wAn4seTjY5Fn2ewtaSE8WboXvoqhoGitrKdtsGMUFwz9H
	 yuGmWFCw4mKyCcHhdt6oN3SBvxws4gau/S0GyhudVVsLFZFIKl76MdkQ8EoDkBG22x
	 4WZJ6pdEPN68DsBLqx+9asxdTkLwbEWs98F5UT0E=
Date: Mon, 29 Jul 2024 17:14:48 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: chenhuacai@loongson.cn, stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] LoongArch: Define __ARCH_WANT_NEW_STAT in
 unistd.h" failed to apply to 6.10-stable tree
Message-ID: <2024072936-peddling-escalate-298b@gregkh>
References: <2024072921-props-yam-bb2b@gregkh>
 <CAAhV-H6vXEaJf9NO9Lqh0xKoFAehtOOOLQVO4j5v+_tD7oKEXQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAhV-H6vXEaJf9NO9Lqh0xKoFAehtOOOLQVO4j5v+_tD7oKEXQ@mail.gmail.com>

On Mon, Jul 29, 2024 at 10:36:28PM +0800, Huacai Chen wrote:
> Hi, Greg,
> 
> For stable kernels before 6.11 please use this patch, thanks.
> 
> https://lore.kernel.org/loongarch/20240511100157.2334539-1-chenhuacai@loongson.cn/

Please submit it here in a format we can apply it in.

thanks,

greg k-h

