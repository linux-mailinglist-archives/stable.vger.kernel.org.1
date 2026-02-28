Return-Path: <stable+bounces-220460-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KE9RFNQ2o2nP+QQAu9opvQ
	(envelope-from <stable+bounces-220460-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:41:24 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 10DC71C6209
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:41:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 51B3C31101E7
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:31:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E4C2481246;
	Sat, 28 Feb 2026 17:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cZ/nYlR2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12A173BA259;
	Sat, 28 Feb 2026 17:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300348; cv=none; b=o0evWMKicRhq/VDJMVEEHTWVQWuTDAoJGWybyPFUYBZzzwC7xdNedMaoQCo3n14JbzoBvuBIdHQJR8zqlTnDnBZYmB+NXiq9hK02KsgHITLliErQxRqPtNF4Uqr4/U7orEtsn4i9gIytmTWKDbyhMWs4JPBSFLD8Ee0Kx1nsHOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300348; c=relaxed/simple;
	bh=m1ZSAN/ySeKCQCFbk2w7m2/15nYVBMXoKuwOBd1+OFU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iJd/HNiUJdIjFRKIEhGwor6AJ+hhSFv772MiFK6b/drYWyH717iC6cFsAhBG0n+MttjpWTirJfInf6M9WX3LCghvM9gdN3OhB1BtrwISptyuAP9vaGMnY3hYX8FSByRPSlZrsvmIf62nCZG4RAarkRofMU8pph9QSF9om3AonAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cZ/nYlR2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5627CC2BC9E;
	Sat, 28 Feb 2026 17:39:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300347;
	bh=m1ZSAN/ySeKCQCFbk2w7m2/15nYVBMXoKuwOBd1+OFU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cZ/nYlR2scG41iDDbCPlptAtPET6GsiZ8xCxMp97AXzADX1KD5yBrnc5jKBpjtKfT
	 i6/oGaIl++jo45flMQr8iZ4xw75fUaoUuR49sfD6iuvsFEeZwacIMfiQ6xRI/x0uO4
	 kTuU+z+ahYQ0RCDJniAHvEPmt5b7Y/6bW2Yjq9ySBaTj8RzvpFbq0IsphvUS52woxJ
	 nZil/fNR6xGlqAgQ4gXszge/ruM4Bn5QXd2s/sy+31f+NbLhsGJajO7RPVA5uJ1M0Y
	 mchSCUo2EjWtvmMWhD0h/FjazmYjcLGXkZuv1VW08sLkkv47kGIB0nKTgH60CTM2W9
	 on9ybHRw8oXfA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Markus Perkins <markus@notsyncing.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 381/844] misc: eeprom: Fix EWEN/EWDS/ERAL commands for 93xx56 and 93xx66
Date: Sat, 28 Feb 2026 12:24:54 -0500
Message-ID: <20260228173244.1509663-382-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-220460-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 10DC71C6209
X-Rspamd-Action: no action

From: Markus Perkins <markus@notsyncing.net>

[ Upstream commit b54c82d6cbfc76647ba558e8e3647eb2b0ba0e2b ]

commit 14374fbb3f06 ("misc: eeprom_93xx46: Add new 93c56 and 93c66
compatible strings") added support for 93xx56 and 93xx66 eeproms, but
didn't take into account that the write enable/disable + erase all
commands are hardcoded for the 6-bit address of the 93xx46.

This commit fixes the command word generation by increasing the number
of shifts as the address field grows, keeping the command intact.

Also, the check for 8-bit or 16-bit mode is no longer required as this
is already taken into account in the edev->addrlen field.

Signed-off-by: Markus Perkins <markus@notsyncing.net>
Link: https://patch.msgid.link/20251202104823.429869-3-markus@notsyncing.net
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/misc/eeprom/eeprom_93xx46.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/misc/eeprom/eeprom_93xx46.c b/drivers/misc/eeprom/eeprom_93xx46.c
index 9cae6f530679b..5230e910a1d11 100644
--- a/drivers/misc/eeprom/eeprom_93xx46.c
+++ b/drivers/misc/eeprom/eeprom_93xx46.c
@@ -45,6 +45,7 @@ struct eeprom_93xx46_platform_data {
 #define OP_START	0x4
 #define OP_WRITE	(OP_START | 0x1)
 #define OP_READ		(OP_START | 0x2)
+/* The following addresses are offset for the 1K EEPROM variant in 16-bit mode */
 #define ADDR_EWDS	0x00
 #define ADDR_ERAL	0x20
 #define ADDR_EWEN	0x30
@@ -191,10 +192,7 @@ static int eeprom_93xx46_ew(struct eeprom_93xx46_dev *edev, int is_on)
 	bits = edev->addrlen + 3;
 
 	cmd_addr = OP_START << edev->addrlen;
-	if (edev->pdata->flags & EE_ADDR8)
-		cmd_addr |= (is_on ? ADDR_EWEN : ADDR_EWDS) << 1;
-	else
-		cmd_addr |= (is_on ? ADDR_EWEN : ADDR_EWDS);
+	cmd_addr |= (is_on ? ADDR_EWEN : ADDR_EWDS) << (edev->addrlen - 6);
 
 	if (has_quirk_instruction_length(edev)) {
 		cmd_addr <<= 2;
@@ -328,10 +326,7 @@ static int eeprom_93xx46_eral(struct eeprom_93xx46_dev *edev)
 	bits = edev->addrlen + 3;
 
 	cmd_addr = OP_START << edev->addrlen;
-	if (edev->pdata->flags & EE_ADDR8)
-		cmd_addr |= ADDR_ERAL << 1;
-	else
-		cmd_addr |= ADDR_ERAL;
+	cmd_addr |= ADDR_ERAL << (edev->addrlen - 6);
 
 	if (has_quirk_instruction_length(edev)) {
 		cmd_addr <<= 2;
-- 
2.51.0


