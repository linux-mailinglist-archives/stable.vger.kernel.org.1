Return-Path: <stable+bounces-196836-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F08CFC830E5
	for <lists+stable@lfdr.de>; Tue, 25 Nov 2025 02:59:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 506FA34AD99
	for <lists+stable@lfdr.de>; Tue, 25 Nov 2025 01:59:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 414E61684B4;
	Tue, 25 Nov 2025 01:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="bzzMrB2X"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 410DC198E91
	for <stable@vger.kernel.org>; Tue, 25 Nov 2025 01:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764035947; cv=none; b=qG7+9UYEkVCa7x2nzxuXHW49jKQUWLKqllhem+E7UUHh2Y0qnhzbIc+YXLwpWcQmwbH4UnIzToaDv7xWwh0nhuXgZa66R8WuwBNeTD7ZThPrmbdaHPihl84vcFoey9UQ0kZglhx1JUnVk5BzUxLVskMiq9Whv3Qjuo1P5KQI3Co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764035947; c=relaxed/simple;
	bh=H/HigCCJ4syA38odH062o4pdZYRkMatrYkaz1MlLA1U=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=EGTUJbMNh1qIUDlK9EDxaXhAmiZ1PsMU//hFMAqJ0L5KHHDjF4SW04lyEv7EQmJ3hprHxtFTKYnTZVHGaaQicnYdZ1JjimeCqYOKFgyn2WmGVH32pqTWpHsPTETZ2P4YNBdWL9X+5SbRwQRIMSzOq/8f0qNYtKM8UFkVyGi4hHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=bzzMrB2X; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-bd1ce1b35e7so3345866a12.0
        for <stable@vger.kernel.org>; Mon, 24 Nov 2025 17:59:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1764035944; x=1764640744; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k/BJci4ea0TAq74xXzMvBFJc9FPj9ix/bugKuzwv2DE=;
        b=bzzMrB2X5rsiH28p8oOpoShMe93Cbu/+9v64A/D+BjdGnubh9EKDdkRiV1W+ifWZzi
         rdI7dMdECm1tRRMRMtNMd+WQNrT8xFKXSt0dg3linP6H89MWnaKlic9UDE3OPD8SgawG
         ZrOOR1IsK/GItk4z9b/+1woaApOYF+gCpiYBJz5jC1mxhwG5gh7oZNAkrHXsrGPoyQG5
         F4VMGLuSfhBuEgSXeR7dHq9mvdjB5MYgVKauJIoUnAYI8loKV9ncBl2vHhyZhFUAa5iw
         7Y7x5rYIdh//Av1iCBbQbEDDOIu0f3l6VB7QUyTBqg6mMFmi9lgFh9w7q1+bpjHC0VkD
         GN6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764035944; x=1764640744;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=k/BJci4ea0TAq74xXzMvBFJc9FPj9ix/bugKuzwv2DE=;
        b=wlOa7yvaCD9AMMrmvesnxqvztg3WTfxkwEA4g6xHehQb6acJpe8VZbIYiBwkZP1mK4
         D99r8zFy9Da/xa3npL8qmCB04vr0TCZp9mQaVFc46HRPU4LWfq3JYJerjuK0IQB6NGJe
         xRhfsVIB/w0N9KCU7yRNlZ8h/dtMOEEJKCEMf1tHVAlihDWNi6aYwNUH1wUsZfM2lgGd
         mdj9ppMRnXAmuqrxf5M2WfA/KwJX4j6MZ+GLzDvLeSFKBVQdalTxdgIV9KGJtEy4Dh1Z
         4qc6p8R3XC80W2LWk/nyCvLmmMYnrDEkh9AO0l789tUNuWbqaUlADlPqmLz8E5FigcHk
         Hj0w==
X-Forwarded-Encrypted: i=1; AJvYcCUbBG2IEHvHc6aXbxL9hebeWEr1sCj5WXRKc6aVdwnIWKcB1xyKuDal9LzZGg7JlEY2FbJ+BXc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYCA0EbEmEqcPIiWmiNMb46HGnF1ia0RSgxclpF+xWaFDAZ2PK
	kV8Z9Vt0BcX7fuuKYryBMOwIdlNtqQYn8bmJtLwSxnAvWANKHbD32MiPDbOLTMZI/vo=
