Return-Path: <stable+bounces-21752-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E62B485CBFE
	for <lists+stable@lfdr.de>; Wed, 21 Feb 2024 00:24:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23DF91C21EAB
	for <lists+stable@lfdr.de>; Tue, 20 Feb 2024 23:24:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33BB4151CEB;
	Tue, 20 Feb 2024 23:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="f228VVuU"
X-Original-To: stable@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AEF078688
	for <stable@vger.kernel.org>; Tue, 20 Feb 2024 23:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708471445; cv=none; b=b13HlBg+uGX31bVn9BDtLaHyxuyoJV+Ej0tiEpza33SPgg3blAyTCGBzLj5dtepFBv4Beno0iDNgcbpayYXW7s1e5iZPh1r/fo4FYvDkkFjawZ25hsWECCDaWsv8jQOG1SBMAxfHqtcYPO8G1ggil4UQ5QLfX0G9RMwrR7tD05A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708471445; c=relaxed/simple;
	bh=822/BM2og10KE0sFlf1L7ifAzQjrLWmk4iPBo/abG5Y=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=QPuYzrGii7TtbBMSocWT/UdAoGvi69uaXOp/Z6VtzG8h/LLXDKtceu9ZGpOdxCNtGv6aZwNcyt7AIGWiiHwNL2E1GmkxD1vdYXpmEOG9WwoVyP10UvSs2CVaz/yiA1CJX5uN5A2g7Ok/fZc4YHh0TEvTpTqKJUSkewpZ2WrD2xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--hegao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=f228VVuU; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--hegao.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dcbee93a3e1so7343125276.3
        for <stable@vger.kernel.org>; Tue, 20 Feb 2024 15:24:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708471442; x=1709076242; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zj5llVKbfhZvQsdTnWPIOFQYOcDk3LVprZqIgVLkX7c=;
        b=f228VVuUT/2bKjNYwSU8Hml0PnN6deE2Cl4xSvkHi3j38LJUdI1093tW7SsDj3Xcki
         4+jaMXna0lP3juiKfP8CW6N8C9Mg4cjs3nDOO0Uh6ThDK8KjQiUwbfmSNS/1+nVwcZfa
         j2FAS0HiTFGbvRO81nsid0W3+u6nISUZ7+O1k03FUTC2djB1rr83mg1EzFbrJ71bG/Cm
         o55M9eReKHhGNLdZbqkGDt/I3bP+0XrOEoTLsgKucjp3h7tlH+fqO7q6o/KuIDgY4bPU
         hA3xiN5njGeyRTmaiYDtbtZATc3yA1+u9gdj9eRJtopp/8cJ5VFBfD9Qx1b9AkSRGi8F
         nEyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708471442; x=1709076242;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zj5llVKbfhZvQsdTnWPIOFQYOcDk3LVprZqIgVLkX7c=;
        b=nATUHqxUCcasWAZAL8wy+cCefjDSBnrWm3SN3FWXgLfzPWFV08SElzBtMIhR8aeSgV
         Js63dXVXeozQv97shT2HK+D715XQ8z+ikv5qSotmO30/1f1FPciTrJ1EF68ibvJ5UO1X
         RdMiukV7fIJSadKj+T3gEqSXmX4hNIcSqa5Mi3rzwGi6jCpVDAgdEfdm1j57uq88tzIu
         gQk2DTMtEIeAUY4Eq4Ca2HSrAJ3fOuY3jhOHlER9LxWLN9PGwYNnXxG5QQPGJuC2ybpE
         F7+gjxU2A+Nbhvv17ZIRz54/qTrAaftVzNoylUM60kWtPKeoAb99U36ekeyJsNbBi8Qu
         MCiQ==
X-Gm-Message-State: AOJu0Yy2YCqB2YN8Q1Vvk8pxinTWcYvCckbGaOd3Edm8f/rnV8ClRTNy
	5E1iSvYqyO3dCJRQ3O4U0TvUd2K0baodGh1eknzWQ01KjqV0rHmO7Wcj4SKjZrBMHF28z5ABqXD
	0qZOH/O05LXngowjZufw/eI1bcHZRu9CeGP+qJh+F+TvU/Hze52EMlD19/fl9WKgJdPXh3Q3RI0
	N4rMudASIQ1oB586h1fqI/aX1Emtw=
X-Google-Smtp-Source: AGHT+IGpEartoTufsPbctBKbovuz2S9hVH8W2crSnQI3i/NjyTCua86PuLAT45EpHUsXvCVphL1f/q2r5w==
X-Received: from hegao.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:394a])
 (user=hegao job=sendgmr) by 2002:a05:6902:728:b0:dcd:4286:4498 with SMTP id
 l8-20020a056902072800b00dcd42864498mr982910ybt.6.1708471442541; Tue, 20 Feb
 2024 15:24:02 -0800 (PST)
Date: Tue, 20 Feb 2024 23:23:38 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
Message-ID: <20240220232339.3846310-1-hegao@google.com>
Subject: [PATCH 6.1] Backport the fix for CVE-2024-23851 to v6.1
From: He Gao <hegao@google.com>
To: stable@vger.kernel.org
Cc: He Gao <hegao@google.com>
Content-Type: text/plain; charset="UTF-8"

This is the fix of CVE-2024-23851 for kernel v6.1.

Upstream commit: https://github.com/torvalds/linux/commit/bd504bcfec41a503b32054da5472904b404341a4

Changed argument name "blk_mode_t" back to "fmode_t" for the old version. The argument
is not affected by the patch.

He Gao (1):
  dm: limit the number of targets and parameter size area

 drivers/md/dm-core.h  | 2 ++
 drivers/md/dm-ioctl.c | 3 ++-
 drivers/md/dm-table.c | 9 +++++++--
 3 files changed, 11 insertions(+), 3 deletions(-)

-- 
2.44.0.rc0.258.g7320e95886-goog


