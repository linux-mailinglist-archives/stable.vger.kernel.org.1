Return-Path: <stable+bounces-88085-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 02ADC9AE92B
	for <lists+stable@lfdr.de>; Thu, 24 Oct 2024 16:42:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B649A28A452
	for <lists+stable@lfdr.de>; Thu, 24 Oct 2024 14:42:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0037A1E5735;
	Thu, 24 Oct 2024 14:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wAfM0OWt"
X-Original-To: stable@vger.kernel.org
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 980F31E3788
	for <stable@vger.kernel.org>; Thu, 24 Oct 2024 14:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729780910; cv=none; b=BV0qa7RROW1HzRxVfNh0ISezKD+mO/C9HYuaTLIclrxp8Pf7l6RRCezLRt/N3srfgE8eB9mDGD/Wv0JCOD7/4xYG5Ri6JLc1GBWatUlODMZUfr0p0DZSFJ82hOVZNg5fpZk7+ibRvi/u0aSvAWuHsl0qIAjnY5nQDHVTLnn8cyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729780910; c=relaxed/simple;
	bh=PB8KBVtiODUPJZipdTOV7LIC3rFuPdVi4OkEXiOycZQ=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=i9FZCaV+wC65sfti78syurSU3E6sChRyVGL3igOfmqnr/cQgiMspnDCFVEuY7l7erYk9ieEMb+PS8B2FmBkNEtJVEFrmtQUl2QEqk6H6Kfieo82Y5P1KX2hIRCE/fljo8AHWzTio2NzWmUFEqTMR5EWCSNs3Lhs5Qhcy0ppxVqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wAfM0OWt; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3e5f968230bso459908b6e.3
        for <stable@vger.kernel.org>; Thu, 24 Oct 2024 07:41:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729780907; x=1730385707; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dZVAlNyX41TJtkmqUex4uvcXk1DCDx1jUZWPpru6ieQ=;
        b=wAfM0OWtqL3UAFrAGLpmyT38YMOJU3RlJGWdA22cvnLzKsG2yrqnbYtdcpxQ2OJdPx
         WHojQU+W66MEYcqeORNuCTGlbG9pByfnkF5MJeaTLH+VFfRMZPEp9Kr5WK/zIlsHFEXM
         nAhu2+p4f61leCBTqz8ktk4UiVHyvXzz1d9IDiC3yDaUc912qBXHLs25YUs94ZvTEhn/
         msR2cz7IR6e+63DoVlXOvcf98K9bUFV6+5lgFB/YGdlRDRMW1/zmy614wEb7zGg/Yp8E
         0HBnylUyITPWdkrV7ZuyAek1psV1xAF6USHUNcPVkEJOwIVpuXNs6jKAziHhmgUHwzHv
         YDEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729780907; x=1730385707;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dZVAlNyX41TJtkmqUex4uvcXk1DCDx1jUZWPpru6ieQ=;
        b=K4VBMrkAtSFZOHw2fFloEn9s5Rx4ucBhCX8Yg7CNulodF0F/+J9OrOTz7r5XvO4Jy5
         V66i4h5cvqoXK3smFgJ1K3yLd0gckraczIoVPSjvgKv0NxqLEtcPCaiohMYRNYMMff/i
         +1SVAquiuNMxYo2Oez6MGV2S7oTyZXFO24GnWW8FuxYx0kq7S7XQhOIvjmMdascf7vdl
         +yDM4YbkNkeECboM+pPJ5PFAGQnl2dpm9CIUn5LYGHw/OB1j5SjUZTYjYA2ehidxTKfS
         cLRByFnaf/xXD39//RdZ/54ssfA8Qn4MKUaia+skhwZCmFHgUtns2M5MiNQHOnnj0iEK
         zt9w==
