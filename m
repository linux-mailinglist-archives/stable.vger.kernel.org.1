Return-Path: <stable+bounces-100315-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B0F189EAB23
	for <lists+stable@lfdr.de>; Tue, 10 Dec 2024 09:57:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8474188934E
	for <lists+stable@lfdr.de>; Tue, 10 Dec 2024 08:57:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62A0B2309AB;
	Tue, 10 Dec 2024 08:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pXsmrdXc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2111822ACFA
	for <stable@vger.kernel.org>; Tue, 10 Dec 2024 08:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733821018; cv=none; b=tM1F+sjp/9fUGtCmw9BJzQza7iUKyFlf3TpO+28hUwblwrBoJHIgyCHD4bPy2rn4V6UoijmNOcSjTSF3lIz1AAM8Gv9/2zfPaVBGhAasUt2mnUbUV8GNKP1TBy4Ad87nSKias3B2O3pD/Mkfe/r2qoh7dwt0j8vCESckCLbtnK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733821018; c=relaxed/simple;
	bh=dNum5FPy8cCO7i2caVByUX3J3lceeA/e/DCogHXQtR0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=miYRlDfRq/oUiYrTlD/6NF6vU3x1qHQNiFIwjPzYz9LQ9xKEQh/JmNs5jH9Ep6msUKyLiqd/e5A6zQX7nnJuuyx3Nx+a2I67Taz35OLzJjNIz/A30H/a/LnhgduXmlQgiLygimE6wpxTKmwqq7hGXlvWBHg3daJGRiBejGMJXtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pXsmrdXc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D074C4CED6;
	Tue, 10 Dec 2024 08:56:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733821017;
	bh=dNum5FPy8cCO7i2caVByUX3J3lceeA/e/DCogHXQtR0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pXsmrdXc+eFYM2JyWvLEZFbqEdU9tE+2UFPUBXRbFpKaeWVJMuFwwVwc7fPloL/kF
	 wSUqrFj56nL7h5xbhXxdh5wco2H4G0rmAJNjjxkoS/1IOQUCmRvA9xAm7vEJ6EqLKq
	 cn95WyJPfUI04Znkl2QK762ZdCOKnueHMKCkhcf8=
Date: Tue, 10 Dec 2024 09:56:21 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Hugh Dickins <hughd@google.com>
Cc: roman.gushchin@linux.dev, akpm@linux-foundation.org, seanjc@google.com,
	stable@vger.kernel.org, vbabka@suse.cz, willy@infradead.org
Subject: Re: FAILED: patch "[PATCH] mm: page_alloc: move mlocked flag
 clearance into" failed to apply to 6.6-stable tree
Message-ID: <2024121011-cargo-crate-1828@gregkh>
References: <2024111714-varsity-grub-d888@gregkh>
 <92845557-1e54-71b7-0501-4733005a8fc3@google.com>
 <97594aca-8bfe-78d6-fa86-688af7610c83@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <97594aca-8bfe-78d6-fa86-688af7610c83@google.com>

On Fri, Dec 06, 2024 at 02:21:38PM -0800, Hugh Dickins wrote:
> On Mon, 18 Nov 2024, Hugh Dickins wrote:
> > On Sun, 17 Nov 2024, gregkh@linuxfoundation.org wrote:
> > > 
> > > The patch below does not apply to the 6.6-stable tree.
> > > If someone wants it applied there, or to any other stable or longterm
> > > tree, then please email the backport, including the original git commit
> > > id to <stable@vger.kernel.org>.
> > > 
> > > To reproduce the conflict and resubmit, you may use the following commands:
> > > 
> > > git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
> > > git checkout FETCH_HEAD
> > > git cherry-pick -x 66edc3a5894c74f8887c8af23b97593a0dd0df4d
> > > # <resolve conflicts, build, test, etc.>
> > > git commit -s
> > > git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024111714-varsity-grub-d888@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..
> > 
> > For 6.6 and 6.1 please use this replacement patch:
> 
> I notice that there's now a 6.6.64-rc1 out for review, but without
> Roman's mlocked flag clearance patch.  No desperate need to get it into
> an rc of 6.6.64, but we wouldn't want it to go missing indefinitely.

Sorry for the delay, now queued up.

greg k-h

