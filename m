Return-Path: <stable+bounces-69939-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CB75395C531
	for <lists+stable@lfdr.de>; Fri, 23 Aug 2024 08:11:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 810001F2262C
	for <lists+stable@lfdr.de>; Fri, 23 Aug 2024 06:11:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FC0D5FBBA;
	Fri, 23 Aug 2024 06:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yyF0oWmb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB06F8493;
	Fri, 23 Aug 2024 06:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724393509; cv=none; b=D4Tj/WiVFGp3U8Ve/0aHPtieHAblXLdnA8TEBkoJd5LGIQxF9yP1rjfeDHJ9nUzzbtlb+h3QMjZKFu/FgvI3fPsvQwLh3V2Jknx9hchYRHYj9gCupKc11ujRg9j2046muNfN5RkzOrtLvHRasFHQBV529onZrvEqGzADd0QD35c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724393509; c=relaxed/simple;
	bh=rZRxZusxBHotNQZhqeg8CxgvISn6IPndzeerII7HRnY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zcn9CDrRq8O0Uup1HbiIIqdVbplPEwLRAuTehxxdVQRWDgx+fAs41VNQLuY4465X3e70vsJ6RiqJqyU+AAwpc/J9gBgzx7nfWWOF+nCc1+o8hx29F+HgMHjwrGbHffeyKUWgor8z3+vPlVpNqqSF7M5GgpDPm7Rm8riItNJ4H94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yyF0oWmb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17CCAC32786;
	Fri, 23 Aug 2024 06:11:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1724393508;
	bh=rZRxZusxBHotNQZhqeg8CxgvISn6IPndzeerII7HRnY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=yyF0oWmbAfs0WsC0hJUQEocgguWd1sQWMv5hKpZ5WGqUE2kR9E+hnvMopNfC7UgEt
	 OqO6XD+MMLlKABq9qKRPWk1sjrE57i3unYEwxy3L/BBPmQdXH+NeDSrNMg+Ti/6uq4
	 JFkuH8afvVYD8KMm2CseQiriM6w+vjLul30ST7pQ=
Date: Fri, 23 Aug 2024 14:11:45 +0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Zijun Hu <zijun_hu@icloud.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
	linux-kernel@vger.kernel.org, Zijun Hu <quic_zijuhu@quicinc.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH] driver core: Fix an uninitialized variable is used by
 __device_attach()
Message-ID: <2024082349-democrat-cough-bf77@gregkh>
References: <20240823-fix_have_async-v1-1-43a354b6614b@quicinc.com>
 <ZsfRqT9d6Qp_Pva5@google.com>
 <04c58410-13c8-4e50-a009-5715af0cded3@icloud.com>
 <2024082318-labored-blunderer-a897@gregkh>
 <Zsfk-9lf1sRMgBqE@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zsfk-9lf1sRMgBqE@google.com>

On Thu, Aug 22, 2024 at 06:25:15PM -0700, Dmitry Torokhov wrote:
> On Fri, Aug 23, 2024 at 09:14:12AM +0800, Greg Kroah-Hartman wrote:
> > On Fri, Aug 23, 2024 at 08:46:12AM +0800, Zijun Hu wrote:
> > > On 2024/8/23 08:02, Dmitry Torokhov wrote:
> > > > Hi,
> > > > 
> > > > On Fri, Aug 23, 2024 at 07:46:09AM +0800, Zijun Hu wrote:
> > > >> From: Zijun Hu <quic_zijuhu@quicinc.com>
> > > >>
> > > >> An uninitialized variable @data.have_async may be used as analyzed
> > > >> by the following inline comments:
> > > >>
> > > >> static int __device_attach(struct device *dev, bool allow_async)
> > > >> {
> > > >> 	// if @allow_async is true.
> > > >>
> > > >> 	...
> > > >> 	struct device_attach_data data = {
> > > >> 		.dev = dev,
> > > >> 		.check_async = allow_async,
> > > >> 		.want_async = false,
> > > >> 	};
> > > >> 	// @data.have_async is not initialized.
> > > > 
> > > > No, in the presence of a structure initializer fields not explicitly
> > > > initialized will be set to 0 by the compiler.
> > > > 
> > > really?
> > > do all C compilers have such behavior ?
> > 
> > Oh wait, if this were static, then yes, it would all be set to 0, sorry,
> > I misread this.
> > 
> > This is on the stack so it needs to be zeroed out explicitly.  We should
> > set the whole thing to 0 and then set only the fields we want to
> > override to ensure it's all correct.
> 
> No we do not. ISO/IEC 9899:201x 6.7.9 Initialization:
> 
> "21 If there are fewer initializers in a brace-enclosed list than there
> are elements or members of an aggregate, or fewer characters in a string
> literal used to initialize an array of known size than there are
> elements in the array, the remainder of the aggregate shall be
> initialized implicitly the same as objects that have static storage
> duration."
> 
> That is why you can 0-initialize a structure by doing:
> 
> 	struct s s1 = { 0 };
> 
> or even
> 
> 	struct s s1 = { };

{sigh}  I always get this wrong, also there's the question "are holes
in the structure also set to 0" which as you can see from the above
spec, should also be true.  But numerous places in the kernel explicitly
use memset() to "make sure" of that.

thanks,

greg k-h

