Return-Path: <stable+bounces-124729-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31102A65AE7
	for <lists+stable@lfdr.de>; Mon, 17 Mar 2025 18:35:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43D721726D5
	for <lists+stable@lfdr.de>; Mon, 17 Mar 2025 17:33:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A4C41C5F3F;
	Mon, 17 Mar 2025 17:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TNAyDWIr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA4AD1A2C0B;
	Mon, 17 Mar 2025 17:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742232791; cv=none; b=KmEPen63diUo23YbwaOXHVjjbAL7h5e85QnEgHMGmB8IW5Hpn35im9gHin/2UnBx/vEDsZZn9gZe5iKRkH1kTtHxNeSp1BmYtPxPVUNAaBnVe0ifb9u/f85lEJ4oR2Fd72OOCxr0gRHx4H604kW+uy9FFJ1Rh9abhds9BkXMaUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742232791; c=relaxed/simple;
	bh=A7r/Ot+sHsy8b4fRDlo5i7NL+lCmZuAEK2cuxuluGNw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Gf/ooPJtm32HQvC4msmYSvVEkHtfLNvCvG6hALymnyHkHQZ41qd4RcXKGaE8IJgnINVIcUXZPT8EHOBzigtXKfu98QucwHmgtKkbVJMHllSZJ15ewwdyxcbVgmfN4i1tHLBwxZBdh2/Zt6kIpDd1uIoUjF/p6cOfRt9wUjDrFI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TNAyDWIr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57D65C4CEE3;
	Mon, 17 Mar 2025 17:33:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742232791;
	bh=A7r/Ot+sHsy8b4fRDlo5i7NL+lCmZuAEK2cuxuluGNw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TNAyDWIrOyEij3Tm4qO0UYmTyVzbN5jGKWcfXolrsbGVF357HNN/i8TlJJJ424a4S
	 NrCA7PWYaLnU4wLYu/WGYBES7BF3KDt8xsdAg8XVZeJvOEqpTbPcBeoOL373QUsMde
	 LQchtZjttwsa3f3M0rPYewXXcefNL0jPCpv/KvlLDI6cx4csl9xg/CxKI7Qw4z7CG7
	 RcyvZobqOrh0eVHAaBNRDxJ5Px7hC346wKXkdrkUADfbtQ1d3PitAOoaYC2mqWoRdO
	 qGiIPupGo79MoBuoMiC09qpkv0S+WC+F4YpcYBk8J6Bf30/Ln3Iz0rqMEGVGVlThNU
	 QedBDziDtJQ/A==
From: =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Vivien Didelot <vivien.didelot@gmail.com>,
	Tobias Waldekranz <tobias@waldekranz.com>,
	netdev@vger.kernel.org
Cc: Lev Olshvang <lev_o@rad.com>,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH net v2 7/7] net: dsa: mv88e6xxx: workaround RGMII transmit delay erratum for 6320 family
Date: Mon, 17 Mar 2025 18:32:50 +0100
Message-ID: <20250317173250.28780-8-kabel@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250317173250.28780-1-kabel@kernel.org>
References: <20250317173250.28780-1-kabel@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Implement the workaround for erratum
  3.3 RGMII timing may be out of spec when transmit delay is enabled
for the 6320 family, which says:

  When transmit delay is enabled via Port register 1 bit 14 = 1, duty
  cycle may be out of spec. Under very rare conditions this may cause
  the attached device receive CRC errors.

Signed-off-by: Marek Behún <kabel@kernel.org>
Cc: <stable@vger.kernel.org> # 5.4.x
---
 drivers/net/dsa/mv88e6xxx/chip.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index 88f479dc328c..901929f96b38 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -3674,6 +3674,21 @@ static int mv88e6xxx_stats_setup(struct mv88e6xxx_chip *chip)
 	return mv88e6xxx_g1_stats_clear(chip);
 }
 
+static int mv88e6320_setup_errata(struct mv88e6xxx_chip *chip)
+{
+	u16 dummy;
+	int err;
+
+	/* Workaround for erratum
+	 *   3.3 RGMII timing may be out of spec when transmit delay is enabled
+	 */
+	err = mv88e6xxx_port_hidden_write(chip, 0, 0xf, 0x7, 0xe000);
+	if (err)
+		return err;
+
+	return mv88e6xxx_port_hidden_read(chip, 0, 0xf, 0x7, &dummy);
+}
+
 /* Check if the errata has already been applied. */
 static bool mv88e6390_setup_errata_applied(struct mv88e6xxx_chip *chip)
 {
@@ -5130,6 +5145,7 @@ static const struct mv88e6xxx_ops mv88e6290_ops = {
 
 static const struct mv88e6xxx_ops mv88e6320_ops = {
 	/* MV88E6XXX_FAMILY_6320 */
+	.setup_errata = mv88e6320_setup_errata,
 	.ieee_pri_map = mv88e6085_g1_ieee_pri_map,
 	.ip_pri_map = mv88e6085_g1_ip_pri_map,
 	.irl_init_all = mv88e6352_g2_irl_init_all,
@@ -5182,6 +5198,7 @@ static const struct mv88e6xxx_ops mv88e6320_ops = {
 
 static const struct mv88e6xxx_ops mv88e6321_ops = {
 	/* MV88E6XXX_FAMILY_6320 */
+	.setup_errata = mv88e6320_setup_errata,
 	.ieee_pri_map = mv88e6085_g1_ieee_pri_map,
 	.ip_pri_map = mv88e6085_g1_ip_pri_map,
 	.irl_init_all = mv88e6352_g2_irl_init_all,
-- 
2.48.1


