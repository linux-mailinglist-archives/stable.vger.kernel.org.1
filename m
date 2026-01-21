Return-Path: <stable+bounces-211103-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SNOtGOAgcWl8eQAAu9opvQ
	(envelope-from <stable+bounces-211103-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 19:54:24 +0100
X-Original-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C73585B983
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 19:54:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0FED09AFF57
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 18:37:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 245222E62A6;
	Wed, 21 Jan 2026 18:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WlCeQXV2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D07F3387594;
	Wed, 21 Jan 2026 18:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769020448; cv=none; b=kTVzMkbxZHsYW3TiwTa9E0Yaz2LO4KyYBJHL1joQIuZYnrB0F7kHT3EYNdDdYWEPcHmb6nZU9mvsqj/ZhjpZhNqrVyC77S1zce7z1a3ltBBSQu2FNHdIRj3R86FKOn04Vb28kZGSlViksb6Y6vbsq+9ZpxNM92tpuHHxAd5NyzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769020448; c=relaxed/simple;
	bh=bUvC0SjooC32UFKGn5WitQDT3tvL+wZaIp5z8dGYxz8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xa0S7i80w4lWqWt+7V7l5nvujxRM1heGLY665XKpv/rwPB2cmMqX7u9Ijgp/v7fTU1I6jZzdnZbzp2+VcF/dklhdZEQosUz7GgWPByTkXwKFz+Dy0Ic70ACQSNhjqP6BsAuGvGcfPrmwGQEiSQ3g3RvslOJL4I63EU4ofvY0Nlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WlCeQXV2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E339AC4CEF1;
	Wed, 21 Jan 2026 18:34:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1769020448;
	bh=bUvC0SjooC32UFKGn5WitQDT3tvL+wZaIp5z8dGYxz8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WlCeQXV2C6VL2uXUmDAuolFQHfJtKwqxNzF4XmlNbZmmtlMYvMXJf5/rE+SBGzJOQ
	 G3w3Ap+OdsAND2O2BSRU7m60OKZlx2fYT1qZVIQbb63NaSOxBf2jEaVx0UmaUq3woE
	 IwvI35JT28Ljyq+m5Wp+B+3DG4regBmmR50CfeqU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Binbin Zhou <zhoubinbin@loongson.cn>,
	Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH 6.18 161/198] LoongArch: dts: loongson-2k1000: Add default interrupt controller address cells
Date: Wed, 21 Jan 2026 19:16:29 +0100
Message-ID: <20260121181424.345415448@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260121181418.537774329@linuxfoundation.org>
References: <20260121181418.537774329@linuxfoundation.org>
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
	RCVD_TLS_LAST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-211103-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[linuxfoundation.org,none];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: C73585B983
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Binbin Zhou <zhoubinbin@loongson.cn>

commit 81e8cb7e504a5adbcc48f7f954bf3c2aa9b417f8 upstream.

Add missing address-cells 0 to the Local I/O interrupt controller node
to silence W=1 warning:

  loongson-2k1000.dtsi:498.5-55: Warning (interrupt_map): /bus@10000000/pcie@1a000000/pcie@9,0:interrupt-map:
    Missing property '#address-cells' in node /bus@10000000/interrupt-controller@1fe01440, using 0 as fallback

Value '0' is correct because:
1. The Local I/O interrupt controller does not have children,
2. interrupt-map property (in PCI node) consists of five components and
   the fourth component "parent unit address", which size is defined by
   '#address-cells' of the node pointed to by the interrupt-parent
   component, is not used (=0)

Cc: stable@vger.kernel.org
Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/loongarch/boot/dts/loongson-2k1000.dtsi |    2 ++
 1 file changed, 2 insertions(+)

--- a/arch/loongarch/boot/dts/loongson-2k1000.dtsi
+++ b/arch/loongarch/boot/dts/loongson-2k1000.dtsi
@@ -114,6 +114,7 @@
 			      <0x0 0x1fe01140 0x0 0x8>;
 			reg-names = "main", "isr0", "isr1";
 			interrupt-controller;
+			#address-cells = <0>;
 			#interrupt-cells = <2>;
 			interrupt-parent = <&cpuintc>;
 			interrupts = <2>;
@@ -131,6 +132,7 @@
 			      <0x0 0x1fe01148 0x0 0x8>;
 			reg-names = "main", "isr0", "isr1";
 			interrupt-controller;
+			#address-cells = <0>;
 			#interrupt-cells = <2>;
 			interrupt-parent = <&cpuintc>;
 			interrupts = <3>;



