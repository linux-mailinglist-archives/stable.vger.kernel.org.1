Return-Path: <stable+bounces-160398-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 79CB0AFBCC7
	for <lists+stable@lfdr.de>; Mon,  7 Jul 2025 22:48:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 783933A7281
	for <lists+stable@lfdr.de>; Mon,  7 Jul 2025 20:47:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E32C421B9DE;
	Mon,  7 Jul 2025 20:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZmnoBVwr"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A5743597A;
	Mon,  7 Jul 2025 20:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751921295; cv=none; b=UJgRvcvIL8jCYVxnqPJ3CPLky6GAGaAuP5GBCwbJLq6jZx0p5XrX556s0rUy3jToIHr7OGrBY+PPHMLBDxjxJr4e/a13Px2CzZXjFg1tY2/8lHmfsn5oWR/CjC2toPhj/a3QzlFqw5cWKsLULNAuvfpEQpBtOL7jUMlUI6+y7H0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751921295; c=relaxed/simple;
	bh=0LyE35m8eGiFlVySwAeG7x+SezPWKMVGpHRDKOL3s2I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HdVfuReo1w8jjuPQD890oIyn+DX8xWTXhjrm72S8w3aCD8hTpU6mGmLHXXQpJKrufiRxKkxmL5h2Y0nn5dyltdEavRQgvnwPXmTzJfDLOWnpkJalCu/Tk+U9/uuwrx0gnCuMGjnqHDb1mU+CD8kta3amUbLzCfXFK7oIc245n1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZmnoBVwr; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-315f6b20cf9so3710524a91.2;
        Mon, 07 Jul 2025 13:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751921293; x=1752526093; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XF8yJPEDjiuHbqKfKD0xRU3CXXpK0mf7JKANzcAD7fw=;
        b=ZmnoBVwri+Ys0YEQv94ofKhn0MjpnR2F9iBfE76zsLOdn246K7Ni4Ze2vkSweUT06A
         5azU0w06G6ueVwt/yYUkcrvR+qHR6nl9/anmEAAazecwrSKB/sM1U3J4VmI93jdM623c
         F/wDmNmWMwkA0qiGx1Iacfl3JM48r8vpPYDg4Oqb3bqbHsghVZxZJlpLfGmm2Ka68oPT
         3VPo5512XSybxMY5aezGEEXyJs2uFbVjZxnhSU1xR+40MkLC8QwYbQO+KNCIOCtS1ux4
         xPPmEY057h1tgD58fDz6jr2Wx8Jl22gi7QnIPsPwVC+MK/K7F5ehEXFz484y+kpdEa0D
         +n/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751921293; x=1752526093;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XF8yJPEDjiuHbqKfKD0xRU3CXXpK0mf7JKANzcAD7fw=;
        b=aQ2CXH4nLL2xsAS+8WM9xgXTjhkhB5L8CblO8Xf3r6W0bNaMDbBCgecDya72XZejek
         iRxFJjcxOQvOOq6Oci73FCP6NyPi6vRKX5re6GTRoIL/f1+RHB0hko/+omc9hf57HIFu
         gL70QFDzcE3QyUDmtocUzac+m8zuhcuq6zMIrasJHJ2vUMfh2vcI/6JvaK313W04FIRI
         t2XI2yuZQw6fkXWsNc5GHopAwGlIgvOysrGbdkxGm4V4NyqBoeqkEVyC0rP+msjKJRHo
         XS1NgA0sYfg7beCOCxpR/G+qV8ajIbKzlSKsdMP5OFv6n+VaSbrAq6/HOZ5AEG4KCEOa
         VfUg==
X-Forwarded-Encrypted: i=1; AJvYcCV9QI9h0Jz8blfoyCE7icXPtcotprpqD69vsf3O4VNs5eYHIey47VGXguGhoFXLXEEphGm0Gb5toYCK5EM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjZYQgXrnv7s40wLk65H39I3nAn8C0NYE+FPL979YsYJ0rrevr
	D/XBDMMcGkDivwh86KBEjHKzWl0ah4PHQEWrtIPHUKyJs3p7gFpVD2Wz
X-Gm-Gg: ASbGncvLMcVNPMu3mA2jkYWYhus5WlpbNnBkYo2cCXT0ltX8Q1uo/ahG+QZv146NoR+
	71I8pnq+vByn3ria9MLKErbTcOHJxcCGA58ymAidzsls3ZDemwy0zxbq4b6wPVLvWQT0BkkgDGk
	BoK6M0v0XFfglu9Jdg+/YwUsz9H1EtD2qgfeSnaBXTuroYXgxwLPEo3HYOasOy1ABul3vyFXgZ9
	CJgSy0Ozaxh78BpyfMk5rVYFbWcUZDm99OUBnHBiYQCF8kPCU/nnbYKamN59uVYY8j6OY+Atilg
	YULbxjNC2DAmxeFKzkLTKsjuLx3lG5ryWSAUcoz+8C3DsbW8fCPOb0AzzWt403qnxiQO47dI/nM
	fNKDr+a310A==
X-Google-Smtp-Source: AGHT+IFnGPopEwxi19+AVmddL6Q79QsAwXX8s12yZFjnSUGbziH4oWCaeqZ0smSWjCzluneBrcJuwA==
X-Received: by 2002:a17:90b:51d1:b0:312:eaea:afa1 with SMTP id 98e67ed59e1d1-31aaddb4b02mr21412268a91.29.1751921293142;
        Mon, 07 Jul 2025 13:48:13 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31c21d67b7dsm210122a91.11.2025.07.07.13.48.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jul 2025 13:48:12 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Mon, 7 Jul 2025 13:48:11 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
	lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
	f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
	hargar@microsoft.com, broonie@kernel.org
Subject: Re: [PATCH 6.12 000/413] 6.12.35-rc2 review
Message-ID: <6bd90403-d7ed-4683-90a8-98f945a3ae36@roeck-us.net>
References: <20250624121426.466976226@linuxfoundation.org>
 <3037c3e6-558b-4824-8c78-a36990f4e4d6@roeck-us.net>
 <2025070613-escalate-action-761d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2025070613-escalate-action-761d@gregkh>

On Sun, Jul 06, 2025 at 08:03:56AM +0200, Greg Kroah-Hartman wrote:
> On Sat, Jul 05, 2025 at 12:37:52PM -0700, Guenter Roeck wrote:
> > Hi Greg,
> > 
> > On Tue, Jun 24, 2025 at 01:29:53PM +0100, Greg Kroah-Hartman wrote:
> > > This is the start of the stable review cycle for the 6.12.35 release.
> > > There are 413 patches in this series, all will be posted as a response
> > > to this one.  If anyone has any issues with these being applied, please
> > > let me know.
> > > 
> > > Responses should be made by Thu, 26 Jun 2025 12:13:28 +0000.
> > > Anything received after that time might be too late.
> > > 
> > 
> > Some subsequent fixes are missing:
> > 
> > > Tzung-Bi Shih <tzungbi@kernel.org>
> > >     drm/i915/pmu: Fix build error with GCOV and AutoFDO enabled
> > > 
> > 
> > Fixed by commit d02b2103a08b ("drm/i915: fix build error some more").
> 
> How did you check?  This is already in the queues for 6.6, 6.12, and
> 6.15.
> 
...
> 
> They are going to be in THIS release, with one exception as noted above.
> I think something went really wrong with your checking scripts :(
> 
Frankly, I have no clue what I did ;-). I _thought_ I pulled the branch
and checked, but apparently I didn't. Maybe I was dreaming.

Sorry for the noise.

Guenter

