Return-Path: <stable+bounces-160092-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E76A4AF7E4C
	for <lists+stable@lfdr.de>; Thu,  3 Jul 2025 18:59:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 179BC18877F2
	for <lists+stable@lfdr.de>; Thu,  3 Jul 2025 16:59:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B855255E20;
	Thu,  3 Jul 2025 16:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="NHQophuV"
X-Original-To: stable@vger.kernel.org
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F57F1804A
	for <stable@vger.kernel.org>; Thu,  3 Jul 2025 16:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751561950; cv=none; b=HgAho+OSmbQwFocLyazrCUAnKgJk3wSkOr4Gii4LyHRDGhUVIxGcqvtN58GKK769Hr1DRSPuq4PBACRtl6OymzF91bzaTa1iTVY/tPu/cDPGLVmovtgx6ALcXseIaPS33QrDmj9HvLP3ar5Io+ogYsy0bA9wKJyhEjxykUNtJ20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751561950; c=relaxed/simple;
	bh=ylI5VYvDZjRFK8s0Iduq7thejZU8uDUQdkChOwziNag=;
	h=MIME-Version:from:Date:Message-ID:Subject:To:Cc:Content-Type; b=i84PBr3IafedtTgHfiFjFHqSE4E8pPHzjEZf6Pw+dg6va0aU06Dw+zZpwnH/UdfImlNQOwMJnCxqDQ6lbBZ05tSpvkliaG/Amd6z4fhr1Wpa2Sd6RuSKTAKNX28Mp27/mRYWOwxUt/UFICAwtABqvsbTIK25ZdpA02SP9WjkbhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=NHQophuV; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e81a7d90835so22536276.1
        for <stable@vger.kernel.org>; Thu, 03 Jul 2025 09:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1751561947; x=1752166747; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:reply-to:from:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G6E/ALTUpGLnpF7QmDUvG1Hq4VjPHdQoeD8N1r8FGuE=;
        b=NHQophuVoS/ZKhP1SU/QIkozDjX+Hi0eAP0wm8rd3+Hmcz8o/Q6+DtK9N+hBrRdX8j
         aXpTss/C5LCDnWgD05YhmsRguenvOrIdv2ZSfUMMoDFhVnHIcbGqobvtASEjMTa3g7NN
         BVJc6ZVtJv8rFlPjwa1EFtT2itboBM1LjT4aPDeN5k9gDUHSsBGJDNhFYj8RyZZP+kpR
         JJl3ysP7TpkdDQ86HjH67p5K5fT384P5gNdF5I5NG1zVfS5szvPJZxAsmUoqAl7kLlJt
         kohcXedU1fIYYyPijd8KjdpsD7DrTC3DVjhrEwkphcZcwYmk9XS96ixbPjLmT7Soa/az
         7nCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751561947; x=1752166747;
        h=cc:to:subject:message-id:date:reply-to:from:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G6E/ALTUpGLnpF7QmDUvG1Hq4VjPHdQoeD8N1r8FGuE=;
        b=OwbruJu1snE/ddDbG92CxxEZXHQwx3f/b3EpNyfM4VGUSwhagBeYr6RYzCJ8nosPjm
         jkSy2+dmfKHuiNU/c4SgO21iMDcG1runiDij0JrX6Q5BAB7p5CrjVYNTK4hP7mqb3x+i
         PXjECUTEx/Hsme2z3V/HNucjPmFN3sDpbcGuXCxpm1PL4LKMINIjBq/sRi8sApVXOgFX
         wJMV+QOppD4I0ZJP4jUHSUETBHIq82LGTkDyZpUXC2U3RuTJ0IEJ1hqe6we6QHU28kk+
         H3zxH+1RzaFog0dzff9uiB0CE4HiQStv/kN+437W8ey3fdWEfrlIoIf06MrFuy8ZKczj
         L74A==
X-Forwarded-Encrypted: i=1; AJvYcCWnTBuc37/eGizlAWAcUJdIK5m0oUdv1kixTGFm6VsaKI+WKmC6eK3eTyoBDflQYjWBzZv9r9w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxN7wpr06Hz5YGGCF6cz2cBdPeGfko9hkgtO0DgVc9Yt5x6kK/a
	7N9iDoBSQCguEiFai0d6arUKNXeA2idPGRhddC23ZPYcF8K7mrZdzl/KChRua8xyJS/SnCsuG1G
	K8fyS9Xttmu+EnIZScupEo9ihfN0uNUke3rjpctT6hw==
