Return-Path: <stable+bounces-196833-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B01EC82F6F
	for <lists+stable@lfdr.de>; Tue, 25 Nov 2025 01:59:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE26D3ADD3A
	for <lists+stable@lfdr.de>; Tue, 25 Nov 2025 00:59:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDF801EB5FD;
	Tue, 25 Nov 2025 00:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="Fan+I/AL"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F27121B4F1F
	for <stable@vger.kernel.org>; Tue, 25 Nov 2025 00:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764032350; cv=none; b=TMmbWTsS6d2qax0tATq9tcl7NYr8+v6IoXP3CKbhoHlt3q8JCbk2vG0bI94djLa1NOASyO86bShsM7d1hLlI86dlXkvt8RiJq2RkQg8CxKChf4zRZhqAI1TgHJUfeJejo86bjXkZl4RdIeVdid6qLOAvjJaZPDSc9uWGKaerLiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764032350; c=relaxed/simple;
	bh=53CRrf0jGuwB03yFltWzcJNvnk1rJ0WvgrMeNLTu698=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=Fw6wOExlt+YGVvsos1gvhpgM4BEGNxx1v4hnOkS4wCqqSvqx6ARLItdcpFAD1cuKj7HHwkfpnGD4kNNgP1k06cs3MlKpiW086GRJtW0v1r83hL+cGopEgBGYUgjOIeFdJIzeRrU47X5g7o2JaUCCuoSi9UHDtp4uU0YWOz3fLwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=Fan+I/AL; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7ad1cd0db3bso4209041b3a.1
        for <stable@vger.kernel.org>; Mon, 24 Nov 2025 16:59:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1764032348; x=1764637148; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j2i98mUbwvJZAUStTDatdB+yA+uOoCAUJ/CdcxmChEQ=;
        b=Fan+I/AL6FfwCKbUxnGUXdvPmkyQLjXL5nalWlXm/pwMxHkB3iwFQwor+nRiq00gxZ
         RwxpbY81zGo3zF8djeRO1ffACaeeSq6TD1cbClDcP9dGS4R8cNaFCJUrLARt8qk1KwdC
         noGVTcuvudGWjm2mYKUv0369qcT4+Pdps5EEeaohGmbxaLRfqvVGWtsj6aePH2bhrkm1
         Rik99HfiVblKfStbqMtGiTyp5HYFaF6Ae6xLGzyDaj4cnvVM8qXhSJQ26uD3sfj0F8Uk
         KRmS03cZwgs/rv+eAh8tGUsy/f+FHVDWnLOVcXhffKjL8H2jW1DUbZQ/Sc4Y5KzBkeQ1
         ydOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764032348; x=1764637148;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=j2i98mUbwvJZAUStTDatdB+yA+uOoCAUJ/CdcxmChEQ=;
        b=dugN8R80lg9HvaxndEcsGkULA1grX5WTERSBBaGitLCdr0k8PbG2ea43h9u2kCLrYh
         f8ahAsorKIxsPctoFCTus4YJQ0qEnqngQdoyeebdo+MWxhyvWZ05fMsvez2aSN3XMXeW
         DkKfoMOboHL/1djI5G7VC41sdrmJuvoFSF+BnxAIRIAkbJPyNEKHG9Uecq/pSZXE/Fd+
         vF1lDKkioo5yOH7A/XDqH0zvqq4NekY3Ua+CrV57GJDANeITJuk5mKim/PFwSwlJb4um
         zVOdQLLeq/5y1WA1QkBLDi/v6aBShTn1z98LOQjtXA84OPdqAyp5l+Z3REC6VCyw/dfV
         okCw==
X-Forwarded-Encrypted: i=1; AJvYcCWS83iQzruuHSXBEBg2GfxRiLVxP8NfVLx9ta0FxyVTYa+3b8T41YX4aM69ewulBU1c+QtXr7w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPIyZW0pFnh6dPcxynCDeHlJIEl3cq4+ru+p2ZZmjX5ZIkGqPn
	RqFb3OcaXCjDPcZ4MmjUPoGGOCcStOmXvR9UzEmWlUCxspD4Mh+766kLNtNsrMbKrc4=
