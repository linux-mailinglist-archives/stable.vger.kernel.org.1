Return-Path: <stable+bounces-43621-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C4848C4142
	for <lists+stable@lfdr.de>; Mon, 13 May 2024 14:59:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0B141F24499
	for <lists+stable@lfdr.de>; Mon, 13 May 2024 12:59:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7343C1509BB;
	Mon, 13 May 2024 12:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0KQ1q8TC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29950150980
	for <stable@vger.kernel.org>; Mon, 13 May 2024 12:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715605133; cv=none; b=t4fLKCT4CJxi9UTGQtAS25i87Lp1h4uvOkKiQy+qmx9c7j5oqanndWR/rA0//4yK39cjUD3S3tBa6rnTvXPjjNvAgNEphvQJFZ6R5Uc8c2I1PuT4voBsZT7bAwU5IYjP009I0dkeDAIqR08Xv6o6BEDZK18i4z/AFT8krhtUlKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715605133; c=relaxed/simple;
	bh=xMk6LEgjXoAXHIsz247KGNDCJcBrRSdjDIrAtqBEYqk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m11msOr0dPzI8ujlXwdblQd8OJaiKaiTaTC0RTg3AqsJVRP2IV7mzUAYiLQ/xeiWS5c34nCwhaW8swr0grXJILVxn0shq9h7RO5KS7KRsf7n+aB9sk3qTMK2+5h9rrj1CqFeqB0WrJecb8DX3XKdzes0vk+L6cJKA45p2E137ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0KQ1q8TC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0C4DC113CC;
	Mon, 13 May 2024 12:58:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1715605132;
	bh=xMk6LEgjXoAXHIsz247KGNDCJcBrRSdjDIrAtqBEYqk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=0KQ1q8TCHA/X62mIhs2+6CMkC5QL5n1EU8OPHYSK8n2vsvP48EB4o0RFPVp4vToGX
	 DgX60FuHuGwusUj0MEIDCUIxXJG9WbicK6IC0g1cC0eqdH/d/+MAKmJtG1xZw/HoV7
	 tWAcaAJy93Ot8JZHRREklJx7orrKX/kJZsGYH79M=
Date: Mon, 13 May 2024 14:58:49 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Daniel Xu <dxu@dxuuu.xyz>, benno.lossin@proton.me,
	bjorn3_gh@protonmail.com, ojeda@kernel.org, walmeida@microsoft.com,
	stable@vger.kernel.org, Andrea Righi <andrea.righi@canonical.com>
Subject: Re: FAILED: patch "[PATCH] rust: macros: fix soundness issue in
 `module!` macro" failed to apply to 6.1-stable tree
Message-ID: <2024051342-implosion-pectin-7eca@gregkh>
References: <2024042940-plod-embellish-5a76@gregkh>
 <CANiq72npZyXLXBZQe3gzPX-geyUqkF1HNg6H28TKr9t_BE+DuQ@mail.gmail.com>
 <c3quwogwcekhndus6zfls2acrjbcjhcatqryotkpis2jzdudbw@db5qqg3vodpg>
 <CANiq72m-MZPyO+3QLZDsFoAXU9ctyHWtUx=HPoCO1AZatr=-mw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANiq72m-MZPyO+3QLZDsFoAXU9ctyHWtUx=HPoCO1AZatr=-mw@mail.gmail.com>

On Wed, May 01, 2024 at 11:34:15PM +0200, Miguel Ojeda wrote:
> On Wed, May 1, 2024 at 11:02 PM Daniel Xu <dxu@dxuuu.xyz> wrote:
> >
> > Yep, sounds right to me.
> 
> Thanks for the confirmation! I appreciate it.

Great, all now queued up, thanks.

greg k-h

