Return-Path: <stable+bounces-189993-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48215C0E3D4
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 15:06:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B51873B9F3F
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 13:59:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A98B277035;
	Mon, 27 Oct 2025 13:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="BJ6AVbJE"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C34832874FB
	for <stable@vger.kernel.org>; Mon, 27 Oct 2025 13:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761573551; cv=none; b=IPTz2WLS0QbAfT7prcFZX07KT6am7KxbEpjDfo98c2CuMoB1vCK9wuldZY1/vTQaIYSRa1ENE3wxP44VzjHb1BQCNJUFI3KVIprDdG8bCJOGNfUsjw/e87ncblzADv/e86LdZIefL/sgSEabF7NlNQCETHBuuMl+C//oIftuUHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761573551; c=relaxed/simple;
	bh=29wEdzmCnNnvsYvhMU7D0qR6EjOw8TBK8KFTQds4q8c=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=UrsQds/QrrZ4aL11bARt9MN2GzVaYKlEU5VDz+LPZLrC0+PCEo8n1MfhA8BNBZq440ITQJWq2DBgbfy2wZcZfwcqRd/y1z4IvfCtF6phpypNAs3byx+LH0n+eaUsDuq1fEon4esRVh8I9KHjOSK1RFA7xI5cJRTL244DBc6HrnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=BJ6AVbJE; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7a27ab05a2dso3937694b3a.2
        for <stable@vger.kernel.org>; Mon, 27 Oct 2025 06:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1761573546; x=1762178346; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OKSXoKHGs1jyUIt/TshTdqxVz5/e5VjKAXLjvxRE5gk=;
        b=BJ6AVbJEYS6SAA5CbZmxOoAFvI+LxecPP5+ygwh6BZFPA/DQQyMigeVHiK8sD9dQV+
         J6QSaoK+yvxUV6+afCy3C0SHdCwSvuTKu5GUWkYaVSliOZLYeMMPu7oaIQPpHesp3K1i
         riUwPqbAA1flZqKtD6nCx8nLUzaNcq6bJaLrmaO/kI8TITrRVA8JG/VkPnL5G8HKvj5a
         kzMl82aI2yossRmPJ/9nrBYc61ohZnnHL+ok/H9+68JfNTzGCnK7x2Fk1z+j0+9+YT+1
         BR1UU0yaBsVQY8ih8sVJEdoEqyACs9KZ9Ey6SylDMOA1SNZv5i1VeC29y/sEW4lKy0ZM
         iCnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761573546; x=1762178346;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=OKSXoKHGs1jyUIt/TshTdqxVz5/e5VjKAXLjvxRE5gk=;
        b=wbS5bADhWPhHhrpHCngCZkHyOT9LfkurTFPJuxzyXI0hr8TVl7e871r/Z72mOR8ill
         ytSMhx8KtrcF/GsK5STRgWgyhl/iB6TYu+B8ZAvhqWD0o8cWx567r7U3OG2u+4Bi9gZ4
         57YS9vb8/gCyFm8qhQXVfcP9HCaFmkXTgESx2eRTOVGt7csFtFc6uWXfBXUar6KGi2Pu
         fXNBXYAYq1lY781RvHUU6phFk2tPKFF9j8JKI0n9RQ55V0m/OeCN9j0sTVxhoyEvcIXc
         gHYbGdKgbbipXWnEZP9So6SD/kHTB8Usqy8QErVTCwEr9I+uRxQPirgkw/Z7CVHljNSr
         LiFA==
X-Forwarded-Encrypted: i=1; AJvYcCWuqVr4SWVrCHwMsAgbjjVhyWkAs5yyr2Jda+yVtZAt3JqY6fuRRzo4EX/HnYWcPsGJZdE0z4w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwK/g6XZ32jU2+MyHr0xoXAaUDLSpAhnsDjj22hr68VEKtm+Em4
	+auqsbbpPfdT7/VUKR5b3IddNNrSTGIl92IToULWTQyy/15SermKC+hcUgtEGo2M+iE=
