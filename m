Return-Path: <stable+bounces-28306-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 65D9087DC22
	for <lists+stable@lfdr.de>; Sun, 17 Mar 2024 01:54:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6EDDD1C21294
	for <lists+stable@lfdr.de>; Sun, 17 Mar 2024 00:54:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AFAE139B;
	Sun, 17 Mar 2024 00:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gel74v6j"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E4FA37E
	for <stable@vger.kernel.org>; Sun, 17 Mar 2024 00:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710636846; cv=none; b=ef0CWKMKyOr00YimVsLZktm9ikdVRoL4yryOaGYLe4BgwKf4xq7q6oJnaia5dTQ8bXBtG7wJ+oIhHOIXxRpBLidCa8whzC/CwneKEZ0dfDa1pZkgf5Ydr8U2g0MRI07tTPusAzOgroZ9VnTI0idNXKzzhQ4/ZMY6Bb2HsHdtPgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710636846; c=relaxed/simple;
	bh=vIs/A+XazvL1ohtZjvGcTwr36WOEGOWrwdzjw74m6uA=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=WV6yYczrA6VO4KatOd0bN6eIyM1kPBdgil68mH/DvygPwaRu4+pIhyShz9DK/zfIJ8cP1teoA6X/a6b3g9hHhmS+tgXwCXzv2+iA2jx5T0HBHyjiSszf25QcIut+MDZ83xa3L5yyg1ED1tAtdt5zVmbP8dMBDblnwmeZkYh/nRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gel74v6j; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-413f1853bf3so20983955e9.0
        for <stable@vger.kernel.org>; Sat, 16 Mar 2024 17:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710636842; x=1711241642; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Qv4qu4ytAzGsKNHM/brlmeQs6UYJHl86QRb9EmrRdaM=;
        b=gel74v6jyozEjd6u3cDOqzZp6SX+f/ttKCeTEOZ+RTa2GdaT9VuY9FlY+cUpH63Xzx
         UCqZM9jSj7BtQ8GBAfj0FmZOUXSN2774/LqzMd3p7IVfEtGzoFngQXuDP738LsXLMgcK
         XiqBIyUMHvDKsF8ok0CarVSdh/Twq5DBtStTKZeVMFLd+RaJy0J/YjC7xj720D/nw4bA
         Hypj3+FJW5PMt+SIemUpdWPlsw7iSksIPEpFb+a4as3hnXHobJffcaY10iY9PBdf8h/4
         5Z3BtAsSD6HfhcXJkcuYRCQFnhJLJ1CTdwdWs5sEjvM6eNFZrQI1zzeA/2ZRoLEr1bic
         r2Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710636842; x=1711241642;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Qv4qu4ytAzGsKNHM/brlmeQs6UYJHl86QRb9EmrRdaM=;
        b=OhGDdrt2ovBi3mECREDfyWwQvEfcPt+8RTyrUq78uNUxbNiPFxBM+7ZZbqBMrPCbfo
         Yy1fBY/jbWvxhK+yjkbb73zlsvenyoiSQbMrvL7IHUkEHrlCepr98LMGJQdExibZMWH0
         qvr+V25rmiSiLwXSYbdgGtmjHYGysEScKT7VLF2f/SzOu6BH+P/Pa1Lb5bUE0s7xKsS8
         l8Gbu40Rh+aEb/lmkMYLreAUD5l3VOrRtjf6V1ef/ONQ4BUfAVlAvnWTG4QKBnx2cI5s
         5lzjDCG5VcqdfMW0PdXYrFsh0OJ4DS+rWU3MeSSmqsjWEBtSCmUQ+/7jn9+/qqBX6rGl
         /ibw==
X-Gm-Message-State: AOJu0YyYl0Hhpm1osNjpEGvwYA3jktlWI7YCL2MPwScTpA+JxDdwVq4m
	Pi+7KlWnzqkKWvBiZ5hBW5DvRiW7DRogzXFXGnWjpjzoTrYZA+R9YH23nj9UZQ==
X-Google-Smtp-Source: AGHT+IEbyYfCekIufaD625t5m/6wEWhBH0I2Uo04OXCQxFWSqpXQK2CMel+7DAuubVyyVAHSI/A06g==
X-Received: by 2002:a05:600c:19c6:b0:413:e531:5ae2 with SMTP id u6-20020a05600c19c600b00413e5315ae2mr6609518wmq.23.1710636841905;
        Sat, 16 Mar 2024 17:54:01 -0700 (PDT)
Received: from localhost.localdomain (77-59-144-113.dclient.hispeed.ch. [77.59.144.113])
        by smtp.gmail.com with ESMTPSA id l12-20020a05600c4f0c00b0041409d4841dsm2049349wmq.33.2024.03.16.17.54.01
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Mar 2024 17:54:01 -0700 (PDT)
From: Aleksandrs Vinarskis <alex.vinarskis@gmail.com>
To: stable@vger.kernel.org
Subject: [PATCH v0 0/2] Fix LPSS clock divider for XPS 9530, 6.8.y backport
Date: Sun, 17 Mar 2024 01:53:58 +0100
Message-Id: <20240317005400.974432-1-alex.vinarskis@gmail.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is a backport of recently upstreamed fix for XPS 9530 sound issue.
Both apply cleanly to 6.8.y, and could also be cherry-picked from upstream.

Ideally should be applied to all branches where upstream commit
d110858a6925827609d11db8513d76750483ec06 exists (6.8.y) or was backported
(6.7.y) as it adds initial yet incomplete support for this laptop. Patches
for 6.7.y require modification, will be submitted separately.

Signed-off-by: Aleksandrs Vinarskis <alex.vinarskis@gmail.com>

Aleksandrs Vinarskis (2):
  mfd: intel-lpss: Switch to generalized quirk table
  mfd: intel-lpss: Introduce QUIRK_CLOCK_DIVIDER_UNITY for XPS 9530

 drivers/mfd/intel-lpss-pci.c | 28 ++++++++++++++++++++--------
 drivers/mfd/intel-lpss.c     |  9 ++++++++-
 drivers/mfd/intel-lpss.h     | 14 +++++++++++++-
 3 files changed, 41 insertions(+), 10 deletions(-)

-- 
2.40.1