X-Gm-Gg: ASbGncvr48Paue3CnjuYFmvowndrz2TWLA/m2u4tlgQ5tVnwYXjWpibRb7FRneu6s/R
	RNqJNGDJaUTJ99VcqcRIRsn3WtEz3FQ4BHq4sqp+FDrMbpVhH3I9JXblm36qU3OTPMKWO1uhqKJ
	XRjzEFmA5T29iY35vjjA5RioUud/R5fWAQ//kVmJJruaZh660p7gzYCVaiMYpz132GcfEcRE5IA
	8+TERh7O4fEBzJTZ7ehFUZTYPpvJ3GNpqKACUW27Pv0DPQs9kIoM5xsA6IgtnxjL7lxzN7ezKLK
	TDHX9SnBbh+dmNR8IRg9N6SjVBru4F+0jz6Gtghta/ploIjdA8CF/VQU6w9XsN/q8dNQSfSIHox
	nFbg6zneHXb4PedwiU05KZ50k3mC82gta28hfap4+IkKPRTBFpWUmjSzafyfSmzXL82lfzY14wE
	/2m7M4
X-Google-Smtp-Source: AGHT+IGzRx4kNA5iRNrLNjPSjNdzq5SADsaSIfE2dFmJzbipA95JuCbF+EduvAdShgNLUFmy1CSreg==
X-Received: by 2002:a05:7022:4191:b0:119:fb9c:4ebb with SMTP id a92af1059eb24-11cbba47b12mr733774c88.30.1764032347994;
        Mon, 24 Nov 2025 16:59:07 -0800 (PST)
Received: from f771fd7c9232 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11c93e3e784sm55373479c88.5.2025.11.24.16.59.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Nov 2025 16:59:06 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [REGRESSION] stable-rc/linux-6.7.y: (build) default initialization of
 an
 object of type 'struct kernel_param' ...
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: gus@collabora.com, stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Tue, 25 Nov 2025 00:59:06 -0000
Message-ID: <176403234572.318.6770836871469885793@f771fd7c9232>





Hello,

New build issue found on stable-rc/linux-6.7.y:

---
 default initialization of an object of type 'struct kernel_param' with const member leaves the object uninitialized [-Werror,-Wdefault-const-init-field-unsafe] in kernel/params.o (kernel/params.c) [logspec:kbuild,kbuild.compiler.error]
---

- dashboard: https://d.kernelci.org/i/maestro:b49cc34e36d28dfb446fecde078c599d5e502b0f
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  dacf7e83da42bd9d3978560e41869a784c24d912
- tags: v6.7.12


Log excerpt:
=====================================================
kernel/params.c:368:22: error: default initialization of an object of type 'struct kernel_param' with const member leaves the object uninitialized [-Werror,-Wdefault-const-init-field-unsafe]
  368 |         struct kernel_param dummy;
      |                             ^
./include/linux/moduleparam.h:73:12: note: member 'perm' declared 'const' here
   73 |         const u16 perm;
      |                   ^
kernel/params.c:424:22: error: default initialization of an object of type 'struct kernel_param' with const member leaves the object uninitialized [-Werror,-Wdefault-const-init-field-unsafe]
  424 |         struct kernel_param kp;
      |                             ^
./include/linux/moduleparam.h:73:12: note: member 'perm' declared 'const' here
   73 |         co  CC      arch/x86/xen/setup.o
nst u16 perm;
      |                   ^
  HDRTEST usr/include/linux/net_namespace.h
2 errors generated.

=====================================================


# Builds where the incident occurred:

## x86_64_defconfig+allmodconfig on (x86_64):
- compiler: clang-21
- config: https://files.kernelci.org/kbuild-clang-21-x86-allmodconfig-6924fd8bf5b8743b1f5fa868/.config
- dashboard: https://d.kernelci.org/build/maestro:6924fd8bf5b8743b1f5fa868


#kernelci issue maestro:b49cc34e36d28dfb446fecde078c599d5e502b0f

Reported-by: kernelci.org bot <bot@kernelci.org>

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org

