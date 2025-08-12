Return-Path: <stable+bounces-168730-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BECE3B2366D
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 21:00:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D4446E1C4D
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 18:59:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 002B22F6573;
	Tue, 12 Aug 2025 18:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="ixAKkfAI"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FBA02FA0DB
	for <stable@vger.kernel.org>; Tue, 12 Aug 2025 18:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755025147; cv=none; b=dCNWic6/R7PFb64H04JgxLNIOXzleE9BUYBmqG0i6zZg6vbUzF/gGqRdyxwV8sr4A3JM4f2bs/QpGP92XJ/nkwHEUuxHCVz67Cz/lQxf4b2MR+cmDi3d/0W4qVjXkDBrnfgSJYR4NEvhuD0GClI6r9Nchczgjj8Ip3LAiUQte8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755025147; c=relaxed/simple;
	bh=m+foRacDleWMt4sWgUF+t5nHcyWAMI74Hnz3TvmJZL4=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=p2zROvCEiihTkkmAmHx5Ztsn+BYPJI72fCTTDt0smwkwVVV7B2E+PKePWCnBcG9V7l0URbgrCvQqF7EcFPxE4zy7jxm0hK41bhWoTpDIAONEabc3TsKj5SE75GkGmmGlVKEG7Rkkl7LYelA0/QnFxdKzwGZ6oDSa3gqYOe+QKnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=ixAKkfAI; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7682560a2f2so190238b3a.1
        for <stable@vger.kernel.org>; Tue, 12 Aug 2025 11:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1755025145; x=1755629945; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DJvE54Bq8bkgT6Kr7I/wXfWvbtj4Zbul0NEszJ7VL8Y=;
        b=ixAKkfAI9qCSZLPab3eK/KG5vOjXnd/EX0AKl5mXbzeaynXLas5WbyFlpEIlSzJZtX
         26Hq1TTY2EDWjXaXSZyc5/Xi4AESTB5sc4Qp9cH1cuSpYRSHThNktx4AqTz9NW18RTJu
         1Y4gl8ywJ4ytf/MH4a3cHfHPl8dGrI5w0Uv6LwbpIjIaHx/HyD0onU0dctboTDP3PBBF
         x38vfq88skIl9OiZTRlblUnvUgwHGk/AkdgKr0dvsDprOtV+VZBNCwLg1ptidthf7ArZ
         SFPGnEZizXkMH3V8Swv3hgfXKx4Dc3hgXNOwE/QTaBPoYo2vq4Sbu/MV5HyEroNIHL5I
         PoeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755025145; x=1755629945;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=DJvE54Bq8bkgT6Kr7I/wXfWvbtj4Zbul0NEszJ7VL8Y=;
        b=Z6tHEtTuc+rClSWRA/IC7WGMWtSQm5hqh71zCb/PMcp0IDlr9D3VQV4OLlNQIgkO14
         AaxPD7i3d4Uatlj/T/oYXGOSoNhSlL3H+i0wGrECciDr938t7TANW6v1gWAf/A0UV1Vh
         7bR0fXYfpqLQE92PlIztyx5HsBa0Xyw0AnZF0Ht0IE7h4ey16z5ByVYuMrk9xQNlWbIa
         JBt6hlxj+EBfoAmM1zVco2PU/Baj9lPF8lO13fp62mJdGkHaihYJRuQqa2uNdcFRLWr3
         X304gzdzYHMwSjFLXuDoixOM5aPa7yWMtt0tr8kJ58wM+yTIeC7+Vd7XmRoEMD/thdpW
         FzhQ==
X-Forwarded-Encrypted: i=1; AJvYcCV4QxqOaRl76DmSi8yBlPNTSTVo7LNGQbRUzX8aFDHU/yLgt0Dg1Q516M8v3VmkAyxyNQWJtMA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZYMQghvyAuSwAPAwjDjHrfrjM1hUWvXLwZm/4I4qsNwwgQwAc
	rP0u0v3lfDYot2S/B3P5NrP0ixspIRk14/95o1WMoHFc0EZZKJnv+7txwPE5mb9kg1k=