X-Gm-Gg: ASbGncsChbUJgTVIBIjlE4Q9Dc//qH+IciG73S5xf4iIwmIDlpUQW3uU5z/aDlPP7+e
	H9e83to5/88whzc+2PmfWkxygwaMoyDsl4giyxbW0D2d9B8UuKC4UGQZ6CDEAOARXnz+maQPoS/
	Sg5/OhczvjQSIdJ20GcjssqPbJ1w4qBQMSigB5HjCRr3XMVxLQUvNL1fpsG33aBL5kVsO/7VNK7
	BKRCV5YBZBsk2/RZJdPoybsWSk8TNLTbhCAWPPqnv95cv8i8RjNh80UHEW0tQhdgWc36BBEQpoS
	p01MmPRUbyCh8c9wigGwLk30lOZ1cb1h4dFsmd3uPtE/PZ01VJALR1d2HEJG72qAXmbUiMPT+sU
	HOE/rMFHW+0XSMSnURE3/5dOnka9bpfrRMjJPYBT5tDbhQo/6LSRWFMHM6CFYVdJu1jy2jGyUVP
	NSGzRv
X-Google-Smtp-Source: AGHT+IHBSsOD0XlGTeNV+hU9D6D33EHYIUvmLiHFc5AFlyT6aR5EA8c88YAcyuusY4uRwETmm3duzw==
X-Received: by 2002:a05:7301:420c:b0:2a4:3594:72dc with SMTP id 5a478bee46e88-2a7190f1efemr5577728eec.11.1764035944320;
        Mon, 24 Nov 2025 17:59:04 -0800 (PST)
Received: from f771fd7c9232 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2a6fc3d0bb6sm81805463eec.2.2025.11.24.17.59.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Nov 2025 17:59:03 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [REGRESSION] stable-rc/linux-6.7.y: (build)
 ./include/net/ip.h:466:14: error:
 default initialization of an obj...
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: gus@collabora.com, stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Tue, 25 Nov 2025 01:59:03 -0000
Message-ID: <176403594309.337.11340865245400564397@f771fd7c9232>





Hello,

New build issue found on stable-rc/linux-6.7.y:

---
 ./include/net/ip.h:466:14: error: default initialization of an object of type 'typeof (rt->dst.expires)' (aka 'const unsigned long') leaves the object uninitialized [-Werror,-Wdefault-const-init-var-unsafe] in fs/select.o (fs/select.c) [logspec:kbuild,kbuild.compiler.error]
---

- dashboard: https://d.kernelci.org/i/maestro:ef7b256354a7cedfb60e6ae7cbe595e4f34cf4ed
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  dacf7e83da42bd9d3978560e41869a784c24d912
- tags: v6.7.12


Log excerpt:
=====================================================
In file included from fs/select.c:33:
In file included from ./include/net/busy_poll.h:18:
./include/net/ip.h:466:14: error: default initialization of an object of type 'typeof (rt->dst.expires)' (aka 'const unsigned long') leaves the object uninitialized [-Werror,-Wdefault-const-init-var-unsafe]
  466 |                 if (mtu && time_before(jiffies, rt->dst.expires))
      |                            ^
./include/linux/jiffies.h:135:26: note: expanded from macro 'time_before'
  135 | #define time_before(a,b)        time_after(b,a)
      |                                 ^
./include/linux/jiffies.h:125:3: note: expanded from macro 'time_after'
  125 |         (typecheck(unsigned long, a) && \
      |          ^
./include/linux/typecheck.h:11:12: note: expanded from macro 'typecheck'
   11 |         typeof(x) __dummy2; \
      |                   ^
1 error generated.

=====================================================


# Builds where the incident occurred:

## x86_64_defconfig on (x86_64):
- compiler: clang-21
- config: https://files.kernelci.org/kbuild-clang-21-x86-6924fd86f5b8743b1f5fa865/.config
- dashboard: https://d.kernelci.org/build/maestro:6924fd86f5b8743b1f5fa865


#kernelci issue maestro:ef7b256354a7cedfb60e6ae7cbe595e4f34cf4ed

Reported-by: kernelci.org bot <bot@kernelci.org>

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org

