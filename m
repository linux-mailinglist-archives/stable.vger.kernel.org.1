Return-Path: <stable+bounces-93994-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E3079D269C
	for <lists+stable@lfdr.de>; Tue, 19 Nov 2024 14:13:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C79462853A8
	for <lists+stable@lfdr.de>; Tue, 19 Nov 2024 13:13:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1835F1D04A9;
	Tue, 19 Nov 2024 13:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EuUEjr9O"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B89CF1CCB44
	for <stable@vger.kernel.org>; Tue, 19 Nov 2024 13:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732021847; cv=none; b=jb2PpMV2gBAgofHVms3z6Tbo6v7r6Izt4dXfzTcKe7ZOjCsj5Ur47sa4/A2jJXZSAyX26gfbpSXVKXV8QfrWN8eCNJZ2rwefOmKuDwxre7E3OaUp76ewONb1rZ4MPZaP3hEHslLCkuHuLnRM224PUki/InZLrwW/jqiig1LHMt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732021847; c=relaxed/simple;
	bh=N78o9BooxpnGUJrWioW1EV7PgePCIoULnfMmc8yc0hw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TzZ4HxRbJSpckpHAtIRxAvq6s9qeWnU5iOijC1sgSKBaH+/bLLI0PbxtxmOiiH+I5tvXZE6Z9vXlQyeGIZzOyGeZ7nu4h7VMgpiwMcSbpFZAX3LbIEtB3mcXbDq57B6ZrfUh7jlAoD6nph0n1MCAO4AQbFxjr26QUTYEj77d2OE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=EuUEjr9O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED410C4CEE1;
	Tue, 19 Nov 2024 13:10:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1732021847;
	bh=N78o9BooxpnGUJrWioW1EV7PgePCIoULnfMmc8yc0hw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EuUEjr9OcVIXLcfvO2RqpqbF9dtmJB2UOPh+5ToIdv5oBkOrKVFk3zywXjeBo2gWO
	 0nMqtbHsZf3DoQ824AjdMgIIfzkHWJ9D7sXN7+FalO/3X0QoD9CpxHhuaTuD4arj6T
	 wwZE44ZqmZajqyoI2esKVStH6JbGtdGPXPenoFWA=
Date: Tue, 19 Nov 2024 14:10:22 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Xiangyu Chen <xiangyu.chen@eng.windriver.com>
Cc: edumazet@google.com, stable@vger.kernel.org, xiangyu.chen@aol.com
Subject: Re: [PATCH 6.1.y 0/2] Backport fix of CVE-2024-36915 to 6.1
Message-ID: <2024111916-platform-finale-7bd5@gregkh>
References: <20241119020537.3050784-1-xiangyu.chen@eng.windriver.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241119020537.3050784-1-xiangyu.chen@eng.windriver.com>

On Tue, Nov 19, 2024 at 10:05:35AM +0800, Xiangyu Chen wrote:
> From: Xiangyu Chen <xiangyu.chen@windriver.com>
> 
> Following series is a backport of CVE-2024-36915
> 
> The fix is "nfc: llcp: fix nfc_llcp_setsockopt() unsafe copies"
> This required 1 extra commit to make sure the picks are clean:
> net: add copy_safe_from_sockptr() helper
> 
> 
> Eric Dumazet (2):
>   net: add copy_safe_from_sockptr() helper
>   nfc: llcp: fix nfc_llcp_setsockopt() unsafe copies
> 
>  include/linux/sockptr.h | 25 +++++++++++++++++++++++++
>  net/nfc/llcp_sock.c     | 12 ++++++------
>  2 files changed, 31 insertions(+), 6 deletions(-)
> 
> -- 
> 2.43.0
> 
> 

Now queued up, thanks.

greg k-h

