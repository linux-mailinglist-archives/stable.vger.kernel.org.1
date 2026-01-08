Return-Path: <stable+bounces-206285-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 52055D03B8D
	for <lists+stable@lfdr.de>; Thu, 08 Jan 2026 16:17:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5ACDA30754A9
	for <lists+stable@lfdr.de>; Thu,  8 Jan 2026 15:09:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43EF3439001;
	Thu,  8 Jan 2026 09:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DDvn1iS4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47562432FAD
	for <stable@vger.kernel.org>; Thu,  8 Jan 2026 09:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767864263; cv=none; b=ISu1gXeS/fdrg7O81hobADMVx2aw45GOjWu2KGrn6aKYSFA5FnyCov0/GBj+mPNJTWsTvjThGR+bzXp4Ac9sjB0D9+ecCDeXZt8q6a7fM8fdMQEpG4RFdQOA5B9ucmp90DLlAGSy2ql4rWh9FmrmdxHFHEomTFJ55OvdGG39Ae4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767864263; c=relaxed/simple;
	bh=dg9P9yjyGH34rjEIFze9JRWswvIj7XWVKK+K7goE7mw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FsL4qeHDBZ7Sq5W4x4dWwFXs3NIKCPYkYRbjWLsoESeKnMs1HHGXEthAtHtlhcUpSDjvNFpkW0hBRWhhk/IbeKlwhTs27JwnTSNXgqrYxLmP7aDXdJ/Y8yHotfbbScnyHE2art5BeVUk0Dj6Sm4vOu1FBa6E2e4STxhj7iKb2i4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DDvn1iS4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EDDAC19421;
	Thu,  8 Jan 2026 09:24:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767864259;
	bh=dg9P9yjyGH34rjEIFze9JRWswvIj7XWVKK+K7goE7mw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DDvn1iS43Kqml1oBbBBWHrw9ctYhCF+7WMPKqdcHY9ae23DS0e0hFXu/6e19tjIWe
	 GcU4UbWYmvNHv9omwtn2WDz2YRAkqKOr0IX1n/qb6vhRyc6Cgz0CpW89vrhGCNxnnd
	 RpQGK9xAmoxBUxj11En8wAQRh8vOrN/uaxcAg3mU=
Date: Thu, 8 Jan 2026 10:24:16 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: =?utf-8?Q?=C5=81ukasz?= Bartosik <ukaszb@chromium.org>
Cc: stable@vger.kernel.org, stable <stable@kernel.org>
Subject: Re: [PATCH 6.1.y] xhci: dbgtty: fix device unregister: fixup
Message-ID: <2026010811-cape-directly-401e@gregkh>
References: <2025122918-sagging-divisible-a4a4@gregkh>
 <20260107003854.3458891-1-ukaszb@chromium.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260107003854.3458891-1-ukaszb@chromium.org>

On Wed, Jan 07, 2026 at 12:38:54AM +0000, Łukasz Bartosik wrote:
> This fixup replaces tty_vhangup() call with call to
> tty_port_tty_vhangup(). Both calls hangup tty device
> synchronously however tty_port_tty_vhangup() increases
> reference count during the hangup operation using
> scoped_guard(tty_port_tty).
> 
> Cc: stable <stable@kernel.org>
> Fixes: 1f73b8b56cf3 ("xhci: dbgtty: fix device unregister")
> Signed-off-by: Łukasz Bartosik <ukaszb@chromium.org>
> Link: https://patch.msgid.link/20251127111644.3161386-1-ukaszb@google.com
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/usb/host/xhci-dbgtty.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)

No git id?

