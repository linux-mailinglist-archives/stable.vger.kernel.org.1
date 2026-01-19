Return-Path: <stable+bounces-210287-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A6595D3A30B
	for <lists+stable@lfdr.de>; Mon, 19 Jan 2026 10:30:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 54CAC3041A48
	for <lists+stable@lfdr.de>; Mon, 19 Jan 2026 09:29:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36F9E355817;
	Mon, 19 Jan 2026 09:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="KRoi2aIG"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f228.google.com (mail-pl1-f228.google.com [209.85.214.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B838835503C
	for <stable@vger.kernel.org>; Mon, 19 Jan 2026 09:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768814970; cv=none; b=CuwyiXZFZR3+C72LTN2Rr6iTiqBBxDVdra/gqUFbVcqbzndZHIDnUF15+OuSFhNkNtL0slyL4LDQn6doLwMrpMQ/LaRqtyzttYY9D1gSE/aT0Ol4ZAv3BYYgSMhTXT7k0+bp6CkcnWsmTwaBnPKO/XxhHYm4vz0FFhocLCZ9w1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768814970; c=relaxed/simple;
	bh=MZykRSDyhj30BjSCq2J6ccjOwanVT2N1C0ACoeLLSSI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cDh+rpC4YgqLTv9DzrOTUkZdvo67Dpa7hgVRi9LVMtghOgTk773zrtsOUodprhhU/MCA55u6UchNEc9zbT78H+UQ3vVQRlPsFfk40zK0b1Sc2YHqjuofW6OUskZxM8ervtX3apYq1Gni2CXoAMYuofXpW8TM2HN3oVZGw9RgDjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=KRoi2aIG; arc=none smtp.client-ip=209.85.214.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f228.google.com with SMTP id d9443c01a7336-2a08cb5e30eso8690315ad.1
        for <stable@vger.kernel.org>; Mon, 19 Jan 2026 01:29:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768814968; x=1769419768;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fCyc417zI+LatXSOTwvS8SNjJytYpjkoBZeOlVPfO0U=;
        b=Noo/3t/n9orJ3OFRi7AS3u9ksFgwrhS006J23Ra7tu+1YC/hYtLHqU0kogs0kdFMns
         pi9sdrMnlyE4g+hBW38XDU/cPbQGaWYd36rRKBuRWoP6uhWEp8/EIEFUjUnTJGKJnJNe
         /tUl5gdp4Kd/sLPHdIoRF3uAipxf37I4pZIxeR6RSGDpaTlr12i6K2/gUz6zaNIF+jd2
         1ynfQyOF5Ac9lk3cFWV8oF2W0CI6WgXv1oqph4DI6XfaKR2TXqPOYLGYz0u+7QjDfnnl
         PSthgXEd4QJAPqdn1uYdmGNy9D8mfY5A+Nd3KYrQFJoYH+m4mkA9aqxwBPEhtBstNGTZ
         M5tw==
X-Gm-Message-State: AOJu0YyJ8R0Gr02r5+Tv9v+RLTm+6p748ch28KzSBUTA4NVfjv92zJJY
	iF0JwndMcbsAWb8orUYVEgw3Rkn2sxL1r/EdOzOw3H6AjTp+AQfW1V7bYIpjNsSxDI7v7tuyupM
	jDZbz3VwrfrPdHnkoi0MIvx6DOhk6IN6ViMoQ9+xk9Wn74f91dWYdWNzRSEg0zQ8L5AqNtv0XdH
	lnvuX5WhKr3TvPGY83ihb/7m9CGFM92jevbDuCsCXLD1SJnkusnPh93LAMDam3/JdGmq1KcTs87
	r3odJSFSHGZafTD+jyiac4QWpbj2Yg=
X-Gm-Gg: AZuq6aJ5Spa4lG/+gADCvRCGjh8Ezlf1epFBiUKtHz1eEO/jfMnvq2ek8o7sq/jqbI8
	PHDG9ymOcmKF1ZTeYzhCpuMz6aP84NHE9wN9UAn9xBu3VBvsuTSMybV9Hlmh1SjinzlLCKn5zAI
	IG/Mjo//1AFenSlQ7BZdIYxNT/3/+gF+3TJLlZKmEv4BVD1pxQxBf6O2b3eI+lTj8c/KlmmK0Hp
	AwoMtW5+Jw2+DvJw8vN3yyBkh46wZJ5p/6eJTJOfcY52pblejGbmM7NQawmhuddqJ9I7HZWXMTB
	oF7Q9xaLG7FzQYjXRfXrNmlzUm8z3GbRrnpTADMged4B+IaDVU2BhqQQ7+QUWyGyKofGV7Z8uKl
	42DpQuHbvRhKgThlbHWusiZWrHcb1t+gJN4EQo7D0tkWh8tsyJ2d68PodxvJIJNfmq4P720rm5h
	cw01PqljnBzL/b1Sv21At9VbvdQZRXYkmRBLrcFu/JfqJx8Ns45j9jnCg00nCc5CaK
X-Received: by 2002:a17:902:f54a:b0:29f:2df2:cf49 with SMTP id d9443c01a7336-2a7175aa573mr74018555ad.5.1768814968094;
        Mon, 19 Jan 2026 01:29:28 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-118.dlp.protect.broadcom.com. [144.49.247.118])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2a719190943sm13938015ad.31.2026.01.19.01.29.27
        for <stable@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Jan 2026 01:29:28 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-88fd7ddba3fso18663766d6.1
        for <stable@vger.kernel.org>; Mon, 19 Jan 2026 01:29:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1768814966; x=1769419766; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fCyc417zI+LatXSOTwvS8SNjJytYpjkoBZeOlVPfO0U=;
        b=KRoi2aIGi2A1wPo6877aWaCxHp0Evo2+jceFRpB0iJXDhNF1f3hc7pYpRCHy6fSUnf
         H2xC9VmunsMLQ08p9BfA1z+aiQa1NdgHzGHAJ+y+idjdiAlw7Xp7h01CLvMyGU+lQ0Ar
         Hd9PboRF8IWvi7JA5Rn8nZMRnz4hzNSFtr6eQ=
X-Received: by 2002:a0c:e013:0:b0:888:3237:6fce with SMTP id 6a1803df08f44-8942dd8fad1mr137606306d6.4.1768814966244;
        Mon, 19 Jan 2026 01:29:26 -0800 (PST)
X-Received: by 2002:a0c:e013:0:b0:888:3237:6fce with SMTP id 6a1803df08f44-8942dd8fad1mr137605946d6.4.1768814965846;
        Mon, 19 Jan 2026 01:29:25 -0800 (PST)
Received: from keerthanak-ph5-dev.. ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8942e6ad6f3sm76917516d6.36.2026.01.19.01.29.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 01:29:25 -0800 (PST)
From: Keerthana K <keerthana.kalyanasundaram@broadcom.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: j.vosburgh@gmail.com,
	vfalico@gmail.com,
	andy@greyhouse.net,
	davem@davemloft.net,
	kuba@kernel.org,
	kuznet@ms2.inr.ac.ru,
	yoshfuji@linux-ipv6.org,
	borisp@nvidia.com,
	aviadye@nvidia.com,
	john.fastabend@gmail.com,
	daniel@iogearbox.net,
	ast@kernel.org,
	andrii@kernel.org,
	kafai@fb.com,
	songliubraving@fb.com,
	yhs@fb.com,
	kpsingh@kernel.org,
	carlos.soto@broadcom.com,
	simon.horman@corigine.com,
	luca.czesla@mail.schwarzv,
	felix.huettner@mail.schwarz,
	ilyal@mellanox.com,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	ajay.kaher@broadcom.com,
	alexey.makhalov@broadcom.com,
	vamsi-krishna.brahmajosyula@broadcom.com,
	yin.ding@broadcom.com,
	tapas.kundu@broadcom.com,
	Keerthana K <keerthana.kalyanasundaram@broadcom.com>
Subject: [PATCH v2 v5.10.y 0/5] Backport fixes for CVE-2025-40149
Date: Mon, 19 Jan 2026 09:25:57 +0000
Message-ID: <20260119092602.1414468-1-keerthana.kalyanasundaram@broadcom.com>
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
- 5b9985454 (net/bonding: Take IP hash logic into a helper)
- 007feb87f (net/bonding: Implement ndo_sk_get_lower_dev)
- 719a402cf (net: netdevice: Add operation ndo_sk_get_lower_dev)

Kuniyuki Iwashima (1):
  tls: Use __sk_dst_get() and dst_dev_rcu() in get_netdev_for_sock().

Sharath Chandra Vurukala (1):
  net: Add locking to protect skb->dev access in ip_output

Tariq Toukan (3):
  net/bonding: Take IP hash logic into a helper
  net/bonding: Implement ndo_sk_get_lower_dev
  net: netdevice: Add operation ndo_sk_get_lower_dev

 drivers/net/bonding/bond_main.c | 109 ++++++++++++++++++++++++++++++--
 include/linux/netdevice.h       |   4 ++
 include/net/bonding.h           |   2 +
 include/net/dst.h               |  12 ++++
 net/core/dev.c                  |  33 ++++++++++
 net/ipv4/ip_output.c            |  16 +++--
 net/tls/tls_device.c            |  18 +++---
 7 files changed, 176 insertions(+), 18 deletions(-)

-- 
2.43.7


