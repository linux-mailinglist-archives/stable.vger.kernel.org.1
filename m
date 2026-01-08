Return-Path: <stable+bounces-206277-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7918AD04648
	for <lists+stable@lfdr.de>; Thu, 08 Jan 2026 17:31:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 59D6234B3FC8
	for <lists+stable@lfdr.de>; Thu,  8 Jan 2026 15:21:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B6FC40757E;
	Thu,  8 Jan 2026 09:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="JLAQlQBy"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f100.google.com (mail-pj1-f100.google.com [209.85.216.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C914B3FB54D
	for <stable@vger.kernel.org>; Thu,  8 Jan 2026 09:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767863488; cv=none; b=fy6RrBjhPFlFv+6PFesBhy8ES04vqhC30oB0idjeQJvggwmWQXjin5FeL9WcTU5Su+UtHX4R1qwFbJoYtObzprjVK9GEd62CSmiEWb5BHnFIOWK6qnjzhs94jRIJ+Ty6JT4ByQjqmX35V4slRiDtc8aaEQEG24DDHo+2IlpG6io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767863488; c=relaxed/simple;
	bh=8fQdgmUzZT4hVKpr9jFPYQbv3E5T9OAys5UPv6T1pwE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=usUtq7zwk7rwED4r+cdXFY8EcP96N7wBaGrY3TamM2uK8Hv+Y1LYoktRbR7ktt1fZVWjVcqQwclgGZ5OtprOp7A5BgtHTmVF1PEsFHwWL4QSA7cMVDhVW29/yzT9TDy7WO0UXESFr61jN95c1NtR9Jh6WMT+865ERlD9NaaqOXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=JLAQlQBy; arc=none smtp.client-ip=209.85.216.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pj1-f100.google.com with SMTP id 98e67ed59e1d1-34c71f462d2so2606274a91.0
        for <stable@vger.kernel.org>; Thu, 08 Jan 2026 01:11:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767863482; x=1768468282;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iWhuEUJvySClc1pNw5XM1BE2jKG4GXhmun5GIk0jrU8=;
        b=E27u5Bpxrhdn0p+DxtfZrqCT8gW4/imDUnHGgREcY+4rg/mqmJvVN7d64cKpgNqS6t
         pbpN4USPGSBG+DP+feO7YqnJkGsER+kdkaeIPh0WNAKCpMOvDTjGicZDH2148uxZpZlI
         vC2S+V/HUWiyEKlm8lDsiM9j7uMxIKU1ks9sKRHhf5V+rTb6/5raffONk+PplXOmZbH4
         fJsVPSZhBNGp5CLWL7BR2HxC1RhDKACHkz3tPQzQ3JeHQ6VDYtZQ1P6Erqje2idcGGpK
         lWIae0MjPKb+ZrDtnjV0qfjVKXTIJd//Z81SSdJv/0338xyR2zN8vEhEv9twgaDgrChV
         9ELw==
X-Gm-Message-State: AOJu0YwdLkpDCDnzeUA+nT1nbg0sJ1Gvok1f/odTCGpIqZ1hmfftHbD/
	XP/M5SV1knMq3jsL3IpPbNbhWT2g6b630r/zrpALSeBHlOb9+j2GxSOS4ogh/omxnE8BEQdnAva
	K3Ce9eHCoSnxBj0HXHAxGRT2LkKHofk2Nb55HmwuWRAKY/6Cnx5SA8sldxQnGYwndKdRDXLb6Kl
	wxurccZc6aqQ5Z36cxVgLeQnq+xpMrLqTbsNL4cTV0xw8MUkg2veSvSNJkEZSCpaFSEl1gAkkbP
	Dv0uRdUaNengadQLA==
X-Gm-Gg: AY/fxX7d7yJJ/yuLKpcl84FFCp2u27tw0nPdJfU1eG/JYtarluYduMVIdMHFNH7uhCL
	MaLEU2RhsGddBEDsD4alU0lcrOgpmcJ48G73ptb7nnxwHScfhvpDXMTo6+iTdk/cxVtHhhF+yVq
	rh2XkNzJC/6rb7j+yVIrds61WP39XwPBT6CzzzeTJg8Clmt2kj5PFBd8m127YtnnECt0eernYLE
	v8q5b0MfsKql3tgu18eSC36SNPSg0fm1i/Gje/rfaHO55a1g3suQgrvDcW+3W+42F76kElnzoKV
	aBpVhU9CgihTWbh/AmYu5BNgJv1mgyssNCfVKJ63Za3CLZoWvA3waJTXOFENqrxdJ4KaecxvA0C
	unGQ5RHLaBt/gt/6N9+AM4RC96/eM+LEHVvYanVHzWjUyAtXz8NUv0c5qSw65KGJZW3KkthCr3O
	5/NXlfOU26/giky7o6jtI/TngXOFg/wtn8V6MjdQL4SlMsfQ==
X-Google-Smtp-Source: AGHT+IHtGrvAWbdXRBLpuZILMV/2yfKVTI3bdaJWeTgBKWUZdPeDDAP9Zp9wXf/bonwNj79CAmLnhBd7xq+0
X-Received: by 2002:a17:90b:2fc8:b0:341:88c9:6eb2 with SMTP id 98e67ed59e1d1-34f68c7a6bbmr4858376a91.1.1767863482206;
        Thu, 08 Jan 2026 01:11:22 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-1.dlp.protect.broadcom.com. [144.49.247.1])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-34f5fb28679sm974710a91.5.2026.01.08.01.11.21
        for <stable@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Jan 2026 01:11:22 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-2ae26a77b76so2547991eec.0
        for <stable@vger.kernel.org>; Thu, 08 Jan 2026 01:11:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1767863480; x=1768468280; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iWhuEUJvySClc1pNw5XM1BE2jKG4GXhmun5GIk0jrU8=;
        b=JLAQlQByMejk6AFDPTgNcWd8E8n5BhztWVLiT1jj1qere92jyYTHTZXtWwTR4b9sSq
         uNvlzHng0ceA3wfGMwTqB/RLBM+LaOaxQIPEV0SaEJWgchhjgfiUgxH47H7bWQGNOETa
         Djtv633QEncK3SQkuhwypk6I02wxZpuHkIMjA=
X-Received: by 2002:a05:7300:6916:b0:2ae:4f61:892e with SMTP id 5a478bee46e88-2b17d2c9a9bmr6109040eec.36.1767863479754;
        Thu, 08 Jan 2026 01:11:19 -0800 (PST)
X-Received: by 2002:a05:7300:6916:b0:2ae:4f61:892e with SMTP id 5a478bee46e88-2b17d2c9a9bmr6109011eec.36.1767863478946;
        Thu, 08 Jan 2026 01:11:18 -0800 (PST)
Received: from shivania.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b1706c503csm10623374eec.15.2026.01.08.01.11.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 01:11:18 -0800 (PST)
From: Shivani Agarwal <shivani.agarwal@broadcom.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: mathias.nyman@intel.com,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ajay.kaher@broadcom.com,
	alexey.makhalov@broadcom.com,
	vamsi-krishna.brahmajosyula@broadcom.com,
	yin.ding@broadcom.com,
	tapas.kundu@broadcom.com,
	Shivani Agarwal <shivani.agarwal@broadcom.com>
Subject: [PATCH 0/2 v6.6] Fix CVE-2025-22022
Date: Thu,  8 Jan 2026 00:50:19 -0800
Message-Id: <20260108085021.671854-1-shivani.agarwal@broadcom.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

To fix CVE-2025-22022, commit bb0ba4cb1065 is required; however,
it depends on commit 7476a2215c07. Therefore, both patches
have been backported to v6.6.

Michal Pecio (1):
  usb: xhci: Apply the link chain quirk on NEC isoc endpoints

Niklas Neronin (1):
  usb: xhci: move link chain bit quirk checks into one helper function.

 drivers/usb/host/xhci-mem.c  | 10 ++--------
 drivers/usb/host/xhci-ring.c |  8 ++------
 drivers/usb/host/xhci.h      | 16 ++++++++++++++--
 3 files changed, 18 insertions(+), 16 deletions(-)

-- 
2.43.7


