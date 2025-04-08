Return-Path: <stable+bounces-131771-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E36DA80F1C
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 17:01:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9102416CB96
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 14:59:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 150A9218584;
	Tue,  8 Apr 2025 14:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="Y1hwHZ1U"
X-Original-To: stable@vger.kernel.org
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDA501DF749
	for <stable@vger.kernel.org>; Tue,  8 Apr 2025 14:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744124349; cv=none; b=jYQl6yyS8CCRI66RFWqVScXgFKzkfZuThPbPhF2CKbIiHxYo2et8swasAa6VXJp5MfJYve4DphJR+t51O3A4kMDfrigoi2roJzCpjqqmlbQZ7blAE9eltL0F8MJPpqhWHKjSR4leQfq07nH3y8qVJAF1YRpo2vBcp/vq9WrjNXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744124349; c=relaxed/simple;
	bh=IbcYRH62SKTcHVpPSWKMsMk+Afut+PEIm8FeltxsHgE=;
	h=MIME-Version:from:Date:Message-ID:Subject:To:Cc:Content-Type; b=VJzI0wz+Ip7CBwbDqbkpjGZZKlvNEqQMhM8cVXdjyZZA1vjczh2KNKtCr+h0pW/QjVqUvR8pENU/6RXHm34Fk0wkYEwnDQj4HqWDWb2ycjH0WdOyRd2sMvXDqrUgSd5uw+PwdGcrwjcOmxl3iZXb6JRHv1a8EqLpKrwzFwVoEkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=Y1hwHZ1U; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e6a8aa771e8so4833123276.3
        for <stable@vger.kernel.org>; Tue, 08 Apr 2025 07:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1744124347; x=1744729147; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:reply-to
         :from:mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DWOlthETPvb3V9XMs3bIRH6muRPWH/+pRKoFmTQKLpc=;
        b=Y1hwHZ1UYVlQNVVUM1+yL/8Z7EjjJXOC99xT8hiMUU8kd6Mf66LPNiT3bdP7bM00ai
         1TeCKHE8uPIOtDq+dP+gZnQJy65OZMmGO7iuqqWuVYXheM/WpP0C+OUz3MSTv8Q9JD4p
         HrLIAT0bhqXOShsuuTKb6387M8My44fjWe1pqJctszYh/t6wFekyqKhpiDLImgLQaI1n
         tKm1Wwreb6zwVMdUA6E3vczqVewkMuQvH2DMltfxiEtgX1KuEpZiQal3qVQNQQK1Iv8m
         SVlJMJ2AmCXeBykXNwFgngko79xEKdKiyix/ZmEq0z9jcoxIz9/IJA+0VEoSiJLqvR4e
         WWAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744124347; x=1744729147;
        h=content-transfer-encoding:cc:to:subject:message-id:date:reply-to
         :from:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DWOlthETPvb3V9XMs3bIRH6muRPWH/+pRKoFmTQKLpc=;
        b=OgWMdhx0JjnWaJ+kYsP5TlU6qk6UQLf5iWpzRUmT2Vcl083UEMQvRAXymLSEFgb9DI
         Ce82TysT7miW0YFb+eiExz7szRCgYyj6IkYo6VGwxaDPlEVmQwjP2iDlZ9CkO8qI95tc
         pRfOOR1+GozARzEld4UCoA5/EP5Lc0CXKNirG3Yl9uboG7qDsnF2O+Xj9aGCAtLijxPn
         2vmq7Nifs5vYQpKGLRzgz1A/oMo8x4eooMNl0Ql/PuhCfuFmwxkLkNYAJvMTAgjjHKE1
         tTY0cKzIXweQ0PFQOGAgD/LxuRjvjImMCTbrfqppIllOwOR03E6yCCg05d3VIPWeRBqh
         pLew==
X-Forwarded-Encrypted: i=1; AJvYcCVWKZ6TELlfsl7LbsTpZSVSHTSm/9tx+rJ9CY6YlMGvra0SqhO0Om8WlU44zlaFK4Frx3LR2E0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0Bd6A+nnTeMI1INxnHAoEIwAWXP6vx5euPUFCf+lBYbz/OsyR
	C0oC+jWntXcV7f9K+xhgebmIVt0Iitc197E+NS1BYQjtEGsjCtfl8Bc8QrL2yojEY2GlvQKcjjB
	V6n2SvZKqeR9zsyp2+Cri0Ko2GUnufUUTKqdEZw==