X-Gm-Message-State: AOJu0YwQLwjjLBOihrkKLvQ7Tfv4Jw49DFJyllEAPfpis6bIHHrxL923
	KXaQbmPF393EKSaUPw+Tt2rmx1XEgbJzU7n/GzhEll8rylJ9+XDZreLvdIql8TPrd0AfKpAnSxA
	Qdc2uDw0Olwqb5P+XOr83tT4maLTqXAiDv2UK77QTq25TsIoado4=
X-Google-Smtp-Source: AGHT+IFoj6HxQyMTP+O33KIqB5ZEoLUAbXegDn8qFNOc1tMmOFYwu+hGvrsVM/tago/3Idtl8FtQq6jNLh4roVRyF88=
X-Received: by 2002:a05:6808:3a07:b0:3e6:261f:5a51 with SMTP id
 5614622812f47-3e6261f61eemr6815877b6e.35.1729780907103; Thu, 24 Oct 2024
 07:41:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 24 Oct 2024 20:11:34 +0530
Message-ID: <CA+G9fYsaQPsvJdCsezaTu1x3koCzkTBEG8C1NpZotZLXZpZ9Qw@mail.gmail.com>
Subject: stable-rc linux-6.6.y: Queues: tinyconfig: undefined reference to `irq_work_queue'
To: linux-stable <stable@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	rcu <rcu@vger.kernel.org>
Cc: Anders Roxell <anders.roxell@linaro.org>, Dan Carpenter <dan.carpenter@linaro.org>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Sasha Levin <sashal@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Most of the tinyconfigs are failing on stable-rc linux-6.6.y.

Build errors:
--------------
aarch64-linux-gnu-ld: kernel/task_work.o: in function `task_work_add':
task_work.c:(.text+0x190): undefined reference to `irq_work_queue'
task_work.c:(.text+0x190): relocation truncated to fit:
R_AARCH64_CALL26 against undefined symbol `irq_work_queue'

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

metadata:
------------
git_describe: v6.6.57-251-g1870a9bd3fe7
git_repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
Build:   v6.6.57-251-g1870a9bd3fe7
Details: https://qa-reports.linaro.org/lkft/linux-stable-rc-queues-queue_6.6/build/v6.6.57-251-g1870a9bd3fe7
kernel_version: 6.6.58

Regressions (compared to build v6.6.57)
------------------------------------------------------------------------

parisc:

  * build/gcc-11-tinyconfig
mips:

  * build/gcc-12-tinyconfig
  * build/clang-19-tinyconfig
  * build/gcc-8-tinyconfig
  * build/clang-nightly-tinyconfig
arm:

  * build/clang-19-tinyconfig
  * build/gcc-8-tinyconfig
  * build/gcc-13-tinyconfig
  * build/clang-nightly-tinyconfig
powerpc:

  * build/clang-19-tinyconfig
  * build/gcc-8-tinyconfig
  * build/gcc-13-tinyconfig
  * build/clang-nightly-tinyconfig
arm64:

  * build/clang-19-tinyconfig
  * build/gcc-8-tinyconfig
  * build/gcc-13-tinyconfig
  * build/clang-nightly-tinyconfig
arc:

  * build/gcc-9-tinyconfig
  * build/gcc-8-tinyconfig
s390:

  * build/clang-19-tinyconfig
  * build/gcc-8-tinyconfig
  * build/gcc-13-tinyconfig
  * build/clang-nightly-tinyconfig
sparc:

  * build/gcc-8-tinyconfig
  * build/gcc-11-tinyconfig
riscv:

  * build/clang-19-tinyconfig
  * build/gcc-8-tinyconfig
  * build/gcc-13-tinyconfig

compare history links:
-----
 - https://qa-reports.linaro.org/lkft/linux-stable-rc-queues-queue_6.6/build/v6.6.57-251-g1870a9bd3fe7/testrun/25533195/suite/build/test/gcc-13-tinyconfig/history/
- https://qa-reports.linaro.org/lkft/linux-stable-rc-queues-queue_6.6/build/v6.6.57-251-g1870a9bd3fe7/testrun/25533195/suite/build/test/gcc-13-tinyconfig/log

--
Linaro LKFT
https://lkft.linaro.org

