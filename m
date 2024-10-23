Return-Path: <stable+bounces-87834-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 542B19ACC25
	for <lists+stable@lfdr.de>; Wed, 23 Oct 2024 16:20:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00A3C1F2130F
	for <lists+stable@lfdr.de>; Wed, 23 Oct 2024 14:20:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5DEB1BE238;
	Wed, 23 Oct 2024 14:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MwU1zGbp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 716231BD50C;
	Wed, 23 Oct 2024 14:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729693239; cv=none; b=H7iGvBIOyGaS2APKK8YRy4svk3xBgj2pHUkPbG9qo8g+d/ZcHS2rbO68ly124AaA+eeS/tWE/+gQ3u9vBUv6pNvX3qWQcN/6l6Y429S0kOIaaQ7kYVMOoS1g3ghOsBMhmm2DapmvnZTwtSRUhJvY4dvCM8ghQq2bW4PY/kgmw8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729693239; c=relaxed/simple;
	bh=r4vKHBQNc7+Rj1xv/XLUh/604mYqk8ocsSiBZB7Z9D8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dx7nnBoRGVwIp1vkm4HwDcy3bHLK8pSWNtTGP0rZR7fqrCbVOQWarcsWLklbH8YsyQygIHvtQNJzWde4sqyHxCarRlETP4W8eOQT/ImDvg8kRyc2rgRjf5fH/FFXkM01dAT6PKewxHMiGA2K3k+vh0AlorYJ7KhXAU0OmftHHmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MwU1zGbp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07F4FC4CEC6;
	Wed, 23 Oct 2024 14:20:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729693239;
	bh=r4vKHBQNc7+Rj1xv/XLUh/604mYqk8ocsSiBZB7Z9D8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MwU1zGbpF8ppts0KB5EGCUqCuLvkXM/9kddQMSqwxgHReXGzbM75caGYUXJyD3Ssc
	 fIj9NKUwpknkHrSxPR/+4psXMCCHULUUEa3o0dO/qMrK4wn2yeZwvSBkkmvU9dOZfB
	 7JkBzkxOChLzsAuZzmN80gDbfFEBKExNimeOiM0bVJA9Pd9l8MNj6jnpnMOelVkhr/
	 430S0b5/LYrRsI4mNzndegqMt4xdgiYFY2p8vcgQkHpzzJ+XlMfwJ/YVg9Gp36PC6x
	 WfbBY+2vkdW9nXb2xPaJUnahP5y6rRyUbLM+bTaCXeiIT66k+Qt5C6w/j8pqATHFSQ
	 PcRPDw0u0Tc9g==
Date: Wed, 23 Oct 2024 10:20:37 -0400
From: Sasha Levin <sashal@kernel.org>
To: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Jiri Slaby <jirislaby@kernel.org>, stable@vger.kernel.org,
	stable-commits@vger.kernel.org,
	Rodolfo Giometti <giometti@enneenne.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"David S. Miller" <davem@davemloft.net>
Subject: Re: Patch "tty/serial: Make ->dcd_change()+uart_handle_dcd_change()
 status bool active" has been added to the 6.1-stable tree
Message-ID: <ZxkGNdh6cQnKEpSt@sashalap>
References: <20241022175403.2844928-1-sashal@kernel.org>
 <a07de63f-1723-440d-802c-6bedefec7f24@kernel.org>
 <ZxjidR9PG2vfB_De@sashalap>
 <28b8da74-02ff-8b2d-4eca-74062dc84946@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <28b8da74-02ff-8b2d-4eca-74062dc84946@linux.intel.com>

On Wed, Oct 23, 2024 at 02:56:06PM +0300, Ilpo Järvinen wrote:
>On Wed, 23 Oct 2024, Sasha Levin wrote:
>
>> On Wed, Oct 23, 2024 at 08:25:12AM +0200, Jiri Slaby wrote:
>> > On 22. 10. 24, 19:54, Sasha Levin wrote:
>> > > This is a note to let you know that I've just added the patch titled
>> > >
>> > >     tty/serial: Make ->dcd_change()+uart_handle_dcd_change() status bool
>> > > active
>> >
>> > This is a cleanup, not needed in stable. (Unless something context-depends
>> > on it.)
>>
>> The 3 commits you've pointed out are a pre-req for 30c9ae5ece8e ("xhci:
>> dbc: honor usb transfer size boundaries.").
>
>Hi Sasha,
>
>I wonder if that information could be added automatically into the
>notification email as it feels useful to know?
>
>I assume there's some tool which figures these pre-reqs out, if it's based
>on manual work, please disregard my suggestion.

We already add a tag to indicate the dependency, sometimes folks miss it.

In the case of this patch, here it is:
https://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git/tree/queue-6.1/tty-serial-make-dcd_change-uart_handle_dcd_change-st.patch#n25

-- 
Thanks,
Sasha

