Return-Path: <stable+bounces-220590-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +AN/IKA/o2kR+wQAu9opvQ
	(envelope-from <stable+bounces-220590-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:18:56 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E062F1C6D28
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:18:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 31F2B3066E7E
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:51:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44BA83E04CB;
	Sat, 28 Feb 2026 17:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kDIx5jag"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 077453E04C1;
	Sat, 28 Feb 2026 17:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300473; cv=none; b=RoihnyXHzu/SZ3VUM31qjvPxgKsk3dfcHSq4CqZ7MPfluk5lSxLTIOa2GMzIk4nTepX/YuyNC+vCb0ZurlVVmpVRjE1dcbMr3F2Qse3mMTplEJZR0euxBqE6qJ55Dsw4D+C4+lgp6klJ0JxYNNJo5i0Aa6aU827eFtxq/4Y8K3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300473; c=relaxed/simple;
	bh=sRSClu2eF+jcLFV57f7tFFz9qyLvjcSA+nwo7d2RalU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MZL6PesQSbwAuqx02VSkzxPtbzXgZAQyayyxO5GtdOM6bQEBNdshaASzL9sgfLeFACPFOD1fa/t8cjZZE4135XXr2BWWCjvWiBAPj0AzRxxXRQPM/ah9ruakJEOCPU1WhI9xW2+FmtoCrkzLTWFYv00vFBhxc/etJIGDVVkP1Y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kDIx5jag; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21B7CC2BC9E;
	Sat, 28 Feb 2026 17:41:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300472;
	bh=sRSClu2eF+jcLFV57f7tFFz9qyLvjcSA+nwo7d2RalU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kDIx5jagKoAfkeCa7MAK6EOO+WEN0c7hYecQZp6NOGpINBzl753sGgYqF9Xp4LqvB
	 GAQ1NAj7pKXCvYdHVs5qjf3/ADNqI/Yg0J2vobLz3XRuxzt/jMliJ8RJZVEEbKXF66
	 TjF4Ix+5m0OzN1r1SHWqYEMXg/uJIDFEV0tQZwpUchgP9QBseVvdSOtkZ4jQBO2Xzg
	 OzjobXqPGCESPnM6BV9RruhVIbQx2YbOxGg3+3xdgu/7O+KYtxBUvMKsEdiWBNz/mZ
	 suoutQFQVSa2sU6QBNMaitwEGZLzeBpkZ4yCiAQa/qo7wCfdEWnYmR51fMep73M/e5
	 IqZRm/PMvX1eA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>,
	Nishanth Menon <nm@ti.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 511/844] arm64: dts: ti: am62p-verdin: Fix SD regulator startup delay
Date: Sat, 28 Feb 2026 12:27:04 -0500
Message-ID: <20260228173244.1509663-512-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220590-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,toradex.com:email,ti.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E062F1C6D28
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
index 5e050cbb9eaf3..ec9dd931fe922 100644
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


