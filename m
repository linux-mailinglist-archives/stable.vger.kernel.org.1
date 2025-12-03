Return-Path: <stable+bounces-198192-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id CD297C9EDAB
	for <lists+stable@lfdr.de>; Wed, 03 Dec 2025 12:38:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 534D234732A
	for <lists+stable@lfdr.de>; Wed,  3 Dec 2025 11:38:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E36BE2F549B;
	Wed,  3 Dec 2025 11:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="A1z6sc8i"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f226.google.com (mail-pl1-f226.google.com [209.85.214.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D24A2F5335
	for <stable@vger.kernel.org>; Wed,  3 Dec 2025 11:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764761889; cv=none; b=tIXuzhyRpdfAIUGeNdYFyOpfYVVlAJRQb1nTRV4Nl70xsC0i1hzi9Mft/L4cUoIv9J4oJwFB/kmr0+GUwz5r0sYQovSXL96yzHhZ8/6Mh0ha9KjtDIYYdiBGwzw8W9EQonFLQK2oe1X+wmzK6lD5Zut4c+JXv9f5bxBMtfzV/JA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764761889; c=relaxed/simple;
	bh=sENKhAjfiFMdM5Vzt/Kuq1N4Ly56/ZuKzsvCSL6BuPU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=uSI9aUgagjayPIIrddtvwYAtfCEI/LBxSBMf3E03QY3wE/LIlN0B2WUXbKgM2cYHMCBNTBvpaQphU/fsA9l+L9zGr3OuHeoxdasUXwi9H13tu3lXvIHYm2NXhqM3eM7/VRhI3xfGioB75gb3b8c3RjRwRYdLz/zY9EtDhYU0hEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=A1z6sc8i; arc=none smtp.client-ip=209.85.214.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f226.google.com with SMTP id d9443c01a7336-29ba9249e9dso73815175ad.3
        for <stable@vger.kernel.org>; Wed, 03 Dec 2025 03:38:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764761886; x=1765366686;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ro7+YwmIoalPwjaMMWSCKwPO9uGBD09bCG2MDV1ZR4g=;
        b=SakQSdpjl8C8KHBNorkqJntA72Aos9ASGz6MCupMWE6hgrZ+z/IL+BeTEQHt9R1HYy
         dmOOANaXY1VpgZkZhWsDZ+Hbb48FFtvEw6gvXkQB9Wa2ldxP2XrqUO/7+SM/FenkXqrI
         EUhJ/huLs4w+AzRfkfkclVO9OYhYIQdrZG5CHKTZu/RXJawm9FD4Lx4CY4v5LFZmuiNd
         pgRwk+TQp9u7bSMj8bYRCKqwd1p0k2rYPvHyJao7rFCZQCBWAQ4ZYRt6tU+a6YQz//WX
         fL2EhjX+nyr9FVcXswd7UZ9s11ATE0my9lpE94KkD1Oyo+nLmyfnIrLqy8r4jecv1dmY
         QA4A==
X-Gm-Message-State: AOJu0YxnQfLiefiLOG1uQIShc8DtvKFXGhtJGwz2c0WLIQ6T4iJzyCft
	lTXdlZZ32jpFEtjzUZ/HqFrj5amZBkNJG77EKp+fy2Fh6ochsqZ8e/UotJrxDNUw2cDhTnW2gpR
	OWeEqM+uyFj29FehQWNWFA4B/sSBKt01Gix4Wncij41u4UNVPds80a7kIyW4iLHyzQ690yGyoRE
	qo/7C0D5z+PnnBh0DMqQewV1Er9JpNaMcy85kiIhKsWwU/YuxT8scvTZK88PCm0S4XCjIKmBDae
	birT4HgkJ4=
X-Gm-Gg: ASbGncuA15JeSoSb6wS9i2h+8xDaordmJoNhhQ+BSeWb6LKpxeXBfbCgI/8740V4fyf
	9rneHxrIWABhh/W0AOnZ6mfve/sE9Ip22axCj2K/pUuzxOF3/vB2+lesUV2srTQa7ULw+V1b2Qx
	iRR4UPZTaC39ghXnqcfTcaF8RgAf9CGT7cGHq/Fo7gS0gijftc2dh/ff/YPBiTOqy99QhSUoC5+
	bKZcA675/1JlitWF1LIu/HPUSH3daNYN4+fp6VtqeXSfqI5sxUU+9/Qh+nbWJ052oJDlEWLESSO
	e7h0iTKR/lpNzZwuJ23Q4LC0MiqHjeilK1PGbv/PrVA/JpNCYpf1tK9B+YqVES6vN137X9cfjXj
	xPZEpuMvrPKbcF5RUOXRwIZO7f9e6Y8lPAf1d8pnKq/4XBmGtrEMVANNe/2wknXS2ykZHugoT2/
	Cc1sjtdLAeznVrUCnaRkZ4Bcok2Gwy5GtdmR66qsDmPA==
X-Google-Smtp-Source: AGHT+IGewbzzACbz+R3T10DzhIm1NjxFpcGt/OrLZBO8zUZAHjV1kH3/qUha3rVtR/ME8P5mNn9qSD78BI5d
X-Received: by 2002:a17:903:15cf:b0:294:fc77:f021 with SMTP id d9443c01a7336-29d6844df2amr26905525ad.49.1764761886502;
        Wed, 03 Dec 2025 03:38:06 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-11.dlp.protect.broadcom.com. [144.49.247.11])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-29bce45105esm24103085ad.21.2025.12.03.03.38.06
        for <stable@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Dec 2025 03:38:06 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-7b82c2c2ca2so10167470b3a.1
        for <stable@vger.kernel.org>; Wed, 03 Dec 2025 03:38:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1764761884; x=1765366684; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ro7+YwmIoalPwjaMMWSCKwPO9uGBD09bCG2MDV1ZR4g=;
        b=A1z6sc8ioNjYogtVIRORSBKsknrDtI9z2F8/+DIgRi6zxsly+hnNnboWIU3BcfIJiR
         qS9QBMb4Kri31duy0yfghEDuhtzjqumaqfUi2ODpv64/HJ3q0vHYeYnDmRo+ehmJvhJa
         zbOppR/t7wgfgix4nIOJs/9mVRXwgUw67xnGI=
X-Received: by 2002:a05:7022:6094:b0:11b:ceee:b760 with SMTP id a92af1059eb24-11df0c3b2ebmr1658977c88.23.1764761884331;
        Wed, 03 Dec 2025 03:38:04 -0800 (PST)
X-Received: by 2002:a05:7022:6094:b0:11b:ceee:b760 with SMTP id a92af1059eb24-11df0c3b2ebmr1658939c88.23.1764761883776;
        Wed, 03 Dec 2025 03:38:03 -0800 (PST)
Received: from photon-dev-haas.. ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11dcb03c232sm83169465c88.6.2025.12.03.03.38.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Dec 2025 03:38:03 -0800 (PST)
From: Ajay Kaher <ajay.kaher@broadcom.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	linux-kernel@vger.kernel.org,
	ajay.kaher@broadcom.com,
	alexey.makhalov@broadcom.com,
	yin.ding@broadcom.com,
	tapas.kundu@broadcom.com
Subject: [PATCH v6.12 0/4] sched: The newidle balance regression
Date: Wed,  3 Dec 2025 11:20:23 +0000
Message-Id: <20251203112027.1738141-1-ajay.kaher@broadcom.com>
X-Mailer: git-send-email 2.40.4
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

This series is to backport following patches for v6.12:
link: https://lore.kernel.org/lkml/20251107160645.929564468@infradead.org/

Peter Zijlstra (3):
  sched/fair: Revert max_newidle_lb_cost bump
  sched/fair: Small cleanup to sched_balance_newidle()
  sched/fair: Small cleanup to update_newidle_cost()
  sched/fair: Proportional newidle balance

 include/linux/sched/topology.h |  3 ++
 kernel/sched/core.c            |  3 ++
 kernel/sched/fair.c            | 74 +++++++++++++++++++++++-----------
 kernel/sched/features.h        |  5 +++
 kernel/sched/sched.h           |  7 ++++
 kernel/sched/topology.c        |  6 +++
 6 files changed, 75 insertions(+), 23 deletions(-)

-- 
2.40.4


