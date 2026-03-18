Return-Path: <stable+bounces-226971-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IFhDOjVLummWTwIAu9opvQ
	(envelope-from <stable+bounces-226971-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 07:50:29 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DB79C2B68F0
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 07:50:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 94DFE3014F63
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 06:50:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 580E7354AF2;
	Wed, 18 Mar 2026 06:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rajagiritech-edu-in.20230601.gappssmtp.com header.i=@rajagiritech-edu-in.20230601.gappssmtp.com header.b="mERAlMHb"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0F8E322B88
	for <stable@vger.kernel.org>; Wed, 18 Mar 2026 06:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773816624; cv=pass; b=BhatR/qYR7e9rZ7HeBVrylglkbyAhWSGU0oN1GFbA1P/n4Hr04pt+luKE19YSljK5K4u04MnXrCV9RWrnpELQtea+IESuOPGPOWsOopb3pLZqWVlZMtt02EC6/g3O9Jw9LOgifsn77yYGJQ8K/anHhD12T4Vgd0/tYkLngpOYhk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773816624; c=relaxed/simple;
	bh=D+l8pH3fbSGAAiFTAKmcMYwmkdh9ywr3O9jc/b+KYUk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=epf8teFowJlhV4t1Be7jM31ibwtDWqCioq4CZ+7jmRCfgmbR58GNV5LF2f8SPikHy9/RdarPf3eM/wJ2mhzVvTs1VPTQqZQMW03tVECIb88HIR+D8f3wRJRZEs+vvOk3WxJC5MN8bwfS1fwIC3p/TqE0ql4/XI4YSiJcWzMDVlc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rajagiritech.edu.in; spf=none smtp.mailfrom=rajagiritech.edu.in; dkim=pass (2048-bit key) header.d=rajagiritech-edu-in.20230601.gappssmtp.com header.i=@rajagiritech-edu-in.20230601.gappssmtp.com header.b=mERAlMHb; arc=pass smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rajagiritech.edu.in
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=rajagiritech.edu.in
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-65c0891f4e9so11632963a12.1
        for <stable@vger.kernel.org>; Tue, 17 Mar 2026 23:50:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773816621; cv=none;
        d=google.com; s=arc-20240605;
        b=ebgo7FnzdMKTeEy0P4evxT8xgMcoJEsXVsT0UehJoKQHA2V/aSFBLnpAyXvg/JVB2d
         ZLNkYMDXy6Efd1q5N+nq+lAMFIqAXYggfn3dputZ0279QXdXMfdFUXIHJ/sC5kzvU4Pb
         IA+6Xsm8Kb+FF3+TjcuPRB7u3T0rJsO+SE1DnneL2Gu8qnoa0+S6h6QYJDFeswBxu2BK
         y2zodLumQyii4VMz4p8gW8Jcvj3IMHRoK0can5pwWHA2TbUOofWHK1tNLFQMcTJ1K7x5
         ba10XfIsL6zbV0askICR3g0FPJXjlPQEPIPqCbiiSjW7B7WQUlhIdBa5mRVkaKLnULlH
         Pn0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Zdvi6hWM24Xo3eVCU2axEwOSGy4gAnAXKG/xyveFr9A=;
        fh=Wz8J5UEBOCqQDV8EGy7SaS7auVxYFAJQ5oaobiGaD9E=;
        b=Kc/oIdHysbpWUhiFNVp7DKJEQBxeZ+5Z6N50RMI/yPUv+n1t3rX4uJ0+GkGjKSt79R
         ltcHg0Zglq5dBG6ZdWMuHuFgwvgOa7NYM3d3ltOg30eJAUd02SLkWUa3M5RQeCHoeirC
         AebpNSxFW1YcNrnlOxLZN5iBEBOmp2KA1vwyW2OXO8hYGxmTHEDT15vaZ9yrOAYKP+rq
         YP9pBs6aKcbMJg65qxemTdJ0WvfKhXkwjEC9eVX3FleWCTUT4cRqEAJuKkVpEcIr2/ml
         yaEHX3X8HVhNuK3T3Sxe4soUtSwUYFaxZi6TJHRQIypXY+qG6anAhMZYj2P1YuIox5RL
         Ei8g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rajagiritech-edu-in.20230601.gappssmtp.com; s=20230601; t=1773816621; x=1774421421; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Zdvi6hWM24Xo3eVCU2axEwOSGy4gAnAXKG/xyveFr9A=;
        b=mERAlMHbqv/NuviNtrV0DDD03w0LULmaS89w76aqkC7kZgV0nwT8nPU6x3AX66pkHd
         kJChfcELPEBpyQ8SXn3yNy4pRx8JV2XCt4tcP5hdqF2Lz/1eVem12nboCMmME8gqBQ6a
         Na+5UYJOJ5tltHzdVH6+FfzrxmroRGQIjPp6gs1vfA+gJzvaK1XwHLa9aRPkRzcnBTz7
         inHw1VoZf7E2jHQHCcbhFrhKmGXpAM5SzjmrarLThLgkuVyzxO+XCp9nDE46pSZdVS45
         3lQJ1T6TCfkst5NMnJMpexwnDOv5DOgUQe12wl/whyJhjXeUFW6sYGR9wjj1z9KBXV9n
         U3fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773816621; x=1774421421;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zdvi6hWM24Xo3eVCU2axEwOSGy4gAnAXKG/xyveFr9A=;
        b=ds8l+EXE3tyCANCl1TurLHjJ/tdWpjn5LSzoeF3NLOgrPprUDcuxCaE1MlpJJ9KuNb
         4O3/MYh3UoMf3gAGnHxArCez7ur1jvpKbEBp8TqFcHu5vivE8mTr7dCrHWHNU2RCAR4/
         7FqZQAdoNVZKpK+p6GtCYfQ70nyDNnvvswRTdfSD3zCLoG8YhurRn8NAA0nANa914q2N
         digycrObPoy2S6YqINjYK0UwzgTktu9lNattQsX2cD56sEhzt6JCA9Za52ICl9KkKSZe
         CfEoLFtEcyy+RI1U3QP9jlI0V5z15ywF0JsnilVzW15HwT44Wghnw2AkPMyRFKtKO24D
         6aiQ==
X-Gm-Message-State: AOJu0YxMp9X+Gtk+cSLAMeoyoseHeNX2iar1EsBBCjgs6D2k4nFIXoO1
	7zqEbLmvi/zQkPNqShsoK+HEySh0/RRu9TrV+h/yUhKl9o61tdOMg8J19eYx1Ac1t1eilKzZub2
	Ckr6F8mf7U4FcJodEAV1tUWa1SW1R02ELH/6RPeGqKQ==
X-Gm-Gg: ATEYQzwmddQMDFueOBXmgmb8hP0yyTJurlnhKZ0S31dgGMJUDHrR2gA4Q6CfI2I9j2f
	MvwwWCF0CBjMFvo64u56D6PfpGEHZvVPghkxY4oxF+cNucgDBY0h/ehgZ7P5jidP9zBw36L/C3E
	33wRpVUUtk0ZSgUMCHtk/PFj2ZI0Tm+bQH70P08ExOlxC2ImGXdYyUCxG3shhY6y39sJQkVbu3F
	YaHrxx8em1kQEdER5eFhh4JqLCutXH6DJpFWAsN/51jagMvyBHSTblTKrL7AaludM9jssMBl+7/
	Z2zcz3zqGSrfgSCYjg7yGC/cOHAtsOzHJBipHjR0uELwN/LOImUBUB1jbpHEmJWO1KoBKJ4=
X-Received: by 2002:a17:907:7212:b0:b97:ad82:973f with SMTP id
 a640c23a62f3a-b97f48ba054mr121944066b.13.1773816621097; Tue, 17 Mar 2026
 23:50:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260317162959.345812316@linuxfoundation.org>
In-Reply-To: <20260317162959.345812316@linuxfoundation.org>
From: Jeffrin Thalakkottoor <jeffrin@rajagiritech.edu.in>
Date: Wed, 18 Mar 2026 12:19:44 +0530
X-Gm-Features: AaiRm53yRWxBBTQF1p7uxw4V_pBVj0qnQTGxwtjzEHQXnfphOan0wcD2pkPn8N4
Message-ID: <CAG=yYw=mjEuAttBzTOq4VpVhwUFmGdddDm4XWxTHtN7Rtm5EbA@mail.gmail.com>
Subject: Re: [PATCH 6.18 000/333] 6.18.19-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@nabladev.com, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, 
	achill@achill.org, sr@sladewatkins.com
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_DKIM_ALLOW(-0.20)[rajagiritech-edu-in.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[rajagiritech.edu.in];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-226971-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[rajagiritech-edu-in.20230601.gappssmtp.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeffrin@rajagiritech.edu.in,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DB79C2B68F0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

hello,

 Compiled and booted  6.18.19-rc1+
No new typical dmesg regressions
.

Tested-by: Jeffrin Jose T <jeffrin@rajagiritech.edu.in>


--
software engineer
rajagiri school of engineering and technology-

