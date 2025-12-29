Return-Path: <stable+bounces-203649-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 564DECE736E
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 16:31:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 02F003002847
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 15:31:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C06E6186E40;
	Mon, 29 Dec 2025 15:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RateFKi5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EB461F956
	for <stable@vger.kernel.org>; Mon, 29 Dec 2025 15:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767022272; cv=none; b=frntME0kLScrwZs7Fak84dPLvGwQQNGeJzDxDA0K7194NkRLd3fOlo9jZ0Hr3BxK2uvEjJUG5gcS1w+nRU7ut/lzUNtMCEKrwZ0yA6nY47o2at81O8+rrzWB3ctuUrNza4sRMPiJbZ8achAnbkVWsC0y4dxGvK9aWWIOcfKvNzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767022272; c=relaxed/simple;
	bh=41FytYc1UiirkNIuzB9+MfEFDigdsPE+ysKFFAGy1kk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WpHosWM2AA5jLj99uU4h0EiuqTxISqKQaw6SwSkkBQF3fzUTcnboiBAtvhXTsCaVIN6U/8qI/2KiWTZr+Pah7wKH3NeBa+tjh2n/V4Bx/hAFTydwF4Sa5Kl9y26gprD3rnGY+DvJPrGED1AtcOwy2e92RaZbzBbyi2QVTbRKdoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RateFKi5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AD7FC4CEF7;
	Mon, 29 Dec 2025 15:31:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767022272;
	bh=41FytYc1UiirkNIuzB9+MfEFDigdsPE+ysKFFAGy1kk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RateFKi5CJ9i++37LcNK371efrBoL+2qTvbiM/rQqRtCd0yF0gHVCa2FRCXfJFxHH
	 ydvS7NG5JsKLTKsAwA5DS28ujwov76Jk/vJeMTGHjahYcBAxagPDxjomzBcVA0vUnd
	 EjTfFJEbFSV70JNVGortxRAz2KTDdRXt0Gz4Vjxs=
Date: Mon, 29 Dec 2025 16:31:04 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: activprithvi@gmail.com, stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] io_uring: fix filename leak in
 __io_openat_prep()" failed to apply to 5.15-stable tree
Message-ID: <2025122949-starting-handiwork-20c6@gregkh>
References: <2025122931-palm-unfixed-3968@gregkh>
 <4c57e1d1-d78b-472c-a833-5793bd395afb@kernel.dk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4c57e1d1-d78b-472c-a833-5793bd395afb@kernel.dk>

On Mon, Dec 29, 2025 at 08:15:18AM -0700, Jens Axboe wrote:
> On 12/29/25 4:34 AM, gregkh@linuxfoundation.org wrote:
> > 
> > The patch below does not apply to the 5.15-stable tree.
> > If someone wants it applied there, or to any other stable or longterm
> > tree, then please email the backport, including the original git commit
> > id to <stable@vger.kernel.org>.
> 
> Here's one for 5.15-stable AND 5.10-stable. Please apply to both, as they
> share the same base.

All now queued up, thanks.

greg k-h

