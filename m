Return-Path: <stable+bounces-215735-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oOfnEqfci2k9cQAAu9opvQ
	(envelope-from <stable+bounces-215735-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 11 Feb 2026 02:34:31 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 664ED1207A2
	for <lists+stable@lfdr.de>; Wed, 11 Feb 2026 02:34:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EF1633013C45
	for <lists+stable@lfdr.de>; Wed, 11 Feb 2026 01:34:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66ED52741AB;
	Wed, 11 Feb 2026 01:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="cqYRKg58"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E880201004
	for <stable@vger.kernel.org>; Wed, 11 Feb 2026 01:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770773663; cv=none; b=XFn5NxJX11ggY6bO+YC41gbIO27ZkoM7bzmt4V+do1FD0fntaM8/kBvnClkGFoPEoxk29sTgOrTKAldTnaP1Vosf2oP2L7dLV6/76R5/l8lTVMC6AFcgS+HqS4aJcq/0iBoKWhtbhhbzqV4HF+d44eKugsKPMHk/RAPexzO3JI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770773663; c=relaxed/simple;
	bh=A8nICfib0TyQ1veAYiZTePZtta6HfMcxlT3QckErAro=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LpaPa0WBszj7y0JacPoQHL/mLxZuvLmz4sbVNmA7ITZzv1wvQcjlRK0tW5ZqkHVrFYbhwuKj2qb2+fSzdE5P2Gp3dV3WIA64QRCa5ZHQW6fQpS6Cew1mZfXsF54ULGOYAE8Xpn2jHdHeFF0prLTABe418u4XDmv6IzPiTqW6Q/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=cqYRKg58; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-c6c67bc8b9eso2527109a12.1
        for <stable@vger.kernel.org>; Tue, 10 Feb 2026 17:34:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1770773661; x=1771378461; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=L8YQjWm58lWYBHnmQ2ylv8+SOgWGHnRAFzYCue4QlMc=;
        b=cqYRKg58YA2N555xOkDVinmSTHhH+8j/ZiZgyRcrfecq+ulNLzfl+qYs6dJQtDjiRA
         gcB0vaK6yBTskk3TXA8qHdBUxkOfEctAN+rUpntspW/g+lCo1b2bh1Me/5fLCi6dvXPC
         ycXYeJ4WlxQ4YHdNewxRkqLTkUJNjD624bqw4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770773661; x=1771378461;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L8YQjWm58lWYBHnmQ2ylv8+SOgWGHnRAFzYCue4QlMc=;
        b=aHRhCX3e/WCdefMkcBb5VWKEaqU8ugbnUqTWXgjPjBgkipwdbXIlvthI4tQwu6yRNE
         x/ZTa3CGB/H94YO+lTFr8/XfR60A5DmhQHtdX2sLEfafvPrfOoJ9wGmvS1EEIR6WrKrK
         O7dd8Ok17/JcYcxohBRtK74tAnvGAzqh83NvWG2RlmJJ11Nu0ADAVmMJTIfGjn9ie2/Y
         eBwm5p+/rRF82hBX1CxVlk8FLgVLnnmD5hp42Sk/KPZVrtl1u2Zl3n3ja6re6UyE0SbU
         b59/D90A7a7IqWASa7qkmIiskOEoabvtNWTHlLUQdNgZYwNPezw8tsWKq3FnCBUOUxFP
         swww==
X-Forwarded-Encrypted: i=1; AJvYcCUE3UN29v1UmYR2ddp1N2G8luvBhjddPHPgOXgG+faygEAXOGz5SCEPr5yASKZrOcaOcsvWx0o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzz1ufq+6GIet9G4ZrEdoKBsDjNLX5ZvQIOxbSizYtTXxGORsy8
	rIU2zQCpg4zz0swGWQz4UjWV2iDdYRaw7Z+a6jzBVc+juUrBvrcwtsa9eRSED7hFKw==
X-Gm-Gg: AZuq6aIdgcu1ub8pLFXkCEQnPOYkv3vMCpiTWqRmcZs4mL262WpEsvzK+ropcSfSbmA
	7ED930yCnsSjI2ceCpuZB3S87BvUh/pjgVfSglrCi3rXPVodG3VDekv4atgcmrTFO74uf6yQxlW
	qoUnQKqyECytJ2xZNY8Jvct6d+J6FPA9BkGS25K89wjfCtHRpjs3ESU8qH9+XW3fLZtFRGCP8sj
	4v1lfWL2QHZpUO8EG7Hc6nZNIjop7D2ZOU2zSrHxLd6AL3iqjzMATr3nwuZS7egqiZYq0KBorfE
	zV+DknWLBymzUWuQ4Cr4vCBfjDm7HdEuDyd1abmYCx0AVwsdFSRkBs4Wl0imdZEtgt9VF1xuanM
	PBZu425sBEyqu9EeJwLD9ecyqts7JoTrX6MZEYgoP1xxyIJ41jri+aU5/vBxmaDA2a0S/KMjmef
	8b/BA1hxlT3fw1HvDFbdwk9LMOXMdvGfhcdl1LeXF9PXR+w9/NT470/pbcWuuvuA==
X-Received: by 2002:a17:902:d481:b0:2a7:63dd:349b with SMTP id d9443c01a7336-2ab102f4d0fmr38295215ad.10.1770773661497;
        Tue, 10 Feb 2026 17:34:21 -0800 (PST)
Received: from google.com ([2a00:79e0:2031:6:ec5:3497:e96b:e7be])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ab296e5a72sm3932525ad.0.2026.02.10.17.34.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Feb 2026 17:34:20 -0800 (PST)
Date: Wed, 11 Feb 2026 10:34:17 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Xueqin Luo <luoxueqin@kylinos.cn>, dsmythies@telus.net, christian.loehle@arm.com, 
	daniel.lezcano@linaro.org, gregkh@linuxfoundation.org, harshvardhan.j.jha@oracle.com, 
	linux-pm@vger.kernel.org, sashal@kernel.org, stable@vger.kernel.org
Subject: Re: Performance regressions introduced via Revert "cpuidle: menu:
 Avoid discarding useful information" on 5.15 LTS
Message-ID: <ba2bwuhcua2zakojk2wcksyxol76o7lmmceaunls4436gqh4ry@ys3mpganxhwy>
References: <006601dc965c$afe30280$0fa90780$@telus.net>
 <20260210093321.71876-1-luoxueqin@kylinos.cn>
 <67clm4sqv5cbqxjhjoyn4eodwocc2jm6piwky6cyv4zncfrp7p@izdkjc5db37j>
 <CAJZ5v0gxNdQG8O32PrBcSa3GGvQCYObrquuiUXyJ8kgPV=91Sg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0gxNdQG8O32PrBcSa3GGvQCYObrquuiUXyJ8kgPV=91Sg@mail.gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[chromium.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[chromium.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[chromium.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-215735-lists,stable=lfdr.de];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[senozhatsky@chromium.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 664ED1207A2
X-Rspamd-Action: no action

On (26/02/10 15:24), Rafael J. Wysocki wrote:
> On Tue, Feb 10, 2026 at 11:04 AM Sergey Senozhatsky
> <senozhatsky@chromium.org> wrote:
> >
> > On (26/02/10 17:33), Xueqin Luo wrote:
> > >
> > > In addition to the cpuidle statistics, measured system idle power is
> > > about 2W higher when this commit is applied.
> > >
> >
> > We also noticed shorted battery life on some of the affected laptops.
> 
> Was the difference significant?

I think I saw up to "5.16% regression in perf.minutes_battery_life"

