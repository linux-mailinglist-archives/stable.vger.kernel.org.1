Return-Path: <stable+bounces-179320-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ABA8B5405D
	for <lists+stable@lfdr.de>; Fri, 12 Sep 2025 04:30:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 800E21C85F8F
	for <lists+stable@lfdr.de>; Fri, 12 Sep 2025 02:30:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE7501EE7C6;
	Fri, 12 Sep 2025 02:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="Wfq4yWJ/"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02E3A13B7AE
	for <stable@vger.kernel.org>; Fri, 12 Sep 2025 02:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757644216; cv=none; b=FcOTcxa1HPXSDWAMCNR61UKmfLm6SUntdY5fytKCk2LAyizQDQ6t1U8j9am2hqj44pvQTcm/td2Tsfg/zZLKHcV20C9vgkjiXlaKwaUH59VxDqfXNplyDgX0Tvf2RHQ8Ui2Fvdt6NoRjxJYILYEiy/TYAhI4FR2AroA4NTihwSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757644216; c=relaxed/simple;
	bh=vQQIU6ckHc2+RvHHnlo2eleJNpXZev81qLhetlXEw2Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K2CJnfuzkIAkB63I636GzHoZhBiDGboVKsAdujZnMBF6PU6fXJ2C8eiz6RDi3nGNDjjwfef+4C94raAf1O/fljQTJx/sLWUj8+8f3Hs2GMW67ZZLrCTIqdfTjUoRtRfPZyL9OmWc96GOfAeH7CmnID1UmTsFIeBTbpXUD4U1jwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=Wfq4yWJ/; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-7211b09f639so15255946d6.3
        for <stable@vger.kernel.org>; Thu, 11 Sep 2025 19:30:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1757644214; x=1758249014; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bOcBl4BVZOSZI/RGkDZyOTuzjiM4ERqznZpinFtbvyg=;
        b=Wfq4yWJ/5fRvTYXWHplP2tcJqgI4K5WhBq7exprxaW8O9GnbMVmnQ+WyHtXgyGfoZm
         qFaaMQ3X/vTI0zZA/7YyhB6ZxyrqgXvEr495XVxOxW0xNtX/Bh+JDkwP4P+neeOQQiHi
         dXPIgz9l7wEbaiUNqzp+UbdFXOlWSiLmBnjtVwHpkga+6vplDydwiVbt1v323n9qIixg
         /mzQlk81GgqKDqfrYI7Z3150UXzl6iBlAUkgNfY8oO0K/hz9Mf4vGjCd77NKUlo9MFkU
         trZdi5ItiDQeB4+ODoTvYS9SJtB1+4dqL7oyaYH3kSDQcHLFwh0/eNK9g9fviC2SVJZs
         q6Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757644214; x=1758249014;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bOcBl4BVZOSZI/RGkDZyOTuzjiM4ERqznZpinFtbvyg=;
        b=ZzJ5fc0LmWnrqMYBq9jAxoJ7FZh71TK2dpn2BDLCpQxWn3MP/EZxKb4Qe4TAj3gRVT
         //GpheYjiX/i4aMTSBN4Zz52JQezBV9mts2voldQVtvX7+w782QVLLAsjaasqm2d5ojM
         +/fVZZvonv62l+Tjg9K5CeGfmRtDnfnzof9aXbcRU0gxQxB7LiCmmmmr4QCDPJHh31rb
         VpHZ/OO7jbNc+eQVnTetmAthpy8pSiDwqmC/3lvdTQhSziH++MpL2cTYfbjKYEpnXAyZ
         vZUOQQi60yA0H1Ak3dFopu0nur+2dEabPM4XheVand6PBaivM6pZlnkh4XiYfHBm/Hms
         C6Lg==
X-Forwarded-Encrypted: i=1; AJvYcCVNRfSiHG2vneejuR3BtSr+euaCCtpmxHFDI2DZA515tbhjCa3zenQb6T11/YrM3xHZUqvxzxY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLwpfOib+2mMXSNVfM1Wh6ZYVs+oLla9Xr+8NhPgqbg9tHQO8z
	LDP/WqJUvg0N41mi7NJa8vCWC8tsIJyrwkZ5Z5sJNMQe+jsc9fT+dmQY05Skqoi4dg==
