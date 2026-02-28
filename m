Return-Path: <stable+bounces-220252-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qNAYLfoyo2mV+QQAu9opvQ
	(envelope-from <stable+bounces-220252-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:24:58 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 097821C5C2A
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:24:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 12AB3319065D
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 17:59:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62100377001;
	Sat, 28 Feb 2026 17:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i5bK7Zvm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FCBD47CC9B;
	Sat, 28 Feb 2026 17:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300156; cv=none; b=S4OLXm8LKT4zntLCfC1t3xmsSzpwPTAooZoWpHDN2AYT7jk02XfAIXfkYCYnp3QxSsONH7nGN7AKhE1AlYnvLyGgU3sjo3RJjlLHI/Chc1kBxLdUOlWD4nU/I3vmaI6plbyvqa2gtD41l4nH0b8Z/bXuUqJUcf47feT3b3JN/oA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300156; c=relaxed/simple;
	bh=PnUWV+2waipA/3l6Zw0FE24BqUwqTNTQo97COvz2/04=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kxQ/faBJ9Doxj+QNZVLfRpUae1MvY28xOpD6W30ZqYsoQc7CppISH5e6BG5W6p4ZzTr0KkjyHxiwuO/Wzd+TNx0R/wDZPjJeC7bxqDyIaddjKSkcqEshV26GXa7lGKitrCcfQBNwu8hfzeZ/6MLfUsRSS5suLkoLKy7AoVC/boM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i5bK7Zvm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 460C2C19425;
	Sat, 28 Feb 2026 17:35:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300155;
	bh=PnUWV+2waipA/3l6Zw0FE24BqUwqTNTQo97COvz2/04=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=i5bK7Zvmh73xxX27WKRUAz/2lH97AYrjwA17hPRusO8deg3v07p1thM/lAwkABwig
	 Cb35WAEAqBu689RTpj/YD9qj5K1tH8WWg7+72A0AC5UKBd9GCTpnAltqoP4yrZr+4E
	 RrIMPoOn3pgq7aBQDidEEKH5TS3qRWbyfv81/+DWRSAWU8UktpuT7yaJS5jeYXAhtr
	 ovMbEpImpvJFfG9iTdNKoOO09FBxR812IYUjP9W9ZOd/tkZte+GPqIFfjWR0ZBjVlM
	 5WuPQTHTLroN9Gt1S1yGZxccUhI0b393+OS/ZwjDNcNdY4MVkR+N2LDntGNpris58o
	 Fj+KV477GAZQg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Miquel Raynal <miquel.raynal@bootlin.com>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 174/844] spi: spi-mem: Limit octal DTR constraints to octal DTR situations
Date: Sat, 28 Feb 2026 12:21:27 -0500
Message-ID: <20260228173244.1509663-175-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220252-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url,linaro.org:email,bootlin.com:email]
X-Rspamd-Queue-Id: 097821C5C2A
X-Rspamd-Action: no action

From: Miquel Raynal <miquel.raynal@bootlin.com>

[ Upstream commit 8618271887ca10ac5108fe7e1d82ba8f1b152cf9 ]

In this helper, any operation with a single DTR cycle (like 1S-1S-8D) is
considered requiring a duplicated command opcode. This is wrong as this
constraint only applies to octal DTR operations (8D-8D-8D).

Narrow the application of this constraint to the concerned bus
interface.

Note: none of the possible XD-XD-XD pattern, with X being one of {1, 2,
4} would benefit from this check either as there is only in octal DTR
mode that a single clock edge would be enough to transmit the full
opcode.

Make sure the constraint of expecting two bytes for the command is
applied to the relevant bus interface.

Reviewed-by: Tudor Ambarus <tudor.ambarus@linaro.org>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Link: https://patch.msgid.link/20260109-winbond-v6-17-rc1-oddr-v2-3-1fff6a2ddb80@bootlin.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-mem.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-mem.c b/drivers/spi/spi-mem.c
index c8b2add2640e5..6c7921469b90b 100644
--- a/drivers/spi/spi-mem.c
+++ b/drivers/spi/spi-mem.c
@@ -178,8 +178,19 @@ bool spi_mem_default_supports_op(struct spi_mem *mem,
 		if (op->data.swap16 && !spi_mem_controller_is_capable(ctlr, swap16))
 			return false;
 
-		if (op->cmd.nbytes != 2)
-			return false;
+		/* Extra 8D-8D-8D limitations */
+		if (op->cmd.dtr && op->cmd.buswidth == 8) {
+			if (op->cmd.nbytes != 2)
+				return false;
+
+			if ((op->addr.nbytes % 2) ||
+			    (op->dummy.nbytes % 2) ||
+			    (op->data.nbytes % 2)) {
+				dev_err(&ctlr->dev,
+					"Even byte numbers not allowed in octal DTR operations\n");
+				return false;
+			}
+		}
 	} else {
 		if (op->cmd.nbytes != 1)
 			return false;
-- 
2.51.0


