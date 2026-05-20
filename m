Return-Path: <stable+bounces-251669-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SED3L1b3DWpd5AUAu9opvQ
	(envelope-from <stable+bounces-251669-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:03:02 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 656455952C9
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:03:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4E92A30B1899
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 17:36:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBA173C870E;
	Wed, 20 May 2026 17:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qOICoF8b"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59FF029D26E;
	Wed, 20 May 2026 17:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779298584; cv=none; b=n1UgV8UoAVhGZvHTo20YeLIjhXuRKD4PwYHcrrKCRp393KNZTKOTVdKceMR3UAb24NA9fwpwgmi8IIkOpI31bVjEVpjJ3QhXt/RXUtLa6PTBuMIGAnwICUD0txR8zAJgR74i5BZtYlyPiBRrTCvyGYNq8Bw5qmKcM5Vcx0tN5mU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779298584; c=relaxed/simple;
	bh=sX7npLsVxXRGKWIp+JVM0DtoxCUGMzotxIQU7c76OoM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UUjDXdCT3QNiuh8eygJYwOjvWtBobkymvEN+kpbF/bXf3KjKDaUOhQPwwbP6lDC0NydYBZYSoCV56i4Ted0ahAwT/9YyLNTZxuBB8bOkWKEjic4/zlqxxDGq+CLHDbfBhP+v6Cx1/lLbeo1M1uhWG5eYgO5QbqM/noIP9FCiZWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qOICoF8b; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA0951F00898;
	Wed, 20 May 2026 17:36:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779298583;
	bh=z+vg3EUd0rtflOTkOeQDZ7ohdqAqjM/FmBIqCYJW4uw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=qOICoF8bgCiajYXwOIAhBsBQeHbxTm1GQjciWDEUMKh8gvDfBvpPFhPPRxMQdhJqX
	 cIvIdmZo4YpftyKAYZE+zn7Pla9IA5XXvwMl+f2wNdphGpkOUp+y0CzMAWfEqjiqWF
	 4afKxT1Myr4357ZbTimdgJ8N0g4uhgp3SCPo/j7g=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Takahiro Kuwano <Takahiro.Kuwano@infineon.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH 6.18 466/957] mtd: spi-nor: sfdp: introduce smpt_read_dummy fixup hook
Date: Wed, 20 May 2026 18:15:49 +0200
Message-ID: <20260520162144.629487572@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162134.554764788@linuxfoundation.org>
References: <20260520162134.554764788@linuxfoundation.org>
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
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-251669-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,renesas];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,linuxfoundation.org:mid,linuxfoundation.org:dkim,mailbox.org:email,infineon.com:email]
X-Rspamd-Queue-Id: 656455952C9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>

[ Upstream commit 653f6def567c81f37302f9591ffd54df3e2a11eb ]

SMPT contains config detection info that describes opcode, address, and
dummy cycles to read sector map config. The dummy cycles parameter can
be SMPT_CMD_READ_DUMMY_IS_VARIABLE and in that case nor->read_dummy
(initialized as 0) is used. In Infineon flash chips, Read Any Register
command with variable dummy cycle is defined in SMPT. S25Hx/S28Hx flash
has 0 dummy cycle by default to read volatile regiters and
nor->read_dummy can work. S25FS-S flash has 8 dummy cycles so we need a
hook that can fix dummy cycles with actually used value.

Inroduce smpt_read_dummy() in struct spi_nor_fixups. It is called when
the dummy cycle field in SMPT config detection is 'varialble'.

Reviewed-by: Tudor Ambarus <tudor.ambarus@linaro.org>
Tested-by: Marek Vasut <marek.vasut+renesas@mailbox.org> # S25FS512S
Signed-off-by: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
Signed-off-by: Pratyush Yadav <pratyush@kernel.org>
Stable-dep-of: 3620d67b4849 ("mtd: spi-nor: update spi_nor_fixups::post_sfdp() documentation")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mtd/spi-nor/core.h |  3 +++
 drivers/mtd/spi-nor/sfdp.c | 18 ++++++++++++++++--
 2 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/spi-nor/core.h b/drivers/mtd/spi-nor/core.h
index ceff412f7d65a..5ad46d95d09cc 100644
--- a/drivers/mtd/spi-nor/core.h
+++ b/drivers/mtd/spi-nor/core.h
@@ -409,6 +409,8 @@ struct spi_nor_flash_parameter {
  *                flash parameters when information provided by the flash_info
  *                table is incomplete or wrong.
  * @post_bfpt: called after the BFPT table has been parsed
+ * @smpt_read_dummy: called during SMPT table is being parsed. Used to fix the
+ *                   number of dummy cycles in read register ops.
  * @post_sfdp: called after SFDP has been parsed (is also called for SPI NORs
  *             that do not support RDSFDP). Typically used to tweak various
  *             parameters that could not be extracted by other means (i.e.
@@ -426,6 +428,7 @@ struct spi_nor_fixups {
 	int (*post_bfpt)(struct spi_nor *nor,
 			 const struct sfdp_parameter_header *bfpt_header,
 			 const struct sfdp_bfpt *bfpt);
+	void (*smpt_read_dummy)(const struct spi_nor *nor, u8 *read_dummy);
 	int (*post_sfdp)(struct spi_nor *nor);
 	int (*late_init)(struct spi_nor *nor);
 };
diff --git a/drivers/mtd/spi-nor/sfdp.c b/drivers/mtd/spi-nor/sfdp.c
index 21727f9a4ac69..9a47dcaca06ae 100644
--- a/drivers/mtd/spi-nor/sfdp.c
+++ b/drivers/mtd/spi-nor/sfdp.c
@@ -699,6 +699,17 @@ static u8 spi_nor_smpt_addr_nbytes(const struct spi_nor *nor, const u32 settings
 	}
 }
 
+static void spi_nor_smpt_read_dummy_fixups(const struct spi_nor *nor,
+					   u8 *read_dummy)
+{
+	if (nor->manufacturer && nor->manufacturer->fixups &&
+	    nor->manufacturer->fixups->smpt_read_dummy)
+		nor->manufacturer->fixups->smpt_read_dummy(nor, read_dummy);
+
+	if (nor->info->fixups && nor->info->fixups->smpt_read_dummy)
+		nor->info->fixups->smpt_read_dummy(nor, read_dummy);
+}
+
 /**
  * spi_nor_smpt_read_dummy() - return the configuration detection command read
  *			       latency, in clock cycles.
@@ -711,8 +722,11 @@ static u8 spi_nor_smpt_read_dummy(const struct spi_nor *nor, const u32 settings)
 {
 	u8 read_dummy = SMPT_CMD_READ_DUMMY(settings);
 
-	if (read_dummy == SMPT_CMD_READ_DUMMY_IS_VARIABLE)
-		return nor->read_dummy;
+	if (read_dummy == SMPT_CMD_READ_DUMMY_IS_VARIABLE) {
+		read_dummy = nor->read_dummy;
+		spi_nor_smpt_read_dummy_fixups(nor, &read_dummy);
+	}
+
 	return read_dummy;
 }
 
-- 
2.53.0




