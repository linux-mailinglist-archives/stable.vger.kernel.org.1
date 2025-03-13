Return-Path: <stable+bounces-124312-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AABC1A5F631
	for <lists+stable@lfdr.de>; Thu, 13 Mar 2025 14:43:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7754317F520
	for <lists+stable@lfdr.de>; Thu, 13 Mar 2025 13:42:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FAC2267F63;
	Thu, 13 Mar 2025 13:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="skO+OwXg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CDF9267B6A;
	Thu, 13 Mar 2025 13:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741873341; cv=none; b=WIT212Yl24uRs9tRiSpZA4nb9djjAO+HNCfGn49rpoeaD22CXrgyxqRuyEiq3MD0t8UD9bSUCkfhiGt0F2JzoPYc47OACkc6mnnUwva2wvPuakjfqe2L9kuJe7NrvoqNzTRlPtCj7ffD7fyxsEfSAc7MWO3CF+Q4Riffy9bgIMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741873341; c=relaxed/simple;
	bh=3AiveYwmJJ73loAjlvkNyDS2sGIDEQW22xhB8L9mhkQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KnmmOkYQlpsFGGmYF2ncVFofcQwu3ld6vrAQSg0lw2AEFbMAvPGXqzO3IiY7mJ0z0tTYM3stBSXrggMMznpM9sJD/MOMFyA7D7tOw5dBRp73E+rghwoY84/l0qU1ZRqLCmCkca6o4eugeMxBdsBe8yaA02dW+io/jr7CS0aifSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=skO+OwXg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAB4DC4CEEA;
	Thu, 13 Mar 2025 13:42:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741873340;
	bh=3AiveYwmJJ73loAjlvkNyDS2sGIDEQW22xhB8L9mhkQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=skO+OwXgAtRRYX42St8Xj5mwcSjnqgLLguLlynTHAjLqha3ttabqCEIkNZ6MD+IAF
	 Sr9j8RtgfhYEfuF8qNAdJ+DVe7vkw5rblikPLPbLFOmJ3NvzytMdWoyZ2Ua3+XmpQy
	 aFeOpMRAKQOJfWVpqaFEHeFcwlyYzCE901pRJFlHy4Z7yfWky4mssh37lUui2TsWbm
	 Lb+wssIPK44G8+rOX2cRkoHxrzvM/3heOiMYTy3wEOLLAAMu/oh7j/fo0CqqW9/DMw
	 ilJXJC6YWtEswwsTfbYcf7IApkQoganldGVOAXpmvT0DgtuN2mHpQx2QfniOHncSJx
	 jiCW8JJxFfkvA==
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
Subject: [PATCH net 13/13] net: dsa: mv88e6xxx: workaround RGMII transmit delay erratum for 6320 family
Date: Thu, 13 Mar 2025 14:41:46 +0100
Message-ID: <20250313134146.27087-14-kabel@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250313134146.27087-1-kabel@kernel.org>
References: <20250313134146.27087-1-kabel@kernel.org>
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
index 898aff46693b..6e7c9bbd9787 100644
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
@@ -5125,6 +5140,7 @@ static const struct mv88e6xxx_ops mv88e6290_ops = {
 
 static const struct mv88e6xxx_ops mv88e6320_ops = {
 	/* MV88E6XXX_FAMILY_6320 */
+	.setup_errata = mv88e6320_setup_errata,
 	.ieee_pri_map = mv88e6085_g1_ieee_pri_map,
 	.ip_pri_map = mv88e6085_g1_ip_pri_map,
 	.irl_init_all = mv88e6352_g2_irl_init_all,
@@ -5180,6 +5196,7 @@ static const struct mv88e6xxx_ops mv88e6320_ops = {
 
 static const struct mv88e6xxx_ops mv88e6321_ops = {
 	/* MV88E6XXX_FAMILY_6320 */
+	.setup_errata = mv88e6320_setup_errata,
 	.ieee_pri_map = mv88e6085_g1_ieee_pri_map,
 	.ip_pri_map = mv88e6085_g1_ip_pri_map,
 	.irl_init_all = mv88e6352_g2_irl_init_all,
-- 
2.48.1


