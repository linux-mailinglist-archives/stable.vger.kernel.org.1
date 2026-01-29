Return-Path: <stable+bounces-212764-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uG0LMyM7e2mNCgIAu9opvQ
	(envelope-from <stable+bounces-212764-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 29 Jan 2026 11:49:07 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A26AAF168
	for <lists+stable@lfdr.de>; Thu, 29 Jan 2026 11:49:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BBF96300A8F0
	for <lists+stable@lfdr.de>; Thu, 29 Jan 2026 10:49:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 235483816F9;
	Thu, 29 Jan 2026 10:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W7CA5ZyS"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A6003815EF
	for <stable@vger.kernel.org>; Thu, 29 Jan 2026 10:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769683742; cv=none; b=MDOdZ/DUwv0tSadcAZSFrGmcWkI7Tr9ZK3nPbjMe+4zcvzGMxVKWArBW0nFao8h0SjV63A/AKO8IvszbMvVOqiDqcDx1JREY1v02naXItNQNaHG6/f2BAwHAieTgm/O0PT41MQPKEpZ00RMMXf/q052hULooIaIXfgM9e+cgSDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769683742; c=relaxed/simple;
	bh=+qtb/t+0xDSDGfD5B5cb7Zpuf4UiYelnPEUWlU2u+Q4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HWlZRJ1MIkxnJb+6lXw8ax+VXhZnFYaTipGNIZ1w2Ef592xMWnYgdX/A0gLFUZ3Y2Aa2Q0480E+AEhAdd1y58rhdkHC5jZ6A3r2wIpstCLsVnwMOwDZ5AvL/CU06aS63cxirPsxTckLlsadaGOFlX2AhRfJ7VPYjs6ZyOnjOmT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W7CA5ZyS; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4806f3fc50bso8013075e9.0
        for <stable@vger.kernel.org>; Thu, 29 Jan 2026 02:49:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769683740; x=1770288540; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1MaVol00ZtirOaVD8s5awZQiRxb5rtZJQIGYIkDlUXM=;
        b=W7CA5ZySmjRyElUnAedrC3087HPUM27XISmN2l/F8Gfap9e3fOSpv9femYUmcFe/ig
         0k65o9WyVm1K/mpL6pYuQ2LvQ5j2Cx3eojZyUze61h+/E00DhzyHXjLe4IBtzjszrih1
         tG77Y/B34CjaUL5J0NlzuNhjiplzwL3Dbzz47PfhejpIFOovQl+y5vsCJUDCb9l0OIa2
         ICwaxVP+NdgiZWp26w59olrN3khZ85BNVhkr4mBGTMG+NzBwQkaKpijJ3sm8gOuqocT5
         PBYIKRA9Q11FdbmOq/HqIjiNLQNtfKUyApkrFnAfkdyB37dxGSGRpoHcFfhYBQl9QPd1
         PtNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769683740; x=1770288540;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1MaVol00ZtirOaVD8s5awZQiRxb5rtZJQIGYIkDlUXM=;
        b=YY2ZjMoUmmmFtG5hra//M/guDWEplnT56WSa5DGcBjolGS9t/WMNZM6vCak7zaaIWF
         GE+NG6KDCIipBdkSwXAwYrDMvuauZlfdvnlOgVHBzLNlz/7udgF45f552Bcc/SyTr91j
         8uORR7WTEBwECAUaJBLoWgnqFoIvmj8OXN4irRqDBk1IFBCgbHwV2v+lWirRoRzYf6l5
         aRbsVY5rprG92JxPbf1wBZ8JO0znExqX7Hk4QkwIUbJLKY9yT3w20fsh2I90BHJW+ZUr
         szh9tmoiXWvdWlrx3x3txvb8254qRKmoJGKpvb3gJL00mgatrfpVZrLp5pOGeNLL+l68
         iWhw==
X-Forwarded-Encrypted: i=1; AJvYcCWCmia1W8Ci+oQqRV1+c4c/oIzndY/StMqQTe50mj6sH4zLTRpZXcPgnqG4ORVvH24gM8Oc6N8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4GYW7mGF1J0d1HApYEJjMtftbi1UM3zTx4Mc4omKzF2rAKzYI
	j3IPmq1000tHeAHIsHszftW4TtjpV3KvKHK+FAAt9kG1mDPQEqpAYbE0
X-Gm-Gg: AZuq6aKG+NOpEPufUGi/AHPgg85efDZ33Z4xjcFp6qPg+jDsTYLkmi0iNssTQ8xS21Z
	8Z8UEtnwCuj2OUVuGBvSMeHve+HI1YGiuekhb8l6SeFYg6WOjIlRqnsPGkaov2GxUykXzbhkFiD
	+6kwKQ8/yFxyidek8UTwA7XK4Goy4hmD+l9der5Gl99R6rXDt+6Trt+mKFCJkcc7Wh3fFuQwlND
	h5K1xk0i7AeZUDBk/oBTbf1mrwuZo9Ee3Di+mm/0q9XiUEH5QQVr1wswHBCbLYVzpxRaP1XO7am
	pKw/13UG6FVg+oEp8Zn1MJZ3FCQAb+Ta+uBbjxXW4AjZ0Mx+XFenMTv5uS8ppKcPhbF//SGxQqi
	/HbIv+TFM+oFNNebV29TMUkV1Tscf+4+KOGSTW0e4vhbfmBlMZDg5zuPqlDJXYk6qOLOAhpP0uQ
	h/5/GrjoK/uMDu/Os8IQoDLWiwgS+YAcKykWRxYij47oPTADJchpwpGCUT8b0sOYY6dvTTmkego
	Tv2IU/Ys17J0NfLJY2e9QOVkSZYug==
X-Received: by 2002:a05:600c:83ca:b0:477:b734:8c53 with SMTP id 5b1f17b1804b1-48069c1a96emr105858205e9.12.1769683739413;
        Thu, 29 Jan 2026 02:48:59 -0800 (PST)
Received: from emanuele-nb.corp.toradex.com (248.201.173.83.static.wline.lns.sme.cust.swisscom.ch. [83.173.201.248])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435e10ed952sm13365525f8f.10.2026.01.29.02.48.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jan 2026 02:48:58 -0800 (PST)
From: Emanuele Ghidoli <ghidoliemanuele@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>
Cc: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v1] arm64: dts: freescale: imx95-toradex-smarc: fix PMIC_SD2_VSEL label position
Date: Thu, 29 Jan 2026 11:47:35 +0100
Message-ID: <20260129104741.888670-1-ghidoliemanuele@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-212764-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_TO(0.00)[kernel.org,nxp.com,pengutronix.de,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ghidoliemanuele@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable,dt];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,toradex.com:email]
X-Rspamd-Queue-Id: 7A26AAF168
X-Rspamd-Action: no action

From: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>

Fix the PMIC_SD2_VSEL gpio-line-name position. It should be on line 19
of gpio3, not line 20.

Fixes: 90bbe88e0ea6 ("arm64: dts: freescale: add Toradex SMARC iMX95")
Cc: stable@vger.kernel.org
Signed-off-by: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
---
 arch/arm64/boot/dts/freescale/imx95-toradex-smarc.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx95-toradex-smarc.dtsi b/arch/arm64/boot/dts/freescale/imx95-toradex-smarc.dtsi
index 5932ba238a8a..f64c05dc50f8 100644
--- a/arch/arm64/boot/dts/freescale/imx95-toradex-smarc.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx95-toradex-smarc.dtsi
@@ -262,7 +262,6 @@ &gpio3 {
 			  "",
 			  "",
 			  "",
-			  "",
 			  "PMIC_SD2_VSEL";
 	status = "okay";
 };
-- 
2.43.0


