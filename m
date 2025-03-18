Return-Path: <stable+bounces-124847-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 93A88A67B3C
	for <lists+stable@lfdr.de>; Tue, 18 Mar 2025 18:44:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2BE617B0EA
	for <lists+stable@lfdr.de>; Tue, 18 Mar 2025 17:44:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DBFF212B07;
	Tue, 18 Mar 2025 17:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="iytnGwcD"
X-Original-To: stable@vger.kernel.org
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6143B211A1D
	for <stable@vger.kernel.org>; Tue, 18 Mar 2025 17:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742319866; cv=none; b=IrAJeM4gzjGrH6JPWCwU5CcvN+v7uxp/zMRjo6dmR4an1HMUnBUChDbTwD4LCD45mbiRyRhihP2gnlj9CBtU7k2W//v/zHML/1KfUk0RNTr6Attt9EkichuolAKSoyHwtWiH27YXFz1vlXio5ibUy+O4XcpUD1L+bwMI727xQjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742319866; c=relaxed/simple;
	bh=SIzApz/pnrExtS0dLb1GZsZrdlqovRSozvJ9L/Il57E=;
	h=MIME-Version:from:Date:Message-ID:Subject:To:Cc:Content-Type; b=kPau9VMmrdUexQ5mCYJvEX9xQPjJkRM46u0sUB5gFdMpXXrGEKROa2mnLzuM6jF95Ln63yJmQxxnpdcEZjdaRKcPWTie5RX/GRm7TINRtI1ceS0qjiODi27ua3hI3cdf4nJLNSXcxBVyxrKjXlJMVdQ123qFBgy4fBGm3lSOBV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=iytnGwcD; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e6405b5cd9bso3338045276.1
        for <stable@vger.kernel.org>; Tue, 18 Mar 2025 10:44:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1742319863; x=1742924663; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:reply-to:from:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ftHjA6CS4sqbiMtvxDpbz7eMNdmmwVdFsfQ8lZgcQNo=;
        b=iytnGwcDnybWAElAP9PqRBA6GzWALnIrDr8EfR3s+19ZtQeUJHJXz2wHjI00TGeGDJ
         UaYDl9CU00UJDNW0xv6lZtTEYg4A9/w0V6n7Ydpc0uDNi170Bm9lPvOVmW4H+lLJ9dRN
         RxwohIt7e8i5I4tyhzvA76KQg01JXhaFSSrnAbx+FLNcUtxwMP5JMIVTffv/aqKTiAo5
         kPwdbIdGRIb0nyNb57dvqeA3L7koBoatXSJ0A2T9ZQNUwJ2VH8sHTWO9NjfhfofhdKFg
         G0faTv4G9JbEpXa8igD/ywAZv7HyJAFHIGWb2h+r+YvAKScM394jzgvEUICv5tOkpRQA
         m6bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742319863; x=1742924663;
        h=cc:to:subject:message-id:date:reply-to:from:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ftHjA6CS4sqbiMtvxDpbz7eMNdmmwVdFsfQ8lZgcQNo=;
        b=L+PLLJLv5oKSy9We2F8tmKuIY4MOO4BLVj97Am2R849cZeTvl8y5dNwqfx24ZPBiwk
         Sr/m7lCTWNrWGpHZdRiGL3dnCqvzSx2TyOdI6Av/DMc+JQcgw/h2IiPb0juL00Ayo4j5
         JU4EaFBsC/fLkPEDnmNArirrYlQBIfYQJzDs5PrrBjGIjbEfiVrakWcqbyxy2kBtZVcI
         3aTWBALqZI55dnDcGH8o7/xzHsQAXSt1zVVZlY0dE9BwOg+gapzTTA8KTzrfTYIJpvrA
         VGnwJC5O3bfYlcv+7mbIq7nEYEh2DKUyMDEvFVG3Tg/FMUSDJkk75E+Yd4LWJL7NDY7n
         DVJQ==
