Return-Path: <stable+bounces-95946-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AEC089DFCD7
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 10:13:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A67CB21083
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 09:13:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F79B1FA157;
	Mon,  2 Dec 2024 09:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QdNLDQcd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C6F11F8AD8
	for <stable@vger.kernel.org>; Mon,  2 Dec 2024 09:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733130829; cv=none; b=q88rTi/ynfakpqoaFtxRonHYn27/V0cIMD62pMejGGwhzAWEf1+oUwDJD0YvhNqicgl4IhT0GfOqzbE7O+hxpXanXU9pmNmXlwIvxIP1vOQFOIH/8l0j0ZwR/U4XHoryECK/HN+wdPxjymlpC0Hh9Q528Hk9DDHW2p4sjnHvnr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733130829; c=relaxed/simple;
	bh=4Aza7VePAmQrxk/5GiJkdvZehtgxvLRkIkXBIjwvpCQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mU2vubQr9+W4opP3fvcG2RfHP4UyicT8x0LQS/+VQLAiItV44KUHc5S+ZNMbMCRwXeo7AP1CPUQv817Jq2kNk6drOH8Pq98Tw0y0Mnq1EN8KSu9w7wW7WyAkhAOYNF2ClBuv1QWZZnmuVRjGdsp8I8P11VKTJyzJRew+zKufdLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QdNLDQcd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FD45C4CEDA;
	Mon,  2 Dec 2024 09:13:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733130828;
	bh=4Aza7VePAmQrxk/5GiJkdvZehtgxvLRkIkXBIjwvpCQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QdNLDQcd6CX5DIkfgLL/lT8tSyB4O5j6L1+4uy5Q7vMymlRg3qb0bB2IEK+aL5KOY
	 goopUQk775lkUTrAh3Uu5ZLYOpB1R48Itcqponw6vJs7WfiEFcmdj4t2dNIrArXQX5
	 aE9B86/1g2BRnQLeZOp3gesuB6k1YIM6VJGg98sA=
Date: Mon, 2 Dec 2024 10:13:45 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Mathias Nyman <mathias.nyman@linux.intel.com>
Cc: stable@vger.kernel.org, hadrosaur@google.com,
	=?utf-8?Q?=C5=81ukasz?= Bartosik <ukaszb@chromium.org>
Subject: Re: [PATCH] xhci: dbc: Fix STALL transfer event handling
Message-ID: <2024120238-comma-freely-23ab@gregkh>
References: <20241122154146.3694205-1-mathias.nyman@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241122154146.3694205-1-mathias.nyman@linux.intel.com>

On Fri, Nov 22, 2024 at 05:41:46PM +0200, Mathias Nyman wrote:
> commit 9044ad57b60b0556d42b6f8aa218a68865e810a4 upstream
> Backport targeted specifically for linux-6.6.y stable kernel.
> Resolve minor conflict due to 10-patch dbc cleanup series in 6.8

Breaks the build :(


