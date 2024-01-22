Return-Path: <stable+bounces-12712-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2660C8370AF
	for <lists+stable@lfdr.de>; Mon, 22 Jan 2024 19:49:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 91ACCB2F343
	for <lists+stable@lfdr.de>; Mon, 22 Jan 2024 18:16:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D689746531;
	Mon, 22 Jan 2024 17:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="F1Uwfe8u"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 988B946521
	for <stable@vger.kernel.org>; Mon, 22 Jan 2024 17:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705945248; cv=none; b=c3R9aA/nEeYuoI5kXul2iFUpXKBwVjDncqEngy78dn/Xgzah1LjkQKNdaUTD7THydI1+5sFW7ZZC3lFXb3naDibW8UEA7FXIE0YfIba1WSuntVcPlPD3H9mvhZsdUEySbKHPcwwEgyg/jXhSs9/ab6qX7yOjdEJPciG1mqr8v60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705945248; c=relaxed/simple;
	bh=A15fpLuqtEewedy+3KW1XIOtSEhXtsRr36/bedCmV0w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CZxVQYYQEeG8if0KG31Mox8RLexut2iWNy5Wo/lQOviNQtAzSjlD1uUfN+k0r9m7DeyR5r+TdZiCdkWDlgYu8R8eVoZu86LEvQaPGvVU6T96lIZD58l39jjGC0LgVhynQiYf1NSxcvJX26xobukQjsQpLBayAzhejZVTGefO5UQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=F1Uwfe8u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A1AEC43390;
	Mon, 22 Jan 2024 17:40:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705945248;
	bh=A15fpLuqtEewedy+3KW1XIOtSEhXtsRr36/bedCmV0w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=F1Uwfe8uWI8gpJVB+OnOO8bOubxgwH/teDNYP1XmzplDcjgcAL1qE5IWE3cHrbl1F
	 2KrKhxnEZkwYpP3AOKDgtdK56ci1ziE+PhLtIg/snlruqwt2cRtrDRV3sh4m8jTl+J
	 uVlDCie/46ogE7Nvk3ct/NQp0L6Y7QoFETwTfw+Y=
Date: Mon, 22 Jan 2024 09:40:46 -0800
From: Greg KH <gregkh@linuxfoundation.org>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org,
	Matthew Maurer <mmaurer@google.com>
Subject: Re: Apply bad098d76835 to 6.6.y and 6.7.y
Message-ID: <2024012239-draw-shopping-d462@gregkh>
References: <CANiq72koa-tTXuxKRujXMuJUCw__WiPbgnxj6i9J2c6Yby78Uw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANiq72koa-tTXuxKRujXMuJUCw__WiPbgnxj6i9J2c6Yby78Uw@mail.gmail.com>

On Sat, Jan 20, 2024 at 03:13:13AM +0100, Miguel Ojeda wrote:
> Hi Greg and Sasha,
> 
> Please consider applying commit bad098d76835 ("rust: Ignore
> preserve-most functions") to 6.6.y and 6.7.y (6.1.y does not need it
> since `__preserve_most` was introduced in 6.6). It fixes a build error
> with Rust + `CONFIG_LIST_HARDENED`. It should apply cleanly.

Now queued up, thanks,

greg k-h

