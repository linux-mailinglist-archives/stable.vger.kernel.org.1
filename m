Return-Path: <stable+bounces-180662-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 954B2B89FB9
	for <lists+stable@lfdr.de>; Fri, 19 Sep 2025 16:32:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7F625A735E
	for <lists+stable@lfdr.de>; Fri, 19 Sep 2025 14:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BBAB3164C3;
	Fri, 19 Sep 2025 14:30:24 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E11E314A85;
	Fri, 19 Sep 2025 14:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758292224; cv=none; b=RkTm43N2UswicBxMdg1j0X7i+A1igk1c+P+KKdH91gG4NSXnblHUBKAIdr3e9tCOzZHZcStWe7mVJV58GCc7zeOrZP8pdLVrzZ+96xUqNljt9Z/bDe6sztAylLheiq4pD68x/whCYhYeiGUf8NrWbMtyTe5uHiU19VsRHNHS9hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758292224; c=relaxed/simple;
	bh=jR5hXSe5Rb2lJevs7VVywEayah8UQ+hzgixju+gCauo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=r9NZ/qRfuB2twSrIZ5Cj9s94dMfSuskTuTwtXGg5YuTNfuEgvLum74p8TkbEp5pZCCF7GrcgrttaoWDLCd1JN4lDEPQVNLbnPFuxLBYeRDfGAwNgrDfP5dt2ysLrTwPNE7V/nalnaFYo+H8UwTERSrGjF6+j029/SllIoTlD6U0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; arc=none smtp.client-ip=210.160.252.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
X-CSE-ConnectionGUID: QoxrVUnMQTSZrC+KOJJF5A==
X-CSE-MsgGUID: QMmjvF3MRJu2R/nyXL2UxA==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 19 Sep 2025 23:30:13 +0900
Received: from demon-pc.localdomain (unknown [10.226.92.70])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 2EAF940083FA;
	Fri, 19 Sep 2025 23:30:09 +0900 (JST)
From: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
To: 
Cc: Srinivas Kandagatla <srini@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] nvmem: rcar-efuse: add missing MODULE_DEVICE_TABLE
Date: Fri, 19 Sep 2025 17:28:53 +0300
Message-ID: <20250919142856.2313927-1-cosmin-gabriel.tanislav.xa@renesas.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The nvmem-rcar-efuse driver can be compiled as a module. Add missing
MODULE_DEVICE_TABLE so it can be matched by modalias and automatically
loaded by udev.

Cc: stable@vger.kernel.org
Fixes: 1530b923a514 ("nvmem: Add R-Car E-FUSE driver")
Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---

V2:
 * add stable to CC
 * pick up Reviewed-by

 drivers/nvmem/rcar-efuse.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvmem/rcar-efuse.c b/drivers/nvmem/rcar-efuse.c
index f24bdb9cb5a7..d9a96a1d59c8 100644
--- a/drivers/nvmem/rcar-efuse.c
+++ b/drivers/nvmem/rcar-efuse.c
@@ -127,6 +127,7 @@ static const struct of_device_id rcar_fuse_match[] = {
 	{ .compatible = "renesas,r8a779h0-otp", .data = &rcar_fuse_v4m },
 	{ /* sentinel */ }
 };
+MODULE_DEVICE_TABLE(of, rcar_fuse_match);
 
 static struct platform_driver rcar_fuse_driver = {
 	.probe = rcar_fuse_probe,
-- 
2.51.0


