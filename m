Return-Path: <stable+bounces-69244-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CDE9953AE8
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 21:36:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2261A1F25B15
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 19:36:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F39CE74059;
	Thu, 15 Aug 2024 19:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Lg9jjJzw"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 791F77580A
	for <stable@vger.kernel.org>; Thu, 15 Aug 2024 19:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723750560; cv=none; b=N2ugBM1XLs9619kuUOkGrc1P9nDRuU0xfu2RCXbSgqEKP3ZTapp2/7vqdewzhi3Su7H0hRf9jl768k3VL9fxDjAMsxeMV1LOigPVjt8XpAe3fNI2l6amR5V8tX1Cda0CtQNKClUYYh/Q4ROrOgHxLpZb4X+J0kqW0LC59BWd7WI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723750560; c=relaxed/simple;
	bh=EKsx3kPPXwzdhd+E8N+BmlJsiSEoAZoQpsBQKM9fd7U=;
	h=MIME-Version:In-Reply-To:Message-ID:Date:Subject:From:To:Cc:
	 Content-Type; b=YGPuEHjr65uciElI4GNVLa6NbB67XUHz7iIIwAkCTrFOBbm58NoNI0GcnAE7q2PKRK86h5sf0FVWjHuYBllZTKSFZcXQwkuC54FGQyY1t1iS0x76uMsdUSyPjUMApTGeI927SKEdl6Yje00/O0gvlcmcKs5ZGze/crSys7iMggo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=cros-rc-feedback.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Lg9jjJzw; arc=none smtp.client-ip=209.85.214.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cros-rc-feedback.bounces.google.com
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-1fc5e1ab396so12371595ad.2
        for <stable@vger.kernel.org>; Thu, 15 Aug 2024 12:35:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723750559; x=1724355359; darn=vger.kernel.org;
        h=cc:to:from:subject:date:message-id:in-reply-to:mime-version:from:to
         :cc:subject:date:message-id:reply-to;
        bh=EKsx3kPPXwzdhd+E8N+BmlJsiSEoAZoQpsBQKM9fd7U=;
        b=Lg9jjJzwqX+TW2SCMaNDZtbMLDSbaNwNU61t02FXq2qS90umUXcR5mlcDWXPml2HZr
         wRKjGbCXbog6slcJ4hegV5M1kNaD/58QbPruVcrDjYvPF3Rad1yxntkJrhdWa0UjTsPf
         l9QAj+ywEyoLexTZa+DzS5q4iWmSrI3wAMMsVsg7Pn+YBL0zsuaBAVU3vwxGYpK1MJQL
         rHPXsgzeVye6bdeA65zT9D+L3UvtUTQPz7Fs7KlL6qQIyRCZxRwDY5fKljIznBet1Vz8
         TCPB5D1QlgvYNBUyofuEqL0CQCCJbQF3OghJ2HAW5N3iW1DhJZWZmPssRt8XBanqq3C1
         n+EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723750559; x=1724355359;
        h=cc:to:from:subject:date:message-id:in-reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EKsx3kPPXwzdhd+E8N+BmlJsiSEoAZoQpsBQKM9fd7U=;
        b=DTDfbtosP/PeXE09AXjAtPF2dX1tSQYGKgiTnfIZbTbkB+2bWRSPf/rhh3LzlxLNdF
         3Bb/5SAvHHqojLhfGx17uxA8dnL8Q2cpS6nlr0w9Oqt2pAqE8Tocqg/Q71sKP/JH5Bdj
         K1SLED6/aGTesCMKcLgCZ/eTNk1U6zgqSugOchtsoLCIURwM78ltlpJSVuRy8b8UOCnw
         GNE34NwFhw/hFGiGHHOluEh67WyCkqwsgOB7gDcgflJSgvOUjij5GNLBu0r7NCnq7AdH
         FCNUaxM1JHTl5TBCL2FutaRlKdWBZIdmWlz9CHsEsNIxlXbTK/DHKqtM1XvGoiaxAIIe
         2OAA==
X-Gm-Message-State: AOJu0YxePpCpsBZhvKBEeTVRc/XmbnFwsNbrKN47pcotP0FOthTuOcMf
	zBwwRixnrtbTef1YE6GaJ6sJH8rJ6jWvX/lGxwHs3/wU5xXz/Tok2R3Eon32wQMhSxlSFAVbd/+
	H9mqomvRCuIEh44bJCAoKdbQ59ZSS2WXGnLf6qfD1y/EKy+fwYyGwjSTCnsg0rNrEF2F9CSonAq
	BcRWHe86cV++tWGrvBnOzUOW9SJohq
X-Google-Smtp-Source: AGHT+IFJ8ECkDnS3k6jLL8zhyaYh5sBo9rZan0khf2zhxhubUiLbYf5E8Mdgyd3AX7JdK2Z99hTuFPWJxxCSsc1t0GftFzbA4HHOdCdosaLvHrR7Qg==
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a17:903:11d1:b0:1f7:b45:f2d4 with SMTP id
 d9443c01a7336-20203e5e808mr642225ad.4.1723750558750; Thu, 15 Aug 2024
 12:35:58 -0700 (PDT)
In-Reply-To: <20240815131838.311442229@linuxfoundation.org>
Message-ID: <000000000000bd15a9061fbdf348@google.com>
Date: Thu, 15 Aug 2024 19:35:58 +0000
Subject: Re: [PATCH 6.6 00/67] 6.6.47-rc1 review
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
https://chromium-review.googlesource.com/c/chromiumos/third_party/kernel/+/5791538/1?tab=checks

Thanks,

Tested-by: ChromeOS CQ Test <chromeos-kernel-stable-merge@google.com>

