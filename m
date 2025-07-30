Return-Path: <stable+bounces-165533-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 615F7B16387
	for <lists+stable@lfdr.de>; Wed, 30 Jul 2025 17:20:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0D7F188BEEE
	for <lists+stable@lfdr.de>; Wed, 30 Jul 2025 15:21:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5125F299AA1;
	Wed, 30 Jul 2025 15:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QImK2UTz"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B41B1A5B92;
	Wed, 30 Jul 2025 15:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753888847; cv=none; b=MF6+5TSXCm7Mo7Dmh24DymmxGersna0ii8DEsr6v9+8kxXSyFl38eU6Xj1nxiyRBcIJybwegK3QXI7wlxX01Bdh9/M4Bh3KXZi13gLpaWzSwxANacSLDSLgVnmAbmtUgEFrWx7uQ5WL4xKSy0gTpFYjY/EbdXNQzBlpBRP5DsX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753888847; c=relaxed/simple;
	bh=2YJILWFVi9iNE2E7aaZODttyLwFM9GOA/QeoQJ4EfeY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=buEr5ppC1EvajbLds7DJSdRwt23XQcdDfjHOY1cPvp2EjHNQnymIfvrzORCgEkRZBX3NFlOR/CdQ8u+ILF1jP7CleqttkciAkGZBK5STgVNqFqvaMJaqoq/yPxPHe+Sqvf0VwjIO4TKIwnD6cmbbGrtz+yC9UGI7KBzUl6rQjKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QImK2UTz; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3b78d337dd9so1701977f8f.3;
        Wed, 30 Jul 2025 08:20:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753888843; x=1754493643; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Kci03Gb7LVvbq3eEOdY/a+e9RESG12PudUU6mEsPhsY=;
        b=QImK2UTzs99K9rosAUMdz7lytv5ymcoStKsqj/P+sxlaNts3O4U2haW9gDKafXo4n1
         3Cr3RBqTW53xdZ1sksR2xmsUdOSW7GF6iivrkuvU58PQNI2FCLVyQW33ZWy4zkkhETCv
         CZ4dFnkiiWHsLh8vSuY+woR7lIurpTdXypWPpXdyUsdXJX8Dl8ALdDUBhm3VlJR6wDbh
         ueWK3GWgWI63MlWqbAld4rcF5RzohvnDihqA0SO9MPG1YA5im8Zj/CyQ3dRRI+ZJLTLv
         zZJR4P0T5M0WfyTaGK3UaXeooCZUpugp18wHwFhTG5wE8CudXS8ff9pevx+jhiyOGmTx
         dGsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753888843; x=1754493643;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kci03Gb7LVvbq3eEOdY/a+e9RESG12PudUU6mEsPhsY=;
        b=NwWDxLllNw491STs5QowiSbnPVd33gLi84cZd+bD1ind8T11bkPwp0Hft2bdPtAC3d
         VVrkRWSt+TBQmyCs+zKnUu7a8Oh92lkXuR4L7FB4unzc0T2/VR65T4nkopuPBAbq0Dqi
         A+/3XnlcDL3VSjOPOD3yoInH4ssNf7VxKOr4KDmjwsANVsoIA1TFO6cSVkOA6DAeOOLY
         IMxv7j9c1R2N4JxHWn0M8zvqNRsl48a6LAKxwTySA9nA1gwlrPYGUTzDqWFOqazPUALh
         Wsp143g0YaXqJqh2Iob0vnPthtzEp1XHQZpMIQ+1xtusNGBdxL/rYHDd6OyEK9V/kqL5
         gNhQ==
X-Forwarded-Encrypted: i=1; AJvYcCV4mwEnt1xJV392XKkP3BiffNXny/iE4ZABnp8xR9SKiL3JX577UFn0oGHonFNG0+7cbihBdarZu9e7TEs=@vger.kernel.org, AJvYcCWh3AikiwZ1eKUgD188UzK5uRE6vaMM2HFJz+473raL69+LilztMeHr2VV/BuF76bccpJal3D1j@vger.kernel.org
X-Gm-Message-State: AOJu0Yxg1dsEHJVzDDPFT7iw1y2oJgUOuPdLLi3sMcpQ0L7Fog7VxYvf
	v+H0sekPtfFlmIHC3K580i8G7daZ0dsHRDLVxnoKXrU1TksvsCdTiMxo
