Return-Path: <stable+bounces-60644-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3475B9382BE
	for <lists+stable@lfdr.de>; Sat, 20 Jul 2024 21:54:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6685E1C20EFB
	for <lists+stable@lfdr.de>; Sat, 20 Jul 2024 19:54:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A667B13CFA6;
	Sat, 20 Jul 2024 19:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=m3y3r.de header.i=@m3y3r.de header.b="MuM+EjpX"
X-Original-To: stable@vger.kernel.org
Received: from www17.your-server.de (www17.your-server.de [213.133.104.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4348039850
	for <stable@vger.kernel.org>; Sat, 20 Jul 2024 19:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721505284; cv=none; b=F7HjkcEtedC8TgWNtMYX0zGb5r9OUdoBf5fi4jBVCYFBSi3IR1/+GfNl5NnKQ17XdqgOFHC414vwfWHIrzAJ2RSwjWAPy/MccG2b20B8+73J8w9fGOym7jS8mBxRTxrEccecaTMJuisBS+jn12/sodhz4LgF2kRoefk1FytQBFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721505284; c=relaxed/simple;
	bh=iNBLd7UmmBULWefxdu8VMuiD+xATfBeDK1g9RFRiNsQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nmhs7NTJAulMYs6q3UKmwgNkt0LJNzkWmijmhEt5IGNjKmf1L5UiEL+JdLVcfy3G3V7IzoA3C6KpJDIrEthu1BTTvdlaI+tG5hfXgI7Cn9sPE6AG/gzRURwJoTO32RVSsFHjfHjz9ju6/k2x6j5Lj2H+QEeGAdznLt5UAXYnKAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=m3y3r.de; spf=pass smtp.mailfrom=m3y3r.de; dkim=pass (2048-bit key) header.d=m3y3r.de header.i=@m3y3r.de header.b=MuM+EjpX; arc=none smtp.client-ip=213.133.104.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=m3y3r.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=m3y3r.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=m3y3r.de;
	s=default2402; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID; bh=FFS6cz/cmUEgQDTDFVJt80brk5+HIaacwGUAv4dPDKA=; b=MuM+Ej
	pXmOG9Ay48QDXjRGZQVKm9sazCdrA1QGTAbiBncc/2ahHgTnIOMRNQtNnSbebk9p5+j7EWERLR7GP
	pXPNJBp952G54L4dSPLvM//BM7Horltop/9d1QRVj7GZ50SNfIhY6wfs4ba54XahOoTe1/4QybqCD
	xLDjbChAFKkMyPFHQyEHA8MaJb/eE1G86/foh0ItbnngTkIV0bTiKer6jNrka7t10IDdfOXol9fAW
	Ll/XNATwu6koAOF5jfYIxHFuPhuyD2T9CPodeOYNFKaAeVRE90XrgaKM24QlslV+kyUIrZu0nhU89
	3YZ3NyLspZWTlkiUZ+TiXw/5W9Hw==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
	by www17.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <thomas@m3y3r.de>)
	id 1sVGA3-0009hc-LE; Sat, 20 Jul 2024 21:54:31 +0200
Received: from [2a00:6020:509f:6000:41e7:900f:edc:2880] (helo=localhost.localdomain)
	by sslproxy02.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <thomas@m3y3r.de>)
	id 1sVGA3-000EZ3-0t;
	Sat, 20 Jul 2024 21:54:31 +0200
Date: Sat, 20 Jul 2024 21:54:30 +0200
From: Thomas Meyer <thomas@m3y3r.de>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org
Subject: Re: 5.15.x: randomize_layout_plugin.c: 'last_stmt' was not declared
 in this scope?
Message-ID: <ZpwV9gaA9lqg5C4z@localhost.localdomain>
References: <ZpO2yOXdylWmyaaj@localhost.localdomain>
 <2024071653-glider-plated-0a61@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024071653-glider-plated-0a61@gregkh>
X-Authenticated-Sender: thomas@m3y3r.de
X-Virus-Scanned: Clear (ClamAV 0.103.10/27342/Sat Jul 20 10:24:53 2024)

Am Tue, Jul 16, 2024 at 04:08:44PM +0200 schrieb Greg KH:
> On Sun, Jul 14, 2024 at 01:30:16PM +0200, Thomas Meyer wrote:
> > Good day,
> > 
> > I wanted to upgrade my kernel to the latest 5.15.162 but it seems to fail with
> > this error message after upgrading to fedora 40, any ideas what could be the
> > problem?
> > 
> > $ make
> >   HOSTCXX scripts/gcc-plugins/randomize_layout_plugin.so
> > scripts/gcc-plugins/randomize_layout_plugin.c: In function 'bool dominated_by_is_err(const_tree, basic_block)':
> > scripts/gcc-plugins/randomize_layout_plugin.c:693:20: error: 'last_stmt' was not declared in this scope; did you mean 'call_stmt'?
> >   693 |         dom_stmt = last_stmt(dom);
> >       |                    ^~~~~~~~~
> >       |                    call_stmt
> > make[2]: *** [scripts/gcc-plugins/Makefile:48: scripts/gcc-plugins/randomize_layout_plugin.so] Error 1
> > make[1]: *** [scripts/Makefile.build:552: scripts/gcc-plugins] Error 2
> > make: *** [Makefile:1246: scripts] Error 2
> > 
> > Maybe a problem with gcc 14?

This seems to fix the compiler error:
https://lore.kernel.org/all/20230811060545.never.564-kees@kernel.org/

> 
> Maybe, has any previous 5.15.y kernel worked?
> 
> > My current kernel was compiled with gcc 13:
> > [    0.000000] [      T0] Linux version 5.15.160 (thomas2@localhost.localdomain) (gcc (GCC) 13.3.1 20240522 (Red Hat 13.3.1-1), GNU ld version 2.40-14.fc39) #15 PREEMPT Sat Jun 1 16:54:27 CEST 2024
> 
> If you build 5.15.160 with gcc 14 does it also fail?  Doing a 'git
> bisect if it does not would be great to track down the offending commit.
> 
> thanks,
> 
> greg k-h

