Return-Path: <stable+bounces-224526-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QE59F/dRsGmBiAIAu9opvQ
	(envelope-from <stable+bounces-224526-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 18:16:39 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F3F402555A5
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 18:16:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C8D5B3020220
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 17:16:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45AAB3BFE5D;
	Tue, 10 Mar 2026 17:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fris.de header.i=@fris.de header.b="jPFQbXvU"
X-Original-To: stable@vger.kernel.org
Received: from mail.fris.de (mail.fris.de [116.203.77.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB73B2E1EF4;
	Tue, 10 Mar 2026 17:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.77.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773162996; cv=none; b=i/fnxvjPCP9/tjahTz33lUUw+dR2PaM6AcqPPR3fYx46bK5rC+M6aYiD+huRlYZ5qg8xaIzgjyM5c6CIdIOBo7g4LDP1B7NvoZq4l+rtW4ZoXxlxEbcbuxWAeBmeLahXiiQgpjlDVkxfuHl4mkhh0DxprYjHl7w0e6+7r8euTEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773162996; c=relaxed/simple;
	bh=cUsXdhUWC9WAt4pU1xHzAuAXvkPMcuwHkpVO895O2Gc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uvOJmzPy7PgVkg8s6/bAhNh/jtB45016LTMwf3C4l7iznp1Cv2D3f199rRtzQuyw2goAs+dcGiyGGmYhUCtpvThchpQdfpFBNEm9QUYFp+TMGphAOL5Yi0OXWR7OLUVy0TCCl8kgQWMWz0tj7xCN/CdSuqfiQXRRG6FV9kwfWTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fris.de; spf=pass smtp.mailfrom=fris.de; dkim=pass (2048-bit key) header.d=fris.de header.i=@fris.de header.b=jPFQbXvU; arc=none smtp.client-ip=116.203.77.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fris.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fris.de
From: Frieder Schrempf <frieder@fris.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fris.de; s=mail;
	t=1773162984;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=YN9NqA2BdcEm2/4Kq3U8fwrpU71hC9cRhN8LE4Av7CM=;
	b=jPFQbXvURFqgN14i6nwVPxl0suSxd7mbCuRxCnx5ZupezKQcOprLAjCLx/O1QNbJi0M6ui
	LPegkccitFg8w40D2oqwH0PhHhGIGaqfB9LmGDYA3iOk7zeUKilw1XHjQTt/8xdGG7PwKL
	f4QtZnpxNLiQ8dw8voEF1CRAFCInTpP+ep8bQ5H8aV8Bqv3iNwa0FxdwhfW+UYta5GE+s4
	qQSulJn5HF4jLGxCzwQMJMonCWQj8j63+m5lgcO37hgf+aXwyOQVf7kJ/+Dm/8FeRbpA+6
	X9KIvd8TmiWuE1ahrmgX5OJcujlUG2uX1O14wDS6QMweS6eKCeCzE3CFTz39nQ==
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mtd@lists.infradead.org,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>
Cc: Daniel Golle <daniel@makrotopia.org>,
	Dhruva Gole <d-gole@ti.com>,
	Frieder Schrempf <frieder.schrempf@kontron.de>
Subject: [PATCH 6.1.y] mtd: spinand: macronix: use scratch buffer for DMA operation
Date: Tue, 10 Mar 2026 18:15:44 +0100
Message-ID: <20260310171544.1568499-1-frieder@fris.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: F3F402555A5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[fris.de,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	R_DKIM_ALLOW(-0.20)[fris.de:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-224526-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[fris.de:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[frieder@fris.de,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,ti.com:email,makrotopia.org:email,kontron.de:email]
X-Rspamd-Action: no action

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
---
This backport fixes the following error in 6.1:

[  102.320032] WARNING: CPU: 0 PID: 537 at drivers/spi/spi-mem.c:216 spi_mem_check_op+0x15c/0x168
[  102.328775] Modules linked in: bluetooth rfkill ipv6 snd_soc_fsl_asrc
[  102.335289] CPU: 0 PID: 537 Comm: nandtest Not tainted 6.1.158-ktn #1
[  102.341745] Hardware name: Freescale i.MX6 Ultralite (Device Tree)
[  102.347943]  unwind_backtrace from show_stack+0x10/0x14
[  102.353203]  show_stack from dump_stack_lvl+0x24/0x2c
[  102.358280]  dump_stack_lvl from __warn+0x74/0x120
[  102.363092]  __warn from warn_slowpath_fmt+0x178/0x188
[  102.368250]  warn_slowpath_fmt from spi_mem_check_op+0x15c/0x168
[  102.374286]  spi_mem_check_op from spi_mem_exec_op+0x3c/0x3e0
[  102.380063]  spi_mem_exec_op from mx35lf1ge4ab_ecc_get_status+0x9c/0xf8
[  102.386712]  mx35lf1ge4ab_ecc_get_status from spinand_ondie_ecc_finish_io_req+0x38/0x9c
[  102.394748]  spinand_ondie_ecc_finish_io_req from spinand_mtd_read+0x184/0x350
[  102.401998]  spinand_mtd_read from mtd_read_oob+0x98/0x160
[  102.407517]  mtd_read_oob from mtd_read+0x5c/0x80
[  102.412247]  mtd_read from mtdchar_read+0x108/0x2bc
[  102.417158]  mtdchar_read from vfs_read+0x98/0x24c
[  102.421977]  vfs_read from sys_pread64+0x8c/0xb8
[  102.426613]  sys_pread64 from ret_fast_syscall+0x0/0x54
[  102.431858] Exception stack(0xe0ce1fa8 to 0xe0ce1ff0)
[  102.436922] 1fa0:                   00200000 00000000 00000003 b6e1f008 00040000 00000000
[  102.445110] 1fc0: 00200000 00000000 00000001 000000b4 b6ff3220 b6e1f008 b6e1f008 b6ddf008
[  102.453294] 1fe0: 000000b4 be925b38 b6f3d611 b6ec1b26
[  102.458414] ---[ end trace 0000000000000000 ]---
---
 drivers/mtd/nand/spi/macronix.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/spi/macronix.c b/drivers/mtd/nand/spi/macronix.c
index dce835132a1e2..722a9738ba370 100644
--- a/drivers/mtd/nand/spi/macronix.c
+++ b/drivers/mtd/nand/spi/macronix.c
@@ -83,9 +83,10 @@ static int mx35lf1ge4ab_ecc_get_status(struct spinand_device *spinand,
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
-- 
2.53.0


