Return-Path: <stable+bounces-194520-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C788AC4F738
	for <lists+stable@lfdr.de>; Tue, 11 Nov 2025 19:33:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 702983B8E01
	for <lists+stable@lfdr.de>; Tue, 11 Nov 2025 18:33:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8279B280A56;
	Tue, 11 Nov 2025 18:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rajagiritech-edu-in.20230601.gappssmtp.com header.i=@rajagiritech-edu-in.20230601.gappssmtp.com header.b="wBgetCe0"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3B5027F010
	for <stable@vger.kernel.org>; Tue, 11 Nov 2025 18:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762886033; cv=none; b=FiCfhpHDEGLEykBd0vMiuVHRPpPY8cjA6Dww+IGeAn/FTa2PlI9qdZfggrzH/otyN0M3+qFYaLNHUJFEE4t2fXy7a0p75p3xMLlhWzHgMBB05e0JKcsG69WUoPK+xGyjD4O+iuEu9apYJ5sGYmWBLou1HomJREh4vcsbOZul2L0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762886033; c=relaxed/simple;
	bh=pBVOS/SepbH40xJUmfX0ZVqtQ0pPFCREKy8C0yb+qsE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ew1v6FwFRahrMmE7rBaLTYHcBeq78aufsosqftFGEN8C4gUUICz+nfe0Ie5jQMxhSoOk8dIi+K5ULL32M/qts23B2gx4w7C7VRQZMRHFQZlXrpLRLpljvCbr3Ft/Vdbb0cxj9ymLBKbRuRL5bCTwxnt+dt7zElBPg/zsqi68lRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rajagiritech.edu.in; spf=none smtp.mailfrom=rajagiritech.edu.in; dkim=pass (2048-bit key) header.d=rajagiritech-edu-in.20230601.gappssmtp.com header.i=@rajagiritech-edu-in.20230601.gappssmtp.com header.b=wBgetCe0; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rajagiritech.edu.in
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=rajagiritech.edu.in
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b7277324054so12500666b.0
        for <stable@vger.kernel.org>; Tue, 11 Nov 2025 10:33:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rajagiritech-edu-in.20230601.gappssmtp.com; s=20230601; t=1762886030; x=1763490830; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=AcER7olAeM4Hg35J9yaU4mQhqPClLIDJZWM1CqRDI7A=;
        b=wBgetCe00aDdfNpVsZe4f/iMNtN9x2rCfxHPkEYmQ5QLMsPFAUvXgRKK7VOihXIovD
         kmlAaDM427J2mQiWViaz9wv6d1DBJ7md0OmqiUrCsMx+NG0aNSfrEXgNk1f93cmUO4Sc
         /Yig0fCwVd+5JGYG+XS0kJ7l1sel1rPbmCgCYV96UgfkHJL0nu10VHGoq2OdQwnTyJou
         5sgJ+aPd/gItF/Ite+6iyHUMPM3Lcguso1JWgqPU4XDXyVri5+WDoLQ0Vw4QWDlInf8j
         xhMXxsWgLmbzLY5+OyFR8Nf3RiPZ7n6blzHwkqb7Gm4khlT3wRxP5+h5EpUkQkiEL7h5
         Fu9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762886030; x=1763490830;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AcER7olAeM4Hg35J9yaU4mQhqPClLIDJZWM1CqRDI7A=;
        b=EGi2ZMR/bpXcljrNkkg9/3xgev6P+xxPUJPrn3ZPK/m/WxkS4EHPITYxIeo7XC2owx
         ZRcha+oeBj7TEhtnr9P555utZ4fSn+OG1/bA03B4ZH0gmXWQ+Aq4Wd2JmEANgYkvoDYa
         BweypPaumD1h+p9rm6hDgJtQuvoik1LEx7BYlilJgo24pocYcH+Bk+nqhj3AndbW2SQU
         o2bUxA3/xTZQ6YOlISAO4bQf4KPHkthd12JJLx2s32wcjQI9I0d2+sAxJkp2gLa+lAEB
         9dpWSQCHIg2nanTlRSHzvaLgUAZ7zKH7JQZi7sQKg/0bY7mBuIgdgqDFLa6Qbx7D5xG4
         IkWQ==
X-Gm-Message-State: AOJu0Ywc5VoFAENR7AorO5ddSLw8yooXzo3lbRPhTUaFWmhhtBVRU68S
	MXHCid5+rj+93SE0uSWy7RsDeZfRQ/KgGyXdULT8os98p7UeHOyVS19/+NJl3aCZ1Q0tP/OrAeg
	3P0m+xoEEWiICKolxLVIfO0pDkGddDF41wWlJNt+ZMg==
X-Gm-Gg: ASbGncteQJjFR+ckOfz+0v7P+vjTXjeQtBilf0LJ+v+DgVGenKCLAEWABLZBTR4ehPm
	2PrugQeJubCxwFc2z7sTc8q2QW3rzrSLU1aw/wyLTDuHcrqIf2X1bxtfstPalKrEGIilAkTLUUZ
	+MQ7QUarXPYYMcnik8dzYLoTTWcAf3mVq3BW5frDOd7zoNVrAww+3ZCILQ/kkduG+neNZjw0ldU
	gqkV2maxWWgOdXYD+YmCqZwDbjipMGVfUSGhB9I93h80ZOK6AtLi5KZUE7Y6iPT1qXA8JqHLw==
X-Google-Smtp-Source: AGHT+IGW3rnwRPb8WEwNqTyz1wwfAn5KHqqYxBaDlV78zmJCWuayX9a8ksHIrQUncY5Ow5tnnTpTxNuBcC0v9xLmqNI=
X-Received: by 2002:a17:907:3e93:b0:b73:2299:b891 with SMTP id
 a640c23a62f3a-b7331a048ddmr11999466b.8.1762886030014; Tue, 11 Nov 2025
 10:33:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251111004536.460310036@linuxfoundation.org>
In-Reply-To: <20251111004536.460310036@linuxfoundation.org>
From: Jeffrin Thalakkottoor <jeffrin@rajagiritech.edu.in>
Date: Wed, 12 Nov 2025 00:03:13 +0530
X-Gm-Features: AWmQ_bmgKdP63t7tWapnOHZkHv4fUMORWDcztPTMRDI9ccR9qOGODxwLC1UKFvk
Message-ID: <CAG=yYwk7yJ3M+RhhQfUoPnCMBJyThff-8zGFq4Q7MmsB4hb8fA@mail.gmail.com>
Subject: Re: [PATCH 6.17 000/849] 6.17.8-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, 
	achill@achill.org, sr@sladewatkins.com
Content-Type: text/plain; charset="UTF-8"

 Compiled and booted  6.17.8-rc1+

NO new regression and issue from dmesg

As per dmidecode command.
Version: AMD Ryzen 3 3250U with Radeon Graphics

Processor Information
        Socket Designation: FP5
        Type: Central Processor
        Family: Zen
        Manufacturer: Advanced Micro Devices, Inc.
        ID: 81 0F 81 00 FF FB 8B 17
        Signature: Family 23, Model 24, Stepping 1

Tested-by: Jeffrin Jose T <jeffrin@rajagiritech.edu.in>

--
software engineer
rajagiri school of engineering and technology

