Return-Path: <stable+bounces-12234-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D509832459
	for <lists+stable@lfdr.de>; Fri, 19 Jan 2024 06:49:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0AA91C22F2F
	for <lists+stable@lfdr.de>; Fri, 19 Jan 2024 05:49:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E82D74A0C;
	Fri, 19 Jan 2024 05:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="12t2hEgz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A83E93C37;
	Fri, 19 Jan 2024 05:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705643336; cv=none; b=IGj+ddb4QxMTc+qVNO6fxoHTwJoKo1AhYhauJJrOp1dFR1UD3id567ahzoe3Nitl5DwkERIOCC8vdhO3g7GBeG69p9214L324jrJx58XwzUhNu4M5z9ZAgTZwnnYsUpAHxGgXqDQjXJbOoVND/VNR+sidSokVfHHjNUazFXqD4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705643336; c=relaxed/simple;
	bh=LFI3MIfZMLgN8s2H8POFMuVXcGr9p4yQG5cD+zi3nrI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SwbArb5SViC8miRrCjxXOTcyvMwd3Uz/i+I9VhWsu5FLjiD79kip/RXrKj8IZZnP/1he/TiE7Sz3JeaWXvFc4Tj3bAYUJNaXgIYLJC/FJz+ifmysPHkGln1U97pF8pTjPjpho62Gz6DBqod4vMcmyUckXPrYRj1vxvsl1L/mcuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=12t2hEgz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0FDBC433C7;
	Fri, 19 Jan 2024 05:48:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705643336;
	bh=LFI3MIfZMLgN8s2H8POFMuVXcGr9p4yQG5cD+zi3nrI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=12t2hEgz9iIUyLTAPiu3FGTud3/uLAXGrqGDBvtElNX0f6jcNmg9IGSYCG2v7Siz+
	 3GD3Iy0Z9mse/KC69XsxWhrUaghZlViKGukGLHlGrCfOXUySf1TOetuGAFpof74ikc
	 nIMdUqyeATCAES8hcphGwOm18bZ15rRdAgudveho=
Date: Fri, 19 Jan 2024 06:48:53 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Carlos Llamas <cmllamas@google.com>
Cc: Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Christian Brauner <brauner@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Sherry Yang <sherryy@android.com>, linux-kernel@vger.kernel.org,
	kernel-team@android.com, Alice Ryhl <aliceryhl@google.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 04/28] binder: fix async space check for 0-sized
 buffers
Message-ID: <2024011948-sulfate-tartly-7f97@gregkh>
References: <20231201172212.1813387-1-cmllamas@google.com>
 <20231201172212.1813387-5-cmllamas@google.com>
 <Zal8uGqP2lLZz_oz@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zal8uGqP2lLZz_oz@google.com>

On Thu, Jan 18, 2024 at 07:32:08PM +0000, Carlos Llamas wrote:
> On Fri, Dec 01, 2023 at 05:21:33PM +0000, Carlos Llamas wrote:
> > Move the padding of 0-sized buffers to an earlier stage to account for
> > this round up during the alloc->free_async_space check.
> > 
> > Fixes: 74310e06be4d ("android: binder: Move buffer out of area shared with user space")
> > Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> > Signed-off-by: Carlos Llamas <cmllamas@google.com>
> > ---
> 
> Sorry, I forgot to Cc: stable@vger.kernel.org.


<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>

