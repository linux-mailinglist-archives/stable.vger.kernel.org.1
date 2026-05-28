Return-Path: <stable+bounces-255734-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YM67LqqkGGoQlwgAu9opvQ
	(envelope-from <stable+bounces-255734-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:25:14 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id BF99F5F8A2A
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:25:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D913A3062CF0
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 20:22:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D76703101B0;
	Thu, 28 May 2026 20:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xAp52enl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B590F30C15B;
	Thu, 28 May 2026 20:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779999734; cv=none; b=SeEHOswM5E8coSamCge+sl2ebQoDl0h0Goqf7vNa3l6muLfJG+H95JxHhq9nOo01a38s75uIGOCcDCYZwAtDk/S2jH2QBJePV6Ozq6y2UHuF3VceizpLxoOvQB1qomft/c19GgmZip2AXaQMCs2Kdb+y8tCKLZ7KRCysZmMRlp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779999734; c=relaxed/simple;
	bh=nBdi2k6g3y1hTMiVT7jhaP5lDreqoIaeVOXYDiIv8gs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DqepEGASf73lO/FTiPwSFcdSoSbwDP0h9hjopE88m94HqYn8D8oi4inT6IKoPwDXa8CfT1jQy+qJRxTMGjXJC1jUnemo6l6xN0ViDtBzerznR/8z/5GBbgs25Firt92YGiv8ra5pke4ldgisnVSurB4aqtKHqArTzbL9VfqBfm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xAp52enl; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 200B21F000E9;
	Thu, 28 May 2026 20:22:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779999733;
	bh=h+O5WZZuClhXYuiTTv9Y05W4Ss58c7QS8oYCqtH6MZQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=xAp52enlds0Dfq9gkBdw93HnbzT1tqDrLTTsuw6iMr23w30caFw7OI8ANbMbYTKeU
	 yXiLFlN153jaRWH7fRbCFs+hAm1bbvQj3XU3U2JUJVJLgPbt8sKoVikOSRn+MtF27f
	 9vLIFAqQ9yVk8gzr4KAIloSBRurqnsvXbPxesljA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 172/377] ARM: dts: renesas: rskrza1: Drop superfluous cells
Date: Thu, 28 May 2026 21:46:50 +0200
Message-ID: <20260528194643.411117241@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260528194638.371537336@linuxfoundation.org>
References: <20260528194638.371537336@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-255734-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable,renesas];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[1.18.168.128:email,msgid.link:url,glider.be:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,linuxfoundation.org:mid,linuxfoundation.org:dkim,mailbox.org:email]
X-Rspamd-Queue-Id: BF99F5F8A2A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Marek Vasut <marek.vasut+renesas@mailbox.org>

[ Upstream commit ab83176d3cf1cf1c1f6e604432905bda4515d17f ]

Drop superfluous address-cells and size-cells to fix DTC W=1 warning:

    arch/arm/boot/dts/renesas/r7s72100-rskrza1.dts:32.17-72.4: Warning (avoid_unnecessary_addr_size): /flash@18000000: unnecessary #address-cells/#size-cells without "ranges", "dma-ranges" or child "reg" or "ranges" property

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
Fixes: 98537eb77d3ef185 ("ARM: dts: renesas: rskrza1: Add FLASH nodes")
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/20260327234244.91707-7-marek.vasut+renesas@mailbox.org
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/renesas/r7s72100-rskrza1.dts | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/boot/dts/renesas/r7s72100-rskrza1.dts b/arch/arm/boot/dts/renesas/r7s72100-rskrza1.dts
index 91178fb9e7210..3306bc9b7bc37 100644
--- a/arch/arm/boot/dts/renesas/r7s72100-rskrza1.dts
+++ b/arch/arm/boot/dts/renesas/r7s72100-rskrza1.dts
@@ -36,8 +36,6 @@ flash@18000000 {
 		power-domains = <&cpg_clocks>;
 		bank-width = <4>;
 		device-width = <1>;
-		#address-cells = <1>;
-		#size-cells = <1>;
 
 		partitions {
 			compatible = "fixed-partitions";
-- 
2.53.0