X-Gm-Gg: ASbGnctnfEp+iZ65FZ5otrFcB/TlMqgBcjVJ16URrRkC/t/bLRkjCpcan7Z/tKLzxy/
	KQCwidJjMYWycxQRvx6TJFcA0WYUTsQHVMCbDVKRgzp+E3gGbjwpM2+8W3ekST6bE2vCLmL00rc
	+Pfv9jtiyjIywFfD9UZdyp90aXKrqyX6WMWtMYqSIIavwSUWp7dJ6Z8v5YOp5JNXXaOulCOtFoT
	lJO0C5CCPEDaVwd3laD+yDRzyljMy2ZSL5w+wxb53BSYMZsYpHKeuATJL/RRz30I3qa0ISerqrQ
	/v1j3VKbSUiQXv0t8MDMVtTRFk2CuJEck9Ajq/HrPA9bDYD1xhR6cDEbgy9UkbdzGG/bIsqmQd4
	41tD+21EVG4hL55Kk
X-Google-Smtp-Source: AGHT+IEJPN7tEJNhornPvR7RdLvqmgKDmJwuyZwaABKc2U4HF9KjmKXrtxFOewSROr0H08UM5lNjEw==
X-Received: by 2002:a05:6a20:3ca2:b0:23d:d85c:bc0e with SMTP id adf61e73a8af0-240a9e6e934mr30477637.14.1755025145229;
        Tue, 12 Aug 2025 11:59:05 -0700 (PDT)
Received: from 99cfaf6094a7 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bcce8b59esm29789457b3a.37.2025.08.12.11.59.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 11:59:04 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: 
 =?utf-8?q?=5BREGRESSION=5D_stable-rc/linux-5=2E15=2Ey=3A_=28build=29_?=
 =?utf-8?q?=E2=80=98host=5Finitiated=E2=80=99_undeclared_=28first_use_in_thi?=
 =?utf-8?q?s_function=29_in_arch/x=2E=2E=2E?=
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: gus@collabora.com, stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Tue, 12 Aug 2025 18:59:04 -0000
Message-ID: <175502514372.223.9553022187120134710@99cfaf6094a7>





Hello,

New build issue found on stable-rc/linux-5.15.y:

---
 ‘host_initiated’ undeclared (first use in this function) in arch/x86/kvm/vmx/vmx.o (arch/x86/kvm/vmx/vmx.c) [logspec:kbuild,kbuild.compiler.error]
---

- dashboard: https://d.kernelci.org/i/maestro:f3f2b1eabef22152c0bfbd86fe01d397c2c3478a
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  62f5d931273c281f86db2d54bfa496b2a2b400cc



Log excerpt:
=====================================================
arch/x86/kvm/vmx/vmx.c:2022:14: error: ‘host_initiated’ undeclared (first use in this function)
 2022 |             (host_initiated || guest_cpu_cap_has(vcpu, X86_FEATURE_RTM)))
      |              ^~~~~~~~~~~~~~
arch/x86/kvm/vmx/vmx.c:2022:14: note: each undeclared identifier is reported only once for each function it appears in
arch/x86/kvm/vmx/vmx.c:2022:32: error: implicit declaration of function ‘guest_cpu_cap_has’; did you mean ‘guest_cpuid_has’? [-Werror=implicit-function-declaration]
 2022 |             (host_initiated || guest_cpu_cap_has(vcpu, X86_FEATURE_RTM)))
      |                                ^~~~~~~~~~~~~~~~~
      |                                guest_cpuid_has
  CC      fs/kernfs/dir.o
  CC      mm/msync.o
  CC      security/landlock/fs.o
  CC      arch/x86/kernel/cpu/perfctr-watchdog.o
  CC      block/blk-mq-cpumap.o
  CC      kernel/time/timekeeping.o
cc1: all warnings being treated as errors

=====================================================


# Builds where the incident occurred:

## cros://chromeos-5.15/x86_64/chromeos-intel-pineview.flavour.config+lab-setup+x86-board+CONFIG_MODULE_COMPRESS=n+CONFIG_MODULE_COMPRESS_NONE=y on (x86_64):
- compiler: gcc-12
- dashboard: https://d.kernelci.org/build/maestro:689b7814233e484a3f8f20f4


#kernelci issue maestro:f3f2b1eabef22152c0bfbd86fe01d397c2c3478a

Reported-by: kernelci.org bot <bot@kernelci.org>

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org

