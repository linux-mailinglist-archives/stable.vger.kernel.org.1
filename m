Return-Path: <stable+bounces-160139-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 28DEAAF8705
	for <lists+stable@lfdr.de>; Fri,  4 Jul 2025 06:57:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF2FA1C44490
	for <lists+stable@lfdr.de>; Fri,  4 Jul 2025 04:57:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13A8F14A62B;
	Fri,  4 Jul 2025 04:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="cnO60MTk"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78D101EF38C
	for <stable@vger.kernel.org>; Fri,  4 Jul 2025 04:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751605036; cv=none; b=HUFfmAowfPdi3dllyRdYMuzD0IVvK0b06rKFEjSzG8zQufEiEeBaVpSkNpuoo7sSlqNACm8yQ1gR2wT1kLwOAWfwbSLLF3xxf3i1qkgKhIF6Ky3b6BdhO6a3Bk7QqQJoaXQUMBuDDaOBBcWu5igfKdtZNpm3yn1GEsELnRPFjVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751605036; c=relaxed/simple;
	bh=FDw4ZPy3X7k/Beth3BEz0O00Bzcr7Wah6dBowmHyKVo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CGngEY1k7dd9NodJKvu0Bet7MvEZRp+cR9aMku1j7XOWAx2crkksg0ubMiiQhVxXuDjFSCD5oz208p7Z5646idHXT2LwcC+0Ul/wTDBN/chuaiXxxk94QFDpWOkqOVjx/U4wAv3trqPCJgyaFNzirQyTkDaHn9lJ25wJ1mzF09c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=cnO60MTk; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-31329098ae8so509846a91.1
        for <stable@vger.kernel.org>; Thu, 03 Jul 2025 21:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1751605034; x=1752209834; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FDw4ZPy3X7k/Beth3BEz0O00Bzcr7Wah6dBowmHyKVo=;
        b=cnO60MTkGt4M+jPTL/G4OLyjBYQc6DUTWK56Xs65vP3k0GYfhk+DhZDniaWoDmHlFv
         LnC+x2AdF1sYK+niuEUwKD9RB0CQe3S/imgZycbSk9BYK+FCB6Xp1xrahmYJS0T5iygU
         mHV+LF7sWDfqIjjTUDnE/IFyAdZsWs8PLSPAc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751605034; x=1752209834;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FDw4ZPy3X7k/Beth3BEz0O00Bzcr7Wah6dBowmHyKVo=;
        b=IGxaculzrqlRXxDREDi6dKkwDSzT5hTHU3oWCjN0joQFCdspQE8es1PCKUcElS2K10
         l/0hDDcEt8SgwB/oBuQ2lJeVfooimDUl9jenS+X6Pt7MGMNZP4ljDN2M5lscBGDZzfpO
         FANBuKS3UCfVf9NdfjxaAuGmdpdB3/3CUqTy7pOvwf2TPBueSjbqpCDiWCELMjVeHjzr
         UZglzKOHhxyCmqc1YbPpM80gPRJXCFWx34GgvDOIHBLmmgXrLr6RFi0id5uABHEyR2YV
         YoOVnctF+W7xfVnQVxkbiSU1AA/efjPVT509sEf7iIsD2o5D1CPHM739+/nlGkBOT4LC
         ty1w==
X-Forwarded-Encrypted: i=1; AJvYcCUA1kV+6CW7i7XMGXsZBiKAhhKTPTwvsTrpx3SGzFrewj8IWDg4T5RohllBTAsdGUDG1tF65pI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvkRs7BwHm4P0DS6cFkBixVPtAh8za5Jpxtttb2KBXJyVwpiSC
	Z4sVhb5Q3NWp93KVH/N8tIQGAEIxd2BNa3HRjYi5q2Tx05nxXB9/UD4OzdyWc3jNmyv2UYWw/Nb
	4LdiZGg3a
