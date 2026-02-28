Return-Path: <stable+bounces-220558-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cMNYMqBOo2nw/QQAu9opvQ
	(envelope-from <stable+bounces-220558-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 21:22:56 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3247D1C84A7
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 21:22:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D06A1320CB56
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:47:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3ED03D836F;
	Sat, 28 Feb 2026 17:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FgFMTK0N"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86BEC3D8366;
	Sat, 28 Feb 2026 17:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300439; cv=none; b=D2nnBjWbU8L1qHeXD8TI+dAoX5JBz6XqUxii8NPVHrE5GdvUrpqE+OZax1sdK8OJsfrfQGwaOhJBnBfYxYp0I4eFU1XPPVDOuWwDqqt0TZh2UksLLf1ZOoZntDdoR82D0fB6TzQa3sOW6V/3i9vDWgNaVuqi5dgjyRjf4F3vXJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300439; c=relaxed/simple;
	bh=uOU7PEpDm7z0hH/MQwjULsqqsKpWCC8N/AVwo0iYu4c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NZis32+0whALtuElQxn8WBy+FIeFFCuScIsq0hAwi6Dqnv/n8nsSiLjyoLRIUJV0SzDTckJvRHQcGLy9XU2y0vNr7C8NrQJUdNBbGKCK1wvUfJ2MdqKoyJqTGkYQf1TxkmXn2TswRAQe/rqD0e5hOTb8IglXp8R/5pblLPsz+ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FgFMTK0N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC4CCC2BC87;
	Sat, 28 Feb 2026 17:40:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300439;
	bh=uOU7PEpDm7z0hH/MQwjULsqqsKpWCC8N/AVwo0iYu4c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FgFMTK0NUfypXVWU/6LHU9+IsDtUJx4MMzCLwANAmRhH48+E6Z7Vo/Q0nOHq5Ol+1
	 gG1Q+0A25dySavd+l1jjYXT9UMCWhUiD+KziP7dsB81xJgTqezf6SIrywBgaFKBAiz
	 Ls8ObNvKHWZ/DTqOCIRwPGAT1/jO1kN0fmbKE+MvgQVd02kvTzxPaIziXPFybKV/EQ
	 6HamNuta4vuK5itOGXgU8IMGySV/IM2cyBWQ+cdT6jh9ib9LS/tuFnFesWEhVYpE/J
	 BV+5db2Qt4OKcQ27w0dUKbHxeeccyoNf53YKstz0r+Ti3hk2/Qf4iEplyfD46C010n
	 lKkZfSvViPY7g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ivan Vecera <ivecera@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 479/844] dpll: zl3073x: fix REF_PHASE_OFFSET_COMP register width for some chip IDs
Date: Sat, 28 Feb 2026 12:26:32 -0500
Message-ID: <20260228173244.1509663-480-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220558-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3247D1C84A7
X-Rspamd-Action: no action

From: Ivan Vecera <ivecera@redhat.com>

[ Upstream commit 4cfe066a82cdf9e83e48b16000f55280efc98325 ]

The REF_PHASE_OFFSET_COMP register is 48-bit wide on most zl3073x chip
variants, but only 32-bit wide on chip IDs 0x0E30, 0x0E93..0x0E97 and
0x1F60. The driver unconditionally uses 48-bit read/write operations,
which on 32-bit variants causes reading 2 bytes past the register
boundary (corrupting the value) and writing 2 bytes into the adjacent
register.

Fix this by storing the chip ID in the device structure during probe
and adding a helper to detect the affected variants. Use the correct
register width for read/write operations and the matching sign extension
bit (31 vs 47) when interpreting the phase compensation value.

Fixes: 6287262f761e ("dpll: zl3073x: Add support to adjust phase")
Signed-off-by: Ivan Vecera <ivecera@redhat.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://patch.msgid.link/20260220155755.448185-1-ivecera@redhat.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/dpll/zl3073x/core.c |  1 +
 drivers/dpll/zl3073x/core.h | 28 ++++++++++++++++++++++++++++
 drivers/dpll/zl3073x/dpll.c |  7 +++++--
 drivers/dpll/zl3073x/ref.c  | 25 ++++++++++++++++++++-----
 drivers/dpll/zl3073x/regs.h |  1 +
 5 files changed, 55 insertions(+), 7 deletions(-)

diff --git a/drivers/dpll/zl3073x/core.c b/drivers/dpll/zl3073x/core.c
index 383e2397dd033..b20d4f24c0e94 100644
--- a/drivers/dpll/zl3073x/core.c
+++ b/drivers/dpll/zl3073x/core.c
@@ -1023,6 +1023,7 @@ int zl3073x_dev_probe(struct zl3073x_dev *zldev,
 				     "Unknown or non-match chip ID: 0x%0x\n",
 				     id);
 	}
+	zldev->chip_id = id;
 
 	/* Read revision, firmware version and custom config version */
 	rc = zl3073x_read_u16(zldev, ZL_REG_REVISION, &revision);
diff --git a/drivers/dpll/zl3073x/core.h b/drivers/dpll/zl3073x/core.h
index 09bca2d0926d5..f6a792557ccd6 100644
--- a/drivers/dpll/zl3073x/core.h
+++ b/drivers/dpll/zl3073x/core.h
@@ -35,6 +35,7 @@ struct zl3073x_dpll;
  * @dev: pointer to device
  * @regmap: regmap to access device registers
  * @multiop_lock: to serialize multiple register operations
+ * @chip_id: chip ID read from hardware
  * @ref: array of input references' invariants
  * @out: array of outs' invariants
  * @synth: array of synths' invariants
