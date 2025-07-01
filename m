Return-Path: <stable+bounces-159163-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 47FA3AF01A9
	for <lists+stable@lfdr.de>; Tue,  1 Jul 2025 19:21:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9AA8F1C20930
	for <lists+stable@lfdr.de>; Tue,  1 Jul 2025 17:12:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A62B9277CB0;
	Tue,  1 Jul 2025 17:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="XS9t/U9R"
X-Original-To: stable@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 911B027A903
	for <stable@vger.kernel.org>; Tue,  1 Jul 2025 17:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751389922; cv=none; b=PThqxzsl+u5YkXGIi11cGeuskxPSgqyKUcGWPj5vX3Rdv8WZaucbMb+PqKPUCoHAyCG+apwz/wWZ3qt/UTuORQIMAQ1raYK6QzM7tp0BT7u2v94aKWmQAJPDmHAUeQO1q8UdNIvXCktFP4StjreGM5LGniG2cnYNTlXx9TrfqPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751389922; c=relaxed/simple;
	bh=SX2heC/Qk6afxGMZKjrW09kyPvYeBI0adPXbi3Fnvpc=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=k97T/jy/5F/JshydD/74Ikfm3BqxDkKO+zceuj5IrPwl/UJaqW5zGsXgQfMpF2Irgp9WGNmUIER9tbo6j4SfTKIqYfHC43I2nexB9loOv/K3vt1ojYb76NW8ZpKV1TUwSSV4Ia2t9x+hBHqnUsN0j0h1DQcMJgTwYyhyaeGFoik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=XS9t/U9R; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 787613F18C
	for <stable@vger.kernel.org>; Tue,  1 Jul 2025 17:11:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1751389918;
	bh=sU2Tqd6bdvzOLtqB6osCLzx8U1+d3a8Z2ezfvd4F1oM=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=XS9t/U9R+3zUPjGMo8TXfF8V4bFRO48sGEJTHDFEwALEQlklu34q5iWKNWJAxeJDN
	 +K3J8c/GIUaMzj/GAXRLelvWCBv1t1aNu430TZblitWvrwTVWBchyyxHwyT9K2nFJV
	 2SWUvcYUGjOfRYSLdpCwNODR9T1Oe/hhRKxARi7O1Z4AJmUcQosDyXFPrM9D3+2a97
	 w2pqLs5qGElOjXvgryvDOJ7FE1c8xrUPTzjxFZdV2sZU22COfpkD6ECGQ0PtD7Jyp5
	 u1S0HgtOspnVPWIHNGHSQOAgw/iDhvS32Yt2ki1VYu1t0R/B2Mce+anQPsZXBmoaSU
	 nEIFsheOI6nHA==
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-60c776678edso5783961a12.1
        for <stable@vger.kernel.org>; Tue, 01 Jul 2025 10:11:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751389918; x=1751994718;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sU2Tqd6bdvzOLtqB6osCLzx8U1+d3a8Z2ezfvd4F1oM=;
        b=Xj0g3EeVtE1Kbu02svqQVVOSX11sVQbbPjGbLfiifZSECOcShUDdJ95UqSdyW4jtLt
         rNInNhIi7zLOLWWqOzgPNZ+O9brzBhpu95kAXejkE2fIfOlNxF8G5T1XSCgmhIOhcfDp
         GAL+lFulQ21wBzL525+fxyp8vTOl18uojLpGvBaMm29g8sJJyXXiRbHMz15Q0/3YKUSJ
         a5msnoORjRfzluNSfub+OarHfpD+6ZldxxWQx6QNzveoP0S6g7gDR3Voeq2Dr1Osv0iX
         LZ1/7TNuv/JPPaxWuo36/fq6dbGWQG49qLmzcLg1TkELBPb2X8gw+0Ag4tgADwIjQGzL
         rSFA==
