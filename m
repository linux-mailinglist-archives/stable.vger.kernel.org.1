Return-Path: <stable+bounces-233651-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mOfCCDke1Wnr0wcAu9opvQ
	(envelope-from <stable+bounces-233651-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 17:09:45 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id AF6ED3B0AE7
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 17:09:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4CAB63054BAE
	for <lists+stable@lfdr.de>; Tue,  7 Apr 2026 15:08:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2A3E361640;
	Tue,  7 Apr 2026 15:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qd6iY4nZ"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52E163612FB
	for <stable@vger.kernel.org>; Tue,  7 Apr 2026 15:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775574494; cv=none; b=LGzi8V8J+vDuml27f/R205Ef9LKv3Te1OP0P6IZj36BNzJftR291/+IJf6gYKJ38OK6LQ+H+faVu60QDqL8s+pcb0QN3MSgNGzHbsoAls8TkdvJB3pcf2/U2+RNCOxs1IZ2vC82aKleaUe1WOqdwnzhfgSLdgBc7k1VEs6os9n8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775574494; c=relaxed/simple;
	bh=YlGVSvMZLu6bWASSWjVD5z1mrlI3iUsiMFKGMrm4JAQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mgyGOeiDkbCmSB2//GwoUwhc1UnZ8dvbRAKzM7abttOjznAdM6LONCnqKXIMJW2LWmKNCsr2l8E95jrsh0hvTHldOzocVEfez4GA0lgl10D09Fe/baCH9YwyZImgQ98HC9SuPDTt+1owbof+PVPQG0p5uZGvPmL/6vMwQtKr5tE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qd6iY4nZ; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4888375f735so47428425e9.3
        for <stable@vger.kernel.org>; Tue, 07 Apr 2026 08:08:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775574492; x=1776179292; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wo4JrQLFyZsuapckvLQUaG6CN51cN4+Sg/wSKHqYt8g=;
        b=Qd6iY4nZYT5YR4V3MpWXrcSxQHIwRWD9976rN3km81sIg2NPd2lCG6VED9TQkpxPsN
         H3F2KUKYldvR7+YQGydvWYUYk2xljFG3Pmfcvkf8MqvDf9Bt0fY7NLHVCHJhvjR8D7Sk
         RAoeQpFLZwldJZaupxZNCywkYlRZIqNKvlR+44Qqu0Ha2SzmOyy/np1f9NMsIAqDOx0f
         UyqyHWJHuSlHsJ7NEoFB9u0j3JaGLzKnmw6dE7J6jpRRgODM9sFQGWFSqO5NVyyQFX7C
         wAWn26T9aE/Tkjayk/YTWQDLLm0BcAEVFFXUsyNawOUzYABXDRUtYFQ20WrRd5RelOsQ
         qWSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775574492; x=1776179292;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Wo4JrQLFyZsuapckvLQUaG6CN51cN4+Sg/wSKHqYt8g=;
        b=tBxngjxP2FebIArfJqBPzAs0k2DWt0ufwMDwZ3O277MbyBg8p4fsH/sqiSZdK7pbCI
         wGdO4Uc4evPc6qD1PWkBjfp/mJcG2wWWbdehkyfROTdWFga87lo+vG0MPAFDaugtWb/I
         Zy2bUnNGcjx1yjpeaGliEIqDUCftF3vO1tUa7V1k3hhPUnOrBHYEj5TwSod1RpEoF/tb
         yYBNFva2sXO2WCAna8iw7Ywdpp52rBd7ECNXIIOUiTXLp8klxZ1woQhPs6e30sucyueH
         HsBweIGMoSH1vSEACTJyVNJfIusojFAb8+3j5qdYcepkwGKZK5qeTzcsprxKsHg4XxFX
         nT8g==
X-Forwarded-Encrypted: i=1; AJvYcCVJrFlZiMTx0hcIcjGFckN9kDFmn0LfUUTTIkkjXursUytcM2PYajO8N7FUuC5MjT0nYc+Dp/o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9oxpbfD4THW3QvJGibL0J9n/R4q8SNyeGX8NYVznx/OeXVgGo
	xnTLzqPbGrdV4V/V6ZtjLEkubvICZ37sl7HrYiU3h/e6UDJr1Uc6bDB1
X-Gm-Gg: AeBDievTPrjHbhaiv2ei0baUvx6UNOPsopghulA4L3WuAO9hQMVJwO+ryWQXL4IxLmV
	N8zcIWSQVMWMMP3g4IMbb+QW6tRlRUYyASxNK4k0uopT7PuD8lczG94c/TnWeDxsBpxvho8vjM1
	k1eqy74pAd5pc/xhE1EFGOgvya9Pna1vZsX1oa3GmjCveoW1wd5RJbA/DB8RFLLrXRbim1PRUMc
	OgqwFW58qSawprrHFFMF5lQTKl5cGEhI4pqxJNcIQoc+39WCqh5Pob960ZOJessYj00QpEJpZAD
	CX0qYzJU9q0l0unjc0ZvqpmT1f7cOq3jZkCpoFJqOnQNcZZV1/3lz7/thD9Q2x2A0HGk2/MwY+z
	IexLq+62GoR8FYv6S2Mjqq5UM9P2PJYHHuMb/ZkwfONoDH/+5JOJLOHb63CzrZyySWRo1C/SNtN
	qP0l1b9vYL0O4x4g9dQ61lZ+mfASx5bErFyetRpk5ngg+g+iSKAZa1ZDp++NZYFi2l
X-Received: by 2002:a05:600c:3549:b0:486:fbe1:2499 with SMTP id 5b1f17b1804b1-488997d2d7cmr232748915e9.22.1775574491478;
        Tue, 07 Apr 2026 08:08:11 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4887e829c43sm541202825e9.5.2026.04.07.08.08.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 08:08:11 -0700 (PDT)
Date: Tue, 7 Apr 2026 16:08:09 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Tamir Duberstein <tamird@kernel.org>, Petr Mladek <pmladek@suse.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Rasmus Villemoes
 <linux@rasmusvillemoes.dk>, Sergey Senozhatsky <senozhatsky@chromium.org>,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, kernel test robot
 <lkp@intel.com>
Subject: Re: [PATCH] printf: mark errptr() noinline
Message-ID: <20260407160809.48d5fe2a@pumpkin>
In-Reply-To: <20260406123232.3dacbe94@gandalf.local.home>
References: <20260405-printf-test-old-gcc-v1-1-76d24d9bb60e@kernel.org>
	<20260406111531.779571d7@gandalf.local.home>
	<CAJ-ks9n+cX=+97=HN76L=WF6jzfLiHZEvL6zM1-P47XORTBz5A@mail.gmail.com>
	<20260406123232.3dacbe94@gandalf.local.home>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-233651-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[davidlaightlinux@gmail.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AF6ED3B0AE7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, 6 Apr 2026 12:32:32 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Mon, 6 Apr 2026 11:21:39 -0400
> Tamir Duberstein <tamird@kernel.org> wrote:
> 
> > Thanks Steve. IMO that is a very big hammer and not warranted in this
> > case. There's been talk of encouraging distros to enable CONFIG_KUNIT
> > by default [0], which would probably interact poorly with the change
> > you propose.
> >   
> 
> Branch profiling is really just a niche that is enabled specifically for
> seeing all branches taken in the kernel. It hooks to all "if" statements!
> As you can imagine, it causes a rather large overhead in performance.
> 
> This option is only used by developers doing special analysis of their code
> (namely me ;-).

Is there any way to stop randconfig picking up options like these?
It is rather a waste of brain-cycles trying to fix them.
If you want the option to test a specific bit of code it is easy to
hack/disable any problematic parts.

Even having the KASAN/KMSAN code compiled into allmodconfig is a PITA
when you are trying to check that code compiles to something sensible.

	David

