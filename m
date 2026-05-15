Return-Path: <stable+bounces-248522-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kOnEL61OB2p3xwIAu9opvQ
	(envelope-from <stable+bounces-248522-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 18:49:49 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 58285553FC3
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 18:49:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E23053351E31
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 16:21:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E41B64963B0;
	Fri, 15 May 2026 16:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2BBRynbq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6A5D48C8BE;
	Fri, 15 May 2026 16:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778861944; cv=none; b=XzR/Lcz9kp/iOqx/Xqu/0Jt9aASr4//BK1X+1M8M7kWiY3B2yhNd76Dq+Bdy8Zy/Ofpq37uNBof3Xpi/3A1wN9IHPhGSgM02uM+z1p+VsLXABZY/p1lpNpHD1lYICiumXVPt6WO0IyMH2heViAdcx2mUtfEHWzOHB8WCt0EvptM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778861944; c=relaxed/simple;
	bh=sjiIvNU8hvcP63FRuk2/Hf49j7yEx1/xRXitfss440M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JyZ8rJSkWCp2NtZa3XkNkyCUvnSVX/jCfU0TLQDZVU+GUaMYIq55u5lBPtciOmJtZGtwo/yAIjzl4/les4qquJJMH2mPVHnBKqaBPTTKq+Rk0bSgi0tVehxb9MBqVD9c0CAAe0KnIFPs3cYgB60H5whEJWawaUhHa51eE3A0syw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2BBRynbq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38F0DC2BCB3;
	Fri, 15 May 2026 16:19:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778861944;
	bh=sjiIvNU8hvcP63FRuk2/Hf49j7yEx1/xRXitfss440M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=2BBRynbqfh9IanQvIHX24/saaKg51ojjXg7A4LRK6SghxwnvhWcOphOMItLnHa92j
	 Hp1idhC+8+ev9b3uzV8CVH1RCWtVwnniSUOh1320z9DjQp97q6DgPQnkJOIkfjcB8k
	 kmWiCWFftQORtr5vOO91+UkOXfS/lARaEB0bq6YE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Gregor Herburger <gregor.herburger@linutronix.de>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Rasmus Villemoes <ravi@prevas.dk>
Subject: [PATCH 6.18 047/188] arm64: dts: broadcom: bcm2712-d-rpi-5-b: update uart10 interrupt
Date: Fri, 15 May 2026 17:47:44 +0200
Message-ID: <20260515154658.337368542@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260515154657.309489048@linuxfoundation.org>
References: <20260515154657.309489048@linuxfoundation.org>
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
X-Rspamd-Queue-Id: 58285553FC3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-248522-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[broadcom.com:email,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linutronix.de:email,prevas.dk:email]
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Gregor Herburger <gregor.herburger@linutronix.de>

commit 18d4a06e10051681de074a9250e54afc1f3ee312 upstream.

On the -d revision of bcm2712 the uart interrupt is on 120. Update it
accordingly.

Signed-off-by: Gregor Herburger <gregor.herburger@linutronix.de>
Link: https://lore.kernel.org/r/20260226-raspi-dts-updates-v1-6-60832d20ff04@linutronix.de
Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: Rasmus Villemoes <ravi@prevas.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/boot/dts/broadcom/bcm2712-d-rpi-5-b.dts |    4 ++++
 1 file changed, 4 insertions(+)

--- a/arch/arm64/boot/dts/broadcom/bcm2712-d-rpi-5-b.dts
+++ b/arch/arm64/boot/dts/broadcom/bcm2712-d-rpi-5-b.dts
@@ -45,3 +45,7 @@
 	compatible = "brcm,bcm2712d0-aon-pinctrl";
 	reg = <0x7d510700 0x1c>;
 };
+
+&uart10 {
+	interrupts = <GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>;
+};



