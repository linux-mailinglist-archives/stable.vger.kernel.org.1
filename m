Return-Path: <stable+bounces-118299-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B33EA3C415
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 16:48:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2A7337A7652
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 15:43:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 033AC1FBEB0;
	Wed, 19 Feb 2025 15:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QoSGvJO8"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCABF1F9421
	for <stable@vger.kernel.org>; Wed, 19 Feb 2025 15:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739979840; cv=none; b=kB81u2dQSkaoKU5u2WRp7133J6+m/3KqDGhCRW8XEuvh5nT7GNJVDVY7FgVgAeE3UM4gMODEMdG91vbQaEZg0Gsz8XFrbP6u+mR+UlGLCD0qmxH+vmRS8wQ7sKprM1R0HlfWEp1oHzl89O/p+XGbEb18aaLBfe0ZKJqs+I3Qqck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739979840; c=relaxed/simple;
	bh=YNmYlTClH6f57hMX0irzBAGNNqToOG6S23UwEJ2SIOI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fmb/KGyEsxB0TT2a3tDM3cXCyomjCarv4dA9dzl0FuHY1afKCLUJLje6GIMDYlY5kz4YT5W7OwX4Y0bOny9mwLfoXstMVYCTLIB9jwLmXYPyBDgNbHyDRQ4LIcuHU6NA3k6rZB5NpCJ7ugK39y1H+calh9Jrjk4LPjTGUGYfkwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QoSGvJO8; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-ab744d5e567so190603366b.1
        for <stable@vger.kernel.org>; Wed, 19 Feb 2025 07:43:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739979837; x=1740584637; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ztTcSqiM5jchwSh7zNDJUJXvpA9bZcVb5dRh9uYh8nc=;
        b=QoSGvJO83q8cWOJJ8KKjrnClpNxrJ0kdQZzcO3aB88o1NUKX5dQSIXXXqUJfs3YR/5
         6DVZQbJOqSLfag/Gm15Q6deG1TVw2E+Wj//os0FCD8Chr9/v1PH+UuEkEeTxrOutOl+2
         tzcms0G5JyMZ4dtMhx+aY4kO+ZNkMtJYder+9p2yRGK6oY7JuQX7FXEfufSApqVPYqBs
         CWMNn7ytav+OFZJv61mZNB24RzH97CIT6apKcohOToJj1YTkoNVAgGo8GNasIhWKqDbW
         AuYQQsh19to4MC1wDMKWyni3kDwygPJl5adZztkb6KTwBA9tUu7JMJ8JBDuqMgxeu7V/
         s0tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739979837; x=1740584637;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ztTcSqiM5jchwSh7zNDJUJXvpA9bZcVb5dRh9uYh8nc=;
        b=KqXjhpEV3Wuhut0/E6wuJEe3I4cM8Di+KI3jGbfNUl9o1q75VMVU4+hSzIJyS/g2hW
         SMLw2R8uZJ/0U34G9pty0aPXHEcLu+IT00LAFnwfyITXeoRh1UPs7CSrYtIa+9A6bIXd
         DWj3EpQU9FLWEFaoe7xRpzdTeBuonWn5Y5c9bkNSJy7/kwJfoOGCc2es2iiFP+fMJ3+4
         NhOakidPBoiJF2mOJp0YxCv2O6rhWRAr/sIn1qp6EBtALo2iSV3ZKMf8pxuejUnWNdQl
         cAcnRkSwaIoi8qmfOBXt9LPRrGuqND1X84QbPiLpO0tlO5PzPkqpOwAcMeWj4R5RZ2js
         D1JA==
X-Forwarded-Encrypted: i=1; AJvYcCVA3J7J6jR0FTySyc/juhzIN8FM27ZZTSZNZoE7BImWCQ6m5VUYeyO+RJAWRB8L/sr1BJgdb0E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuCz/7R72Wg+CkujV4V5rRvOuwBxD6dX2h/fKgr0R4O0lQwJS9
	vSROPlLLK/kPbO28NKeYnY2f73FFFKstiu6sQZxvPdEmJI9ka7TaDLEghUXNRro=
X-Gm-Gg: ASbGncu07TUFoyXiEjJvt+w9aKFsh1qCZjWGdjZcmY0BWnuPanjupm21fE8CNyDAqne
	bpC/sL7L1DeqoKn6in6ZkhDxtxTmiMueYekvAjmEjBnQCmX6EGswoAleBecjFKvo77XwBo1BGRl
	DLVmuB2HkWd7VgELT7ECtygKQ0hT82/FG9QcbWgdGvHrgTrvdMtZFbRsMg9AxDuZkhN9izCUI1S
	y0dOe3D+VVPlkvp7degfkZlj5LrO86/hFGegCco8rD5feU3YpD0/CmNMmaqwHaK5AqJqlNtinbb
	KAAvAjKBEuSVsP3I7MV5
X-Google-Smtp-Source: AGHT+IEuAZ/31Yw+onuB6dX7P6MBrwUPKEqWPMc6/GLwGLwgBLIZWvMyIkebqkSIVitXPRtyLX0fJg==
X-Received: by 2002:a17:907:d307:b0:abb:aa8f:c9cd with SMTP id a640c23a62f3a-abbcc7f2ab3mr419789166b.28.1739979836924;
        Wed, 19 Feb 2025 07:43:56 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-abbaa56026fsm491684066b.113.2025.02.19.07.43.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 07:43:56 -0800 (PST)
Date: Wed, 19 Feb 2025 18:43:52 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Yang Shi <yang@os.amperecomputing.com>
Cc: Naresh Kamboju <naresh.kamboju@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
	Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
	linux-fsdevel@vger.kernel.org, linux-mm <linux-mm@kvack.org>,
	Anders Roxell <anders.roxell@linaro.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Herbert Xu <herbert@gondor.apana.org.au>, willy@infradead.org,
	Pankaj Raghav <p.raghav@samsung.com>,
	Yang Shi <yang@os.amperecomputing.com>,
	David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH 6.6 000/389] 6.6.76-rc2 review
Message-ID: <b44dc8f6-7abf-4168-b96d-54f1562008e6@stanley.mountain>
References: <20250206155234.095034647@linuxfoundation.org>
 <CA+G9fYvKzV=jo9AmKH2tJeLr0W8xyjxuVO-P+ZEBdou6C=mKUw@mail.gmail.com>
 <CA+G9fYtqBxt+JwSLCcVBchh94GVRhbo9rTP26ceJ=sf4MDo61Q@mail.gmail.com>
 <Z7Xj-zIe-Sa1syG7@arm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z7Xj-zIe-Sa1syG7@arm.com>

Hi Catalin and Yang Shi,

What's happening is that we backport the latest kselftests and run
them on the old kernels.  This is a supported thing so kselftests
are supposed to be able to handle that.

So we need to modify the testing/selftests/arm64/mte/check_hugetlb_options.c
to check if the feature is present and disable the test for older
kernels.

This is not an issue with the stable kernel it's an issue with the
new selftest.

regards,
dan carpenter


