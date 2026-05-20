Return-Path: <stable+bounces-249946-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wFa1JBrJDWr93AUAu9opvQ
	(envelope-from <stable+bounces-249946-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 16:45:46 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E0AAD58FF52
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 16:45:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7805D31E72BA
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 14:30:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8656F3ED3BE;
	Wed, 20 May 2026 14:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tecnico.ulisboa.pt header.i=@tecnico.ulisboa.pt header.b="ZFADVStW"
X-Original-To: stable@vger.kernel.org
Received: from smtp1.tecnico.ulisboa.pt (smtp1.tecnico.ulisboa.pt [193.136.128.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E11083E9C10;
	Wed, 20 May 2026 14:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.136.128.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779287377; cv=none; b=kFW12uBe9f5xJLE8LiXfvJMZzpJjjk/gl2PHoK8hGUEXxU4csNh9YuRUqb6cBcEFgOskI1ByCVH6HpBTiatcXRjgVCVmDxAXJQgkdGl6Ob0Xh8T+XX0i2L7VxplTeXnK+XqxtLU/6zM1vWv+Tg4GY/FBGBDkIqY06xBxLEP66yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779287377; c=relaxed/simple;
	bh=kPzxEInlDAqex3iUZUsXtzfOfrfcX4/V9td+dKGhApw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=eQlVjKSTUZ0DK/d/EaUfKpHWsEl2vdUqRI7sAtIkYNFaqsh8yjIymUCNVVntj844rodO9i5tWvJYCo18rA7VXNJXpZ3yuLrQzB+zFVvvMkROAbyBRT4z4H1OOkMNsB6y5BdZVZMmHsQAviXB3ef4otWL4mI5l/FoOAYdgar+Jtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tecnico.ulisboa.pt; spf=pass smtp.mailfrom=tecnico.ulisboa.pt; dkim=pass (2048-bit key) header.d=tecnico.ulisboa.pt header.i=@tecnico.ulisboa.pt header.b=ZFADVStW; arc=none smtp.client-ip=193.136.128.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tecnico.ulisboa.pt
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tecnico.ulisboa.pt
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp1.tecnico.ulisboa.pt (Postfix) with ESMTP id 466006000856;
	Wed, 20 May 2026 15:29:23 +0100 (WEST)
X-Virus-Scanned: by amavis-2.13.0 (20230106) (Debian) at tecnico.ulisboa.pt
Received: from smtp1.tecnico.ulisboa.pt ([127.0.0.1])
 by localhost (smtp1.tecnico.ulisboa.pt [127.0.0.1]) (amavis, port 10025)
 with LMTP id l2g1-B4W2H_l; Wed, 20 May 2026 15:29:21 +0100 (WEST)
Received: from mail1.tecnico.ulisboa.pt (mail1.ist.utl.pt [IPv6:2001:690:2100:1::b3dd:b9ac])
	by smtp1.tecnico.ulisboa.pt (Postfix) with ESMTPS id 2D1786003C15;
	Wed, 20 May 2026 15:29:21 +0100 (WEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tecnico.ulisboa.pt;
	s=mail2; t=1779287361;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=X+vv7pFphgH9oN7gbjgYJ5zgMLVmo8gr23RIoruceic=;
	b=ZFADVStW7tmQeoKTy9oqdEzcsENcb1+NuxuL9tDOqxGeA5qS21itZ91Yp/bllJsWh30yHy
	/j8OPGTIemidCJfDYwgB8uWheClA1IBhHW4JuXQU3oissZIDwzm4UaEc00WR6H8Js2uE4V
	4HbO7rSLgBZ8DO3wU8rtsmHLlEQIQFPo6NgVdzgojYHe31G6sFOIfzrmgGa+eC/MX4C1Zq
	E06UExZO6GvMkjeSk4+llTJzl32JJ3xWoU/XIwn2AKQ71CPcG4Uv7Arx/Ul+1pRtBnHEiM
	4WR/Xq1EqGGcddfVnA46KwsKuF72SYDZ0Vn95Gj2pZ2sWS5RmOxSFYtf2sN2qQ==
Received: from [192.168.1.138] (unknown [IPv6:2a04:cec2:a:9912:685c:7af9:be7c:958f])
	(Authenticated sender: ist187313)
	by mail1.tecnico.ulisboa.pt (Postfix) with ESMTPSA id 51071360085;
	Wed, 20 May 2026 15:29:20 +0100 (WEST)
From: Diogo Ivo <diogo.ivo@tecnico.ulisboa.pt>
Date: Wed, 20 May 2026 16:28:52 +0200
Subject: [PATCH] mfd: max77620: Avoid regmap mutex deadlock in power-off
 handler
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260520-max77620_poweroff-v1-1-9186a3bcbe9e@tecnico.ulisboa.pt>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMywqDMBBA0V+RWTcwju/+ikjxMdEp1EiiVhD/3
 ajLs7h3B8dW2ME72MHyKk7M6BG+AmiHeuxZSecNhJRiQqh+9ZZlKeFnMn+2RmuFOUdFTEUeJRp
 8N1nWst3PsnrslubL7XyN4DhO2ZZmTXUAAAA=
X-Change-ID: 20260520-max77620_poweroff-08e39429835f
To: Lee Jones <lee@kernel.org>, Dmitry Osipenko <digetx@gmail.com>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Diogo Ivo <diogo.ivo@tecnico.ulisboa.pt>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779287359; l=2320;
 i=diogo.ivo@tecnico.ulisboa.pt; s=20240529; h=from:subject:message-id;
 bh=kPzxEInlDAqex3iUZUsXtzfOfrfcX4/V9td+dKGhApw=;
 b=KboUS9zB3FhnXkuf14cyKjeORvD1pgOAXqOgalkTZSUvGoXfbwi6eTA6QL6F943ip3yQRD+4u
 MPJEPTgJ/aXAUr6maUBKZ0luYv2thFrxUd4n0rgIkeacDsx8bExg08H
X-Developer-Key: i=diogo.ivo@tecnico.ulisboa.pt; a=ed25519;
 pk=BRGXhMh1q5KDlZ9y2B8SodFFY8FGupal+NMtJPwRpUQ=
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[tecnico.ulisboa.pt,quarantine];
	R_DKIM_ALLOW(-0.20)[tecnico.ulisboa.pt:s=mail2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-249946-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,ulisboa.pt:email];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[tecnico.ulisboa.pt:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[diogo.ivo@tecnico.ulisboa.pt,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: E0AAD58FF52
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

max77620_pm_power_off() is called via the sys-off framework as a
SYS_OFF_MODE_POWER_OFF handler, which runs in an atomic notifier chain
with IRQs disabled after smp_send_stop(). regmap_update_bits() acquires
the regmap mutex in this path; if another CPU held that mutex when it
was stopped, the power-off sequence deadlocks.

Replace regmap_update_bits() with i2c_smbus_write_byte_data(), which
bypasses the regmap lock entirely. The I2C core detects the atomic
context via i2c_in_atomic_xfer_mode() and uses i2c_trylock_bus() rather
than a blocking acquisition, avoiding the deadlock.

Tested on Pixel C, powers off correctly.

Assisted-by: Claude:claude-sonnet-4-6
Fixes: 744b13107d0d ("mfd: max77620: Provide system power-off functionality")
Cc: stable@vger.kernel.org
Signed-off-by: Diogo Ivo <diogo.ivo@tecnico.ulisboa.pt>
---
This patch was tested on a local branch that sets pm_power_off =
max77620_pm_power_off() unconditionally so that the function runs.
I haven't checked whether the other bits in ONOFFCNFG1 are safe to
discard at power-off time as I don't have access to the datasheet.
If someone with access to the datasheet confirms they're not I'll
respin the patch taking that into account.
---
 drivers/mfd/max77620.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/mfd/max77620.c b/drivers/mfd/max77620.c
index 3af2974b3023..8c768968a317 100644
--- a/drivers/mfd/max77620.c
+++ b/drivers/mfd/max77620.c
@@ -487,10 +487,14 @@ static int max77620_read_es_version(struct max77620_chip *chip)
 static void max77620_pm_power_off(void)
 {
 	struct max77620_chip *chip = max77620_scratch;
+	struct i2c_client *client = to_i2c_client(chip->dev);
 
-	regmap_update_bits(chip->rmap, MAX77620_REG_ONOFFCNFG1,
-			   MAX77620_ONOFFCNFG1_SFT_RST,
-			   MAX77620_ONOFFCNFG1_SFT_RST);
+	/*
+	 * Atomic context: IRQs disabled. Use raw I2C write, bypassing
+	 * regmap locking entirely.
+	 */
+	i2c_smbus_write_byte_data(client, MAX77620_REG_ONOFFCNFG1,
+				  MAX77620_ONOFFCNFG1_SFT_RST);
 }
 
 static int max77620_probe(struct i2c_client *client)

---
base-commit: 27fa82620cbaa89a7fc11ac3057701d598813e87
change-id: 20260520-max77620_poweroff-08e39429835f

Best regards,
--  
Diogo Ivo <diogo.ivo@tecnico.ulisboa.pt>


