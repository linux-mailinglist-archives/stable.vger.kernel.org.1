Return-Path: <stable+bounces-188041-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F5B6BF0ECE
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 13:52:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CB8A34E7E60
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 11:52:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D626D2F7ACB;
	Mon, 20 Oct 2025 11:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gCt9k9zR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78142354ADC
	for <stable@vger.kernel.org>; Mon, 20 Oct 2025 11:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760961171; cv=none; b=l61rkiABkWTo5xqRzIPsItsnu7Fz8cN7DgLdnDoX2xpKg3LqnOF+dfVjjjSmKWaBYaCLhK4I2hLjgxCo1PtsFCQX75wwxVPsw0DGyWoLAoGwXR4zcOOjxt+cYmmnOqkit/FfNQSDD349j2OWLos+/fDfIcHzDy3ZvC1Jop9wU3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760961171; c=relaxed/simple;
	bh=sNyVM3UVsWwBR9cmuV5KYorFmACrf/906bSqRQY7KTA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rktqylfc3Ahxfz3UtcdMMely3n1mnJNvw4I2zL32W3ogg2eQJrQrXbrMU2wouf/SD/L2lhTTW5vHzx05IXNsX/TF5vKoe9Sevx/iPJ9Wmlxr1Y25OOYXrnmE6OhC8k75aT42Z9dCiEYSV0eBsV9HlY/t5oxP6eIfhgw1fQE3Ia4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gCt9k9zR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2B3FC4CEF9;
	Mon, 20 Oct 2025 11:52:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760961171;
	bh=sNyVM3UVsWwBR9cmuV5KYorFmACrf/906bSqRQY7KTA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gCt9k9zRBT6HLwg64SgY3+4hNkmU+4WhK3r6gW0j2n9U3GaKkHRKw40ijOocf4bbM
	 GYiXkONVomTpsspzmOY73xpgLY6HCIBxAnJjp9EFXgOt7UeHHaOGDUgOHsjaWjPOXV
	 g1RvEURXmqdUWQEA52vD4n7s5jxqNzltFSlRpkrM=
Date: Mon, 20 Oct 2025 13:52:48 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: carnil@debian.org, kevin@xf.ee, stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] Revert "io_uring/rw: drop -EOPNOTSUPP
 check in" failed to apply to 6.12-stable tree
Message-ID: <2025102041-borax-livable-24e3@gregkh>
References: <2025102039-bonelike-vocation-0372@gregkh>
 <6d07f9bb-5c73-4e17-8292-927257867c83@kernel.dk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6d07f9bb-5c73-4e17-8292-927257867c83@kernel.dk>

On Mon, Oct 20, 2025 at 05:20:34AM -0600, Jens Axboe wrote:
> On 10/20/25 2:00 AM, gregkh@linuxfoundation.org wrote:
> > 
> > The patch below does not apply to the 6.12-stable tree.
> > If someone wants it applied there, or to any other stable or longterm
> > tree, then please email the backport, including the original git commit
> > id to <stable@vger.kernel.org>.
> 
> Easy fixup, here's one for 6.12-stable.

Now queued up, thanks!

greg k-h

