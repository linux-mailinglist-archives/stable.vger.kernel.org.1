Return-Path: <stable+bounces-221103-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +BuTHLxJo2nW/AQAu9opvQ
	(envelope-from <stable+bounces-221103-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 21:02:04 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D7E3E1C7C9E
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 21:02:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6618F305B343
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:47:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5193737144F;
	Sat, 28 Feb 2026 17:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="quq7o2lg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 149C8301F0B;
	Sat, 28 Feb 2026 17:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772301452; cv=none; b=KG2k97a8XL0bAOlOs73LtFnkvjvW6ailwggOHqAOVL1LtBC9uKZMYTNMLPhh22pXk+dCYbVmZTqSag0SNNmQgcwvxXoGIh2FN5B11r8ICqoTCBxVYMVQgrZOZJ+LZ97U8gA+XOL5LDabxX+aG8CUT7XdM3oxboAbH0FPaTI7/Tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772301452; c=relaxed/simple;
	bh=PKJ9Ov/jtohoKOMDjlpOu8tcHkHVq+BixZLd6OIar3A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=my6iaS1FdGz7eZfcFaqJ+/vOctjEiUnNfSu7GhAjWijlF7UlzYSMQsYU2pdVGikSc/rW+fr9oOtM1nZdCsLKJGje3XuXJH5FtypyvgeFcXr5JrTzrICc7o85xuXkIVfbm0+1beO/utC4Cs6TO6JF3bir1PmIRMOMb1yfC6NXato=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=quq7o2lg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34587C116D0;
	Sat, 28 Feb 2026 17:57:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772301452;
	bh=PKJ9Ov/jtohoKOMDjlpOu8tcHkHVq+BixZLd6OIar3A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=quq7o2lgCEzUPka+/peowfZBOC0KxJ8i6ojXprpJZ409cuGLloStagrL8KOoZKg+Z
	 tyr++57sNbhfUwpXbtmVrzoJK2uhljqYrumwF/7JJv1ulsRD+BWz78SuLkr9hBP51b
	 3V4uxM9jlKjKF4B3EZ90iZsFVUVrfDqdo6JgXHohznLov+omSGVYW4+ok58dZ2SxD5
	 pl5fnvfkhu7bpAOIuKOea01abAwjo8eTZO5HsHSwx8sTaQQuRWnFYpDxSx8cZIH15w
	 TAVH495XbWiVtVJv+SUjYq5sbz0Wt2ACl/dFX1hQA+ODHDVSP0LwAiiEAnJczg45Ke
	 BePnjW1YGv7IQ==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev
Cc: David LaPorte <dalaport@amazon.com>,
	stable@vger.kernel.org,
	Gunnar Kudrjavets <gunnarku@amazon.com>,
	Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 638/752] mtd: spinand: Disable continuous read during probe
Date: Sat, 28 Feb 2026 12:45:49 -0500
Message-ID: <20260228174750.1542406-638-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228174750.1542406-1-sashal@kernel.org>
References: <20260228174750.1542406-1-sashal@kernel.org>
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
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-221103-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,iopsys.eu:email,bootlin.com:email]
X-Rspamd-Queue-Id: D7E3E1C7C9E
X-Rspamd-Action: no action

From: David LaPorte <dalaport@amazon.com>

[ Upstream commit b4af7d194dc879353829f3c56988a68fbba1fbdd ]

Macronix serial NAND devices with continuous read support do not
clear the configuration register on soft reset and lack a hardware
reset pin. When continuous read is interrupted (e.g., during reboot),
the feature remains enabled at the device level.

With continuous read enabled, the OOB area becomes inaccessible and
all reads are instead directed to the main area. As a result, during
partition allocation as part of MTD device registration, the first two
bytes of the main area for the master block are read and indicate that
the block is bad. This process repeats for every subsequent block for
the partition.

All reads and writes that reference the BBT find no good blocks and
fail.

The only paths for recovery from this state are triggering the
continuous read feature by way of raw MTD reads or through a NAND
device power drain.

Disable continuous read explicitly during spinand probe to ensure
quiescent feature state.

Fixes: 631cfdd0520d ("mtd: spi-nand: Add continuous read support")
Cc: stable@vger.kernel.org
Signed-off-by: David LaPorte <dalaport@amazon.com>
Reviewed-by: Gunnar Kudrjavets <gunnarku@amazon.com>
Reviewed-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mtd/nand/spi/core.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index f92133b8e1a60..697877584a285 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -859,6 +859,14 @@ static void spinand_cont_read_init(struct spinand_device *spinand)
 	    (engine_type == NAND_ECC_ENGINE_TYPE_ON_DIE ||
 	     engine_type == NAND_ECC_ENGINE_TYPE_NONE)) {
 		spinand->cont_read_possible = true;
+
+		/*
+		 * Ensure continuous read is disabled on probe.
+		 * Some devices retain this state across soft reset,
+		 * which leaves the OOB area inaccessible and results
+		 * in false positive returns from spinand_isbad().
+		 */
+		spinand_cont_read_enable(spinand, false);
 	}
 }
 
-- 
2.51.0


