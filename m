Return-Path: <stable+bounces-180412-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FAD5B80537
	for <lists+stable@lfdr.de>; Wed, 17 Sep 2025 17:01:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 56CDC7BB20F
	for <lists+stable@lfdr.de>; Wed, 17 Sep 2025 14:59:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D29033B490;
	Wed, 17 Sep 2025 14:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="iyOk5hTd"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 510AB33B482
	for <stable@vger.kernel.org>; Wed, 17 Sep 2025 14:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758121049; cv=none; b=EM/KyynaWIaElCjhmS4bVBh4bRvVWTRo2PZVUH9UOQJ0FzeShHrxeFslPPWI8TRg9p3TtoJP0YOyRUqh0I+kbHzOaMR9FNcsXJBL7p0LYdcp9ae5eNhGjDrfDNLtBiETuXWngS/Rqsd88wtOcCZF0MTidw45UkvblosyCmBbQsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758121049; c=relaxed/simple;
	bh=9OJQZq6bHCOGv02hQ9NPzIP7qKBnKi5yAR5CrQuWy6g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TRVB9PY6jcEdmAeeP3HAHYARwpfm9sjTUOLPnNyLtUGnu17GC3cqaRpDsqXR4+u2/6mMruyoRldqz6A/Pzd8UWId7GaliU3SPvUsbSJtGT1Rv3giP/rGPkmqm2oTu8jxCU71+SQnW3G7FzOinVFmxPBwOv6NpWp6pD5n9iKw2CI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=iyOk5hTd; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-8127215a4c6so101695285a.0
        for <stable@vger.kernel.org>; Wed, 17 Sep 2025 07:57:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1758121046; x=1758725846; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=W8HN1UTZvELIwcpsDbtiuDd2WLyYOA0zppT13Ez3H28=;
        b=iyOk5hTd0RGR9IJYHKGcrhnycmh/4ftPLUaqp3uwYYz6uA9kAqIbgGODrL6+WBffg0
         ASlqAudM790xLRDtuWWVwGyscKIBeOCecYaxuipegTHgeE3O2ZwrmDYwfAcZmOhtrYQs
         gfKdsmskHqq3krQtsNfAaxiEd3Hyp41ZR6lsxwJBmigCoKmRuSdQChvKcyJjfMq4K4WV
         hK30HKK/+ZfvEEt4CWApkQQB5nEMOCD3uJYt57jUsnemEI1SeaoBf8fSVBslYFyb4zJ/
         qKaDohT80/SXOdXnCUU+ZFDXbAaoyRjUz6d3wNqDRh7pDiGVCollGDl+dZzXX1RK185h
         9o8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758121046; x=1758725846;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W8HN1UTZvELIwcpsDbtiuDd2WLyYOA0zppT13Ez3H28=;
        b=TTVrBswYLu7UScMGhN+w8bCgFijqkswVxYl2GM8XBUqPmYUvyYGumm9kg8JXUyD/+p
         3TVmkKf2S2UoSX9+g4BCyXOsYTHEy43EEgy9jMHCm4fvbZAOrOZs2CI1JgigwQUj+mq2
         naYgM5BQ5vqZ9Mo2GMDx/DXl7Lk2tpzNwZvs9nowzG/Lv5vm0bxrNwgf+16tM4yP5gZu
         CWkSFwfdhlR3spQrcHvOiepGPMxZ6ELpTIlD4oIGxIDgU7s95K1VEPAZLGeafgcXbuXd
         2UJKKACSR4Ftv6qdYUbvPuEeX/LII5KACI9Oyxp11Bml2I4N/bAZH1PolBsxRoLaSB54
         n5yw==
X-Forwarded-Encrypted: i=1; AJvYcCWr0R4tJmHyJp9ZfgQ1+lRzfky29aE9hfY0ajgq4FmG473COdrqg7yokLteuxP7BAiNKEppwpY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyk9KmkAjBUOryJfsCwHWuTorqt5d8VgteEYWLCbwJh+ujo1eXE
	1Yt1bzjfZVK80zwuO6/O0PrGw6U4PNxDC0mRDb57/fv3MivFSDSkKvO9yUUyvhV1NQ==
