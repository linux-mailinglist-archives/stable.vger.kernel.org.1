Return-Path: <stable+bounces-86509-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41DDB9A0D3C
	for <lists+stable@lfdr.de>; Wed, 16 Oct 2024 16:49:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 739CA1C24DBB
	for <lists+stable@lfdr.de>; Wed, 16 Oct 2024 14:49:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9730820CCD0;
	Wed, 16 Oct 2024 14:49:19 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B92E014A4E2;
	Wed, 16 Oct 2024 14:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=163.172.96.212
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729090159; cv=none; b=Yd+hcDMx7/WbbzO+rmLr/w4arHmrncCYGLzdp/T8JtPbqKJYBkCzDTdor4DSb4XOaM65Sos8ADPmlUtAlhaVzsn75Q5KLy1trl2fJNG6I/QMTeoFgonl0jgMhYjjI4n2SaLbX2phsHMYYGcKieLtvYpylqR19teLjdm/tjFG9TA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729090159; c=relaxed/simple;
	bh=BRLkgOoXP0ReLybVRqT4/mfy3F+qbEOdkaefS2a66Iw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m1dKrEvWkXC8kG/oog/2HsqAckZ/8Qi16glzQvfXh3jLj3XFfI+b/mZqJxFTvoDm5hUeMhJ2i/T0jW8DdK/gLxINftypoYBX58saZBsDYWwm/fbuftjsYBOpVlmOCSSL09bI9kXT+CLGzVCcSmciIEFpXiQl6klEJQhTrg/hbJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu; spf=pass smtp.mailfrom=1wt.eu; arc=none smtp.client-ip=163.172.96.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1wt.eu
Received: (from willy@localhost)
	by mail.home.local (8.17.1/8.17.1/Submit) id 49GEn9m9020915;
	Wed, 16 Oct 2024 16:49:09 +0200
Date: Wed, 16 Oct 2024 16:49:09 +0200
From: Willy Tarreau <w@1wt.eu>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>
Cc: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
        "Paul E. McKenney" <paulmck@kernel.org>, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH] tools/nolibc/stdlib: fix getenv() with empty environment
Message-ID: <Zw/SZad0QR8eyNnI@1wt.eu>
References: <20241016-nolibc-getenv-v1-1-8bc11abd486d@linutronix.de>
 <Zw+uxLIklMHSSxTu@1wt.eu>
 <20241016143300-a80ab677-e0bc-444e-9bfa-1670069b7a77@linutronix.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241016143300-a80ab677-e0bc-444e-9bfa-1670069b7a77@linutronix.de>

On Wed, Oct 16, 2024 at 03:01:08PM +0200, Thomas Weißschuh wrote:
> Ah, environ being assignable is something I did not consider.

Yes, it is. Long ago, in nolibc when there were no global variables,
I used to have this in my programs:

  char **environ;
  int main(int argc, char **argv, char **envp)
  {
      environ = envp;
      ...
  }

And it used to work pretty well with any libc.

> > >  	int idx, i;
> > >  
> > > -	if (environ) {
> > > +	if (*environ) {
> > >  		for (idx = 0; environ[idx]; idx++) {
> > >  			for (i = 0; name[i] && name[i] == environ[idx][i];)
> > >  				i++;
> > 
> > However as a quick note, if we decide we don't care about environ being
> > NULL, and since this is essentially a cleanup, why not even get rid of
> > the whole "if" condition, since the loop takes care of it ?
> 
> It's not only a cleanup.

OK.

> Without this patch I see crashes due to illegal memory accesses.
> Not reliably, only under special conditions and only on s390, but
> crashes nevertheless.

But I don't understand how the patch could make them disappear, as it
removes an extra check. So if environ was bad before, and was not null,
it remains bad and continues to be dereferenced. And if it was null,
it wouldn't enter the block but will now.

> It's the same binary with the same kernel that sometimes works and
> sometimes crashes.
> The proposed fix makes the issue go away.

Maybe it's related to the size of the executable or code optimization
with some offending parts that could be eliminated by the compiler in
fact.

It's also possible we've subtly broke something in the s390 init code
in a way that slightly violates the official ABI (stack alignment etc)
and that could explain the randomness.

> But my original analysis looks wrong, I'll investigate some more.

OK!

> User process fault: interruption code 0010 ilc:2 in test_nanosleep[43c4,1000000+8000]
> Failing address: 0000000000000000 TEID: 0000000000000800
(...)

Unfortunately I'm not fluent in s390 :-/

Willy

