Return-Path: <stable+bounces-220928-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AHjUA5lHo2lM/AQAu9opvQ
	(envelope-from <stable+bounces-220928-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:52:57 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C46A1C7774
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:52:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1DEBA323F8C6
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:44:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33AD5333447;
	Sat, 28 Feb 2026 17:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cY1Ifs8U"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA6F732AABE;
	Sat, 28 Feb 2026 17:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772301275; cv=none; b=VULxxCsNg6TfwzI9aKy+gl6rB2CABdxUgi0zQevVtwQVnETbSf17zS9J8meOtk+FGwbotxmBaduNaIRZgwTDn4Zwu/opKAsAtehRHgiWkDfyZggpy3/fYEEGAiTAgdLoQUWTFijpBHr92ZTQhbhFmfoVbjeuBuIZqJ9PCF1Hi/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772301275; c=relaxed/simple;
	bh=sOZafZMaT3kqNgOBlTSDIK2K+h1oEj84NBZvSxfy35E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r+pD3OqQUPaUCg50sTHm+UFsJpDwxLmEXb9DUr4l8z1wsBHpDcDLGxaUjMXubUI5H4loz62mnsWkZBQUzYrybFn8r8MfugF3oJ7zjH6BP2kw+wn5vC7m200t1RAgPZwKpewGqLZK4fiC1lfy5u7cApw6UJQMcrytqfHCbO7xWDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cY1Ifs8U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36421C19423;
	Sat, 28 Feb 2026 17:54:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772301274;
	bh=sOZafZMaT3kqNgOBlTSDIK2K+h1oEj84NBZvSxfy35E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cY1Ifs8UTz4Bk7CZ8WwX48FFtfuTgEFZbFOjFg3LTE+VwEYlfm+12n69tdM85qkGN
	 2zFWTGUCtSF7+6xl9R12Ev8xjJMFKQOs4Gba7/FSIXP/nq059aZ/Jp7gdQVtDYHgZc
	 IOMlsgNWZwGIbKO8/5kJVYHUbDZPXkZ8nOcnkHSPAjW7fQXVczFMYSj7aKX0ZoE2Ts
	 dWuZj3t0c0o7ZCeiKRFWUU1fcyp6XLiOn2Mk6MZ6aFd33H+VLeCZDQ4LwqXCOLQxDb
	 WeJDIBMOdzKik/ZRHdl6SwCEBoBUu248Gx5oXSHbhPZSfTvb8aIroXHv/7FQUm+3sf
	 0rNtNq6b01mJA==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>,
	stable@vger.kernel.org,
	Nishanth Menon <nm@ti.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 459/752] arm64: dts: ti: am62p-verdin: Fix SD regulator startup delay
Date: Sat, 28 Feb 2026 12:42:50 -0500
Message-ID: <20260228174750.1542406-459-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228174750.1542406-1-sashal@kernel.org>
References: <20260228174750.1542406-1-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220928-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ti.com:email,msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6C46A1C7774
X-Rspamd-Action: no action

From: Francesco Dolcini <francesco.dolcini@toradex.com>

[ Upstream commit de86dbc0fb00bd3773db4b05d9f5926f0faa2244 ]

The power switch used to power the SD card interface might have
more than 2ms turn-on time, increase the startup delay to 20ms to
prevent failures.

Fixes: 87f95ea316ac ("arm64: dts: ti: Add Toradex Verdin AM62P")
Cc: stable@vger.kernel.org
Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
Link: https://patch.msgid.link/20251209084126.33282-1-francesco@dolcini.it
Signed-off-by: Nishanth Menon <nm@ti.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/ti/k3-am62p-verdin.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am62p-verdin.dtsi b/arch/arm64/boot/dts/ti/k3-am62p-verdin.dtsi
index 99810047614e3..b7d559c61f3f8 100644
--- a/arch/arm64/boot/dts/ti/k3-am62p-verdin.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62p-verdin.dtsi
@@ -112,7 +112,7 @@ reg_sd1_vmmc: regulator-sdhci1-vmmc {
 		regulator-max-microvolt = <3300000>;
 		regulator-min-microvolt = <3300000>;
 		regulator-name = "+V3.3_SD";
-		startup-delay-us = <2000>;
+		startup-delay-us = <20000>;
 	};
 
 	reg_sd1_vqmmc: regulator-sdhci1-vqmmc {
-- 
2.51.0