X-Gm-Gg: ASbGnct2bORED8xdb9IRqqLOQX3mOKN9qapTLISPnHhbiaK+8ZMYycY0aAr6b0VDwuq
	kbau1MqtnhR0r1fCxm++HSJGOJJ4+Qkx+6AsIfuQ/i+5qWYOFU7BHmQECNlyBs9tynNEurvWoNA
	Y6sGaaIAJ4+ppXtsUmVdqHLhYq+iaU3Ci2zyEQAQq4lLiB1jYEny6moqamocUwEEtkfyej7+nxo
	pElu3NnHEko5tD0/VwVYFsSa0/tAH+HZnZt3UG8vIRCA4rFj0ZT8OhvcwfMrXyvmzMqfN3owUtl
	eNEZmvo0ceTGCBORipsYmJsU0xD8qxhGMoZt8CPJthjBTAuAIQe+/alYubXV38SICaGmWnT8K1x
	Y8bCj+l3W5Nm8HPbL01EaqIYQcV38DbKU4RohfWIsNoMLkVsO5ZuD5KRIjp/ztMs2QV89ReaNYz
	kf/N4K/LVAgDGfFemotgkK
X-Google-Smtp-Source: AGHT+IHSha0l2uy8bY+NcvRiDKKxmDF7lfi4/yLSRxZTDI+PO2c2F0E2cv/USSjdeL4NWU7Va2vk2w==
X-Received: by 2002:a05:620a:4713:b0:828:b2ab:a50e with SMTP id af79cd13be357-82b9e38f41bmr799576585a.31.1758121045894;
        Wed, 17 Sep 2025 07:57:25 -0700 (PDT)
Received: from rowland.harvard.edu (nat-65-112-8-24.harvard-secure.wrls.harvard.edu. [65.112.8.24])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-820c974dbbbsm1145829885a.21.2025.09.17.07.57.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 07:57:25 -0700 (PDT)
Date: Wed, 17 Sep 2025 10:57:23 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: Hubert =?utf-8?Q?Wi=C5=9Bniewski?= <hubert.wisniewski.25632@gmail.com>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>, stable@vger.kernel.org,
	kernel@pengutronix.de, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, Lukas Wunner <lukas@wunner.de>,
	Russell King <linux@armlinux.org.uk>, Xu Yang <xu.yang_2@nxp.com>,
	linux-usb@vger.kernel.org
Subject: Re: [PATCH net v1 1/1] net: usb: asix: forbid runtime PM to avoid
 PM/MDIO + RTNL deadlock
Message-ID: <ccfd7d48-401b-4f25-ac8e-aa6aa9654956@rowland.harvard.edu>
References: <20250917095457.2103318-1-o.rempel@pengutronix.de>
 <c94af0e9-dc67-432e-a853-e41bfa59e863@rowland.harvard.edu>
 <DCV5CKKQTTMV.GA825CXM0H9F@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DCV5CKKQTTMV.GA825CXM0H9F@gmail.com>

On Wed, Sep 17, 2025 at 04:31:40PM +0200, Hubert Wiśniewski wrote:
> On Wed Sep 17, 2025 at 3:54 PM CEST, Alan Stern wrote:
> > Are you aware that the action of pm_runtime_forbid() can be reversed by 
> > the user (by writing "auto" to the .../power/control sysfs file)?
> 
> I have tested this. With this patch, it seems that writing "auto" to
> power/control has no effect -- power/runtime_status remains "active" and
> the device does not get suspended. But maybe there is a way to force the
> suspension anyway?

I don't know exactly what's going on in your particular case.  However, 
if you read the source code for control_store() in 
drivers/base/power/sysfs.c, you'll see that writing "auto" to the 
attribute file causes the function to call pm_runtime_allow().

If you turn on CONFIG_PM_ADVANCED_DEBUG there will be extra files in the 
.../power/ directory, showing some of the other runtime PM values.  
Perhaps they will help you to figure out what's happening.

Alan Stern

