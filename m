Return-Path: <stable+bounces-10858-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4833D82D502
	for <lists+stable@lfdr.de>; Mon, 15 Jan 2024 09:25:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C5615B20C62
	for <lists+stable@lfdr.de>; Mon, 15 Jan 2024 08:25:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E4F55C98;
	Mon, 15 Jan 2024 08:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hkH0t46i"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 092235689
	for <stable@vger.kernel.org>; Mon, 15 Jan 2024 08:25:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E495C433F1;
	Mon, 15 Jan 2024 08:25:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705307126;
	bh=xaGnhtvwtZ3IDwAH/diSmw4UUfdlBaNyNg03un69HC4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hkH0t46iXDN+JxeuUotit4CYlZ6sK2tGXWKIHqDf8VMhVQjV47OllY2Fqo4q/Tmau
	 eOKQhSHG8KSkJo2Inc6ZDi5rPTOkUwWO5geglTtIZ/JnlCupUzYVgbrIYozYgM1zXD
	 O7BORXRTJryXbQlEHByXFl4WJZGwLvB6HLf+bE0Y=
Date: Mon, 15 Jan 2024 09:25:23 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: =?utf-8?B?0JzQsNGA0Log0JrQvtGA0LXQvdCx0LXRgNCz?= <socketpair@gmail.com>
Cc: stable@vger.kernel.org
Subject: Re: kernel BUG on network namespace deletion
Message-ID: <2024011517-nursery-flinch-3101@gregkh>
References: <CAEmTpZHU5JBkQOVWvp4i2f02et2e0v9mTFzhmxhFOE47xPyqYg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEmTpZHU5JBkQOVWvp4i2f02et2e0v9mTFzhmxhFOE47xPyqYg@mail.gmail.com>

On Mon, Jan 15, 2024 at 12:19:06PM +0500, Марк Коренберг wrote:
> Kernel 6.6.9-200.fc39.x86_64
> 
> The following bash script demonstrates the problem (run under root):
> 
> ```
> #!/bin/bash
> 
> set -e -u -x
> 
> # Some cleanups
> ip netns delete myspace || :
> ip link del qweqwe1 || :
> 
> # The bug happens only with physical interfaces, not with, say, dummy one
> ip link property add dev enp0s20f0u2 altname myname
> ip netns add myspace
> ip link set enp0s20f0u2 netns myspace
> 
> # add dummy interface + set the same altname as in background namespace.
> ip link add name qweqwe1 type dummy
> ip link property add dev qweqwe1 altname myname
> 
> # Trigger the bug. The kernel will try to return ethernet interface
> back to root namespace, but it can not, because of conflicting
> altnames.
> ip netns delete myspace
> 
> # now `ip link` will hang forever !!!!!
> ```
> 
> I think, the problem is obvious. Althougn I don't know how to fix.
> Remove conflicting altnames for interfaces that returns from killed
> namespaces ?

As this can only be triggered by root, not much for us to do here,
perhaps discuss it on the netdev mailing list for all network developers
to work on?

> On kernel 6.3.8 (at least) was another bug, that allows dulicate
> altnames, and it was fixed mainline somewhere. I have another script
> to trigger the bug on these old kernels. I did not bisect.

If this is an issue on 6.1.y, that would be good to know so that we can
try to fix the issue there if bisection can find it.  Care to share the
script so that I can test?

thanks,

greg k-h

