Return-Path: <stable+bounces-136946-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84B55A9F901
	for <lists+stable@lfdr.de>; Mon, 28 Apr 2025 20:59:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CCC23B7EE1
	for <lists+stable@lfdr.de>; Mon, 28 Apr 2025 18:59:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81CFD296145;
	Mon, 28 Apr 2025 18:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="vrsG1D0o"
X-Original-To: stable@vger.kernel.org
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF172296D19
	for <stable@vger.kernel.org>; Mon, 28 Apr 2025 18:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745866752; cv=none; b=ixo0Rn+nI3eixkdfWRLEmCoCd8KRRzl1iel3iYpg/kX+nuC5aMYq2ejAMLoQen6k8iamy7AJdAc8Y6t842TRF7Y+SuyptaGrv/Q+fQCFTY3dJS5QX6wnGAJncK2T5xTMqraag1QWdY+gMhdSYF+9sVOpaxUJuj5kkmB/NxnD+CY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745866752; c=relaxed/simple;
	bh=cr34As6DU+qHZdHhf4Jk3ppqBTgMOFb36om0DtT/+0Y=;
	h=MIME-Version:from:Date:Message-ID:Subject:To:Cc:Content-Type; b=EpjxHGqqI5eQzAjtSBqsPT8kZwAXLjvvuNzt/LISxmvNDOoIjnyZ2eY5nkxL+aHxP/GRoUhk7wG6sPBajVSZtFc+wL5SAXb6fLkC0E4xhLD0aV5sPsg1g5GMr+3RHVRtRV8ogyFB8EbrH/zVVhj8tm2l/jO2QY6V8/T+xGZDnPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=vrsG1D0o; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-e461015fbd4so4296701276.2
        for <stable@vger.kernel.org>; Mon, 28 Apr 2025 11:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1745866750; x=1746471550; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:reply-to:from:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j7SACblqqF38+Sui/WvtkCdgB551H5+uVLC+qG9G6ys=;
        b=vrsG1D0oPHM2DZY1XC5ZlyvzpM+3zMSCjMh0sAUhsU6PYCFVxaJIuX94SF7ITv8V3R
         g5iSj3w2rlTOG0dv+hjB8yTIJDp9jsUTAB2doQnITHnamDdlcLQXsZnKicMFXWNi+wLy
         AkG79lNBDg1YOshB7HcDLu0MFJujcffyAA8+I71MXhUBT/ifp83cHgrmfupbT2LEwF0I
         u5IlfEV8NN6go69jipFXvZs/KUFy87DtduDLIvE61g7aXc/JCJ+Fs6UED+xlnzISdUVm
         DaL65CmlFV84OslCph6pueoToHZi1gZYmqJdPymDEpiifRz7GBhSS+l7okyfpzf03izw
         UeKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745866750; x=1746471550;
        h=cc:to:subject:message-id:date:reply-to:from:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j7SACblqqF38+Sui/WvtkCdgB551H5+uVLC+qG9G6ys=;
        b=QPb7NDrkcsax2BvdgdWpizBC4PL4Sm3zlY8S1qIXOBjZwV67rWib4ZfEYvKSLNvyQk
         pFXzf1kkcppcvGSDjHxo7LG4UfpNaSMQptM/kg8lUgpD/lbucx+f7AdBM7w+HNu8rbVh
         6nBSwYf+0jCdtQrWC3y3a/kzvbrstXWscaSDI0Mb8XKrRfzqFWANIf8AtIQp/5fhfBmO
         cTSMQ1r83zcs/9HX2dSSPMqo+g6VaZEbqQnFwEofeTxovzxrh/v4ZppPdz2kGIsCSVCP
         q8Bo5U3CfIti0Sseg0cUAhN9lMZFKvEKdMHi2KrDuDYR+27PyCcKfJyXpBfs9a0nMVLq
         Rdxw==
X-Forwarded-Encrypted: i=1; AJvYcCWyLjsgvJ4b2OzYtgTSNiGfwssFGcQcYT9PGZYrPcvNUhxZWnGenNMwdWPBMGgSJX44d40f+XE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSZA/oTipNtnFdAmm6wloIopK/v8DTuLpamoX9uy9T1hGEGn6L
	OiIEQylXBu8ghQtEPwdqWRbDZ6rF+5dQPEo6apI366lWqlkWid2lAD77JxdCrlqUhqb51/0lkHc
	G+Et0fAlsMYE3fRDibcF6hg55MMcvEXCOnP2v1g==
X-Gm-Gg: ASbGncufT19YNaHS+rHh5W/SJaFqAilIdJdqI1mpoi58uqmkOdEqnFivlitsY5RSCMl
	KkIbdhkfBzRfqX6j6GVBVtkiTQ9znH2dIN8nHAUo1hLv38R/DFynQckKDRbkE2DiyblYh78ARQ2
	FYU11ADQAhp2/xOKqzicSO
