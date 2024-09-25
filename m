Return-Path: <stable+bounces-77690-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DAC449860B2
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 16:31:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 19646B31EDA
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 14:11:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EABF1D5AA5;
	Wed, 25 Sep 2024 12:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="uDy0qS99"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEF251D5AC8;
	Wed, 25 Sep 2024 12:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727266756; cv=none; b=a6n/EmUhrODRjWqGxbY4MMSpP0drTRtvqk0fzIAoxaxMC1qr3EvQMWtDh9mmdHIhkZyBdfZKOkAdw4m4ctAL1wNf8V4pe9Bt55oINF9f+ydmKs7/h0HT4d0Iaki0h7Jlxe1uO7PHPjrygae/KUwOAQ3/LPu0YicJ1AtEFeKXB6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727266756; c=relaxed/simple;
	bh=GBjmNGp2DyOdTduShZbVDR709sl5DDzfWr9u2Fkn4ps=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OB+q4fPBwBVzi0lNoJIjciHUIzrdn04pmakvScVageRbzpislW+GfaghDpZgEbupIl1Tda55U3+eSYc9QKRIlQ+yWSjy9Nc/UdlqO8bP71MpF26XUsfFuPFEvrPCGSoXks0SlU3CWgSliZgX+VvtiUKYxDNXYTbXOkBvMCGkVks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=uDy0qS99; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9957C4CEC3;
	Wed, 25 Sep 2024 12:19:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727266756;
	bh=GBjmNGp2DyOdTduShZbVDR709sl5DDzfWr9u2Fkn4ps=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uDy0qS99EK8Tj91CEL6aa3kc8+MzIjASdfXn7Xe7FzapRL6H5U7zHVbJ6STCL0epc
	 7GmYlwuNHD6OM1QI+yLAe+P4BtRIuTxZ6Y4dWOSBnQ6K625G8/gD5COUph2wvIuqxP
	 Sv9Jo8h2bTYv3YhbTB/4Uf4JZCK0YDh5PcSZl5AM=
Date: Wed, 25 Sep 2024 14:19:12 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Gaosheng Cui <cuigaosheng1@huawei.com>
Cc: rafael@kernel.org, akpm@linux-foundation.org,
	thunder.leizhen@huawei.com, wangweiyang2@huawei.com,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH -next 1/2] kobject: fix memory leak in kset_register()
 due to uninitialized kset->kobj.ktype
Message-ID: <2024092530-putt-democracy-e2df@gregkh>
References: <20240925120747.1930709-1-cuigaosheng1@huawei.com>
 <20240925120747.1930709-2-cuigaosheng1@huawei.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240925120747.1930709-2-cuigaosheng1@huawei.com>

On Wed, Sep 25, 2024 at 08:07:46PM +0800, Gaosheng Cui wrote:
> If a kset with uninitialized kset->kobj.ktype be registered,

Does that happen today with any in-kernel code?  If so, let's fix those
kset instances, right?

> kset_register() will return error, and the kset.kobj.name allocated
> by kobject_set_name() will be leaked.
> 
> To mitigate this, we free the name in kset_register() when an error
> is encountered due to uninitialized kset->kobj.ktype.

How did you hit this?

thanks,

greg k-h

