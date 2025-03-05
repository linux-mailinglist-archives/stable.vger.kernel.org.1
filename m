Return-Path: <stable+bounces-121105-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BC45A50BDB
	for <lists+stable@lfdr.de>; Wed,  5 Mar 2025 20:47:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D30017A3AA7
	for <lists+stable@lfdr.de>; Wed,  5 Mar 2025 19:46:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FB50253F24;
	Wed,  5 Mar 2025 19:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="wc9itJER"
X-Original-To: stable@vger.kernel.org
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BA77255E3A
	for <stable@vger.kernel.org>; Wed,  5 Mar 2025 19:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741203998; cv=none; b=RK7uu/jsV3e7qY9732iWyN+D0OXEKiZZHro2w30HAy5mn/TxwhBrfAEigDq4Mi7n0+/9iJo/+qiY1+Wjs1Jn8kkDnS0YaBT9xEI6zTua7d4aMm1rgQvFti9B825K9lUDtBMo1nW6oaONFAqm4HqS4g2jYpNILnu2+9si1n3Gjio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741203998; c=relaxed/simple;
	bh=jPA2i+F4hRjHuSWzj2EOMzpztuncA4pQxoasR3d67js=;
	h=MIME-Version:from:Date:Message-ID:Subject:To:Cc:Content-Type; b=u7lkThRsIBNWjyKN7lkhsaPmFV8MlihvbLSD+mq+3QTMSgaadhLXwijsdKPpGBNAX9LYfoGC+Qnct4YOMG5+5Lu4aSPIC+QnWXR8eHAMB1qMWNJ38Vft1noWaaLuc9Ai6fByVzS13he+zvMnewxh71OX5E+ECghM+g3D1KVbTDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=wc9itJER; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e5dcc411189so6310384276.0
        for <stable@vger.kernel.org>; Wed, 05 Mar 2025 11:46:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1741203996; x=1741808796; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:reply-to
         :from:mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=suaL3V2MdE0GYOzY2Sxig0jr7iJ7bfmKLmsYXc76Hj8=;
        b=wc9itJERpJEL4HcAsJFdFpHQijbMBkzG2lPOaRlaZCs7MKOAIsdvrWaXS6Ml37kLP7
         l1a3WtFewezlbYdiWS82afUBjS9GF6MancHt1GlXl5dGeeuPtEmTbwyrKp/VDd8j9WAv
         w69e3rhnis/S2yWWYTnDqUhy0PODcv80wAOfKY1fCXuBIqRqAQY5rgj6ZBS0aOB5lg20
         RFfpnDOO5gYOJW9avb68ONRhZQEkfbKydHsIO3qOaLnq6RHPFgWt8NyJz46n/tn8HPWu
         4FYG9/WYtNi+cAX2ruraylwS7hCW1oXjLmuk1XUfMRKlHefrn3FkNPJ5QIkTrgDZDhwB
         Q+FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741203996; x=1741808796;
        h=content-transfer-encoding:cc:to:subject:message-id:date:reply-to
         :from:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=suaL3V2MdE0GYOzY2Sxig0jr7iJ7bfmKLmsYXc76Hj8=;
        b=rI35EWdLRvIQGNcfPS0wudbHZuAx9JHXkK0BzKLzZQjbdmqP6kGz9gi2mM+yoI2d1+
         NeOrPWsHzDQ+gN/15o4OUo0aYyKbhwS0HOlwa3plAoVzYBovQKqQDhGrvrwVoeh3Da/A
         3N08zBQc8cPSM0UexLz/zjb2cIdHGrh8/k9a7bfGT8CE5AfxUovVbYwb/YQSI1ZZKA0R
         F/8ZLDrkb36SZ2nafttzOHB/4dEV5bVUGQw8MKX3iEv1D6TeTxeLPqPc3nJMHwngMNmJ
         a8PwoVAygP8sHRomCpYtERp4ejvA3tQucKgtrkU+X1ELzsNmiHN416G8lVnfA6bHiGjN
         s5ew==
