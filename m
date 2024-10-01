Return-Path: <stable+bounces-78542-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CB2C98C093
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 16:45:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B74AE283A09
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 14:45:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0E4A1C6F55;
	Tue,  1 Oct 2024 14:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="WLYlVQ2t"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 796E8BA3F;
	Tue,  1 Oct 2024 14:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727793927; cv=none; b=IOzLoEIHgFfqrdbOdOmOL2f2lAEMXV7m74pMvDTyOFWTJfTfexsKBcycbdrFC5CqCyqSmc9W4mkiXLnlB0Q8vzZxpsOpi2C5iZ9VQL+1k9pUdGk6pvP4IfCA7dzc6GA3tFpHTjQan4EcaW0ZPma2nb29vCCCCAvfh/KhCAg1ISs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727793927; c=relaxed/simple;
	bh=VxGPKoeL5kHB08Xyvlo/tLsrNYB8gDU7DLMMnKk8nlM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tzi9xYxZQD3xspLRVPOwDdp8Q/6a3tqeTsAP1vvMVJpe3XIg/uo6r8hDIypTPv92sji8OcjpLBUjJhxjijdTWfGCuic6IDVpvC2czZR3um9RW8xMoHREhVdNKHjU+iF5M1Tbi2n6T7sSxX+MuLJLhUww75qIWwmVeU2M5PS7zkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=WLYlVQ2t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B1ABC4CEC6;
	Tue,  1 Oct 2024 14:45:26 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="WLYlVQ2t"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1727793924;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7aROAmXf20HpZKKF2RVwY2zxpDo4Bc+RIMTuu27lCFQ=;
	b=WLYlVQ2tXImmB7tP/hQBD8PV+sT38jSOIoEbRq+OAFA3rQt34UwM5DWBw3ZbMXzfG4Zkz6
	dJD384XIlN2rt4RcfQ4ZprxNi/dDXEBLjaeCrfjJEkYbxYSAfJI9P+JXjY02Gk2B2HQ3O/
	C00rl44wm0k3rw7VVVF0YJx0H+9hgSE=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 74d45c97 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 1 Oct 2024 14:45:22 +0000 (UTC)
Date: Tue, 1 Oct 2024 16:45:22 +0200
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: stable@vger.kernel.org, Sasha Levin <sashal@kernel.org>,
	stable-commits@vger.kernel.org, Shuah Khan <shuah@kernel.org>
Subject: Re: Patch "selftests: vDSO: skip getrandom test if architecture is
 unsupported" has been added to the 6.11-stable tree
Message-ID: <ZvwLAib3296hIwI_@zx2c4.com>
References: <20240930231443.2560728-1-sashal@kernel.org>
 <CAHmME9rFjE7nt4j5ZWwh=CrpPmtuZ_UdS5O4bQOgH8cVwEjr0Q@mail.gmail.com>
 <433ff0ca-92d1-475e-ad8b-d4416601d4ba@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <433ff0ca-92d1-475e-ad8b-d4416601d4ba@linuxfoundation.org>

On Tue, Oct 01, 2024 at 08:43:05AM -0600, Shuah Khan wrote:
> On 9/30/24 21:56, Jason A. Donenfeld wrote:
> > This is not stable material and I didn't mark it as such. Do not backport.
> 
> The way selftest work is they just skip if a feature isn't supported.
> As such this test should run gracefully on stable releases.
> 
> I would say backport unless and skip if the feature isn't supported.

Nonsense. 6.11 never returns ENOSYS from vDSO. This doesn't make sense.

