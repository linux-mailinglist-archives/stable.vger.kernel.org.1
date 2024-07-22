Return-Path: <stable+bounces-60686-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 476C6938EB3
	for <lists+stable@lfdr.de>; Mon, 22 Jul 2024 14:01:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0750F281E45
	for <lists+stable@lfdr.de>; Mon, 22 Jul 2024 12:01:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C52EF16B3AE;
	Mon, 22 Jul 2024 12:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jGFUQnYd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 842E116130D
	for <stable@vger.kernel.org>; Mon, 22 Jul 2024 12:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721649662; cv=none; b=AzcTqEfKzCy+fcHbcO0aIjCxEPhzbCLvR7Dg9VC9AKkWj81JPY9GcL9GCF64EbnKXHh2i2kyIJQS4laG60etytdPry+oYuiuTEOpiWsNkys3N5f/bVZBKjX0fZV6k8KPSH44KgTtKHk944EWPEIIuzOaUkIbYCUEh4GDxBflLQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721649662; c=relaxed/simple;
	bh=iAFffuOYJl0XAEmWv3iyoG8d1UQKByK+0vP6WASv5ts=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t3MGqSjeSdNh9CyzFesXhcfVFl2QPhkNJCz68CPCtVb8yOlkkGLnQJl6pYJUQdXlg/0mls0QuIAThfaJVjhOGNCEa9Hct+vNRAo81mtgYdV0CGc5jHGVw5h2Lg6amcABh3tgUg83LxPJPvPEXDtPY02zjQrfxNhgj2JcOCo1iOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jGFUQnYd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD4E6C4AF0A;
	Mon, 22 Jul 2024 12:01:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1721649662;
	bh=iAFffuOYJl0XAEmWv3iyoG8d1UQKByK+0vP6WASv5ts=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jGFUQnYdry7SEIAxq+1J5GOOnnPkbJlKBlfplPIJVRDWeYseA+vlCt35n9mHPjxTH
	 gf7Y8mRNq82LGNRk2btzYIM5IKvZJyw/iVS0VWsMhIUsAdpkBySfd6CRD1g02ErQZw
	 znhj4QcAaIxRwiH1vW0rw2yeVp2rcqxn3Ok7dHDs=
Date: Mon, 22 Jul 2024 14:00:59 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Thomas Meyer <thomas@m3y3r.de>
Cc: stable@vger.kernel.org
Subject: Re: 5.15.x: randomize_layout_plugin.c: 'last_stmt' was not declared
 in this scope?
Message-ID: <2024072234-plaza-docile-7a4b@gregkh>
References: <ZpO2yOXdylWmyaaj@localhost.localdomain>
 <2024071653-glider-plated-0a61@gregkh>
 <ZpwV9gaA9lqg5C4z@localhost.localdomain>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZpwV9gaA9lqg5C4z@localhost.localdomain>

On Sat, Jul 20, 2024 at 09:54:30PM +0200, Thomas Meyer wrote:
> Am Tue, Jul 16, 2024 at 04:08:44PM +0200 schrieb Greg KH:
> > On Sun, Jul 14, 2024 at 01:30:16PM +0200, Thomas Meyer wrote:
> > > Good day,
> > > 
> > > I wanted to upgrade my kernel to the latest 5.15.162 but it seems to fail with
> > > this error message after upgrading to fedora 40, any ideas what could be the
> > > problem?
> > > 
> > > $ make
> > >   HOSTCXX scripts/gcc-plugins/randomize_layout_plugin.so
> > > scripts/gcc-plugins/randomize_layout_plugin.c: In function 'bool dominated_by_is_err(const_tree, basic_block)':
> > > scripts/gcc-plugins/randomize_layout_plugin.c:693:20: error: 'last_stmt' was not declared in this scope; did you mean 'call_stmt'?
> > >   693 |         dom_stmt = last_stmt(dom);
> > >       |                    ^~~~~~~~~
> > >       |                    call_stmt
> > > make[2]: *** [scripts/gcc-plugins/Makefile:48: scripts/gcc-plugins/randomize_layout_plugin.so] Error 1
> > > make[1]: *** [scripts/Makefile.build:552: scripts/gcc-plugins] Error 2
> > > make: *** [Makefile:1246: scripts] Error 2
> > > 
> > > Maybe a problem with gcc 14?
> 
> This seems to fix the compiler error:
> https://lore.kernel.org/all/20230811060545.never.564-kees@kernel.org/

Ah, this is a gcc14 issue.  I'll backport this, but odds are you will
have other problems using this compiler with such an old kernel tree.

thanks,

greg k-h

