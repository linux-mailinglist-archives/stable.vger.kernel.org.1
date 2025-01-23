Return-Path: <stable+bounces-110290-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2496EA1A6BD
	for <lists+stable@lfdr.de>; Thu, 23 Jan 2025 16:11:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFBF03A15B9
	for <lists+stable@lfdr.de>; Thu, 23 Jan 2025 15:11:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29F60212B06;
	Thu, 23 Jan 2025 15:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cEvf8YtW"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B2A31CA8D;
	Thu, 23 Jan 2025 15:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737645072; cv=none; b=dhCJwieHrgjbohAQUm2xF9ZFRJs8CiLvtPJiqc3v6wVZkKjkdlpK4c8fh7mpr9561gHONoCR43eIpCfaykmxDLu811cA9wI10q8z/XekEdZ0et0whx3cyfuLs/RQpnHfFrOOC/JAiwTxzytIeDyEg2+3Hexixoxbr7J4kWz6xlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737645072; c=relaxed/simple;
	bh=Tif76zDRrIJX6lJuKWq8bNtyoEWXtS07G9SKxrHHHfg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bMj5Drgm/6d5ipNVFxdEk4MlgfiqjE3Y0efeowXbu5X9nSYdHSgZMgLm+JfgFuVGG3RUG59FITQ5t55sRzlMnuIn2fO9sDlkTAPpqdFytajC72ZQi5buCpr0EA9bPyN+tH5veOCaHIG1WbzhDfQMJw+s+0Wy5jqq5EZlxyY+AVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cEvf8YtW; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2164b662090so20022715ad.1;
        Thu, 23 Jan 2025 07:11:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737645070; x=1738249870; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=CPVOhXs2R7AvyExLoxGLf0L/phBUtvvTj+5Z0v1peEA=;
        b=cEvf8YtW1HURnpfXrewojfO+Ufq3/AfwAWlajd+dCxpznPC5fZ/lIR3KgJYtEMLK2r
         2k2H0InYnZNJBmmGKLXo6YcpFszd66aQ3LhkHZL+XiAL2wQGduV8uz6YjmfYZs3LFZ6x
         WTr2OAgCGXnDof0lx3hMeeOhahUt4iDUkDB/ma6tZMiiWW3uWGkD7rWJNV2BPGADo6Oc
         RnlOdcSwLb+oRkeXbfqipqnjhPO22NNRiAA2cPVMOz7NPsKNzaXte19oTT53ETF49CLJ
         vT1T9q05tZtDiQkyseIe80kyC/os0QenfBmUktHrjFAUgxSHS3x0T5nin6XTx0S7AgNN
         OfDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737645070; x=1738249870;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CPVOhXs2R7AvyExLoxGLf0L/phBUtvvTj+5Z0v1peEA=;
        b=boxp+srXdwirLA3L7moRcHezL3p/S16nIMhP4MDlwNbxS9RPl7GwT2G9kxy3o355Ye
         MwQTOTYT9hMeERgqXdse9fnAuKu8oKCdEsPK3fVudAufxKBwBEgAT2n5wzLEUNSoP4nJ
         aXjdQ2828BYmY1sYTHmNX3UwRkFjaP5qxfhZlZdH4uErS5BCaRAQsUEzfi5XFCISiROb
         iFOpmY8T6QxtxM1bCBD4+oqnHhADx6SGoAablv6VOpgcYsccsrFaY7GrwC3SL+25l8bN
         i/6c4xjzDPM0woM7No74gA4gEBovgAMbwAgfmPTJmcaljd2vQT/ZDjiNkiVrXhVEZQo+
         PfKQ==
X-Forwarded-Encrypted: i=1; AJvYcCUcpvuVuarTuzelvfumzZnwlXZaCLb4Y+3NgfnnNcVUENNdVfHu4P8Drms4DKP/KNi/kTT0IYBKsbFjVlw=@vger.kernel.org, AJvYcCVao+HBBQCa08YoEfU4telACStd8EOA/qjYNjIJ1h2aDCZ8lFYiSVFd/hyCYFmnALUKAhMAfyoB@vger.kernel.org, AJvYcCWDqlFYpV8fAfn/5hxAR9HfmO2x9L19U0J9ccd4po7O1kBcAV2ReEGviZnh+dSe0R+hgsXH5RhW@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4aiC8YkC5xaLMP+8QoPBZK6kTeZhwRWCp080WrjmleJI+63By
	XmPNQZMy0LrH1KtipxT9RfzQAIEQ5M6gBpS1YyOjtDJAadhjPY/B
X-Gm-Gg: ASbGncuO3dpcJyrG7fAWXcelG361kWkyoY3xuSkADPnXowLKQVZoimJsedMhMh1+hyI
	XfdXv8kvgQ5+To7QPpYlGSmaifiqMCswm2rKsZ9uz7VTfqgz4NMhYWo9sAu4pGUsnAse7q/5Rv2
	2jKr4C1BlGCnmii9ycNV1THoXZS8Fev4qLKN8lokIqh+Fi6qC9+RC0kStztjuu/sz9JvB+pGfd7
	hpBSnKWgbIhdFweY6VWK3U+fgfnVn5LRj/kj4KfPKSmvBW4r1KDSFbqPBPLS7+gxDl3Mvn2FQ7o
	OMjNtmDX/V7ON2eAkAgLwiCs
X-Google-Smtp-Source: AGHT+IHGhnh5sedgClGN15IhDMrSkupxb1oxY9VDNKt+MW2FCfzIppVwZ5pXtLHL0q/K/w9+EUv/+w==
X-Received: by 2002:a17:902:da88:b0:216:69ca:773b with SMTP id d9443c01a7336-21c352c7b99mr402128005ad.5.1737645069936;
        Thu, 23 Jan 2025 07:11:09 -0800 (PST)
Received: from hoboy.vegasvil.org ([2600:1700:2430:6f6f:e2d5:5eff:fea5:802f])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21da3d9c552sm180675ad.18.2025.01.23.07.11.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2025 07:11:09 -0800 (PST)
Date: Thu, 23 Jan 2025 07:11:07 -0800
From: Richard Cochran <richardcochran@gmail.com>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	John Stultz <john.stultz@linaro.org>, Arnd Bergmann <arnd@arndb.de>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH RESEND net] ptp: Ensure info->enable callback is always
 set
Message-ID: <Z5JcCxGuQNH9bZYH@hoboy.vegasvil.org>
References: <20250123-ptp-enable-v1-1-b015834d3a47@weissschuh.net>
 <Z5IOHVu9L+QpyK4Y@mev-dev.igk.intel.com>
 <779708b6-d61c-4688-92cc-6afb987334d6@t-8ch.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <779708b6-d61c-4688-92cc-6afb987334d6@t-8ch.de>

On Thu, Jan 23, 2025 at 02:19:46PM +0100, Thomas Weißschuh wrote:
> On 2025-01-23 10:38:37+0100, Michal Swiatkowski wrote:
> > What about other ops, did you check it too? Looks like it isn't needed,
> > but it sometimes hard to follow.
> 
> I couldn't find any missing, but I'm not familiar with the subsystem and
> didn't check too hard.

Initially all of the callbacks were required, but that requirement
became relaxed over time with getcycles64().

Now that we have more and more drivers, it wouldn't hurt to let
ptp_clock_register() check that the needed callbacks are valid.

> Note:
> 
> A follow-up fix would be to actually guard the users of ->enable and
> error out.

Yes, I would place checks at the call sites, within ptp_ioctl().

Thanks,
Richard

