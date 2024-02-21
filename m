Return-Path: <stable+bounces-21780-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D6FBF85D0E6
	for <lists+stable@lfdr.de>; Wed, 21 Feb 2024 08:09:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 77C64B21EA7
	for <lists+stable@lfdr.de>; Wed, 21 Feb 2024 07:09:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B15D3A8CF;
	Wed, 21 Feb 2024 07:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vkQfgsQD"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC1293B78D
	for <stable@vger.kernel.org>; Wed, 21 Feb 2024 07:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708499288; cv=none; b=tZP3VZ3kk63jOyc23D8PAXjomMYlNt2o6d7yPAUqciDpPz1oLfjKGuhfof8gVAXKz0IKB6Qbs97DAUV67YaAuSMXAI8gqdPvyooc/c7QYvmXda2KS3J3qu0ZDpl7AuohzxJ638mmDMGie/3CczxntoBUGOzjl+tMIO35uyZXLAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708499288; c=relaxed/simple;
	bh=L6zbD+r4iAQVkolpUdqaC5kdIDlOZs92K4PNPYeqx8Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vs186qEZ5D9z5WOqCJ8murJvrCmpseUmGQFQAU6mLhxTJ08x+oEprI30tAGkZfEZdWmNjA9s9g+9PWLcWxzUfNliEwPBV8WxRmH5UzB/rkAcXYyFulNmAzQaAs+jNOLTtXD1GBnI/Zi2PGpCGHhfzF66HDlwIoVaKi3OstzdTFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vkQfgsQD; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-512bd533be0so354823e87.0
        for <stable@vger.kernel.org>; Tue, 20 Feb 2024 23:08:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708499285; x=1709104085; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=L6zbD+r4iAQVkolpUdqaC5kdIDlOZs92K4PNPYeqx8Y=;
        b=vkQfgsQDHrbxG0DiaoWAnw8FsfnbUdtZib000uWHg0wIlYT+HrgSStHuiYTFUcJX+e
         WxuIkK2ISklm7coEPKp5c4WxJ1ItMjJcaNB8ViHy0TMQQou9LBHAhK8lNrXNP1UFDnmj
         0PC0tcY6HTPeoetxu516Pf+mF4jHWA3jzFvgNzv3dSdg4L83oGnRoGj6PvPKG0wgqado
         oXMgHUNtdrh61hAjN49nc9F36tiScy25yxpJYLLhwKySzAuU9+zoHH24k2aRZOjzq/n/
         jgDtVQNmz3Cy8icJcJZdMLlt0wqpN9qNPWLCE0UozdxYIJUcxYOwIkkojnyKbpr0Qq0+
         zRsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708499285; x=1709104085;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L6zbD+r4iAQVkolpUdqaC5kdIDlOZs92K4PNPYeqx8Y=;
        b=xP7T9fWvWilu16qtH2thBoQK7EUPRieWQIxWMJ1hHaao5l/aA4A8GcAoOM1KlKJh/V
         1+uP15LFkgL+t6CfR4v27UiFt4rwa9TXhUkiJDFtlv9Aowr3vbbPEJcptOeAnjfJoMe5
         xcHQ1ewBNl2hQNKMvU2hOcYtmrTqhtMu9454CVhq4fhgqIybinWf6GEJhuUk0Fyy9sTq
         XAMU3DwOm1+S5tejycKVonuDN25oxgOPp1gy5gLtea7ebl4mf0S5U4gqcKIWhqoJ0KEU
         mvysdaArFSGE338mSPrNVM4iTVmTOP5kHSdwJO3dg+rV5z9cTe8UW6RM40xDCO/SfjAt
         Hhjw==
X-Forwarded-Encrypted: i=1; AJvYcCV1IvuDOaVcfy6+b3W412lobgVeOditRSrvc+HF01pjKv4XkAWe9kljAnrmopUtcP4GiMngqzx6kwjgSvbvgeFfZsdryhoW
X-Gm-Message-State: AOJu0Yyi4hMcuDB8ybAU4A6nAMcuk30SWU3o3f0c2Ufe31Xy5BQ181ve
	4ZJxD+DyArppYvcFQw2jWFVFBQBR4gQg1eBozrWka9IQ9hAbPAXnBuqOOSaGQaSRsG/jE4AKmKp
	6DYolKDEje13wHUsOves3hE5n2Oo/YDnwMQJA6lGCMX8Yc3jixw==
X-Google-Smtp-Source: AGHT+IHa365tMHI74PcJwpoL4by21xl2KdQYoT7uJGyPBKgsElto/rB7Qh2SvL3fkLhg7dgdD64D4s6+6hqom1eKg68=
X-Received: by 2002:a05:6512:2107:b0:512:d6ca:71ae with SMTP id
 q7-20020a056512210700b00512d6ca71aemr61918lfr.31.1708499284887; Tue, 20 Feb
 2024 23:08:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240220191114.3272126-1-dhavale@google.com> <6c2d5345-98bc-49b1-adc7-bcc349a0a6bb@linux.alibaba.com>
In-Reply-To: <6c2d5345-98bc-49b1-adc7-bcc349a0a6bb@linux.alibaba.com>
From: Sandeep Dhavale <dhavale@google.com>
Date: Tue, 20 Feb 2024 23:07:52 -0800
Message-ID: <CAB=BE-Se6nO_VTncA9CH7k65xRPtyxo=xSH__i_OhV8++LfEYQ@mail.gmail.com>
Subject: Re: [PATCH v1] erofs: fix refcount on the metabuf used for inode lookup
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>, Yue Hu <huyue2@coolpad.com>, 
	Jeffle Xu <jefflexu@linux.alibaba.com>, quic_wenjieli@quicinc.com, 
	stable@vger.kernel.org, kernel-team@android.com, linux-erofs@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

>
> If it looks good to you, could you resend a formal patch? Thanks!
>
Hi Gao,
This looks better and more readable. I will send a v2.

Thanks,
Sandeep.

> Thanks,
> Gao Xiang

