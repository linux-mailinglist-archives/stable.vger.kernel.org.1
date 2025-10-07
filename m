Return-Path: <stable+bounces-183541-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 32FB0BC170C
	for <lists+stable@lfdr.de>; Tue, 07 Oct 2025 15:09:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1F0454EB7A3
	for <lists+stable@lfdr.de>; Tue,  7 Oct 2025 13:09:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49F8F2DFA2F;
	Tue,  7 Oct 2025 13:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="YeMjjHNO"
X-Original-To: stable@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 731EC221FA0
	for <stable@vger.kernel.org>; Tue,  7 Oct 2025 13:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759842591; cv=none; b=NcP2jYJDH8C7su9kx7J1awpKnSo0/NuzM7roUtNWE1Ugj3PGh9VCe4mdJ1l/cQ7CuCOSmCR//QuBXwQGD3ZyvJuETs/scKB3VhEmWIDcrouHbNgnTDfkEhWoqv39Y01m5tXngZDbnwgaPtPQgqj+Ru3c/Vv9D2aB1QXDgM9gCUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759842591; c=relaxed/simple;
	bh=xuzmYmA8CSrUkVL2n9oidb8PirMbgnRfGDJiusiJ96c=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Qxi2j4bGsxILKvz4Ml4YkZ9Jh18utNq6r0g4H7dqBcOQL8X6KVhYBRdohNUra2nfYR7+VvV/vHSUxrzYPtmPhb8t5b99M3egqbu/lNYJumSJOvHIaaz1RFUhIOEb5S7o0wAiWRHPLfpzkzLLaz/+E69wAvVan+mMRKiUgjv2p1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=YeMjjHNO; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1759842589; x=1791378589;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=xuzmYmA8CSrUkVL2n9oidb8PirMbgnRfGDJiusiJ96c=;
  b=YeMjjHNOiGe7C431o5NLVSY2ArNWgS8qL9fpIVw0z1Q0hSjsKKd/h98n
   CHxDzveg/Mm80LUAqf4Of3+7qncYLNjwwSuna+YyDo9HawYgtf1FCloAk
   H/NUVysPgAOrmSbuOPrZMFsNFDJqsn47rOpm5lMX4U5VsUWm+DWx08jbp
   nbBQlqq1XGcJYj6D1ICb+dFmZBzuH1cZJwfZQKkADIFckKgkEzduIi1ph
   PI78DF4+bykhapTbhGdbH48kAo3iLraAVQ/97ZruJoInmCGFOFtUHjuDp
   Slc4UNvzSCYTL2E4UH3gLx9CcG/sScSeiZ2bok9VkJqPHPLdxJKpIf2BV
   g==;
X-CSE-ConnectionGUID: RmscGUEvQpKl6xIsrtZ1MQ==
X-CSE-MsgGUID: hbwLvYpfR4iijZcjgCC+qA==
X-IronPort-AV: E=Sophos;i="6.18,321,1751266800"; 
   d="scan'208";a="53484408"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Oct 2025 06:09:43 -0700
Received: from chn-vm-ex4.mchp-main.com (10.10.87.33) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Tue, 7 Oct 2025 06:09:13 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.87.151) by
 chn-vm-ex4.mchp-main.com (10.10.87.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1748.10; Tue, 7 Oct 2025 06:09:13 -0700
Received: from ROU-LT-M70749.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Tue, 7 Oct 2025 06:09:12 -0700
From: Romain Sioen <romain.sioen@microchip.com>
To: <stable@vger.kernel.org>
CC: <contact@arnaud-lcm.com>, <jikos@kernel.org>, Romain Sioen
	<romain.sioen@microchip.com>
Subject: [PATCH 0/1] Backport request: Fix reading issue on mcp2221
Date: Tue, 7 Oct 2025 15:08:10 +0200
Message-ID: <20251007130811.1001125-1-romain.sioen@microchip.com>
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
This request is following the one I did previously to fix hid-mcp2221
in previous LTS versions.

I have confirmed that the patches applie cleanly and build successfully
against v6.12, v6.6, v6.1, v5.15 and v5.10 stable branches.

Thanks,

Romain

Arnaud Lecomte (1):
  hid: fix I2C read buffer overflow in raw_event() for mcp2221

 drivers/hid/hid-mcp2221.c | 4 ++++
 1 file changed, 4 insertions(+)

-- 
2.48.1


