Return-Path: <stable+bounces-59413-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3802932801
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 16:08:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2871DB211CC
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 14:08:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C27FD19AD71;
	Tue, 16 Jul 2024 14:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="P89Xu9TC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8013613CA99
	for <stable@vger.kernel.org>; Tue, 16 Jul 2024 14:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721138932; cv=none; b=OU063pGCpsKApc9E6iMAQiROPgpIMWEnAZsiMen+Zt5WLR4NJeMsui6dA4BJv3tRNs4WtJAPbdrxMZlNY0xOnHQ+AtO99xDddWdNhKBAq+2jZhT3p/T0ClQXDlkkL+FjUEp5zxE4ZYotBZIvFrhTZyKKw81uZ1OsIlHP4vqoqtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721138932; c=relaxed/simple;
	bh=btISHMKVIhZylwjke+qF1gRxULQ5fYgvQYKc4Jj743U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gWXUEhHXvf8OJx7k97l12p6l+vLN8NLUW/3NDwHo2JFCpuNCcDu2FBJD8mDWVr2b4tXZZGKbkEZzNgbz6Mkt17ZTiZBOpVsJME+ISw5lm71B9aAUhtSWvfl55ssVgyoBUHLMob/sHcbjNDOIgVo7QcM5M3oop7QJo0qu202p4OI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=P89Xu9TC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC3C9C116B1;
	Tue, 16 Jul 2024 14:08:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1721138932;
	bh=btISHMKVIhZylwjke+qF1gRxULQ5fYgvQYKc4Jj743U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=P89Xu9TCp8EkRHu6ShIe2D3MLHetflXz0zzaoK/vdkGp+2YQ0MU1NX6weWxXyTSp9
	 OwdRFqbXAfSFw0UjIMamJRCzXpa6GKVgPj7C+F5GX+RhGPV5RHNQx/B+NfiVF9B1Rq
	 m8TEAhG9qFj6m6MVXyt4HsiccVkyjaBZALT2lxe4=
Date: Tue, 16 Jul 2024 16:08:44 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Thomas Meyer <thomas@m3y3r.de>
Cc: stable@vger.kernel.org
Subject: Re: 5.15.x: randomize_layout_plugin.c: 'last_stmt' was not declared
 in this scope?
Message-ID: <2024071653-glider-plated-0a61@gregkh>
References: <ZpO2yOXdylWmyaaj@localhost.localdomain>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZpO2yOXdylWmyaaj@localhost.localdomain>

On Sun, Jul 14, 2024 at 01:30:16PM +0200, Thomas Meyer wrote:
> Good day,
> 
> I wanted to upgrade my kernel to the latest 5.15.162 but it seems to fail with
> this error message after upgrading to fedora 40, any ideas what could be the
> problem?
> 
> $ make
>   HOSTCXX scripts/gcc-plugins/randomize_layout_plugin.so
> scripts/gcc-plugins/randomize_layout_plugin.c: In function 'bool dominated_by_is_err(const_tree, basic_block)':
> scripts/gcc-plugins/randomize_layout_plugin.c:693:20: error: 'last_stmt' was not declared in this scope; did you mean 'call_stmt'?
>   693 |         dom_stmt = last_stmt(dom);
>       |                    ^~~~~~~~~
>       |                    call_stmt
> make[2]: *** [scripts/gcc-plugins/Makefile:48: scripts/gcc-plugins/randomize_layout_plugin.so] Error 1
> make[1]: *** [scripts/Makefile.build:552: scripts/gcc-plugins] Error 2
> make: *** [Makefile:1246: scripts] Error 2
> 
> Maybe a problem with gcc 14?

Maybe, has any previous 5.15.y kernel worked?

> My current kernel was compiled with gcc 13:
> [    0.000000] [      T0] Linux version 5.15.160 (thomas2@localhost.localdomain) (gcc (GCC) 13.3.1 20240522 (Red Hat 13.3.1-1), GNU ld version 2.40-14.fc39) #15 PREEMPT Sat Jun 1 16:54:27 CEST 2024

If you build 5.15.160 with gcc 14 does it also fail?  Doing a 'git
bisect if it does not would be great to track down the offending commit.

thanks,

greg k-h