X-Forwarded-Encrypted: i=1; AJvYcCWC/XwHcHfKK75iHEdBrcro7jWo5yTbm61Lv6RFY0z0SAVaaYCB9p0C8YLfU8R7SEH/D6/HKpA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOibRG2MuPE9FhREU/y3wX+dGp+clt4ONRID0dyS+vGpO7AK/N
	ItbuCyXZVJw0yDt1CmsagAwmpaf/l3/bwNFJ0FzxL4M9t7NR4RjNlA0cTK9Xiqe99qdvc0+Hozb
	GDIRovr1t7sdcK+OeZ2XWvjoHRn1yswmDTk5xRQ==
X-Gm-Gg: ASbGnctSUPBcOwNmoVuSf+F/novPEN0O+OCMJumyyf87pHkpFpR/ghMA4S2ZE2sQ1J+
	nGCrK/eWbTaOSZCnBLN/7KQRjDQb12aN6z+9sg2R3v9vqz8gI1s/1IyJkcl6/I7RMqNq8Z/ndk0
	XyNta83FFZKkKDlCXlJ8S80JUGrjjij4V1vkwTAyxK3HYQ1fYo3CW1wbsfb6s=
X-Google-Smtp-Source: AGHT+IFe9teX/QKXhOJUaYoYSVmbfitnj3x2RJWl6fMePLVzHQNdPT1MPl3xDxIwnYxxVkZ7u7y+mKF3Yhq9HDThSkI=
X-Received: by 2002:a05:6902:2605:b0:e5d:d765:38ca with SMTP id
 3f1490d57ef6-e611e3667e9mr5343591276.41.1741203996078; Wed, 05 Mar 2025
 11:46:36 -0800 (PST)
Received: from 415818378487 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 5 Mar 2025 11:46:34 -0800
Received: from 415818378487 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 5 Mar 2025 11:46:34 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
from: KernelCI bot <bot@kernelci.org>
Reply-To: kernelci@lists.linux.dev
Date: Wed, 5 Mar 2025 11:46:34 -0800
X-Gm-Features: AQ5f1JqmwE3vuXqF7MhxFdAgCzxhtdAHFuEjXRHU9tJTSAaZJ7Pp96bjHp-je1w
Message-ID: <CACo-S-37vvL1ATSu15DH-OeosSwTrbWTwKqQedO_87dHuE_mbA@mail.gmail.com>
Subject: =?UTF-8?B?W1JFR1JFU1NJT05dIHN0YWJsZS1yYy9saW51eC02LjYueTogKGJ1aWxkKSDigJhpbml0cg==?=
	=?UTF-8?B?ZF9zdGFydF9lYXJseeKAmSB1bmRlY2xhcmVkIChmaXJzdCB1c2UgaW4gdGhpcyBmdW5jdGlvbik7IGRp?=
	=?UTF-8?B?ZCAuLi4=?=
To: kernelci-results@groups.io
Cc: gus@collabora.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

New build issue found on stable-rc/linux-6.6.y:

---
 =E2=80=98initrd_start_early=E2=80=99 undeclared (first use in this functio=
n); did you
mean =E2=80=98initrd_start=E2=80=99? in arch/x86/kernel/cpu/microcode/core.=
o
(arch/x86/kernel/cpu/microcode/core.c)
[logspec:kbuild,kbuild.compiler.error]
---

- dashboard: https://d.kernelci.org/issue/maestro:b19e4ff21824fec766ed87bd9=
7bf937236992087
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
- commit HEAD:  9f243f9dd2684b4b27f8be0cbed639052bc9b22e


Log excerpt:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
arch/x86/kernel/cpu/microcode/core.c:198:25: error:
=E2=80=98initrd_start_early=E2=80=99 undeclared (first use in this function=
); did you
mean =E2=80=98initrd_start=E2=80=99?
  198 |                 start =3D initrd_start_early;
      |                         ^~~~~~~~~~~~~~~~~~
      |                         initrd_start
arch/x86/kernel/cpu/microcode/core.c:198:25: note: each undeclared
identifier is reported only once for each function it appears in

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D


# Builds where the incident occurred:

## i386_defconfig+kselftest on (i386):
- compiler: gcc-12
- dashboard: https://d.kernelci.org/build/maestro:67c89ed518018371956c816d


#kernelci issue maestro:b19e4ff21824fec766ed87bd97bf937236992087

Reported-by: kernelci.org bot <bot@kernelci.org>

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org

