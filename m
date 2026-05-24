Return-Path: <stable+bounces-254003-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mEhcEzOyEmq/2wYAu9opvQ
	(envelope-from <stable+bounces-254003-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 24 May 2026 10:09:23 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B71A5C1A9C
	for <lists+stable@lfdr.de>; Sun, 24 May 2026 10:09:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E7B12300D479
	for <lists+stable@lfdr.de>; Sun, 24 May 2026 08:09:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E772933A03F;
	Sun, 24 May 2026 08:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s32dtw9O"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 590452DC321
	for <stable@vger.kernel.org>; Sun, 24 May 2026 08:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779610157; cv=none; b=gEv7H6zpI5cSgJRN/lMtNnFto7hHIniH1Xj9Uhx+nsDbjtwB53gIVz6KbgxFzkP9vB00oT2j9R7yPodRR4hEDZMRYmqGdoZGlLCh5VQ7JGeQJUznumIdqAo970XDNukwpbssmyAol8qc22+wbWkLCblrZue0kcVzmQAT5+w/bbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779610157; c=relaxed/simple;
	bh=V88tvOdPEuOMBu/jBdpAoznTcHpLTE0OfiQPkQyF8mc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kU1xkAM2PFqp1CcacBrEfeK0PQfjhxXNxF2rr1E35jmmQiR/2mwHWKSBAvvys+sURU3z0tCtwKNu9gY5NO0ixPLxqgL8lvD052hC8QcbTWH0GtnRgBLs9gSj9p8QqXwfZJzyVzFa9haLOO1gvJqJchnwovTQWQYg/4+z+Wqhryw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=s32dtw9O; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-490388fd0dbso30535445e9.0
        for <stable@vger.kernel.org>; Sun, 24 May 2026 01:09:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779610155; x=1780214955; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=V88tvOdPEuOMBu/jBdpAoznTcHpLTE0OfiQPkQyF8mc=;
        b=s32dtw9Osg37R6qzAJeWgTvOwjsWMygOyjS98KGjhPTj09ZBWPSk0gSUhBMugKgPvH
         i+/SC7z0yehvKwKaekT8jpQ/KUQGsbrdRBTIp1+zAQdHlizdgWWZqvqz41b35F1ngrh6
         TPbXeozsSqUysp4fpUHu2dSfcFs8lV7Lz12y0G6XS1MK+kwfPcdIyc0UZ93msf77kb2d
         WmHHZ8GeJk704NI6hjnxquD99/K/hARyJD+nr6y8LcJyxWU6YuG7RIt16LYxpWDYx3mA
         +3MJ39dnkqC88c3iRbe3vSIKGgGzqK8WI0LStq194OQOiK5ubNucyB5NAhoCWjgB/ikI
         7Ukw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779610155; x=1780214955;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V88tvOdPEuOMBu/jBdpAoznTcHpLTE0OfiQPkQyF8mc=;
        b=lnCr2xPz8OtnEhpfVMihSZqP4V/sfb2uTu9h88swSygGZTtTBH5i4BzZieep2+q/yx
         xjh9CiFT0t3/19GEhrGPfsFzTaLk476IGkPdnkWi2Jn0ngc4DYMZBrP4FrC0n+E0AnhL
         smmXnVl88aLnaXbDW6ZCE/qfnS/W0MxZ3YRWphBLIwtJn7TkAQy0RyVNTFYIPijQxLYi
         A5Q2/IcZpoP3v/nlLf6I3WcQKLi+gu8/8OOv7SoTUUdIcnwXnukpjRE3Q0Z9vomTNdU/
         h0TuVLhNhzDgQjMWsiMwniYKNdWpQsvg5HEJ0FSWyvzxQTYfqjx2SV7ZZy/g2CI2PVbN
         2Zfw==
X-Forwarded-Encrypted: i=1; AFNElJ8sE7B3JtiNbwS41sfGjPBcUou3n74ErBHYQJgBTdca4IPt8RiGizuqipkMnUcCIYzhOmiJgMM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzH0+PVpcWwvsqnAwM4Dgwk2lsC2hQQFQYURL9EVCb6T59iK9Vo
	BwKooY2zVUh9g9gmHEqgYo7AoyPuDwhJqNE/Op7/5Ysmf6sQ5IF6hsgZ
X-Gm-Gg: Acq92OErgOooEczcvuy5sC0e5j/EueY09pXNwa3ISn48UpBUAIaH1CJK2PLKaAwG733
	2UreaJjh+Noe+CBzkUCaV7dwtDWP1+s28/o4rmKb8BLhBr9P+y1ogTVYspOqoGHLCAJ8bACscgR
	4G9nPFe8z37CGHshQ9Vj7qGSjf9z7CwdfJeoDdgAioySPbiCcinnozVgMc35F1cRxxCwaOqS5xG
	Hjv4mtCxgFu32jrB7by20WLnSIWbXz/SK65U0D369hjMJ4IFrCl01C/jjeqHZi6Y9PktOugfgFF
	3kQmtEfRTR7EFSyLB0HGYWzvQIVgobzGZNr37tThTpr7jtONfdMHMktSbDGX3i3mErOjdLlb1Ki
	Z03s/R0HXORtXp7aznQW05KviCOh9AaJVUMK6FWSQLk3IgOJbP4O/r3tg16B60S0vnd2xK6TA/Y
	STq5zJs4e9eDOjZ1hNWdrYPfFhI6s95gThbvbum27n3KJA1yQmSZebp6iPK+JFsZWOYN8Vh0Ssv
	QbumWPh9skUhVT2MXFlXFdGU2pt7CrUSY3MmmrJFLk5U/z6MNl45LHB2zE4C0S68pDrd5Aa+CmE
	7NCdZBlE4G4tDRSKJ5rlBQFLM2VV
X-Received: by 2002:a05:600c:3512:b0:490:601f:d787 with SMTP id 5b1f17b1804b1-490601fd939mr17292075e9.6.1779610154351;
        Sun, 24 May 2026 01:09:14 -0700 (PDT)
Received: from unknown748F3CBA5068 (dynamic-2a02-3100-b3e0-e401-c487-9725-5e6f-67f3.310.pool.telefonica.de. [2a02:3100:b3e0:e401:c487:9725:5e6f:67f3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490454ac6a6sm168901005e9.12.2026.05.24.01.09.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2026 01:09:13 -0700 (PDT)
Date: Sun, 24 May 2026 10:09:11 +0200
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Linus Walleij <linusw@kernel.org>
Cc: Russell King <linux@armlinux.org.uk>, 
	Abbott Liu <liuwenliang@huawei.com>, Ard Biesheuvel <ardb@kernel.org>, 
	Florian Fainelli <f.fainelli@gmail.com>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] ARM: io: avoid KASAN instrumentation of raw halfword I/O
Message-ID: <ahKt0Lp9Y8eJDMJ8@unknown748F3CBA5068>
References: <20260522212018.25295-1-kmehltretter@gmail.com>
 <CAD++jL=jrk4EYo+5mhp1cpy2cfsA966MVmbohWhcZdx_SObD_w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD++jL=jrk4EYo+5mhp1cpy2cfsA966MVmbohWhcZdx_SObD_w@mail.gmail.com>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254003-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[armlinux.org.uk,huawei.com,kernel.org,gmail.com,lists.infradead.org,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kmehltretter@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,armlinux.org.uk:url]
X-Rspamd-Queue-Id: 9B71A5C1A9C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, May 24, 2026 at 12:11:36AM +0100, Linus Walleij wrote:
> Please put this patch into Russell's patch tracker.

Done: https://www.armlinux.org.uk/developer/patches/viewpatch.php?id=9474/1

Thanks,
Karl

