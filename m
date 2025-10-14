Return-Path: <stable+bounces-185634-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 89E58BD8EF4
	for <lists+stable@lfdr.de>; Tue, 14 Oct 2025 13:09:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F7794256C5
	for <lists+stable@lfdr.de>; Tue, 14 Oct 2025 11:09:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B89D7308F34;
	Tue, 14 Oct 2025 11:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="H/02+A+J"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9B1A308F0D
	for <stable@vger.kernel.org>; Tue, 14 Oct 2025 11:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760440127; cv=none; b=Rp7g6P2sevec5cIXU04w3Ftj01nUIy9VPPzOCwH9BbyGQYy6bi0sf7KnCKETU+TwUzdthuQ/VshK5ri30SXu9bhIerfDn9LkfJmArtaFHRXf74icny7jdL/KlofZ3PsB1rNLuThXNGLK+4VXX5O9Pj1dTq8+QQ4aDOwHARZOm+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760440127; c=relaxed/simple;
	bh=P+5GauTt6GT2A5ICewQhAYJjsy2WOR/Fp4RhjgMbv+U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hpRu9k+TNIfMtNyO3RnMy6AoommwySscGC9LoJOF1fjCPuIIXGPQjtvBeSH4aoe6WnD9JtogtubrV7dMyolmY8Huw6rHU9TStv41C8Jk6tYrRBUSm5qXJ60KaMBXA7YwMBD0yNlRw6mqxMC6nvRPQkgjvJqBp2hqdccz+Z3g/4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=H/02+A+J; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3381f041d7fso6655031a91.0
        for <stable@vger.kernel.org>; Tue, 14 Oct 2025 04:08:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1760440125; x=1761044925; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kIl7+t2byU2rLxGt9Fvez6I/u2Ic/lM71HIRdn+BxNU=;
        b=H/02+A+Jy1afx8MazniDdIkPUcfD3mozlAvQd3k00bvcAnKT9uWCcdBtRjpainlonI
         nyAN92GepjCoe20RpotEEe6h3gac/V13RTXHleFFcU3pMqUJsAbm9vygupmOdlWwS2FE
         JcdBE7DQ0/jjuceG3b6B7zWIaUIecCrDSG6gI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760440125; x=1761044925;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kIl7+t2byU2rLxGt9Fvez6I/u2Ic/lM71HIRdn+BxNU=;
        b=buN/p1xf9qv6wOqARlD8zqI57PN+fEMopc9mS9878yvOoxmd7ezneYvEvwAX04J/EP
         F1wy4P+r5eeEMxPLKMj5MsVGsiOLkVfnRZMjIhP13qQwAIJfGaSAm2vDCMd2mNj6jJYg
         diLNOwudUezhp/dCDapeWCaqnPZhEPKJza6kdYgmFp1gS4/ng1Cg6BVyiKBSQ+lrHmph
         ZIQ0Hwf5tfRJYQ7RN3+P0J0Jb8yW3JFs/oSgLo7Znm9Pmugx4Hmx6yPjklzb6DztXMX3
         l6ZpJUVySXX0HNDSsA03zkB9TFa7aEpPRb/LZNP1letxtgdVJaEblaYNdTXmy/6TQGrx
         Wupw==
X-Forwarded-Encrypted: i=1; AJvYcCXjTkPHDVMDlh5r/3PJttWMOUj4IpjKKp6Wip6x1bdyhfSV8bUxFwCVf4im0aGO7rQ33jOTJpo=@vger.kernel.org
X-Gm-Message-State: AOJu0YygOYXWdgaQanCaMSYbJveofpwLUOTxoeHOLvEt6u5NI6DpHRa0
	pVDsu4z/HDglztk4IdHjsYm7kfu2pKlYAf+jUgio8WgNh36fXDTQAygtqewgTh9hWg==
X-Gm-Gg: ASbGncsCw4Pqgy5kVJb51KoLVmNWFKs6SDc7n3f18FOaloj0nBFmCvOW0tPyBPYZcs4
	WJppIfcra2A1t3WKR7yojECqaKFfO+P9v/XAVvjejqaE8BBvR1pTh4lYXLdJQprRh5cyrsvOXNF
	ugmeQ0sp077I+WHn3darGB126O1SEFS0YgiHbhL4OhHScyiXsydYWaxAJzmN4YkfdP9ff7qgema
	C0C72s4zt2ZXkNA3qwgogc4kbThydWr2h6lV7f5nSj7WrxOHucZ2zixOq1RBUQqSH6jPT1MGqlt
	s2quwts8oT3qn9O7JXa9v3jhtuzbg6C2R7O0mf9ZT0UnKI9WkSipjjr3b9mvo3BdyOCG/U68P4B
	BdnagTgrEtjjkkkz3pgeHGCL2KTWE1nvOZa0y+T70P8X0EqQwyPmu7A==
X-Google-Smtp-Source: AGHT+IHZp5MLtuj8aEbRYmVAG30fR1mkEeXUfh1F7/djMcG98/l7AMsS3SPYvh8TdHqkm61PdymDQA==
X-Received: by 2002:a17:90b:4acf:b0:32e:6111:40ab with SMTP id 98e67ed59e1d1-339eda4744dmr37545449a91.3.1760440124929;
        Tue, 14 Oct 2025 04:08:44 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:f7c9:39b0:1a9:7d97])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33b61a1d386sm15642214a91.5.2025.10.14.04.08.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 04:08:44 -0700 (PDT)
Date: Tue, 14 Oct 2025 20:08:39 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, 
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Artem Bityutskiy <artem.bityutskiy@linux.intel.com>, 
	Christian Loehle <christian.loehle@arm.com>, Sasha Levin <sashal@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Tomasz Figa <tfiga@chromium.org>, stable@vger.kernel.org
Subject: Re: stable: commit "cpuidle: menu: Avoid discarding useful
 information" causes regressions
Message-ID: <gl4gcdqg4d7kqvnbmo3vuymdzcxjoi3qubgaiuu4pzlashxzjr@z7fqi3lek3e7>
References: <36iykr223vmcfsoysexug6s274nq2oimcu55ybn6ww4il3g3cv@cohflgdbpnq7>
 <2025101451-unlinked-strongly-2fb3@gregkh>
 <zfmoe4i3tpz3w4wrduhyxtyxtsdvgydtff3a235owqpzuzjug7@ulxspaydpvgi>
 <2025101421-citrus-barley-9061@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2025101421-citrus-barley-9061@gregkh>

On (25/10/14 10:02), Greg Kroah-Hartman wrote:
> The point is still the same, commit fa3fa55de0d6 ("cpuidle: governors:
> menu: Avoid using invalid recent intervals data"), is not backported to
> 6.1.y, it is however in the following released kernels:
> 	5.10.241 5.15.190 6.6.103 6.12.43 6.15.11 6.16.2 6.17
> so something got lost in our trees and it needs to be backported.

I can send a backport for 6.1, unless someone else wants to do it
(or is already on it).

