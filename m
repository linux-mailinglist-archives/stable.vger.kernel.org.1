Return-Path: <stable+bounces-43133-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 514E28BD391
	for <lists+stable@lfdr.de>; Mon,  6 May 2024 19:04:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E739B1F21D41
	for <lists+stable@lfdr.de>; Mon,  6 May 2024 17:04:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9502615746D;
	Mon,  6 May 2024 17:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FnMt/DXd"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C453156F54
	for <stable@vger.kernel.org>; Mon,  6 May 2024 17:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715015050; cv=none; b=AIFCHpFX0TtEGXUxLATkKw5eVvfzVVoldF7V2Jg8r1oCClAp2XtV42auaCafCtki7mMAGPjDN1RlW4FanMQhso9IjiD8kfoTMGySrfU9Hfm3jSY69Ivk661C65WoX3kFsk4AuSaoF1LjoOBl8uAejgifdNTSP+5hwf6hSehZbyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715015050; c=relaxed/simple;
	bh=3ERVaimfa0RavbCwXjVsALhYs2yHgjOMIPHx21z0Fkk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HzEN2V/+0f9iS16b5Qb3SsFWm76EltwylWU15bmD02c0iFZdtgM3g0hVHbwbZot0kA9ziwP7WQbJitQHZExP6HxJWDDpZ1UeOw01u10Kd5k1EaI81ZMkGN1ABGKRo5XBBgSG57wd/xFl16CZ3FHObao5/J5eyJlZP4f4jn7MVLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=FnMt/DXd; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6f460e05101so1237271b3a.1
        for <stable@vger.kernel.org>; Mon, 06 May 2024 10:04:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715015048; x=1715619848; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nh5u78QHidWuEv3zxf5mnHEaLauXii2ZAlcYYCjkWo8=;
        b=FnMt/DXdhjIG36+E+qsCRWpYuSxiaksnl0gHPWNtnZNLJsF9SiY+ANP9zonlJxosNG
         jW9t/x98ejoZBy0zi4xW2ZAFD7leuFNxxUoHxOK2xNnluU9muFHrI/f/BWwm4F5scD+8
         cBioL9A5GQ2tcTRlZzCrcMQLq6zR9KpG0/LnA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715015048; x=1715619848;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nh5u78QHidWuEv3zxf5mnHEaLauXii2ZAlcYYCjkWo8=;
        b=ZsSF/oeZtjz5otR/q8YijgD3McTM1Z5WoGcs8P/hGW+xeIbO72w+i0UE2xpZuKgngZ
         uIbT7ndtZQgic6lrLIi/s42MPEUqVfAnsn9KtOogh5leIzUTzKDKbYfDIvF+ZkNyHnDO
         k8+69uOfUM+pjv+1dyO5ouP7xVeVYZh+zf/rs4RA7/2Dm1uaX1hcoiTWjX1lv5Iig2Pk
         byjD3MisuT/qP//1jU/rAc6E1MSkXenYKpUK9iuZpmHScH2XbnSm71ua7kR7589+KExf
         lhbOTohn8mHjtEVk1EvM5SaU9B2C/NLQsrkpnk9gdhTfJ2QYbkmp36Odjoqq8vmjFdm4
         ayGA==
X-Forwarded-Encrypted: i=1; AJvYcCVbk9aX59HP7Wu08AgKGcoCZ8/sZQaVMi1eN3FGAmeiTxO3rXlaBbrDVwjOkYZhGSkCPMcgONn1SxEyuCSRNvktRW+Q5qxx
X-Gm-Message-State: AOJu0Yw8nyusYdA8nm3f+axKMoojHDCzmPITpSE5iVvNsApKjTCuH+LP
	ZWAXsoIRaB1FOuVUh0rIew0JFE6bvPv6AofTp0Rbx0R0Ytp1P4KfkNdGK77mpQ==
X-Google-Smtp-Source: AGHT+IHZ19g7EIIbe17uKRyz+Ga9/paMlTkZAc++bhrs3f5TO8DSdkyHhZh5qpgkkcFIrfHkocR+fw==
X-Received: by 2002:a05:6a20:4393:b0:1ad:7e68:570c with SMTP id i19-20020a056a20439300b001ad7e68570cmr312144pzl.4.1715015048352;
        Mon, 06 May 2024 10:04:08 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id e14-20020a62ee0e000000b006e724ccdc3esm7945562pfi.55.2024.05.06.10.04.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 May 2024 10:04:07 -0700 (PDT)
Date: Mon, 6 May 2024 10:04:06 -0700
From: Kees Cook <keescook@chromium.org>
To: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc: Christian Brauner <brauner@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Mark Brown <broonie@kernel.org>, Sasha Levin <sashal@kernel.org>,
	Sean Christopherson <seanjc@google.com>,
	Shengyu Li <shengyu.li.evgeny@gmail.com>,
	Shuah Khan <shuah@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Brendan Higgins <brendanhiggins@google.com>,
	David Gow <davidgow@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	=?iso-8859-1?Q?G=FCnther?= Noack <gnoack@google.com>,
	Jon Hunter <jonathanh@nvidia.com>, Ron Economos <re@w6rz.net>,
	Ronald Warsow <rwarsow@gmx.de>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	Will Drewry <wad@chromium.org>,
	kernel test robot <oliver.sang@intel.com>, kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	netdev@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v6 00/10] Fix Kselftest's vfork() side effects
Message-ID: <202405061002.01D399877A@keescook>
References: <20240506165518.474504-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240506165518.474504-1-mic@digikod.net>

On Mon, May 06, 2024 at 06:55:08PM +0200, Mickaël Salaün wrote:
> Shuah, I think this should be in -next really soon to make sure
> everything works fine for the v6.9 release, which is not currently the
> case.  I cannot test against all kselftests though.  I would prefer to
> let you handle this, but I guess you're not able to do so and I'll push
> it on my branch without reply from you.  Even if I push it on my branch,
> please push it on yours too as soon as you see this and I'll remove it
> from mine.

Yes, please. Getting this into v6.9 is preferred, but at least into the
coming v6.10 merge window is important. :)

-Kees

-- 
Kees Cook

