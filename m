Return-Path: <stable+bounces-161329-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51D3DAFD5D5
	for <lists+stable@lfdr.de>; Tue,  8 Jul 2025 19:59:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 464213ACB22
	for <lists+stable@lfdr.de>; Tue,  8 Jul 2025 17:58:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 028742E7173;
	Tue,  8 Jul 2025 17:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="zQwQllQ+"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EF482E6D36
	for <stable@vger.kernel.org>; Tue,  8 Jul 2025 17:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751997551; cv=none; b=laRpW9KnQdx5EKVAWPZzM8x6zskj8b2tV7QJ8yIl01jZG/LyQ8iUwKkiy0I1uicdD1mL87+yZ711tzhI3mYae8GYbIgPA9muZ2eHDSQD4+cgv5sFttHLa/ZgT/GrT0HRAbFnwlBRkidvNZJUDLc6xkzWm41nSJeyBI5eBw4FJlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751997551; c=relaxed/simple;
	bh=XWqHh9T/eyFrIpnkFaDisoXS61LcLHZxmJtBx10ppeA=;
	h=MIME-Version:from:Date:Message-ID:Subject:To:Cc:Content-Type; b=mW92c7bXNM1jci7oCh3vLy++Nu6gqHw5VW0Nk4MFDH2ZJHWX5aQ6Opr7ki2j0hjQe+fAfJvnTx/30RegP3zIRPUZaFsCo9QRaY4TQCb5kmBXkKlSlSEhXY0yOKgIo+J6mAIifVm7bivQxwO4EbVHCudVK93mK00SuY5vfcsU1F0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=zQwQllQ+; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-70e5d953c0bso50673427b3.1
        for <stable@vger.kernel.org>; Tue, 08 Jul 2025 10:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1751997549; x=1752602349; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:reply-to:from:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fz7vQEbYUFCwVD5sBoEsgbsQuIEQCPbOivzmU2D7EWA=;
        b=zQwQllQ+kcGBrgiCqwqcixaf4/zMNdBc901plbyWa+6Ociopz7/e9at7sxFgm0NldM
         lwt1AlHGSY9ujJCoJru0j5J00PQwYbsgjKSyhNWydUlRmpbYaGoVzZutHyFjvZVeOkE9
         P/kjimk8n1kAyRMKj6FI3j+3v9pGvjmBr4wFDOmG2+VOoSF0qFwd+VQj+3s//IzBxGIq
         4wKcBCjhsTtx7qnFZely8Ufky4MfJ0WSaINK2Y0L8abG5F+vFChwfkV8mTYPlwxSM0Ty
         cjC8vLUwtbN6mAW4P7PHDkO3BA8fVmEIT/FViaPAl/6eC5zBJ6iq7UumL+6Dxg1YKna5
         BQCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751997549; x=1752602349;
        h=cc:to:subject:message-id:date:reply-to:from:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fz7vQEbYUFCwVD5sBoEsgbsQuIEQCPbOivzmU2D7EWA=;
        b=vk33ccuTXCLZKjwKpsAstTczUDUX0wxE7KVqFPa0my47FIjuBbVMzrRIiWSinAuNQz
         N8hGNVcwNr1P+wKS6bTCWCDxjUDqU1Vz5fiWy+MTBT4uTzsbD2CzrynmrAuYZQqtXaMG
         bBJmSspl2gFQP5szJpjaNoX/qfDq4qfdhK/JWoRhMX724vsb3eOYOXfXaGx+L4zYirHC
         zqIjgru0l3kNk8bONSyxxG3OgbiDFbqcHB99oar4qvj+ZJjzfVkVz3oXkiwAoF92TKb0
         EkNLM5tiAR8g/9m3I1ZhlxuNxJphtpN564CnxYUl/fFBvRhAMv+dblqfNhF56NTqmz2Q
         yJZQ==
X-Forwarded-Encrypted: i=1; AJvYcCVueGU+J0viZjRWEzVucryOHR+gm9VxmIsJVVTwZrejbqMIec/SBhOsrMb49YVOP8unWdtz0Wg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2LZPnqvG5K9y5tbPaHUVQLm8K4DooGZtgsMgBQAXIqSJijMmj
	a4pYOokgvhxMLg5cqih9e9j6yTGShbzIjaawR6kpaLeA9TLhjvWOYVzJtcBAH/tqiYZJBkyJk2U
	HoZrSS8b8tatxfObkw8cHeYmfEwBncVqFiaK9mxzO4Q==
X-Gm-Gg: ASbGncv7gQpBOeN//5MpCu/x/OEL7u3BGwrNeMufaZi5PkZqNk3yH+0ip0/5P5ja5OQ
	DsDerLddkQ335dd0Q+gYETQvLl+Ir4nYPPAbJtnSzfIiYfnTlzuCVVUdOO/gLM7mz+vDvS+YkCy
	XuCnkEV0JOJD0U4Mib7htlFRJ8lLzInjCeRH9dlerd6A==
X-Google-Smtp-Source: AGHT+IGOnts6pTkMhhdvz4zL7a+IMUY4lBg0w8O9uAu6HnHCEGpzL4pPyMpIsbCKfI60XyQNK4YSWI+vumX378BOF4g=
X-Received: by 2002:a05:690c:3707:b0:70e:711f:43bf with SMTP id
 00721157ae682-7179e421805mr75697097b3.20.1751997549245; Tue, 08 Jul 2025
 10:59:09 -0700 (PDT)
Received: from 415818378487 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 8 Jul 2025 10:59:07 -0700
Received: from 415818378487 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 8 Jul 2025 10:59:07 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
from: KernelCI bot <bot@kernelci.org>
Reply-To: kernelci@lists.linux.dev
Date: Tue, 8 Jul 2025 10:59:07 -0700
X-Gm-Features: Ac12FXwhIRkFdJAWAed4xDP3q3IywLSg2d6UkKV6U_MRflLr1i4sd5nUB4xKcWM
Message-ID: <CACo-S-3VEXYFUMuOA3Jh8W3+dh6Ou+pLOFP=RKvSVVA4Ajac6Q@mail.gmail.com>
Subject: [REGRESSION] stable-rc/linux-6.1.y: (build) undefined reference to
 `cpu_show_tsa' in drivers/base/cpu (drivers...
To: kernelci-results@groups.io
Cc: gus@collabora.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

New build issue found on stable-rc/linux-6.1.y:

---
 undefined reference to `cpu_show_tsa' in drivers/base/cpu
(drivers/base/cpu.c) [logspec:kbuild,kbuild.compiler.linker_error]
---

- dashboard: https://d.kernelci.org/i/maestro:634dca9c0041633c75d4d5ce3cb61da4d05029f1
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  16a0c0f862e842e4269c2142fabfece05c2380b1



Log excerpt:
=====================================================
arm-linux-gnueabihf-ld: drivers/base/cpu.o: in function `.LANCHOR2':
cpu.c:(.data+0xc0): undefined reference to `cpu_show_tsa'

=====================================================


# Builds where the incident occurred:

## multi_v7_defconfig on (arm):
- compiler: gcc-12
- dashboard: https://d.kernelci.org/build/maestro:686d53f934612746bbb53f15

## multi_v7_defconfig+kselftest on (arm):
- compiler: gcc-12
- dashboard: https://d.kernelci.org/build/maestro:686d49fc34612746bbb51ff1


#kernelci issue maestro:634dca9c0041633c75d4d5ce3cb61da4d05029f1

Reported-by: kernelci.org bot <bot@kernelci.org>

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org

