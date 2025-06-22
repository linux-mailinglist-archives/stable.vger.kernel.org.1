Return-Path: <stable+bounces-155248-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C21DAE2F3C
	for <lists+stable@lfdr.de>; Sun, 22 Jun 2025 11:48:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 259CA16D803
	for <lists+stable@lfdr.de>; Sun, 22 Jun 2025 09:48:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C2C586349;
	Sun, 22 Jun 2025 09:47:59 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from bregans-1.gladserv.net (bregans-1.gladserv.net [185.128.211.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 730CB79F2;
	Sun, 22 Jun 2025 09:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.128.211.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750585679; cv=none; b=SGiPq6X+fcxdndQsZWljIU6xtzoXS+KTVt9CBoAqGYZROXHgixWd1PEFVxbK4vmu00VavfI69DcYaZLT8ZO0GfOKynHq1GsL7bK6qVbOKgSBZjEYLr1DEwAMaRs7guR1Oc8ncNB0gy/W3NuJ/9sZdYc+xS1emn9iJLW5Ntp16os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750585679; c=relaxed/simple;
	bh=3r2stGeFxdRTV62Vx1SerU6WP4+HO3pIxtvqxjafR0Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dH0xn+BLhUHgokOpp8yCUdUE2NQ/yaAE4pLcOAu31MKu/0Cz84GFlBEXQcOT9mwNy7f355g2i4GtVVt9WEaSeJOSIkZRgzgoIa4mQ0WWx9TYttVZXEDnMeu6p++lQ1YuWQb+R7iz/XyuouE7Sc9m+rdIc11atFpa+lMrfm/BGOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=librecast.net; spf=pass smtp.mailfrom=gladserv.com; arc=none smtp.client-ip=185.128.211.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=librecast.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gladserv.com
Received: from [2a0c:e303:0:7000:1adb:f2ff:fe4f:84eb] (port=45862 helo=localhost)
	by bregans-1.gladserv.net with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(envelope-from <brett@gladserv.com>)
	id 1uTH9E-007CGr-0o;
	Sun, 22 Jun 2025 09:38:00 +0000
Date: Sun, 22 Jun 2025 11:37:53 +0200
From: Brett Sheffield <brett@librecast.net>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Willem de Bruijn <willemb@google.com>, stable@vger.kernel.org,
	regressions@lists.linux.dev
Subject: Re: 6.12.y longterm regression - IPv6 UDP packet fragmentation
Message-ID: <aFfO8a7vS1jeBonh@karahi.gladserv.com>
References: <aElivdUXqd1OqgMY@karahi.gladserv.com>
 <2025061745-calamari-voyage-d27a@gregkh>
 <aFGl-mb--GOMY8ZQ@karahi.gladserv.com>
 <CA+FuTSen5bEXdTJzrPELKkNZs6N=BPDNxFKYpx2JQmXmFrb09Q@mail.gmail.com>
 <2025062212-erasable-riches-d3eb@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2025062212-erasable-riches-d3eb@gregkh>
Organisation: Gladserv Limited.  Registered in Scotland with company number SC318051. Registered Office 272 Bath Street, Glasgow, G2 4JR, Scotland. VAT Registration Number 902 6097 39.

On 2025-06-22 11:10, Greg KH wrote:
> On Tue, Jun 17, 2025 at 02:25:02PM -0400, Willem de Bruijn wrote:
> > FWIW, I did not originally intend for these changes to make it to stable.
> > 
> > The simplest short term solution is to revert this patch out of the
> > stable trees. But long term that may give more conflicts as later
> > patches need to be backported? Not sure what is wiser in such cases.
> 
> For now, I've applied the above 2 to the 6.12.y tree.  They do not apply
> any older.  If I should drop the change from the older stable trees,
> please let me know.

Thanks Greg.

For the older stable trees I agree with Willem that reverting the patch is the
simplest fix.

As it stands UDP is broken in the older stable trees, so if this can make it
into the next stable release that would be a good thing.

Cheers,


Brett
-- 
Brett Sheffield (he/him)
Librecast - Decentralising the Internet with Multicast
https://librecast.net/
https://blog.brettsheffield.com/

