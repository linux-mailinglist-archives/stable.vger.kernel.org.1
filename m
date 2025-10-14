Return-Path: <stable+bounces-185594-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B7D1BD8059
	for <lists+stable@lfdr.de>; Tue, 14 Oct 2025 09:55:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F81B3AE386
	for <lists+stable@lfdr.de>; Tue, 14 Oct 2025 07:55:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5944730F53F;
	Tue, 14 Oct 2025 07:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Isd29rg8"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3A5930F539
	for <stable@vger.kernel.org>; Tue, 14 Oct 2025 07:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760428492; cv=none; b=n2h0/cUaDQWzdmqtqD64rcPhoS4FsaLK/F9WTsSaZfzqER3n9srys4Cw3xHuhNB3VRZABkUTbDsAEIeTXFa44vxSfb2JP/fmO+Agc76MlRVDkNhP44pI039+yQgr9OFl8FMKFBQlxYpsimsdPQBCKKWoenrEUKWa09CuJBiCGHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760428492; c=relaxed/simple;
	bh=IPU5z0Jlg1yO/rxNLxtj9z4MrewbKL/7K6aEPJLzYTU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fz7ayNpighTvb2b5E5XvKuO8CAVnk6B9erL7FPMVpfmuftTEZYncQiCqowGK4bK+f/qr9elHBy8HNXHPSSMC4tMSS4sVAKtmIPyPSIO2NsXp30s8OT0R8vV0dxiwvpC7Igqdyvnjgv2kTGTTeO/PLq/rPGlIXxJwpwV/XKtPdBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Isd29rg8; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-27c369f898fso71201855ad.3
        for <stable@vger.kernel.org>; Tue, 14 Oct 2025 00:54:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1760428490; x=1761033290; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ksS8LYkJl9QHQKVTv7IPKK1Z2Yj/b9KllkjM/XlVz50=;
        b=Isd29rg8TF50sXI2d1MSHVL0JSOynekWdCVGxF63mL1iu1EDdlH69fqTWeU41EstMC
         3tPrdCVcQdCpbR8hEdO2oqJwDzAShJg/mm84FjDKb5qS15uj1kY3eqYxaMfE1B5HyDfD
         3FiOYwTTTPtC6UNz8ZDj+ubxGRD7UC9W5H3Ns=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760428490; x=1761033290;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ksS8LYkJl9QHQKVTv7IPKK1Z2Yj/b9KllkjM/XlVz50=;
        b=EO42rIko1tqcLXtz20EdbR+4WLD2YbG7niOjTEheU53bcwbmFLe/3BTTIM+cMSpsj5
         cLcyrVclqLPLQMJqec8zsYwyNRXfJ6zM5bNGWyP46AZBi3PlQiLJon9trqFWs0k8mAam
         HTRUuE2Ww7QPYBnfa7WbaPWERlz2PGQCRHpVqL3d9UVRalhJdB4mz4MhJ45aiRNMyhdZ
         qiO1ENsGjFw2JCTH/l+Leh4xjwcERRdyMcGYwCy3NiBgmNRjFRH3ZqMqfho3dUE/dDLy
         ilOG/BOOgF1HurVhKH1AvykA7qLrsXekDb/zQ9hqx+y9wiHVFmrlVJEskUoxaiyWS9cQ
         WMiA==
X-Forwarded-Encrypted: i=1; AJvYcCXQzN3a81c1I8Rsqwy8lnV4COXanjakREGDcpBxUqkeEIRd5GnVMeyw6voM57yzuL7REfr5kqs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIhqgmu642wRrO0wAFWopmUkXX4e34VBmMFXTaJsHRnK70IM5x
	LJ4uAe66pn7ZqMekaaEoCBzYsLnZwXtJUdWu9oOUxmiVd2g25yfPJ86cs3BOoJZqjg==
X-Gm-Gg: ASbGnctDGF7I2FA1xM1lMvjj7tCfJqeSLFZAXF733bpRerulr2c1sNT995BRDEJhXkd
	sMcpq4niFk1C8Ea/b85INrhlTxZsssOjuAxrkhOtGj1dqQwFJWjuorQk4A3PvWdiD0h+VHCKEL5
	L1XkVzjg2Gpcen+st8KCVwXVqe0DBznH2IUHM6NQrZNpvLTjVsKlTpqPsGTcMWSmOvLeOiHD+95
	hWFgv9VFs6gRN5NT2mZuSoAb6wLsmYD7qPrbxfLRYPA3fQpQ+ZGP0sn0NW88d1W2tiOhoU91bva
	5unzwbl9yxu67mohg9Z2JQQXQxw9jWCs9M7nTyyCkSzv2/fNLsdfeLlPhM/xNj0v1A1dhy5CNqd
	/oF3pGWoBv//BLBCplUOTcE3BuGprU5nTsYdezyEDu+ilOBe45JXJ56Q2SeMDh5RX
X-Google-Smtp-Source: AGHT+IFvIVVGJj7wXuIXy69FB6dwSBFxEn9vka5rzvUJ8F3THFqGapMxGBUUn0K/GJKYj64Jy6pczQ==
X-Received: by 2002:a17:903:1a90:b0:269:d978:7ec0 with SMTP id d9443c01a7336-290272c19bdmr295819825ad.28.1760428490089;
        Tue, 14 Oct 2025 00:54:50 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:f7c9:39b0:1a9:7d97])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034f89972sm154634655ad.112.2025.10.14.00.54.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 00:54:49 -0700 (PDT)
Date: Tue, 14 Oct 2025 16:54:45 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, 
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Artem Bityutskiy <artem.bityutskiy@linux.intel.com>, 
	Christian Loehle <christian.loehle@arm.com>, Sasha Levin <sashal@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Tomasz Figa <tfiga@chromium.org>, stable@vger.kernel.org
Subject: Re: stable: commit "cpuidle: menu: Avoid discarding useful
 information" causes regressions
Message-ID: <zfmoe4i3tpz3w4wrduhyxtyxtsdvgydtff3a235owqpzuzjug7@ulxspaydpvgi>
References: <36iykr223vmcfsoysexug6s274nq2oimcu55ybn6ww4il3g3cv@cohflgdbpnq7>
 <2025101451-unlinked-strongly-2fb3@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2025101451-unlinked-strongly-2fb3@gregkh>

On (25/10/14 09:47), Greg Kroah-Hartman wrote:
> On Tue, Oct 14, 2025 at 04:43:43PM +0900, Sergey Senozhatsky wrote:
> > Hello,
> > 
> > We are observing performance regressions (cpu usage, power
> > consumption, dropped frames in video playback test, etc.)
> > after updating to recent stable kernels.  We tracked it down
> > to commit 3cd2aa93674e in linux-6.1.y and commit 3cd2aa93674
> > in linux-6.6.y ("cpuidle: menu: Avoid discarding useful information",
> > upstream commit 85975daeaa4).
> > 
> > Upstream fixup fa3fa55de0d ("cpuidle: governors: menu: Avoid using
> > invalid recent intervals data") doesn't address the problems we are
> > observing.  Revert seems to be bringing performance metrics back to
> > pre-regression levels.
> > 
> 
> For some reason that commit was not added to the 6.1 releases, sorry
> about that.  Can you submit a working/tested backport so we can queue it
> up after the next round of releases in a few days?

Sorry for the confusion, the commit in question presents both in
stable 6.1 and in 6.6 and appears to be causing regressions on our
tests.  I copy-pasted wrong commit id for 6.1: it should be a9edb700846
for 6.1 (and 3cd2aa93674 for 6.6).

