Return-Path: <stable+bounces-229895-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kNIGNzl9wWknTgQAu9opvQ
	(envelope-from <stable+bounces-229895-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 18:49:45 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3714E2FA7A9
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 18:49:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 67E843123953
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 16:25:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2915A3B38A4;
	Mon, 23 Mar 2026 16:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZR76Blei"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E077939A7EF;
	Mon, 23 Mar 2026 16:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774283152; cv=none; b=Cf3DZ2r3/X33SiMCplHxiQk0LyLZUpzekO7JWKY29d5R9JwAK8Blw4ULU+7pafTKs6CE3gxRAaEBVQmhIsFnzvgIB2odkeYh4hCju9yzG1NH7BwS8ir3oUZ8NxjF7ZBP29tXBnaIcEfmKF3SFr5r0GHwNe63g6VN+Qdepv872P4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774283152; c=relaxed/simple;
	bh=kDdtEcrMwI7YQlV2ApdSXHbGn01Ob/qMvNhgqWpQfVs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H3I1Ilm6hsl3anOVzNJOTzP6BpFk+FTROEjqiT59nU2KgRlL6sM5Rb42/D7ynSD9mXs4dyCFdlZUHPT7JUHak4//AXdi/yxtko6oW5RjJiMcrsyTNPHjmmWx0fIoacYTDkaTd6yb93FMjiwXJYs731Us6NwJbAYMFo9p27W1FZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZR76Blei; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79248C4CEF7;
	Mon, 23 Mar 2026 16:25:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774283151;
	bh=kDdtEcrMwI7YQlV2ApdSXHbGn01Ob/qMvNhgqWpQfVs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZR76Blei+McNfcOoLliu8DEEhdxAiF3YJDfn/RhnI0lZSsWiclzPgkH6dfwKUyKrS
	 ftf0PtV6f+TBPAY3bpyw7gfmJbRnc/PT8HOiYgi2Pp8dY/n2wCmwZsQOzORgIgSryr
	 O3D6Eed8J2Smr9+eI83gUPNmyQAcIj5hwVTzZ+H0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Daniel Golle <daniel@makrotopia.org>,
	Dhruva Gole <d-gole@ti.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Frieder Schrempf <frieder.schrempf@kontron.de>
Subject: [PATCH 6.1 377/481] mtd: spinand: macronix: use scratch buffer for DMA operation
Date: Mon, 23 Mar 2026 14:45:59 +0100
Message-ID: <20260323134534.321383265@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323134525.256603107@linuxfoundation.org>
References: <20260323134525.256603107@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-229895-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,makrotopia.org:email]
X-Rspamd-Queue-Id: 3714E2FA7A9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Daniel Golle <daniel@makrotopia.org>

[ Upstream commit ebed787a0becb9354f0a23620a5130cccd6c730c ]

The mx35lf1ge4ab_get_eccsr() function uses an SPI DMA operation to
read the eccsr, hence the buffer should not be on stack. Since commit
380583227c0c7f ("spi: spi-mem: Add extra sanity checks on the op param")
the kernel emmits a warning and blocks such operations.

Use the scratch buffer to get eccsr instead of trying to directly read
into a stack-allocated variable.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
Reviewed-by: Dhruva Gole <d-gole@ti.com>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Link: https://lore.kernel.org/linux-mtd/Y8i85zM0u4XdM46z@makrotopia.org
Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/mtd/nand/spi/macronix.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/mtd/nand/spi/macronix.c
+++ b/drivers/mtd/nand/spi/macronix.c
@@ -83,9 +83,10 @@ static int mx35lf1ge4ab_ecc_get_status(s
 		 * in order to avoid forcing the wear-leveling layer to move
 		 * data around if it's not necessary.
 		 */
-		if (mx35lf1ge4ab_get_eccsr(spinand, &eccsr))
+		if (mx35lf1ge4ab_get_eccsr(spinand, spinand->scratchbuf))
 			return nanddev_get_ecc_conf(nand)->strength;
 
+		eccsr = *spinand->scratchbuf;
 		if (WARN_ON(eccsr > nanddev_get_ecc_conf(nand)->strength ||
 			    !eccsr))
 			return nanddev_get_ecc_conf(nand)->strength;



