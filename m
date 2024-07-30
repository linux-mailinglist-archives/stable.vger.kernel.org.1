Return-Path: <stable+bounces-62634-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A8E4940845
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 08:21:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EF129B22956
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 06:21:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94DBC16B75D;
	Tue, 30 Jul 2024 06:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JmrfFXmG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38C4915FCEB;
	Tue, 30 Jul 2024 06:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722320459; cv=none; b=R24GVbgIQ59oCS5nHnGgGlTuxsOceaOWGMtEMOa0RRd3WCLVqjPTMjVYa4+b1rNSJE2XHGIwW8A6heFcmyoV+U1PtJWZKpzBWFFt+8qMVE+PJ49SKjrdm6iuxqyPUglY/9rVTHbZzB6xKaTwyYzV8WoStxjCvS6jYx/xd02ms3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722320459; c=relaxed/simple;
	bh=ZEn+kLQh+MCk0r4OKoaJ3rs4HBr/OuaPYlVIDQjhFZQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=th3FG9mpq/EAdUuCBg4kulzNCvngKa3WxBoUIi646P3fD41DQLYDa9D9ny1V3eYfkyLjLC3ZjjOSh4DHK35NnlX0oXsnNmtOsqI5nTO1qsDQsuG06Gds9kXpKD8ercoGwv+q1nnAgbkZo1A4nLjUZiBPPF0dWEbQqPfymAXnNN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JmrfFXmG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48211C4AF09;
	Tue, 30 Jul 2024 06:20:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722320458;
	bh=ZEn+kLQh+MCk0r4OKoaJ3rs4HBr/OuaPYlVIDQjhFZQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JmrfFXmGjMwrYowxZg80Od6UI+qnsVaIH7qtah4m2wZpfj/XrPE90VovwNrzrjkGm
	 6kBkvs6sIpWmCQZyT/1TGWViL3CnjErkVHJ+lkwMCWMkf76N7yO44CoHI0baczNS7M
	 7lwNzo/U3nQlmmOhhjBACJoJnQwK1OtJb0KEll/4=
Date: Tue, 30 Jul 2024 08:20:55 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: "Lin, Wayne" <Wayne.Lin@amd.com>
Cc: "kevin@holm.dev" <kevin@holm.dev>,
	Linux regressions mailing list <regressions@lists.linux.dev>,
	"Deucher, Alexander" <Alexander.Deucher@amd.com>,
	"Wu, Hersen" <hersenxs.wu@amd.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	ML dri-devel <dri-devel@lists.freedesktop.org>,
	"amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [REGRESSION] No image on 4k display port displays connected
 through usb-c dock in kernel 6.10
Message-ID: <2024073028-rectified-antler-a65b@gregkh>
References: <d74a7768e957e6ce88c27a5bece0c64dff132e24@holm.dev>
 <9ca719e4-2790-4804-b2cb-4812899adfe8@leemhuis.info>
 <fd8ece71459cd79f669efcfd25e4ce38b80d4164@holm.dev>
 <CO6PR12MB54896312D4BEAE30963FDC5EFCB02@CO6PR12MB5489.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CO6PR12MB54896312D4BEAE30963FDC5EFCB02@CO6PR12MB5489.namprd12.prod.outlook.com>

On Tue, Jul 30, 2024 at 05:56:42AM +0000, Lin, Wayne wrote:
> [Public]
> 
> Hi,
> Thanks for the report.
> 
> Patch fa57924c76d995 ("drm/amd/display: Refactor function dm_dp_mst_is_port_support_mode()")
> is kind of correcting problems causing by commit:
> 4df96ba6676034 ("drm/amd/display: Add timing pixel encoding for mst mode validation")
> 
> Sorry if it misses fixes tag and would suggest to backport to fix it. Thanks!

Please submit a backported version to the stable@vger.kernel.org list
and we will be glad to consider it.

thanks,

greg k-h