X-Gm-Gg: ASbGncvKvAoSZlwQcM5OiYutQrVsqMl8XxVgAbxSCjzHO/Z/QeD1MnqbeZxAbloUSpd
	56WvLQ+KXmfSKcpUFg6SZEnueeEAa7lmi1nauGZVGdjBZsJVkn7y6mW1fuz83+akd5y9MQuDw/H
	S3i1Nzt8lPZGPjRiUqbiww5obHcsDoy5s5C+H5Xn8JEzFUbhioeqpm0vt6jw2mXIOBMk7UPPcWQ
	GGbrAeEhpY40CNkOJjQ8RiQHA049qi3mfXH6NtiUl/vPGpEWNPytJKggS+3O/mwTjt5wYslnVyy
	SsnkMPl0I/L4rdS5so2cC5K59vsOTaiZyaBp/AVL3e79g40zPCiTo/vNBnNTa69IaFHMqzc/8FY
	g9mwUD5aefqInOR4b5I4LkrjQA998UniDgGY=
X-Google-Smtp-Source: AGHT+IF3YJcN8fftkWAXBvp5e8ChiQTwvDs2PYP+e/p5pRC3qGnSYo/pJ7OVH35ncvR4Bc8YEDrv+A==
X-Received: by 2002:a05:6214:230c:b0:70d:b2cb:d015 with SMTP id 6a1803df08f44-767c88fae6bmr22357036d6.67.1757644213876;
        Thu, 11 Sep 2025 19:30:13 -0700 (PDT)
Received: from rowland.harvard.edu ([2601:19b:d03:1700::6aa9])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-763bdd3773bsm19545826d6.36.2025.09.11.19.30.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 19:30:13 -0700 (PDT)
Date: Thu, 11 Sep 2025 22:30:09 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Jakub Kicinski <kuba@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Hubert =?utf-8?Q?Wi=C5=9Bniewski?= <hubert.wisniewski.25632@gmail.com>,
	stable@vger.kernel.org, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	Lukas Wunner <lukas@wunner.de>, Xu Yang <xu.yang_2@nxp.com>,
	linux-usb@vger.kernel.org
Subject: Re: [PATCH net v1 1/1] net: usb: asix: ax88772: drop phylink use in
 PM to avoid MDIO runtime PM wakeups
Message-ID: <22773d93-cbad-41c5-9e79-4d7f6b9e5ec0@rowland.harvard.edu>
References: <20250908112619.2900723-1-o.rempel@pengutronix.de>
 <CGME20250911135853eucas1p283b1afd37287b715403cd2cdbfa03a94@eucas1p2.samsung.com>
 <b5ea8296-f981-445d-a09a-2f389d7f6fdd@samsung.com>
 <aMLfGPIpWKwZszrY@shell.armlinux.org.uk>
 <20250911075513.1d90f8b0@kernel.org>
 <aMM1K_bkk4clt5WD@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aMM1K_bkk4clt5WD@shell.armlinux.org.uk>

On Thu, Sep 11, 2025 at 09:46:35PM +0100, Russell King (Oracle) wrote:
> On Thu, Sep 11, 2025 at 07:55:13AM -0700, Jakub Kicinski wrote:
> > We keep having issues with rtnl_lock taken from resume.
> > Honestly, I'm not sure anyone has found a good solution, yet.
> > Mostly people just don't implement runtime PM.
> > 
> > If we were able to pass optional context to suspend/resume
> > we could implement conditional locking. We'd lose a lot of
> > self-respect but it'd make fixing such bugs easier..
> 
> Normal drivers have the option of separate callbacks for runtime PM
> vs system suspend/resume states. It seems USB doesn't, just munging
> everything into one pair of suspend and resume ops without any way
> of telling them apart. I suggest that is part of the problem here.
> 
> However, I'm not a USB expert, so...

The USB subsystem uses only one pair of callbacks for suspend and resume 
because USB hardware has only one suspend state.  However, the callbacks 
do get an extra pm_message_t parameter which they can use to distinguish 
between system sleep transitions and runtime PM transitions.

Alan Stern