X-Gm-Gg: ASbGncu2ZUeQOrfNn/0/uPbPJkqVg/lhsqry29Oz8PMWHcmCZI/N/CkosRaQSbD6S3l
	JJAChNA/2bOzsIdGDWP2gcFLPnMwF/n0fnbeZ63TCgbjaIfyETXWxdIY/5o7lodHlTCXhgpe74f
	6yLeVObTm5v73S2VSMvyKsxdkTDjmrVmEnuJvGACWwug==
X-Google-Smtp-Source: AGHT+IGnFcwJEnQZpM5vSbep8UXdrHK6lPsB/9VSK5cgUjNriOGSEcYx0qoX1tVQ+uSCYYtqlXuc7N7BuVEHMJpVrW0=
X-Received: by 2002:a05:690c:30e:b0:707:dba5:2e44 with SMTP id
 00721157ae682-7164d46e77emr110345567b3.30.1751561947108; Thu, 03 Jul 2025
 09:59:07 -0700 (PDT)
Received: from 415818378487 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 3 Jul 2025 09:59:05 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
from: KernelCI bot <bot@kernelci.org>
Reply-To: kernelci@lists.linux.dev
Date: Thu, 3 Jul 2025 09:59:05 -0700
X-Gm-Features: Ac12FXwWAxA36ObRrMN4k2a3prp-Ne4jvZSkP0WSR2Slxytla4iWimqUKy2juQ8
Message-ID: <CACo-S-2xtJFkfrZOC1KEYHQDatP9Pn1GE4_jriuyM9x1hDE9XA@mail.gmail.com>
Subject: [REGRESSION] stable-rc/linux-5.4.y: (build) ./include/linux/regulator/consumer.h:613:51:
 warning: declaration ...
To: kernelci-results@groups.io
Cc: gus@collabora.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

New build issue found on stable-rc/linux-5.4.y:

---
 ./include/linux/regulator/consumer.h:613:51: warning: declaration of
'struct regulator_dev' will not be visible outside of this function
[-Wvisibility] in drivers/ata/ahci.o (drivers/ata/ahci.h)
[logspec:kbuild,kbuild.compiler.warning]
---

- dashboard: https://d.kernelci.org/i/maestro:e328869b26a76c83d9b30c60ae3469908d116c3f
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  f4010b99ef529ae2ba2db6f124d91a187d5e23ed


Log excerpt:
=====================================================
In file included from drivers/ata/ahci.h:25:
In file included from ./include/linux/phy/phy.h:17:
./include/linux/regulator/consumer.h:613:51: warning: declaration of
'struct regulator_dev' will not be visible outside of this function
[-Wvisibility]
  613 | static inline int regulator_suspend_enable(struct regulator_dev *rdev,
      |                                                   ^
./include/linux/regulator/consumer.h:614:9: error: unknown type name
'suspend_state_t'
  614 |                                            suspend_state_t state)
      |                                            ^
./include/linux/regulator/consumer.h:619:52: warning: declaration of
'struct regulator_dev' will not be visible outside of this function
[-Wvisibility]
  619 | static inline int regulator_suspend_disable(struct regulator_dev *rdev,
      |                                                    ^
./include/linux/regulator/consumer.h:620:10: error: unknown type name
'suspend_state_t'
  620 |                                             suspend_state_t state)
      |                                             ^
./include/linux/regulator/consumer.h:627:7: error: unknown type name
'suspend_state_t'
  627 |                                                 suspend_state_t state)
      |                                                 ^
2 warnings and 3 errors generated.

=====================================================


# Builds where the incident occurred:

## x86_64_defconfig on (x86_64):
- compiler: clang-17
- dashboard: https://d.kernelci.org/build/maestro:68669dc85c2cf25042fb8139


#kernelci issue maestro:e328869b26a76c83d9b30c60ae3469908d116c3f

Reported-by: kernelci.org bot <bot@kernelci.org>

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org