X-Gm-Gg: ASbGncvjNSVxBq6kzfOMb4GYDnRGuUWhNOWBks0XYXLFspwjENoX+xs1VQKcubvcvlK
	2Cloa5t+4j6SlLotF5e6Gn97Hd5h50uiSoqHcVfYjatMF3/YjNswT77T3VIrQ1npXCKvDUI1hzP
	fkCp20wpVXsM91AUrgC/9+tGiQFdU8OkX5OrK/Bljy3POCGFZfPOYJohOiD/KOYDmZmJdqXFx2A
	hS75uMrJiIEtctmyjheWQ7if4tSTSbNAn1jLJseJzxJSNEdxNVztSw2RdsGJwK6MalUEzwn1xHv
	DHbN+nDySGOx2UGagRZPxnNNGjhtZbbOAr6AeB7LcoXJ/hcDUh4nS3N419w6hIQ8aYLLDg5yxSO
	CxEJUogoxWidlSLc4qq3ILlQbPNX7K3w=
X-Google-Smtp-Source: AGHT+IHVAE/OzDGEVtkvpfSZUr627Cgxhj3egNhQDXRQkuOQO3Qe+yX3K8dvgAq6amOAK2M7n6X6ow==
X-Received: by 2002:a17:90b:3849:b0:311:1617:5bc4 with SMTP id 98e67ed59e1d1-31aab0397ffmr2425986a91.12.1751605034034;
        Thu, 03 Jul 2025 21:57:14 -0700 (PDT)
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com. [209.85.214.177])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31a9cc66830sm3818606a91.16.2025.07.03.21.57.13
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Jul 2025 21:57:13 -0700 (PDT)
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-235e389599fso309865ad.0
        for <stable@vger.kernel.org>; Thu, 03 Jul 2025 21:57:13 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVpDDOiIYbS4PByRfwQn85A93JUK/Uv5LEzt2/FPGWWyUI0+ripoe7TosUL1DfrkkHhG69ofY4=@vger.kernel.org
X-Received: by 2002:a17:902:c405:b0:237:ef9c:ffd9 with SMTP id
 d9443c01a7336-23c79adac6dmr4437795ad.2.1751605032342; Thu, 03 Jul 2025
 21:57:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <87C1B2AF-D430-4568-B620-14B941A8ABA4@linux.dev> <84dfa466-d201-4a51-8794-6c64568bec95@kernel.org>
In-Reply-To: <84dfa466-d201-4a51-8794-6c64568bec95@kernel.org>
From: Peter Marheine <pmarheine@chromium.org>
Date: Fri, 4 Jul 2025 14:56:59 +1000
X-Gmail-Original-Message-ID: <CAG_X_pC0jTe5fuNaK81veif-p9JeJyYpgb2E2R_RXBzfcj4_MQ@mail.gmail.com>
X-Gm-Features: Ac12FXyWqCjWEIleUBl_ePtV786t5G-mg7Cm4JbPyPJYEHruTXbvG1LIQIHiEZg
Message-ID: <CAG_X_pC0jTe5fuNaK81veif-p9JeJyYpgb2E2R_RXBzfcj4_MQ@mail.gmail.com>
Subject: Re: [REGRESSION] - Multiple userspace implementations of battery
 estimate broken after "ACPI: battery: negate current when discharging"
To: Hans de Goede <hansg@kernel.org>
Cc: Matthew Schwartz <matthew.schwartz@linux.dev>, pmarheine@chromium.org, 
	Sebastian Reichel <sre@kernel.org>, regressions@lists.linux.dev, stable@vger.kernel.org, 
	rafael.j.wysocki@intel.com, linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

I'm not surprised that there exist a number of userspace programs that
assume the buggy ACPI battery behavior is the only one, but this does
leave us in the previous situation where there's a clear bug in the
ACPI driver.

> But, the patch was actually doing the right thing, according to:
>
> Documentation/ABI/testing/sysfs-class-power

This is the key issue, since it's entirely plausible for a program
assuming non-negative battery current to run on a non-ACPI platform
and misbehave in the same way. If we're not going to fix the ACPI
driver to behave as specified for the kernel ABI, then the ABI needs
to be redefined to reflect the actual behavior. It's either that or we
give userspace an opportunity to fix itself (and I'm not sure exactly
how that would be done such that the clients which need to be fixed
discover that they need to be) and correct the driver's behavior
later.

