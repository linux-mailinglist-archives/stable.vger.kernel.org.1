Return-Path: <stable+bounces-127722-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A38CEA7A9D6
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 21:03:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36C381898999
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 19:03:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9833254AE5;
	Thu,  3 Apr 2025 19:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KE8G4Dot"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BDB8253356;
	Thu,  3 Apr 2025 19:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743706948; cv=none; b=Ee+4U5vivkNHkAm0buhw40ztVS7ZqcIHNsj1p50ytWjBN8bokJWKM9Dgc6qFFvP+S63MoZ8JbaZSuvmEoIJ6R0KKsaxCTNtAWzQa80yxyI6ijr8RiRfBOl+XYr3lEGsEP5hTJahfpDrBl3XYTFuYk2RdjCKNVwGv0Fo9L/vKGqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743706948; c=relaxed/simple;
	bh=RCKS208+S9uxKFrgFhNxe1Xye6b7JnXWUELLEdZiEiI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nXyEjLpXm/B3fG85/8OIa2SGeRxGo1X73jwmV35srz7NAs6zpWaoCdukQ0RwrFgytiH+UFdx9gz4jqbkBSe3U3jVvp53Fh0Sjl8jDfr/6nKS3OUjRL/ID5lLF1VSjYHBnFg1MaTM1f8cpQoeYtvOQy6Ja7YUuSjrhVPOErBRTDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KE8G4Dot; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74236C4CEE3;
	Thu,  3 Apr 2025 19:02:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743706948;
	bh=RCKS208+S9uxKFrgFhNxe1Xye6b7JnXWUELLEdZiEiI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KE8G4DotWTbQm37cM0a/cwD4kiNU1KeSA74QhbvgJcFDySF5/Q7JBjZ7SLImpgREn
	 q+ZKlBSEAFkjK5sA1QyQhLxzmYtnQ15PgADPNIk+9a0lwA5l/hH7+KOLM75nZEHFNb
	 Y2YIAxx6Z4IxrGNV6mbkcbvpurR8WiluZY9CpqeJAd5QBe64p6dKvRVRM3dmCG3/Wj
	 wgHmsh/K4mKW9nqQjC+AzHC764joTiuTAVzyJ/E12R6MxPpXXd7TyyA8Z1fVtUjy28
	 iXJqoNlIF0GjmT1WDH4B7fg5NOgYvKu+K3OQVHxVKS8zi/0ezDewsrxwMgcfCM4doZ
	 3FxQyyLrJPfcw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Niklas Cassel <cassel@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	corbet@lwn.net,
	akpm@linux-foundation.org,
	paulmck@kernel.org,
	thuth@redhat.com,
	rostedt@goodmis.org,
	bp@alien8.de,
	ardb@kernel.org,
	gregkh@linuxfoundation.org,
	jpoimboe@kernel.org,
	linux-doc@vger.kernel.org,
	linux-ide@vger.kernel.org
Subject: [PATCH AUTOSEL 6.14 07/54] ata: libata-core: Add 'external' to the libata.force kernel parameter
Date: Thu,  3 Apr 2025 15:01:22 -0400
Message-Id: <20250403190209.2675485-7-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250403190209.2675485-1-sashal@kernel.org>
References: <20250403190209.2675485-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14
Content-Transfer-Encoding: 8bit

From: Niklas Cassel <cassel@kernel.org>

[ Upstream commit deca423213cb33feda15e261e7b5b992077a6a08 ]

Commit ae1f3db006b7 ("ata: ahci: do not enable LPM on external ports")
changed so that LPM is not enabled on external ports (hotplug-capable or
eSATA ports).

This is because hotplug and LPM are mutually exclusive, see 7.3.1 Hot Plug
Removal Detection and Power Management Interaction in AHCI 1.3.1.

This does require that firmware has set the appropate bits (HPCP or ESP)
in PxCMD (which is a per port register in the AHCI controller).

If the firmware has failed to mark a port as hotplug-capable or eSATA in
PxCMD, then there is currently not much a user can do.

If LPM is enabled on the port, hotplug insertions and removals will not be
detected on that port.

In order to allow a user to fix up broken firmware, add 'external' to the
libata.force kernel parameter.

