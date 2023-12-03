Return-Path: <stable+bounces-3823-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 32A8680286E
	for <lists+stable@lfdr.de>; Sun,  3 Dec 2023 23:30:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E05E280AAA
	for <lists+stable@lfdr.de>; Sun,  3 Dec 2023 22:30:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8C5517998;
	Sun,  3 Dec 2023 22:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=horus.com header.i=@horus.com header.b="WCN7iiIk"
X-Original-To: stable@vger.kernel.org
Received: from mail.horus.com (mail.horus.com [78.46.148.228])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AFAC116;
	Sun,  3 Dec 2023 14:30:20 -0800 (PST)
Received: from [192.168.1.22] (193-81-119-54.adsl.highway.telekom.at [193.81.119.54])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.horus.com (Postfix) with ESMTPSA id D069C640D9;
	Sun,  3 Dec 2023 23:30:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=horus.com;
	s=20180324; t=1701642618;
	bh=SG4QXUafv7HBFyUQGEy8Wdv6fwaRmduVMKl810igHa8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WCN7iiIkXOuAaT+gX21mk9w9Rzs+zstRivGernVUh9P8UQrgDN2DZ3JUgUq0fe1G9
	 bZMBSDw6sKHRewm6FfhntBeNRHQRt9A/bSuc9K7QRKQAr402ir1iQOL0lfq8bWGYUJ
	 5cZxOe7h0hXysLK/b//N8afuRWyNtLyhS9VaOQjw=
Received: by camel3.lan (Postfix, from userid 1000)
	id 65B965401F9; Sun,  3 Dec 2023 23:30:18 +0100 (CET)
Date: Sun, 3 Dec 2023 23:30:18 +0100
From: Matthias Reichl <hias@horus.com>
To: Mark Brown <broonie@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
	torvalds@linux-foundation.org, stable@vger.kernel.org,
	jslaby@suse.cz
Subject: Re: Linux 6.6.3
Message-ID: <ZW0BeuPt-B1HAban@camel3.lan>
Mail-Followup-To: Matthias Reichl <hias@horus.com>,
	Mark Brown <broonie@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
	torvalds@linux-foundation.org, stable@vger.kernel.org,
	jslaby@suse.cz
References: <2023112811-ecosphere-defender-a75a@gregkh>
 <ZWo45hiK-n8W_yWJ@camel3.lan>
 <dea2db44-2e13-47c1-be0b-8548bfd54473@sirena.org.uk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dea2db44-2e13-47c1-be0b-8548bfd54473@sirena.org.uk>

On Fri, Dec 01, 2023 at 08:01:36PM +0000, Mark Brown wrote:
> On Fri, Dec 01, 2023 at 08:49:58PM +0100, Matthias Reichl wrote:
> 
> > I'm not familiar with the regcache code but it looks a bit like the
> > return value from the regcache_read check is leaking out - not
> > assigning the value to ret seems to resolve the issue, too
> > (no idea though if that would be the correct fix):
> 
> That looks sensible, can you submit as a proper patch please?

Thanks a lot for the feedback, I sent out the patch
https://lore.kernel.org/lkml/20231203222216.96547-1-hias@horus.com/T/#u

so long,

Hias

