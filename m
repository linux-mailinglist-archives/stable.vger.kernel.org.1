Return-Path: <stable+bounces-236352-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kAL6ImgZ3WnoZwkAu9opvQ
	(envelope-from <stable+bounces-236352-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 18:27:20 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1211B3EEF67
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 18:27:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 406D0308AF76
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 16:12:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA3C42F362B;
	Mon, 13 Apr 2026 16:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="iDQws/Nf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D9D4274B58;
	Mon, 13 Apr 2026 16:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776096684; cv=none; b=Yhck+Dr6Qs08HhbeOMo+g24Ar0hXR1bPKpWIIDkA73fHOC1PIbvT4B6VRw1h8/neabqhA9xtD6YWtDr+LjBFSE2FfLNB8YIDs3s4cn82DCgtPCIHWLhck+Qfnx5ZoasDzIrVxwnIVlbeWWUbOM8spK12zHBlN5yQRoAJMHNSRxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776096684; c=relaxed/simple;
	bh=AUcFfsjoIC0pAjeFd+MS0TmUiWphBMMcOtOnhd4wQVE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bgIkyFHzrwwdshsdk4GQ2zj7VQL1hYgS/DTmpt56g7HVh0ahkGkhExaWtltTpDEkwSrf6yaGLfZ+JUat4i45Fwis6korknwKwNnqEQbCEt6FFlAtZNBI9x6Ps7PWtCt1a/6igiw9mH6kdV7JoWL+UYYaw9L/Ptpmwr5vA7F2XAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=iDQws/Nf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BFFDC2BCAF;
	Mon, 13 Apr 2026 16:11:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776096684;
	bh=AUcFfsjoIC0pAjeFd+MS0TmUiWphBMMcOtOnhd4wQVE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iDQws/Nf8v5+OwshMNqKIEmi73ZD1H0vtLWId/9KLDrs+x0jwRe9ybbMOgJah9sMT
	 7TiPnduN1hdtuhv54XL49lVmfhr+rDlMFe9d+lkw25rYvdxSod0qPyiRoUDFyu7TqQ
	 1+C7mM+5OSsSpf5kNoMNHH48SXVtQScGtVFZ5d5I=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: [PATCH 6.12 23/70] arm64: dts: renesas: white-hawk-cpu-common: Add pin control for DSI-eDP IRQ
Date: Mon, 13 Apr 2026 18:00:18 +0200
Message-ID: <20260413155729.053333533@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260413155728.181580293@linuxfoundation.org>
References: <20260413155728.181580293@linuxfoundation.org>
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
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-236352-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	TAGGED_RCPT(0.00)[stable,renesas];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,glider.be:email,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid]
X-Rspamd-Queue-Id: 1211B3EEF67
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Geert Uytterhoeven <geert+renesas@glider.be>

commit 8219a455efd4ba11c1d30c1bbc9ce853466c19bf upstream.

When the DSI to eDP bridge was added, pin control for the IRQ pin was
left out, because the pin controller did not support INTC-EX pins yet.

Commit 10544ec1b3436037 ("pinctrl: renesas: r8a779g0: Add INTC-EX
pins, groups, and function") added support for these pins, so add the
missing pin control description.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/89bab2008891be1f003a3c0dbcdf36af3b98da70.1729240573.git.geert+renesas@glider.be
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/boot/dts/renesas/white-hawk-cpu-common.dtsi |    8 ++++++++
 1 file changed, 8 insertions(+)

--- a/arch/arm64/boot/dts/renesas/white-hawk-cpu-common.dtsi
+++ b/arch/arm64/boot/dts/renesas/white-hawk-cpu-common.dtsi
@@ -239,6 +239,9 @@
 	clock-frequency = <400000>;
 
 	bridge@2c {
+		pinctrl-0 = <&irq0_pins>;
+		pinctrl-names = "default";
+
 		compatible = "ti,sn65dsi86";
 		reg = <0x2c>;
 
@@ -343,6 +346,11 @@
 		function = "i2c1";
 	};
 
+	irq0_pins: irq0 {
+		groups = "intc_ex_irq0_a";
+		function = "intc_ex";
+	};
+
 	keys_pins: keys {
 		pins = "GP_5_0", "GP_5_1", "GP_5_2";
 		bias-pull-up;



