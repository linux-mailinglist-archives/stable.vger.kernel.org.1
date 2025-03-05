Return-Path: <stable+bounces-120452-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEFCFA505D3
	for <lists+stable@lfdr.de>; Wed,  5 Mar 2025 17:59:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 125AF167DED
	for <lists+stable@lfdr.de>; Wed,  5 Mar 2025 16:59:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8791219DFA5;
	Wed,  5 Mar 2025 16:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="v+DtFreJ"
X-Original-To: stable@vger.kernel.org
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20BA2151992
	for <stable@vger.kernel.org>; Wed,  5 Mar 2025 16:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741193994; cv=none; b=J8KT9CNtItDG7p/Hez5seN1fwYob+bjSFoDxkus3q1WP9PhrqFVcE5ny87WsiinEOq7AhmXVVZo2/L2etYfCF5rngOhkyasfth8xavapBWp2SRgdPCJx0eXRfhpyn/gbg4fQmdsz1dmZ8d8GmzCr1Y+5ZMFx89cbDKylunVJCgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741193994; c=relaxed/simple;
	bh=K3WmfqhkP8/RahQMofjKxqK+HJ2XzJzReP+/dZIM/xs=;
	h=MIME-Version:from:Date:Message-ID:Subject:To:Cc:Content-Type; b=nF40/cKkzibaahycVrt3o9DpofX4Gea9Dss1YkZBtGFMlv1wLkJI72PwzkN8Pg2hEsbc5klo1qY7JVlbEuhfDIPQcGwfos/K1jnlqwUlqw9tm+6AyfN77tF44dRnvNTMPqeTCdWSiw/8OXe34nqg6gKD5FuA8tAMMyxCJLZr2O8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=v+DtFreJ; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e573136107bso6198553276.3
        for <stable@vger.kernel.org>; Wed, 05 Mar 2025 08:59:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1741193991; x=1741798791; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:reply-to:from:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wWnIRSAHRtM5hBgAo1DhTEBhbdTXvjeCYcMrnxYerTE=;
        b=v+DtFreJs2OlarXqh+r5UGpcjeOkinkWL7hSbyW8BwUCsOlJ0iM+NpDVWg1QteK42S
         of5pXhKH/DbgJauotL/LAwx5t9NLTFKq425nvvvm9Q5q/jFia3Iu+2rvug5ivSVglBFp
         fjZqYyQPYLSauYOztqV++fM9yZT6q9AvLJtxapRGHMwSyPqnfuQJDoUkRaDJ2YYQgawE
         ycjVGPJ7NvIJ56+c4GWxvmrXvCjMmxwKmhL6M7Q2pw+hKSKCtX8Ua8tsvK1MbdeVb/4J
         cjGnb7mdXQZ04UN0QdGw6tVqlYq6w4Inu3/vJwAmLmHQ0UrNsmeTGYgxPP1o0lcP3VNd
         LzKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741193991; x=1741798791;
        h=cc:to:subject:message-id:date:reply-to:from:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wWnIRSAHRtM5hBgAo1DhTEBhbdTXvjeCYcMrnxYerTE=;
        b=c/05aK4nCsolNV18Ealgyw9u3T80l9tZ40ucqwX9KIf1b5TjBy+7rQssimJk/UT4Gc
         GIswmffO070DHoLags0/nFaDn9wfRQ7Kl1mKFb5QnDP9ZEtqNXlao8o8rPTKMUYK8g/a
         +LCVKkGeZLm+O8RBAtBQGTIBLm/E52E5Zbip+blOh91tb/XA21Vaw1JkhD8qDAa/QEIP
         R1IOyvdFcCe7FfEZ0U1WZVmX5j895Shu8YAL4ztojAOO+3KXMvZt85NJajTalgOd82O+
         IeQKQ4eoEb2O4VPFr19SPG7Fk6G23qg+0WmVqz5gb/gU96WFxB9tjohztaQy2u97Wpl6
         qgGg==
X-Forwarded-Encrypted: i=1; AJvYcCVoeXc5PpOULkXQVZ/9HyaDj+qxjRDodjbhtO7mdjGgmgvFM+VV2eTuMY+SwD0Df3iivE7LhRo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzO/yRYJRHlCqMURlpCcCycli3kx7z3pGde4/9CHdAYSOu25iMZ
	N5FeBF0qXSE0hfnCreMLMcI7HBHkHY2881SFX/SjEEGnEhjYjYeh44Zt56Zn30gzkV9Q2Q5msCi
	Rm/VzFqn+C9YGmbvVUxLcjMBsljx6wPR6RV0OfQ==
X-Gm-Gg: ASbGncv3ocEsuitG8XKYEcXn9+6FNk1VfWuSMOiZX4Hwp+y9k+qe01q3m+X+cJk27If
	e/QDxwtGM0EpimSgz8PGaLi4dM87RA1iFIXc6+/JXQQCo0xFBUadjmfegOGti8OqU4CvC2NcOQA
	3JlkmJ06PzOLktTU33pnnybSuLVZzu7AGk9ShgOknkPTzyXeLJOb2ODazlcHE=
X-Google-Smtp-Source: AGHT+IEQx57wO8bHmD4s/3HLXIO/eBpO+qIKaK/WdN1AqJ7kXe801Ne0NKb9UY0sCnWaC8BYUJ+uEMuIUI8ZYuMJn4U=
X-Received: by 2002:a05:6902:725:b0:e5d:d2b8:243e with SMTP id
 3f1490d57ef6-e611e31821amr4440396276.42.1741193991087; Wed, 05 Mar 2025
 08:59:51 -0800 (PST)
Received: from 415818378487 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 5 Mar 2025 08:59:49 -0800
Received: from 415818378487 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 5 Mar 2025 08:59:49 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
from: KernelCI bot <bot@kernelci.org>
Reply-To: kernelci@lists.linux.dev
Date: Wed, 5 Mar 2025 08:59:49 -0800
X-Gm-Features: AQ5f1JpajwvlbUgfq-jBRTMa7MxbzSd5yQx0XCGq4txxU8EEtV_jxf3uEeX8T0o
Message-ID: <CACo-S-1CAMsQW_G2ge4JHTS04JR6bcvfzwoNCaenpp06dKWEXg@mail.gmail.com>
Subject: [REGRESSION] stable-rc/linux-6.13.y: (build) use of undeclared
 identifier 'sz' in arch/arm64/mm/hugetlbpage.o (...
To: kernelci-results@groups.io
Cc: gus@collabora.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

New build issue found on stable-rc/linux-6.13.y:

---
 use of undeclared identifier 'sz' in arch/arm64/mm/hugetlbpage.o
(arch/arm64/mm/hugetlbpage.c) [logspec:kbuild,kbuild.compiler.error]
---

- dashboard: https://d.kernelci.org/issue/maestro:729533e78f26d9eebe477a0e479e082cba03bafe
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  1ff63493daf5412bf3df24d33c1687bd29c2a983


Log excerpt:
=====================================================
arch/arm64/mm/hugetlbpage.c:397:28: error: use of undeclared identifier 'sz'
  397 |         ncontig = num_contig_ptes(sz, &pgsize);
      |                                   ^
1 error generated.

=====================================================


# Builds where the incident occurred:

## defconfig+arm64-chromebook+kselftest on (arm64):
- compiler: clang-17
- dashboard: https://d.kernelci.org/build/maestro:67c8713c18018371956b7bef


#kernelci issue maestro:729533e78f26d9eebe477a0e479e082cba03bafe

Reported-by: kernelci.org bot <bot@kernelci.org>

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org

