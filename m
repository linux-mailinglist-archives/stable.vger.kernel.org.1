Return-Path: <stable+bounces-176876-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 27596B3E840
	for <lists+stable@lfdr.de>; Mon,  1 Sep 2025 17:05:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 393DB3BE820
	for <lists+stable@lfdr.de>; Mon,  1 Sep 2025 15:05:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DDB4341AB7;
	Mon,  1 Sep 2025 15:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="n2fWn02M"
X-Original-To: stable@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D48F3AC1C
	for <stable@vger.kernel.org>; Mon,  1 Sep 2025 15:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756739100; cv=none; b=eYPDetU9WRyMrKI1wVBHNvgjyqBsIy+9MZCfPf3Hbr25YehDsJdgQHRn6omHjXC/u9BKn20D3xBrZ71r3YGZRjwCiTa9UseBWYj7+8eihJRCAOFOVf2EAJLXwdkjCyf4UpHzUt42BPbOTQn0fKq9ZyBtFn9vddZZj4IFFWdff0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756739100; c=relaxed/simple;
	bh=tFalWuxmF7KRSqc7jOq0iWaoday9p2Yg1OTSzvgmOPQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rpRIDyijbrJ15xpcqmgCEO27Jl8bQKAf9jfRTbZG01twObv1oSNyMIG8ClPVKiK5kQi0GZOkmcK9G2G5kNM076kkBrUJZHRT3jdlaTAJH5hYkxKs8WCsI80wpAHmYU45X06ZkJWwhDk2XuOCYROSPTzp1k0OZpPEvIZ8a+sOTyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=n2fWn02M; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1756739100; x=1788275100;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=tFalWuxmF7KRSqc7jOq0iWaoday9p2Yg1OTSzvgmOPQ=;
  b=n2fWn02MnFCrP7FgbRJrlFwlYZ0bGDzy5JzrnmTJQ6kD16W6QOc9C88j
   s7NR4wtbIq+k0Lub9z9OagLcqI6u1Zwna1iOWRg1U7pjphy8TnOUAfqZ7
   DNFAA7q6ArxYMlN3xM0z2Bd5X7fbQ/WUOdrOGmrzeewNT4krORmEDlm7L
   vShAb5E07jajgkw9E6KykI86nIJLW27Y/LunL7dOD9k6QbA7El6viTvqc
   WyI/bCFASZaG++wCAFg2v6tejlllYYFKcIOVH9WUJF8D8XZkiiHUNYNUG
   2w+ZJwEUD+8Pt1ns7QRVhDjYZrpdCKClc3FpZFuM0M/5N9B4OocDPwAxE
   A==;
X-CSE-ConnectionGUID: hRJ1odblTViAzW9QhPAUiw==
X-CSE-MsgGUID: I0ODsaOsQq+ANQAamzT4Ig==
X-IronPort-AV: E=Sophos;i="6.18,225,1751266800"; 
   d="scan'208";a="277284640"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 01 Sep 2025 08:04:59 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 1 Sep 2025 08:04:28 -0700
Received: from ROU-LT-M70749.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.44 via Frontend Transport; Mon, 1 Sep 2025 08:04:27 -0700
From: Romain Sioen <romain.sioen@microchip.com>
To: <stable@vger.kernel.org>
CC: <hamish.martin@alliedtelesis.co.nz>, <jikos@kernel.org>, Romain Sioen
	<romain.sioen@microchip.com>
Subject: [PATCH 0/2] Backport request: mcp2221 needed to access eeprom data
Date: Mon, 1 Sep 2025 17:03:29 +0200
Message-ID: <20250901150331.198437-1-romain.sioen@microchip.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Hi maintainers,

Please consider backporting the following patches to the stable trees.
These patches fix a significant reading issue with mcp2221 on i2c eeprom.

I have confirmed that the patches applie cleanly and build successfully
against v6.6, v6.1, v5.15 and v5.10 stable branches.

I will later come back to you with other patches that might need larger
backport changes.

Thanks,

Romain

Hamish Martin (2):
  HID: mcp2221: Don't set bus speed on every transfer
  HID: mcp2221: Handle reads greater than 60 bytes

 drivers/hid/hid-mcp2221.c | 71 +++++++++++++++++++++++++++------------
 1 file changed, 49 insertions(+), 22 deletions(-)

-- 
2.48.1


