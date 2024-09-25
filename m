Return-Path: <stable+bounces-77350-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B3C6C985C7E
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 14:48:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F2981B27AB6
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 12:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 666471A3BC7;
	Wed, 25 Sep 2024 11:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="UmcrhU17"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21C621A3BB6;
	Wed, 25 Sep 2024 11:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727265521; cv=none; b=iMC2aClFxf5p+l85BDHEk9MSyqtJO+jcTJpIdgkZR9hh4jd5Z1dXCHDeXrZOHF/YemSuzPcjiYngBnkmWPjfvQv09WT9BciyCg2OBKdZX373U80UbdwbD/t2z9wZK59SwjXqpcK/F4X7tJuJy1LH4Gg/MtlCQva9QANhUj/Fif0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727265521; c=relaxed/simple;
	bh=MqTIcPv2wreLQE3sRuPmqeOCVAS2j8QpUl+LEEm4tcg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XPwBf8TCnvoHxjGgsu1q0mLMWWWcOGtVjDouF22GIJcqFkJ/LRMcViy8BXKgSIuYS3ggp80r+J7hV57rH6ZP9Kdjyg4KCVxO5oy6uy47b952dvD4zSCDLsXQ/07oRIlF5Rm6CzRbQcMGVmB5bY2E/Ltrpf0+ouOXKcFW4sxj/C8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=UmcrhU17; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B25DAC4CECE;
	Wed, 25 Sep 2024 11:58:40 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="UmcrhU17"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1727265519;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MqTIcPv2wreLQE3sRuPmqeOCVAS2j8QpUl+LEEm4tcg=;
	b=UmcrhU17rPHE9Ut1C4iXvbL+fSHolQUuaY2Cwvm2yV3E0JDMHmRjroY6as9bPAnXlHgLDd
	UD8JIUhZN74c0PQoYizKWbJq+viVDN0yxR3FMCd6fNlTuDHuZNgTjmpi5+TMmKs1g3iglA
	ZJFtUrDLHwhxwzsk2bFAqbGSZeFhRio=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 0b952be1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 25 Sep 2024 11:58:39 +0000 (UTC)
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-5e174925b7bso2579155eaf.0;
        Wed, 25 Sep 2024 04:58:39 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXonm31Y+zeTRHQiKd9vRqY4FxqsgG137NWlOWrDy5m2pvtiuQhW0nPUBfseSR9EjAy0alWDFA=@vger.kernel.org
X-Gm-Message-State: AOJu0YylMlqOXGkbnaUi7slDt11m+sHLtLDTknvFuS3zcpSJSRtw1zOO
	fB18FqC+XOHPSl/F+Vq8NcDiNBCtgTtyOrNOYP36+PtI5owgbTeovessolZPJWfyOo1KFHRtuEm
	B59+f3Unui9D46UD/KYT5+dXWW1Q=
X-Google-Smtp-Source: AGHT+IG2aKJ/WujNjjU6njEx76gXf8gAEbsVLChrBS9uQBYUoIBZH178QGvU1zeRs+BoAbEO/YOFMz6uqr+QApMqzaw=
X-Received: by 2002:a05:6870:72cd:b0:277:e1e8:a085 with SMTP id
 586e51a60fabf-286e1440a8bmr1580077fac.23.1727265518554; Wed, 25 Sep 2024
 04:58:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240925113641.1297102-1-sashal@kernel.org> <20240925113641.1297102-230-sashal@kernel.org>
In-Reply-To: <20240925113641.1297102-230-sashal@kernel.org>
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
Date: Wed, 25 Sep 2024 13:58:29 +0200
X-Gmail-Original-Message-ID: <CAHmME9pnXA3rj85TEVt+CYiio=SX41XNw_4MUyMJremQGVnAJQ@mail.gmail.com>
Message-ID: <CAHmME9pnXA3rj85TEVt+CYiio=SX41XNw_4MUyMJremQGVnAJQ@mail.gmail.com>
Subject: Re: [PATCH AUTOSEL 6.11 230/244] random: vDSO: avoid call to out of
 line memset()
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, Ard Biesheuvel <ardb@kernel.org>, tytso@mit.edu, 
	luto@kernel.org, tglx@linutronix.de, vincenzo.frascino@arm.com
Content-Type: text/plain; charset="UTF-8"

This is not stable material and I didn't mark it as such. Do not backport.

