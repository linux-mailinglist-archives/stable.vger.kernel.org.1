Return-Path: <stable+bounces-73957-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D02D970EA3
	for <lists+stable@lfdr.de>; Mon,  9 Sep 2024 08:54:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AFBC1B2227D
	for <lists+stable@lfdr.de>; Mon,  9 Sep 2024 06:54:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CD7A1AD3E4;
	Mon,  9 Sep 2024 06:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S7nrBuv7"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FB221F95E;
	Mon,  9 Sep 2024 06:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725864849; cv=none; b=EKFa5uTqkEtncdYqU44fnDhRLDFvJxbi3F9gsLpfBE9tnHmixZz7nlK2sBcEOMTF9Ck6wR85O/xbui6phk8er4hbeDcU5DA6PpigXQhEYtqOow4S5FTMtq+p0UeHaW7NKMIQvX5r9S7z1NZ7S2iaIxpHKukLSsJH3fq3KsD+Oro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725864849; c=relaxed/simple;
	bh=s90mMIl9Yk0dS3ZxwgoGrwtmHEwr0osOFdbPy6fBLDg=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=bdDhRRdV09lnwII1WXs0xMNu/5PoMoYj/eXSZttori9AQfEpl0HPv1GbLqKSySJ8SNzZC7jmMZ5e01g6TwORQQDfhrPYKfc07gwzct9DQA/3ucNhJ8F25mNFWazYaeRs//GBo+cJ+7BYjfrgpBt/veWGqoOZ9oeRgv6pd4EgYoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S7nrBuv7; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-6db2a9da800so29441627b3.0;
        Sun, 08 Sep 2024 23:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725864847; x=1726469647; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Q7d8zwumBa2mhTup4zQYqTmBFbEzejGeaSSz2DQo8ts=;
        b=S7nrBuv7Wd4RCq6XcJqxFRIiauxhIb8v9qD909mhgONYmYcHnrPrjzWT+9DvPfFGfR
         kQYmUlCT9zDON3gJ23OgKjT11LZ0DeOULUEP79GklmB73s9iythKug/BP63NXxxa510v
         yW6FD9jBVCuGzozi+qYs2uC45W8UioAs5L1UKfzytl4nJIsd69b5UYAYtb29S0ikMtrt
         zeS0MQ4AocgXU81MVJgEdd2q9rCt6o7ekHFhiVia4sggJqulbXsK7pbhFgtsdD09I54G
         XjVWdmyItefW0bst+XHPnRtLyj7NxJoT7lz5eXrx8kB90u7Seq5miv6tdWgPGFjL2Cv2
         6QEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725864847; x=1726469647;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Q7d8zwumBa2mhTup4zQYqTmBFbEzejGeaSSz2DQo8ts=;
        b=Qi1i2q8gC5Savo+4UDnpyEj+E9oRzZ1OaZdo3KE+CiHlRMS+dpS2yIvqhUW6OwUtaM
         oVwcxGXUE2vy3pJBieqmjWwFb1MyuRSh2AwPIIpJk/wK1aE8cEv/zkqIt9WmW/TaAAwc
         2AThN1iMo9LNZVylXVE/Uyd5sk/MCvA8xCnKC+5MAnzpdfzr9SaATLp3pRURQEnf2/XW
         u3a3sc2VQlC1/oJR2/K2MHVHt1aS5LnJJwn3ed6OO4n+Y7HYkDg+0CR4KhetYDW9i+pO
         TAETNq95vW9pEGD3Kw+6rw/cipMoIK76z8PbWgnhQLE46j+YcPsrbSowtaOpoJg/elm8
         60Sg==
X-Forwarded-Encrypted: i=1; AJvYcCVsCNCu1ZmIcSpaYlzyUQ8sn52ZBXmcxq9tkwu6UhJ6HzwZUucfoI8cu6mz4exmNb5RUJPfyu7bnmkhyKg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4mZfOSuf8h8uyFdkJsk/vLtzqUSfBI0T5OzJJ/9EGhiSLND7r
	t2SvrAPOqeAsG0/F6tOFQcyca3vvdXqNfwpiDSFq+4AqaRwTFHPuEYN9Afyf+Eh1PbFid9QipDR
	aqYAuHKisxoF92Vc1PqlFfoelCkAL/j0GdxM=
X-Google-Smtp-Source: AGHT+IGf+k1Qbf5QZG88Dg+4QfNHq6ywW4JlKCO4pQ/VZyLmq0NSpIL5vgjIjpH3e3gxkgq+6y9vc0izdS8MD1vtfww=
X-Received: by 2002:a05:690c:28b:b0:6d6:a5b7:3ff with SMTP id
 00721157ae682-6db26016c10mr136267497b3.14.1725864847299; Sun, 08 Sep 2024
 23:54:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Hugues Bruant <hugues.bruant@gmail.com>
Date: Sun, 8 Sep 2024 23:53:56 -0700
Message-ID: <CALvjV29jozswRtmYxDur2TuEQ=1JSDrM+uWVHmghW3hG5Y9F+w@mail.gmail.com>
Subject: [REGRESSION] soft lockup on boot starting with kernel 6.10 / commit 5186ba33234c9a90833f7c93ce7de80e25fac6f5
To: stable@vger.kernel.org
Cc: regressions@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Fenghua Yu <fenghua.yu@intel.com>, Reinette Chatre <reinette.chatre@intel.com>, 
	Borislav Petkov <bp@alien8.de>, Tony Luck <tony.luck@intel.com>
Content-Type: text/plain; charset="UTF-8"

Hi,

I have discovered a 100% reliable soft lockup on boot on my laptop:
Purism Librem 14, Intel Core i7-10710U, 48Gb RAM, Samsung Evo Plus 970
SSD, CoreBoot BIOS, grub bootloader, Arch Linux.

The last working release is kernel 6.9.10, every release from 6.10
onwards reliably exhibit the issue, which, based on journalctl logs,
seems to be triggered somewhere in systemd-udev:
https://gitlab.archlinux.org/-/project/42594/uploads/04583baf22189a0a8bb2f8773096e013/lockup.log

Bisect points to commit 5186ba33234c9a90833f7c93ce7de80e25fac6f5

At a glance, I see two potentially problematic changes in this diff.
Specifically, in the refactoring to move the call to rdt_ctrl_update
inside the loop that walks over r->domains :

  1. the change from on_each_cpu_mask to smp_call_function_any means
that preemption is no longer disabled around the call to
rdt_ctrl_update, which could plausibly be a problem

  2. there's now a race condition on the msr_params struct: afaict
there's no write barrier, so if the call to rdt_ctrl_update is
executed on a different CPU, it could plausibly read an outdated value
of the dom field, which prior to this series of patches wasn't passed
as an explicit parameter, but derived inside rdt_ctrl_update

For initial report to Arch Linux bugtracker and bisect log see:
https://gitlab.archlinux.org/archlinux/packaging/packages/linux/-/issues/74

Best
Hugues

