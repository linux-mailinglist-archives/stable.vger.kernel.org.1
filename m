Return-Path: <stable+bounces-246643-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CHKaHXdyA2rH5wEAu9opvQ
	(envelope-from <stable+bounces-246643-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 20:33:27 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7756F527C0B
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 20:33:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1AC053336272
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 18:15:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1C0535676B;
	Tue, 12 May 2026 18:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="naw3Vh60"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7527D34CFD0;
	Tue, 12 May 2026 18:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778609746; cv=none; b=GZm4jeB4U4a8eyVKAQoxAOwB5T+gJ3YU9RHz9JmxlbXVbQlaPMVlAuaBkKjbkzgoVGaeCv5UVY6n5IvCjHZ5pYTTCTDGcrGnzgBYXRpWyLE36xu3NzgsxI9sFlunFU108V2o6ZbHZk0h14GYQx/pU0U+zHhev3PBWp8F6EoE7w8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778609746; c=relaxed/simple;
	bh=BUeL4vQq82vM3xviPmMTR1ZzZ6upV+XZfwK1BGOS7yE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Cet5VS5Jc2sNydrWi547sCyw/nuFrqAyp+1GmdkxjVWs9oYi0gV/vZFC1+wNms64XlXaJOOe5LnWuuSKxvZshdaDMdQYtowk6SusUPCH0DAv4wC8Gm9+oxsSwcfch2Qrf3NhDed0bqNr3YzyjfK2lVo0jonLxRj8AxOY4gqfA8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=naw3Vh60; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D057C2BCB0;
	Tue, 12 May 2026 18:15:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778609746;
	bh=BUeL4vQq82vM3xviPmMTR1ZzZ6upV+XZfwK1BGOS7yE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=naw3Vh60OsSncV4fwbQBjZrMJNcIGOZHgKqxsqM1PX/6HGpmhxcUAfAcsfjJEJ1+y
	 CB4BiBIMgPzBXRw7Lo1eFfn2b8SQLGEoJmb7O/eduS8rUKF3jt+tRgG9bXYrbY1PQt
	 CsMPSKD/W+R4NJy7KEDcMisnOpUO7XuRgaXKwrZ0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Chao Li <lichao@loongson.cn>,
	Dongyan Qian <qiandongyan@loongson.cn>,
	Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH 7.0 290/307] LoongArch: Use per-root-bridge PCIH flag to skip mem resource fixup
Date: Tue, 12 May 2026 19:41:25 +0200
Message-ID: <20260512173946.246500844@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260512173940.117428952@linuxfoundation.org>
References: <20260512173940.117428952@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 7756F527C0B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-246643-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[loongson.cn:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Action: no action

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Huacai Chen <chenhuacai@loongson.cn>

commit 49f33840dcc907d21313d369e34872880846b61c upstream.

When firmware enables 64-bit PCI host bridge support, some root bridges
already provide valid 64-bit mem resource windows through ACPI.

In this case, the LoongArch-specific mem resource high-bits fixup in
acpi_prepare_root_resources() should not be applied unconditionally.
Otherwise, the kernel may override the native resource layout derived
from firmware, and later BAR assignment can fail to place device BARs
into the intended 64-bit address space correctly.

Add a per-root-bridge ACPI flag, PCIH, and evaluate it from the current
root bridge device scope. When PCIH is set, skip the mem resource high-
bits fixup path and let the kernel use the firmware-provided resource
description directly. When PCIH is absent or cleared, keep the existing
behavior and continue filling the high address bits from the host bridge
address.

This makes the behavior per-root-bridge configurable and avoids breaking
valid 64-bit BAR space allocation on bridges whose 64-bit windows have
already been fully described by firmware.

Cc: stable@vger.kernel.org
Suggested-by: Chao Li <lichao@loongson.cn>
Tested-by: Dongyan Qian <qiandongyan@loongson.cn>
Signed-off-by: Dongyan Qian <qiandongyan@loongson.cn>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/loongarch/pci/acpi.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/arch/loongarch/pci/acpi.c
+++ b/arch/loongarch/pci/acpi.c
@@ -61,11 +61,16 @@ static void acpi_release_root_info(struc
 static int acpi_prepare_root_resources(struct acpi_pci_root_info *ci)
 {
 	int status;
+	unsigned long long pci_h = 0;
 	struct resource_entry *entry, *tmp;
 	struct acpi_device *device = ci->bridge;
 
 	status = acpi_pci_probe_root_resources(ci);
 	if (status > 0) {
+		acpi_evaluate_integer(device->handle, "PCIH", NULL, &pci_h);
+		if (pci_h)
+			return status;
+
 		resource_list_for_each_entry_safe(entry, tmp, &ci->resources) {
 			if (entry->res->flags & IORESOURCE_MEM) {
 				entry->offset = ci->root->mcfg_addr & GENMASK_ULL(63, 40);



