Return-Path: <stable+bounces-112067-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F3A9A268AC
	for <lists+stable@lfdr.de>; Tue,  4 Feb 2025 01:39:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20C373A5670
	for <lists+stable@lfdr.de>; Tue,  4 Feb 2025 00:39:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A69BC4EB50;
	Tue,  4 Feb 2025 00:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="DP3F9BZj"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f196.google.com (mail-yw1-f196.google.com [209.85.128.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E26EC4685
	for <stable@vger.kernel.org>; Tue,  4 Feb 2025 00:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738629542; cv=none; b=NlywfJ7agILLcJjLg/CZOefbQowm02pxfGHP/CC8DuLzxTdOT+ale29tY/SJT8GqMTNTdkByf32WzdkCuK15EHx40w98VJ2Smp6zyT7xithJm8rUbF/Xb+sr6KV+U4sTPDonmQ8ixOxTBRl6FZ94nHiPtdkU+fh36/JaNHGXuc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738629542; c=relaxed/simple;
	bh=tNnQ1LRnpP3iB28CMuCBj9PWVQIL4Nqk+HQ+nz1JYec=;
	h=MIME-Version:from:Date:Message-ID:Subject:To:Cc:Content-Type; b=i2Y+XrAJv9IPdp6+eiVcZDUcyCrGNlJDEWTUJaYDrBe1CREQzJ+NRF2m/XYLoUnP1ybAgO00ZIrhTLTgqUznzZLfPJEsiFGDZ2MbuF6kdeeuYYwskkKrefd9bT7snT4LPTRwc3ovYDW9BN2Vob7gTDNvVW5+ZaVr+YXhhuUuZ64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=DP3F9BZj; arc=none smtp.client-ip=209.85.128.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-yw1-f196.google.com with SMTP id 00721157ae682-6f973c0808dso7895147b3.0
        for <stable@vger.kernel.org>; Mon, 03 Feb 2025 16:39:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1738629540; x=1739234340; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=z72Qzq73v4ISrBuFmGndp2Yi71TP4NlpDhkx8bIeIZ4=;
        b=DP3F9BZjVChUEjT2NIM4ObYQMfydAFeHZTdvT/EnXW0khbdXhARxeKkkjSmmmwq2Dq
         xlu/21xuDfhmjTi8zkJsi4RcZvVfp0wXPEYKltVEvfJ0IJW8uALvrDPb2L/ZD2RMiHVf
         CQXGe41l68gy6I6trsQPjSsaxCDu66F7XoGMCvP0++tYqigbRffRf/HxepdDGe8pFKMm
         J1PqTqr+TorNiHewh6xPYNL/XD4KmTRZ/JWiTtPhh76BHWwt0En8F1gkNSdTIcPb/lCB
         5efov+sP4AnXgjxyI931+X4OwKjp2cRNZkcxtKOWMCZprXBLQToua5Yh8DweZ2yq/sWH
         dyfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738629540; x=1739234340;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=z72Qzq73v4ISrBuFmGndp2Yi71TP4NlpDhkx8bIeIZ4=;
        b=lkyZfaceVxWPu/VayFzfsxHO6EIQfRDQM07+2r2j+189xHi0jc+T8Rxu4F8nSJXEsj
         wzyCE5Ow5C/oBnLYTvQ/2oVbslYlxIbzlYhi2W3TeQGZnoKWw3bYtkce9FUN0haKz2jx
         nex9ksB9s0L6RQXQqpOiVvLvrNlSo/t6QUfYAqHaFj0r0H9rCAUgycjBCrdYLtbZYpTh
         hN1Tvn1OFOAa+czSZ4GTLuECvzrfKrrD8YWWLYalJZSCHoR8Dc3Nso7YzpTE+GH74lv4
         tLXlaSFLvypswGmy0A1XmJOPu7yBbgPy5cU/TmEHveHzRHhYvhsFQX0YgQBROmze6T2f
         I8EQ==
X-Gm-Message-State: AOJu0Yw/cWWzmlAY7tHqMUbP+5m1cW1dul36Leqckpybb7k6DgpXUOer
	Eaq59/OCIgHea5pUIgavpEEWW+hUP141QyYkZuQNy6CGqM+ZP1fnL6nL1szjxxDDjXwXu8xmZb7
	xYRL6ogrD79JhjhVrQE6L4mAMrA/pdCd/Fvly5BG/kmUQ+BhA3I/gQJqf
X-Gm-Gg: ASbGncsMH2JmcCSM81+Iy4bXBuKg76XukRUM3SQUmBNd9dTFWDdYKTBVbNVD3AYABMf
	sXJbd4O2LwlR56ak4Df6WEFqjD5kDhmc1e3LMjFdNRPyqVWVFLuaH814Elchzhi+onMDge5Onu2
	lq0o1afXgGppXP2bw1VxOwEwHWkht51g==
X-Google-Smtp-Source: AGHT+IF0DSbpJXeoa3o/2oOf98FB2NlcQH+j+FA2kUdjQOr9/3NU8lIKNJqaALhyZjtu+ijhBfbYOthNyv5BOhzQPik=
X-Received: by 2002:a05:690c:7083:b0:6ef:6f24:d093 with SMTP id
 00721157ae682-6f7a83251a2mr198713217b3.6.1738629539837; Mon, 03 Feb 2025
 16:38:59 -0800 (PST)
Received: from 415818378487 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 3 Feb 2025 16:38:59 -0800
Received: from 415818378487 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 3 Feb 2025 16:38:59 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
from: KernelCI bot <bot@kernelci.org>
Date: Mon, 3 Feb 2025 16:38:59 -0800
X-Gm-Features: AWEUYZmc7GnTfZM-d1cHe4wiBGeG46Jn6hWGrWe0cSa84jvAQHyW2eljI-ccMwM
Message-ID: <CACo-S-0B6BySk3XBKn0Maq9oC3YZvt-a0ycZf0-HMJLaFCfAmQ@mail.gmail.com>
Subject: stable-rc/linux-5.15.y: new build regression: expected ';' at end of
 declaration in drivers/soc/atmel/...
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org, gus@collabora.com
Content-Type: text/plain; charset="UTF-8"

Hello,

New build issue found on stable-rc/linux-5.15.y:

 expected ';' at end of declaration in drivers/soc/atmel/soc.o
(drivers/soc/atmel/soc.c) [logspec:kbuild,kbuild.compiler.error]

- Dashboard: https://staging.dashboard.kernelci.org:9000/issue/maestro:e215ae3b0e6270af8feaeba47353c1644d7527f8
- Grafana: https://grafana.kernelci.org/d/issue/issue?var-id=maestro:e215ae3b0e6270af8feaeba47353c1644d7527f8


Log excerpt:
drivers/soc/atmel/soc.c:367:24: error: expected ';' at end of declaration
  367 |         struct device_node *np __free(device_node) =
of_find_node_by_path("/");
      |                               ^
      |                               ;
1 error generated.



# Builds where the incident occurred:

## defconfig+allmodconfig(clang-17):
- Dashboard: https://staging.dashboard.kernelci.org:9000/build/maestro:67a11aa4661a7bc87489ba72


#kernelci issue maestro:e215ae3b0e6270af8feaeba47353c1644d7527f8


--
This is an experimental report format. Please send feedback in!
Talk to us at kerneci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org

