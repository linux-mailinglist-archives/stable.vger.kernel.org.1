Return-Path: <stable+bounces-217644-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oMZZNUv2mWltXgMAu9opvQ
	(envelope-from <stable+bounces-217644-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 21 Feb 2026 19:15:39 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 84E6D16D761
	for <lists+stable@lfdr.de>; Sat, 21 Feb 2026 19:15:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E438E3042B50
	for <lists+stable@lfdr.de>; Sat, 21 Feb 2026 18:15:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 909992E2DF3;
	Sat, 21 Feb 2026 18:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=puri.sm header.i=@puri.sm header.b="IZydHVLh"
X-Original-To: stable@vger.kernel.org
Received: from ms.puri.sm (ms.puri.sm [135.181.196.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD2441534EC;
	Sat, 21 Feb 2026 18:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=135.181.196.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771697733; cv=none; b=OCZEyVeAPMv16SITR6ZOHx1ZLwKVckf7twTV4H/foAIh2VyFo1bV8RZypEJkUsE6E/nlDxfKjGkwKAJbWcpAVG+2hvoCzhzg1vRwQRZyJ0O7168iMwcILf6E66f7WUr4xD2X/+jjFHB438iXNSnX+c5nOMaO89wm9rgPV2VoJ4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771697733; c=relaxed/simple;
	bh=jtCfrr13o4B/392SWdb5ghKU04pq1d/ZsNEtXEu0AAQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=O7Hlp0jP0y+am8XN3yzl+p62BnuG3MuLFems09+CIf/bu1jC2VwxNtITW56/MC42SHQbN72TfVxpiyy8XhFTgI2V5LqzO15SuAHoXsbys76MGKbvaGNzbBk213E7BmrU8YuMESHthbpN3TPqNLadFjhOM8PlemEgHHN2nfhg/MM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=puri.sm; spf=pass smtp.mailfrom=puri.sm; dkim=pass (2048-bit key) header.d=puri.sm header.i=@puri.sm header.b=IZydHVLh; arc=none smtp.client-ip=135.181.196.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=puri.sm
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=puri.sm
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=puri.sm; s=smtp2;
	t=1771697730; bh=jtCfrr13o4B/392SWdb5ghKU04pq1d/ZsNEtXEu0AAQ=;
	h=From:Subject:Date:To:Cc;
	b=IZydHVLhRFVP2zi9KCfvZVBmBfo/FfJt5BgfxLWRthoK7kQHO46NLrn2OLF46jpjO
	 DjUpkZWDwbHD3Dp2YwJ8jxLkTUXgiq5exdxqxl17LJk1TOImxpy6u+tdKPwOjC0mFW
	 mXXDy/i5SwSNfCr173N1CO7Sa5sxKpQ/1c+PMeBUp68mycPADBxyjYL6dkLeCEYrWe
	 2oTjFuKaFLtk9auEkDK/ZJ1Vu/6ShmkU1CcLsvgu/Aq8tAVAgYoEDkr/k6bTQxL8k5
	 mZ/4WNfGWOd/Dp+MYY+Tl/a0PcmM0Ba8hL1e0YbY9rBzu3KcXi53UbqCQ7plvRj49d
	 5k/70D1cDerPg==
Received: from pliszka.localdomain (79.184.40.11.ipv4.supernova.orange.pl [79.184.40.11])
	by ms.puri.sm (Postfix) with ESMTPSA id 475311F511;
	Sat, 21 Feb 2026 10:15:28 -0800 (PST)
From: Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>
Subject: [PATCH v2 0/2] arm64: dts: imx8mq-librem5: PMIC voltage changes
Date: Sat, 21 Feb 2026 19:15:17 +0100
Message-Id: <20260221-l5-voltages-v2-0-dd8885bb9331@puri.sm>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/22NQQ6CMBBFr2K6dpQ2CMSV9zAshnaASaCQDjQaw
 t0trF2+5P/3NiUUmEQ9L5sKFFl48gnM9aJsj74jYJdYmcwUmTEahgfEaViwI4GW8rJwuW1Jlyo
 95kAtf07bu07coBA0Ab3tD8fAfpX7iLJQOOY9yzKF79mO+jj9z0QNGTjEComcrQr7mtfANxlVv
 e/7D2z9HcvDAAAA
X-Change-ID: 20260221-l5-voltages-fe476d4cfe17
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=890;
 i=sebastian.krzyszkowiak@puri.sm; h=from:subject:message-id;
 bh=jtCfrr13o4B/392SWdb5ghKU04pq1d/ZsNEtXEu0AAQ=;
 b=owEBbQKS/ZANAwAKAejyNc8728P/AcsmYgBpmfY/8yEmf5Wf0qh+LHo4HeWrFbUViB3Jovo3V
 OiUzjmeJ++JAjMEAAEKAB0WIQQi3Z+uAGoRQ1g2YXzo8jXPO9vD/wUCaZn2PwAKCRDo8jXPO9vD
 /yXtEADAkK6+RnxOxYe9hmOYcuw0c+HNRmhZTY7Yv90YDSS/26q0J04W5k3V24OJVjnVm2VUKD8
 1j0rKLVfvKTcPX2uocgGFQ+4aFzkqb5NH+IeOzj1ovUXcpw1dx77gGP9yaTWo2o26vsQ/T2mRfx
 qhwsh3iRHmg2gyae2YuPZ0syU7kQm1++o8xGWgPvtxGh5/XboQzV/lJlWfRbRHzGX9USh2Wlckt
 RJWVd0AoDA08nZScxzA7ce7qqXSV0hc8Qwe8LIz2eZdYitRh5TVOAbeMhl+NDYjo/wsVOcZzwXj
 1dn2cY33kUMIUAqGvRKtxcMYos/kap/+A/OZBvcBhrfkcXPhBLEAEiKJHLUKAzYDYdQzCZGBQyd
 MgNn5r11uTVxYNdh3bzRzFZjXv+OiKeh4+4k7IxWjHKiRwyzc0Ar9RREcZsuOx8JKmSwjhYpgVv
 zAfJ1QzU5xACJw611D21LnLYlhnh1TYpU+R86Xcdq+Y2LSt/vX578m7UdtCdh+DzGWk9f5jhqRv
 L/YsDk74xVh6OkVVHRPHRH6RFBIn4KolkED26ryC8tblOuFSpudH6GLUop8MPYg8679hO3n6kje
 c2WuIoBLxDUJfcuxXOYpFgK3MpLDkE6UiAyAcaJRWe/zpLD5NqwPe1DLIT4/N689Ij/b8kw/RNv
 1QxqaTOIrZb+hrQ==
X-Developer-Key: i=sebastian.krzyszkowiak@puri.sm; a=openpgp;
 fpr=22DD9FAE006A11435836617CE8F235CF3BDBC3FF
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[puri.sm,reject];
	R_DKIM_ALLOW(-0.20)[puri.sm:s=smtp2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-217644-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[puri.sm:mid,puri.sm:dkim,puri.sm:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 84E6D16D761
X-Rspamd-Action: no action

Simple changes to bump the voltages up to their nominal values to ensure
stable operation across all units.

Signed-off-by: Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>
---
Changes in v2:
- added Fixes and Cc: stable tags
- Link to v1: https://lore.kernel.org/r/20260221-l5-voltages-v1-0-daa8aeedc86c@puri.sm

---
Sebastian Krzyszkowiak (2):
      Revert "arm64: dts: imx8mq-librem5: Set the DVS voltages lower"
      arm64: dts: imx8mq-librem5: Bump BUCK1 suspend voltage up to 0.85V

 .../arm64/boot/dts/freescale/imx8mq-librem5-r3.dts |  2 +-
 arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi  | 24 +++++++---------------
 2 files changed, 8 insertions(+), 18 deletions(-)
---
base-commit: d79526b89571ae447c1a5cfd3d627efa07098348
change-id: 20260221-l5-voltages-fe476d4cfe17

Best regards,
-- 
Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>


