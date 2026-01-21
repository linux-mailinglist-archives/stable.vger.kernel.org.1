Return-Path: <stable+bounces-211102-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +AyZEQsscWl1fAAAu9opvQ
	(envelope-from <stable+bounces-211102-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 20:42:03 +0100
X-Original-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FA265C644
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 20:42:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 560A6989CC7
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 18:37:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 455023B8BB8;
	Wed, 21 Jan 2026 18:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tgxetAIV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F29DD38BF61;
	Wed, 21 Jan 2026 18:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769020446; cv=none; b=gfpH6OT6kG3zsAwIkuCZwhAhqFj6LvQqJ0FE2U5/rFSdg8ofSendeX9ZQV0tQsIl/NW0xv0JJb1W4jHffkSYwvrqwfeb2RG7ZVdZAW2Z4boSofwyBjAA4s0zKv99MGRidCXkJ0YPHdknStR5ycrVnIYXtyBxSQUIGY5tG3Jys1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769020446; c=relaxed/simple;
	bh=dsfaS/Jtu4twmORKoi8lJZvvSvjdx6aoD1OT/MHirtg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qY3Aujs/8Zaw3NQ5BCKK5/4F0+XEbgeAOaGfF9gh+p5o18lekAW6t/x35wo5und+uILy/ck1SoSxBYsMl08Pepg5rrqXvM6VFwxFlx+99eQJ7+Wpa0MPyuX6dqFsgxdOt2MHefOPVX/WZtJC2UezgofzxgPUMrPslxtu8dit2nE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tgxetAIV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1717C4CEF1;
	Wed, 21 Jan 2026 18:34:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1769020445;
	bh=dsfaS/Jtu4twmORKoi8lJZvvSvjdx6aoD1OT/MHirtg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tgxetAIVfh1CkGFVQBTXo2Lhcwv13QYjQHSRFhkFATQLcPu/1DltBZ2x6jAiLYBvv
	 hecCIWmdY8T0rWwwC1IhXI9J/e8UukNYfsoTM64A1xKVmQyl613QnkY4MA7sFRuR/K
	 S8qT/FvvRDGnNlBXmwqtvbpAyIsLQH8gUcA2C358=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Binbin Zhou <zhoubinbin@loongson.cn>,
	Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH 6.18 160/198] LoongArch: dts: loongson-2k0500: Add default interrupt controller address cells
Date: Wed, 21 Jan 2026 19:16:28 +0100
Message-ID: <20260121181424.310386137@linuxfoundation.org>
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
	DMARC_POLICY_ALLOW(0.00)[linuxfoundation.org,none];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-211102-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_PROHIBIT(0.00)[0.152.150.128:email];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,0.0.0.0:email,1fe11600:email]
X-Rspamd-Queue-Id: 9FA265C644
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Binbin Zhou <zhoubinbin@loongson.cn>

commit c4461754e6fe7e12a3ff198cce4707e3e20e43d4 upstream.

Add missing address-cells 0 to the Local I/O and Extend I/O interrupt
controller node to silence W=1 warning:

  loongson-2k0500.dtsi:513.5-51: Warning (interrupt_map): /bus@10000000/pcie@1a000000/pcie@0,0:interrupt-map:
    Missing property '#address-cells' in node /bus@10000000/interrupt-controller@1fe11600, using 0 as fallback

Value '0' is correct because:
1. The Local I/O & Extend I/O interrupt controller do not have children,
2. interrupt-map property (in PCI node) consists of five components and
   the fourth component "parent unit address", which size is defined by
   '#address-cells' of the node pointed to by the interrupt-parent
   component, is not used (=0)

Cc: stable@vger.kernel.org
Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/loongarch/boot/dts/loongson-2k0500.dtsi |    3 +++
 1 file changed, 3 insertions(+)

--- a/arch/loongarch/boot/dts/loongson-2k0500.dtsi
+++ b/arch/loongarch/boot/dts/loongson-2k0500.dtsi
@@ -131,6 +131,7 @@
 			reg-names = "main", "isr0";
 
 			interrupt-controller;
+			#address-cells = <0>;
 			#interrupt-cells = <2>;
 			interrupt-parent = <&cpuintc>;
 			interrupts = <2>;
@@ -149,6 +150,7 @@
 			reg-names = "main", "isr0";
 
 			interrupt-controller;
+			#address-cells = <0>;
 			#interrupt-cells = <2>;
 			interrupt-parent = <&cpuintc>;
 			interrupts = <4>;
@@ -164,6 +166,7 @@
 			compatible = "loongson,ls2k0500-eiointc";
 			reg = <0x0 0x1fe11600 0x0 0xea00>;
 			interrupt-controller;
+			#address-cells = <0>;
 			#interrupt-cells = <1>;
 			interrupt-parent = <&cpuintc>;
 			interrupts = <3>;



