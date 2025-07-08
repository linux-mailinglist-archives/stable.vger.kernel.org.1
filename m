Return-Path: <stable+bounces-161331-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D295AFD5D7
	for <lists+stable@lfdr.de>; Tue,  8 Jul 2025 19:59:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C31CA3AC7FA
	for <lists+stable@lfdr.de>; Tue,  8 Jul 2025 17:58:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02DDC2E6D16;
	Tue,  8 Jul 2025 17:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="CMz2GzRH"
X-Original-To: stable@vger.kernel.org
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DDC62E6D12
	for <stable@vger.kernel.org>; Tue,  8 Jul 2025 17:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751997554; cv=none; b=Bln1Tcuc+mp++Q+KpHRHKv6b6TEn6jjVsJqOWfDtWWq4AcvnGtW2NgWb+6puZzzRg/FgcfNFBHzjRJiOBVskAALV4Ty2pUZqpMmaLYFftjQsbtcmqkydjTrn56g36VnqFABw1VFzani297JCo4ud4E7u8BqeghmoL1PQrVnzAJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751997554; c=relaxed/simple;
	bh=AhutHxxmfii7jh0xZ+c1jq8so7HFKV/Oc6DnAOZqGHI=;
	h=MIME-Version:from:Date:Message-ID:Subject:To:Cc:Content-Type; b=K8P1rxIeyvLyH7AynKb4BqsEqzwDOddr9/I4vKV53sUCH6sxmmyikyUW1JbkfMMaEaryA3GNdzTr1SSnhfdyo+ytj58lpfCku/Oqi/SWOY2n4Up3zsBOQ1oACqvzwGhbrWYpExnXNVHioNkmHg0Rlwh71Kmrj+ko0GGwyEWz1VU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=CMz2GzRH; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e81749142b3so3784192276.3
        for <stable@vger.kernel.org>; Tue, 08 Jul 2025 10:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1751997552; x=1752602352; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:reply-to:from:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a4fG8/hbDJqsMuZ61vj1Y5w2+GrzB4ExU/SSFov2XrY=;
        b=CMz2GzRHcW4byswsyTHgYIPnZxdzJjMPTUXE0QMvIOi9aAIoTmfAQx/Hes3wMCESKw
         vxNvQZoosmibdGOCSAEnyl75I9RrNrqoSXa4zEPzVUFklJk3SEqngj7UY0sEa8wCflWN
         WBKXqo0xKMrAIOecXD21yaJI7ezsuFc4NumVlB05bi+Wmw9O4VuSkYaRbYYm2o0pZvFL
         8iTMGFquguYci4CHkvPFz/5GJ109dux/DxoqI9b2Jq6r7OCTH6EfAu9OJSJNJk87If1e
         M/VfaqDgBb/EqGinR22ok781H4MSYKY2P6YVOaHnBUiTovP/KJ/mJDhJDUpdPcICBb5x
         grJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751997552; x=1752602352;
        h=cc:to:subject:message-id:date:reply-to:from:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a4fG8/hbDJqsMuZ61vj1Y5w2+GrzB4ExU/SSFov2XrY=;
        b=vqayQ/+bAqXezIqRzTqKMOYp1+fBJA9tcW/R8xFgzn/z5qSomoJIN/TObrhLV4En9K
         ORxkpBu+7BVriZ1cG96kGU1Nnbz3dRjyKEe8T2vk8FscD7wCxnts7GjyX2gb8GUxJ5AJ
         mFe4bkAA4qhNGCFMlWaYk+VbygNlCe6i6UGCiro6p3FCw/KRFKdf5IeAqO5LkHLf8g2T
         pw5s2ZTUIV4cZrnoVzvs6GkZ4KEM9DAzebzwXL50F1AEt12HJbz4BxGCeCZNwAntnHEM
         r4JqZiiLAkcU/QrCoNMlU1zJQUTNfmd+ByGj267cqS5zd4P/sGhh8jwMWBplXomzwLs3
         ymgg==
