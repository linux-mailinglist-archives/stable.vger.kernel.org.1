Return-Path: <stable+bounces-218222-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GHo3HddQnmmNUgQAu9opvQ
	(envelope-from <stable+bounces-218222-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:31:03 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D89218ED67
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:31:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4A06E3070BCB
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 01:30:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D79CD248886;
	Wed, 25 Feb 2026 01:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="h5+gNc/c"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ABB523EAA5;
	Wed, 25 Feb 2026 01:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771983016; cv=none; b=k8q4jihTyMML39ReMs3N8Hr6Qu6cpruXpWurbmLgjx5pNU28XYtWJ5FAfvSlWx/VB0MQq24IjAohatJDECITGvvCRDJD5pKFIcLQNyiOWIhC7z+SVqorbEF3g/kMwuRF4rbCd8UIT1s6twwg9ycslVjpH6UrP+UmokjEiysPwcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771983016; c=relaxed/simple;
	bh=UdRu56UI2DZVnvuqZFqCMzVDqRLBaknmvmi1vAjrnng=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UgonA2X6OHYRcw287seHBFQpDGAuaq4lQ6ifY1GrcgEPCjuRfQF4aLOR5IZtH73ZE8Dm3jhzwuH2LjOaa1sqA71QzMTus+gAoFEQa6qIsEXMf+bSy+bHbb7StOdVXWMzc2jstgPgO9hndNg0YPrqKj4nNF9qpskbRYz0WQeL8gM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=h5+gNc/c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AAF7C116D0;
	Wed, 25 Feb 2026 01:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771983016;
	bh=UdRu56UI2DZVnvuqZFqCMzVDqRLBaknmvmi1vAjrnng=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=h5+gNc/ccG2Nrv3yrIs6QYZ6OYPmqfauaC5mVEbI1XWKqLe7CxwcC6eq2qHnEytUO
	 FuD3w8rkAH1VgEUPk9Wq64Ca3GyLQDP7pr+2ZX/JsAHxeWHc7t1cUkSEApK1Yj1bjH
	 yJebv2Pmb6tj/FgGvzTpT3UdJXdaLL8PYRtFIX3U=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Michael Walle <mwalle@kernel.org>,
	Nishanth Menon <nm@ti.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 184/781] arm64: dts: ti: k3-am67a-kontron-sa67-base: Fix SD card regulator
Date: Tue, 24 Feb 2026 17:14:53 -0800
Message-ID: <20260225012404.159048698@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260225012359.695468795@linuxfoundation.org>
References: <20260225012359.695468795@linuxfoundation.org>
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-218222-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 7D89218ED67
X-Rspamd-Action: no action

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michael Walle <mwalle@kernel.org>

[ Upstream commit 53289af62b66812d07a7b0f5f9d62f429c94d317 ]

The property "enable-active-high" was missing, as the default is
active-low. Add it.

Fixes: 1c3c4df06f9d ("arm64: dts: ti: Add support for Kontron SMARC-sAM67")
Signed-off-by: Michael Walle <mwalle@kernel.org>
Link: https://patch.msgid.link/20260115131431.1521102-3-mwalle@kernel.org
Signed-off-by: Nishanth Menon <nm@ti.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/ti/k3-am67a-kontron-sa67-base.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am67a-kontron-sa67-base.dts b/arch/arm64/boot/dts/ti/k3-am67a-kontron-sa67-base.dts
index 3be6c6d19def5..95234c8460ed0 100644
--- a/arch/arm64/boot/dts/ti/k3-am67a-kontron-sa67-base.dts
+++ b/arch/arm64/boot/dts/ti/k3-am67a-kontron-sa67-base.dts
@@ -173,6 +173,7 @@ vcc_3p3_sd_vio_s0: regulator-6 {
 		regulator-max-microvolt = <3300000>;
 		vin-supply = <&vcc_3p3_s0>;
 		regulator-boot-on;
+		enable-active-high;
 		enable-gpios = <&main_gpio0 7 GPIO_ACTIVE_HIGH>;
 		gpios = <&main_gpio0 8 GPIO_ACTIVE_HIGH>;
 		states = <3300000 0x0>,
-- 
2.51.0




