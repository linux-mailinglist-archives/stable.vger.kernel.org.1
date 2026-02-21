Return-Path: <stable+bounces-217646-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2JPEOGz2mWltXgMAu9opvQ
	(envelope-from <stable+bounces-217646-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 21 Feb 2026 19:16:12 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 84FC816D787
	for <lists+stable@lfdr.de>; Sat, 21 Feb 2026 19:16:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E34B1306144C
	for <lists+stable@lfdr.de>; Sat, 21 Feb 2026 18:15:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F09D30DEA9;
	Sat, 21 Feb 2026 18:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=puri.sm header.i=@puri.sm header.b="vomIkakD"
X-Original-To: stable@vger.kernel.org
Received: from ms.puri.sm (ms.puri.sm [135.181.196.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5684309EEB;
	Sat, 21 Feb 2026 18:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=135.181.196.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771697735; cv=none; b=iMclLrvwDW8FkXCJnLdU4N+Y/r0SHjW62vVzf8RbKF/bZF6gt+UwiFwV9/s2ZmlydwoMpnbBHMHMIdgc4+0QrjomH2jf6Fm+kNRqbV8ySsQJydyK8RCvA/V1YBBUGhd7v5jXZPWiJ61W8+LUz7o5dW17IqBOGLmgh6Wt4AL5mSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771697735; c=relaxed/simple;
	bh=6qD4WxlgSPhVsvrYvovWSqRW5CeLnWSLVEIuD0nudn0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eVkOM+clqEApMt06CItXcqkrrN73kVqUXAUfsdNdVlIhSWcUpgO3gvgMva9Igk3zp8VVrRcmME62tusJqVdzRXj6Z6JV+sEzfY9Ae+S8ZPCsv+S4CsRBsYdoIC3OP4QXturRLLdHrnnQ1E318Yc5IOkeJNMHgfDz9JZ9RqADINk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=puri.sm; spf=pass smtp.mailfrom=puri.sm; dkim=pass (2048-bit key) header.d=puri.sm header.i=@puri.sm header.b=vomIkakD; arc=none smtp.client-ip=135.181.196.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=puri.sm
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=puri.sm
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=puri.sm; s=smtp2;
	t=1771697732; bh=6qD4WxlgSPhVsvrYvovWSqRW5CeLnWSLVEIuD0nudn0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=vomIkakDhqc7ckGditKPSVQJgTR81T9qO8QthHrcgF19gPCvhDIuOx1L76lsEUYPe
	 6zj0MPzJO6J0OpRzJFDMxJoFHQ7XiBDXeV92pa+fdwR0a2NH9THiVwwKpjca9dsGRr
	 z8kZlpu1dNH0aLxaC7SsV1d9FQSWFfmybquYJvUmOijg99XrI9EW5XHreT5Dz25BAv
	 f9BlzMzSw5iHSJkvrIL9NK62chqMRzMj6UndhbW6mOaQ713hGoKb/Aw0i7iSjrSnJ/
	 3ScBzG/1d6oOxuPMGc0KDzm/5Kii20usIEjbDwFbsrKaXWn7pFJGhsysFBW9oKLwFZ
	 60KIWLtNFrYpA==
Received: from pliszka.localdomain (79.184.40.11.ipv4.supernova.orange.pl [79.184.40.11])
	by ms.puri.sm (Postfix) with ESMTPSA id 7B95E1F6B7;
	Sat, 21 Feb 2026 10:15:31 -0800 (PST)
From: Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>
Date: Sat, 21 Feb 2026 19:15:19 +0100
Subject: [PATCH v2 2/2] arm64: dts: imx8mq-librem5: Bump BUCK1 suspend
 voltage up to 0.85V
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260221-l5-voltages-v2-2-dd8885bb9331@puri.sm>
References: <20260221-l5-voltages-v2-0-dd8885bb9331@puri.sm>
In-Reply-To: <20260221-l5-voltages-v2-0-dd8885bb9331@puri.sm>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Frank Li <Frank.Li@nxp.com>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, 
 Martin Kepplinger <martin.kepplinger@puri.sm>, 
 Shawn Guo <shawnguo@kernel.org>, "Angus Ainslie (Purism)" <angus@akkea.ca>, 
 Daniel Baluta <daniel.baluta@nxp.com>
Cc: kernel@puri.sm, devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Guido_G=C3=BCnther?= <agx@sigxcpu.org>, 
 Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1237;
 i=sebastian.krzyszkowiak@puri.sm; h=from:subject:message-id;
 bh=6qD4WxlgSPhVsvrYvovWSqRW5CeLnWSLVEIuD0nudn0=;
 b=owEBbQKS/ZANAwAKAejyNc8728P/AcsmYgBpmfY/yZm25YPcks8kVOiZpmQMkUlzf4fAbTMtK
 i5qav26UFuJAjMEAAEKAB0WIQQi3Z+uAGoRQ1g2YXzo8jXPO9vD/wUCaZn2PwAKCRDo8jXPO9vD
 /wA0EAC7xmej68FmfWdPdQk3Dw2u3qHJersdxWmVMKT0J+JxvoJIGhvLcIzXayfwpV55P/2xRbe
 wtaknjtOysVw/9JXJs5fbhpYvotz8FqYVt6WUkxZsLdxFc9eLNScL9JddkponP6+1uhU/h0VWnG
 wpkGcGUrpRfYNmhZLThrOCRHr38WS4caL6tUgcn/TC7amEl5FKARztx8DEwo9hAKaK15ELMIxKE
 ta7gjtz0TUsby6uKRpoXg/yX3FQcC0B2HpO4rrG1UD4Ynnt3tdG26yHFzTiW84Q8zAxY1I2ycT4
 c0WpQszde2NK2L89oEJyCx0NSjZVri9AwuW03xBbVRSc0BABbFZR3iFPIJ2UeHwe2hNvNvDfU+9
 LzA0Bt8jv9Gi8XFyGGX/5B1b7WEFPO1VejsTIBPd/KYuVmm9gADkFS04T3JQPMtfiIKolNzAaef
 xesvHNOCGmIf1hD/dlDTIMy9ZqSsxa5pZbxMhWjMz/BZ3r6TGMdzBTRlAb00mKetMEWx2fnJtGe
 dpGlZkjgC7omVXQd7B9bxGJIZI3VwKjXXEaaluOEKqJvRlK67aS71VIYmZM3bbdA1HwHLUqRlKM
 oPjl0ncstpMteakUnQIRPdGPXri8e+wABtKVdIbV7RPloU+fF+lkahf2w9bcQ4hgMW+REDZfKGx
 sifqTFzG9PkSsJQ==
X-Developer-Key: i=sebastian.krzyszkowiak@puri.sm; a=openpgp;
 fpr=22DD9FAE006A11435836617CE8F235CF3BDBC3FF
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[puri.sm,reject];
	R_DKIM_ALLOW(-0.20)[puri.sm:s=smtp2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-217646-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,nxp.com,pengutronix.de,gmail.com,puri.sm,akkea.ca];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sebastian.krzyszkowiak@puri.sm,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[puri.sm:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[puri.sm:mid,puri.sm:dkim,puri.sm:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 84FC816D787
X-Rspamd-Action: no action

The minimal voltage of VDD_SOC sourced from BUCK1 is 0.81V, which
is the currently set value. However, BD71837 only guarantees accuracy
of ±0.01V, and this still doesn't factor other reasons for actual
voltage to slightly drop in, resulting in the possibility of running
out of the operational range.

Bump the voltage up to 0.85V, which should give enough headroom.

Cc: <stable@vger.kernel.org>
Fixes: 8f0216b006e5 ("arm64: dts: Add a device tree for the Librem 5 phone")
Signed-off-by: Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>
---
 arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi b/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi
index 7818d84f25a7..f5d529c5baf3 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi
@@ -882,7 +882,7 @@ buck1_reg: BUCK1 {
 				regulator-ramp-delay = <1250>;
 				rohm,dvs-run-voltage = <900000>;
 				rohm,dvs-idle-voltage = <850000>;
-				rohm,dvs-suspend-voltage = <810000>;
+				rohm,dvs-suspend-voltage = <850000>;
 				regulator-always-on;
 			};
 

-- 
2.53.0


