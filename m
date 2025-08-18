Return-Path: <stable+bounces-171326-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 56DABB2A912
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 16:14:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D9F65A26DC
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 14:07:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BEB5322532;
	Mon, 18 Aug 2025 13:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="n/KCUeBw"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91BD4322742
	for <stable@vger.kernel.org>; Mon, 18 Aug 2025 13:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755525549; cv=none; b=tVEHsAkRRBHine32izTcaXomA9V+YH2R2EVMwZRKd9nZjz2fuNoQgDfD3lvC/Mf0GY8bm69EJMXAe8JkevJZgfRDBvCU0o0T9acU9cHB8goD1v0/JVkdxK2xtNcZImqB5lw9eHeYzyjdYqn/b0e0m9Pk4esWXCAy7lwKkP16q28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755525549; c=relaxed/simple;
	bh=I96u/IVzBV7nJ4C+1kleMTiS/mzW7xq5+2rf8eNjfE8=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=UVNKxfE1pg5Yuu6A3MVoTNDgYiiNmq/TqIGvS06s1a9aq0djp1XMXeQhh5j4ZLsRTphjE83U4oxLHGQAk3/UsF4KbGAEPzUZdQnDi/qjoaxhw1GDvy3AIqUM5uCbGtex66Q69ERkdjHkl7yUJ+eYbpk5SKg/nVfH5wPQ/1OdWpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=n/KCUeBw; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-b47174beb13so3008302a12.2
        for <stable@vger.kernel.org>; Mon, 18 Aug 2025 06:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1755525548; x=1756130348; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2QL83AuBmlp8rggw/9mmBRQ1e4C/BUotQdlFSuMwcTk=;
        b=n/KCUeBw46I9mFer3nu7HSLq/WtZzZNsF+kE0U3wJPjBt5+C+B5+AeYGMbyPPw5qBr
         M5ym7pa5eiG7clyAQrRmbYVwVkpizZCt/Getj77aTv9EvokVNYgHI8+4+p+ALew5pY9W
         Blg4Q5GuxjwUf6x0Ucdw1dy9xcZKpS31iPS5388YoflTrQBLVNbBgFhpaskckDchtcsk
         VWuUSL0JR2r2Cw99T9mfvpIaS5gthlj7oRLsLOueDdusLDw522FAp2xjTzxlfQTER8dL
         SIYNLMUERCYh/v/9Vqg+UDVGgrlD5M3G6Wc0kSDnmkx/Kk9TVUNxsK2LX4FoP3mHhm3/
         UIEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755525548; x=1756130348;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2QL83AuBmlp8rggw/9mmBRQ1e4C/BUotQdlFSuMwcTk=;
        b=ny1NQJ8n1gqzHp3uOKivEEzd7OGiatcfzL2yOxiPBTh3ipzvBw0ZjBeL3tTja2AUXS
         2RbSw74yanqvkNyf2YSmuxh0nFeDU1NzI1b4KdOfBrM+qpocySLDPYDmDSD0i99royxJ
         c7FZnEk+OdTBJj1q6cwjY+BYCEFnv2E6rmvJ67EVrA4E1ANn6eEZOtzkcn+YF06UqNvd
         XxZD6ALLoKTeac+ywezZb+Q9ZI2T5TlHeq6GXkdX1+iLUnG3O4auwNIWzVODY2BVi//x
         r8ObBmvwUDcn/IRlHSrREDrDcHkgPNQB+UTXUEXhHHsXG3R+L/ImIj8c7I1IHymxlAwb
         3InQ==
X-Forwarded-Encrypted: i=1; AJvYcCW+8NnFw3ft83Oh5C+NeKHZAJJe5kM0qlsG03BBocRmIjY85RhPXyTIWyISXp0/fbsL/Ej//FM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyhq4s+Ysnsj21YyMFpi5N3ihVzx1K9X/WMBnfO9Thh6xMslXXD
	QmFcmWPrj70S/0tMdtvpRq7NuwRWkJgOay3Na445wnNysBeDVnQPxpJfOgS8c407pp6y4dMZOs4
	lEh0e
