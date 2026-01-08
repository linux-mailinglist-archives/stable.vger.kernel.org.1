Return-Path: <stable+bounces-206302-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E3EDCD0460F
	for <lists+stable@lfdr.de>; Thu, 08 Jan 2026 17:30:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5063030B3A7E
	for <lists+stable@lfdr.de>; Thu,  8 Jan 2026 15:19:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C8092D1907;
	Thu,  8 Jan 2026 10:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="E6oUwL5I"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f100.google.com (mail-qv1-f100.google.com [209.85.219.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7912D48E8E2
	for <stable@vger.kernel.org>; Thu,  8 Jan 2026 10:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767868010; cv=none; b=nLpINbzq4gJsExAdaGzOkIAeRtuo1w/UawRdufUJDTQ+gUrNlldvaY9a1s4FbO8cFgPqS9l32OMySDdO+S3o0w4t4+fEQbYQm/2I5M99t36wu9s4TLOGhY47SCFh2sPFrNW5h1E9OhVr17un/xtiN0T+VmKwlMWnUjAvFf5sKt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767868010; c=relaxed/simple;
	bh=yDM0MYcN44C4fZWfKAiNXGBUoTkQhc/bAsbUtdLeolo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=d4xpU6h3TH7bmw4vo+Etgg08b1+snMLnMZ8PtFd1oo1Zv6oYt9oIblQly4ynUy4pHOR/AXnv09NSm1c/vAY+pmqfZTbFB7CF2qapbDIaFdRvyvTKfWhuiLxShYC9gmEjn2RWEvDlRIyb51s1bNokWHKbVM1bTHVuIx+JoH47Zmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=E6oUwL5I; arc=none smtp.client-ip=209.85.219.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qv1-f100.google.com with SMTP id 6a1803df08f44-88a26ce6619so29331796d6.3
        for <stable@vger.kernel.org>; Thu, 08 Jan 2026 02:26:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767868002; x=1768472802;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5FCB3AHMmrGnbZZnftF4zn0nkPwbHqYdVOpZ4CrAVgE=;
        b=Ti3fzm/pzGMc1cb04YjP5t3r6iNpNx+KZTMZ4VWzL2cTSnLygAmKdngxPEriWqlpG4
         w4KxBYLD10Qa3Ia5aH7l0W7u5VV18C3zar2dVT2mx1Yu9jSW/4cGgXSnbbhijlieGl7N
         Mkf1J66u5sPhA9naFLshQOcMVDv39f9oizfX1hkds12L09SsMN5RDB+7UtXDdn1ImEW5
         utKDg0/RdJq8UQYCZqh1CBB/aLnV+mg3CdLGB5pYM1TjUNj6LVV/GMhz62+uNAqczmKr
         b1ekUkqCdzzs9r/J8oZks8e+33ZODdeiWryNad3qqN4+T9h6ziPWUd2bh1KKWXk8eSfg
         JzNw==
X-Gm-Message-State: AOJu0YxjOWvsF3tg6CeRF1uYYSX4e78BT64tz3PobCB/jW5vcROEKxzM
	1Ck3I4r7TCc88q+OVV0LWFffyv8GSjKt999BEHl5bvghfCF1AJpC0E4w7lPtQCfxCaLz5clQlRc
	+EH0YzIKDQXo9jUo1Mq20hyOIPBLqm9WY8DgTyz/8y/DtAQQOCqdrvof6oBmcehVGP5kkIT31OS
	CP6cC5ggKk4v9eO+Og6zGxS0AkERjlO+hpRFg9tTAB5E9F95ClcvA4XEAT10jyXckibMBiSFrpE
	BpJgmoTX97P/9ezTA==
X-Gm-Gg: AY/fxX4to22/i3UET9wi1cPJf9UkSonyvIAl3ZJNODrfcg4Zm7Dfv8qQUgNgLqodyfN
	FkN3VJJgd5L8ltfBuK7S11sk6reKY7BB7gvMqKo3y91X6y0Y9DNQbqJbK+nkGsIF6KHwqPoMX4y
	q+AAucCth9fcfD9tXCqK9aitAGYwAG/1a/4rmvCYF3Kzv/K1E3roOO2h911RjsRZglxwPJDnXKk
	jYIRLQBI/zeDvqKP/or3778JXfsbnDcJVEPodM2CwRcL8Jocs7WVwUqAe6i09AGP0SNpInY3BZ3
	YiSHgiEqRLuKa1UvNrw8CvStd6NcI53zmQMWI5UGyW3sZNm5ti+DPweSVGDvNTIONkkFRHcQL2r
	dp2KwOazsosTsT8ifIOiCST7ZYMeXBlxSHrjje+mgqiJ99k8EkjjsdIgYFoBja76Ut6JLbeNhaB
	eGYewQglKL3OsfGJ6aDz4c/LNblBQwVAmWShCLrQh3XDlNRqc0uKA=
X-Google-Smtp-Source: AGHT+IEVK4bbDFWSXgdIqrTTESj3yj5ORD9kAyYVZTBeaN8odal4uFq2RWlUnH/283k9nCK6uMRbzFrq4nig
X-Received: by 2002:a05:6214:4302:b0:890:398b:1104 with SMTP id 6a1803df08f44-89084271444mr80925176d6.36.1767868001837;
        Thu, 08 Jan 2026 02:26:41 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-120.dlp.protect.broadcom.com. [144.49.247.120])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-8907712f2e3sm9422726d6.24.2026.01.08.02.26.41
        for <stable@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Jan 2026 02:26:41 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4ffc5f68516so4019401cf.2
        for <stable@vger.kernel.org>; Thu, 08 Jan 2026 02:26:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1767868001; x=1768472801; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5FCB3AHMmrGnbZZnftF4zn0nkPwbHqYdVOpZ4CrAVgE=;
        b=E6oUwL5IgUJmbtRLMsnStQaEQeGPcILGS4UvluX+LynW801mb70cocX2dVfGJsgktD
         JQcUriHRozaMFTUBL+G7ZXgN7wbCvqXwM32hIvybn1OnU+VdrsAbbsMn2K6br7p+7BtD
         qfBIhJ7R2y298jZ9ynwB/gs4W3UgoHpv5Aqac=
X-Received: by 2002:ac8:58d3:0:b0:4f1:ca48:cd3 with SMTP id d75a77b69052e-4ffb4ae8c91mr75598871cf.80.1767868000719;
        Thu, 08 Jan 2026 02:26:40 -0800 (PST)
X-Received: by 2002:ac8:58d3:0:b0:4f1:ca48:cd3 with SMTP id d75a77b69052e-4ffb4ae8c91mr75598451cf.80.1767868000105;
        Thu, 08 Jan 2026 02:26:40 -0800 (PST)
Received: from shivania.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4ffa8e362fdsm45124721cf.21.2026.01.08.02.26.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 02:26:39 -0800 (PST)
From: Shivani Agarwal <shivani.agarwal@broadcom.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: jgg@ziepe.ca,
	leon@kernel.org,
	zyjzyj2000@gmail.com,
	mbloch@nvidia.com,
	parav@nvidia.com,
	mrgolin@amazon.com,
	roman.gushchin@linux.dev,
	wangliang74@huawei.com,
	marco.crivellari@suse.com,
	zhao.xichao@vivo.com,
	haggaie@mellanox.com,
	monis@mellanox.com,
	dledford@redhat.com,
	amirv@mellanox.com,
	kamalh@mellanox.com,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ajay.kaher@broadcom.com,
	alexey.makhalov@broadcom.com,
	vamsi-krishna.brahmajosyula@broadcom.com,
	yin.ding@broadcom.com,
	tapas.kundu@broadcom.com,
	Shivani Agarwal <shivani.agarwal@broadcom.com>
Subject: [PATCH 0/2 v6.6] Fix CVE-2024-57795
Date: Thu,  8 Jan 2026 02:05:38 -0800
Message-Id: <20260108100540.672666-1-shivani.agarwal@broadcom.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

To fix CVE-2024-57795, commit 8ce2eb9dfac8 is required; however,
it depends on commit 2ac5415022d1. Therefore, both patches have
been backported to v6.6.

Zhu Yanjun (2):
  RDMA/rxe: Remove the direct link to net_device
  RDMA/rxe: Fix the failure of ibv_query_device() and
    ibv_query_device_ex() tests

 drivers/infiniband/core/device.c      |  1 +
 drivers/infiniband/sw/rxe/rxe.c       | 22 ++++++++++++----------
 drivers/infiniband/sw/rxe/rxe.h       |  3 ++-
 drivers/infiniband/sw/rxe/rxe_mcast.c | 22 ++++++++++++++++++++--
 drivers/infiniband/sw/rxe/rxe_net.c   | 25 ++++++++++++++++++++-----
 drivers/infiniband/sw/rxe/rxe_verbs.c | 26 +++++++++++++++++++++-----
 drivers/infiniband/sw/rxe/rxe_verbs.h | 11 ++++++++---
 include/rdma/ib_verbs.h               |  2 ++
 8 files changed, 86 insertions(+), 26 deletions(-)

-- 
2.43.7