X-Forwarded-Encrypted: i=1; AJvYcCWrv/SBRYL1gBbJawh1XmjChnrCF1RC+NorPBUv8HmtWgYHmz6i4QIaFvhAEZsuqYU3n+RPYrg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrFGXt9aZ+GCn1MbOGjEG4GajklAwdmk5MPAtOyN+OmysLLuuT
	EfFNlsB+vctHhD0No+8BhI6nAfeGCLjDHCLWyWFSfe52h5KP3vinA8p5h0T/c3bf+mwP8pW9KaH
	mDqlra1bjrFdVePG6UjyQb9Hfw0Okub+pQ8Pf7wmumw==
X-Gm-Gg: ASbGncsf6plEwBebxQWUXkXm+1ymPL1+X6kfnsoPj8IolSh7+b4cSusAVH3wy3jh9Ea
	t/6nht3LKv0j4mv8ztuArzncMflrMIcfAvxEQKQ1p86HGRuMRmOQe5PO/CDuvgR8njJ51YGoEky
	baWgc/TltcVqz+l0pD3FW1HkCDjAE6eMnl/7ebM3jLyw==
X-Google-Smtp-Source: AGHT+IErFD4HAvczhqGniLT8zwMd2YO6XDMvNAV6U3Ihi68gf89MDcAZTPg+bYCjO2zNZfyCBA/wJF10mxr2RQyXwsY=
X-Received: by 2002:a05:690c:c0f:b0:70f:88e2:c4ae with SMTP id
 00721157ae682-717ae14e8c9mr12601847b3.37.1751997552135; Tue, 08 Jul 2025
 10:59:12 -0700 (PDT)
Received: from 415818378487 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 8 Jul 2025 10:59:08 -0700
Received: from 415818378487 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 8 Jul 2025 10:59:08 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
from: KernelCI bot <bot@kernelci.org>
Reply-To: kernelci@lists.linux.dev
Date: Tue, 8 Jul 2025 10:59:08 -0700
X-Gm-Features: Ac12FXw9qcaWpW0L9UBSAlyofk4iSAuf077r13fcDtPfbLZiaaFJ4vfFvWT0mb8
Message-ID: <CACo-S-2-5PQK-dbyEUXAUXcWhCRkHcTLNuPHX2-UAQYuoxoHNg@mail.gmail.com>
Subject: [REGRESSION] stable-rc/linux-6.6.y: (build) incompatible function
 pointer types initializing 'int (*)(struct i...
To: kernelci-results@groups.io
Cc: gus@collabora.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

New build issue found on stable-rc/linux-6.6.y:

---
 incompatible function pointer types initializing 'int (*)(struct
iommu_domain *, unsigned long, size_t)' (aka 'int (*)(struct
iommu_domain *, unsigned long, unsigned int)') with an expression of
type 'void (struct iommu_domain *, unsigned long, size_t)' (aka 'void
(struct iommu_domain *, unsigned long, unsigned int)')
[-Wincompatible-function-pointer-types] in drivers/iommu/tegra-gart.o
(drivers/iommu/tegra-gart.c) [logspec:kbuild,kbuild.compiler.error]
---

- dashboard: https://d.kernelci.org/i/maestro:387fac999fdadaaca0ca80ad07047ef2d702c09a
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  b5872ed076bddad62df34a0ff4cbe4bbdfe45a67



Log excerpt:
=====================================================
drivers/iommu/tegra-gart.c:281:21: error: incompatible function
pointer types initializing 'int (*)(struct iommu_domain *, unsigned
long, size_t)' (aka 'int (*)(struct iommu_domain *, unsigned long,
unsigned int)') with an expression of type 'void (struct iommu_domain
*, unsigned long, size_t)' (aka 'void (struct iommu_domain *, unsigned
long, unsigned int)') [-Wincompatible-function-pointer-types]
  281 |                 .iotlb_sync_map = gart_iommu_sync_map,
      |                                   ^~~~~~~~~~~~~~~~~~~
1 error generated.

=====================================================


# Builds where the incident occurred:

## defconfig+allmodconfig+CONFIG_FRAME_WARN=2048 on (arm):
- compiler: clang-17
- dashboard: https://d.kernelci.org/build/maestro:686d4a9e34612746bbb52198


#kernelci issue maestro:387fac999fdadaaca0ca80ad07047ef2d702c09a

Reported-by: kernelci.org bot <bot@kernelci.org>

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org

