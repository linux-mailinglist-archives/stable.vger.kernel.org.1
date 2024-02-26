Return-Path: <stable+bounces-23734-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07F08867B10
	for <lists+stable@lfdr.de>; Mon, 26 Feb 2024 17:03:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5F6D293F6F
	for <lists+stable@lfdr.de>; Mon, 26 Feb 2024 16:03:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BB5112C547;
	Mon, 26 Feb 2024 16:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wyQBHbGb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18DDD12BF00
	for <stable@vger.kernel.org>; Mon, 26 Feb 2024 16:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708963407; cv=none; b=rzE9EyB36iJBsW8HLvnIMPvNfxf2yuuFMD/5uTWj9wwqPEtLfU4mVnaT+Ek/a4Ac3qNmn8JWsHVPqyqgMgAvTxerLmuT4mC0NebUuVyEwhI1hRjAIuRHNxFe3j5vpxK1lQYtNTh6adz/JCTwVNKgfXY3Cq6ZmeDbJzkSvQHOEIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708963407; c=relaxed/simple;
	bh=h2JbLZHCkRS7vyjN+KGuZhcxwKn200R0DcSHLoaqRcs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h8NTvCI/+w0Ah3+QswZb/9NYVv4fEKmYaZ9tIJrz1Q3wI9QzQFD44wwgj6WL9L+YeqSiLLD0gY27FGfgfEj14TWot7z8bkjwThL6Y6l7yKwJy9b5hZ29l2y1d8zCrh2PGWct9CqErO1ML6Y2oKJDirRLVp2C+d6I/FSdcAqnOJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wyQBHbGb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39D73C433F1;
	Mon, 26 Feb 2024 16:03:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708963405;
	bh=h2JbLZHCkRS7vyjN+KGuZhcxwKn200R0DcSHLoaqRcs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=wyQBHbGbzQrHglsWKdkUR4O9bXz6lI7txiOXI4GQnbO2Dcwu/hCBca2ZZEXqodrN9
	 X5z0IC7FVQMQ79VOEiTTbI7Mbvyi5mJPxs4UK92PTm67aYb48z26HkR282MOh6w/4y
	 Xi20OCd0kOExgZLIwG+9tR5mFQHAR3YJLbElrxvk=
Date: Mon, 26 Feb 2024 17:03:23 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: =?utf-8?B?0KDQsNC00L7RgdC70LDQsiDQndC10L3Rh9C+0LLRgdC60Lg=?= <stalliondrift@gmail.com>,
	stable@vger.kernel.org
Cc: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Subject: Re: Kernel 6.6.17-LTS breaks almost all bash scripts involving a
 directory
Message-ID: <2024022645-zoology-oppose-ea92@gregkh>
References: <fa4cd67e-906d-4702-90e2-b9c047320c34@gmail.com>
 <20240226-porcupine-of-splendid-excellence-22defc@meerkat>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240226-porcupine-of-splendid-excellence-22defc@meerkat>

On Mon, Feb 26, 2024 at 10:52:50AM -0500, Konstantin Ryabitsev wrote:
> > In the past 4 or 5 years I've been using this script (with an alias) to
> > compress a single folder:
> > 7z a "$1.7z" "$1"/ -mx=0 -mmt=8
> > 
> > I know it doesn't look like much but essentially it creates a 7z archive
> > (with "store" level of compression) with a name I've entered right after the
> > alias. For instance: 7z0 "my dir" will create "my dir.7z".
> > And in the past 4 or 5 years this script was working just fine because it
> > was recognizing the slash as an indication that the target to compress is a
> > directory.
> > However, ever since 6.6.17-LTS arrived (altough I've heard the same
> > complaints from people who use the regular rolling kernel, but they didn't
> > tell me which version) bash stopped recognizing the slash as an indication
> > for directory and thinks of it as the entire root directory, thus it
> > attempts to compress not only "my dir" but also the whole root (/)
> > directory. And it doesn't matter whether I'll put the slash between the
> > quotes or outside of them - the result is the same. And, naturally, it
> > throws out an unlimited number of errors about "access denied" to everything
> > in root. I can't even begin to comprehend why on Earth you or whoever writes
> > the kernel would make this change. Forget about me but ALL linux sysadmins I
> > know use all kinds of scripts and changing the slash at the end of a word to
> > mean "root" instead of a sign for directory is a rude way to ruin their
> > work. Since this change occurred, I can no longer put a directory in an
> > archive through CLI and I have to do it through GUI, which is about 10 times
> > slower. I have a DE and I can do that but what about the sysadmins who
> > usually use linux without a DE or directly SSH into the distro they're
> > admins of? With this change you're literally hindering their job!
> > 
> > I downgraded the kernel to 6.6.15-LTS and the problem disappeared - now the
> > slash is properly recognized as a sign for directory.


Any chance you can run 'git bisect' to find the offending commit?

Also, what filesystem type are you seeing this issue on?

thanks,

greg k-h

