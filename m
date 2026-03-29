Return-Path: <stable+bounces-230922-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id H+S0Hw4pyWnTvQUAu9opvQ
	(envelope-from <stable+bounces-230922-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 29 Mar 2026 15:28:46 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E27233523CE
	for <lists+stable@lfdr.de>; Sun, 29 Mar 2026 15:28:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C13C0300AEFE
	for <lists+stable@lfdr.de>; Sun, 29 Mar 2026 13:28:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81768375F69;
	Sun, 29 Mar 2026 13:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cEheKmHF"
X-Original-To: Stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45A543644D3
	for <Stable@vger.kernel.org>; Sun, 29 Mar 2026 13:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774790923; cv=none; b=jmEXKdtoBabmRVUhXC/BsjrVJfUP3147j7OmNvHdEx2zZUZ5yyp7+jULu07gUaBlfXpILangyBTLISPiVyG6faWiqs0yrdrLV7S7pgZXNphSyTgArZ37EjToeNq0aioMYvOWVmxzmHGX/uNtcBn7fzYWeCR9RAAHMoZ1zMmTPIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774790923; c=relaxed/simple;
	bh=1UjdbtLHYTflq1hquI+GcD767xWrjc3IBpCJ+OrZv8M=;
	h=Subject:To:From:Date:Message-ID:MIME-Version:Content-Type; b=YFzC9WP2aHKwgJ1Ie8QrgpWXz0QaPnh7kihggfkfsUzkw/YvUdy8KgmgsKOb7umYit5CdouFw3nWpnXXog52wGAYZaKGOKwwCw+IEfpoJnaRS03XhaJab9WY127Kl2AGM5pVWZWx++HRpUdui5hnszujt1pOg5MkKjE0kE03qX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cEheKmHF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A205EC116C6;
	Sun, 29 Mar 2026 13:28:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774790923;
	bh=1UjdbtLHYTflq1hquI+GcD767xWrjc3IBpCJ+OrZv8M=;
	h=Subject:To:From:Date:From;
	b=cEheKmHFLGnbtTXNAQP6do8+MGP7kRANWRMqdQpCSTx/8ZUpOOhvNHzj9zl+b6Zat
	 U7jWlRhX/k4PCgzZ76AYF5VBymkoTCQxyC4zdsPFDDZ76KBTP91mY7H/U5SeHiKItJ
	 LdZNUnjzdVGPa6/JYBBwllqAgaz8Y1kyk9mR0B+M=
Subject: patch "iio: imu: bmi160: Remove potential undefined behavior in" added to char-misc-linus
To: jpoimboe@kernel.org,Jonathan.Cameron@huawei.com,Stable@vger.kernel.org,andriy.shevchenko@intel.com,arnd@arndb.de,nuno.sa@analog.com
From: <gregkh@linuxfoundation.org>
Date: Sun, 29 Mar 2026 15:28:13 +0200
Message-ID: <2026032913-national-disbelief-847f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-230922-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linuxfoundation.org:dkim,huawei.com:email,intel.com:email,analog.com:email,arndb.de:email]
X-Rspamd-Queue-Id: E27233523CE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


This is a note to let you know that I've just added the patch titled

    iio: imu: bmi160: Remove potential undefined behavior in

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-linus branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will hopefully also be merged in Linus's tree for the
next -rc kernel release.

If you have any questions about this process, please let me know.


From c05a87d9ec3bf8727a5d746ce855003c6f2f8bb4 Mon Sep 17 00:00:00 2001
From: Josh Poimboeuf <jpoimboe@kernel.org>
Date: Mon, 9 Mar 2026 20:45:45 -0700
Subject: iio: imu: bmi160: Remove potential undefined behavior in
 bmi160_config_pin()
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

If 'pin' is not one of its expected values, the value of
'int_out_ctrl_shift' is undefined.  With UBSAN enabled, this causes
Clang to generate undefined behavior, resulting in the following
warning:

  drivers/iio/imu/bmi160/bmi160_core.o: warning: objtool: bmi160_setup_irq() falls through to next function __cfi_bmi160_core_runtime_resume()

Prevent the UB and improve error handling by returning an error if 'pin'
has an unexpected value.

While at it, simplify the code a bit by moving the 'pin_name' assignment
to the first switch statement.

Fixes: 895bf81e6bbf ("iio:bmi160: add drdy interrupt support")
Reported-by: Arnd Bergmann <arnd@arndb.de>
Closes: https://lore.kernel.org/a426d669-58bb-4be1-9eaa-6f3d83109e2d@app.fastmail.com
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Reviewed-by: Nuno Sá <nuno.sa@analog.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/imu/bmi160/bmi160_core.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/imu/bmi160/bmi160_core.c b/drivers/iio/imu/bmi160/bmi160_core.c
index 5f47708b4c5d..4abb83b75e2e 100644
--- a/drivers/iio/imu/bmi160/bmi160_core.c
+++ b/drivers/iio/imu/bmi160/bmi160_core.c
@@ -573,12 +573,16 @@ static int bmi160_config_pin(struct regmap *regmap, enum bmi160_int_pin pin,
 		int_out_ctrl_shift = BMI160_INT1_OUT_CTRL_SHIFT;
 		int_latch_mask = BMI160_INT1_LATCH_MASK;
 		int_map_mask = BMI160_INT1_MAP_DRDY_EN;
+		pin_name = "INT1";
 		break;
 	case BMI160_PIN_INT2:
 		int_out_ctrl_shift = BMI160_INT2_OUT_CTRL_SHIFT;
 		int_latch_mask = BMI160_INT2_LATCH_MASK;
 		int_map_mask = BMI160_INT2_MAP_DRDY_EN;
+		pin_name = "INT2";
 		break;
+	default:
+		return -EINVAL;
 	}
 	int_out_ctrl_mask = BMI160_INT_OUT_CTRL_MASK << int_out_ctrl_shift;
 
@@ -612,17 +616,8 @@ static int bmi160_config_pin(struct regmap *regmap, enum bmi160_int_pin pin,
 	ret = bmi160_write_conf_reg(regmap, BMI160_REG_INT_MAP,
 				    int_map_mask, int_map_mask,
 				    write_usleep);
-	if (ret) {
-		switch (pin) {
-		case BMI160_PIN_INT1:
-			pin_name = "INT1";
-			break;
-		case BMI160_PIN_INT2:
-			pin_name = "INT2";
-			break;
-		}
+	if (ret)
 		dev_err(dev, "Failed to configure %s IRQ pin", pin_name);
-	}
 
 	return ret;
 }
-- 
2.53.0