X-Forwarded-Encrypted: i=1; AJvYcCX94fuRo+GvFPxt0JZfYTWiAq5r8OnnYdREVDB9BsoP6eRxXvXrrXWmWhphX8fscYf6EcJehxo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGJDhSLq/OlRGmsljm7316gHWkXjuD+c8lC0ZAc/0pXXYsvYlZ
	zdNG/YpOlrYyZeofAmzXana5ErH53DRMIrfGUnhHPQkLkhd7erB1wH9rRdxT8QjP0pKgMbayAom
	hWGVoc4Ohkq3Kpl//bxy4QIEvn1fWsKQMYwK3JphJnCAkgTJYFq+f+rNBWuZA8zD+koGSWqNJMA
	==
X-Gm-Gg: ASbGnctAfVQzzdWktKFVkTDb2/TjCXTJUesx9G8v+46mx832fjQ9v0vm2fv298HFlHS
	2SI7SQ5+0MeeP3JSPeTvluAm5aKoWq4lAtITlVL6DSJlnYFr7U7UYXaH+CBaSDD/Esbjw/+eJzg
	+CPnD/SdqrKtz2O3DK2w66ngP/xkHv/Jvct/UGXglNTQUmkauNgkqHMeuNFCQYBdpmissCU8ejp
	CP1tM89toSEUzKRN2kjyMipWZlxcdk+wkD2vhtfEWHp1k43kokWHgnVG38UoImlbT+ti+ezfXcn
	xbw+HG5bwLJnUzTFO4E3WQZkVpN9Sfgi7sEhJfmNvU5fAZXsIJPj3Ki7rt7hlCQ4
X-Received: by 2002:a50:ed87:0:b0:608:40bf:caed with SMTP id 4fb4d7f45d1cf-60e3a8f3b4cmr2512625a12.7.1751389917970;
        Tue, 01 Jul 2025 10:11:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEu8J6lVnS+AjHzqRmWb7aXWSa8lc+z3NV7ufWDiI84tWqPRb7bwIpffBsf/O52QDBXHBTQ1w==
X-Received: by 2002:a50:ed87:0:b0:608:40bf:caed with SMTP id 4fb4d7f45d1cf-60e3a8f3b4cmr2512601a12.7.1751389917513;
        Tue, 01 Jul 2025 10:11:57 -0700 (PDT)
Received: from t14s.. (adsl-6.109.242.31.tellas.gr. [109.242.31.6])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-60c828bbea9sm7818156a12.1.2025.07.01.10.11.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 10:11:57 -0700 (PDT)
From: Ioanna Alifieraki <ioanna-maria.alifieraki@canonical.com>
To: baolu.lu@linux.intel.com,
	kevin.tian@intel.com,
	jroedel@suse.de,
	robin.murphy@arm.com,
	will@kernel.org,
	joro@8bytes.org,
	dwmw2@infradead.org,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	regressions@lists.linux.dev,
	stable@vger.kernel.org
Subject: [REGRESSION][BISECTED] Performance Regression in IOMMU/VT-d Since Kernel 6.10
Date: Tue,  1 Jul 2025 20:11:54 +0300
Message-Id: <20250701171154.52435-1-ioanna-maria.alifieraki@canonical.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

#regzbot introduced: 129dab6e1286

Hello everyone,

We've identified a performance regression that starts with linux
kernel 6.10 and persists through 6.16(tested at commit e540341508ce).
Bisection pointed to commit:
129dab6e1286 ("iommu/vt-d: Use cache_tag_flush_range_np() in iotlb_sync_map").

The issue occurs when running fio against two NVMe devices located
under the same PCIe bridge (dual-port NVMe configuration). Performance
drops compared to configurations where the devices are on different
bridges.

Observed Performance:
- Before the commit: ~6150 MiB/s, regardless of NVMe device placement.
- After the commit:
  -- Same PCIe bridge: ~4985 MiB/s
  -- Different PCIe bridges: ~6150 MiB/s


Currently we can only reproduce the issue on a Z3 metal instance on
gcp. I suspect the issue can be reproducible if you have a dual port
nvme on any machine.
At [1] there's a more detailed description of the issue and details
on the reproducer. 

Could you please advise on the appropriate path forward to mitigate or
address this regression?

Thanks,
Jo

[1] https://bugs.launchpad.net/ubuntu/+source/linux/+bug/2115738

