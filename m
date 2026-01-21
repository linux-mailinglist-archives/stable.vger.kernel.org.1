Return-Path: <stable+bounces-210904-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CPsgMcw0cWlQfQAAu9opvQ
	(envelope-from <stable+bounces-210904-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 21:19:24 +0100
X-Original-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EAD95D082
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 21:19:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B35B378C8F9
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 18:24:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32DD23A7F4E;
	Wed, 21 Jan 2026 18:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OxmcN/b0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4F1134AAF2;
	Wed, 21 Jan 2026 18:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769019775; cv=none; b=bbJIKADQ7rBud4YggJ1VSd+dHahoJF3Jb2p3oToGgRbnZAywjX/vOr7XN42DBl+an0T1Lf+P7ATOPcrtQawh+pzgu48l+o+Apsv+g9LKR4lSXVQBrO2fI87BzYaaElzrW7jP6ANZU4IeFDqSs9TuGUAAPglN+P253NqQrD3TjWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769019775; c=relaxed/simple;
	bh=qCYy7gBNAW7r3B6sgGVYnOdZrCO2uLKKJIvjcvLQULY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bi/nrVKPhy5xR9btv7HAgsX9lPP/5iQTcpdBgwyskP9KPLul46lj0Y6LyMnF388xkttsctyxwpyrXiiTy74bBVTUhvRP1dzk/Lin62I+if33B5nxiGIP4DfEdT2RxreUvvRbWP4gR15qLo9kQSQ3H/7ToBDPHj1Dz1TlHhsYn1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OxmcN/b0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83F23C4CEF1;
	Wed, 21 Jan 2026 18:22:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1769019775;
	bh=qCYy7gBNAW7r3B6sgGVYnOdZrCO2uLKKJIvjcvLQULY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OxmcN/b0M5iZkgk2RLfbZ4yBc1nRvFtjKDNQvYLA2VMJ0bCY5ZDFFwvyImkQ949te
	 G5RQ8c/ywFDJLBvaXkvLElWgFgySjli71jGivK8zYIqI9g2qzVKRwLsZcQMeXcB3mN
	 JabLIjGgSYCn6NTwke0RN8PBbchwkJVmXm+lZFzM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Binbin Zhou <zhoubinbin@loongson.cn>,
	Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH 6.12 105/139] LoongArch: dts: loongson-2k1000: Add default interrupt controller address cells
Date: Wed, 21 Jan 2026 19:15:53 +0100
Message-ID: <20260121181415.227540437@linuxfoundation.org>
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
	DMARC_POLICY_ALLOW(0.00)[linuxfoundation.org,none];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-210904-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_PROHIBIT(0.00)[0.0.0.9:email];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[0.152.150.128:email,linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,1a000000:email,loongson.cn:email]
X-Rspamd-Queue-Id: 4EAD95D082
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

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



