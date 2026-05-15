Return-Path: <stable+bounces-248717-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KJVAB9pTB2pIygIAu9opvQ
	(envelope-from <stable+bounces-248717-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 19:11:54 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 91233554948
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 19:11:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 458153130738
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 16:30:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DC423BB11C;
	Fri, 15 May 2026 16:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Sgm7Q41M"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1A2A3E008D;
	Fri, 15 May 2026 16:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778862448; cv=none; b=ajfxYgQyQKNZZYBDte5BTPqgCMdN/O/cLFXt6JJj9a+pSJ20v8RMs672X4C9mrZMDzGtirhXPtYFkAdLdecWTza4brVxLRO7h5yk3mM74Wl+XqRu2/+//+TnnlgLpm/ojyb9KxWztikAtliDGft+C2w6Zhyn/gZqg9zd+ex7WBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778862448; c=relaxed/simple;
	bh=jcoM6jbxXPsMf+MEqiYBul6bm29htgADRvrz5U+0LyI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CCBQ7JW7nBRLIvDt6eSlJFSmXjLDqiS3jGozb6z7g1UfNYtH3LSLjoEC+biTWUJo8nfNS1yy5SLkqkMFhruh2dPQpyjxZIeuv0MROOS9ApA5cjShbQoGg7PsnykMKe0qxOY3fe5k2Zt44L4Fc37VUQgY2RAyOPNuhhJ4cpmyNbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Sgm7Q41M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02D2BC2BCB0;
	Fri, 15 May 2026 16:27:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778862448;
	bh=jcoM6jbxXPsMf+MEqiYBul6bm29htgADRvrz5U+0LyI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Sgm7Q41MJoou8xfJYo1CHV3mXmVzFaRZHdSrn8j5KE9Fa1bfld09vo9k0CbSigPzJ
	 B5qzLHyFZS+s0jY2SIrVXDLBljQOztA+PO3QZxZFt6r5PBhGChsnmyWq3xjMbz+2s7
	 D1MYfBgVNQm1/aQWPNp3Y/uGBZcs8ekvwLDTc+Fg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Franz Schnyder <franz.schnyder@toradex.com>,
	Francesco Dolcini <francesco.dolcini@toradex.com>,
	Vignesh Raghavendra <vigneshr@ti.com>
Subject: [PATCH 7.0 053/201] arm64: dts: ti: k3-am69-aquila-clover: Fix DP regulator enable GPIO
Date: Fri, 15 May 2026 17:47:51 +0200
Message-ID: <20260515154659.685177870@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260515154658.538039039@linuxfoundation.org>
References: <20260515154658.538039039@linuxfoundation.org>
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
X-Rspamd-Queue-Id: 91233554948
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
	TAGGED_FROM(0.00)[bounces-248717-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url,ti.com:email,toradex.com:email,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Action: no action

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Franz Schnyder <franz.schnyder@toradex.com>

commit 8cfb2e517113543e0de9e8df5754d5e09cb3627e upstream.

Correct the DP regulator enable GPIO to index 21.
The 3.3V DP regulator was not being enabled by the assigned GPIO, as it
is routed to GPIO index 21 and not 37, which was causing instability
with displays connected over DP or via an active DP-to-HDMI adapter.

Fixes: 9f748a6177e1 ("arm64: dts: ti: am69-aquila: Add Clover")
Cc: stable@vger.kernel.org
Signed-off-by: Franz Schnyder <franz.schnyder@toradex.com>
Reviewed-by: Francesco Dolcini <francesco.dolcini@toradex.com>
Link: https://patch.msgid.link/20260202083604.325060-3-fra.schnyder@gmail.com
Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/boot/dts/ti/k3-am69-aquila-clover.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am69-aquila-clover.dts b/arch/arm64/boot/dts/ti/k3-am69-aquila-clover.dts
index ec8ff4587715..dc0d3cf2f985 100644
--- a/arch/arm64/boot/dts/ti/k3-am69-aquila-clover.dts
+++ b/arch/arm64/boot/dts/ti/k3-am69-aquila-clover.dts
@@ -26,7 +26,7 @@ reg_3v3_dp: regulator-3v3-dp {
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_gpio_21_dp>;
 		/* Aquila GPIO_21_DP (AQUILA B57) */
-		gpio = <&main_gpio0 37 GPIO_ACTIVE_HIGH>;
+		gpio = <&main_gpio0 21 GPIO_ACTIVE_HIGH>;
 		enable-active-high;
 		regulator-max-microvolt = <3300000>;
 		regulator-min-microvolt = <3300000>;
-- 
2.54.0




