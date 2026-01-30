Return-Path: <stable+bounces-212854-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0GzmBMV7fGkONgIAu9opvQ
	(envelope-from <stable+bounces-212854-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 30 Jan 2026 10:37:09 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 669BAB8F7A
	for <lists+stable@lfdr.de>; Fri, 30 Jan 2026 10:37:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D7189300B071
	for <lists+stable@lfdr.de>; Fri, 30 Jan 2026 09:36:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55B643542F8;
	Fri, 30 Jan 2026 09:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=dannybaumann@web.de header.b="Ik9lNLJx"
X-Original-To: stable@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD45E24A069;
	Fri, 30 Jan 2026 09:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769765789; cv=none; b=eT10JYKHTntA3Em9JHDQYxQSOe8LwG0kkatApAcH1C/cJe3Cqa32q/LtgXj3H/tdfeyg1Dvq17W5Cubt/bX0vibYg/19IPyOc+VmLEUP2OSZX0g+NYV+TWLD6pGjKynlyuG6lCCC1eL/6Fxr492N1iV+4p61Db52xyV7iYILEbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769765789; c=relaxed/simple;
	bh=lLSyEwmFVtRHCKQ8jELaRipYlc/Wucrwy63TfX/w0Wo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NK3NWTl+whL0NHT6ynJk6rVlTU3j1pEbFqVv02oJnFdrJUaf3AVvGrcK6kYvz+muciuaxbLXSikQkOlEuqi6Jm7RbCPIHeMrEenYTK8dtgIYEtejZSTBNqGz4ruiwnJI3qObYZ4At5vXDUQQ1fxUFIq3z2N1afIT9c1d3dBqmCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=dannybaumann@web.de header.b=Ik9lNLJx; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1769765775; x=1770370575; i=dannybaumann@web.de;
	bh=auA2jkuJ2FrtKsTghN97H7aAOrc0KWQEM6dpYXsdwxU=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Ik9lNLJxq2o517YVEBh1ajslFs3eNmzODATLyJG6ZnYADo9B7iz7Olzm0TZNjBLU
	 a9UxNQDb9/9//uJkqlxs9YCj6CZkqzgXWebcFL0fQZUZRxO3LrKuWtO3pdWpV1hGy
	 GnCv7nEEPCh1IKmzVej2mHYvSU9DQ9uZMBn0qQXzfEnMp8b9tzZdQcfotaAg4KiHG
	 +EW0pZeiRFuuVmyWVdW5f66eYZQZYdcJbpjiLmqMybKOgHbPEc0u2/ZR74VLiKJij
	 2SGuq+Iz0AlyCOnGHUyoYQHqmksZPQ8/lfX0bCyxg4rC6QIsS1RvtySm0CY4Xysiy
	 S+QrhYVLlwGEagQ4Mg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from rechenknecht.fritz.box ([79.229.128.233]) by smtp.web.de
 (mrweb105 [213.165.67.124]) with ESMTPSA (Nemesis) id
 1N8n08-1vpcng40fe-00xBHk; Fri, 30 Jan 2026 10:36:15 +0100
From: Danny Baumann <dannybaumann@web.de>
To: devicetree@vger.kernel.org,
	linux-omap@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	aaro.koskinen@iki.fi,
	andreas@kemnade.info,
	khilman@baylibre.com,
	rogerq@kernel.org,
	tony@atomide.com
Cc: Danny Baumann <danny.baumann@legrand.com>,
	stable@vger.kernel.org
Subject: [PATCH] ARM: dts: ti/omap: dra7: Fix PCIe PHY divided clock generation
Date: Fri, 30 Jan 2026 10:35:50 +0100
Message-ID: <20260130093550.751250-1-dannybaumann@web.de>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:PDfIIdNGTGffgpGG4vkeR0AMCKXU6zK5BtU98EOcs5Y5vhx0gVp
 2YJCs0Y+gbNrbLcCTxODfoc5sWUcwcVjy+VIeXWAkJM1W/c7ady1flDa3/DGXTQRlGEN1nh
 def5OmUTeyeQFMUp70NoN/I+Ztd3SGjDLREGCvKqBTm8/CR/RxGD5NrF9r2QzgJpZ+tRS5s
 uDJwu+kfrq6Mw5UfpNLYA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:efoC8JVfYXI=;2Ns6iq2CzJQqdcsUlbqWBmjI/tD
 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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[web.de,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[web.de:s=s29768273];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-212854-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[web.de:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[web.de];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dannybaumann@web.de,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,4a00821c:email,legrand.com:email]
X-Rspamd-Queue-Id: 669BAB8F7A
X-Rspamd-Action: no action

From: Danny Baumann <danny.baumann@legrand.com>

Commit d0bdd8bb7f35a2b4434a3ef665f9cfc3aba886c7 ("ARM: dts: ti/omap:
dra7: fix redundant clock divider definition") removed the ti,dividers
property in favor of the ti,max-div property. That particular divider is
'backwards', though (0 =3D 'divide by 2', 1 =3D 'do not divide, see AM574x
TRM, table 3-846 on page 939), so the removal of that property inverted
the driver behavior.
Restore previous behavior by restoring the ti,dividers property and fix
the redundancy by removing the ti,max-div property instead.

Fixes: d0bdd8bb7f35 ("ARM: dts: ti/omap: dra7: fix redundant clock divider=
 definition")
Cc: Andreas Kemnade <andreas@kemnade.info>
Cc: Kevin Hilman <khilman@baylibre.com>
Cc: stable@vger.kernel.org # 6.13+
Signed-off-by: Danny Baumann <danny.baumann@legrand.com>
=2D--
 arch/arm/boot/dts/ti/omap/dra7xx-clocks.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/ti/omap/dra7xx-clocks.dtsi b/arch/arm/boot/=
dts/ti/omap/dra7xx-clocks.dtsi
index 0de16ee262cf..615a8fb47776 100644
=2D-- a/arch/arm/boot/dts/ti/omap/dra7xx-clocks.dtsi
+++ b/arch/arm/boot/dts/ti/omap/dra7xx-clocks.dtsi
@@ -1376,8 +1376,8 @@ optfclk_pciephy_div: clock-optfclk-pciephy-div-8@4a0=
0821c {
 		clocks =3D <&apll_pcie_ck>;
 		#clock-cells =3D <0>;
 		reg =3D <0x021c>;
+		ti,dividers =3D <2>, <1>;
 		ti,bit-shift =3D <8>;
-		ti,max-div =3D <2>;
 	};
=20
 	apll_pcie_clkvcoldo: clock-apll-pcie-clkvcoldo {
=2D-=20
2.52.0


