Return-Path: <stable+bounces-208037-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DCBDCD10B4E
	for <lists+stable@lfdr.de>; Mon, 12 Jan 2026 07:34:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 228163047668
	for <lists+stable@lfdr.de>; Mon, 12 Jan 2026 06:33:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 587F530FC37;
	Mon, 12 Jan 2026 06:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="XU4tbbCu"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f226.google.com (mail-pl1-f226.google.com [209.85.214.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3104213E89
	for <stable@vger.kernel.org>; Mon, 12 Jan 2026 06:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768199629; cv=none; b=BYTQ33SeMdwpWG4x5XiC7RVQ7BzLqLc4zVKgtjpQqacL6ZdX4CRlpdOzSeZNrsp/dsMCWZCz8OupIG6ZnpwspodtEUVF7yrRmIqZMFUEVPfRkeUGM3K3/NoJ7PEIlzMQ4qK+3uxailZajaTGxLg2JxSX5Iceb/S8nFMR0Qc6H2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768199629; c=relaxed/simple;
	bh=hADIlBZYtdDPX5eqQOXYz6UWY5u+6lD/06flIKFJ18E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=O8BM0lBxbp9UJPWzT94SjIFbztg0QNY5Py78z8NNl8DWzJrsYUc1tHpAFKrKWOpaogd0rjUrJwEcPcoPv7pRczh7oa8/g5CAWCLcJCfBgDmNaS2HQqN1UCC7D6AnOnIjof4IuQNV1if1Xdkiubp1OkcXZaD9gnISoTt72mtAEN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=XU4tbbCu; arc=none smtp.client-ip=209.85.214.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f226.google.com with SMTP id d9443c01a7336-29f3018dfc3so16002365ad.0
        for <stable@vger.kernel.org>; Sun, 11 Jan 2026 22:33:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768199627; x=1768804427;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1UzlbmQPdy52FJ6wYnKqwTgesgoqrerCYySfqK64xSQ=;
        b=sMb+GgXygN1cCYJXp4NeVjpHZUZYAoVW3afwfWr5qboHCgYifExUPQU/XOqCuyKgSr
         2vZpZRM/5OfZFi8uunuEHFrSajvI1LAuVO+8RiZZceZdemtBbylGNEmWTZjfOJU8BzM2
         biss37sse3ga72NKvTrsSOZFfDlPKKJB6xCVKVh4mI+HiMYALla6HqawyfrmaHgYgdWZ
         qxWPmtklPqe5Rig5D6DOh6cTNz472FP3lLrvsGDY+hGKBHoPcClESiEqsePgxpQZHtpO
         RI3c5PPGSYTQ4j8m3XIp4494JhJhdeXeaDdqd40Vph5QFhrln4Y/JFR3R8POSGMZmWRk
         LFQw==
X-Gm-Message-State: AOJu0YyQmtLGMAFJ4F9cxqIpbXZa5tpDKoa/cUp6YFnSzEorAD6YCyIZ
	q+BhEsRxsGg7GYHW+PLqEmC6R4y+2mpKQ5l7DVPWskprH7wVziJ8ytHewsvSigL5VBE1+TyH1/B
	jVEuDW53VN/OgQZOwfQ1YXE9TzUcNbALJfxYWFKZ0uFqT8opkuvWv430wPCcgSh1OyFTviz7A2J
	spBzcSUqJ41KcUbMJX86mWN5v/2j/Q424vPzKiPUMkpFo7Yj3ZfKYI4CSlGrL87yOTnkjP5wQT+
	LjOMMPu9qoJpld0dHV/QTaGXbP8SS4=
X-Gm-Gg: AY/fxX7+WUHxTBAt/rQsG6T2/j4X+Ft0sP5JZ2n1JleHNfBOwrDVvlExO3KuUlPfSyX
	TFF7PJczViqLEj0Fu9wDiZPXGL7S95TpkAh5gbLmSS94vZez2ZUN1Z7Paha9PSwtWwprky3QcBp
	B5lPwGIAwViVor7VTvXAVrhfTFfQIOGFZ0YT086yzMBxKXE0LE6OVIpJLCpXJ4XJ53yhThGdS2S
	mHDvdB+vqrQD1zRNnG9L7StRYo89ufRm+OL8Chup1yzwCWzjijwiIIigsQ+dPUEIrcedeoLQs5n
	/BopeX687UPxIN2D4MzqiPDbLENILSCScfZtvubJGFpThydYu9TMqbCRtXpTS7Ae7Olxpr8v1cn
	7lC/pFYPIAwfQGvUDbsAnwOPAYWp7tpqQykt2s8h/ld0yTItaRhL8ZFIL1IWOtqEL1YpO9cA5aA
	amzYmq63UbDH80I/6vzJi/8cIVtzNoqnDoXKF3UeWTX7+1qfSC7Wwou34SBxUti54o
X-Google-Smtp-Source: AGHT+IEMHv/3n0wmpKSG3QyPxSGy7xqlI6xvrbMEq+z9E5tx8n3pGFUXsjnKzqOZyJ6EquL7kn7hWPrP6lC8
X-Received: by 2002:a17:903:244e:b0:298:535e:ef34 with SMTP id d9443c01a7336-2a3ee4916ffmr119813315ad.5.1768199627201;
        Sun, 11 Jan 2026 22:33:47 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-118.dlp.protect.broadcom.com. [144.49.247.118])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2a3e3c3bd06sm20495715ad.2.2026.01.11.22.33.46
        for <stable@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 11 Jan 2026 22:33:47 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8b5ff26d6a9so129042285a.0
        for <stable@vger.kernel.org>; Sun, 11 Jan 2026 22:33:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1768199626; x=1768804426; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1UzlbmQPdy52FJ6wYnKqwTgesgoqrerCYySfqK64xSQ=;
        b=XU4tbbCupw0FbbNLf2BlGVoXOJwO2ULYuVAfFlj79A5O5VDYm0R+FkgDuE+BdAy02m
         uUId3s1SO/sQ6l9KdAL2yfaF+FhXxezbgGFCZalzWwciXpifP7cruxaQaa8J7BMfdc7f
         L4aCZ7EXqX3lM6xGJyiCwI2Ho/6qXP0iKAddg=
X-Received: by 2002:a05:620a:d8d:b0:8a4:5856:e106 with SMTP id af79cd13be357-8c3893699c7mr1930992385a.2.1768199625774;
        Sun, 11 Jan 2026 22:33:45 -0800 (PST)
X-Received: by 2002:a05:620a:d8d:b0:8a4:5856:e106 with SMTP id af79cd13be357-8c3893699c7mr1930988785a.2.1768199625102;
        Sun, 11 Jan 2026 22:33:45 -0800 (PST)
Received: from keerthanak-ph5-dev.. ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c37f4a794bsm1472324885a.9.2026.01.11.22.33.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jan 2026 22:33:44 -0800 (PST)
From: Keerthana K <keerthana.kalyanasundaram@broadcom.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	yoshfuji@linux-ipv6.org,
	dsahern@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	borisp@nvidia.com,
	john.fastabend@gmail.com,
	sashal@kernel.org,
	leitao@debian.org,
	kuniyu@amazon.com,
	willemb@google.com,
	jramaseu@redhat.com,
	aviadye@mellanox.com,
	ilyal@mellanox.com,
	ajay.kaher@broadcom.com,
	alexey.makhalov@broadcom.com,
	vamsi-krishna.brahmajosyula@broadcom.com,
	yin.ding@broadcom.com,
	tapas.kundu@broadcom.com,
	Keerthana K <keerthana.kalyanasundaram@broadcom.com>
Subject: [PATCH v5.10.y 0/3] Backport fixes for CVE-2025-40149
Date: Mon, 12 Jan 2026 06:30:36 +0000
Message-ID: <20260112063039.2968980-1-keerthana.kalyanasundaram@broadcom.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

Following commits are pre-requisite for the commit c65f27b9c
- 1dbf1d590 (net: Add locking to protect skb->dev access in ip_output)
- 719a402cf (net: netdevice: Add operation ndo_sk_get_lower_dev)

Kuniyuki Iwashima (1):
  tls: Use __sk_dst_get() and dst_dev_rcu() in get_netdev_for_sock().

Sharath Chandra Vurukala (1):
  net: Add locking to protect skb->dev access in ip_output

Tariq Toukan (1):
  net: netdevice: Add operation ndo_sk_get_lower_dev

 include/linux/netdevice.h |  4 ++++
 include/net/dst.h         | 12 ++++++++++++
 net/core/dev.c            | 33 +++++++++++++++++++++++++++++++++
 net/ipv4/ip_output.c      | 16 +++++++++++-----
 net/tls/tls_device.c      | 18 ++++++++++--------
 5 files changed, 70 insertions(+), 13 deletions(-)

-- 
2.43.7


