Return-Path: <stable+bounces-216351-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sNauJPfJj2nMTgEAu9opvQ
	(envelope-from <stable+bounces-216351-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 14 Feb 2026 02:03:51 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5753713A4BE
	for <lists+stable@lfdr.de>; Sat, 14 Feb 2026 02:03:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 51DAA30178B5
	for <lists+stable@lfdr.de>; Sat, 14 Feb 2026 01:03:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 344C721ADC7;
	Sat, 14 Feb 2026 01:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sFKYLODG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB4AF2147E5;
	Sat, 14 Feb 2026 01:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771031002; cv=none; b=mPSnJON2mjNwImhDFcWuYkJNX77djsyaplGrriONPH5e0Mt086ipF9FvUZrl0/R0nxbP6HplYgFhp0WH9YjDqyydg6wNV03wN6+FgGCfs1OWEnAeighkNI51eOawsTkAOOrGW50LyijQ6GBumRzrh85JMpH5h0DoIfgXVepDJzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771031002; c=relaxed/simple;
	bh=WfSGLbx2Gb4pPiNqLpvLMFeRhj+5Ut+9o4V69WRrGmw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h/LhEonE+uFIS30X0cMELH8V94QlgH06e1gWnRU5RQjr2D3Q47Btj+0lWpRZMmGaSe9TxqxI9dE+GyfPW8sLbgidCjZ7DsCRSPp4HxBdYORxMxN4fnE67N1c6KbUVcOQh8WJewyVokCxGu2aaZuqGaS+J35G0MH/tuzlRI6qIgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sFKYLODG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA4C2C16AAE;
	Sat, 14 Feb 2026 01:03:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771031001;
	bh=WfSGLbx2Gb4pPiNqLpvLMFeRhj+5Ut+9o4V69WRrGmw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sFKYLODGiUmJfhv4umzLlTZApLjmOLcqoxKOB7EHyw6KgBD9rlHL8ykteHpKmprDj
	 kpn5WSqZ3MLYNCFtC3oKZj6nIHQA3QEp0ekwVWjoEcsFSIsYytKplvCegxeQzf7/gd
	 s/2M9/Kr1tW6pC2xBjVwCCC+UmP1LUGfdL3cTmZzVJ6RcRTm9Q1D8O/3p+71KQ3DGK
	 I5r4Gc5JL4pWj8Zdh39rr322WmH9FxxkoDcCUQLbUgegRmayPcBqYcIiBRTCHaYhP7
	 IkYBmfWJEAzg6lJHfINPTg5/JJ4AxkphoucnJYhToip1kQqL/X1cgZFSDwr27zbwfQ
	 qvUp1YVjfs3pQ==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Miquel Raynal <miquel.raynal@bootlin.com>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-spi@vger.kernel.org
Subject: [PATCH AUTOSEL 6.19-6.6] spi: spi-mem: Limit octal DTR constraints to octal DTR situations
Date: Fri, 13 Feb 2026 19:58:20 -0500
Message-ID: <20260214010245.3671907-20-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260214010245.3671907-1-sashal@kernel.org>
References: <20260214010245.3671907-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.19
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-216351-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,bootlin.com:email,linaro.org:email]
X-Rspamd-Queue-Id: 5753713A4BE
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

LLM Generated explanations, may be completely bogus:

The core of the fix — moving the `op->cmd.nbytes != 2` check inside a
tighter condition — is self-contained. It doesn't depend on the `swap16`
feature (that's a separate, pre-existing check). The new even-byte
checks for addr/dummy/data in 8D-8D-8D mode are a tightening of
validation that could also be backported.

However, the presence of the `swap16` check in the surrounding context
means the patch won't apply cleanly to older stable trees that lack
commit `030ace430afcf` (from 6.12 cycle). The fix would need minor
adaptation for older stable trees, but the logic change itself is
independent.

### 7. Assessment Summary

**What the bug is:** `spi_mem_default_supports_op()` incorrectly rejects
valid non-8D-8D-8D DTR operations (like 1S-1S-8D) by requiring
`cmd.nbytes == 2` for ALL DTR operations, not just 8D-8D-8D ones.

**Impact:** Real functional bug — any SPI memory device using mixed DTR
modes (where only the data phase is DTR but not the command phase) would
have its operations rejected. This prevents legitimate device
operations.

**Scope of the fix:** The change is confined to a single function in one
file. It narrows a condition check and adds additional validation only
for the specific 8D-8D-8D case.

**Risk:** Low. The fix is logically correct — it restricts a previously
over-broad check. It can't introduce new failures for 8D-8D-8D mode
(those checks are preserved and even strengthened), and it unblocks
mixed-DTR modes that were incorrectly blocked.

**Who benefits:** Users with SPI memory devices that use non-8D-8D-8D
DTR modes (e.g., some flash chips using 1S-1S-8D for certain
operations).

**Concerns:**
- Part of a larger patch series (v2-3), but the fix to
  `spi_mem_default_supports_op()` is self-contained
- May need minor context adjustment for older stable trees (due to
  `swap16` context)
- The even-byte-count validation is technically a new constraint for
  8D-8D-8D mode, but it enforces existing hardware requirements that
  were previously unchecked

This is a clear correctness fix for a real bug that has existed since
kernel 5.18. It's small, contained, well-reviewed (Reviewed-by from
Tudor Ambarus, a key MTD maintainer), and fixes incorrect rejection of
valid SPI operations.

**YES**

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


