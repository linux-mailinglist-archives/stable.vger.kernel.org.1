Return-Path: <stable+bounces-121545-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 80737A57B89
	for <lists+stable@lfdr.de>; Sat,  8 Mar 2025 16:24:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2AB216D035
	for <lists+stable@lfdr.de>; Sat,  8 Mar 2025 15:24:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA35A19DF9A;
	Sat,  8 Mar 2025 15:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G4MWjN76"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CBD21AA1E0;
	Sat,  8 Mar 2025 15:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741447477; cv=none; b=lgFpzzRESYuC1iu4otD4GNeB9F2iCIG7VHX20ZKbIE2FFLovvG40KlsmUdAc59x6KBk4XDkyk4nn2zL2BgbVOIkouNoPpP2kE6ZFKr6kjaRt5Ygvf8GONYr+J18Rm1OodbJbbx8hSp8mA/MMRbNuFTdhnZHZGb8mDOtqZ1t/3Ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741447477; c=relaxed/simple;
	bh=+ksPnQkYFLq9BBBIQN5ECaD4K+JAR/8p7m68GDKx5EU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oTTvvQs9yfPJYWsTRtBp0ACFCsVrSWOYSUj/1cm1acJI7Oy74qtWAPFlGXQ6F1B1gJwseLinsy07Hk9Jtmzg+c/xDyBT8RgNf30uAyFP4+M22urefIxLBYt6pZDPuqQFZOACpgoezPworOakFuFMHOZmdd7qM1rofngn6VLT9Qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G4MWjN76; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-22398e09e39so51778045ad.3;
        Sat, 08 Mar 2025 07:24:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741447475; x=1742052275; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AnyqBsmlqD/tBRZnGec00fMxsrhMgvwfzn2a+aeT/JI=;
        b=G4MWjN76gr2cKmDAcXiNNzcG5OnUTownEUhudXg7yW8F/R52aE2v4au6LtaB06mf94
         Q34z3P6Q5gtN94/OLwadc2dxPFfyiLnCJbdcDvlzXv1zw6Vlvjh1u3A8RooFtSRunKV3
         yiGGgu6lleDLSpXpAoIqM6eMGNIX1U54dtuWEPaa35atWXm6yNGEdkWBTbhZICluaVnB
         NTnZNbiC5VSUYfiBxwcPAZ0FPfppCkWUxxavNmjSQiUiHBnD1mykIOFiZ+fBq/aN+dgu
         WjUkSSLyrPSAEHWziKYl8xfbX0irQthnyhmTr6PdmCEVsXqxNLxzVHmDvscHP2xeaEmu
         LP+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741447475; x=1742052275;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AnyqBsmlqD/tBRZnGec00fMxsrhMgvwfzn2a+aeT/JI=;
        b=PlICgiEGXyMBQ/+k58L6JyESYptwAkQyLMQybSSWKJmNIx0E9+QbUo4cm4gVm2l57+
         uvd28tHAfNhC3Mneahz3I8pWiNtBzarXJL2GRSfxa/0QilRrrsvBd9LZqknS7JFDX/Zd
         91n3dYcdSq0e9ff2TmoTW1KpU4X8sbAhKQDyb3N0ycXCrjTG2e79aNL8Y64CQAclokgq
         h/i4rKOB3uEaHeSqe7LnlKF+0QWPaDm/9XdwMblqUtKzl3Wn8CakFTqp6AgknvBcUYpx
         aAHRoqHRwsHt9YAC+95/v638pKsyjGFelPqRtPvDnboHfaHMw5JdYS8X/ETh6bKQ4ZzF
         9dyA==
X-Forwarded-Encrypted: i=1; AJvYcCWC7TxSDpPCaxYcf1yL0pRQGlCI4OrOMKrFI7a9qW9LstzZuZM98KmVpCQm+rl+Ahk4VtgFC9Y419s7fOs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3pu9DNfZDcZjbROz4X2cLwS6xequX7JMBq4xD9P/mOJ8h9liC
	ZKvPRFhZ0NalxE56cWmTN7Egw7ZT9YEHDqbLjnuMmV3re/g3XZ4J
X-Gm-Gg: ASbGncuxDazJgPXunWPtU2BLgyOUjICkUrBRjDHV8IrEs6iDHx+GpUcVJ7jfWBZzmkc
	JT3+pktmNnIA3FS+BCzIImfFZyv2oTr97XseAYt1rPuPgJ2A3aUcLsgCp2iSrY1agmBOuGudrPN
	qHJgWm27N1RwHPvURSxDwMUOkHSlaGcje5zGES4szunsULK1Cr8FKAgZJp9Zm6kPxkYoeMeOLDS
	X3WMgcIP1G3A0qXLpAheEbz+f30fKuTHPWudA6M6cIKkFGfI39TWJI3qXmVrjZCY5SEauQWKup6
	ivdl2cn9PJ8ffHlr+dHBVLiMRTkSxKVvhGIu2Y2tz8jPwFJCqvOhmz2WPg==
X-Google-Smtp-Source: AGHT+IHHaus2ApAqxcrdFmQ+yT7IfhTtas4VZTKJvwI8GomHS8+8SKSibt2Tu+bsbFhxp0QEXMB/LA==
X-Received: by 2002:a17:902:e745:b0:223:fabd:4f99 with SMTP id d9443c01a7336-22428886adcmr132213215ad.5.1741447475574;
        Sat, 08 Mar 2025 07:24:35 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-224109ddcd9sm47970025ad.10.2025.03.08.07.24.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Mar 2025 07:24:35 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Sat, 8 Mar 2025 07:24:34 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
	lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
	f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
	hargar@microsoft.com, broonie@kernel.org
Subject: Re: [PATCH 6.6 000/147] 6.6.81-rc2 review
Message-ID: <ac26ddda-4268-4f59-bb33-5f68ea00a9cb@roeck-us.net>
References: <20250306151412.957725234@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250306151412.957725234@linuxfoundation.org>

On Thu, Mar 06, 2025 at 04:20:44PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.81 release.
> There are 147 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 08 Mar 2025 15:13:38 +0000.
> Anything received after that time might be too late.
> 

Building i386:defconfig ... failed
--------------
Error log:
arch/x86/kernel/cpu/microcode/core.c: In function 'find_microcode_in_initrd':
arch/x86/kernel/cpu/microcode/core.c:198:25: error: 'initrd_start_early' undeclared

$ git grep initrd_start_early
arch/x86/kernel/cpu/microcode/core.c:           start = initrd_start_early;

Caused by 4a148d0054f3f ("x86/microcode/32: Move early loading after paging enable").

Looks like 4c585af7180c1 ("x86/boot/32: Temporarily map initrd for microcode loading")
may be a prerequisite, though I did not check details.

Guenter

