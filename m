Return-Path: <stable+bounces-210334-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B1B1D3A774
	for <lists+stable@lfdr.de>; Mon, 19 Jan 2026 12:54:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D80D33092543
	for <lists+stable@lfdr.de>; Mon, 19 Jan 2026 11:52:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 163F831A077;
	Mon, 19 Jan 2026 11:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="UxeO3Jbq"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f97.google.com (mail-dl1-f97.google.com [74.125.82.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AC513191A0
	for <stable@vger.kernel.org>; Mon, 19 Jan 2026 11:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768823558; cv=none; b=PIY9xWDN+luZcr9AsYUaWNqd/thxfqlClkbWH6yATcuBRKC8LvcJDTllFQGmJg2FL4twfazXsnODX4GuEGYggforoxQEbT+a3enOKr9z+f2pqSZBG4YbpqD7fRH0+yK67Erc7TaxO0m0E9a1WIbp5dNQN0y2Eq9lmvLahymntzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768823558; c=relaxed/simple;
	bh=uSEkHsH1REtKl3xcr1eJo/cD8PSr1EaGnbXhvaEtR94=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PSzzMZv6ZLLiK6vUCwOBKE5AGU6tYPMt9c0N62Vq1pCZWbAea6hPNLGrPyZJ2kvYScobUSifA27gfBGHDQbd0fiGLiM4mm6ZyPUbDl5TD3EpkvVVaWj1JjpvaoM5WNK44EW32U/cXkF6pfs0N4C3xsprjpfBDvU6VdNLFa+JUcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=UxeO3Jbq; arc=none smtp.client-ip=74.125.82.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-dl1-f97.google.com with SMTP id a92af1059eb24-1233bc11279so246991c88.1
        for <stable@vger.kernel.org>; Mon, 19 Jan 2026 03:52:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768823557; x=1769428357;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dc2NcPIsYn4GHcEHnwWFmYEwoZXJ29FY+pyN3/3N0k8=;
        b=i2IdVEUsJvFliImDe/KMSAECfQS16ooHsGYi5DLG9A/JfvMu7ggORMmXbVO48j6mO8
         2fQkD1E6AoILaD3lxE5yPonQ6z9Mq7b6HwS5tDUfUnlx16QKPnQdiuwZElPJRT6Ds+k2
         Z+xp/cVO7U2OWpAneWvLbiQuCKUM1vcUQhYTuQkrnIJ83YV7HYwHIyx7ijxwWJUqyL3d
         vctJSzKpobY8mHS46/HGCUILTU+UsW6K9U3dJbmRDz+Vt9O1bGDdE2i9VbF67obA+SZq
         uDG9aL62A++QyoTT9X0U1XNlUgP3UwsRO0WX3p6nEJRTSuPtwJkzlf00xnGlq3xDor6P
         hn5g==
X-Gm-Message-State: AOJu0YxqcDv5ZFs+1SMmvsSW1f+stlLbhikZHLZeKc/o2Wed4bctRTIw
	onIbAM+eqCV140DY0hE7mm8BVd904YS0B+O2u+f8QU28TtEn6VdLbDyIvHAPqv/IMy9YpfrF5r/
	bNmyg9wGIiiS7EWted8mJWPhf4ZsssgFB6uTmqoc25uoM/btynN+svqBOHDZgFozJHO0rQIfPFs
	99ukFcHxRTBq++D+sXL/y9Tzfi6ybfEoZrTh7xCdoQDwG6PIlaeEoZJCi86bzW5FlK/k+tOPz4s
	2ub8dJYSzLJ51QV4TQMW1rTXE9t
X-Gm-Gg: AY/fxX7dCdZoi0J5U3UN78IBjIpEWQUwQHHcAjv/dipbRcBiQ9k1T2R0j8Wo3h9Ho2L
	qx9BIwPrkKYuffGXH9j3YmMBZcRLVMeXMtcsIIROF0Bd5sCUx6TnBb3jBBwu6/HEwKrH3UrRcOV
	CoRdvrg+gc2WbEZ+p4ImjqXD3Msgfp3v1YqLR2HCreGQ6lub2PTTDTIsXwZIn5TxZW8K1s395se
	X+Jfav7MSvcEs8KISOhmZRCfwVfnvVssqE3FGwLFIyt1uH4KK2z34oWTigKpuAgOSx32iFOMxvj
	EyGuBZfHXEMNs7B6LjVLuLg3iGC14XPJiRD7nYQZ4gjTgFuVXZywH79r1PGlMYht3lAAjS9AOdh
	Sxgzglt/eGdG4DeOYPY8nNMAtFOB8Dgx1MFJjeCAr4CGE+57SuNACWN1HcMSomNU2d++Ucjdl29
	JbtvPqN1I1KhkFhHRCIm8ZyEKyUMSaCWr2mC7tneZjV+H7NnsLqu+5VJbfGLs=
X-Received: by 2002:a05:7023:d02:b0:119:e56b:46ba with SMTP id a92af1059eb24-1244a7dd744mr4042887c88.4.1768823556509;
        Mon, 19 Jan 2026 03:52:36 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-2.dlp.protect.broadcom.com. [144.49.247.2])
        by smtp-relay.gmail.com with ESMTPS id a92af1059eb24-1244aec712esm2220838c88.5.2026.01.19.03.52.35
        for <stable@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Jan 2026 03:52:36 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8c522c44febso92834985a.0
        for <stable@vger.kernel.org>; Mon, 19 Jan 2026 03:52:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1768823554; x=1769428354; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Dc2NcPIsYn4GHcEHnwWFmYEwoZXJ29FY+pyN3/3N0k8=;
        b=UxeO3JbqnbXagaa7QFNEcZf0J3D1OxQh+2fttI5wqB4e5O1Z+VhtirxwdO6BOHHDSS
         4dy36JY+NXKgQ8vLaZirHMzge6FfSOUIGoStnbud/vY0o4eQveDCtwGlCOB6BjhUI6CT
         HnuvTQ9o7BPZfgAm6TCJSnHZ5vCb5Mi0FSRao=
X-Received: by 2002:a05:620a:178a:b0:8b2:1f8d:f11d with SMTP id af79cd13be357-8c6a6703cdcmr1146997885a.2.1768823554273;
        Mon, 19 Jan 2026 03:52:34 -0800 (PST)
X-Received: by 2002:a05:620a:178a:b0:8b2:1f8d:f11d with SMTP id af79cd13be357-8c6a6703cdcmr1146994885a.2.1768823553648;
        Mon, 19 Jan 2026 03:52:33 -0800 (PST)
Received: from keerthanak-ph5-dev.. ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c6a71bf2b0sm772878885a.12.2026.01.19.03.52.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 03:52:32 -0800 (PST)
From: Keerthana K <keerthana.kalyanasundaram@broadcom.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	yoshfuji@linux-ipv6.org,
	dsahern@kernel.org,
	borisp@nvidia.com,
	john.fastabend@gmail.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	ajay.kaher@broadcom.com,
	alexey.makhalov@broadcom.com,
	vamsi-krishna.brahmajosyula@broadcom.com,
	yin.ding@broadcom.com,
	tapas.kundu@broadcom.com,
	Keerthana K <keerthana.kalyanasundaram@broadcom.com>
Subject: [PATCH v5.15-v6.1 0/2] Backport fixes for CVE-2025-40149
Date: Mon, 19 Jan 2026 11:49:08 +0000
Message-ID: <20260119114910.1414976-1-keerthana.kalyanasundaram@broadcom.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

Following commit is a pre-requisite for the commit c65f27b9c
- 1dbf1d590 (net: Add locking to protect skb->dev access in ip_output)

Kuniyuki Iwashima (1):
  tls: Use __sk_dst_get() and dst_dev_rcu() in get_netdev_for_sock().

Sharath Chandra Vurukala (1):
  net: Add locking to protect skb->dev access in ip_output

 include/net/dst.h    | 12 ++++++++++++
 net/ipv4/ip_output.c | 16 +++++++++++-----
 net/tls/tls_device.c | 17 ++++++++++-------
 3 files changed, 33 insertions(+), 12 deletions(-)

-- 
2.43.7


