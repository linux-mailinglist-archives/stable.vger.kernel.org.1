Return-Path: <stable+bounces-204171-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DF28CE88AC
	for <lists+stable@lfdr.de>; Tue, 30 Dec 2025 03:23:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2E4EB30142E0
	for <lists+stable@lfdr.de>; Tue, 30 Dec 2025 02:22:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80F892DF14B;
	Tue, 30 Dec 2025 02:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LfF6QnfA"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB0FF2DA759
	for <stable@vger.kernel.org>; Tue, 30 Dec 2025 02:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767061373; cv=none; b=jbnJGVoXJD/qUGREfm6n4R8nXvkIKEkM7INIpk0FraIxG9VDQQ6yDWnPHEdjevJz5F1sJfzzGG0UCdnJORwWTbUJUp6InqXi646XPEyQX4NBHxp/ShZmnA2pTKF8qD+3GHrE3k6cJC9cUjdirAecO1dhmjU9Zw5+NqrAAMyHvY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767061373; c=relaxed/simple;
	bh=1TPUuZRqeK9VE9JKVNfQ7gOUgA9r0Suwe3bu4LqCFiI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MNfYDVsL7w4UHf/Lumyc7fhG7DsBn7B6geZ+3Ou66wSR+LnlLxzrKK4Kc2aMJgY+mqjYQzYRGdfuwULZ36RtMyXLhZRLVjVdWOWt4ikFBm1zWKRO++PFkJxii6ZQu8Y8JuAl9JXT9bF87BUTlq5PamlJwpeMDMqoxAojc9y0uOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ynaffit.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LfF6QnfA; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ynaffit.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b609c0f6522so16680835a12.3
        for <stable@vger.kernel.org>; Mon, 29 Dec 2025 18:22:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767061371; x=1767666171; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:user-agent:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dKB/MFi2JJNcHgRM1ZVpW/6k+K0ih/df/zx7AJgRywM=;
        b=LfF6QnfAtFOE6YuRQ1jp6GnfvXM9tXazkLDbPuVQNajsh5V0dZULNbelpNYEY6sKRj
         NNrcsTwfXj+F5FrlZoenzFLGYQ2pthDw0PK/scJmCSP5ALLf5x19iDjrBJS3jGtVZSWQ
         dYbTjoZwJdfHQcm2dGY3b1oDJFUtoW0qsrCM1Pdi+Jeamua1iPqHXxdNMTHiVcQtAiht
         171jYcmCDZTMbAHm8tEFMbQpU/QZptUn5lYLI7shYpx65SSGErzhAD6dP3A+gApdD7QS
         dwyIB6+Oi93533zbMocnDB8ygJBLVutE8Xg61YlhoC06ulfJfLcw6YLpeJwMLQYwKpla
         4aRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767061371; x=1767666171;
        h=cc:to:from:subject:message-id:user-agent:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dKB/MFi2JJNcHgRM1ZVpW/6k+K0ih/df/zx7AJgRywM=;
        b=jTu7ed2K5EvEr3vFPW3612RqpPlvRlMd6hrnZEV+dhH9dsfIGMkY9Wng86cUnmSZuJ
         K4TRTOcniYcVyWEOD1ECNSY6K9yrLQGNjT7EnT4yrey9Na/MbPfr+NuAWNIwLoQKrxYp
         ZoC8by8MFez4ifsVnrnMBHxXJ0aDbiS323OPxkocHaKpTP/AjkBVJCfQU0f0LW+c0e/9
         aNMZaujZIhJzegwrs685WR8s3hOEW9oqYwwUMKIAH4SVWfduWpboLStTfRrO7Lw9rZJb
         yE8LJcnV391r4K/u/p2uccOar1p4Tk6nLHt6XUk+uGA1skjsw/j9/nGYDRoYAtWinrBB
         lsKg==
X-Forwarded-Encrypted: i=1; AJvYcCX9jkFPpJk05dtmOR2Knbv/aA7GetxM+UwhEoOcuRH0BQRwkQV9oURr5A/NiPSwq173T6TW3bY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAVJlKqIG1wb1+TOCw+jL0sf7tjwObRkDN5I0YCkbOJGz9RQ/q
	RT/ggO2Kn8/KhAONgiDEUCZh23ILzv1HzpYAl0JS+CpmScwYEQSiVFKmHgz59z5+RF33GYfin0E
	dqqMwaQA2Bg==
X-Google-Smtp-Source: AGHT+IELINBMPFmRxNHDW7vHWpdCROA3hncsEtneXbUH1OrOJmjFny3vsrRGMAMBfntFNvUrUIrN7tzzSSsU
X-Received: from dlbsn2.prod.google.com ([2002:a05:7022:b902:b0:11f:300a:a308])
 (user=ynaffit job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:3718:b0:119:e569:f62e
 with SMTP id a92af1059eb24-121722ecbe0mr22094565c88.39.1767061371145; Mon, 29
 Dec 2025 18:22:51 -0800 (PST)
Date: Mon, 29 Dec 2025 18:22:49 -0800
In-Reply-To: <20251205-stable-disable-unit-ptr-warn-v2-1-cec53a8f736b@google.com>
 (Justin Stitt's message of "Fri, 05 Dec 2025 14:51:41 -0800")
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251205-stable-disable-unit-ptr-warn-v2-1-cec53a8f736b@google.com>
User-Agent: mu4e 1.12.12; emacs 30.1
Message-ID: <dbx8ikdoso7a.fsf@ynaffit-andsys.c.googlers.com>
Subject: Re: [PATCH 6.1.y RESEND v2] KVM: arm64: sys_regs: disable
 -Wuninitialized-const-pointer warning
From: Tiffany Yang <ynaffit@google.com>
To: Justin Stitt <justinstitt@google.com>
Cc: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	Alexandru Elisei <alexandru.elisei@arm.com>, Joey Gouly <joey.gouly@arm.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Zenghui Yu <yuzenghui@huawei.com>, Will Deacon <will@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Christopher Covington <cov@codeaurora.org>, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes

Justin Stitt <justinstitt@google.com> writes:

> A new warning in Clang 22 [1] complains that @clidr passed to
> get_clidr_el1() is an uninitialized const pointer. get_clidr_el1()
> doesn't really care since it casts away the const-ness anyways -- it is
> a false positive.

<snip>

Reviewed-by: Tiffany Yang <ynaffit@google.com>

-- 
Tiffany Y. Yang