X-Gm-Gg: ASbGncvO5TdrqlfJFGUOlqiNrnT1qHxKAa1VQa+4q4Af+Rhk04p4/AU2yq1wTjoTHz/
	xeOtEKlozOKxZp20iQirT0oABsR3atF5/mqgWDOTGWv4DVizStADOjWZORifoeDlXoX7ghzByrW
	5CxUxEn+LeRR4VS0j/+FaeWzhA
X-Google-Smtp-Source: AGHT+IE42rHcBHiXJkkRKqUWKwkpAK0omF8bVC/d9tsGyoObQAYnRwkLAXoSp/UXs/1PnbCtmRz+ebBwjwxJ9Z5a9ZA=
X-Received: by 2002:a05:6902:480e:b0:e6d:f157:c601 with SMTP id
 3f1490d57ef6-e6e1c29af83mr24917953276.17.1744124346757; Tue, 08 Apr 2025
 07:59:06 -0700 (PDT)
Received: from 415818378487 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 8 Apr 2025 07:59:05 -0700
Received: from 415818378487 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 8 Apr 2025 07:59:05 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
from: KernelCI bot <bot@kernelci.org>
Reply-To: kernelci@lists.linux.dev
Date: Tue, 8 Apr 2025 07:59:05 -0700
X-Gm-Features: ATxdqUGEZGNxGIRmrGbXJyEmwsYWfk4vdAGagCU6BM6CX9EoBpIQZm_Hs3o8ahE
Message-ID: <CACo-S-0-PUaB6MtRO4OBPyW1Bh8Tztwm5OjMmqRfUxWxwXkcLA@mail.gmail.com>
Subject: [REGRESSION] stable-rc/linux-6.12.y: (build) in vmlinux
 (scripts/Makefile.vmlinux:34) [logspec:kbuild,kbuild.co...
To: kernelci-results@groups.io
Cc: gus@collabora.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

New build issue found on stable-rc/linux-6.12.y:

---
 in vmlinux (scripts/Makefile.vmlinux:34)
[logspec:kbuild,kbuild.compiler.linker_error]
---

- dashboard: https://d.kernelci.org/i/maestro:044a06526d293c2801fdbdc2f440e=
46bd3b51a52
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
- commit HEAD:  8e9508dd93587658f8f8116bc709aeb272144427


Log excerpt:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
ld.lld: error: ./arch/arm/kernel/vmlinux.lds:36: ( expected, but got }
>>>  __vectors_lma =3D .; OVERLAY 0xffff0000 : AT(__vectors_lma) { .vectors=
 { OVERLAY_KEEP(*(.vectors)) } .vectors.bhb.loop8 { OVERLAY_KEEP(*(.vectors=
.bhb.loop8)) } .vectors.bhb.bpiall { OVERLAY_KEEP(*(.vectors.bhb.bpiall)) }=
 } __vectors_start =3D LOADADDR(.vectors); __vectors_end =3D LOADADDR(.vect=
ors) + SIZEOF(.vectors); __vectors_bhb_loop8_start =3D LOADADDR(.vectors.bh=
b.loop8); __vectors_bhb_loop8_end =3D LOADADDR(.vectors.bhb.loop8) + SIZEOF=
(.vectors.bhb.loop8); __vectors_bhb_bpiall_start =3D LOADADDR(.vectors.bhb.=
bpiall); __vectors_bhb_bpiall_end =3D LOADADDR(.vectors.bhb.bpiall) + SIZEO=
F(.vectors.bhb.bpiall); . =3D __vectors_lma + SIZEOF(.vectors) + SIZEOF(.ve=
ctors.bhb.loop8) + SIZEOF(.vectors.bhb.bpiall); __stubs_lma =3D .; .stubs A=
DDR(.vectors) + 0x1000 : AT(__stubs_lma) { *(.stubs) } __stubs_start =3D LO=
ADADDR(.stubs); __stubs_end =3D LOADADDR(.stubs) + SIZEOF(.stubs); . =3D __=
stubs_lma + SIZEOF(.stubs); PROVIDE(vector_fiq_offset =3D vector_fiq - ADDR=
(.vectors));
>>>                                                                        =
                           ^

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D


# Builds where the incident occurred:

## defconfig+allmodconfig+CONFIG_FRAME_WARN=3D2048 on (arm):
- compiler: clang-17
- dashboard: https://d.kernelci.org/build/maestro:67f50be06fa43d168f278ccc


#kernelci issue maestro:044a06526d293c2801fdbdc2f440e46bd3b51a52

Reported-by: kernelci.org bot <bot@kernelci.org>

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org