X-Gm-Gg: ASbGncun/nNvHnal0EVJ/mwwQOB4U9A385vVGRzoWfP5HeZHtu2dEiRgzmj9FBNOMYU
	9/lrMZycQMtQ1wfRH2fOZZZ14KXK5N37EnWF0hFdAtXqndC0zFpPG1FrV7n+bS5Sfb94Z4+C2af
	evL4KM3SdQjBHXWnTW0tnK7FIv4y1Ey8/ysJB7Lp95k3QwyuBKeg3ZycepO/Y/hgGiQEFl7x1ky
	BtzGaOAjcnt6XXTbbGrjY1B2yPJukBtkUsvizddnVmQrMHylVyGLdMcUTBgLSwc8WtGJBpnjRN2
	+OlD8QtOqfxR3hFdHLVaDhVhRt7rMA5p8aUUQ66nl2sGBck+RjpuQ579NachtsaePeLIkPBGKIm
	1IKph0M6ysUCbERnT+nuk0tv56szQsKChzIfL5A==
X-Google-Smtp-Source: AGHT+IHZ5uPP3sSeP3uo5Irehwp9UanNH8VHnApD4ymC15rZMdYUtl31JAcUDnl8t21FPfX2nZjuEw==
X-Received: by 2002:a17:902:d509:b0:237:e696:3d56 with SMTP id d9443c01a7336-2446d8c61b8mr207553255ad.32.1755525547729;
        Mon, 18 Aug 2025 06:59:07 -0700 (PDT)
Received: from 16ad3c994827 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2446d50faf2sm81761735ad.81.2025.08.18.06.59.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 06:59:07 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: 
 =?utf-8?b?W1JFR1JFU1NJT05dIHN0YWJsZS1yYy9saW51eC01LjQueTogKGJ1aWxkKSDigJhD?=
 =?utf-8?b?UFVGUkVRX05FRURfVVBEQVRFX0xJTUlUU+KAmSB1bmRlY2xhcmVkIGhlcmUgKG5v?=
 =?utf-8?b?dCBpbiBhIGZ1bmN0aW9uKSBpLi4u?=
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: gus@collabora.com, stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Mon, 18 Aug 2025 13:59:06 -0000
Message-ID: <175552554653.51.2028032983372634371@16ad3c994827>





Hello,

New build issue found on stable-rc/linux-5.4.y:

---
 ‘CPUFREQ_NEED_UPDATE_LIMITS’ undeclared here (not in a function) in drivers/cpufreq/cppc_cpufreq.o (drivers/cpufreq/cppc_cpufreq.c) [logspec:kbuild,kbuild.compiler.error]
---

- dashboard: https://d.kernelci.org/i/maestro:dc41002c36bbf28f576cb4cf62779067892fb9db
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  a6319f2fe27b8fefe40757d3797cfca30d43ce3c



Log excerpt:
=====================================================
drivers/cpufreq/cppc_cpufreq.c:410:40: error: ‘CPUFREQ_NEED_UPDATE_LIMITS’ undeclared here (not in a function)
  410 |         .flags = CPUFREQ_CONST_LOOPS | CPUFREQ_NEED_UPDATE_LIMITS,
      |                                        ^~~~~~~~~~~~~~~~~~~~~~~~~~

=====================================================


# Builds where the incident occurred:

## defconfig+arm64-chromebook+kselftest on (arm64):
- compiler: gcc-12
- dashboard: https://d.kernelci.org/build/maestro:68a3251d233e484a3f9e9e33

## defconfig+lab-setup+arm64-chromebook+CONFIG_MODULE_COMPRESS=n+CONFIG_MODULE_COMPRESS_NONE=y on (arm64):
- compiler: gcc-12
- dashboard: https://d.kernelci.org/build/maestro:68a324d8233e484a3f9e9df2

## defconfig+lab-setup+kselftest on (arm64):
- compiler: gcc-12
- dashboard: https://d.kernelci.org/build/maestro:68a32513233e484a3f9e9e2a


#kernelci issue maestro:dc41002c36bbf28f576cb4cf62779067892fb9db

Reported-by: kernelci.org bot <bot@kernelci.org>

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org

