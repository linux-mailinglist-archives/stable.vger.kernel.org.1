Return-Path: <stable+bounces-227021-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uE88AvyDumlpXgIAu9opvQ
	(envelope-from <stable+bounces-227021-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 11:52:44 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D0F92BA43A
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 11:52:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 56C4B30D480B
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 10:51:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D78C39B942;
	Wed, 18 Mar 2026 10:51:37 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B97C37D126
	for <stable@vger.kernel.org>; Wed, 18 Mar 2026 10:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773831096; cv=none; b=hYnTEUeynkvlx5fMhA9vDKhvG5Za5Gst6cZ1j/WAhHTQgdZltsUCzROl9XiENtcvPGJgzHYv64q6R1SH8HmYK89NngBS5zgVMgKRt2etAxg7mNWJPa3D+98qAWuXzZwhMWxNrccOtaIyRva0IJ2vwxO5lGfNNDR0p2HDo0aMAnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773831096; c=relaxed/simple;
	bh=thnm6PEYhA6tWFCd44xDPHzccXm1OIwwLMjKMACRj+0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qrJayRUTfzXb/d9cgANQ6TI3HOP+vuO6ZAghY28uyp+zAIdoeaOK77FZFJNiTKvuRqocIUxlMdRWyqHDe1SMl1kf14P7i+lDjVO6ZUW9QdAxzmWauDIWESK6bjL51BR8nyAqeUfMzXtm9uQnycfbZlp79pG9igyDWA8fg3vW1Hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1w2oUn-0001WK-F0; Wed, 18 Mar 2026 11:51:25 +0100
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac] helo=dude04)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1w2oUn-000tSO-06;
	Wed, 18 Mar 2026 11:51:25 +0100
Received: from ore by dude04 with local (Exim 4.98.2)
	(envelope-from <ore@pengutronix.de>)
	id 1w2oUm-00000003RIS-41UW;
	Wed, 18 Mar 2026 11:51:24 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: David Jander <david@protonic.nl>,
	stable@vger.kernel.org,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com
Subject: [PATCH v1 2/7] ARM: dts: stm32: stm32mp15x-mecio1-io: Fix ADC sampling times
Date: Wed, 18 Mar 2026 11:51:18 +0100
Message-ID: <20260318105123.819807-3-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260318105123.819807-1-o.rempel@pengutronix.de>
References: <20260318105123.819807-1-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: stable@vger.kernel.org
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[pengutronix.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,foss.st.com];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-227021-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.993];
	FROM_NEQ_ENVFROM(0.00)[o.rempel@pengutronix.de,stable@vger.kernel.org];
	TAGGED_RCPT(0.00)[stable,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5D0F92BA43A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: David Jander <david@protonic.nl>

Increase the minimum ADC sample times for all configured channels on
ADC1 and ADC2 to ensure measurement accuracy meets specifications.

The default 5us sample time is insufficient for the internal sampling
capacitor to fully charge. Increase the default time to 20us to relax
the input impedance requirements.

Additionally, the phint0_ain and phint1_ain channels require a much
longer sampling period due to their specific circuit design. Increase
their sample times to 200us. Remove stale comments regarding clock
cycles that no longer match the updated timings.

Fixes: 8267753c891c ("ARM: dts: stm32: Add MECIO1 and MECT1S board variants")
Cc: <stable@vger.kernel.org>
Signed-off-by: David Jander <david@protonic.nl>
Co-developed-by: Oleksij Rempel <o.rempel@pengutronix.de>
Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 .../arm/boot/dts/st/stm32mp15x-mecio1-io.dtsi | 32 +++++++++----------
 1 file changed, 15 insertions(+), 17 deletions(-)

diff --git a/arch/arm/boot/dts/st/stm32mp15x-mecio1-io.dtsi b/arch/arm/boot/dts/st/stm32mp15x-mecio1-io.dtsi
index 1ce01bac9814..1b1299770ca0 100644
--- a/arch/arm/boot/dts/st/stm32mp15x-mecio1-io.dtsi
+++ b/arch/arm/boot/dts/st/stm32mp15x-mecio1-io.dtsi
@@ -104,80 +104,79 @@ &adc1 {
 
 	channel@0 {
 		reg = <0>;
-		/* 16.5 ck_cycles sampling time */
-		st,min-sample-time-ns = <5000>;
+		st,min-sample-time-ns = <20000>;
 		label = "p24v_stp";
 	};
 
 	channel@1 {
 		reg = <1>;
-		st,min-sample-time-ns = <5000>;
+		st,min-sample-time-ns = <20000>;
 		label = "p24v_hpdcm";
 	};
 
 	channel@2 {
 		reg = <2>;
-		st,min-sample-time-ns = <5000>;
+		st,min-sample-time-ns = <20000>;
 		label = "ain0";
 	};
 
 	channel@3 {
 		reg = <3>;
-		st,min-sample-time-ns = <5000>;
+		st,min-sample-time-ns = <20000>;
 		label = "hpdcm1_i2";
 	};
 
 	channel@5 {
 		reg = <5>;
-		st,min-sample-time-ns = <5000>;
+		st,min-sample-time-ns = <20000>;
 		label = "hpout1_i";
 	};
 
 	channel@6 {
 		reg = <6>;
-		st,min-sample-time-ns = <5000>;
+		st,min-sample-time-ns = <20000>;
 		label = "ain1";
 	};
 
 	channel@9 {
 		reg = <9>;
-		st,min-sample-time-ns = <5000>;
+		st,min-sample-time-ns = <20000>;
 		label = "hpout0_i";
 	};
 
 	channel@10 {
 		reg = <10>;
-		st,min-sample-time-ns = <5000>;
+		st,min-sample-time-ns = <200000>;
 		label = "phint0_ain";
 	};
 
 	channel@13 {
 		reg = <13>;
-		st,min-sample-time-ns = <5000>;
+		st,min-sample-time-ns = <200000>;
 		label = "phint1_ain";
 	};
 
 	channel@15 {
 		reg = <15>;
-		st,min-sample-time-ns = <5000>;
+		st,min-sample-time-ns = <20000>;
 		label = "hpdcm0_i1";
 	};
 
 	channel@16 {
 		reg = <16>;
-		st,min-sample-time-ns = <5000>;
+		st,min-sample-time-ns = <20000>;
 		label = "lsin";
 	};
 
 	channel@18 {
 		reg = <18>;
-		st,min-sample-time-ns = <5000>;
+		st,min-sample-time-ns = <20000>;
 		label = "hpdcm0_i2";
 	};
 
 	channel@19 {
 		reg = <19>;
-		st,min-sample-time-ns = <5000>;
+		st,min-sample-time-ns = <20000>;
 		label = "hpdcm1_i1";
 	};
 };
@@ -187,14 +186,13 @@ &adc2 {
 
 	channel@2 {
 		reg = <2>;
-		/* 16.5 ck_cycles sampling time */
-		st,min-sample-time-ns = <5000>;
+		st,min-sample-time-ns = <20000>;
 		label = "ain2";
 	};
 
 	channel@6 {
 		reg = <6>;
-		st,min-sample-time-ns = <5000>;
+		st,min-sample-time-ns = <20000>;
 		label = "ain3";
 	};
 };
-- 
2.47.3


