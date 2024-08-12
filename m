Return-Path: <stable+bounces-67381-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A599C94F784
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 21:36:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47CD31F231E6
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 19:36:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F6952599;
	Mon, 12 Aug 2024 19:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qtqkyu7T"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A76B17A5B5
	for <stable@vger.kernel.org>; Mon, 12 Aug 2024 19:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723491390; cv=none; b=R4zOQwkQIrNHTUa6cuRzDyMkP0gC8MTUG1oO51r/CvZbdGz846gGd8pDbE+Yvz4o9G06DDBx3mCSlXSHl4B/WSxcIRaFOZSmXOxjDuFQ4bLMA0bd2fQLg2yKYT2rmsU7rcyjvv7TT/DKPmbLWkK9wRHDAHo8fEJfKfed0hG4D0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723491390; c=relaxed/simple;
	bh=eWcy7xE8ttgz+wR9ps6hBW/kivFgprsNTb9KV8BPMVE=;
	h=MIME-Version:In-Reply-To:Message-ID:Date:Subject:From:To:Cc:
	 Content-Type; b=VFRsYcqMtBrh/dhpQeVg/88SCKl0PDEkrXtw4YUp65UtrBvnzFrex2HI28u62Zc5EGJOlIa13VJz/OqllOXwm0uv/wXz1jhDSJyEW3ZxR6ELgRi6f43AhJyI2e2TPacUBqxh8t6OUsnVotc19lYifOcZTY4ENp58YaHk0KDoA5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=cros-rc-feedback.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qtqkyu7T; arc=none smtp.client-ip=209.85.210.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cros-rc-feedback.bounces.google.com
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-70d1a9bad5dso5117838b3a.0
        for <stable@vger.kernel.org>; Mon, 12 Aug 2024 12:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723491388; x=1724096188; darn=vger.kernel.org;
        h=cc:to:from:subject:date:message-id:in-reply-to:mime-version:from:to
         :cc:subject:date:message-id:reply-to;
        bh=eWcy7xE8ttgz+wR9ps6hBW/kivFgprsNTb9KV8BPMVE=;
        b=qtqkyu7Tc4i3DGo4B62QZgPoaiSfAE32aqThHzNuTtfER/FVdIIGCj0QFWoIH+z9wU
         bOu3WEUsK/wYFlRoaOc9HeQKnaW+kGSvxqfKxSjlcOdMJsBnsSuXMjRk2Ud2+n4s4Rst
         scPxwWT2zjKnwbowk6NmIRT9/wo3njCbTxpEm40dBLuIwjy2i7RlUYoQpmp8VT2dWPGn
         Vxalm/w8AuHlB1zIdOyoafXmObNnr0HcBP7hkh2IA4fX/Gd++ssD/3IyuOAqZ57PSokK
         0GK1kxHE0c97wgudxZ5aqj6IYMc2CLrzvDKkyVaNeG2Vr8J8TCEfGYdZ1pNQOYWNPX5K
         hKYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723491388; x=1724096188;
        h=cc:to:from:subject:date:message-id:in-reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eWcy7xE8ttgz+wR9ps6hBW/kivFgprsNTb9KV8BPMVE=;
        b=aHongt6cRoKK2iaBZmpeWuwFFacONrfg1mFZUt/67dqi2ewM+gruzTnHdmvuSdds04
         eUZKWovMVksvmWNJWB64buNSFYReual0v/Gj1NIPO2iDmI2VbSZVVKWCG9XOwgeF+Zm5
         EPWZYfQg7WxJ63HyoF9LUGFqaYoDUtQlZoXfFMsG6rCqN6gl65Vr/gKLTdKQAsu8nQaa
         1n3dmnJVMqNoR/Xlwsq6UsytMM2QNkL3pfhVV6S6xzrj5ClI7+CqscNtcEto0crgJPV1
         urv/UoUPO7SP4XvfcsAumtyeANhet7inFn61YoDyHYEtxfwlVeP1OLq5j2uKDfuD9QXE
         xbiQ==
X-Gm-Message-State: AOJu0Yxw004pSLx55NtSzs97Am1AM+5MSpJw1E2Q1BjvyGzabCLwHqvq
	XNkRosHCSgb3TjR+jShXsB3ms/2qHbFeCfuzi4i+FIEPGCli+9vk4/WrUXxDE4/G+OFyrRxp+UJ
	Q6AT2PElThkpM+UYgtxCa1fg+76M3VopyVRZKsFyMNFmuqDy5URdfEWCuHSH78qD5tNXWVDdenC
	TLbFl9OUFbIXkTwwVt8gVzgDiNpmUE
X-Google-Smtp-Source: AGHT+IEVOtkezygPLG/8V800714fG83za699IBYKlnGcaD5g/17+ZBdQeSicqhpSx53FJIgBJTwRDy8V8CezUKsU3p3ZKqE1jt1HGYgKhkhwqiB+JA==
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6a00:b18:b0:70e:98e2:fdae with SMTP id
 d2e1a72fcca58-71254f60803mr8875b3a.0.1723491388040; Mon, 12 Aug 2024 12:36:28
 -0700 (PDT)
In-Reply-To: <20240812160125.139701076@linuxfoundation.org>
Message-ID: <000000000000f57a13061f819b1b@google.com>
Date: Mon, 12 Aug 2024 19:36:28 +0000
Subject: Re: [PATCH 6.1 000/150] 6.1.105-rc1 review
From: ChromeOS Kernel Stable Merge <mdb.chromeos-kernel-auto-merge+noreply@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, chromeos-kernel-stable-merge@google.com, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, 
	broonie@kernel.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes

Hello,

This rc kernel passed ChromeOS CQ tests:
https://chromium-review.googlesource.com/c/chromiumos/third_party/kernel/+/5782314/1?tab=checks

Thanks,

Tested-by: ChromeOS CQ Test <chromeos-kernel-stable-merge@google.com>