X-Gm-Gg: ASbGncsDF7A9xHhOz1mkmMf53uBDoms6pA7R+t2xZQe0tZlYnoVocbO/XGaEAo1U5yT
	wiQUmghkn5HIHN+VrykPUMJqHXak5hpYAMqp2u0I7fjh4HrwlntEr5+X7Aig4FQOnRLmlVkT309
	gt4f2TtKE95G5tG/c25VXrRKzWE/6++8Y6uMo00CEMpQuJnkxG7fs4z1E1+kwu7CgmhAgsTvmjO
	DJ9uIoBtK4Bix6F0ud4kRrLyV5SI7z15Q+J8dnnoQiw8nVRWibSpu/PbJOlHsmbAcycDZAYfjE/
	qzrqeBz2cbBUPWPvy8A38By3P/ua6BCpKfqJOyllAxre433AQLRPE/J7n4lwhlRnPEaUAhLMSZ2
	LzJlRM/yUhb+rTSmMUY85b6kEKYO/Xvv3M5krrs0hTSZ3Z/kMI0uQUJP4z2qOF88cmg==
X-Google-Smtp-Source: AGHT+IFujs7Q9eRhqfnwDZ+MvXL7x9DocH05EbUQKXWIE5rTbWniIFMJNpGqQkP0jEAo4UKtbeJXqg==
X-Received: by 2002:a05:6000:381:b0:3a4:dc93:1e87 with SMTP id ffacd0b85a97d-3b794fc19d1mr3452329f8f.1.1753888843257;
        Wed, 30 Jul 2025 08:20:43 -0700 (PDT)
Received: from eldamar.lan (c-82-192-244-13.customer.ggaweb.ch. [82.192.244.13])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-458953cfe56sm32874015e9.20.2025.07.30.08.20.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jul 2025 08:20:42 -0700 (PDT)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Received: by eldamar.lan (Postfix, from userid 1000)
	id 76D18BE2DE0; Wed, 30 Jul 2025 17:20:41 +0200 (CEST)
Date: Wed, 30 Jul 2025 17:20:41 +0200
From: Salvatore Bonaccorso <carnil@debian.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jari Ruusu <jariruusu@protonmail.com>, Yi Yang <yiyang13@huawei.com>,
	GONG Ruiqi <gongruiqi1@huawei.com>, Helge Deller <deller@gmx.de>,
	Sasha Levin <sashal@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Text mode VGA-console scrolling is broken in upstream & stable
 trees
Message-ID: <aIo4SSJXIrJEanmP@eldamar.lan>
References: <C4_ogGo3eSdgo3wcbkdIXQDoGk2CShDfiQEjnwmgLUvd1cVp5kKguDC4M7KlWO4Tg9Ny3joveq7vH9K_zpBGvIA8-UkU2ogSE1T9Y6782js=@protonmail.com>
 <2025073054-stipend-duller-9622@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2025073054-stipend-duller-9622@gregkh>

Hi,

On Wed, Jul 30, 2025 at 04:26:44PM +0200, Greg Kroah-Hartman wrote:
> On Wed, Jul 30, 2025 at 02:06:27PM +0000, Jari Ruusu wrote:
> > The patch that broke text mode VGA-console scrolling is this one:
> > "vgacon: Add check for vc_origin address range in vgacon_scroll()"
> > commit 864f9963ec6b4b76d104d595ba28110b87158003 upstream.
> > 
> > How to preproduce:
> > (1) boot a kernel that is configured to use text mode VGA-console
> > (2) type commands:  ls -l /usr/bin | less -S
> > (3) scroll up/down with cursor-down/up keys
> > 
> > Above mentioned patch seems to have landed in upstream and all
> > kernel.org stable trees with zero testing. Even minimal testing
> > would have shown that it breaks text mode VGA-console scrolling.
> > 
> > Greg, Sasha, Linus,
> > Please consider reverting that buggy patch from all affected trees.
> 
> Please work to fix it in Linus's tree first and then we will be glad to
> backport the needed fix.

FWIW, and maybe just an interesting side node: if it ever get
considered to revert the commit, this will re-introduce/re-open
CVE-2025-38213.

Cf. https://lore.kernel.org/linux-cve-announce/2025070422-CVE-2025-38213-c3e3@gregkh/T/#u

Regards,
Salvatore