libata.force can be specified either on the kernel command line, or as a
kernel module parameter.

For more information, see Documentation/admin-guide/kernel-parameters.txt.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Link: https://lore.kernel.org/r/20250130133544.219297-4-cassel@kernel.org
Signed-off-by: Niklas Cassel <cassel@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../admin-guide/kernel-parameters.txt         |  2 +
 drivers/ata/libata-core.c                     | 38 +++++++++++++++++++
 2 files changed, 40 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index fb8752b42ec85..aa7447f8837cb 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3116,6 +3116,8 @@
 			* max_sec_lba48: Set or clear transfer size limit to
 			  65535 sectors.
 
+			* external: Mark port as external (hotplug-capable).
+
 			* [no]lpm: Enable or disable link power management.
 
 			* [no]setxfer: Indicate if transfer speed mode setting
diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index d956735e2a764..0cb97181d10a9 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -88,6 +88,7 @@ struct ata_force_param {
 	unsigned int	xfer_mask;
 	unsigned int	quirk_on;
 	unsigned int	quirk_off;
+	unsigned int	pflags_on;
 	u16		lflags_on;
 	u16		lflags_off;
 };
@@ -331,6 +332,35 @@ void ata_force_cbl(struct ata_port *ap)
 	}
 }
 
+/**
+ *	ata_force_pflags - force port flags according to libata.force
+ *	@ap: ATA port of interest
+ *
+ *	Force port flags according to libata.force and whine about it.
+ *
+ *	LOCKING:
+ *	EH context.
+ */
+static void ata_force_pflags(struct ata_port *ap)
+{
+	int i;
+
+	for (i = ata_force_tbl_size - 1; i >= 0; i--) {
+		const struct ata_force_ent *fe = &ata_force_tbl[i];
+
+		if (fe->port != -1 && fe->port != ap->print_id)
+			continue;
+
+		/* let pflags stack */
+		if (fe->param.pflags_on) {
+			ap->pflags |= fe->param.pflags_on;
+			ata_port_notice(ap,
+					"FORCE: port flag 0x%x forced -> 0x%x\n",
+					fe->param.pflags_on, ap->pflags);
+		}
+	}
+}
+
 /**
  *	ata_force_link_limits - force link limits according to libata.force
  *	@link: ATA link of interest
@@ -486,6 +516,7 @@ static void ata_force_quirks(struct ata_device *dev)
 	}
 }
 #else
+static inline void ata_force_pflags(struct ata_port *ap) { }
 static inline void ata_force_link_limits(struct ata_link *link) { }
 static inline void ata_force_xfermask(struct ata_device *dev) { }
 static inline void ata_force_quirks(struct ata_device *dev) { }
@@ -5460,6 +5491,8 @@ struct ata_port *ata_port_alloc(struct ata_host *host)
 #endif
 	ata_sff_port_init(ap);
 
+	ata_force_pflags(ap);
+
 	return ap;
 }
 EXPORT_SYMBOL_GPL(ata_port_alloc);
@@ -6272,6 +6305,9 @@ EXPORT_SYMBOL_GPL(ata_platform_remove_one);
 	{ "no" #name,	.lflags_on	= (flags) },	\
 	{ #name,	.lflags_off	= (flags) }
 
+#define force_pflag_on(name, flags)			\
+	{ #name,	.pflags_on	= (flags) }
+
 #define force_quirk_on(name, flag)			\
 	{ #name,	.quirk_on	= (flag) }
 
@@ -6331,6 +6367,8 @@ static const struct ata_force_param force_tbl[] __initconst = {
 	force_lflag_on(rstonce,		ATA_LFLAG_RST_ONCE),
 	force_lflag_onoff(dbdelay,	ATA_LFLAG_NO_DEBOUNCE_DELAY),
 
+	force_pflag_on(external,	ATA_PFLAG_EXTERNAL),
+
 	force_quirk_onoff(ncq,		ATA_QUIRK_NONCQ),
 	force_quirk_onoff(ncqtrim,	ATA_QUIRK_NO_NCQ_TRIM),
 	force_quirk_onoff(ncqati,	ATA_QUIRK_NO_NCQ_ON_ATI),
-- 
2.39.5


