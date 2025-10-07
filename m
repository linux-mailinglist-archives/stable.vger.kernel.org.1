Return-Path: <stable+bounces-183542-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE2FCBC1712
	for <lists+stable@lfdr.de>; Tue, 07 Oct 2025 15:11:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B57A1188EC4C
	for <lists+stable@lfdr.de>; Tue,  7 Oct 2025 13:11:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F6182DFA31;
	Tue,  7 Oct 2025 13:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Z05b5vsI"
X-Original-To: stable@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E0F3221FA0
	for <stable@vger.kernel.org>; Tue,  7 Oct 2025 13:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759842669; cv=none; b=Tx3hbpkPgAhtLgqCSF0LRfjY3qvzm0QbgFpolEq5ND/EqSSb0dJNLTh1Cha8sD/YT9qsc0LOu5ZWCUR7eec2z8GR+9xwmV5zaA3eia+iFlapQqTvWpBlAl913bMikXmhEvjwqR75h80a3Qcm5zcF35lMA6ZFuBjdjriBCdUUSJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759842669; c=relaxed/simple;
	bh=CI2VWlJIYbCpCMqwLYio15RNKkiqJ9Ncp5cRCb3n9Gk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Kj7kJl+fUroNLsJOjoZI25y0QLLn9ofe7vv6fBEzippG86mPb/frYLY79GxGx8BUSKDUY2shQKlCHHPQJIdPJQkX5OJ3fxzerWyMhaAbS802Y3IvBh/XI0W7elFyhrNdqyPjXYgEYjrT7z3RnotAByHg4poXQED0sJREEg7UGlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=Z05b5vsI; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1759842668; x=1791378668;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CI2VWlJIYbCpCMqwLYio15RNKkiqJ9Ncp5cRCb3n9Gk=;
  b=Z05b5vsIVohOGpJxiB1VHpmMY3ihajRkWBt5DtTQkt4mWnVZvHex1qTP
   9LrCI44PK1xCj/z6eVUoe9FwM7PZaSjoHWHDrMQwtdKBntkezbZ6ccLfB
   00iKMOjNYA+wARmOkjVudimyITe+bF4fQYobtuCyWwaJ97OeeArrGBDx1
   y6cbUinDW8zcZH4kl7g4ThP13Zxbi9RiOWvYFTgx/38r0dNKwNZ84A5eL
   C+ZUWvwrFiUTtTXKnAw6rkDTuGkwnyQVrHr9I5YRRkFynHcGvy9gjK4QG
   uvhmxzRIPZuAUS8/BXNTn8I58ERbMLSyMNgYNx5OouhP8OkBcg8Nf6WRR
   A==;
X-CSE-ConnectionGUID: XjmPiH4aTPqta1AXoxzKDQ==
X-CSE-MsgGUID: 2DUUkf7hTmuNmCvnhA/YMA==
X-IronPort-AV: E=Sophos;i="6.18,321,1751266800"; 
   d="scan'208";a="214790415"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Oct 2025 06:09:59 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Tue, 7 Oct 2025 06:09:30 -0700
Received: from ROU-LT-M70749.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Tue, 7 Oct 2025 06:09:29 -0700
From: Romain Sioen <romain.sioen@microchip.com>
To: <stable@vger.kernel.org>
CC: <contact@arnaud-lcm.com>, <jikos@kernel.org>,
	<syzbot+52c1a7d3e5b361ccd346@syzkaller.appspotmail.com>, Romain Sioen
	<romain.sioen@microchip.com>
Subject: [PATCH 1/1] hid: fix I2C read buffer overflow in raw_event() for mcp2221
Date: Tue, 7 Oct 2025 15:08:11 +0200
Message-ID: <20251007130811.1001125-2-romain.sioen@microchip.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251007130811.1001125-1-romain.sioen@microchip.com>
References: <20251007130811.1001125-1-romain.sioen@microchip.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Arnaud Lecomte <contact@arnaud-lcm.com>

[ Upstream commit b56cc41a3ae7323aa3c6165f93c32e020538b6d2 ]

As reported by syzbot, mcp2221_raw_event lacked
validation of incoming I2C read data sizes, risking buffer
overflows in mcp->rxbuf during multi-part transfers.
As highlighted in the DS20005565B spec, p44, we have:
"The number of read-back data bytes to follow in this packet:
from 0 to a maximum of 60 bytes of read-back bytes."
This patch enforces we don't exceed this limit.

Reported-by: syzbot+52c1a7d3e5b361ccd346@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=52c1a7d3e5b361ccd346
Tested-by: syzbot+52c1a7d3e5b361ccd346@syzkaller.appspotmail.com
Signed-off-by: Arnaud Lecomte <contact@arnaud-lcm.com>
Link: https://patch.msgid.link/20250726220931.7126-1-contact@arnaud-lcm.com
Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
[romain.sioen@microchip.com: backport to stable, up to 6.12. Add "Fixes" tag]
Signed-off-by: Romain Sioen <romain.sioen@microchip.com>
---
 drivers/hid/hid-mcp2221.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/hid/hid-mcp2221.c b/drivers/hid/hid-mcp2221.c
index 0f93c22a479f..83941b916cd6 100644
--- a/drivers/hid/hid-mcp2221.c
+++ b/drivers/hid/hid-mcp2221.c
@@ -814,6 +814,10 @@ static int mcp2221_raw_event(struct hid_device *hdev,
 			}
 			if (data[2] == MCP2221_I2C_READ_COMPL ||
 			    data[2] == MCP2221_I2C_READ_PARTIAL) {
+				if (!mcp->rxbuf || mcp->rxbuf_idx < 0 || data[3] > 60) {
+					mcp->status = -EINVAL;
+					break;
+				}
 				buf = mcp->rxbuf;
 				memcpy(&buf[mcp->rxbuf_idx], &data[4], data[3]);
 				mcp->rxbuf_idx = mcp->rxbuf_idx + data[3];
-- 
2.48.1