X-Forwarded-Encrypted: i=1; AJvYcCUANOKE4qWhrpjjF4BXsOvgUVy1/QkAHJ7LTGjGE85JxMSo/HFo+KVIokfP1uTCw9E9DYYZUsg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUJjzDvJwOA+8X8Ol6F/LI0Y/E/D+A9X2tosUg+6+aQzkXWg0s
	RVYgGEbmQTAJchCsOE7XOQ/7TNegy6UN5JqqKud/ilN1SIZWGTWUM+3y11aHQ2NVt4qd3NRygCf
	63qztSVsMd/mkGuThzGhYjoVUgAVreH5di5mt1w==
X-Gm-Gg: ASbGncu+GxNxNZOPtxQPKZuBq85G6YWgMOmR/CjiHOMqSPTIoiF3dlLhhuC9ExfFy+u
	gTifxqor7O+NQHZmqkzEDTyWuR2SzCAOQAZpzrhdISYRjmPH9g1ZZW+v7lD0YWrXoaclz6J6TCS
	s/VgEXpwfbKXSOKz9igHRlYP5FlurGT/59dcrw825E8mdyjnniXqcH/EJo1gnDa3taZIpOKg==
X-Google-Smtp-Source: AGHT+IGgd1Xt8vCtdCo1gv52j2zlLqUlVTSECNsvqxHJOZYE3Rmmb0TBqF2yMW2jTBzzzyuzOoaLL7E1W9G14G5Dko4=
X-Received: by 2002:a05:6902:220f:b0:e61:142a:82b0 with SMTP id
 3f1490d57ef6-e6511b7519dmr6391950276.24.1742319863290; Tue, 18 Mar 2025
 10:44:23 -0700 (PDT)
Received: from 415818378487 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 18 Mar 2025 10:44:22 -0700
Received: from 415818378487 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 18 Mar 2025 10:44:22 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
from: KernelCI bot <bot@kernelci.org>
Reply-To: kernelci@lists.linux.dev
Date: Tue, 18 Mar 2025 10:44:22 -0700
X-Gm-Features: AQ5f1JqBudS1oMdy1qlImRBOKVTsY4BdI5x_sZIioEE-37JoFrZbIEEExi2jHCI
Message-ID: <CACo-S-2OMK2UUW4nXrfftXG6Ax3Et=bDdtmphjzSt-HD7x6=og@mail.gmail.com>
Subject: [REGRESSION] stable-rc/linux-5.4.y: (build) clang: error: linker
 command failed with exit code 1 (use -v to se...
To: kernelci-results@groups.io
Cc: tales.aparecida@redhat.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

New build issue found on stable-rc/linux-5.4.y:

---
 clang: error: linker command failed with exit code 1 (use -v to see
invocation) in samples/seccomp/bpf-fancy (scripts/Makefile.host:116)
[logspec:kbuild,kbuild.other]
---

- dashboard: https://d.kernelci.org/i/maestro:9b282409ffe9399386349927812ed439dcc91837
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  bbf51067f14852464d75398076a963edbe1e5cc0


Log excerpt:
=====================================================
.o
Generating X.509 key generation config
/usr/bin/ld: cannot find crtbeginS.o: No such file or directory
/usr/bin/ld: cannot find -lgcc: No such file or directory
/usr/bin/ld: cannot find -lgcc_s: No such file or directory
clang: error: linker command failed with exit code 1 (use -v to see invocation)

=====================================================


# Builds where the incident occurred:

## i386_defconfig+allmodconfig+CONFIG_FRAME_WARN=2048 on (i386):
- compiler: clang-17
- dashboard: https://d.kernelci.org/build/maestro:67d9892328b1441c081c5044


#kernelci issue maestro:9b282409ffe9399386349927812ed439dcc91837

Reported-by: kernelci.org bot <bot@kernelci.org>

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org

