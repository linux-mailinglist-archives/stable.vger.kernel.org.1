Return-Path: <stable+bounces-49019-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B87128FEB83
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 16:25:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26134287441
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 14:25:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDA981AB52E;
	Thu,  6 Jun 2024 14:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NVc1r4/+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB5051AB52D;
	Thu,  6 Jun 2024 14:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717683260; cv=none; b=XZ9VJQv2CGgxgKAsAYqFWU77qrKaSdUx2dDQ9wL3+ode+g0mzC4hb/rmfbnQBgekeBJwI3TJVzF84ryk/Hl+fHrF5aSkmuUjWk8qLEWDXvTznhrqq/IATIRt8fQcZ3zDKPBh6zq558NpMRBGEoBOWPc1oIQDxGypimHf6V/R358=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717683260; c=relaxed/simple;
	bh=yLhbZn5Ol+Vp5FTb2H1GkGVA6PIJE6Tb6CLe00FdPX8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=meGVe1P+UvJni5GJuwEHY4BFvRj77H6nuOC4GqSArNmYkEoqH/cfI33ZfBdrLUMO5Zv4zPpUjQv+2htPLUUNPJXLR6s5Uo96R7wsbovsiCFvV4FTqkLf2aTfp6L53mp0lqclo5wFKcq6Pmn7oMnKwz/Kj+6kH1K+wo3JzLLMvdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NVc1r4/+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 849CDC2BD10;
	Thu,  6 Jun 2024 14:14:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1717683260;
	bh=yLhbZn5Ol+Vp5FTb2H1GkGVA6PIJE6Tb6CLe00FdPX8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NVc1r4/+FQusplu5r05XOqNa6v7wTVRytR74wwpt6+YyzARe5URvOOW5jpl0apC2b
	 T5VW+QszyELAKhY9BcRQ8bG8UqcK8tN/lbM9dSivtpmAXUFGEO5dVYumRRoyvXWINW
	 Qi6Ym0HcQRH6DrBPsjj3PsLVOG73+yk0pyuyalTU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
	Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 136/473] net: dsa: mv88e6xxx: Avoid EEPROM timeout without EEPROM on 88E6250-family switches
Date: Thu,  6 Jun 2024 16:01:05 +0200
Message-ID: <20240606131704.424267844@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240606131659.786180261@linuxfoundation.org>
References: <20240606131659.786180261@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>

[ Upstream commit e44894e2aa4eb311ceda134de8b6f51ff979211b ]

88E6250-family switches have the quirk that the EEPROM Running flag can
get stuck at 1 when no EEPROM is connected, causing
mv88e6xxx_g2_eeprom_wait() to time out. We still want to wait for the
EEPROM however, to avoid interrupting a transfer and leaving the EEPROM
in an invalid state.

The condition to wait for recommended by the hardware spec is the EEInt
flag, however this flag is cleared on read, so before the hardware reset,
is may have been cleared already even though the EEPROM has been read
successfully.

For this reason, we revive the mv88e6xxx_g1_wait_eeprom_done() function
that was removed in commit 6ccf50d4d474
("net: dsa: mv88e6xxx: Avoid EEPROM timeout when EEPROM is absent") in a
slightly refactored form, and introduce a new
mv88e6xxx_g1_wait_eeprom_done_prereset() that additionally handles this
case by triggering another EEPROM reload that can be waited on.

On other switch models without this quirk, mv88e6xxx_g2_eeprom_wait() is
kept, as it avoids the additional reload.

Fixes: 6ccf50d4d474 ("net: dsa: mv88e6xxx: Avoid EEPROM timeout when EEPROM is absent")
Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/dsa/mv88e6xxx/chip.c    |  4 +-
 drivers/net/dsa/mv88e6xxx/global1.c | 89 +++++++++++++++++++++++++++++
 drivers/net/dsa/mv88e6xxx/global1.h |  2 +
 3 files changed, 93 insertions(+), 2 deletions(-)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index b59cdc850a07a..dc4ff8a6d0bf5 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -5001,8 +5001,8 @@ static const struct mv88e6xxx_ops mv88e6250_ops = {
 	.watchdog_ops = &mv88e6250_watchdog_ops,
 	.mgmt_rsvd2cpu = mv88e6352_g2_mgmt_rsvd2cpu,
 	.pot_clear = mv88e6xxx_g2_pot_clear,
-	.hardware_reset_pre = mv88e6xxx_g2_eeprom_wait,
-	.hardware_reset_post = mv88e6xxx_g2_eeprom_wait,
+	.hardware_reset_pre = mv88e6250_g1_wait_eeprom_done_prereset,
+	.hardware_reset_post = mv88e6xxx_g1_wait_eeprom_done,
 	.reset = mv88e6250_g1_reset,
 	.vtu_getnext = mv88e6185_g1_vtu_getnext,
 	.vtu_loadpurge = mv88e6185_g1_vtu_loadpurge,
diff --git a/drivers/net/dsa/mv88e6xxx/global1.c b/drivers/net/dsa/mv88e6xxx/global1.c
index 964928285782c..83c6d1fab94ab 100644
--- a/drivers/net/dsa/mv88e6xxx/global1.c
+++ b/drivers/net/dsa/mv88e6xxx/global1.c
@@ -75,6 +75,95 @@ static int mv88e6xxx_g1_wait_init_ready(struct mv88e6xxx_chip *chip)
 	return mv88e6xxx_g1_wait_bit(chip, MV88E6XXX_G1_STS, bit, 1);
 }
 