@@ -48,6 +49,7 @@ struct zl3073x_dev {
 	struct device		*dev;
 	struct regmap		*regmap;
 	struct mutex		multiop_lock;
+	u16			chip_id;
 
 	/* Invariants */
 	struct zl3073x_ref	ref[ZL3073X_NUM_REFS];
@@ -144,6 +146,32 @@ int zl3073x_write_hwreg_seq(struct zl3073x_dev *zldev,
 
 int zl3073x_ref_phase_offsets_update(struct zl3073x_dev *zldev, int channel);
 
+/**
+ * zl3073x_dev_is_ref_phase_comp_32bit - check ref phase comp register size
+ * @zldev: pointer to zl3073x device
+ *
+ * Some chip IDs have a 32-bit wide ref_phase_offset_comp register instead
+ * of the default 48-bit.
+ *
+ * Return: true if the register is 32-bit, false if 48-bit
+ */
+static inline bool
+zl3073x_dev_is_ref_phase_comp_32bit(struct zl3073x_dev *zldev)
+{
+	switch (zldev->chip_id) {
+	case 0x0E30:
+	case 0x0E93:
+	case 0x0E94:
+	case 0x0E95:
+	case 0x0E96:
+	case 0x0E97:
+	case 0x1F60:
+		return true;
+	default:
+		return false;
+	}
+}
+
 static inline bool
 zl3073x_is_n_pin(u8 id)
 {
diff --git a/drivers/dpll/zl3073x/dpll.c b/drivers/dpll/zl3073x/dpll.c
index a8001c9760382..d7194418d1568 100644
--- a/drivers/dpll/zl3073x/dpll.c
+++ b/drivers/dpll/zl3073x/dpll.c
@@ -459,8 +459,11 @@ zl3073x_dpll_input_pin_phase_adjust_get(const struct dpll_pin *dpll_pin,
 	ref_id = zl3073x_input_pin_ref_get(pin->id);
 	ref = zl3073x_ref_state_get(zldev, ref_id);
 
-	/* Perform sign extension for 48bit signed value */
-	phase_comp = sign_extend64(ref->phase_comp, 47);
+	/* Perform sign extension based on register width */
+	if (zl3073x_dev_is_ref_phase_comp_32bit(zldev))
+		phase_comp = sign_extend64(ref->phase_comp, 31);
+	else
+		phase_comp = sign_extend64(ref->phase_comp, 47);
 
 	/* Reverse two's complement negation applied during set and convert
 	 * to 32bit signed int
diff --git a/drivers/dpll/zl3073x/ref.c b/drivers/dpll/zl3073x/ref.c
index aa2de13effa87..6b65e61039999 100644
--- a/drivers/dpll/zl3073x/ref.c
+++ b/drivers/dpll/zl3073x/ref.c
@@ -121,8 +121,16 @@ int zl3073x_ref_state_fetch(struct zl3073x_dev *zldev, u8 index)
 		return rc;
 
 	/* Read phase compensation register */
-	rc = zl3073x_read_u48(zldev, ZL_REG_REF_PHASE_OFFSET_COMP,
-			      &ref->phase_comp);
+	if (zl3073x_dev_is_ref_phase_comp_32bit(zldev)) {
+		u32 val;
+
+		rc = zl3073x_read_u32(zldev, ZL_REG_REF_PHASE_OFFSET_COMP_32,
+				      &val);
+		ref->phase_comp = val;
+	} else {
+		rc = zl3073x_read_u48(zldev, ZL_REG_REF_PHASE_OFFSET_COMP,
+				      &ref->phase_comp);
+	}
 	if (rc)
 		return rc;
 
@@ -179,9 +187,16 @@ int zl3073x_ref_state_set(struct zl3073x_dev *zldev, u8 index,
 	if (!rc && dref->sync_ctrl != ref->sync_ctrl)
 		rc = zl3073x_write_u8(zldev, ZL_REG_REF_SYNC_CTRL,
 				      ref->sync_ctrl);
-	if (!rc && dref->phase_comp != ref->phase_comp)
-		rc = zl3073x_write_u48(zldev, ZL_REG_REF_PHASE_OFFSET_COMP,
-				       ref->phase_comp);
+	if (!rc && dref->phase_comp != ref->phase_comp) {
+		if (zl3073x_dev_is_ref_phase_comp_32bit(zldev))
+			rc = zl3073x_write_u32(zldev,
+					       ZL_REG_REF_PHASE_OFFSET_COMP_32,
+					       ref->phase_comp);
+		else
+			rc = zl3073x_write_u48(zldev,
+					       ZL_REG_REF_PHASE_OFFSET_COMP,
+					       ref->phase_comp);
+	}
 	if (rc)
 		return rc;
 
diff --git a/drivers/dpll/zl3073x/regs.h b/drivers/dpll/zl3073x/regs.h
index d837bee72b178..5573d7188406b 100644
--- a/drivers/dpll/zl3073x/regs.h
+++ b/drivers/dpll/zl3073x/regs.h
@@ -194,6 +194,7 @@
 #define ZL_REF_CONFIG_DIFF_EN			BIT(2)
 
 #define ZL_REG_REF_PHASE_OFFSET_COMP		ZL_REG(10, 0x28, 6)
+#define ZL_REG_REF_PHASE_OFFSET_COMP_32	ZL_REG(10, 0x28, 4)
 
 #define ZL_REG_REF_SYNC_CTRL			ZL_REG(10, 0x2e, 1)
 #define ZL_REF_SYNC_CTRL_MODE			GENMASK(2, 0)
-- 
2.51.0


