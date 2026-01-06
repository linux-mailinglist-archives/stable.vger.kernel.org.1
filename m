Return-Path: <stable+bounces-205056-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AB73CCF7796
	for <lists+stable@lfdr.de>; Tue, 06 Jan 2026 10:20:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1191E312A6F2
	for <lists+stable@lfdr.de>; Tue,  6 Jan 2026 09:15:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C181C30F94B;
	Tue,  6 Jan 2026 09:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com header.b="RpS+foLe"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17DC630DED7
	for <stable@vger.kernel.org>; Tue,  6 Jan 2026 09:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767690938; cv=none; b=coGdyO2Gq37e8Zb+tQBJFZ0F/DkhZm96z8aQ3y41XGQZvkDgaIvH3D/N5I68W+M0Di1XTgb+JK6CETq7XGpYbE/KxC7Ujd1KpyTc/+jTFf5ko0dfmwCzetqkVK4GZTzyquOwTUbQuSvv0f7pdOProtNPH6NsJOUToLF+QWzWe5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767690938; c=relaxed/simple;
	bh=OA52/i2DySdJ2oa/UO8WVQLSVE0wUq50Xz8n8YBQARw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EEdlnZ2r+psOYD4lVsWCTYWKKd6YkPt3GHqgWpMX++HPeCxnPsCnmAsfjmuncChS/SoeAUXGKfXaqQMTpiWGrIRc/jnN+P9O5OMV5w8oId7POWmlXTN/uxyH7Gw7uUEN+qV7XliFRGZCWGNAbABlyl6JPNa4Zv+WhB/0nCn/2z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=konsulko.com; spf=pass smtp.mailfrom=konsulko.com; dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com header.b=RpS+foLe; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=konsulko.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6505cbe47d8so1226255a12.1
        for <stable@vger.kernel.org>; Tue, 06 Jan 2026 01:15:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1767690934; x=1768295734; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=j6/zpETfkXIXzs5jvYKUCRYKONy/bc8t30ozg4s3tEQ=;
        b=RpS+foLe7a6RinjXLpQ5o5TSzKdgfG8HShjE+fkVJtaPJudVXiJlkfi4ofYeoxkqBD
         mLQeOUxUl2p1OiejsUV6cmoNM6gIQwEB+k39bAn9ZL00YaTLFoY5nIi7JoJXo2DKEnw1
         7QHIVKeuD5oTQZPnhuNk5P1//+GiQlQ9zJL9U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767690934; x=1768295734;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j6/zpETfkXIXzs5jvYKUCRYKONy/bc8t30ozg4s3tEQ=;
        b=T+eZyZI7LFwA0YUPcfXev8y8LQ71WAUGP3w5UDvVfQHt6k6Q0dLTVRIgDCkr92gmby
         VtknVw/aDaJOoKDyM8UDvHm2LWH1WOKDI5sxpSHVOdjU5GdOQdQvK8rzUf4+PPzYeq02
         phNliqkD5jirJWRXlA21YKUteUuHp2NITCFrfoC18p4FeMR+aTu5VvJusMmL9bjIiVMO
         oFuAbrNJ1lgnh7jI8KQGw3OTZCBzXQms/n+SdgZkCTD0xTPPzUrFdYnkMf9JRO8hlQpS
         JKCGL3Di0soi6/deyGeS+VypWKT1urQuBvptOsRecYDPDKhhN6tPBceYnyJIpI94P4H4
         8+qA==
X-Forwarded-Encrypted: i=1; AJvYcCX/QzQCPr0jJ8aKbxjV363cVY43kvBK3lHWHEzOn4bFDprqOGjyAHWUKMh36MBfEQrQ+JE69c4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwefW0Ji/NylOkJL83q9JFU4IMs5874EA1CltLIbZXA/AXT8nq3
	WMppxxlDeC6l4jXgqloKZyU/UnXVyYlKm0oU0wJBjQwypqX34IK51z8QyD7yQyYGD1XAdpvNdPL
	8uJbE
X-Gm-Gg: AY/fxX40DV93EEHWsOryua7NT1clt/wsStAWbqxvO38BPRYeC+QGyffjc+5R5h+cmE5
	7fjpQFYKRpdJhO+lvx1BzUViwxTDBLFyh/eKlZbL3YQ7WSwHvTdVVhH0ScvJUSbSwm8joNcMswy
	XV4LRCxtisxUybpHD6asmPiVs1j53V7uCAauF10VLamDxZXYeaWnDEqM9S/tg13qa2Wtuuxn4Ff
	JlUkMPWCovshqJlApF4XFO0jbq1EGMXsp2+F0kf5C84TohcniZo9gWnAoKGCdgbH0LCSoDPaYzI
	TbeOLzpZQt9yaq+JvYAd8Lm2Yl1Qak6sqg82mviGGriTLup9lJP/Luf+GEI6TQJazNqNoAL+/sR
	TLpED43bYspX5iPMJDo1fBMEo7Vg7wf8rOlwx+KN9dUQoIe9XU/CwIttuLUjzzRYn64wm54R0F1
	2nHKrlefvRW/INi9XNpNQ=
X-Google-Smtp-Source: AGHT+IHa1yFWPnvONAfuUp5TLEw8FoXzXY4i9ww+OmCrNhj1GQ19Fi4TwPShASdRT4IaN8gbBkvqQw==
X-Received: by 2002:a17:907:3ea1:b0:b83:1326:a56a with SMTP id a640c23a62f3a-b8426c68092mr253739866b.58.1767690933968;
        Tue, 06 Jan 2026 01:15:33 -0800 (PST)
Received: from cabron.k.g ([95.111.117.177])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b842a27c0bfsm177640866b.22.2026.01.06.01.15.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 01:15:33 -0800 (PST)
Date: Tue, 6 Jan 2026 11:15:32 +0200
From: Petko Manolov <petko.manolov@konsulko.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Paolo Abeni <pabeni@redhat.com>, davem@davemloft.net,
	netdev@vger.kernel.org, kuba@kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] net: usb: pegasus: fix memory leak on usb_submit_urb()
 failure
Message-ID: <20260106091532.GA4723@cabron.k.g>
References: <20251216184113.197439-1-petko.manolov@konsulko.com>
 <b3d2a2fa-35cb-48ad-ad2e-de997e9b2395@redhat.com>
 <20260102121011.GA25015@carbon.k.g>
 <38d73c63-7521-41ad-8d4d-03d5ba2288df@lunn.ch>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <38d73c63-7521-41ad-8d4d-03d5ba2288df@lunn.ch>

On 26-01-02 23:02:53, Andrew Lunn wrote:
> > Sure, will do.  However, my v2 patch makes use of __free() cleanup
> > functionality, which in turn only applies back to v6.6 stable kernels.
> 
> I would suggest not using the magical __free() cleanup.
> 
> https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html#using-device-managed-and-cleanup-h-constructs
> 
>     Low level cleanup constructs (such as __free()) can be used when
>     building APIs and helpers, especially scoped iterators. However,
>     direct use of __free() within networking core and drivers is
>     discouraged. Similar guidance applies to declaring variables
>     mid-function.


Heh, __free() is OK for APIs, but not drivers...

Maybe this text is a relic from the times auto cleanup was not fully understood?


		Petko

