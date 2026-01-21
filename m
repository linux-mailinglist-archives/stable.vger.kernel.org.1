Return-Path: <stable+bounces-210906-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2JbZKi4tcWl1fAAAu9opvQ
	(envelope-from <stable+bounces-210906-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 20:46:54 +0100
X-Original-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 199CF5C7AA
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 20:46:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D0006B46442
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 18:24:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDB633A784B;
	Wed, 21 Jan 2026 18:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Uz4CLe0t"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63B07340A76;
	Wed, 21 Jan 2026 18:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769019782; cv=none; b=qezeBVJ1HMXBd5uxeOpGd1fWKHBnoQz96Gc6144batr9DKJYoUaMGFWWSJAADpijOPNUDJxKdMjMOwnNoFLyNQ0QO+rIBFjYcXnIAj+2MhNjD9gR3EmYfY7dl8iWRLYeil3GkTfMzHbYd/QPSrJAhf9o9+aJNdaKj2ZJrGb1HWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769019782; c=relaxed/simple;
	bh=E37bjvgm+C/xSrM9Ij/9PMSEtpekxT512VILsTb9qBo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WqSl1KvW3O3ooRhICsM0tailgiVAXlBFsMzebeDpSuQnCv6ptZzauwwi4gu43vAfythcr1MxY8pnXBh6dES39MROwhUMyRU/DvCADknfbm30m/sKu1u+sonI7+arl77r+KY9fqKUe/qcJ+zJ8p6J0+QCNg74pYiNc12t936eQBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Uz4CLe0t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4F6AC4CEF1;
	Wed, 21 Jan 2026 18:23:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1769019782;
	bh=E37bjvgm+C/xSrM9Ij/9PMSEtpekxT512VILsTb9qBo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Uz4CLe0tDlCFedpaq8y/Zm0k4CIvtoEmK8qgPJww9dt5PEGxfLr3o3CvWS36zmnc3
	 wh71eckSCO1tOY7xtV2Knin6qxuIfDvbn0pL7lZc14e6fk91luUK7sJTcBWy/0Gye7
	 SaBWLITot+L+fES6XSLcVjpEo/gEwYa3+c77cZ2I=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Binbin Zhou <zhoubinbin@loongson.cn>,
	Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH 6.12 107/139] LoongArch: dts: loongson-2k2000: Add default interrupt controller address cells
Date: Wed, 21 Jan 2026 19:15:55 +0100
Message-ID: <20260121181415.298846142@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260121181411.452263583@linuxfoundation.org>
References: <20260121181411.452263583@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[linuxfoundation.org,none];
	TAGGED_FROM(0.00)[bounces-210906-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[loongson.cn:email,linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,0.152.150.128:email,0.0.0.9:email,1a000000:email]
X-Rspamd-Queue-Id: 199CF5C7AA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Binbin Zhou <zhoubinbin@loongson.cn>

commit e65df3f77ecd59d3a8647d19df82b22a6ce210a9 upstream.

Add missing address-cells 0 to the Local I/O, Extend I/O and PCH-PIC
Interrupt Controller node to silence W=1 warning:

  loongson-2k2000.dtsi:364.5-49: Warning (interrupt_map): /bus@10000000/pcie@1a000000/pcie@9,0:interrupt-map:
    Missing property '#address-cells' in node /bus@10000000/interrupt-controller@10000000, using 0 as fallback

Value '0' is correct because:
1. The LIO/EIO/PCH interrupt controller does not have children,
2. interrupt-map property (in PCI node) consists of five components and
   the fourth component "parent unit address", which size is defined by
   '#address-cells' of the node pointed to by the interrupt-parent
   component, is not used (=0)

Cc: stable@vger.kernel.org
Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/loongarch/boot/dts/loongson-2k2000.dtsi |    3 +++
 1 file changed, 3 insertions(+)

--- a/arch/loongarch/boot/dts/loongson-2k2000.dtsi
+++ b/arch/loongarch/boot/dts/loongson-2k2000.dtsi
@@ -126,6 +126,7 @@
 			reg = <0x0 0x1fe01400 0x0 0x64>;
 
 			interrupt-controller;
+			#address-cells = <0>;
 			#interrupt-cells = <2>;
 			interrupt-parent = <&cpuintc>;
 			interrupts = <2>;
@@ -140,6 +141,7 @@
 			compatible = "loongson,ls2k2000-eiointc";
 			reg = <0x0 0x1fe01600 0x0 0xea00>;
 			interrupt-controller;
+			#address-cells = <0>;
 			#interrupt-cells = <1>;
 			interrupt-parent = <&cpuintc>;
 			interrupts = <3>;
@@ -149,6 +151,7 @@
 			compatible = "loongson,pch-pic-1.0";
 			reg = <0x0 0x10000000 0x0 0x400>;
 			interrupt-controller;
+			#address-cells = <0>;
 			#interrupt-cells = <2>;
 			loongson,pic-base-vec = <0>;
 			interrupt-parent = <&eiointc>;



