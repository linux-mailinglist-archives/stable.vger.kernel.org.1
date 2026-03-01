Return-Path: <stable+bounces-222024-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mAPaNFKgo2k3IQUAu9opvQ
	(envelope-from <stable+bounces-222024-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 03:11:30 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 50B7C1CD3C2
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 03:11:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9540233C7C72
	for <lists+stable@lfdr.de>; Sun,  1 Mar 2026 01:49:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3399E2FF641;
	Sun,  1 Mar 2026 01:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iuA4dnQi"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E971B2BD0B;
	Sun,  1 Mar 2026 01:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772329717; cv=none; b=Obf7rfI90JLPeHY08Z5fbSc5BW9PWgPF/DHGHUbZVKbp5XNoE/3VKLNSj0r4lE3n4+OOyEJg85DoLc9tFiP0cohOjM95drNnkcUHIBGIbJ7sgPQz7nusRF3F2mElAACa0fhhHa8e6vcUtRYYfyz4iGqkH5Lv74GHsXTe9HDq0MA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772329717; c=relaxed/simple;
	bh=Olk+8t3HlVz9cQ2zJMufltbYrf5UTyXOmrJPGugixxs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=N3iIAKfI/k7zVY+znmPyVWVMhi/fGjBbtoWaaRRcjJq4mNGplW6dxTNAj5aYMbmoWMhCdbhV8BZD0xjehUeNVS3JJ8oY63CinTdqT1ZPn/Vw4U/7+0A4H3ER/g632I5a7cFg06Q8DdzNs4gPyh4KKEj7Ot5ULFRIikH7z1Wtesk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iuA4dnQi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 460FDC19421;
	Sun,  1 Mar 2026 01:48:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772329716;
	bh=Olk+8t3HlVz9cQ2zJMufltbYrf5UTyXOmrJPGugixxs=;
	h=From:To:Cc:Subject:Date:From;
	b=iuA4dnQitKGOLF8Ogk9TS3D/DKoaIhgKwKSlDA2eBf5gJ4PWNsxQP0m7lIB6zEP/H
	 M/nxF+ImsKLduRSAf5WNksJieB6nIlx1tYBaGTcTV8vEZAIxYvVJXK4Ng/Mlw4aHpg
	 gy32619OTlHRv7dIXvpwPx05AFfuzRebZ8in/rRSqKJNlC0oOyIOERUJadeoV4oDc1
	 9cIUJjWucr0O2r7QWU6xjSIL1F4yDRdlFss9TjZxJ6opnC9ZAAAgExwX3TbI2dn0YK
	 /QQ0BifIio8DS4EnSsYWEwxwXSxJ0bqCEJnvwknouW1JDR3C00TgujkvoPaKyb7RoH
	 zjp21KNcD5LkQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	cascardo@igalia.com
Cc: Xu Yilun <yilun.xu@intel.com>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	linux-fpga@vger.kernel.org
Subject: FAILED: Patch "fpga: dfl: use subsys_initcall to allow built-in drivers to be added" failed to apply to 5.15-stable tree
Date: Sat, 28 Feb 2026 20:48:34 -0500
Message-ID: <20260301014835.1712811-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: ignore
X-stable: review
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-222024-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,igalia.com:email]
X-Rspamd-Queue-Id: 50B7C1CD3C2
X-Rspamd-Action: no action

The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 267f53140c9d0bf270bbe0148082e9b8e5011273 Mon Sep 17 00:00:00 2001
From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Date: Mon, 15 Dec 2025 16:05:50 -0300
Subject: [PATCH] fpga: dfl: use subsys_initcall to allow built-in drivers to
 be added

The dfl code adds a bus. If it is built-in and there is a built-in driver
as well, the dfl module_init may be called after the driver module_init,
leading to a failure to register the driver as the bus has not been added
yet.

Use subsys_initcall, which guarantees it will be called before the drivers
init code.

Without the fix, we see failures like this:

[    0.479475] Driver 'intel-m10-bmc' was unable to register with bus_type 'dfl' because the bus was not initialized.

Cc: stable@vger.kernel.org
Fixes: 9ba3a0aa09fe ("fpga: dfl: create a dfl bus type to support DFL devices")
Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Link: https://lore.kernel.org/r/20251215-dfl_subsys-v1-1-21807bad6b10@igalia.com
Reviewed-by: Xu Yilun <yilun.xu@intel.com>
Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
---
 drivers/fpga/dfl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/fpga/dfl.c b/drivers/fpga/dfl.c
index 7022657243c0a..449c3a082e232 100644
--- a/drivers/fpga/dfl.c
+++ b/drivers/fpga/dfl.c
@@ -2018,7 +2018,7 @@ static void __exit dfl_fpga_exit(void)
 	bus_unregister(&dfl_bus_type);
 }
 
-module_init(dfl_fpga_init);
+subsys_initcall(dfl_fpga_init);
 module_exit(dfl_fpga_exit);
 
 MODULE_DESCRIPTION("FPGA Device Feature List (DFL) Support");
-- 
2.51.0