X-Gm-Gg: ASbGncuCKkxQLrJrkJhwxQisa/sH0whJT6Cdh3cgAWv09pkorsF8m83dyjE3d6muUSB
	6TqXTR8Qnsz7S/OEpJFEuvSvyHJV5kRjaal1GsbBa4EurD+RHraam440/TBnq4jFKgtTBwQoLBK
	kfRB5XGcwK+q8an3C42ErIamOUcG1VahekUZaiIyHgHa2iIMkc/aXziJAYgfPcNhq2sc1UgqiCU
	UR6qgZd1kSNTunP5hGZrt/ypVJMJWgID0bUoC9x6MzDjwPiKqbQ2V313joqmImQdzeII5o3opB6
	ZKDhlVMpQwKRIT8P2QDJd6ps4R5oXck6XyaJGKiaCuoRDXvK9q3z51BH7NQMLBeZUfp//k5mSVl
	hkm7I+8tp1yPRiHo0V0SyWp5j9dUgx9HvBYcKkBEBXpdkS3tbFuDJea6jqJiIdnfaxtY32Hs8h4
	uwLen0
X-Google-Smtp-Source: AGHT+IEL0Ts4FgLBh8sjAZeSjBjrex+aipwsV5pwyjwUgZj3aG46MdvCCgEtZyFFr9zai/izq4xzbA==
X-Received: by 2002:a05:6a00:997:b0:781:1784:6dad with SMTP id d2e1a72fcca58-7a441c41f2fmr28721b3a.24.1761573545694;
        Mon, 27 Oct 2025 06:59:05 -0700 (PDT)
Received: from 15dd6324cc71 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a414012a1dsm8236459b3a.10.2025.10.27.06.59.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 06:59:05 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: 
 =?utf-8?q?=5BREGRESSION=5D_stable-rc/linux-5=2E15=2Ey=3A_=28build=29_unused_?=
 =?utf-8?q?variable_=E2=80=98ext=5Fend=E2=80=99_=5B-Wunused-variable=5D_in_a?=
 =?utf-8?q?rch/riscv/kernel=2E=2E=2E?=
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: gus@collabora.com, stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Mon, 27 Oct 2025 13:59:04 -0000
Message-ID: <176157354426.7785.7106792717580274646@15dd6324cc71>





Hello,

New build issue found on stable-rc/linux-5.15.y:

---
 unused variable ‘ext_end’ [-Wunused-variable] in arch/riscv/kernel/cpu.o (arch/riscv/kernel/cpufeature.c) [logspec:kbuild,kbuild.compiler.warning]
---

- dashboard: https://d.kernelci.org/i/maestro:5135288c90855e0205f0a76b012c159c9f2e4f97
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  2e86ed6526626d22b225d03a7faf8bd09dca2a5b



Log excerpt:
=====================================================
arch/riscv/kernel/cpufeature.c:107:37: warning: unused variable ‘ext_end’ [-Wunused-variable]
  107 |                         const char *ext_end = isa;
      |                                     ^~~~~~~
arch/riscv/kernel/cpu.c: In function ‘riscv_of_processor_hartid’:
arch/riscv/kernel/cpu.c:24:33: error: implicit declaration of function ‘of_get_cpu_hwid’; did you mean ‘of_get_cpu_node’? [-Werror=implicit-function-declaration]
   24 |         *hart = (unsigned long) of_get_cpu_hwid(node, 0);
      |                                 ^~~~~~~~~~~~~~~
      |                                 of_get_cpu_node
cc1: some warnings being treated as errors

=====================================================


# Builds where the incident occurred:

## defconfig on (riscv):
- compiler: gcc-12
- config: https://files.kernelci.org/kbuild-gcc-12-riscv-68ff67651198e7d4c92ca10f/.config
- dashboard: https://d.kernelci.org/build/maestro:68ff67651198e7d4c92ca10f

## nommu_k210_defconfig on (riscv):
- compiler: gcc-12
- config: https://files.kernelci.org/kbuild-gcc-12-riscv-nommu_k210_defconfig-68ff66e91198e7d4c92ca077/.config
- dashboard: https://d.kernelci.org/build/maestro:68ff66e91198e7d4c92ca077


#kernelci issue maestro:5135288c90855e0205f0a76b012c159c9f2e4f97

Reported-by: kernelci.org bot <bot@kernelci.org>

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org