+static int mv88e6250_g1_eeprom_reload(struct mv88e6xxx_chip *chip)
+{
+	/* MV88E6185_G1_CTL1_RELOAD_EEPROM is also valid for 88E6250 */
+	int bit = __bf_shf(MV88E6185_G1_CTL1_RELOAD_EEPROM);
+	u16 val;
+	int err;
+
+	err = mv88e6xxx_g1_read(chip, MV88E6XXX_G1_CTL1, &val);
+	if (err)
+		return err;
+
+	val |= MV88E6185_G1_CTL1_RELOAD_EEPROM;
+
+	err = mv88e6xxx_g1_write(chip, MV88E6XXX_G1_CTL1, val);
+	if (err)
+		return err;
+
+	return mv88e6xxx_g1_wait_bit(chip, MV88E6XXX_G1_CTL1, bit, 0);
+}
+
+/* Returns 0 when done, -EBUSY when waiting, other negative codes on error */
+static int mv88e6xxx_g1_is_eeprom_done(struct mv88e6xxx_chip *chip)
+{
+	u16 val;
+	int err;
+
+	err = mv88e6xxx_g1_read(chip, MV88E6XXX_G1_STS, &val);
+	if (err < 0) {
+		dev_err(chip->dev, "Error reading status");
+		return err;
+	}
+
+	/* If the switch is still resetting, it may not
+	 * respond on the bus, and so MDIO read returns
+	 * 0xffff. Differentiate between that, and waiting for
+	 * the EEPROM to be done by bit 0 being set.
+	 */
+	if (val == 0xffff || !(val & BIT(MV88E6XXX_G1_STS_IRQ_EEPROM_DONE)))
+		return -EBUSY;
+
+	return 0;
+}
+
+/* As the EEInt (EEPROM done) flag clears on read if the status register, this
+ * function must be called directly after a hard reset or EEPROM ReLoad request,
+ * or the done condition may have been missed
+ */
+int mv88e6xxx_g1_wait_eeprom_done(struct mv88e6xxx_chip *chip)
+{
+	const unsigned long timeout = jiffies + 1 * HZ;
+	int ret;
+
+	/* Wait up to 1 second for the switch to finish reading the
+	 * EEPROM.
+	 */
+	while (time_before(jiffies, timeout)) {
+		ret = mv88e6xxx_g1_is_eeprom_done(chip);
+		if (ret != -EBUSY)
+			return ret;
+	}
+
+	dev_err(chip->dev, "Timeout waiting for EEPROM done");
+	return -ETIMEDOUT;
+}
+
+int mv88e6250_g1_wait_eeprom_done_prereset(struct mv88e6xxx_chip *chip)
+{
+	int ret;
+
+	ret = mv88e6xxx_g1_is_eeprom_done(chip);
+	if (ret != -EBUSY)
+		return ret;
+
+	/* Pre-reset, we don't know the state of the switch - when
+	 * mv88e6xxx_g1_is_eeprom_done() returns -EBUSY, that may be because
+	 * the switch is actually busy reading the EEPROM, or because
+	 * MV88E6XXX_G1_STS_IRQ_EEPROM_DONE has been cleared by an unrelated
+	 * status register read already.
+	 *
+	 * To account for the latter case, trigger another EEPROM reload for
+	 * another chance at seeing the done flag.
+	 */
+	ret = mv88e6250_g1_eeprom_reload(chip);
+	if (ret)
+		return ret;
+
+	return mv88e6xxx_g1_wait_eeprom_done(chip);
+}
+
 /* Offset 0x01: Switch MAC Address Register Bytes 0 & 1
  * Offset 0x02: Switch MAC Address Register Bytes 2 & 3
  * Offset 0x03: Switch MAC Address Register Bytes 4 & 5
diff --git a/drivers/net/dsa/mv88e6xxx/global1.h b/drivers/net/dsa/mv88e6xxx/global1.h
index 04b57a21f7868..f3c0b8ab6461b 100644
--- a/drivers/net/dsa/mv88e6xxx/global1.h
+++ b/drivers/net/dsa/mv88e6xxx/global1.h
@@ -281,6 +281,8 @@ int mv88e6xxx_g1_set_switch_mac(struct mv88e6xxx_chip *chip, u8 *addr);
 int mv88e6185_g1_reset(struct mv88e6xxx_chip *chip);
 int mv88e6352_g1_reset(struct mv88e6xxx_chip *chip);
 int mv88e6250_g1_reset(struct mv88e6xxx_chip *chip);
+int mv88e6xxx_g1_wait_eeprom_done(struct mv88e6xxx_chip *chip);
+int mv88e6250_g1_wait_eeprom_done_prereset(struct mv88e6xxx_chip *chip);
 
 int mv88e6185_g1_ppu_enable(struct mv88e6xxx_chip *chip);
 int mv88e6185_g1_ppu_disable(struct mv88e6xxx_chip *chip);
-- 
2.43.0




