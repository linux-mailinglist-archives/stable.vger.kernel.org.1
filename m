Return-Path: <stable+bounces-256084-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4BS8Eq+pGGpolwgAu9opvQ
	(envelope-from <stable+bounces-256084-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:46:39 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BADB25F9854
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:46:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1933F3129847
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 20:38:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74A4B330D35;
	Thu, 28 May 2026 20:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="C/Ml07Me"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 523D12E7F25;
	Thu, 28 May 2026 20:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780000710; cv=none; b=IdTAl0b9vgp3OQ4gORESPNQiGmQGGKlVcpO1tklfVetB0d+BQe1T/20DuJWMu2znmEp85W7sViwUVZ7zYXXDmiSW+gUEiiAJsLulh+h9DruE3rwJ4UR/ezX+1LOb73mRUS2udo2UBGE2hVYjbIKnXTpgWwKkO588CBS1BBbhbzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780000710; c=relaxed/simple;
	bh=T+eEFRse8n1qs9R+xTGBbLd4L7knUEUgploeDt9e+Bs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LFf6uPzMy8FL/Xy1ezLZDfluV83hvY7+qN1aiuwtEzVggvMf9xlrUEA9F0YeKwAEDeX8a0Rhze1TNVq6PyxBMQcanX6PAcER/eTqlH21fd0X9ZXMHn26VaIV8uND5ATBaBsP9aDK52bf+qYTvaRSqT18QRhSbrX8vF6xY529V6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=C/Ml07Me; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 745851F000E9;
	Thu, 28 May 2026 20:38:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780000709;
	bh=x/8WlQb44HIL/rxjh5bV8m/m1fBuTZtNmB7uNXcqTDo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=C/Ml07MehrWk52wzUL733lH5LL2VCgXy1PYx5z31t/WmuUfIrYqnWBJxGWApbILCK
	 LUW8QyTGF3Elr8uUIwOlcOAtxdu1iFDJODY6ZeHta9DifmJI5yNXWnYdurGC9bn3T2
	 Tra1LPmqRg1mmwQTLVnq45V+dRjDbRqPBrABxhII=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 142/272] ARM: dts: renesas: genmai: Drop superfluous cells
Date: Thu, 28 May 2026 21:48:36 +0200
Message-ID: <20260528194633.348051308@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260528194629.379955525@linuxfoundation.org>
References: <20260528194629.379955525@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-256084-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable,renesas];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mailbox.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,msgid.link:url,glider.be:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,1.18.168.128:email]
X-Rspamd-Queue-Id: BADB25F9854
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Marek Vasut <marek.vasut+renesas@mailbox.org>

[ Upstream commit 714e1d6bba0e0abe5c87c8e189a35fa690540df4 ]

Drop superfluous address-cells and size-cells to fix DTC W=1 warning:

    arch/arm/boot/dts/renesas/r7s72100-genmai.dts:28.17-55.4: Warning (avoid_unnecessary_addr_size): /flash@18000000: unnecessary #address-cells/#size-cells without "ranges", "dma-ranges" or child "reg" or "ranges" property

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
Fixes: 30e0a8cf886cb459 ("ARM: dts: renesas: genmai: Add FLASH nodes")
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/20260327234244.91707-6-marek.vasut+renesas@mailbox.org
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/renesas/r7s72100-genmai.dts | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/arm/boot/dts/renesas/r7s72100-genmai.dts b/arch/arm/boot/dts/renesas/r7s72100-genmai.dts
index 28e703e0f152b..9bfbd25b25a24 100644
--- a/arch/arm/boot/dts/renesas/r7s72100-genmai.dts
+++ b/arch/arm/boot/dts/renesas/r7s72100-genmai.dts
@@ -38,9 +38,6 @@ flash@18000000 {
 		clocks = <&mstp9_clks R7S72100_CLK_SPIBSC0>;
 		power-domains = <&cpg_clocks>;
 
-		#address-cells = <1>;
-		#size-cells = <1>;
-
 		partitions {
 			compatible = "fixed-partitions";
 			#address-cells = <1>;
-- 
2.53.0




