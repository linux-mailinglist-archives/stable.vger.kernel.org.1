Return-Path: <stable+bounces-152291-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB160AD361C
	for <lists+stable@lfdr.de>; Tue, 10 Jun 2025 14:26:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B2C73ABCF5
	for <lists+stable@lfdr.de>; Tue, 10 Jun 2025 12:25:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23F28291877;
	Tue, 10 Jun 2025 12:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t4RfRdZd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5FB5291870;
	Tue, 10 Jun 2025 12:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749558367; cv=none; b=DenTMyKmo+QVDl4NShpHxHwOWqS5kDip0ODsnff/b1b2Kwhj03EcDGxQgWokxxXZd0WuBBqf1uka75NSOOBLafBtsjCtfsspqGjPorbnxoafAOxAi8fLAeFtxqK+XnrgMJZK1V/XM9FTrf2Sd3YCeIjUBgwfkhLijZcNrau2aO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749558367; c=relaxed/simple;
	bh=QB4/CDRyNJLJV/BoZ0SgfWs+wIHNtm+r1nCerSN5cXs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eHWkqB0LDVzaLircop1UVDKoOxHm9XTvLVNEcTqenKvOY6arSt03Q00DgwXotknnuQZ1GK2gvPeyr+s9zj4soQZLI8MJlrbOhqyOAN1wcDczLcs3TLWwqYrm8OPIVJIEykL4ZIdULNzJ4OmHVhePeWeAAotoGGnx2kH/OL7NlPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t4RfRdZd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B90C9C4CEED;
	Tue, 10 Jun 2025 12:26:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749558367;
	bh=QB4/CDRyNJLJV/BoZ0SgfWs+wIHNtm+r1nCerSN5cXs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=t4RfRdZdNSkEFTHsVnYntpuTd8pJpFF8rDcjgnnEal0FKOtJ2sQQ68UGWxmScYqsM
	 xXYEUhbgmWfVweQFoW2HDXFThInOAC5o+gKm1dQIXeYoGQTODq7t0+l+quG3KAsP2g
	 P74IzC2lMdWNVpzGvWSL/gmhgjoToh/K8exnM09K/zXuH9RRVMltbxYh5MpawT5d6l
	 1hGCx+ptmxnc1OY4ru7zXuQoV8VOXH/ufaHT2KTxR9kA/K2Aq803ZHVd0RH4f62e50
	 D5iaMYdBaxjtU6ciRvFvrZTO2noXpzuH4xrB4VGB2PaIBTwDhwzz9Ex0Sw1cAiEl/O
	 SGvmWdeMY1Z1w==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1uOy3I-000000005Dg-401k;
	Tue, 10 Jun 2025 14:26:05 +0200
Date: Tue, 10 Jun 2025 14:26:04 +0200
From: Johan Hovold <johan@kernel.org>
To: stable@vger.kernel.org
Cc: stable-commits@vger.kernel.org, gregkh@linuxfoundation.org
Subject: Re: Patch "USB: serial: bus: fix const issue in
 usb_serial_device_match()" has been added to the 6.15-stable tree
Message-ID: <aEgkXORtnPqvSEf2@hovoldconsulting.com>
References: <20250610121813.1558278-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250610121813.1558278-1-sashal@kernel.org>

Hi Sasha,

On Tue, Jun 10, 2025 at 08:18:13AM -0400, Sasha Levin wrote:
> This is a note to let you know that I've just added the patch titled
> 
>     USB: serial: bus: fix const issue in usb_serial_device_match()
> 
> to the 6.15-stable tree which can be found at:
>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> 
> The filename of the patch is:
>      usb-serial-bus-fix-const-issue-in-usb_serial_device_.patch
> and it can be found in the queue-6.15 subdirectory.
> 
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.
> 
> 
> 
> commit 0e91be50efc1a26ec9047dadc980631d31ef8578
> Author: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Date:   Wed May 21 15:41:34 2025 +0200
> 
>     USB: serial: bus: fix const issue in usb_serial_device_match()
>     
>     [ Upstream commit 92cd405b648605db4da866f3b9818b271ae84ef0 ]
>     
>     usb_serial_device_match() takes a const pointer, and then decides to
>     cast it away into a non-const one, which is not a good thing to do
>     overall.  Fix this up by properly setting the pointers to be const to
>     preserve that attribute.
>     
>     Fixes: d69d80484598 ("driver core: have match() callback in struct bus_type take a const *")
>     Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>     Signed-off-by: Johan Hovold <johan@kernel.org>
>     Signed-off-by: Sasha Levin <sashal@kernel.org>

This patch does not need to be backported and I left out the stable
patch on purpose as usual.

Please drop.

Johan

