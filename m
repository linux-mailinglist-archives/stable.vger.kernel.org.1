Return-Path: <stable+bounces-235553-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4NymHvpS2Gl4bwgAu9opvQ
	(envelope-from <stable+bounces-235553-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 10 Apr 2026 03:31:38 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D3DC53D11AE
	for <lists+stable@lfdr.de>; Fri, 10 Apr 2026 03:31:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C29AD3019B95
	for <lists+stable@lfdr.de>; Fri, 10 Apr 2026 01:31:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 401562165EA;
	Fri, 10 Apr 2026 01:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fIeXV1Em"
X-Original-To: stable@vger.kernel.org
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A25B21A3172
	for <stable@vger.kernel.org>; Fri, 10 Apr 2026 01:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775784679; cv=none; b=iXXvD7iVVJxSsHyfYV9rN+bwH0gDCITrfrAQW8xFSMwNI0TGODfNcTKePuCZbJuYEFW9e89x6OR99l7Ft6Oj7bVLPFe73R+/ksCHWbw5BrzM/CpPdmoD23xfQuBTTFP+LvyYZRocNBhM8AjyaqLKaQ01dmOjkhjOqE9x4G3CDK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775784679; c=relaxed/simple;
	bh=bK71FNXB5Mi6LHt1KAqhmJrc/QHty5Fg0oZJTACIkMU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tR+sLPfCkxoBuHSuXFO7vVFXzsTHs6337nXBet/FNyMIYHgQXvyqV0+YkKu2z7t6qyBwkERvlMukkWgMiUEvi5eZXXKhSE/m6+4ucMItl6S3M9BPBE15DRzd+9+goOIiOU/b3YJEYQJ3ofgUHtj835c1asYjxAMxLAJqpRBUyVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fIeXV1Em; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1775784665;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ZE7zKv+ccYFwk/xStkrmdQacawyYJjmPK2aVWrwn0q0=;
	b=fIeXV1EmY2mpUDjnZ6KD6ybh9TAWbNsE5eXokTdRFEbxSco39L7kSDrDVkPOWKysjXNDXD
	pnBFIj7LKcZIF9sno0O41LmQtMRTO+5QZzplZQeCS4aal6y+d6yKhqwW1XT4G41fFkMelF
	dI2vgpRK+nJc627YCpm7PbAuGc+A7/M=
From: George Guo <dongtai.guo@linux.dev>
To: chenhuacai@kernel.org,
	jiaxun.yang@flygoat.com,
	tglx@kernel.org
Cc: linux-kernel@vger.kernel.org,
	George Guo <guodongtai@kylinos.cn>,
	stable@vger.kernel.org,
	Kexin Liu <liukexin@kylinos.cn>
Subject: [PATCH 1/1] irqchip/loongson-pch-pic: Fix vec_count reading for 32-bit and 64-bit
Date: Fri, 10 Apr 2026 09:30:53 +0800
Message-ID: <20260410013053.3877-1-dongtai.guo@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-235553-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dongtai.guo@linux.dev,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: D3DC53D11AE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: George Guo <guodongtai@kylinos.cn>

Commit 0370a5e740f2 ("irqchip/loongson-pch-pic: Adjust irqchip driver for
32BIT/64BIT") changed vec_count reading from readq() to readl() to support
both 32-bit and 64-bit platforms. However, on virtual 64-bit platforms
(QEMU 8.2.0) this causes incorrect vec_count value, leading to panic:

WARNING: drivers/acpi/irq.c:63 at acpi_register_gsi+0xe8/0x108
Call Trace:
[<900000000024c634>] show_stack+0x64/0x188
[<9000000000245154>] dump_stack_lvl+0x6c/0x9c
[<900000000026cb38>] __warn+0x98/0x200
[<90000000016dc900>] __report_bug+0xa8/0x1c0
[<90000000016dcb0c>] report_bug+0x3c/0xc0
[<90000000017170b0>] do_bp+0x270/0x3c0
[<900000000024aba8>] handle_bp+0x128/0x1e0
[<9000000000def7a0>] acpi_register_gsi+0xe8/0x108
[<9000000000ddcc5c>] acpi_dev_resource_interrupt+0x2f4/0x348
[<9000000000e43ad0>] pnpacpi_allocated_resource+0xc8/0x398
[<9000000000e1d608>] acpi_walk_resource_buffer+0x88/0x168
[<9000000000e1dbec>] acpi_walk_resources+0x13c/0x178
[<9000000000e43df0>] pnpacpi_parse_allocated_resource+0x50/0xc8
[<9000000001778b00>] pnpacpi_add_device.isra.0+0x208/0x2e4
[<9000000001778c10>] pnpacpi_add_device_handler+0x34/0x54
[<9000000000e14fac>] acpi_ns_get_device_callback+0x15c/0x2c8
[<9000000000e14bc4>] acpi_ns_walk_namespace+0x134/0x2d0
[<9000000000e14e28>] acpi_get_devices+0xc8/0xf0
[<9000000001778878>] pnpacpi_init+0x68/0x9c
[<9000000000248e7c>] do_one_initcall+0x6c/0x4b0
[<9000000001731aa0>] do_initcalls+0x118/0x160
[<9000000001731ca4>] kernel_init_freeable+0x148/0x1a4
[<900000000171a294>] kernel_init+0x24/0x130
[<9000000001717358>] ret_from_kernel_thread+0x28/0x150
[<900000000024a24c>] ret_from_kernel_thread_asm+0xc/0xa0
GSI: No registered irqchip, giving up

Fix this by using readq() on 64-bit and readl() on 32-bit platforms.

Fixes: 0370a5e740f2 ("irqchip/loongson-pch-pic: Adjust irqchip driver for 32BIT/64BIT")
Cc: stable@vger.kernel.org
Tested-by: Kexin Liu <liukexin@kylinos.cn>
Signed-off-by: George Guo <guodongtai@kylinos.cn>
---
 drivers/irqchip/irq-loongson-pch-pic.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-loongson-pch-pic.c b/drivers/irqchip/irq-loongson-pch-pic.c
index 98fc1770e2a5..eb25d482a4c5 100644
--- a/drivers/irqchip/irq-loongson-pch-pic.c
+++ b/drivers/irqchip/irq-loongson-pch-pic.c
@@ -343,7 +343,12 @@ static int pch_pic_init(phys_addr_t addr, unsigned long size, int vec_base,
 		priv->table[i] = PIC_UNDEF_VECTOR;
 
 	priv->ht_vec_base = vec_base;
-	priv->vec_count = ((readl(priv->base + 4) >> 16) & 0xff) + 1;
+
+	if (IS_ENABLED(CONFIG_64BIT))
+		priv->vec_count = ((readq(priv->base) >> 48) & 0xff) + 1;
+	else
+		priv->vec_count = ((readl(priv->base + 4) >> 16) & 0xff) + 1;
+
 	priv->gsi_base = gsi_base;
 
 	priv->pic_domain = irq_domain_create_hierarchy(parent_domain, 0,
-- 
2.43.0


