Return-Path: <stable+bounces-110889-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 45088A1DC0E
	for <lists+stable@lfdr.de>; Mon, 27 Jan 2025 19:30:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 585261888B2B
	for <lists+stable@lfdr.de>; Mon, 27 Jan 2025 18:30:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6675D18B467;
	Mon, 27 Jan 2025 18:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uh1YRWf5"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 758F522619;
	Mon, 27 Jan 2025 18:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738002616; cv=none; b=JnkvACFdC1FUk65qU/Qiq0Kdgkbg2/g/lwSHxIx7ZLy4BagzFrYF6Wxy7kuZ17sC6Gk86Ltc2OLk3isyku8rrD0dIZJXhw/B1kgICOxxqQ2UnULyCj40RITbgJ5YJi6DIKLUFTG/f2s7h9Uq3TQO+aRRgSuGYH9r2cqGQidZ8d0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738002616; c=relaxed/simple;
	bh=Ry0pzYLcwCx9M0mqNp6/bOEyP1wFbL932b9BPw4aC9A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hUPKMKqEAGPVAPcbfML26Ex7bbSF6ZzzNgBfl9jsOnHxQCE4coadxgGoorGzmYFjLEgsDa1deUCqgoqkt80JIz3eZtvpYNcF4jYBnlkMj/HJS2RTX/kTfH4HvymvWl/OuUsR1SszQBk/XKuCMttBXTq+DXj1YsE8ZJOR/bSYL/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Uh1YRWf5; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-30615661f98so49794621fa.2;
        Mon, 27 Jan 2025 10:30:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738002612; x=1738607412; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8BuIu4l6wPSP7fJ+Eza3SUprCGG69F2G4g4BU8K2Cio=;
        b=Uh1YRWf5GuErubNIs0E4pHaAd5Vo3AjXMktk9E+mSIHKqhKzMDq6x6c8a3jg8K9lY7
         7zHCC733cuzEuLEofrzjURY0H89OVNLlbwiJFSZhbRhLGSrwOFTDO/foitEOR+o22ea3
         QkCOxztsBtsx287ey95HTYlWEZuoqhDkQy+T/+5BxPdliTtx/O1cGDq8wZ26U+1eUheN
         8hUxRVE9OpFamAthP2qiwjUtsZXwo6xQ8tuH3K3hXcrLMMkH8CJqD8V8YgP2+v/mzHGZ
         Yhr1if7IyR/iV/9IT8mNsL9R7G/UF3JUd9IZ1XP5OkRJM2T0mv46e9yO910XaX1oAGLm
         qCzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738002612; x=1738607412;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8BuIu4l6wPSP7fJ+Eza3SUprCGG69F2G4g4BU8K2Cio=;
        b=kKcksKeDnra/wM7BNiOe9UNypaPsmkUYt/U7Kpj1kN5ElmS+2Q6UbzIaGfqCPY+d7P
         BqUlNOhUhCdbV+ofwMp39qFp9TWlJy33FRU/mXTmXxBE/4LJHBrHRA+xEXl0rvis9O66
         1R28L7N+iWO88i5Y4q3pfIPPfPOmiC+aQjdA4cDvnAydFT/DX8E6n0XB86m/Afb5hhWp
         QV5ybr8PMdxtbVZEZ0tGnOPBxDAfdpYDDY6YJN0dTDf1PLD/KaXjmLezdXUIVyXR7GQA
         /+SReqgnqfcbk9Tp80hjxTY5E9FdhVoehPGzMVK0cZb5QoyOVp1nD9KiwkZtGFvnU5tT
         t5Og==
X-Forwarded-Encrypted: i=1; AJvYcCVemFnVEwXdB/cEd8F7ngDz/g27eiKqkA+VwfMQ+agnU/1dhzgeruReUGFF7YxA/1YYPaY2V4sm@vger.kernel.org, AJvYcCWxioG7UtG3ZQrjRRCfRv/q+hARm0jCSixjWAlORBD4n3aWr98TwHxjsknNnE5nFAx9p2jfOUhxtdjbGw==@vger.kernel.org, AJvYcCXhq4kXZQJBRpduNzwW5pGKDTZvEEj9OThtQyv5kpc2thS2DAdVjpKSf2aCNO4B895eiHuziYvcCwI/re0M@vger.kernel.org
X-Gm-Message-State: AOJu0YxHjl0pt+5xNTt9cQ7GeUPE/6j8bAplI18exZpy+w3hMc0qKErL
	jygouGamKAyhQwTBkJhlXRSvS1fM19LXI1qKUfW3/0Gt/IeX9ROl
