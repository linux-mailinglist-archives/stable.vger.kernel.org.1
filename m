Return-Path: <stable+bounces-242105-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kMumIJdW82mLzgEAu9opvQ
	(envelope-from <stable+bounces-242105-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 15:18:15 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EFC14A34FB
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 15:18:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2607E30095EE
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 13:17:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4EFF423148;
	Thu, 30 Apr 2026 13:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UxvNvxQ2"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50B7141B360
	for <stable@vger.kernel.org>; Thu, 30 Apr 2026 13:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777555026; cv=pass; b=WYVaaoSQbBKARaPIApY/rU31iT7DsHlKTnr5r0ZEffw4tuLOXQqTlHiaOx93m8YKZniYSWWqHsbIWnRfPxOnElyn6eBd5d76L7fdIjregeJNtJCSQSs5ZkepZqN2YRwDmC7ucQ9A55TYtXoUNqaM/lkYxjcD5JKDiS0YKJHKw9Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777555026; c=relaxed/simple;
	bh=CW9oV6oDJor07e61kTEkhmTZFlL7d8Er44rZpxHeW9M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BBNSOyDsb5on2fbEPMyZHUK3HX+DYaq1C4Z2uZk1M4HJ2UAlwulsl9JCLjnKHVt26ZlDtvWfxPx96abCROHXb8nbkMZzfRMylEPd23NBX+nw4+nWYbn7yVwkatXK7SRVDbcaBNHCXXgHUSg/TFo1xmym3w+Kyxw+tb6FkAmAkH4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UxvNvxQ2; arc=pass smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-2ba9c484e5eso1025571eec.1
        for <stable@vger.kernel.org>; Thu, 30 Apr 2026 06:17:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777555024; cv=none;
        d=google.com; s=arc-20240605;
        b=eWterS6I/qcDTlyDMr/OuShUX/FZ1OukTe6/K3qHXlzerdOfJDWlPD5D0cXZt6JoXX
         zRDgq3XwHNwrYfxXlxCHv2LRNJqlLdDLf8YhUdyzvDUEObLBQOBSGiDgK51rUFucnAGt
         HfK1NP71UJ36TwvAiq348bz2SbpoaHQ7VG8cfQ8CKiLzkLzGaY12EYvsd9NdPZZvnhkT
         vccxIYQ8p5mY/1/Vbu8M/nrlHrK/zvvbZGxgeAObqoTBQFTTNUZPblkT5CUb+Hi5BJFu
         duQdRa2QEiNuYbuivP5hs7M42teP5IMtYUP6eSVd9eyY0I9/ZSqTLV5PWjrguqpOH0xk
         Srqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=CW9oV6oDJor07e61kTEkhmTZFlL7d8Er44rZpxHeW9M=;
        fh=8aDTJp2eQQPZii/WncgAk/kWmLRl3F67r5Nd5u2eslE=;
        b=fZ6w3Y4PNHgs1uSFEiMec9/uweSTICZ4H2ltjCmRYJpeAwncEqqGxwV+tvkNy6S4kX
         TBndSXVImMeRPbUnCdL3LdVcqhWHwSPoa87CHd9AzzkXageUzJD6aVsEESZgauAHUECI
         xy5VPM28hxI9iZww0/OvOQxnZV+c+Z5bqCUdbCi8rtUeuOW7GhGWTUdaWB3h4N1Yt/BP
         DZvOJmyw7PzCX3101iz3vmFQeiXDCQul+8OeLQNjBlSDMhvM2DKzT5BrT4k/sxyGEGf4
         PEEJwqPsXjuCsExu0qZSi0Hl/HBvhDhEJzp1dQgOi3UxFdzmkPWHiIda7Zn7lkz8zG2f
         aOZg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777555024; x=1778159824; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CW9oV6oDJor07e61kTEkhmTZFlL7d8Er44rZpxHeW9M=;
        b=UxvNvxQ27nhQyn2OE1dnnS8b16PThxNoMkP1A2R3ReyMNTHMcG/y8TO/YTnM1nwXqO
         R4oyCjoXXCNDK6noPY5IpehTzUFn+qXoUgPo+f1J/h/kmg0zzwgMtEnono5GadsdlYq7
         V8WW4ZJyuQ2fX91D4y34llDDFgRuXi6W4ci5Ud6MnYVtpTqhok6rtCdjQEcWHGl0JJmE
         UDunZVoV6s3fKtxG1NYULZksDJwNpv6BcMBCSiXZZ0PxYXvI5jQHnN+44GTizNLJFbLD
         r9PZiaJFnB5ODQOswe/UQedjsCw0KPgYTNne414BEm0rC7kFj0SE9izrPLV5cG5volb2
         iUEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777555024; x=1778159824;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CW9oV6oDJor07e61kTEkhmTZFlL7d8Er44rZpxHeW9M=;
        b=aklc3u9BW9uo2WaOZXZw52evfUi1T+epxu1fd3kzoksUtbn78q2aX3MgmrosHCrhzJ
         d35t9pre/iLe0eIj9sV4UEI3hNHZOoY9SMaTS+synh7bVIjZSQN5bm+X1Hk+KCvcL/Ip
         dA1nYSg5QkKLA1IR8XWAFkhpgc719Qab2WfSC7CGS8CZ22txff90MyAlw51tR6uABky8
         60p9oXHhaTpn0Fn/4sbQh0OvDwdTUQegDhEgBI/hyBtQDfB2Kuyhcs/RHRw6T6cNEZdS
         7ZfYxyDlqyJ9TtnYPxYF2oFumgN5q7KGiunICDtW0t8z8g99MQ/cl5t0VNDu2KjDw9Hj
         9pCw==
X-Forwarded-Encrypted: i=1; AFNElJ9c8ZeoxlnRpHe4BvGjYtmI8Hw/XE/kbm81CCBJFgZM0vQomLGQ/+f7NbUA2ELQV5QdANjitYg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRFApDwU5xZY3H6TmSpgLWPIhZV4ZcgkDuT//o6S49UtCGwfOd
	tRxkatNBu9eYjovO2D4Ascj11ZXDPZkRq7axfULmPg8vPulGzGuI+k7F0QkzwIj/A44NgECtaUJ
	q+sdb37bB+9Q+U8E737LJpn6qPSmHv3w=
X-Gm-Gg: AeBDiesq7lYqY63E6c3N3xDEoysp5XDIWgD30QF+r+vqKKsPoLtzLv7QiLBlmtDaokp
	mR3bsJllDFLf0y1zKq4SqhxGfAJPXw/LcwEVi92csBdBgkGci81bsCG/c+AV9bGhuPayv6nYkZO
	N+iHy18OSwfTL1FNrOLv+nupK2MNUfP3eTgoNJ+NlehKQqSRgAxkYV4afnQ+LcmTJ3MS82Wy62z
	q3Pi/jxshL078kJsmT6nYFRXCnlpvcixfQyNdRh3PxwKtVZuQA5VHFd4oOvXmkW/jQJ5TRrM+6W
	v702EcXaBjSCpIiGQMk+ek1/PJTTv/tftBTG+d73juxofoMgmljCuW/bvz8JKEk4jijnssAlcwI
	3pc7pNZ2hZtfHD0lZLRk9A7aecD71co7Xw/ob4JPR8r8ItEsRe9oXeo0iz6HOPRNlZ+qyNzFS0r
	LPtS9mYwuZWrYm97UI2ifIJaRKpOgPym98vGl8XcqKX/TcTBa1
X-Received: by 2002:a05:7300:7b89:b0:2ed:e14:42e8 with SMTP id
 5a478bee46e88-2ed3ff5ba70mr1281308eec.33.1777555024167; Thu, 30 Apr 2026
 06:17:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2026043052-coasting-tinwork-27b5@gregkh> <CADo9pHjPzxmHNd8MAeWH=CCuVazxpb3OxdasEcUxoarvLwKzZg@mail.gmail.com>
 <2026043052-deflector-dodgy-93a6@gregkh>
In-Reply-To: <2026043052-deflector-dodgy-93a6@gregkh>
From: Luna Jernberg <droidbittin@gmail.com>
Date: Thu, 30 Apr 2026 15:16:49 +0200
X-Gm-Features: AVHnY4JWaL9qa50i735penGj69PRLX-X2jSKFNURvzf7Yr6rvEqNLBzocsSb6V4
Message-ID: <CADo9pHihUk66XL2Fy+tFqCcgwv1M5YMEDDS-ASJMkC=WM_Xvcw@mail.gmail.com>
Subject: Re: Linux 7.0.3
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Luna Jernberg <droidbittin@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, 
	akpm@linux-foundation.org, stable@vger.kernel.org, lwn@lwn.net, 
	jslaby@suse.cz
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 7EFC14A34FB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-242105-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[linuxfoundation.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[droidbittin@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,copy.fail:url,mail.gmail.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

Ah alright then i know, its me thats not keeping up thank you

Den tors 30 apr. 2026 kl 15:15 skrev Greg Kroah-Hartman
<gregkh@linuxfoundation.org>:
>
> On Thu, Apr 30, 2026 at 03:09:05PM +0200, Luna Jernberg wrote:
> > Hey!
> >
> > Works fine
> >
> > patching: https://copy.fail/ next ? ;)
>
> That was fixed a while ago in older kernel releases that you should
> already be running :)
>
> thanks,
>
> greg k-h