X-Google-Smtp-Source: AGHT+IHjkRtThRM1THXHxDME/a6nNmFALedSBejL9jiPxgIGPaYa/FavlLsY0ADp4yWBRyvfZGBdztjGzPHLWqPbgiI=
X-Received: by 2002:a05:6902:5406:b0:e6d:e985:5eb1 with SMTP id
 3f1490d57ef6-e732343c04dmr10829982276.38.1745866749800; Mon, 28 Apr 2025
 11:59:09 -0700 (PDT)
Received: from 415818378487 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 28 Apr 2025 11:59:06 -0700
Received: from 415818378487 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 28 Apr 2025 11:59:06 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
from: KernelCI bot <bot@kernelci.org>
Reply-To: kernelci@lists.linux.dev
Date: Mon, 28 Apr 2025 11:59:06 -0700
X-Gm-Features: ATxdqUHnXL5TZpIioMKAizEPOFd6LIf6nDWeFgNbNtFVoyDwDb_gSw4R7xQpTlg
Message-ID: <CACo-S-1zxbU=JYsWVbSbeC1ZHPS-NYNv+W-x-iJb6EwdWVuZBg@mail.gmail.com>
Subject: [REGRESSION] stable-rc/linux-6.12.y: (build) expected ')' in
 .vmlinux.export.o (.vmlinux.export.c) [logspec:kbu...
To: kernelci-results@groups.io
Cc: gus@collabora.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

New build issue found on stable-rc/linux-6.12.y:

---
 expected ')' in .vmlinux.export.o (.vmlinux.export.c)
[logspec:kbuild,kbuild.compiler.error]
---

- dashboard: https://d.kernelci.org/i/maestro:4c5b6ca45d520d28e9cb7711bd71952a44f4db34
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  0f114e4705bd70a1aade95111161a0a24a597879


Log excerpt:
=====================================================
.vmlinux.export.c:1649:33: error: expected ')'
 1649 | KSYMTAB_FUNC(bpf_map_get, "", ""BPF_INTERNAL"");
      |                                 ^
.vmlinux.export.c:1649:1: note: to match this '('
 1649 | KSYMTAB_FUNC(bpf_map_get, "", ""BPF_INTERNAL"");
      | ^
./include/linux/export-internal.h:62:37: note: expanded from macro
'KSYMTAB_FUNC'
   62 | #define KSYMTAB_FUNC(name, sec, ns)     __KSYMTAB(name,
KSYM_FUNC(name), sec, ns)
      |                                         ^
./include/linux/export-internal.h:41:5: note: expanded from macro '__KSYMTAB'
   41 |         asm("   .section
\"__ksymtab_strings\",\"aMS\",%progbits,1"     "\n"    \
      |            ^
.vmlinux.export.c:1658:42: error: expected ')'
 1658 | KSYMTAB_FUNC(bpf_link_get_from_fd, "", ""BPF_INTERNAL"");
      |                                          ^
.vmlinux.export.c:1658:1: note: to match this '('
 1658 | KSYMTAB_FUNC(bpf_link_get_from_fd, "", ""BPF_INTERNAL"");
      | ^
./include/linux/export-internal.h:62:37: note: expanded from macro
'KSYMTAB_FUNC'
   62 | #define KSYMTAB_FUNC(name, sec, ns)     __KSYMTAB(name,
KSYM_FUNC(name), sec, ns)
      |                                         ^
./include/linux/export-internal.h:41:5: note: expanded from macro '__KSYMTAB'
   41 |         asm("   .section
\"__ksymtab_strings\",\"aMS\",%progbits,1"     "\n"    \
      |            ^
.vmlinux.export.c:1660:34: error: expected ')'
 1660 | KSYMTAB_FUNC(kern_sys_bpf, "", ""BPF_INTERNAL"");
      |                                  ^
.vmlinux.export.c:1660:1: note: to match this '('
 1660 | KSYMTAB_FUNC(kern_sys_bpf, "", ""BPF_INTERNAL"");
      | ^
./include/linux/export-internal.h:62:37: note: expanded from macro
'KSYMTAB_FUNC'
   62 | #define KSYMTAB_FUNC(name, sec, ns)     __KSYMTAB(name,
KSYM_FUNC(name), sec, ns)
      |                                         ^
./include/linux/export-internal.h:41:5: note: expanded from macro '__KSYMTAB'
   41 |         asm("   .section
\"__ksymtab_strings\",\"aMS\",%progbits,1"     "\n"    \
      |            ^
3 errors generated.

=====================================================


# Builds where the incident occurred:

## x86_64_defconfig+kselftest+x86-board on (x86_64):
- compiler: clang-17
- dashboard: https://d.kernelci.org/build/maestro:680fc29843948caad95c14ba


#kernelci issue maestro:4c5b6ca45d520d28e9cb7711bd71952a44f4db34

Reported-by: kernelci.org bot <bot@kernelci.org>

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org