X-Gm-Gg: ASbGncvArhbi/ebbZ0MveG8ONNEFGBZzB064OhJwCoxXbDYLqov2KXPwPhduVfE9Sh/
	uA5FtN86BCE78/W/roTWTFfUoXPxte87t4U01j2eauw2mk0UWx/KYDedlqXpTsy/9ze2QPhOTHf
	hWLQMkfMhXlik4NENejhlcDXEOEkv/dKRaZKOvcCIavUAXI62FlWIgToT1ZsWl1BfxYtUojANU/
	pc6UxyIOotCArgYLKh7ETSX1xS3t41Sb+ibZlSU60jTlby8RIvhqfRqoXZ1plHJccrnLWz+Yekx
	g1VifVqBvH9WmT9YlFs=
X-Google-Smtp-Source: AGHT+IH2ScEgn8uuPjwMkePm52H+flcKMPqBEQfjBeotCJ4WSOqUW6FDBnqXkySVZKLeRV4j8HLc5g==
X-Received: by 2002:a2e:a265:0:b0:307:2ae8:14b with SMTP id 38308e7fff4ca-3072cacabd5mr127635061fa.12.1738002612179;
        Mon, 27 Jan 2025 10:30:12 -0800 (PST)
Received: from home.paul.comp (paulfertser.info. [2001:470:26:54b:226:9eff:fe70:80c2])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3076ba66a5csm15866621fa.2.2025.01.27.10.30.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2025 10:30:11 -0800 (PST)
Received: from home.paul.comp (home.paul.comp [IPv6:0:0:0:0:0:0:0:1])
	by home.paul.comp (8.15.2/8.15.2/Debian-22+deb11u3) with ESMTP id 50RIU7Zd002723;
	Mon, 27 Jan 2025 21:30:08 +0300
Received: (from paul@localhost)
	by home.paul.comp (8.15.2/8.15.2/Submit) id 50RIU41a002722;
	Mon, 27 Jan 2025 21:30:04 +0300
Date: Mon, 27 Jan 2025 21:30:03 +0300
From: Paul Fertser <fercerpav@gmail.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: "Winiarska, Iwona" <iwona.winiarska@intel.com>,
        "jae.hyun.yoo@linux.intel.com" <jae.hyun.yoo@linux.intel.com>,
        "Rudolph, Patrick" <patrick.rudolph@9elements.com>,
        "pierre-louis.bossart@linux.dev" <pierre-louis.bossart@linux.dev>,
        "Solanki, Naresh" <naresh.solanki@9elements.com>,
        "jdelvare@suse.com" <jdelvare@suse.com>,
        "fr0st61te@gmail.com" <fr0st61te@gmail.com>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "openbmc@lists.ozlabs.org" <openbmc@lists.ozlabs.org>,
        "joel@jms.id.au" <joel@jms.id.au>
Subject: Re: [PATCH] hwmon: (peci/dimmtemp) Do not provide fake thresholds
 data
Message-ID: <Z5fQqxmlr09M8wr8@home.paul.comp>
References: <20250123122003.6010-1-fercerpav@gmail.com>
 <71b63aa1646af4ae30b59f6d70f3daaeb983b6f8.camel@intel.com>
 <7ee2f237-2c41-4857-838b-12152bc226a9@roeck-us.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7ee2f237-2c41-4857-838b-12152bc226a9@roeck-us.net>

Hi Guenter,

On Mon, Jan 27, 2025 at 09:29:39AM -0800, Guenter Roeck wrote:
> On 1/27/25 08:40, Winiarska, Iwona wrote:
> > On Thu, 2025-01-23 at 15:20 +0300, Paul Fertser wrote:
> > > When an Icelake or Sapphire Rapids CPU isn't providing the maximum and
> > > critical thresholds for particular DIMM the driver should return an
> > > error to the userspace instead of giving it stale (best case) or wrong
> > > (the structure contains all zeros after kzalloc() call) data.
> > > 
> > > The issue can be reproduced by binding the peci driver while the host is
> > > fully booted and idle, this makes PECI interaction unreliable enough.
> > > 
> > > Fixes: 73bc1b885dae ("hwmon: peci: Add dimmtemp driver")
> > > Fixes: 621995b6d795 ("hwmon: (peci/dimmtemp) Add Sapphire Rapids support")
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Paul Fertser <fercerpav@gmail.com>
> > 
> > Hi!
> > 
> > Thank you for the patch.
> > Did you have a chance to test it with OpenBMC dbus-sensors?
> > In general, the change looks okay to me, but since it modifies the behavior
> > (applications will need to handle this, and returning an error will happen more
> > often) we need to confirm that it does not cause any regressions for userspace.
> > 
> 
> I would also like to understand if the error is temporary or permanent.
> If it is permanent, the attributes should not be created in the first
> place. It does not make sense to have limit attributes which always report
> -ENODATA.

The error is temporary. The underlying reason is that when host CPUs
go to deep enough idle sleep state (probably C6) they stop responding
to PECI requests from BMC. Once something starts running the CPU
leaves C6 and starts responding and all the temperature data
(including the thresholds) becomes available again.

-- 
Be free, use free (http://www.gnu.org/philosophy/free-sw.html) software!
mailto:fercerpav@gmail.com

