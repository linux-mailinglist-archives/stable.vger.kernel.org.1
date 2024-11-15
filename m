Return-Path: <stable+bounces-93544-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1711C9CDF96
	for <lists+stable@lfdr.de>; Fri, 15 Nov 2024 14:07:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0336283D69
	for <lists+stable@lfdr.de>; Fri, 15 Nov 2024 13:07:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 286DD1BD9CD;
	Fri, 15 Nov 2024 13:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OeR7N49F"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5592F1B6CF9
	for <stable@vger.kernel.org>; Fri, 15 Nov 2024 13:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731676060; cv=none; b=qhvm7aUrRdavdn8PGuKfJUaDBnqIiVpYsRYJFy1HO9FkyAzu//iPwhF9bcrWRW0W6JlUhiUlhaekkqjlD3DRdh+iO+kHr35mg6R3A8HBGqpuVxa1QBdy77kHIwuPiI7DNQe8MJjPE3BClkMdeJKmtkNZ0wWfTcEOVHqHnw3sdWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731676060; c=relaxed/simple;
	bh=dEY4bMcfjN2jDnrT5hwQmo7mPSnSCSRep4/jww4nqDk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FGhThStthGS0E0iT36Q19QaDGHPkZY8GdyAGaWPEhqKv/9oE91yEDCoDfD4YBxwDSBkiKXnL+NfQ3bU/8smHDDaq8ld1L3vS063GEcuF9DBKLnKi3flOBmj8HNqcDvXXQfmnEiW2VgPLcfnFwXTw+97dAeVyELm34uSgN+SgbR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OeR7N49F; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-432d9bb168cso11171165e9.1
        for <stable@vger.kernel.org>; Fri, 15 Nov 2024 05:07:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731676058; x=1732280858; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZiAfY0lvd8epGAfG9vNvMumF0065glHRGxW52XCXbkY=;
        b=OeR7N49FEZcEypjrT2B5wTO9I0SN3XO19ljXjY1GToDAbiwQtlcD3w86yI+MpGbKex
         G5D7T8Y9KKY9bXAEDXwYdQCCN9Oq9mchRtSPp5bdUkaNKpADhVkRIX7+nSXQJYicmUCq
         YZSUK0CB+cQRz0V1k/mdDKqHgrkpEU5Ospsp70McnQruzWO12wovDQ5hH5ofJ8lVGlwY
         HGNH9IiDTspUNqHrYVjogxryBXOGHgLVCsUEpsQuHeidNTd9kgapVSj4dH+YSfwjwsJr
         bcl/pfyC7Ox3HJUHiJm9fpmDWc+DfrCQkluNlmUMSC6FqRLEZkYHPV4A7oEnSkVI5tNH
         M/8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731676058; x=1732280858;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZiAfY0lvd8epGAfG9vNvMumF0065glHRGxW52XCXbkY=;
        b=bzrH/E6DZA7ZpTuChOZijW/y2r+Uy85bOuQIRNSdpTem0Tws3mKDBkh2SHo7EytLf9
         66tUPBaIfDXs4wjETFwHhTN1raPv/b24KBmnLV70AbOGORIgY+YeUnx7lLRglvUZDiGA
         Noin2Q1TXmxj5cKapPYrnJe7piAAGsjaaLhcTTP9rHCr9NU2ZEl1wl22KEy9kZt6bWwb
         iIE8LsPPP9e6tL5n8YgmXoQuRMLXUExJ3AqAhuVPuW+80iSBoxzHzTnhoJX1Y6v0WBar
         VV2r8hbaSYKotokZXeGjgfU4zfHJeWoniW8KlTESbU+IVIR9DPTf3J7sLseD0xiq03CM
         QNQg==
X-Forwarded-Encrypted: i=1; AJvYcCVz4egln+c6E41FzHyoSubx1mx7jvyoEqoVQc+ajW/fQ7o1oQ03kszvHN8PgSKBORYo1B2xX/I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxmBrsSW39xNJZyhYEVgm/eA2pgBn1JLsd8+p62WsIO6tayDFQ
	UiqbLB0Hb7oKo/T1XvLl5LUYYnG4Jd7/2ssW3yn1PxxJExORccjzPr1ixJ+zLGs=
X-Google-Smtp-Source: AGHT+IFLypSUXKMXZQokl7jiW1yVHZc6DmXrur69Qui95mFW1vmj5vxRjJRCT3fWilyBKdsvE8W84w==
X-Received: by 2002:a05:600c:1c95:b0:431:416e:2603 with SMTP id 5b1f17b1804b1-432d9726874mr70098235e9.3.1731676057729;
        Fri, 15 Nov 2024 05:07:37 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432dab7878esm54044435e9.14.2024.11.15.05.07.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 05:07:37 -0800 (PST)
Date: Fri, 15 Nov 2024 16:07:33 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: Greg KH <gregkh@linuxfoundation.org>, Shuah Khan <shuah@kernel.org>,
	Linux Kernel Functional Testing <lkft@linaro.org>,
	Kernel Selftests <linux-kselftest@vger.kernel.org>,
	Netdev <netdev@vger.kernel.org>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Willem de Bruijn <willemb@google.com>,
	Naresh Kamboju <naresh.kamboju@linaro.org>,
	Ido Schimmel <idosch@nvidia.com>, stable@vger.kernel.org
Subject: Re: LKFT CI: improving Networking selftests results when validating
 stable kernels
Message-ID: <226bc28f-d720-4bf9-90c9-ebdd4e711079@stanley.mountain>
References: <ff870428-6375-4125-83bd-fc960b3c109b@kernel.org>
 <1bda012e-817a-45be-82e2-03ac78c58034@stanley.mountain>
 <c4ed1f88-e43b-4b12-bffc-faf27879042c@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c4ed1f88-e43b-4b12-bffc-faf27879042c@kernel.org>

On Fri, Nov 15, 2024 at 01:43:14PM +0100, Matthieu Baerts wrote:
> Regarding the other questions from my previous email -- skipped tests
> (e.g. I think Netfilter tests are no longer validated), KVM,
> notifications -- do you know who at Linaro could eventually look at them?
> 

The skip tests were because they lead to hangs.  We're going to look at those
again to see if they're still an issue.  And we're also going to try enable the
other tests you mentioned.

regards,
dan carpenter


