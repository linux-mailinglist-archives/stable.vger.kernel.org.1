Return-Path: <stable+bounces-220192-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sGkYBcgto2me+AQAu9opvQ
	(envelope-from <stable+bounces-220192-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:02:48 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A31A11C55C1
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:02:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4D11F30BF31F
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 17:51:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF8AA4C8FED;
	Sat, 28 Feb 2026 17:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="btfSCLA5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1C2E4C8FE7;
	Sat, 28 Feb 2026 17:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300098; cv=none; b=bSOaZa/70JuUy5yW8Ny6anf31A7tSyrgL4udmR9t1mIDNneysmrAsSMuGmtj9im4z3TGMdvvMM+GFv7UF5CUmlIeXO8oeg2SmJzbC4erUrjmzyPE4h2mFjYtjKWkF/kc47AuVNMKq628o6mD6sZzf26LDyS6deLMF5xlVhBpPRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300098; c=relaxed/simple;
	bh=npRQ0tXYpgs62t84J3RGWsOTLTpkojqnwhv4hiqG08s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iHkDVTHRTxOLlnFD5nJHssUPlOnJG41Tq89l1cPSgHgzWj9g9aSRxfW/HFW70e4gI0IXw8BvnYElstiFE9ZHrnPNzYtjtJtVoOT4D71EN63THPjrVR73jG22Tej8l7J4tkwBPxMG24wf32oDuieutjXODWUvJAyeQ5o/1C2vhd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=btfSCLA5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF9DDC2BCAF;
	Sat, 28 Feb 2026 17:34:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300098;
	bh=npRQ0tXYpgs62t84J3RGWsOTLTpkojqnwhv4hiqG08s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=btfSCLA5z5gmWbIvTTfbWZ1Cjv6wl3OgviL5roAMkVZD/ubZX4BCIGr1q5eGkGmXb
	 GuJBnUJYsc94cflkLGGJ0YkhXD3dNeEpRSxmV7LIVkDp6EiuuTYXsbHauBtwKPcrGA
	 TmNjix+Hs5AK8v5JzVp8ubC7+7ZUQXx+KgxAPZP3lkH82XrsdZfCeTXsu7KzKx9dj5
	 KlECEUEjZZFHVxSfklIkG5kLd2cXkO3ZBqsJ5sK5gtrHYo1UKxcUrxMs1oZLjwyhDY
	 gy5CTbifYDEDVsYHOpS4gkRPL9nMM5FgjqZXcvSK1KJji478SWeihB0PBgGUSbqHAw
	 Xn1i6MszFa34g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Tomas Melin <tomas.melin@vaisala.com>,
	Michal Simek <michal.simek@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 114/844] Revert "arm64: zynqmp: Add an OP-TEE node to the device tree"
Date: Sat, 28 Feb 2026 12:20:27 -0500
Message-ID: <20260228173244.1509663-115-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220192-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,amd.com:email,vaisala.com:email]
X-Rspamd-Queue-Id: A31A11C55C1
X-Rspamd-Action: no action

From: Tomas Melin <tomas.melin@vaisala.com>

[ Upstream commit c197179990124f991fca220d97fac56779a02c6d ]

This reverts commit 06d22ed6b6635b17551f386b50bb5aaff9b75fbe.

OP-TEE logic in U-Boot automatically injects a reserved-memory
node along with optee firmware node to kernel device tree.
The injection logic is dependent on that there is no manually
defined optee node. Having the node in zynqmp.dtsi effectively
breaks OP-TEE's insertion of the reserved-memory node, causing
memory access violations during runtime.

Signed-off-by: Tomas Melin <tomas.melin@vaisala.com>
Signed-off-by: Michal Simek <michal.simek@amd.com>
Link: https://lore.kernel.org/r/20251125-revert-zynqmp-optee-v1-1-d2ce4c0fcaf6@vaisala.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/xilinx/zynqmp.dtsi | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
index 938b014ca9231..b55c6b2e8e0e1 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
+++ b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
@@ -192,11 +192,6 @@ psci {
 	};
 
 	firmware {
-		optee: optee  {
-			compatible = "linaro,optee-tz";
-			method = "smc";
-		};
-
 		zynqmp_firmware: zynqmp-firmware {
 			compatible = "xlnx,zynqmp-firmware";
 			#power-domain-cells = <1>;
-- 
2.51.0


